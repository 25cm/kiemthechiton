------------------------------------------------------
-- 文件名　：partnertuijianxin.lua
-- 创建者　：dengyong
-- 创建时间：2010-01-05 17:42:14
-- 描  述  ：同伴推荐信
------------------------------------------------------

local tbItem = Item:GetClass("partnertuijianxin");

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Tính năng đồng hành chưa mở.vui lòng thử lại sau");
		return 0;
	end

	local szMsg = "Sử dụng Thư Đồng Hành, đồng hành có thể được giao dịch, <color=yellow>đồng thời thân mật và lĩnh ngộ của đồng hành sẽ trở về giá trị mặc định<color>, bạn có muốn sử dụng?";
	local tbOpt = {};
	
	for i = 1, me.nPartnerCount do
		local pPartner = me.GetPartner(i - 1);
		-- 只有一级的同伴才可以
		if pPartner and pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) == 1 then
			table.insert(tbOpt, {pPartner.szName, self.InsertAPartner, self, i - 1, it.dwId});
		end
	end
	
	if #tbOpt == 0 then
		me.Msg("Hiện tại bạn không có đồng hành cấp 1!");
		Dialog:Say("Hiện tại bạn không có đồng hành cấp 1!");
		return 0;
	end
	
	table.insert(tbOpt, {"Hủy bỏ"});
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbItem:InsertAPartner(nIndex, dwId)
	local pPartner = me.GetPartner(nIndex);
	local pItem = KItem.GetObjById(dwId);
	
	if not pPartner or not pItem then
		return;
	end
	
	if pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) > 1 then
		me.Msg("Chỉ có thể dùng Thư Đồng Hành với đồng hành cấp 1!");
		return;
	end
	
	-- 把同伴放入稚嫩的同伴中之前，先把同伴的信息记录下来，操作成功之后写入日志
	local nPartnerId = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_TEMPID);
	local nLevel = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL);
	local nPotentialId = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialTemp);
	local nPotentialRemained = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialPoint);
	local nPartnerValue = Partner:GetPartnerValue(pPartner);
	
	local szMsg = string.format("%s để đồng hành %s viết thư giới thiệu, ", me.szName, pPartner.szName);
	szMsg = szMsg..string.format("%d, %d, %d, %d, %d, %d, %d, %d, %d",
		nPartnerId, nLevel, nPotentialId, nPotentialRemained, pPartner.GetAttrib(0),
		pPartner.GetAttrib(1), pPartner.GetAttrib(2), pPartner.GetAttrib(3),nPartnerValue
		);
		
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		szMsg = szMsg..string.format(", {%d, %d}", tbSkill.nId, tbSkill.nLevel);
	end
	
	local nRes, pAddItem = Partner:TurnPartnerToItem(me, pPartner);
	if nRes ~= 0 then
		Partner:ConsumePartnerItem(pItem, me);
		
		szMsg = szMsg..string.format("nhận được %s: ", pAddItem.szName);
		local nParnterTempId, nPotentialTemp, tbSkillId = Item:GetClass("childpartner"):ParseGenInfo(pAddItem);
		szMsg = szMsg..string.format("ID đồng hành: %d, ID tiềm năng: %d, ID kỹ năng: {", nParnterTempId, nPotentialTemp);
		for _, nItemSkillId in pairs(tbSkillId) do
			szMsg = szMsg..string.format(" %d,", nItemSkillId);
		end
		szMsg = szMsg.."}";
		
		Dbg:WriteLog("同伴Log:", szMsg);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_REALTION, szMsg);
	end
end