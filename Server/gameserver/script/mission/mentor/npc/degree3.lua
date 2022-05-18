 ------------------------------------------------------
-- �ļ�������degree3.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2009-10-28 17:46:00
-- ��  ��  ��
------------------------------------------------------

local tbNpc = Npc:GetClass("mentor_degree3");

function tbNpc:OnDialog()
	local tbMiss = Esport.Mentor:GetMission(me);
	local szMsg, tbOpt = "", {};
	if Esport.Mentor:CheckApprentice(me.nId) == 1 and tbMiss.nStep == 1 then
		szMsg = "�����������Ɽ�������ҵ��ˣ���������~~��������һ�ж�����˵�����ˣ�Ҳ�������ǡ�˳���߲�����������������Ҫ�ǳ������ң�������һ����·����Ȼ���ٺ١���";
		tbOpt = 
		{
			{"�������ƨ��үү������ؼ䣬�������أ�������������С����ͷ��", self.OnAccept, self},
			{"�����ǣ�����Ӣ���������꣬�ҵȶ��˴Ӵ˹�˳���������Ĳ�����"},
		}
	else
		return;
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnAccept()
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�����������뱣֤�������пո��Ӵ�ŵ��ߣ�");
		return;
	end
	
	local nRet = me.AddItem(unpack(Esport.Mentor.tbFreeze));
	
	local tbMiss = Esport.Mentor:GetMission(me);
	tbMiss:SendMessage("������������ս��������ʼ��������׼����");

	
	tbMiss:GoNextStep();
end
