--׼����npc
--�����
--2008.12.29

local tbNpc = Npc:GetClass("td_ready");

function tbNpc:OnDialog()
	local szMsg = "�㲻�μӱ�������\n";
	local tbOpt = {
		{"�ǵģ����м���Ҫ�뿪", self.OnLeave, self},
		{"��㿴��"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnLeave()
	local nMapId, nPosX, nPosY = EPlatForm:GetLeaveMapPos();	
	me.TeamApplyLeave();			--�뿪����
	me.NewWorld(nMapId, nPosX, nPosY);
end

