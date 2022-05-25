local tbRepository = Ui(Ui.UI_REPOSITORY);
local tbObject = Ui.tbLogic.tbObject;
local self		= tbRepository;
local BTN_CLOSE			= "BtnClose";
local OBJ_REPOSITORY 	= "ObjRepository";
local BTN_LEFTPAGE		= "BtnLeftPage";
local BTN_RIGHTPAGE		= "BtnRightPage";
local BTN_TAKEMONEY		= "BtnTakeMoney";
local BTN_SAVEMONEY		= "BtnSaveMoney";
local TXT_PAGENUM		= "TxtPageNum";
local TXT_MONEY			= "TxtMoney";
local BTN_SORTITEM      = "BtnSortItem";

local PAGE2ROOM =
{
	Item.ROOM_REPOSITORY,
	Item.ROOM_EXTREP1,
	Item.ROOM_EXTREP2,
	Item.ROOM_EXTREP3,
	Item.ROOM_EXTREP4,
	Item.ROOM_EXTREP5,
};


local tbRepCont = { bUse = 0, nRoom = Item.ROOM_REPOSITORY, bSendToGift = 1};

function tbRepository:OnOpen()
	self:RefreshExtRepState(me.nExtRepState);
	self:UpdatePageNumber();
	self:UpdateMoney();
	self.tbRepCont.nRoom = PAGE2ROOM[self.nCurPage]
	self.tbRepCont:UpdateRoom();
	UiManager:OpenWindow(Ui.UI_ITEMBOX);
	UiManager:SetUiState(UiManager.UIS_OPEN_REPOSITORY);
end

function tbRepository:OnButtonClick(szWnd, nParam)
	if (szWnd == BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == BTN_TAKEMONEY) then
		local tbParam = {};
		tbParam.tbTable	   = self;
		tbParam.fnAccept   = self.TakeMoneyAccept;
		tbParam.szTitle	   = "Rút tiền";
		tbParam.varDefault = 0;
		tbParam.nType	   = 0;
		tbParam.tbRange    = { 0, me.nSaveMoney };
		UiManager:OpenWindow(Ui.UI_TEXTINPUT, tbParam);
	elseif (szWnd == BTN_SAVEMONEY) then
		local tbParam = {};
		tbParam.tbTable	   = self;
		tbParam.fnAccept   = self.SaveMoneyAccept;
		tbParam.szTitle	   = "Cất tiền";
		tbParam.varDefault = 0;
		tbParam.nType	   = 0;
		tbParam.tbRange    = { 0, me.nCashMoney };
		UiManager:OpenWindow(Ui.UI_TEXTINPUT, tbParam);
	elseif (szWnd == BTN_LEFTPAGE) then
		if self.nCurPage <= 1 then
			return;
		end
		self.nCurPage = self.nCurPage - 1;
		self.tbRepCont.nRoom = PAGE2ROOM[self.nCurPage];
		self:UpdatePageNumber();
		self.tbRepCont:UpdateRoom();
	elseif (szWnd == BTN_RIGHTPAGE) then
		if self.nCurPage >= self.nMaxPage then
			return;
		end
		self.nCurPage = self.nCurPage + 1;
		self.tbRepCont.nRoom = PAGE2ROOM[self.nCurPage];
		self:UpdatePageNumber();
		self.tbRepCont:UpdateRoom();
	elseif (szWnd == BTN_SORTITEM) then
		Player:ItemSort_SortRepository();
    end
end


tbRepository.RefreshExtRepState = function(self, nPageNumber)
	self.nMaxPage = nPageNumber + 1;
	self:UpdatePageNumber();
end




function tbRepository:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_OPEN_REPOSITORY,		self.OpenRepository },
		{ UiNotify.emCOREEVENT_EXTREPSTATE_CHANGED,	self.RefreshExtRepState },
		{ UiNotify.emCOREEVENT_MONEY_CHANGED, 		self.UpdateMoney },
		{ UiNotify.emUIEVENT_OBJ_STATE_USE,		self.StateRecvUse},	
	};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbRepCont:RegisterEvent());
	return tbRegEvent;
end

LoadUiGroup(Ui.UI_REPOSITORY, "repository.ini");
