------------------------------------------------------
-- �ļ�������degree2.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2009-10-28 17:27:24
-- ��  ��  ��
------------------------------------------------------ 

local tbNpc = Npc:GetClass("mentor_degree2");

function tbNpc:OnDialog()
	local tbMiss = Esport.Mentor:GetMission(me);
	local szMsg, tbOpt = "", {};

	if Esport.Mentor:CheckApprentice(me.nId) == 1 and tbMiss.nStep == 1 then
		szMsg = "���������ǽ�������������������а��������ˡ�������ɱ������Ů����������Թ���Ů����Ҳƽƽ����ȴ��֪���Ķ�ϰ�ˡ�˭Խ�������Ҿ�Խ������ǰ�Ρ�����ħа���������������Ⱥ󱻴�ܵ�ʱ�����5��֮�ڣ����������˾ͻ��Է�֮��˲�������Ѫ�����ǿ�Ҫע���ˣ�";
		tbOpt = 
		{
			{"���ģ��������ɸ㶨", self.OnAccept, self},
			{"���е���ţ����������룡"},
		};
	else
		return;
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnAccept()
	local tbMiss = Esport.Mentor:GetMission(me);
	tbMiss:SendMessage("������������ս��������ʼ��������׼����");
	tbMiss:GoNextStep();
end