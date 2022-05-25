local AutoNhanChanDonLenh = Ui:GetClass("AutoNhanChanDonLenh") or {}
local nTimerId = 1
local nStatus = 0
local nStartTimer=10
local nNhanChanDonLenh=0
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
AutoNhanChanDonLenh.Say_bak = AutoNhanChanDonLenh.Say_bak or uiSayPanel.OnOpen
function uiSayPanel:OnOpen(tbParam)
	AutoNhanChanDonLenh.Say_bak(uiSayPanel,tbParam)
	if(nStatus==0)then
		return
	end
	for i = 1,table.getn(tbParam[2]) do
		if string.find(tbParam[2][i],"CĐKB 3_Online") then
			me.AnswerQestion(i-1)
			break
		end
	end
	if(nNhanChanDonLenh==0)then
		for i = 1,table.getn(tbParam[2]) do
			if string.find(tbParam[2][i],"x2") then
				me.AnswerQestion(i-1)
				nNhanChanDonLenh=1
				AutoNhanChanDonLenh.ThayDoi_Timer(11)	
				break	
			end
		end
		AutoNhanChanDonLenh.CloseWinDows()
		return
	end
	if(nNhanChanDonLenh==1)then
		for i = 1,table.getn(tbParam[2]) do
			if string.find(tbParam[2][i],"x3") then
				me.AnswerQestion(i-1)
				nNhanChanDonLenh=2
				AutoNhanChanDonLenh.ThayDoi_Timer(12)
				break
			end
		end
		AutoNhanChanDonLenh.CloseWinDows()
		return
	end
	if(nNhanChanDonLenh==2)then
		for i = 1,table.getn(tbParam[2]) do
			if string.find(tbParam[2][i],"x4") then
				me.AnswerQestion(i-1)
				nNhanChanDonLenh=3
				AutoNhanChanDonLenh.ThayDoi_Timer(13)
				break
			end
		end
		AutoNhanChanDonLenh.CloseWinDows()
		return
	end
	if(nNhanChanDonLenh==3)then
		for i = 1,table.getn(tbParam[2]) do
			if string.find(tbParam[2][i],"Nhận 1 Chân Đơn Lệnh") then
				local i = 4
				me.AnswerQestion(i-1)
				nNhanChanDonLenh=4
				AutoNhanChanDonLenh.ThayDoi_Timer(14)
				break
			end
		end
		AutoNhanChanDonLenh.CloseWinDows()
		return
	end
	if(nNhanChanDonLenh==4)then
		for i = 1,table.getn(tbParam[2]) do
			if string.find(tbParam[2][i],"Nhận 2 Chân Đơn Lệnh") then
				me.AnswerQestion(i-1)
				nNhanChanDonLenh=5
				AutoNhanChanDonLenh.ThayDoi_Timer(15)
				break
			end
		end
		AutoNhanChanDonLenh.CloseWinDows()
		return
	end
	
end
function AutoNhanChanDonLenh.Stop()
	if (nTimerId ~= 1) then
		Ui.tbLogic.tbTimer:Close(nTimerId)
	end
	nTimerId=0
	nStatus=0
end
function AutoNhanChanDonLenh.Start()
	nTimerId = Ui.tbLogic.tbTimer:Register(nStartTimer,AutoNhanChanDonLenh.OnTimer)
end
function AutoNhanChanDonLenh.Status()
	return nStatus
end
function AutoNhanChanDonLenh.Switch()
	if nStatus == 0 then
		nStatus=1
		AutoNhanChanDonLenh.Start()
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật: Tự nhận Chân đơn lệnh [Shift+O]<color>");
		me.Msg("<color=green>Bật<color> Tự nhận Chân đơn lệnh")
	else
		nStatus=0
		AutoNhanChanDonLenh.Stop()	
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Tắt: Tự nhận Chân đơn lệnh [Shift+O]<color>");		
		me.Msg("<color=green>Tắt<color> Tự nhận Chân đơn lệnh")
	end
end
function AutoNhanChanDonLenh.OnTimer()
	local tbFind = me.FindItemInBags(18,1,1181,1)
	local nBaoRuongSuKien=table.getn(tbFind)
	if(nBaoRuongSuKien==0)then
		me.Msg("Không có Kim Bài Lệnh!")
		AutoNhanChanDonLenh.Stop()
		AutoNhanChanDonLenh.CloseWinDows()
		return
	end
	if (me.nLevel >= 50) then
		if(nNhanChanDonLenh==5)then
			nNhanChanDonLenh=0
			AutoNhanChanDonLenh.CloseWinDows()
			AutoNhanChanDonLenh.ThayDoi_Timer(3000)
			return
		end
		AutoNhanChanDonLenh.CloseWinDows()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem)
			end
		end
	end
end
function AutoNhanChanDonLenh.ThayDoi_Timer(nTime)
	if nStartTimer ~= nTime then
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = Ui.tbLogic.tbTimer:Register(nTime,AutoNhanChanDonLenh.OnTimer);
		nStartTimer = nTime
	end
end
function AutoNhanChanDonLenh.CloseWinDows()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
end
function AutoNhanChanDonLenh.Reloadevent()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\Tools\\script\\window\\NSMM.lua");
	me.Msg("Reload")
end

Ui:RegisterNewUiWindow("UI_AutoNhanChanDonLenh", "AutoNhanChanDonLenh", {"a",320,200}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={ "Ui(Ui.UI_AutoNhanChanDonLenh).Switch()", "AutoNhanChanDonLenh", "", "Shift+O", "Shift+O", "Auto Nhan Ngoi Sao May Man"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	local tCmd={ "Ui(Ui.UI_AutoNhanChanDonLenh).Reloadevent()", "Reloadevent", "", "Ctrl+Shift+Z", "Ctrl+Shift+Z", "Auto Nhan Ngoi Sao May Man"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

