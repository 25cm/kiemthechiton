




local uiSideBarTips = Ui:GetClass("sidebartips");

function uiSideBarTips:OnMouseEnter(szWnd)
	UiManager:CloseWindow(self.UIGROUP);
end

function uiSideBarTips:OnButtonClick(szWnd, nParam)
	UiManager:CloseWindow(self.UIGROUP);
end
