local AutoThuongHoi = Ui:GetClass("AutoThuongHoi")
local tbMsgBoxWithObj = Ui(Ui.UI_MSGBOXWITHOBJ)
local tbRepository = Ui:GetClass("repository");
local tbBox = Item:GetClass("merchant_box");
local uiMail = Ui(Ui.UI_MAIL)
AutoThuongHoi.state = 0
local nTimer = 0
local tbToaDoVeThanh = {
{4,1624,3253},
}

local tbVatPhamThuThap = { --so luong,mapid,pos x ,pos y, item id,ten item
{3,86,1800,3581,475,"Sen Mẫu Đơn"},
{3,86,1701,3716,476,"Bách Hương Quả"},
{3,91,1792,3630,477,"Huyết Phong Đằng"},
{2,91,1679,3675,478,"Hắc Tinh Thạch"},
{2,89,1684,3188,479,"Lục Thủy Tinh"},
{1,90,1834,3231,480,"Thất Thái Thạch"},
}
local tbFindItem = { --so luong,id item, level item,id task kiem tra so luong lenh bai trong hop TH,gia mua ngoai
{3,84,1,nil,2000},  --lenh bai nghia quan
{1,111,1,nil,5000},  --BHD so
{1,110,1,nil,200000},-- GT so
{1,81,1,nil,70000},-- MP so
{1,289,1,11},
{2,289,2,12},
{3,289,3,13},
{3,289,4,14},
{3,289,5,15},
{3,289,6,16},
{1,289,7,17,5000}, --TDC5
{1,289,8,18,5000}, --TDC4
{2,289,9,19,5000}, --TDC3
{2,289,10,20,12000}, --TDC2
{10,190,1,nil,150}, --DBL
}
local nIdxBuyItem = -1
local nThuDangXem = 1
local nMailCount_old = nil

function AutoThuongHoi:State()
	nIdxBuyItem = -1
	nThuDangXem = 1
	KAuction.AuctionSearchRequest("",14,0,0,0,0,2,0,0,-1,0,3)
	
	if AutoThuongHoi.state == 0 then
		if me.GetTask(2036,Merchant.TASK_NOWTASK) == 0 then
			me.Msg(tostring("Bạn chưa nhận nhiệm vụ Thương Hội"))
			return
		end
		AutoThuongHoi.state = 1
		nTimer = Ui.tbLogic.tbTimer:Register(18,AutoThuongHoi.Timer);
		me.Msg("<bclr=red><color=yellow>Bật Auto Thương Hội [Shift+Q]<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật Auto Thương Hội<color><bclr>");
	else
		AutoThuongHoi.state = 0
		Ui.tbLogic.tbTimer:Close(nTimer);
		me.Msg("<bclr=blue><color=White>Tắt Auto Thương Hội [Shift+Q]<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt Auto Thương Hội<color><bclr>");
		nTimer = 0
		if me.nAutoFightState == 1 then
			AutoThuongHoi.StopAutoFight();	-- me.AutoFight(0)
		end
	end	
end

function AutoThuongHoi.StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function AutoThuongHoi.LoadMail()
	if Mail.nMailCount ~= nMailCount_old then
		nMailCount_old = Mail.nMailCount
		nThuDangXem = 1
		return nThuDangXem
	end
	if Mail.nMailCount == 0 then
		nThuDangXem = "Đã Xem"
		return nThuDangXem
	end
	
	if not me.GetTempTable("Mail").tbMailContent or nThuDangXem == 0 then
		me.RequestMail(me.GetTempTable("Mail").tbMailList[1].nId)
		nThuDangXem = 1
		return 1
	end
	if nThuDangXem == "Đã Xem" then
		return nThuDangXem
	end
	
	if UiManager:WindowVisible(Ui.UI_MAILVIEW) == 0 then
		me.RequestMail(me.GetTempTable("Mail").tbMailList[nThuDangXem].nId)
		return nThuDangXem
	end
	me.Msg("Đang kiểm tra thư thứ <color=yellow>"..nThuDangXem.."/"..Mail.nMailCount)
		local pItem = KItem.GetItemObj(me.GetTempTable("Mail").tbMailContent.nItemIdx);
		if not pItem and me.GetTempTable("Mail").tbMailContent.nMoney == 0 then
			me.DeleteMail(me.GetTempTable("Mail").tbMailContent.nMailId)
			nThuDangXem = 1
			nMailCount_old = nil
			me.Msg("Xóa thư rác!")
			if (UiManager:WindowVisible(Ui.UI_MAILVIEW) == 1) then		
				UiManager:CloseWindow(Ui.UI_MAILVIEW)
			end
			return nThuDangXem
		end
		if me.GetTempTable("Mail").tbMailContent.nItemCount > 0 then
			if pItem then
				me.Msg(tostring("[<color=yellow>"..nThuDangXem.."<color>] <color=cyan>"..pItem.szName))
			end
			if pItem and pItem.nGenre == 18 and pItem.nDetail == 1 and pItem.nParticular == tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][2] and pItem.nLevel == tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][3] then
				me.Msg("Có vật phẩm cần tìm <color=green>"..tostring(pItem.szName))
				me.CallServerScript({ "MailCmd", "ApplyProcess",me.GetTempTable("Mail").tbMailContent.nMailId,0});
				nThuDangXem = 1
				nMailCount_old = nil
				if (UiManager:WindowVisible(Ui.UI_MAILVIEW) == 1) then		
					UiManager:CloseWindow(Ui.UI_MAILVIEW)
				end
				return nThuDangXem
			end
		end


		if nThuDangXem < Mail.nMailCount then
			nThuDangXem = nThuDangXem + 1
			return nThuDangXem-1
		else
			nThuDangXem = "Đã Xem"
			me.Msg("Đã xem hộp thư xong")
			KAuction.AuctionSearchRequest("",14,0,0,0,0,2,0,0,-1,0,3)
			return nThuDangXem
		end
end

function AutoThuongHoi.TimVatPhamTrenDauGia(G,D,P,L,nGiaCaoNhatCoTheMua)
	if UiManager:WindowVisible(Ui.UI_MSGBOXWITHOBJ) == 1 then
		tbMsgBoxWithObj:OnButtonClick("BtnOption2",0)
	end
	if (UiManager:WindowVisible(Ui.UI_MAILVIEW) == 1) then		
		UiManager:CloseWindow(Ui.UI_MAILVIEW)
	end
	if nIdxBuyItem ~= -1 then
		AutoThuongHoi:MuaVatPhamDauGia(nIdxBuyItem)
		nThuDangXem = 1
		nIdxBuyItem = -1
		return
	end
	local bEndPage = KAuction.IsEndPage();
	
	if bEndPage == 0 and nIdxBuyItem == -1 then
		me.Msg("Trang thứ "..tostring(KAuction.GetCurPageNo()))
		local nItemCountPerPage = KAuction.AuctionGetSearchResultNum() - 1;
		for nItemBarIdx = 0, nItemCountPerPage do
			local rec = KAuction.AuctionGetSearchResultByIndex(nItemBarIdx);
			if ( rec ~= nil ) then
				local nItemIdx		= rec.GetItemIndex();
				local nOnePrice		= rec.GetOneTimeBuyPrice();
				local pItem 		= KItem.GetItemObj(nItemIdx);
				me.Msg(tostring("<color=yellow>"..pItem.szName.."<color> = <color=yellow>"..nOnePrice))
				if pItem.nGenre == G and pItem.nDetail == D and pItem.nParticular == P and pItem.nLevel == L and nOnePrice <= nGiaCaoNhatCoTheMua then
					me.Msg("Tự động mua <color=yellow>"..pItem.szName.."<color> giá <color=yellow>"..nOnePrice)
					nIdxBuyItem = nItemBarIdx
					return
				end
			end		
		end
		me.Msg("<color=green>-----------------------------------------")
		KAuction.AuctionNextPage("",14,0,0,0,0,2,0,0,-1,0,3)
	elseif bEndPage == 1 then
		me.Msg("Thử tìm lại trên đấu giá")
		nIdxBuyItem = -1
		KAuction.AuctionSearchRequest("",14,0,0,0,0,2,0,0,-1,0,3)
	end

end

function AutoThuongHoi:MuaVatPhamDauGia(nIdxBuyItem_)
	if not nIdxBuyItem_ or nIdxBuyItem_ == -1 then
		return
	end
	local rec = KAuction.AuctionGetSearchResultByIndex(nIdxBuyItem_);
	if ( rec ~= nil ) then
		local nItemIdx		= rec.GetItemIndex();
		local nOnePrice		= rec.GetOneTimeBuyPrice();
		local pItem 		= KItem.GetItemObj(nItemIdx);
		if pItem.nGenre == 18 and pItem.nDetail == 1 and pItem.nParticular == tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][2] and pItem.nLevel == tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][3] and nOnePrice <= tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][5] then
			me.Msg(tostring("<color=yellow>Mua "..pItem.szName.."<color> = <color=yellow>"..nOnePrice))
			local szData = KIo.ReadTxtFile("\\interface\\ThanhTung\\001a\\window\\VatPhamDauGia.txt");
			if not szData or szData == "" then
				szData = "Thông tin đấu giá \n"
			end
			szData = szData.."\n"..GetServerZoneName().."\t"..me.szAccount.."\t"..me.szName.."\t"..pItem.szName.."	giá : "..nOnePrice.."	"..os.date()
			KIo.WriteFile("\\interface\\ThanhTung\\001a\\window\\VatPhamDauGia.txt",szData)
			KAuction.AuctionOneTimeBuy(KAuction.NumberToInt(nIdxBuyItem_))
		else
			me.Msg("Vật phẩm không đúng")
		end
	end
end

function AutoThuongHoi.Timer()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if me.IsDead() == 1 then
		me.SendClientCmdRevive(0)
		return 
	end
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
		return
	end
	if UiManager:WindowVisible(Ui.UI_MSGBOXWITHOBJ) == 1 then
		tbMsgBoxWithObj:OnButtonClick("BtnOption2",0)
		return
	end
	if me.GetTask(2036,Merchant.TASK_NOWTASK) == 0 then
		me.Msg(tostring("Bạn chưa nhận nhiệm vụ Thương Hội"))
		return
	end
	if me.GetTask(2036,4) == Merchant.TYPE_DELIVERITEM_NEW then
		me.Msg("Nhiem vu gui tin")
	elseif me.GetTask(2036,4) == 6 then
		me.Msg("Nhiem vu mua vat pham")
	elseif me.GetTask(2036,4) == Merchant.TYPE_FINDITEM_NEW then
		AutoThuongHoi.TimVatPham()
	elseif me.GetTask(2036,4) == Merchant.TYPE_COLLECTITEM_NEW then
		AutoThuongHoi.ThuThapVatPham()
	end
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
		return
	end
end

function AutoThuongHoi.LayLenhBai(nLevel,nCount)
	if me.GetItemCountInBags(18,1,288,1) == 0 then
		me.Msg("Không tìm thấy hộp thương hội")
		return
	end
	if me.CountFreeBagCell() < nCount then
		me.Msg("Hành trang không đủ chỗ trống")
		return
	end
	local nSoLuongLenhBai_InMerchantBox = me.GetTask(2036,nLevel+10)
	if nSoLuongLenhBai_InMerchantBox < nCount then
		me.Msg("Không đủ lệnh bài muốn lấy")
		return
	end
	
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		me.AnswerQestion(1)
		local nLuaChon = nLevel
		for i = 1,nLuaChon do
			if me.GetTask(2036,i+10) == 0 then
				nLuaChon = nLuaChon - 1
			end
		end
		if nLuaChon > 5 then
			me.AnswerQestion(5)
			nLuaChon = nLuaChon - 5
		end
		me.AnswerQestion(nLuaChon-1)

		if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
			me.CallServerScript({ "DlgCmd", "InputNum",nCount});
		end
		UiManager:CloseWindow(Ui.UI_TEXTINPUT);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	else
		local tbFind = me.FindItemInBags(18,1,288,1);
		for _, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	end
end

function AutoThuongHoi.TimVatPham()
	--me.Msg("tim vat pham")
	local nSoLuongLenhBaiCanTim = tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][1]
	local nSoLuongLenhBai_InBags = me.GetItemCountInBags(18,1,tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][2],tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][3])
	--local nSoLuongLenhBai_InMerchantBox = 
	if nSoLuongLenhBai_InBags >= nSoLuongLenhBaiCanTim then
		local ChuThuongHoi = AutoThuongHoi.TimNPC_TEN("Chủ Thương Hội")
			if ChuThuongHoi then
				if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 0 then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						me.AnswerQestion(0)
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					else
						AutoAi.SetTargetIndex(ChuThuongHoi.nIndex)
					end
				else
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					end
					local nSoLenhBaiDaDatVao = 0
					if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
						UiManager:SwitchWindow(Ui.UI_ITEMBOX)
					end
					AutoThuongHoi.TraVatPhamNhiemVu(18,1,tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][2],tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][3],nSoLuongLenhBaiCanTim)
					local uiGift = Ui(Ui.UI_ITEMGIFT)
					uiGift.OnButtonClick(uiGift,"BtnOk")
					UiManager:CloseWindow(Ui.UI_ITEMGIFT)
					return
				end
			else
				local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2965);
				if Xnpc and Xnpc ~= 0 then
					AutoThuongHoi.GoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
				else
					AutoThuongHoi.GoTo(27,1609,3259)
				end
			end
	else
		if tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][4] then --neu la vat pham dung trong hop
			local nSoLuongLenhBai_InMerchantBox = me.GetTask(2036,tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][4])
			
			if nSoLuongLenhBai_InBags + nSoLuongLenhBai_InMerchantBox >= nSoLuongLenhBaiCanTim then
				AutoThuongHoi.LayLenhBai(tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][4]-10,nSoLuongLenhBaiCanTim-nSoLuongLenhBai_InBags)
				--return
			
			--	if nIdxBuyItem ~= -1 then
			--		KAuction.AuctionOneTimeBuy(nIdxBuyItem)
			--		nIdxBuyItem = -1
			elseif me.GetTask(2036,3) <= 4 or me.GetTask(2036,3) >= 11 then
				if type(AutoThuongHoi.LoadMail()) == "number" then
					
				elseif nThuDangXem == "Đã Xem" or nThuDangXem == nil then
					local nItemIdx = AutoThuongHoi.TimVatPhamTrenDauGia(18,1,tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][2],tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][3],tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][5])
				end
				--me.Msg("Không đủ lệnh bài cần tìm....")
			end
		elseif me.GetTask(2036,3) <= 4 or me.GetTask(2036,3) >= 11 then
			if type(AutoThuongHoi.LoadMail()) == "number" then
					
			elseif nThuDangXem == "Đã Xem" or nThuDangXem == nil then
				local nItemIdx = AutoThuongHoi.TimVatPhamTrenDauGia(18,1,tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][2],tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][3],tbFindItem[me.GetTask(2036,Merchant.TASK_NOWTASK)][5])
			end
			--me.Msg("tìm lệnh bài trên đấu giá")
		end
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if (UiManager:WindowVisible(Ui.UI_MAILVIEW) == 1) then		
		UiManager:CloseWindow(Ui.UI_MAILVIEW)
	end
end

function AutoThuongHoi.GuiTin()
	me.Msg("<color=pink>Auto chưa hỗ trợ Nhiệm vụ này")
	AutoThuongHoi:State()
end
function AutoThuongHoi.TraVatPhamNhiemVu(nG,nD,nP,nL,nSoLuong)
	local nSoLuongDaDatVao = 0
	if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then
		local tbFind = me.FindItemInBags(nG,nD,nP,nL);
		for _, tbItem in pairs(tbFind) do
			if tbItem.nRoom == 2 then
				if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
					local tbObj = Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[tbItem.nY][tbItem.nX];
					if nSoLuongDaDatVao < nSoLuong and tbObj ~= nil  then
						--me.Msg(tbItem.pItem.szName)
						if tbItem.pItem.nCount > nSoLuong-nSoLuongDaDatVao then
							me.SplitItem(tbItem.pItem,tbItem.pItem.nCount-nSoLuong+nSoLuongDaDatVao)
						end
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,tbItem.nX, tbItem.nY);
						nSoLuongDaDatVao = nSoLuongDaDatVao + tbItem.pItem.nCount
						if nSoLuongDaDatVao >= nSoLuong then
							return
						end
					end
				end
			elseif tbItem.nRoom == 5 then
				if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
					local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[tbItem.nY][tbItem.nX]
					if nSoLuongDaDatVao < nSoLuong and tbObj ~= nil  then
						--me.Msg(tbItem.pItem.szName)
						if tbItem.pItem.nCount > nSoLuong-nSoLuongDaDatVao then
							me.SplitItem(tbItem.pItem,tbItem.pItem.nCount-nSoLuong+nSoLuongDaDatVao)
						end
						Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,tbItem.nX, tbItem.nY);
						nSoLuongDaDatVao = nSoLuongDaDatVao + tbItem.pItem.nCount
						if nSoLuongDaDatVao >= nSoLuong then
							return
						end
					end
				end
			elseif tbItem.nRoom == 6 then
				if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
					local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[tbItem.nY][tbItem.nX]
					if nSoLuongDaDatVao < nSoLuong and tbObj ~= nil  then
						--me.Msg(tbItem.pItem.szName)
						if tbItem.pItem.nCount > nSoLuong-nSoLuongDaDatVao then
							me.SplitItem(tbItem.pItem,tbItem.pItem.nCount-nSoLuong+nSoLuongDaDatVao)
						end
						Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,tbItem.nX, tbItem.nY);
						nSoLuongDaDatVao = nSoLuongDaDatVao + tbItem.pItem.nCount
						if nSoLuongDaDatVao >= nSoLuong then
							return
						end
					end
				end
			elseif tbItem.nRoom == 7 then
				if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
					local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[tbItem.nY][tbItem.nX]
					if nSoLuongDaDatVao < nSoLuong and tbObj ~= nil  then
						--me.Msg(tbItem.pItem.szName)
						if tbItem.pItem.nCount > nSoLuong-nSoLuongDaDatVao then
							me.SplitItem(tbItem.pItem,tbItem.pItem.nCount-nSoLuong+nSoLuongDaDatVao)
						end
						Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,tbItem.nX, tbItem.nY);
						nSoLuongDaDatVao = nSoLuongDaDatVao + tbItem.pItem.nCount
						if nSoLuongDaDatVao >= nSoLuong then
							return
						end
					end
				end
			end
		end
	end
end
function AutoThuongHoi.IsMapCollectItem(nMapId)
	for i = 1,table.getn(tbToaDoVeThanh) do
		if me.GetMapTemplateId() == tbToaDoVeThanh[i][1] then
			return i
		end
	end
end
function AutoThuongHoi.ThuThapVatPham()
	local nMyPosX,nMyPosY = me.GetNpc().GetMpsPos()
	if me.GetItemCountInBags(20,1,tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][5],1) == tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][1] then
		if AutoThuongHoi.IsMapCollectItem(me.GetMapTemplateId()) then
			AutoAi.SetTargetIndex(0)
			if me.nAutoFightState == 1 then
				AutoThuongHoi.StopAutoFight();	-- me.AutoFight(0)
			end
			if AutoThuongHoi.KhoangCach(nMyPosX,nMyPosY,tbToaDoVeThanh[AutoThuongHoi.IsMapCollectItem(me.GetMapTemplateId())][2]*32,tbToaDoVeThanh[AutoThuongHoi.IsMapCollectItem(me.GetMapTemplateId())][3]*32) < 50 then
				local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2965);
				if Xnpc and Xnpc ~= 0 then
					AutoThuongHoi.GoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
				else
					AutoThuongHoi.GoTo(27,1609,3259)
				end
			else
				AutoThuongHoi.GoTo(me.GetMapTemplateId(),tbToaDoVeThanh[AutoThuongHoi.IsMapCollectItem(me.GetMapTemplateId())][2],tbToaDoVeThanh[AutoThuongHoi.IsMapCollectItem(me.GetMapTemplateId())][3])
			end
		elseif me.GetMapTemplateId() >= 23 and me.GetMapTemplateId() <= 29 then
			local ChuThuongHoi = AutoThuongHoi.TimNPC_TEN("Chủ Thương Hội")
			if ChuThuongHoi then
				if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 0 then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						me.AnswerQestion(0)
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					else
						AutoAi.SetTargetIndex(ChuThuongHoi.nIndex)
					end
				else
					if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
						UiManager:SwitchWindow(Ui.UI_ITEMBOX)
					end
					if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
						for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
								local pItem = me.GetMainBagItem(i,j);
								if pItem then
									if pItem.nGenre == 20 and pItem.nDetail == 1 and pItem.nParticular == tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][5] and pItem.nLevel == 1 then
										local tbObj = Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
										if tbObj ~= nil then
											Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j)	
										end
									end
								end
							end
						end
					end
					if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
						for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
								local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
								if pItem then
									if pItem.nGenre == 20 and pItem.nDetail == 1 and pItem.nParticular == tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][5] and pItem.nLevel == 1 then
										local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
										if tbObj ~= nil then 
											Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
										end
									end
								end
							end
						end
					end
					if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
						for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
								local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i,j);
								if pItem then			
									if pItem.nGenre == 20 and pItem.nDetail == 1 and pItem.nParticular == tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][5] and pItem.nLevel == 1 then
										local tbObj = Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
										if tbObj ~= nil then
											Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
										end
									end
								end
							end
						end
					end
					if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
						for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
								local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom,i, j);
								if pItem then
									if pItem.nGenre == 20 and pItem.nDetail == 1 and pItem.nParticular == tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][5] and pItem.nLevel == 1 then
										local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
										if tbObj ~= nil then
											Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
										end
									end
								end
							end
						end
					end
					local uiGift = Ui(Ui.UI_ITEMGIFT)
					uiGift.OnButtonClick(uiGift,"BtnOk")
				end
			else
				local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2965);
				if Xnpc and Xnpc ~= 0 then
					AutoThuongHoi.GoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
				else
					AutoThuongHoi.GoTo(27,1609,3259)
				end
			end
		end
	else
		local pNpc_ThuThap = AutoThuongHoi.TimNPC_TEN(tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][6])
		local nNpc_CanhGiu = AutoThuongHoi.TimNPC_TEN("Kiếm Tặc")  or AutoThuongHoi.TimNPC_TEN("Đao Tặc")
		if nNpc_CanhGiu then
			local nNpc_PosX,nNpc_PosY =nNpc_CanhGiu.GetMpsPos()
			local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1)
			if AutoThuongHoi.KhoangCach(nMyPosX,nMyPosY,nNpc_PosX,nNpc_PosY) < tbSkillInfo.nAttackRadius then
				AutoAi.SetTargetIndex(nNpc_CanhGiu.nIndex)
				if me.nAutoFightState == 0 then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey()); 	-- me.AutoFight(1)
				end
				local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1)
				if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
					Switch("horse")
				end
			else
				AutoAi.SetTargetIndex(nNpc_CanhGiu.nIndex)
				if me.nAutoFightState == 1 then
					AutoThuongHoi.StopAutoFight();	-- me.AutoFight(0)
				end
			end
			return
		end
		AutoAi.SetTargetIndex(0)
		if me.nAutoFightState == 1 then
			AutoThuongHoi.StopAutoFight();	-- me.AutoFight(0)
		end
		if pNpc_ThuThap then
			AutoAi.SetTargetIndex(pNpc_ThuThap.nIndex)
		else
			AutoThuongHoi.GoTo(tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][2],tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][3],tbVatPhamThuThap[me.GetTask(2036,Merchant.TASK_NOWTASK)][4])
		end
		
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
end
function AutoThuongHoi.KhoangCach(myX,myY,keyX,keyY)
	local nDistance	= 0;
	nDistance = math.sqrt((myX-keyX)^2 + (myY-keyY)^2);
	return nDistance;
end
function AutoThuongHoi.GoTo(M,X,Y)
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = ","..M..","..X..","..Y
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo)
end

function AutoThuongHoi.TimNPC_TEN(sName)
	local tbEnemyList = {}	
	local tbNpcList = KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc and pNpc.szName == sName then
			table.insert(tbEnemyList,pNpc)
		end
	end
	if table.getn(tbEnemyList) == nil then
		return		
	end
	if sName ~= "Kiếm Tặc" and sName~= "Đao Tặc" then
		return AutoThuongHoi.MucTieuGanNhat(tbEnemyList)
	else
		return AutoThuongHoi.MucTieuNhieuMauNhat(tbEnemyList)
	end
end
function AutoThuongHoi.MucTieuNhieuMauNhat(tblistnpc)
	--me.Msg(tostring(table.getn(tblistnpc)))
	local pNpcNhieuMauNhat = nil
	local nMauNhieuNhat = 0
	for _, pNpc in ipairs(tblistnpc) do
		if pNpc.nCurLife > nMauNhieuNhat then
			nMauNhieuNhat = pNpc.nCurLife
			pNpcNhieuMauNhat = pNpc
		end
	end
	if pNpcNhieuMauNhat ~= nil then
		return pNpcNhieuMauNhat
	end
end

function AutoThuongHoi.MucTieuItMauNhat(tblistnpc)
	local pNpcItMauNhat = nil
	local nMauItNhat = math.huge
	for _, pNpc in ipairs(tblistnpc) do
		if pNpc.nCurLife < nMauItNhat then
			nMauItNhat = pNpc.nCurLife
			pNpcItMauNhat = pNpc
		end
	end
	if pNpcItMauNhat ~= nil then
		return pNpcItMauNhat
	end
end

function AutoThuongHoi.MucTieuGanNhat(tblistnpc)
	local npcgannhat = nil
	local khoanggannhat = 5000
	local nMyX, nMyY = me.GetNpc().GetMpsPos();
	for _, pNpc in ipairs(tblistnpc) do
		local Xnpc,Ynpc = pNpc.GetMpsPos();
		local kc_npc = AutoThuongHoi.KhoangCach(nMyX, nMyY,Xnpc,Ynpc)
		if kc_npc <= khoanggannhat then
			npcgannhat = pNpc
			khoanggannhat = kc_npc
		end
	end
	if npcgannhat ~= nil then
		return npcgannhat
	end
end


Ui:RegisterNewUiWindow("UI_THUONGHOI", "AutoThuongHoi", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_THUONGHOI):State()", "AutoThuongHoi", "", "Alt+F1", "Alt+F1", "AutoThuongHoi"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

