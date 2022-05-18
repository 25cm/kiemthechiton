-- �ļ�������degree1.lua
-- �����ߡ���zhaoyu
-- ����ʱ�䣺2009/10/26 14:40:08
-- ��  ��  ������1����ͷnpc

local tbNpc = Npc:GetClass("mentor_degree1");

function tbNpc:OnDialog()
	local tbMiss = Esport.Mentor:GetMission(me);
	local szMsg;
	local tbOpt;

	if (Esport.Mentor:CheckApprentice(me.nId) == 1 and tbMiss.nStep == 1) then
		szMsg = "׼���ý�����ս����";
		tbOpt = 
		{
			{"��ʼ��", self.OnStartGame, self},
			{"���ٿ���"},
		};
	elseif Esport.Mentor:CheckApprentice(me.nId) == 1 and tbMiss.nStep == 3 then
		szMsg = "�����أ�ǰ���·���������Σ�գ���ʦ�����ҹ�ȥ�ɣ���������������׷�ң�ͽ����<color=red>��������<color>���ذ�";
		tbOpt = 
		{
			{"��ðɣ�", self.OnStartProtect, self},
			{"�粻�š�����"},
		}
	elseif Esport.Mentor:CheckMaster(me.nId) == 1 then
		szMsg = "�Ҿ�����ͽ�ܱ��㳤��˧������ͽ��������˵��~";
		tbOpt = 
		{
			{"�����Ի�"},
		};
	else
		szMsg = "��Ҫ�����磬��ֻ�Ǵ�˵����Ҫ�����㣬��������Ѫ��";
		tbOpt = 
		{
			{"��Ѫ"},
		};
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnStartGame()
	local tbMiss = Esport.Mentor:GetMission(me);
	tbMiss:SendMessage("������������ս��������ʼ��������׼����");
	tbMiss:GoNextStep();
end

function tbNpc:OnStartProtect()
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�����������뱣֤�������пո��Ӵ�ŵ��ߣ�");
		return;
	end
	
	local nRet = me.AddItem(unpack(Esport.Mentor.tbBoom));
		
	local tbMiss = Esport.Mentor:GetMission(me);
	tbMiss:GoNextStep();
end