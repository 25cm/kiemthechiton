local tbDiamonds = Item:GetClass("jxsf8_gradediamonds");

tbDiamonds.UpRate100PMax={
	[1] = 2,
	[2] = 7,
	[3] = 12,
	[4] = 17,
}

tbDiamonds.UpRateDiff={
	[1] = 40,
	[2] = 18,
	[3] = 12,
	[4] = 5,
	[5] = 3,
	[6] = 1,
	[7] = 0,
	[8] = 0,
	[9] = 0,
	[10] = 0,
	[11] = 0,
	[12] = 0,
	[13] = 0,
	[14] = 0,
	[15] = 0,
	[16] = 0,
	[17] = 0,
	[18] = 0,
	[19] = 0,
	[20] = 0,
}

function tbDiamonds:OnUse()
	local nLevel = it.nLevel;
	local nMaxPoint = tbDiamonds.UpRate100PMax[nLevel];
	local szMsg = "Tinh thạch quý giá của trời đất, dùng để luyện hóa Chân Vũ";
	local tbOpt = {};
	
	for i = 20,21 do
		local pItem = me.GetEquip(i);
		if (pItem)then
			local ItemLevel = pItem.GetGenInfo(12);
			local szName = "<color=green>"..pItem.szName.."<color>";
			local nRandRate = 0;
			if ItemLevel <= nMaxPoint then
				nRandRate = 100;
			else
				nRandRate = tbDiamonds.UpRateDiff[ItemLevel - nMaxPoint];
			end
			szName = szName.."-><color=red>"..nRandRate.."%<color>";
			table.insert(tbOpt, {szName, self.DoAddEquipPoint, self, pItem,it});
		end
	end	
	if #tbOpt == 0 then 
		szMsg = szMsg.."\n\n<color=gold>Vui lòng trang bị Chân Vũ trước khi luyện hóa";
	end
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbDiamonds:DoAddEquipPoint(pItem,pThisItem)
	local szMsg = "";
	local nLevel = pThisItem.nLevel;
	local tbOpt = {};
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem)
	end
	
	local nMaxPoint = tbDiamonds.UpRate100PMax[nLevel];
	local ItemLevel = pItem.GetGenInfo(12);
	local nRandRate = 0;
	if ItemLevel <= nMaxPoint then
		nRandRate = 100;
	else
		nRandRate = tbDiamonds.UpRateDiff[ItemLevel - nMaxPoint];
	end	
	local nRandom = MathRandom(1,100);
	local nNewLevel = ItemLevel;
	if ItemLevel==20 then
		me.Msg("Luyện hóa đã đạt cấp cao nhất");
		return 0;
	end
	if nRandom < nRandRate then
		nNewLevel = nNewLevel + 1;
		szMsg = string.format("Người chơi <color=yellow>[%s]<color> dùng <color=green>%s<color> luyện hóa thành công <color=green>%s<color> lên <color=yellow>%d<color> cấp", me.szName,pThisItem.szName,pItem.szName,ItemLevel+1);
		me.Msg(szMsg);
		if ItemLevel+1 >=18 then
			KDialog.MsgToGlobal(szMsg);	
		end
	else
		nNewLevel = nNewLevel - 1;
		szMsg = "<color=red>Luyện hóa thất bại, Trang bị bị giáng <color=gold>1 Cấp<color><color>";
		me.Msg(szMsg);
	end
	Item:SetGradeEquipUpGradeLevel(pItem,nNewLevel);
	return 0;
end
