-----------------------------------------------------
--Phím tắt plugin
------------------------------------------------------
function Mail:MailFailReason(nReason)
end
function Mail:MailBoxLoadOk(bShowMsg)
	if (bShowMsg and bShowMsg == 1) then
	end
	me.SetMailBoxLoadOk();
	CoreEventNotify(UiNotify.emCOREEVENT_MAIL_LOADED);
	Mail:shortcut();
end

function Mail:shortcut()
	UiShortcutAlias.m_tKeyList =
	{
		
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(0)", "ShortcutItem1", "", "1", "1", "使用 1~10 快捷栏上的物品或者技能" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(1)", "ShortcutItem2", "", "2", "2" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(2)", "ShortcutItem3", "", "3", "3" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(3)", "ShortcutItem4", "", "4", "4" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(4)", "ShortcutItem5", "", "5", "5" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(5)", "ShortcutItem6", "", "6", "6" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(6)", "ShortcutItem7", "", "7", "7" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(7)", "ShortcutItem8", "", "8", "8" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(8)", "ShortcutItem9", "", "9", "9" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(9)", "ShortcutItem10", "", "0", "0" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(-0)", "ShortcutItem-0", "", "RButton", "-0" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(-0)", "ShortcutItem-0", "", "RButton", "-0" },
		{ "Ui(Ui.UI_SHORTCUTBAR):OnUseShortcutObj(-0)", "ShortcutItem-0", "", "RButton", "-0" },
		{ "UiShortcutAlias:ShortcutSkill(0)", "ShortcutSkill0", "", "Q", "F1" },
		{ "UiShortcutAlias:ShortcutSkill(1)", "ShortcutSkill1", "", "W", "F2" },
		{ "UiShortcutAlias:ShortcutSkill(2)", "ShortcutSkill2", "", "E", "F3" },
		{ "UiShortcutAlias:ShortcutSkill(3)", "ShortcutSkill3", "", "A", "F4" },
		{ "UiShortcutAlias:ShortcutSkill(4)", "ShortcutSkill4", "", "S", "F5" },
		{ "UiShortcutAlias:ShortcutSkill(5)", "ShortcutSkill5", "", "D", "F6" },
		{ "UiShortcutAlias:ShortcutSkill(6)", "ShortcutSkill6", "", "Z", "F7" },
		{ "UiShortcutAlias:ShortcutSkill(7)", "ShortcutSkill7", "", "X", "F8", "" },
		{ "UiShortcutAlias:ShortcutSkill(8)", "ShortcutSkill8", "", "", "F9", "" },
		{ "UiShortcutAlias:ShortcutSkill(10)", "ShortcutSkill9", "", "Z", "F10", "" },
		{ "UiShortcutAlias:ShortcutSkill(11)", "ShortcutSkill10", "", "X", "F11", "" },
		{ "UiShortcutAlias:ShortcutSkill(12)", "ShortcutSkill11", "", "", "F12", "" },
		{ "UiManager:OnLButtonDown()", 			"LButton", "", 		"LButton", "LButton", "" },
		{ "UiManager:OnRButtonDown()", 			"RButton", "", 		"RButton", "RButton", "" },
		--------------------------------------------------------------------------------------
		{ "UiManager:SwitchWindow(Ui.UI_PLAYERPANEL)",	"PlayerPanel",	"",	"F1",	"Q",	"Nhân Vật" },
		{ "UiManager:SwitchWindow(Ui.UI_ITEMBOX)",	"ItemBoxPalen",	"",	"F2",	"W",	"Hành Trang" },
		{ "UiManager:SwitchWindow(Ui.UI_FIGHTSKILL)",	"SkillPanel",	"",	"F3",	"E",	"Skill" },
		{ "UiManager:SwitchWindow(Ui.UI_TASKPANEL)",	"TaskPanel",	"",	"F4",	"A",	"Nhiệm Vụ" },
		{ "UiManager:SwitchWindow(Ui.UI_RELATION)",	"RelationPanel","",	"F5",	"S",	"PT" },
		{ "UiManager:SwitchWindow(Ui.UI_KIN)",		"KinPanel",	"",	"F6",	"D",	"Gia Tộc" },		
		{ "UiManager:SwitchWindow(Ui.UI_TONG)",		"TongPanel",	"",	"F7",	"F",	"Bang Hội" },
		{ "UiManager:SwitchWindow(Ui.UI_LIFESKILL)", 	"LifeSkillPanel", "",	"F8",	"B",	"Chế Đồ" },
		{ "UiManager:SwitchWindow(Ui.UI_HELPSPRITE)",	"HelpSprite",	"",	"F12",	"Z",	"Thống Kê", UiShortcutAlias.emKSTATE_INGAME + UiShortcutAlias.emKSTATE_LOCK },
		{ "UiManager:SwitchWindow(Ui.UI_TEXTEXEDITOR)",	"TextExEditor",	"",	"Ctrl+Alt+F12",	"Ctrl+Alt+Z",	"打开文本编辑器", UiShortcutAlias.emKSTATE_INGAME + UiShortcutAlias.emKSTATE_LOCK + UiShortcutAlias.emKSTATE_MENU },
		----------------------------------------------------------------------------------------
		{ "Ui(Ui.UI_POPBAR):ChangeToNextModel()", "SwitchPK", "", "L", "Ctrl+H", "Đổi kiểu PK" },
		{ "AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())", "AutoFight", "", "F", "Ctrl+F", "Tự chiến đấu" },
		{ "UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)", "UI_SUPERMAPLINK_UI", "", "Pageup","Pageup","SuperMapLink" },
		{ "UiManager:SwitchWindow(Ui.UI_TOOLS)", "TOOLS", "", "Home", "Home", "Thanh TOOLS" },
		{ "UiManager:SwitchWindow(Ui.UI_TOOL)", "TOOL", "", "End", "End", "Thanh TOOL" },
		{ "UiManager:SwitchWindow(Ui.UI_AutoQuanDoanh)", "AutoQuanDoanh", "", "Pagedown", "Pagedown", "Thanh AutoQuanDoanh" },
		{ "UiManager:OpenWindow(Ui.UI_REPOSITORY)", "REPOSITORY", "", "Ctrl+K", "Ctrl+K", "Mở Rương"},
		{ "UiManager:SwitchWindow(Ui.UI_AUTOSAY)", "UI_AUTOSAY", "", "N", "N", "Tự động rao"},
		{ "Map.tbAutoAim:FPickUp()", "AutoPickup", "", "Ctrl+A", "Ctrl+A", "Nhặt tất cả" },
		{ "Map.tbAutoEgg:AutoPick()", "AutoPick", "", "Alt+A", "Alt+A", "AutoPick"},
		{ "Map.tbAutoQuanDoanh:AutoPick()", "VaoVAGT", "", "Shift+A", "Shift+A", "VAGT"},
		{ "Map.tbAutoPlayerName:PlayerNameswitch()", "PlayerName", "", "Shift+0", "Shift+0", "Hiện/Ẩn Cấp-Phái"},
		{ "Switch([[horse]])", "SwitchMount", "", "C", "M", "Lên Ngựa" },
		{ "UiManager:SwitchWindow(Ui.UI_IBSHOP)", "UI_IBSHOP", "", "G", "Ctrl+G", "Kỳ Trân Các"},
		{ "Map.tbAutoAim:AutoFollow();", "AutoFollow", "", "Ctrl+Q", "Ctrl+Q", "Theo Sau" }, 
		{ "Map.BuffTC:SwitchBuffTC()", "SwitchBuffTC", "", "Ctrl+X", "Ctrl+X", "Buff Tại Chỗ"},
		{ "UiManager:SwitchWindow(Ui.UI_COMPOSE)", "UI_COMPOSE", "", "Shift+X", "Shift+X", "Ghép HT"},
		{ "Open([[map]], 2)", "SwitchMiniMap", "", "F11", "F11", "MiniMap" },

	};

	UiShortcutAlias:RegisterKeys(1)
	UiShortcutAlias:RegisterAlias();
	local function fnshort()
		UiManager:OpenWindow(Ui.UI_SYSTEM);
		UiManager:CloseWindow(Ui.UI_SYSTEM);
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(36, fnshort);
end