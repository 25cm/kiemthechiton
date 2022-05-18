-- Item Oẳn Tù Tì.


local tbNpc = Npc:GetClass("npc_ottjx");
tbNpc.Tax = 0;--Thuế tính theo %
tbNpc.TienXu = {18,10,11,2};--Id vật phẩm Có thể dùng đặt cược
tbNpc.nG = 18;
tbNpc.nD = 10;
tbNpc.nP = 11;
tbNpc.nL = 2;
tbNpc.nChatFace = 280;

tbNpc.MinimumJbCoin = 10000;--Số lượng đồng ít nhất có thể tham gia

function tbNpc:CheckJbcoin(nIdPlayer_Request)
	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local szType = "";
	if not pIdPlayer_Request then
		return 0;
	end
	local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
	if (pReQuestJbCoin1 < tbNpc.MinimumJbCoin) then
				Dialog:SendBlackBoardMsg(pIdPlayer_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>%s Vạn Đồng<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pIdPlayer_Request.szName,math.floor(tbNpc.MinimumJbCoin/10000)));
			return 0;
		end
end
function tbNpc:CheckXucoin(nIdPlayer_Request)
	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local szType = "";
	if not pIdPlayer_Request then
		return 0;
	end
	local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbNpc.TienXu));
	if (pReQuestXuCoin < 1) then
				Dialog:SendBlackBoardMsg(pIdPlayer_Request, string.format("Thật Đáng Tiếc, <bclr=red><color=yellow>%s<color><bclr> Không Đủ <color=yellow>"..KItem.GetNameById(unpack(tbNpc.TienXu)).."<color> Để Tham Gia <bclr=red><color=yellow>[OTT]<color><bclr>!",  pIdPlayer_Request.szName));

			return 0;
		end
end

function tbNpc:OnDialog()


	local tbOpt = {
  
		{"<color=gold>Chơi Ngay<color>", self.Choi, self},
		{"Ta Chỉ Ghé Hỏi Thăm!!!"},
	};
 
	Dialog:Say("Sứ giả: Chào mừng bạn đến với Kiếm Thế Pro Sever ",tbOpt);
 
	return 0;


end
function tbNpc:Choi()

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(me.nId);
	local pReQuestJbCoinx1 = pIdPlayer_Request.nCoin;
	local pReQuestJbCoin1	= (string.format("%d Vạn",pReQuestJbCoinx1/10000));
	local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbNpc.TienXu));
	local szTienXu = KItem.GetNameById(unpack(tbNpc.TienXu));
	if not pIdPlayer_Request then
		return 0;
	end

	local szMsg = string.format("<bclr=red><color=white>%s<color><bclr> Đã Đồng Ý  <bclr=red><color=yellow>Oẳn Tù Tì<color><bclr>!\nVui Lòng Chọn Loại <color=cyan>Đặt Cược<color> ?\n<color=cyan>Bạn Hiện Có:<color>\n<color=gold>Đồng: %s<color>\n<color=yellow>%s: %s<color>", pIdPlayer_Request.szName,pReQuestJbCoin1,szTienXu,pReQuestXuCoin);
	local tbOpt = 
	{
		{"<color=gold>Đồng<color>", self.Step2_LoaiDatCuoc, self, me.nId,1},
		{"<color=yellow>"..szTienXu.."<color>", self.Step2_LoaiDatCuoc, self, me.nId,2},
		{"Ta Suy Nghĩ Lại !"},
	};

end

function tbNpc:Step2_LoaiDatCuoc(nIdPlayer_Request,nType)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local szType = "";
	if not pIdPlayer_Request  then
		return 0;
	end
	--Check vật phẩm
	if nType == 1 then
		local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
			szType = "<color=gold>Vạn Đồng<color>";
			tbNpc:CheckJbcoin(nIdPlayer_Request);
			Dialog:AskNumber("Số Tiền :", pReQuestJbCoin1, self.Step5_Berequest_Select, self , nIdPlayer_Request,nType);

	elseif nType == 2 then
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbNpc.TienXu)).."<color>";
		local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbNpc.TienXu));
			tbNpc:CheckXucoin(nIdPlayer_Request);
			Dialog:AskNumber("Số Lượng :", pReQuestXuCoin, self.Step5_Berequest_Select, self , nIdPlayer_Request,nType);

	end
	--Check Xong vật phẩm
end

function tbNpc:Step5_Berequest_Select(nIdPlayer_Request,nType,n_Request_Use)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local szType = "";
	local nTieuHao = n_Request_Use;

	if not pIdPlayer_Request  then
		return 0;
	end
	local nTieuHao_1 = nTieuHao;
	--Check vật phẩm
	if nType == 1 then
			szType = "<color=gold>Vạn Đồng<color>";
			tbNpc:CheckJbcoin(nIdPlayer_Request);
			nTieuHao_1 = math.floor(nTieuHao/10000);
	elseif nType == 2 then
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbNpc.TienXu)).."<color>";
			tbNpc:CheckXucoin(nIdPlayer_Request);
	end
	--Check Xong vật phẩm
	local szMsg = string.format("Bạn Đã Đặt Cược: <color=gold>%s<color> %s\n  Vui lòng chọn:", nTieuHao_1,szType);
	local tbOpt = 
	{
		{"\n\n<pic=281> Búa", self.Step7_Traketqua, self, nIdPlayer_Request,nType,nTieuHao,1},
		{"\n\n<pic=282> Bao", self.Step7_Traketqua, self, nIdPlayer_Request,nType,nTieuHao,2},
		{"\n\n<pic=283> Kéo", self.Step7_Traketqua, self, nIdPlayer_Request,nType,nTieuHao,3},
		{"Ta Suy Nghĩ Lại"},
	};
	Dialog:Say(szMsg, tbOpt);
	
	


end

function tbNpc:Step7_Traketqua(nIdPlayer_Request,nType,nTieuHao,n_request_select)

	local pIdPlayer_Request = KPlayer.GetPlayerObjById(nIdPlayer_Request);
	local szType = "";
	local szText_R = "";
	local nKetQua = 0; --1 là người mời thắng,2 là hòa,3 là người được mời thắng
	local nTieuHao_1 = nTieuHao;
	local n_Berequest_Select = math.random(1,3);
	if not pIdPlayer_Request  then
		return 0;
	end
	--Check vật phẩm
		if n_request_select == 1 and n_Berequest_Select == 1 then
					nKetQua = 2;
					szText_R = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"
		elseif n_request_select == 1 and n_Berequest_Select == 2 then
					nKetQua = 3;
					szText_R = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
		elseif n_request_select == 1 and n_Berequest_Select == 3 then
					nKetQua = 1;
					szText_R = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
		elseif n_request_select == 2 and n_Berequest_Select == 1 then
					nKetQua = 1;
					szText_R = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
		elseif n_request_select == 2 and n_Berequest_Select == 2 then
					nKetQua = 2;
					szText_R = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"

		elseif n_request_select == 2 and n_Berequest_Select == 3 then
					nKetQua = 3;
					szText_R = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
		elseif n_request_select == 3 and n_Berequest_Select == 1 then
					nKetQua = 3;
					szText_R = "<bclr=red><color=yellow><pic=4> Thua <pic=4><color><bclr>"
		elseif n_request_select == 3 and n_Berequest_Select == 2 then
					nKetQua = 1;
					szText_R = "<bclr=red><color=yellow><pic=0> Thắng <pic=0><color><bclr>"
		elseif n_request_select == 3 and n_Berequest_Select == 3 then
					nKetQua = 2;
					szText_R = "<bclr=red><color=yellow><pic=2> Hòa <pic=2><color><bclr>"

		end

	if nType == 1 then
			szType = "<color=gold>Vạn Đồng<color>";
			tbNpc:CheckJbcoin(nIdPlayer_Request);
	local pReQuestJbCoin1 = pIdPlayer_Request.nCoin;
				nTieuHao_1 = math.floor(nTieuHao/10000);
	if nTieuHao > pReQuestJbCoin1 then
			return 0;
		end
		if nKetQua == 1 then
			pIdPlayer_Request.AddJbCoin(nTieuHao-nTieuHao*tbNpc.Tax/100)
		elseif nKetQua == 3 then
			pIdPlayer_Request.AddJbCoin(-nTieuHao)

		end
	elseif nType == 2 then
	local pReQuestXuCoin = pIdPlayer_Request.GetItemCountInBags(unpack(tbNpc.TienXu));
			szType = "<color=yellow>"..KItem.GetNameById(unpack(tbNpc.TienXu)).."<color>";
			tbNpc:CheckXucoin(nIdPlayer_Request);
		if nTieuHao > pReQuestXuCoin then
			return 0;
		end
		if nKetQua == 1 then
			pIdPlayer_Request.AddStackItem(tbNpc.nG,tbNpc.nD,tbNpc.nP,tbNpc.nL,nil,nTieuHao);
		elseif nKetQua == 3 then
			pIdPlayer_Request.ConsumeItemInBags(nTieuHao,unpack(tbNpc.TienXu));

		end

	end
	
	--Check Xong vật phẩm
	
	
	
	
	
	local szMsg2 = string.format("<color=cyan>Bạn Đã Đặt Cược:<color> <color=gold>%s <color> %s\nBạn Lựa Chọn là:    Đối Phương Chọn Là:  \n\n\n\n  <pic=".. n_request_select + tbNpc.nChatFace  ..">       <pic=".. n_Berequest_Select + tbNpc.nChatFace..">\n\n\n\nKết Quả Là Bạn: %s", nTieuHao_1,szType,szText_R);
		local tbOpt = {};

	Dialog:Say(szMsg2, tbOpt);



end

