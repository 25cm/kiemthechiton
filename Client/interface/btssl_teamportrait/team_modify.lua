local uiTeamPortrait = Ui(Ui.UI_TEAMPORTRAIT);
local bak = uiTeamPortrait.HideTalk;
uiTeamPortrait.HideTalk=function(self)
	uiTeamPortrait:GetMemberBaseData();
	bak(self);
end
