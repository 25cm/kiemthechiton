
Ui.UI_ChanNguyen = "UI_ChanNguyen";
local uiChanNguyen = Ui.tbWnd[Ui.UI_ChanNguyen] or {};
uiChanNguyen.UIGROUP = Ui.UI_ChanNguyen;
Ui.tbWnd[Ui.UI_ChanNguyen] = uiChanNguyen;

local self = uiChanNguyen;

uiChanNguyen.BTN_PRINT      = "BtnPrint"; 
uiChanNguyen.BTN_RELOAD      = "BtnReload"; 
uiChanNguyen.BTN_CLOSE       = "BtnClose";
uiChanNguyen.BTN_DETECTOR      = "BtnDetector"; 

uiChanNguyen.BTN_ON_OPEN1       = "BtnOnOpen1";
uiChanNguyen.BTN_OFF_OPEN1       = "BtnOffOpen1";

uiChanNguyen.BTN_ON_OPEN2       = "BtnOnOpen2";
uiChanNguyen.BTN_OFF_OPEN2    = "BtnOffOpen2";

uiChanNguyen.BTN_ON_OPEN3      = "BtnOnOpen3";
uiChanNguyen.BTN_OFF_OPEN3   = "BtnOffOpen3";

uiChanNguyen.BTN_ON_OPEN4      = "BtnOnOpen4";
uiChanNguyen.BTN_OFF_OPEN4   = "BtnOffOpen4";

uiChanNguyen.BTN_ON_OPEN5      = "BtnOnOpen5";
uiChanNguyen.BTN_OFF_OPEN5   = "BtnOffOpen5";

uiChanNguyen.BTN_ON_OPEN6      = "BtnOnOpen6";
uiChanNguyen.BTN_OFF_OPEN6   = "BtnOffOpen6";

uiChanNguyen.BTN_ON_OPEN7      = "BtnOnOpen7";
uiChanNguyen.BTN_OFF_OPEN7   = "BtnOffOpen7";

uiChanNguyen.BTN_ON_OPEN8      = "BtnOnOpen8";
uiChanNguyen.BTN_OFF_OPEN8   = "BtnOffOpen8";

local szCmd	= [=[
		UiManager:SwitchWindow(Ui.UI_ChanNguyen);
	]=];
	
function uiChanNguyen:OnOpen()	
	
end

function uiChanNguyen:OnButtonClick(szWnd, nParam)
	if (szWnd == uiChanNguyen.BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == uiChanNguyen.BTN_RELOAD) then
		self:Reloadevent();
	elseif (szWnd == uiChanNguyen.BTN_DETECTOR) then
		self:SwitchDetec9();
	elseif (szWnd == uiChanNguyen.BTN_ON_OPEN1) then
		self:OnOpen1();
	elseif (szWnd == uiChanNguyen.BTN_OFF_OPEN1) then
		self:OffOpen1();
	elseif (szWnd == uiChanNguyen.BTN_ON_OPEN2) then
		self:OnOpen2();
	elseif (szWnd == uiChanNguyen.BTN_OFF_OPEN2) then
		self:OffOpen2();
	elseif (szWnd == uiChanNguyen.BTN_ON_OPEN3) then
		self:OnOpen3();
	elseif (szWnd == uiChanNguyen.BTN_OFF_OPEN3) then
		self:OffOpen3();
	elseif (szWnd == uiChanNguyen.BTN_ON_OPEN4) then
		self:OnOpen4();
	elseif (szWnd == uiChanNguyen.BTN_OFF_OPEN4) then
		self:OffOpen4();
-------------------------------------------------------
	elseif (szWnd == uiChanNguyen.BTN_ON_OPEN5) then
		self:OnOpen5();
	elseif (szWnd == uiChanNguyen.BTN_OFF_OPEN5) then
		self:OffOpen5();
	end
end

local nCastState = 0;
local nCastState1 = 0;
local nCastState2 = 0;
local nCastState3 = 0;
local nOldBagHook = 0;
local nOldBagHook1 = 0;
local nOldBagHook2 = 0;
local nOldBagHook3 = 0;
-----------------------------------

local ID_Item = {18,1,1333,1};

---- dòng thứ 1
function uiChanNguyen:OnOpen1()
	local nCount   = me.GetItemCountInBags(unpack(ID_Item));	
	if nCount < 1 then
		me.Msg("Không tìm thấy chân nguyên tu luyện đơn");
	elseif nCastState == 0  then
		nOldBagHook	= Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS, self.OpenChanNguyen, self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=green>Tự sử dụng chân nguyên tu luyện đơn<color>");
		nCastState = 1;
	end

end

function uiChanNguyen:OffOpen1()	
	if nCastState == 1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Dừng sử dụng chân nguyên tu luyện đơn<color>");
		Ui.tbLogic.tbTimer:Close(nOldBagHook);
		nOldBagHook = 0;
		nCastState = 0;
	end
end

function uiChanNguyen:OpenChanNguyen()	
	local nCountFree  = me.CountFreeBagCell();
	local nCurOldBag   = me.GetItemCountInBags(unpack(ID_Item));
	if nCurOldBag < 1 then
		me.Msg("Hành trang đã hết Chân Nguyên Tu Luyện Đơn - Kết Thúc Chương Trình.");
		self:OffOpen1();
	
	else
		local tbFind = me.FindItemInBags(unpack(ID_Item)); --chan nguyên tu luyện đơn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.AnswerQestion(0);
		end
	end
end
-- dòng thứ 2
function uiChanNguyen:OnOpen2()

	local nCount   = me.GetItemCountInBags(unpack(ID_Item));
	
	if nCount < 1 then
		me.Msg("Không tìm thấy chân nguyên tu luyện đơn");
	elseif nCastState1 == 0  then
		nOldBagHook1	= Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS, self.OpenChanNguyen1, self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=green>Tự sử dụng chân nguyên tu luyện đơn<color>");
		nCastState1 = 1;
	end

end

function uiChanNguyen:OffOpen2()	
	if nCastState1 == 1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Dừng sử dụng chân nguyên tu luyện đơn<color>");
		Ui.tbLogic.tbTimer:Close(nOldBagHook1);
		nOldBagHook1 = 0;
		nCastState1 = 0;
	end
end

function uiChanNguyen:OpenChanNguyen1()	
	local nCountFree  = me.CountFreeBagCell();
	local nCurOldBag   = me.GetItemCountInBags(unpack(ID_Item));
	if nCurOldBag < 1 then
		me.Msg("Hành trang đã hết Chân Nguyên Tu Luyện Đơn - Kết Thúc Chương Trình.");
		self:OffOpen2();
	
	else
		local tbFind = me.FindItemInBags(unpack(ID_Item)); --chan nguyên tu luyện đơn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.AnswerQestion(1);
		end
	end
end
-- dòng thứ 3
function uiChanNguyen:OnOpen3()

	local nCount   = me.GetItemCountInBags(unpack(ID_Item));
	
	if nCount < 1 then
		me.Msg("Không tìm thấy chân nguyên tu luyện đơn");
	elseif nCastState2 == 0  then
		nOldBagHook2	= Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS, self.OpenChanNguyen2, self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=green>Tự sử dụng chân nguyên tu luyện đơn<color>");
		nCastState2 = 1;
	end

end

function uiChanNguyen:OffOpen3()	
	if nCastState2 == 1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Dừng sử dụng chân nguyên tu luyện đơn<color>");
		Ui.tbLogic.tbTimer:Close(nOldBagHook2);
		nOldBagHook2 = 0;
		nCastState2 = 0;
	end
end

function uiChanNguyen:OpenChanNguyen2()	
	local nCountFree  = me.CountFreeBagCell();
	local nCurOldBag   = me.GetItemCountInBags(unpack(ID_Item));
	if nCurOldBag < 1 then
		me.Msg("Hành trang đã hết Chân Nguyên Tu Luyện Đơn - Kết Thúc Chương Trình.");
		self:OffOpen3();
	
	else
		local tbFind = me.FindItemInBags(unpack(ID_Item)); --chan nguyên tu luyện đơn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.AnswerQestion(2);
		end
	end
end
--dong thứ 4
function uiChanNguyen:OnOpen4()

	local nCount   = me.GetItemCountInBags(unpack(ID_Item));
	
	if nCount < 1 then
		me.Msg("Không tìm thấy chân nguyên tu luyện đơn");
	elseif nCastState3 == 0  then
		nOldBagHook3	= Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS, self.OpenChanNguyen3, self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=green>Tự sử dụng chân nguyên tu luyện đơn<color>");
		nCastState3 = 1;
	end

end

function uiChanNguyen:OffOpen4()	
	if nCastState3 == 1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Dừng sử dụng chân nguyên tu luyện đơn<color>");
		Ui.tbLogic.tbTimer:Close(nOldBagHook3);
		nOldBagHook3 = 0;
		nCastState3 = 0;
	end
end

function uiChanNguyen:OpenChanNguyen3()	
	local nCountFree  = me.CountFreeBagCell();
	local nCurOldBag   = me.GetItemCountInBags(unpack(ID_Item));
	if nCurOldBag < 1 then
		me.Msg("Hành trang đã hết Chân Nguyên Tu Luyện Đơn - Kết Thúc Chương Trình.");
		self:OffOpen4();
	
	else
		local tbFind = me.FindItemInBags(unpack(ID_Item)); --chan nguyên tu luyện đơn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.AnswerQestion(3);
			
		end
	end
end

-------------------------------------------------------------------------
function uiChanNguyen:CloseUiWindow()
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if (UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1) then
		UiManager:CloseWindow(Ui.UI_REPOSITORY);
	end
	if (nCloseUiTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
		nCloseUiTimerId = 0;
	end
end

function uiChanNguyen:Reloadevent()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\ToolChanNguyen\\script\\window\\Tool_ChanNguyen2.6.lua");
end

local tCmd={"UiManager:SwitchWindow(Ui.UI_ChanNguyen)", "Tool Chân Nguyên", "", "Shift+E", "Shift+E", "Tool Chân Nguyên"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

LoadUiGroup(Ui.UI_ChanNguyen, "cn_setting.ini");