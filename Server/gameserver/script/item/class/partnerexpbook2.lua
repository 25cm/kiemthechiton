------------------------------------------------------
-- 文件名　：partnerexpbook.lua
-- 创建者　：zhaoyu
-- 创建时间：2009-12-15 17:02:08
-- 描  述  ：同伴经验书
------------------------------------------------------
local tbItem = Item:GetClass("partnerexpbook2");

-- 获得的经验比率
tbItem.tbRate =
{-- 已吃道具个数，  对应比例
	{10, 3*0.5},
	{400, 0.5},
}

-- 记录玩家吃了多少本经验书的任务变量索引
tbItem.nTask	 = 2112;
tbItem.nSubTask  = 1;
tbItem.nDateTask  = 2;
tbItem.nLastTime = 7 * 24 * 3600;	-- 同伴经验书最多可以持续一周

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Tính năng đồng hành chưa mở, vui lòng thử lại sau.");
		return 0;
	end
	
	if me.nPartnerCount == 0 then
		Dialog:Say("Bạn chưa có đồng hành. Hãy đi thu phục để có đồng hành.");
		return 0;
	end
	local nCurDate = tonumber(os.date("%Y%m%d", GetTime()))
	local nDate = me.GetTask(self.nTask, self.nDateTask);	   -- 日期
	if nCurDate ~= nDate then
		me.SetTask(self.nTask, self.nSubTask, 0)
		me.SetTask(self.nTask, self.nDateTask, nCurDate);
	end
	
	local nTimes = me.GetTask(self.nTask, self.nSubTask);	   -- 已经吃过的个数 
	if nTimes >= 400 then
		me.Msg("Ngày hôm nay ngươi đã sử dụng trên 400 cuốn!");
		return;
	end
	
	local tbOpt = {};
	for i = 0, me.nPartnerCount - 1 do
		local pPartner = me.GetPartner(i);
		if pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) < Partner.MAXLEVEL and
			pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_EXP) < Partner:GetMaxStoreExp(pPartner) then
				
			local szMsg = pPartner.szName;
			local nExp = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_EXP);
			local nExpAfterBook = self:GetExpFromBook(pPartner);
			
			szMsg = szMsg..string.format("（%d → <color=yellow>%d<color>）", nExp, nExpAfterBook);
			table.insert(tbOpt, {szMsg, self.OnSelectPartner, self, it.dwId, i});
		end
	end
	if #tbOpt == 0 then
		Dialog:Say("Bạn chưa có đồng hành. Hãy đi thu phục để có đồng hành");
		return;
	end
	
	table.insert(tbOpt, {"Ta chưa cần lắm"});
	Dialog:Say("Hãy chọn đồng hành để tăng kinh nghiệm<color=yellow>Mỗi lần sử dụng chỉ có thể tích lũy tối đa 10 cấp<color>.", tbOpt);		
end

-- 返回吃经验书后得得到的经验。
function tbItem:GetExpFromBook(pPartner)
	local nRate = 0;
	for _, tbData in pairs(self.tbRate) do
		if me.GetTask(self.nTask, self.nSubTask) < tbData[1] then
			nRate = tbData[2];
			break;
		end
	end
	
	local nLevel = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL);
	local nBookExp = nRate * self:GetBaseExp(nLevel);	-- 经验书提供的经验
	
	local nMaxStoreExp = Partner:GetMaxStoreExp(pPartner);
	local nCurExp = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_EXP);
	
	return (nCurExp + nBookExp) > nMaxStoreExp and nMaxStoreExp or (nCurExp + nBookExp);
end

function tbItem:OnSelectPartner(nItemId, nPartnerIndex)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end
	local pOwner = pItem.GetOwner();  -- pItem.GetOwner() 可能为nil; zounan
	if not pOwner or pOwner.nId ~= me.nId then 
		return;
	end
	
	local pPartner = me.GetPartner(nPartnerIndex);
	if not pPartner then
		return;
	end
	
	local nBookExp = self:GetExpFromBook(pPartner);
	local nRet, varMsg = Partner:AddExp(pPartner, nBookExp - pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_EXP));
	if nRet ~= 1 then
		me.Msg(varMsg);
		return;
	end
	
	local nAddedExp = varMsg;	-- 返回的是实际增加的经验
	local nTimes = me.GetTask(self.nTask, self.nSubTask);
	local szMsg = string.format("Đồng hành %s của bạn tăng %d điểm kinh nghiệm. Ngày hôm nay bạn đã sử dụng <color=yellow>%d<color> sách kinh nghiệm đồng hành. Mỗi ngày bạn có thể sử dụng <color=yellow>400<color> cuốn，tích lũy tối đa <color=yellow>10<color> cấp.",
		pPartner.szName, nAddedExp,  nTimes + 1);	
	me.Msg(szMsg);
	
	-- 设置任务变量记录吃了多少本经验书
	me.SetTask(self.nTask, self.nSubTask, nTimes + 1);
	Dbg:WriteLog("Log đồng hành:", me.szName, "Sử dụng", pItem.szName, "Kinh nghiệm tăng：", nAddedExp);

	-- 扣除物品
	me.DelItem(pItem);
end

-- 获取经验书的基准经验
function tbItem:GetBaseExp(nPartnerLevel)
	local nKey = math.floor(nPartnerLevel / 10) * 10 + 9;
	local nExp = 0;
	if not Partner.tbPartnerExpBook[nKey] then
		Dbg:WriteLog("Sách kinh nghiệm đồng hành", string.format("角色[%s]传入了同伴等级[%d]，不合法！", me.szName, nPartnerLevel));
		nKey = 9;
	end
	
	return Partner.tbPartnerExpBook[nKey];		
end

function tbItem:InitGenInfo()
	-- 设定同伴经验书的有效期限, 绝对时间
	it.SetTimeOut(0, GetTime() + self.nLastTime);
	return	{ };
end