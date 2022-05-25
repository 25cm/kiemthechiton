local tbMgr = UiManager;
local tbMgrkg = 0;
function tbMgr:OnPressESC()

	if (self:WindowVisible(Ui.UI_ITEMBOX) == 1) or (self:WindowVisible(Ui.UI_TONG) == 1) or (self:WindowVisible(Ui.UI_LIFESKILL) == 1) or (self:WindowVisible(Ui.UI_HELPSPRITE) == 1) or (self:WindowVisible(Ui.UI_AUCTIONROOM) == 1) or (self:WindowVisible(Ui.UI_IBSHOP) == 1) or (self:WindowVisible(Ui.UI_TEXTEXEDITOR) == 1) or (self:WindowVisible(Ui.UI_MSGINFO) == 1) or (self:WindowVisible(Ui.UI_CALENDAR) == 1) or (self:WindowVisible(Ui.UI_WORLDMAP_SUB) == 1) or (self:WindowVisible(Ui.UI_WORLDMAP_AREA) == 1) or (self:WindowVisible(Ui.UI_WORLDMAP_GLOBAL) == 1) or (self:WindowVisible(Ui.UI_WORLDMAP_DOMAIN) == 1) then
                tbMgrkg = 1;
	end

	self:CloseWindow(Ui.UI_WORLDMAP_SUB);
	self:CloseWindow(Ui.UI_WORLDMAP_AREA);
	self:CloseWindow(Ui.UI_WORLDMAP_GLOBAL);
	self:CloseWindow(Ui.UI_WORLDMAP_DOMAIN);
	self:CloseWindow(Ui.UI_TEXTINPUT);
	self:CloseWindow(Ui.UI_JBEXCHANGE);
	self:CloseWindow(Ui.UI_IBSHOPCART);
	self:CloseWindow(Ui.UI_IBSHOP);
	self:CloseWindow(Ui.UI_HISTORY);
	self:CloseWindow(Ui.UI_TONG);
	self:CloseWindow(Ui.UI_LIFESKILL);
	self:CloseWindow(Ui.UI_HELPSPRITE);
	self:CloseWindow(Ui.UI_ITEMBOX);
	self:CloseWindow(Ui.UI_EXTBAGS);
	self:CloseWindow(Ui.UI_AUCTIONROOM);
	self:CloseWindow(Ui.UI_VIEW_FIGHTSKILL);
	self:CloseWindow(Ui.UI_PRODUCE);
	self:CloseWindow(Ui.UI_TEXTEXEDITOR);
	self:CloseWindow(Ui.UI_MSGINFO);
	self:CloseWindow(Ui.UI_CALENDAR);

	if (CloseWndsInGame() == 0) and (tbMgrkg == 0) then
		if (self:WindowVisible(Ui.UI_SKILLPROGRESS) == 0) then
			self:SwitchWindow(Ui.UI_SYSTEM);
		else
			me.BreakProcess();
		end
	end
        tbMgrkg = 0;
end

function tbMgr:OnEnterGame()     
	self:SwitchWindow(Ui.UI_TOOLS); --luôn hiện thanh TOOLS khi vào game
	self:SwitchWindow(Ui.UI_TOOL); 
	self:SwitchUiModel(0);
	ForbitGameSpace(0);
	self:OpenWindow(Ui.UI_NEWSMSG);
	self:OpenWindow(Ui.UI_SERVERSPEED);
	self.nEnterTime	= GetTime();
	self.Unlock_Lock=1;   --bảng mở khóa
if  self.Unlock_Lock==1 then 
		self:OpenWindow(Ui.UI_UNLOCK);
	end
	Ui.tbLogic.tbPassPodTime:OnStart();
	Ladder:ClearLadder();
	Player.tbOnlineExp:OnStartCheckOnlineExpState();
	Ui(Ui.UI_SYSTEM)._no_name_or_life = 1;-- Sẽ đóng cửa để tắt tính năng hiển thị phần của máu
	Ui(Ui.UI_SYSTEM):Update();
	Ui(Ui.UI_SKILLBAR)._disable_switch_skill = nil;
	Ui.tbLogic.tbMsgChannel:LoadChannelSetting();
end
