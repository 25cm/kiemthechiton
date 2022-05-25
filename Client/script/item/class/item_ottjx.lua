-- Item Oẳn Tù Tì.
-- Athor: Sesshomaru.


local tbItem = Item:GetClass("item_ottjx");
tbItem.Tax = 0;--Thuế tính theo %
tbItem.TienXu = {18,10,11,2};--Id vật phẩm Có thể dùng đặt cược
tbItem.nG = 18;
tbItem.nD = 10;
tbItem.nP = 11;
tbItem.nL = 2;
tbItem.nChatFace = 280;

tbItem.MinimumJbCoin = 10000;--Số lượng đồng ít nhất có thể tham gia
tbItem.Luachon = {
[1]="Búa",
[2]="Bao",
[3]="<pic=36> Kéo <pic=36>",

};

function tbItem:OnUse()


	local tbOpt = {
  
		{"Nhập Tên Nhân Vật", self.AskRoleName, self,it.dwId},
		{"Người Chơi Bên Cạnh", self.AroundPlayer, self,it.dwId},
		{"Ta Chưa Cần, Để Chơi Sau Đi!!!"},
	};
 
	Dialog:Say("Hãy Tìm Những Người Chơi Xung Quanh Và Mời Họ Tham Gia <bclr=red><color=yellow>[Oẳn Tù Tì]<color><bclr> Đi! <pic=98> \n\n<color=yellow>Chọn Chức Năng:<color>", tbOpt);
 
	return 0;


end
function tbItem:AskRoleName(nItemId)
	Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName, self,nItemId);
end
function tbItem:OnInputRoleName(nItemId,szRoleName)
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
	if (not nPlayerId) then
		Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self,nItemId}, {"Kết thúc đối thoại"});
	return;
	end
 
	self:ViewPlayer(nPlayerId,nItemId);
end
function tbItem:AroundPlayer(nItemId)
	local tbPlayer = {};
	local _, nMyMapX, nMyMapY = me.GetWorldPos();
	for _, pPlayer in ipairs(KPlayer.GetAroundPlayerList(me.nId, 50)) do
	if (pPlayer.szName ~= me.szName) then
		local _, nMapX, nMapY = pPlayer.GetWorldPos();
		local nDistance = (nMapX - nMyMapX) ^ 2 + (nMapY - nMyMapY) ^ 2;
		tbPlayer[#tbPlayer+1] = {nDistance, pPlayer};
	end
end
	local function fnLess(tb1, tb2)
	return tb1[1] < tb2[1];
	end
		table.sort(tbPlayer, fnLess);
	local tbOpt = {};
	for _, tb in ipairs(tbPlayer) do
	local pPlayer = tb[2];
		tbOpt[#tbOpt+1] = {pPlayer.szName, self.ViewPlayer, self, pPlayer.nId,nItemId};
	if (#tbOpt >= 8) then
		break;
	end
end
	tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
 
	Dialog:Say("<color=yellow>Người Chơi Cần Chọn:<color>", tbOpt);
end
function tbItem:CheckJbcoin(nIdPlayer_Request,nPlayerId_be_Request)
	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	local pBeReQuestJbCoin2 = pPlayerId_be_Request.nCoin;
	local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
		if (pBeReQuestJbCoin2 < tbItem.MinimumJbCoin) then
				Setting:SetGlobalObj(pPlayerId_be_Request);
				Dialog:SendBlackBoardMsg(pPlayerId_be_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>%s Vạn Đồng<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pPlayerId_be_Request.szName,math.floor(tbItem.MinimumJbCoin/10000)));
				Setting:RestoreGlobalObj();
				Setting:SetGlobalObj(pIdPlayer_Request);
				Dialog:SendBlackBoardMsg(pIdPlayer_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>%s Vạn Đồng<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pPlayerId_be_Request.szName,math.floor(tbItem.MinimumJbCoin/10000)));
				Setting:RestoreGlobalObj();

			return 0;
		elseif (pReQuestJbCoin1 < tbItem.MinimumJbCoin) then
				Setting:SetGlobalObj(pPlayerId_be_Request);
				Dialog:SendBlackBoardMsg(pPlayerId_be_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>%s Vạn Đồng<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pIdPlayer_Request.szName,math.floor(tbItem.MinimumJbCoin/10000)));
				Setting:RestoreGlobalObj();
				Setting:SetGlobalObj(pIdPlayer_Request);
				Dialog:SendBlackBoardMsg(pIdPlayer_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>%s Vạn Đồng<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pIdPlayer_Request.szName,math.floor(tbItem.MinimumJbCoin/10000)));
				Setting:RestoreGlobalObj();

			return 0;
		end
end
function tbItem:CheckXucoin(nIdPlayer_Request,nPlayerId_be_Request)
	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	local pBeReQuestXuCoin = pPlayerId_be_Request.GetItemCountInBags(unpack(tbItem.TienXu));
	local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbItem.TienXu));
		if (pBeReQuestXuCoin < 1) then
				Setting:SetGlobalObj(pPlayerId_be_Request);
				Dialog:SendBlackBoardMsg(pPlayerId_be_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pPlayerId_be_Request.szName ));
				Setting:RestoreGlobalObj();
				Setting:SetGlobalObj(pIdPlayer_Request);
				Dialog:SendBlackBoardMsg(pIdPlayer_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pPlayerId_be_Request.szName));
				Setting:RestoreGlobalObj();

			return 0;
		elseif (pReQuestXuCoin < 1) then
				Setting:SetGlobalObj(pPlayerId_be_Request);
				Dialog:SendBlackBoardMsg(pPlayerId_be_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pIdPlayer_Request.szName));
				Setting:RestoreGlobalObj();
				Setting:SetGlobalObj(pIdPlayer_Request);
				Dialog:SendBlackBoardMsg(pIdPlayer_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pIdPlayer_Request.szName));
				Setting:RestoreGlobalObj();

			return 0;
		end
end

function tbItem:ViewPlayer(nPlayerId,nItemId)
 -- 插入最近玩家列表
 -- local pReQuestJbCoin1 = me.nCoin;
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId);
 -- local pBeReQuestJbCoin2 = pPlayerId_be_Request.nCoin;
	local szDT = pPlayerId_be_Request.nCoin;
	local szDTT	= (string.format("<color=gold>%d Vạn<color>",szDT/10000));
	
	local pBeReQuestXuCoin = pPlayerId_be_Request.GetItemCountInBags(unpack(tbItem.TienXu));
	local szTienXu = KItem.GetNameById(unpack(tbItem.TienXu));
	
	local szName = KGCPlayer.GetPlayerName(nPlayerId);
	local tbInfo = GetPlayerInfoForLadderGC(szName);
	local tbState = {
		[0]  = "Không Online",
		[-1] = "Đang xử lý",
		[-2] = "Auto?",
	};
	local nState = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	local tbText = {
		{"<color=cyan>Tên:<color> ", "<bclr=red><color=white>"..szName.."<color><bclr>"},
		{"<color=cyan>Cấp:<color> ", tbInfo.nLevel},
		{"<color=yellow>Đồng:<color> ", szDTT},
		{"<color=yellow>Tiền Xu:<color> ", pBeReQuestXuCoin,szTienXu},
		{"<color=pink>Trạng Thái:<color> ", (tbState[nState] or "<color=green>Trên mạng<color>") .. " ("..nState..")"},
	}
	local szMsg = "";
	for _, tb in ipairs(tbText) do
		szMsg = szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
	end
	local szButtonColor = (nState > 0 and "") or "<color=gray>";
	local tbOpt = {
		{"<color=yellow>Mời Chơi<color> - <bclr=red><color=yellow>Oẳn Tù Tì<color><bclr>", self.OTT_Request, self, me.nId,nPlayerId,nItemId},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbItem:OTT_Request(nIdPlayer_Request,nPlayerId_be_Request,nItemId)
	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	
	-- 只要使用了求婚卡片，不论对方是否同意都得删除
	--local pItem = KItem.GetObjById(nItemId);
	--if pItem then
		--pItem.Delete(pIdPlayer_Request);
	--end
	
	local szMsg = string.format("<bclr=red><color=white>%s<color><bclr> Đã Gửi Lời Mời Chơi <bclr=red><color=yellow>Oẳn Tù Tì<color><bclr> với bạn, Bạn Có Đồng Ý Không ?", pIdPlayer_Request.szName);
	local tbOpt = 
	{
		{"<color=yellow>Vâng Ta Đồng Ý<color>", self.OnAcceptQiuhun, self, nIdPlayer_Request,nPlayerId_be_Request},
		{"Thôi Ta Không Chơi Đâu !", self.OnRefuseQiuhun, self, nIdPlayer_Request,nPlayerId_be_Request},
	};
	
	Setting:SetGlobalObj(pPlayerId_be_Request);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();

end
function tbItem:OnRefuseQiuhun(nSuitorId, nTeamMateId)
	
	local pSuitor = KPlayer.GetPlayerObjById(nSuitorId);
	local pTeamMate = KPlayer.GetPlayerObjById(nTeamMateId);
	
	if not pSuitor or not pTeamMate then
		return 0;
	end
	
	Dialog:SendBlackBoardMsg(pSuitor, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Từ Chối Lời Mời Của Ngươi!", pTeamMate.szName));
end
function tbItem:OnAcceptQiuhun(nIdPlayer_Request,nPlayerId_be_Request)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local pReQuestJbCoinx1 = pIdPlayer_Request.nCoin;
	local pReQuestJbCoin1	= (string.format("%d Vạn",pReQuestJbCoinx1/10000));
	local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbItem.TienXu));
	local szTienXu = KItem.GetNameById(unpack(tbItem.TienXu));
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end

	local szMsg = string.format("<bclr=red><color=white>%s<color><bclr> Đã Đồng Ý Lời Mời Chơi <bclr=red><color=yellow>Oẳn Tù Tì<color><bclr> Của Bạn!\nVui Lòng Chọn Loại <color=cyan>Đặt Cược<color> ?\n<color=cyan>Bạn Hiện Có:<color>\n<color=gold>Đồng: %s<color>\n<color=yellow>%s: %s<color>", pPlayerId_be_Request.szName,pReQuestJbCoin1,szTienXu,pReQuestXuCoin);
	local tbOpt = 
	{
		{"<color=gold>Đồng<color>", self.Step2_LoaiDatCuoc, self, nIdPlayer_Request,nPlayerId_be_Request,1},
		{"<color=yellow>"..szTienXu.."<color>", self.Step2_LoaiDatCuoc, self, nIdPlayer_Request,nPlayerId_be_Request,2},
		{"Ta Suy Nghĩ Lại !", self.OnRefuseQiuhun, self, nIdPlayer_Request,nPlayerId_be_Request},
	};
	Setting:SetGlobalObj(pIdPlayer_Request);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();

end
function tbItem:Step2_LoaiDatCuoc(nIdPlayer_Request,nPlayerId_be_Request,nType)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local pBeReQuestJbCoinx2 = pPlayerId_be_Request.nCoin;
	local pBeReQuestJbCoin2	= (string.format("%d Vạn",pBeReQuestJbCoinx2/10000));
	local pBeReQuestXuCoin = pPlayerId_be_Request.GetItemCountInBags(unpack(tbItem.TienXu));
	local szTienXu = KItem.GetNameById(unpack(tbItem.TienXu));
	local szType = "";
	if nType == 1 then
		szType = "<color=gold>Đồng<color>";
	elseif nType == 2 then
		szType = "<color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color>";
	end
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	local szMsg = string.format("<bclr=red><color=white>%s<color><bclr> Đã Chọn Hình Thức Đặt Cược Là %s.\n<color=cyan>Bạn Hiện Có:<color>\n<color=gold>Đồng: %s<color>\n<color=yellow>%s: %s<color>\nBạn Vẫn Muốn Tham Gia ?", pIdPlayer_Request.szName,szType,pBeReQuestJbCoin2,szTienXu,pBeReQuestXuCoin);
	local tbOpt = 
	{
		{"<color=yellow>Đồng Ý<color>", self.Step3_DatSoLuong_berequest, self, nIdPlayer_Request,nPlayerId_be_Request,nType},
		{"Ta Suy Nghĩ Lại !", self.OnRefuseQiuhun, self, nIdPlayer_Request,nPlayerId_be_Request},
	};
	Setting:SetGlobalObj(pPlayerId_be_Request);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();

end
function tbItem:Step3_DatSoLuong_berequest(nIdPlayer_Request,nPlayerId_be_Request,nType)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	--Check vật phẩm
	if nType == 1 then
		local pBeReQuestJbCoin2 = pPlayerId_be_Request.nCoin;
		local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
			szType = "<color=gold>Vạn Đồng<color>";
			tbItem:CheckJbcoin(nIdPlayer_Request,nPlayerId_be_Request);
			Setting:SetGlobalObj(pPlayerId_be_Request);
			Dialog:AskNumber("Số Tiền :", pBeReQuestJbCoin2, self.Step4_DatSoLuong_request, self , nIdPlayer_Request,nPlayerId_be_Request,nType);
			Setting:RestoreGlobalObj();

	elseif nType == 2 then
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color>";
		local pBeReQuestXuCoin = pPlayerId_be_Request.GetItemCountInBags(unpack(tbItem.TienXu));
		local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbItem.TienXu));
			tbItem:CheckXucoin(nIdPlayer_Request,nPlayerId_be_Request);
			Setting:SetGlobalObj(pPlayerId_be_Request);
			Dialog:AskNumber("Số Lượng :", pBeReQuestXuCoin, self.Step4_DatSoLuong_request, self , nIdPlayer_Request,nPlayerId_be_Request,nType);
			Setting:RestoreGlobalObj();

	end
	--Check Xong vật phẩm
end
function tbItem:Step4_DatSoLuong_request(nIdPlayer_Request,nPlayerId_be_Request,nType,n_BeRequest_Use)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	--Check vật phẩm
	if nType == 1 then
		local pBeReQuestJbCoin2 = pPlayerId_be_Request.nCoin;
		local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
				szType = "<color=gold>Vạn Đồng<color>";
			tbItem:CheckJbcoin(nIdPlayer_Request,nPlayerId_be_Request);
			Setting:SetGlobalObj(pIdPlayer_Request);
			Dialog:AskNumber("Số Tiền :", pReQuestJbCoin1, self.Step5_Berequest_Select, self , nIdPlayer_Request,nPlayerId_be_Request,nType,n_BeRequest_Use);
			Setting:RestoreGlobalObj();

	elseif nType == 2 then
		local pBeReQuestXuCoin = pPlayerId_be_Request.GetItemCountInBags(unpack(tbItem.TienXu));
		local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbItem.TienXu));
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color>";
			tbItem:CheckXucoin(nIdPlayer_Request,nPlayerId_be_Request);
			Setting:SetGlobalObj(pIdPlayer_Request);
			Dialog:AskNumber("Số Lượng :", pReQuestXuCoin, self.Step5_Berequest_Select, self , nIdPlayer_Request,nPlayerId_be_Request,nType,n_BeRequest_Use);
			Setting:RestoreGlobalObj();

	end
	--Check Xong vật phẩm
end

function tbItem:Step5_Berequest_Select(nIdPlayer_Request,nPlayerId_be_Request,nType,n_BeRequest_Use,n_Request_Use)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	local nTieuHao = math.min(n_BeRequest_Use,n_Request_Use);

	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	local n_Request_Use_1 = n_Request_Use;
	local n_BeRequest_Use_1 = n_BeRequest_Use;
	local nTieuHao_1 = nTieuHao;
	--Check vật phẩm
	if nType == 1 then
			szType = "<color=gold>Vạn Đồng<color>";
			tbItem:CheckJbcoin(nIdPlayer_Request,nPlayerId_be_Request);
			n_Request_Use_1 = math.floor(n_Request_Use/10000);
			n_BeRequest_Use_1 = math.floor(n_BeRequest_Use/10000);
			nTieuHao_1 = math.floor(nTieuHao/10000);
	elseif nType == 2 then
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color>";
			tbItem:CheckXucoin(nIdPlayer_Request,nPlayerId_be_Request);
	end
	--Check Xong vật phẩm
	local szMsg = string.format(" <bclr=red><color=white>%s<color><bclr> Đã Đặt Cược: <color=gold>%s<color> %s\n Bạn Đã Đặt Cược: <color=gold>%s<color> %s\n <color=cyan>Số Tiền Được Đặt Cược Là:<color> <color=gold>%s %s<color>\n Vui lòng chọn:", pIdPlayer_Request.szName,n_Request_Use_1,szType,n_BeRequest_Use_1,szType,nTieuHao_1,szType);
	local tbOpt = 
	{
		{"\n\n<pic=281> Búa", self.Step6_Select_request, self, nIdPlayer_Request,nPlayerId_be_Request,n_BeRequest_Use,n_Request_Use,nType,nTieuHao,1},
		{"\n\n<pic=282> Bao", self.Step6_Select_request, self, nIdPlayer_Request,nPlayerId_be_Request,n_BeRequest_Use,n_Request_Use,nType,nTieuHao,2},
		{"\n\n<pic=283> Kéo", self.Step6_Select_request, self, nIdPlayer_Request,nPlayerId_be_Request,n_BeRequest_Use,n_Request_Use,nType,nTieuHao,3},
		{"Ta Suy Nghĩ Lại", self.OnRefuseQiuhun, self, nIdPlayer_Request,nPlayerId_be_Request},
	};
	Setting:SetGlobalObj(pPlayerId_be_Request);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
	
	


end
function tbItem:Step6_Select_request(nIdPlayer_Request,nPlayerId_be_Request,n_BeRequest_Use,n_Request_Use,nType,nTieuHao,n_Berequest_Select)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	local n_Request_Use_1 = n_Request_Use;
	local n_BeRequest_Use_1 = n_BeRequest_Use;
	local nTieuHao_1 = nTieuHao;

	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	--Check vật phẩm
	if nType == 1 then
			szType = "<color=gold>Vạn Đồng<color>";
			tbItem:CheckJbcoin(nIdPlayer_Request,nPlayerId_be_Request);
			n_Request_Use_1 = math.floor(n_Request_Use/10000);
			n_BeRequest_Use_1 = math.floor(n_BeRequest_Use/10000);
			nTieuHao_1 = math.floor(nTieuHao/10000);
	elseif nType == 2 then
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color>";
			tbItem:CheckXucoin(nIdPlayer_Request,nPlayerId_be_Request);
	end
	--Check Xong vật phẩm
	local szMsg = string.format("<bclr=red><color=white>%s<color><bclr> Đã Đặt Cược: <color=gold>%s<color> %s\n Bạn Đã Đặt Cược: <color=gold>%s<color> %s\n <color=cyan>Số Tiền Được Đặt Cược Là:<color> <color=gold>%s %s<color>\n Vui lòng chọn:", pPlayerId_be_Request.szName,n_BeRequest_Use_1,szType,n_Request_Use_1,szType,nTieuHao_1,szType);
	local tbOpt = 
	{
		{"\n\n<pic=281> Búa", self.Step7_Traketqua, self, nIdPlayer_Request,nPlayerId_be_Request,nType,nTieuHao,n_Berequest_Select,1},
		{"\n\n<pic=282> Bao", self.Step7_Traketqua, self, nIdPlayer_Request,nPlayerId_be_Request,nType,nTieuHao,n_Berequest_Select,2},
		{"\n\n<pic=283> Kéo", self.Step7_Traketqua, self, nIdPlayer_Request,nPlayerId_be_Request,nType,nTieuHao,n_Berequest_Select,3},
		{"Ta Suy Nghĩ Lại", self.OnRefuseQiuhun, self, nIdPlayer_Request,nPlayerId_be_Request},
	};
	Setting:SetGlobalObj(pIdPlayer_Request);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
	



end


function tbItem:Step7_Traketqua(nIdPlayer_Request,nPlayerId_be_Request,nType,nTieuHao,n_Berequest_Select,n_request_select)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local pPlayerId_be_Request = KPlayer.GetPlayerObjById(nPlayerId_be_Request);
	local szType = "";
	local szText_R = "";
	local szText_B = "";
	local pWin = "";
	local nKetQua = 0; --1 là người mời thắng,2 là hòa,3 là người được mời thắng
	local nTieuHao_1 = nTieuHao;
	if not pIdPlayer_Request or not pPlayerId_be_Request then
		return 0;
	end
	--Check vật phẩm
			if n_request_select == 1 and n_Berequest_Select == 1 then
					nKetQua = 2;
					szText_R = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"
		elseif n_request_select == 1 and n_Berequest_Select == 2 then
					nKetQua = 3;
					szText_R = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
		elseif n_request_select == 1 and n_Berequest_Select == 3 then
					nKetQua = 1;
					szText_R = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
		elseif n_request_select == 2 and n_Berequest_Select == 1 then
					nKetQua = 1;
					szText_R = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
		elseif n_request_select == 2 and n_Berequest_Select == 2 then
					nKetQua = 2;
					szText_R = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"

		elseif n_request_select == 2 and n_Berequest_Select == 3 then
					nKetQua = 3;
					szText_R = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
		elseif n_request_select == 3 and n_Berequest_Select == 1 then
					nKetQua = 3;
					szText_R = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
		elseif n_request_select == 3 and n_Berequest_Select == 2 then
					nKetQua = 1;
					szText_R = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
		elseif n_request_select == 3 and n_Berequest_Select == 3 then
					nKetQua = 2;
					szText_R = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"
					szText_B = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"

		end

	if nType == 1 then
			szType = "<color=gold>Vạn Đồng<color>";
			tbItem:CheckJbcoin(nIdPlayer_Request,nPlayerId_be_Request);
	local pBeReQuestJbCoin2 = pPlayerId_be_Request.nCoin;
	local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
				nTieuHao_1 = math.floor(nTieuHao/10000);
	if nTieuHao > math.min(pBeReQuestJbCoin2,pReQuestJbCoin1) then
			return 0;
		end
		if nKetQua == 1 then
			pIdPlayer_Request.AddJbCoin(nTieuHao-nTieuHao*tbItem.Tax/100)
			pPlayerId_be_Request.AddJbCoin(-nTieuHao)
		elseif nKetQua == 3 then
			pIdPlayer_Request.AddJbCoin(-nTieuHao)
			pPlayerId_be_Request.AddJbCoin(nTieuHao-nTieuHao*tbItem.Tax/100)

		end
	elseif nType == 2 then
	local pBeReQuestXuCoin = pPlayerId_be_Request.GetItemCountInBags(unpack(tbItem.TienXu));
	local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbItem.TienXu));
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbItem.TienXu)).."<color>";
			tbItem:CheckXucoin(nIdPlayer_Request,nPlayerId_be_Request);
		if nTieuHao > math.min(pBeReQuestXuCoin,pReQuestXuCoin) then
			return 0;
		end
		if nKetQua == 1 then
			pIdPlayer_Request.AddStackItem(tbItem.nG,tbItem.nD,tbItem.nP,tbItem.nL,nil,nTieuHao);
			pPlayerId_be_Request.ConsumeItemInBags(nTieuHao,unpack(tbItem.TienXu));
		elseif nKetQua == 3 then
			pPlayerId_be_Request.AddStackItem(tbItem.nG,tbItem.nD,tbItem.nP,tbItem.nL,nil,nTieuHao);
			pIdPlayer_Request.ConsumeItemInBags(nTieuHao,unpack(tbItem.TienXu));

		end

	end
	
	--Check Xong vật phẩm
	
	
	
	
	
	local szMsg = string.format("<color=cyan>Đối Phương Đã đặt Cược:<color> <color=gold>%s <color> %s\nBạn Lựa Chọn là:    Đối Phương Chọn Là: \n\n\n\n  <pic=".. n_request_select + tbItem.nChatFace  ..">        <pic=".. n_Berequest_Select + tbItem.nChatFace  ..">\n\n\n\nKết Quả Là Bạn: %s", 			nTieuHao_1,szType,szText_R);
	local szMsg2 = string.format("<color=cyan>Bạn Đã Đặt Cược:<color> <color=gold>%s <color> %s\nBạn Lựa Chọn là:    Đối Phương Chọn Là:  \n\n\n\n  <pic=".. n_Berequest_Select + tbItem.nChatFace  ..">       <pic=".. n_request_select + tbItem.nChatFace..">\n\n\n\nKết Quả Là Bạn: %s", nTieuHao_1,szType,szText_B);
		local tbOpt = {};

	Setting:SetGlobalObj(pIdPlayer_Request);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
	Setting:SetGlobalObj(pPlayerId_be_Request);
	Dialog:Say(szMsg2, tbOpt);
	Setting:RestoreGlobalObj();

	--pIdPlayer_Request.Msg(szMsg);
	--pPlayerId_be_Request.Msg(szMsg2);


end

