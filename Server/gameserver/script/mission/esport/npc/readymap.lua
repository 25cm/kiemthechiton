--׼����npc
--�����
--2008.12.29

local tbNpc = Npc:GetClass("esport_yanruoxue2");

function tbNpc:OnDialog()
	local szMsg = "C��c tr?n ?��nh b��ng tuy?t r?t th�� v?. Ruoxue ph?i ch?i v?i m?i ng??i trong m?t th?i gian d��i m?i ng��y. Tr�� ch?i s?p b?t ??u, b?n ?? s?n s��ng ch?a? \n";
	local tbOpt = {
		{"T?i ?ang v?i v��ng r?i ?i v�� kh?ng th? ch?i", self.OnLeave, self},
		{"K?t th��c"},
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
			Dialog:Say("ѩ�����Ͼ�Ҫ��ʼ�ˣ���������û��ǲ�Ҫ�뿪��");
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

