-- �ļ�������menter_def.lua
-- �����ߡ���zhaoyu
-- ����ʱ�䣺2009/10/26 14:39:19
-- ��  ��  ��ʦͽ��������

Esport.Mentor = Esport.Mentor or {};
local Mentor = Esport.Mentor;

Mentor.nGroupTask = 2109;		--ʦͽ����������������
Mentor.nSubDailyTimes = 1;		--�������������Ÿ�������ʣ�����
Mentor.nSubWeeklyTimes = 2; 	--�������������Ÿ�������ʣ�����
Mentor.nSubCurDegree = 3;		--�������������ŵ�ǰ�ܽ���	
Mentor.nSubLastDayTime = 4;		--������������ϴθ��������������ʱ��
Mentor.nSubLastWeekTime = 5;		--������������ϴθ��������������ʱ��

Mentor.RELATIONTYPE_TRAINING = 5;	--ͽ��δ��ʦ��ʦͽ��ϵ�����playerrelation_i.h��ö��KEPLAYERRELATION_TYPE��

Mentor.DAILY_SCHEDULE = 1;	--ÿ���ܽ��븱����������
Mentor.WEEKLY_SCHEDULE = 3;	--ÿ���ܽ��븱����������

Mentor.TEMPLATE_MAP_ID = 1652;
Mentor.MAX_MAP_COUNT = 0;

Mentor.ENTER_X = 1579;
Mentor.ENTER_Y = 3174;

Mentor.LEAVE_MAP = 1;
Mentor.LEAVE_X = 1389;
Mentor.LEAVE_Y = 3102;
Mentor.TIMEOUT = 20;
Mentor.AwardTimer = 5;		--�콱ʱ����ʱΪ5����

Mentor.tbBoom = {18, 1, 521, 1};	--���������GDPL	
Mentor.tbFreeze = {18, 1, 522, 1};	--���������GDPL