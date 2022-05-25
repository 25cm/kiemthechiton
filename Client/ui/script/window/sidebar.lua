
local uiSideBar = Ui:GetClass("sidebar");

uiSideBar.tbTongKinMenu =
{ 
	{ "  Gia tộc  ", 		Ui.UI_KIN	},
	{ "  Bang hội  ",		Ui.UI_TONG	},
	{ "  Chiến đội  ",       Ui.UI_GROUPPANEL  },
};

uiSideBar.tBtn2Group =
{
	{ "BtnPlayer",		Ui.UI_PLAYERPANEL,	"Giao diện nhân vật",		"F1" },
	{ "BtnItemBox",		Ui.UI_ITEMBOX,		"Túi vật phẩm",		"F2" },
	{ "BtnSkill",		Ui.UI_FIGHTSKILL,	"Kỹ năng chiến đấu",		"F3" },
	{ "BtnLifeSkill",	Ui.UI_LIFESKILL,	"Kỹ năng sống",		"F8" },
	{ "BtnTaskPanel",	Ui.UI_TASKPANEL,	"Bảng nhiệm vụ",		"F4" },
	{ "BtnRelation",	Ui.UI_RELATION,		"Quan hệ",		"F5" },
	{ "BtnTeam",		Ui.UI_TEAM,			"Tổ đội",			"P" },
	{ "BtnKin",		    Ui.UI_KIN,			"Gia tộc và bang hội",	"F6, F7" },
	{ "BtnSystem",		Ui.UI_SYSTEM,		"Hệ thống",			"F11" },
};

function uiSideBar:OnButtonClick(szWnd,	nParam)
	for _, tbPair in ipairs(self.tBtn2Group) do
		if (szWnd == "BtnSystem") then
			UiManager:OnReadyEsc();
			break;
		elseif (szWnd == "BtnKin") then
			DisplayPopupMenu(
				self.UIGROUP,
				szWnd,
				3,
				0,
				self.tbTongKinMenu[1][1], 1,
				self.tbTongKinMenu[2][1], 2,
				self.tbTongKinMenu[3][1], 3
			);
			break;
		elseif szWnd == tbPair[1] then
			if nParam ~= 0 then
				UiManager:OpenWindow(tbPair[2]);
			else
				UiManager:CloseWindow(tbPair[2]);
			end
			break;
		end
	end
end

function uiSideBar:OnMouseEnter(szWnd)
	if UiManager.IVER_nSideBarTouch == 0 then
		return;
	end
	if (szWnd == UiManager.WND_MAIN) then
		if (IVER_g_nTwVersion == 0) then
			UiManager:OpenWindow(Ui.UI_SIDEBAR_TIPS);
		end
	end
end

function uiSideBar:OnMouseLeave(szWnd)
	if UiManager.IVER_nSideBarTouch == 0 then
		return;
	end
	if (szWnd == UiManager.WND_MAIN) then
		UiManager:CloseWindow(Ui.UI_SIDEBAR_TIPS);
	end
end

function uiSideBar:WndOpenCloseCallback(szWnd, nParam)
	for _, tbPair in ipairs(self.tBtn2Group) do
		if szWnd == tbPair[2] then
			Btn_Check(self.UIGROUP, tbPair[1], nParam);
			break;
		end
	end
end

function uiSideBar:OnMenuItemSelected(szWnd, nItemId, nParam)
	if szWnd == "BtnKin" then
		if nItemId > 0 and nItemId < 4 then
			UiManager:OpenWindow(self.tbTongKinMenu[nItemId][2]);
		end
	else
		Ui:Output("[ERR] Error! OnMenuItemSelected");
	end
end
