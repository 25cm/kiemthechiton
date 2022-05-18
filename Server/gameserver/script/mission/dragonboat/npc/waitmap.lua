-- �ļ�������waitmap.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-11 16:31:35
-- ��  ��  ��
local tbNpc = Npc:GetClass("dragonboat_waitmap");

function tbNpc:OnDialog()
	local szMsg = "����Ҫ��ʼ�ˣ���׼��������\n";
	local tbOpt = {
		{"���м���Ҫ�뿪û��������", self.OnLeave, self},
		{"��㿴��"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnLeave()
	local nMapId, nPosX, nPosY = EPlatForm:GetLeaveMapPos();
	local tbMCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType());
	if (not tbMCfg) then
		Dialog:Say("��쳣����Ѹ���뿪׼����");
		me.NewWorld(nMapId, nPosX, nPosY);
		return 0;
	end

	local nNpcMapId = him.nMapId;
	local nReadyId = 0;
	for nId, nReadyMapId in pairs(tbMCfg.tbReadyMap) do
		if (nNpcMapId == nReadyMapId) then
			nReadyId = nId;
			break;
		end
	end
	
	if (nReadyId <= 0) then
		Dialog:Say("��쳣����Ѹ���뿪׼����");
		me.NewWorld(nMapId, nPosX, nPosY);
		return 0;
	end
	
	if EPlatForm.ReadyTimerId > 0 then
		if Timer:GetRestTime(EPlatForm.ReadyTimerId) < EPlatForm.DEF_READY_TIME_ENTER then
			Dialog:Say("���������Ͼ�Ҫ��ʼ�ˣ���������û��ǲ�Ҫ�뿪��");
			return 0;
		end
	end
	if EPlatForm.ReadyTimerId <= 0 then
		Dialog:Say("����׼���������쳣���������صǡ�")
		return 0;
	end
	me.TeamApplyLeave();			--�뿪����
	me.NewWorld(nMapId, nPosX, nPosY);
end
