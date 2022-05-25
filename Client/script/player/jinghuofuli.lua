-- 文件名　：jinghuofuli.lua
-- 创建者　：bigfly
-- 创建时间：2009-7-7 17:59:54
-- 文件说明：精活福利脚本

Require("\\script\\player\\player.lua");

local tbBuyJingHuo		= Player.tbBuyJingHuo or {};	-- 支持重载
Player.tbBuyJingHuo		= tbBuyJingHuo;

tbBuyJingHuo.MAX_JINGHUOCOUNT	= 10000;	-- 最多累积10000组
tbBuyJingHuo.DAY_GIVECOUNT		= 1;		-- 每天给1组

tbBuyJingHuo.tbItem = 
{
	[1] = {nWareId=47, TASK_GROUPID=2024, TASK_ID1=9, TASK_ID2=10, nUseMax=5, nCoin = 16, szTypeName = "Tinh Khí Tán (tiểu)", szDesValue="2500 Tinh Lực", szDes="Tinh Lực Tán giảm 60% (tiểu) (5)", }; --小精气散
	[2] = {nWareId=48, TASK_GROUPID=2024, TASK_ID1=11, TASK_ID2=12, nUseMax=5, nCoin = 16, szTypeName = "Hoạt Khí Tán (tiểu)", szDesValue="2500 Hoạt Lực", szDes="Hoạt Lực Tán giảm 60% (tiểu) (5)", }; --小活气散
}
tbBuyJingHuo.nLevelMax = 60;

function tbBuyJingHuo:BuyItem(nType, nFlag)
	local nPrestige = self:GetTodayPrestige();
	if nPrestige <= 0 then
		Dialog:Say("Vẫn chưa sắp xếp uy danh toàn khu, nên chưa có ưu đãi, đợi sau khi xếp hạng rồi hãy quay lại");
		return 0;
	end
	
	if (me.IsInPrison() == 1) then
		Dialog:Say("Trong Thiên Lao không thể nhận phúc lợi.");
		return 0;
	end		

	local nNum = 5; --购买5个
	if me.nLevel < self.nLevelMax then
		Dialog:Say("Đạt cấp 60 mới được nhận phúc lợi.");
		return 0;
	end
	local tbItem = self.tbItem[nType];	
	self:UpdateFuliCount(me, nType);
	local nCount = me.GetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID2);
	if nCount >= tbItem.nUseMax then
		Dialog:Say(string.format("Mỗi ngày mỗi người chơi chỉ được ưu đãi mua <color=yellow>%s个<color>%s。",tbItem.nUseMax, tbItem.szTypeName));
		return 0;
	end
	--排名判断
	if me.nPrestige < nPrestige then
		Dialog:Say("Uy danh giang hồ không đủ <color=red>"..nPrestige.."điểm<color>, không thể mua"..tbItem.szTypeName);
		return 0;
	end
	if not nFlag then 
		Dialog:Say(string.format("Xác định mua<color=yellow>%s<color>？", tbItem.szTypeName),{{"Ta xác định mua", self.BuyItem, self, nType, 1},{"我再考虑考虑"}});
		return 0;
	end
	
	if nCount + nNum > tbItem.nUseMax then
		Dialog:Say(string.format("Mỗi ngày mỗi người chơi chỉ được mua ưu đãi <color=yellow>%s<color> %s, đã mua %s, chỉ được mua thêm %s %s",tbItem.nUseMax, tbItem.szTypeName, nCount, tbItem.nUseMax-nCount, tbItem.szTypeName));
		return 0;
	end	
	
	if IVER_g_nSdoVersion == 0 and me.GetJbCoin() < (tbItem.nCoin * nNum) then
		Dialog:Say(string.format("Không đủ đồng, mua %s %s cần %s đồng.", nNum, tbItem.szTypeName, tbItem.nCoin*nNum));
		return 0;
	end
	if me.CountFreeBagCell() < nNum then
		Dialog:Say(string.format("Túi không đủ chỗ, cần để trống %s ô.", nNum));
		return 0;	
	end
	me.ApplyAutoBuyAndUse(tbItem.nWareId, 1);
	if IVER_g_nSdoVersion == 0 then
		Dialog:Say(string.format("Ngươi đã mua thành công %s %s",nNum, tbItem.szTypeName));
	end
	local szLog = string.format("Đã mua thành công %s %s",nNum, tbItem.szTypeName);

	--统计玩家购买福利精活的次数（同一天购买精力和活力只计数1）
	Stats.Activity:AddCount(me, Stats.TASK_COUNT_FULIJINGHUO, 1, 1);

	-- 更新获取福利精活的时间
	Stats:UpdateGetFuliTime();
	Dbg:WriteLog("Player.tbBuyJingHuo", "Ưu đãi mua Tinh Hoạt", me.szAccount, me.szName, szLog);
	return 1;
end

function tbBuyJingHuo:GetTodayPrestige()
	local nPrestige = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_PRESIGE_RESULT);
	return nPrestige;
end

function tbBuyJingHuo:OnLogin(bExchangeServer)
	if (bExchangeServer == 1) then
		return;
	end
	self:OpenBuJingHuo(me);
end

function tbBuyJingHuo:OpenBuJingHuo(pPlayer)
	local nPrestige = self:GetTodayPrestige()
	if (nPrestige <= 0) then
		return 0, "Vẫn chưa sắp xếp uy danh toàn khu, nên chưa có ưu đãi, đợi sau khi xếp hạng rồi hãy quay lại";
	end
	
	if (pPlayer.nPrestige < nPrestige) then
		return 0, "Uy danh giang hồ không đủ <color=red>"..nPrestige.." điểm<color>, không được lãnh phúc lợi";
	end
	
	if (pPlayer.nLevel < self.nLevelMax) then
		return 0, "Đạt cấp 60 mới được nhận phúc lợi.";
	end

	local nFlag = 0;
	for i, tbItem in pairs(self.tbItem) do
		self:UpdateFuliCount(pPlayer, i);
		local nCount = pPlayer.GetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID2);
		if (nCount <= 0) then
			nFlag = 1;
		end
	end
	
	if nFlag <= 0 then
		return 0, "Hôm nay ngươi đã nhận phúc lợi rồi!";
	end
	
	pPlayer.CallClientScript({"UiManager:OpenWindow", "UI_JINGHUOFULI"});
	return 1;
end

function tbBuyJingHuo:UpdateFuliCount(pPlayer, nType)
	local tbItem = self.tbItem[nType];
	local nDay = pPlayer.GetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID1);
	local nNowDay =tonumber(GetLocalDate("%Y%m%d"));
	if nNowDay > nDay then
		pPlayer.SetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID1, nNowDay);
		pPlayer.SetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID2, 0);
	end	
end

function tbBuyJingHuo:GetPillInfo()
	local tbPillInfo	= {};
	for nType, tbItem in ipairs(self.tbItem) do
		tbPillInfo[nType]	= {
			tbItem.szDes,
			tbItem.nCoin * tbItem.nUseMax,
			tbItem.szDesValue,
			1,
		};
	end	
	return tbPillInfo;
end

if (MODULE_GAMESERVER) then
	PlayerEvent:RegisterGlobal("OnLogin", tbBuyJingHuo.OnLogin, tbBuyJingHuo);
end
