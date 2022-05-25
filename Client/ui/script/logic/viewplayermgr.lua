Ui.tbLogic.tbViewPlayerMgr = {};
local tbViewPlayerMgr = Ui.tbLogic.tbViewPlayerMgr;
tbViewPlayerMgr.tbPlayerInfo = {};


function tbViewPlayerMgr:Init()
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_VIEWPLAYER, 		self.OnViewPlayer, self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_VIEW_NPC_SKILL, 	self.OnViewPlayerSkill, self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_VIEW_PLAYERPARTNER, self.OnViewPlayerPartner, self);
end

function tbViewPlayerMgr:OnViewPlayer(szRoleName, nLevel, nPkValue, nFaction, bSex, szMateName, nPortrait)
	local tbTemp = me.GetTempTable("Npc");
	local nNpcId = 0;
	if (tbTemp.tbViewPlayer) then
		nNpcId = tbTemp.tbViewPlayer.nNpcId or 0;
		tbTemp.tbViewPlayer.nNpcId = 0;
	end
	
	UiManager:OpenWindow(Ui.UI_VIEWPLAYER, szRoleName, nLevel, nPkValue, nFaction, bSex, szMateName, nPortrait, nNpcId);
end

function tbViewPlayerMgr:OnViewPlayerSkill()
	Ui(Ui.UI_VIEWPLAYER):OnViewPlayerSkill();
end

function tbViewPlayerMgr:OnViewPlayerPartner()
	Ui(Ui.UI_VIEWPLAYER):OnUpdatePartner();
end