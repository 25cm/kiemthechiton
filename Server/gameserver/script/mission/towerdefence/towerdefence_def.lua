--����������
--�����.���ǽ�
--2008.12.24
TowerDefence.SNOWFIGHT_STATE = {
	[1] = 20100330,	--���ʼʱ��
	[2] = 20100411,	--�����ʱ��
}

--�����ʱ��
TowerDefence.SNOWFIGHT_TIME_SCHTASK = 
{
 1000, 1030, 
 1100, 1130,
 1200, 1230,
 1300, 1330,
 1400, 1430,
 1500, 1530,
 1600, 1630,
 1700, 1730,
 1800, 1830,
 1900, 1930,
 2000, 2030,
 2100, 2130,
 2200, 2230,
 };

--������ϵͳ��ض���

--�����������
TowerDefence.TSK_GROUP 			= 2118;		--������
TowerDefence.TSK_ATTEND_TOTAL 	= 1;			--�μ�����
TowerDefence.TSK_ATTEND_WIN 	= 2;			--�μ�ʤ��
TowerDefence.TSK_ATTEND_TIE 		= 3;			--�μ�ƽ��
TowerDefence.TSK_ATTEND_COUNT 	= 4;			--ÿ��ɲμӴ�������¼����
TowerDefence.TSK_ATTEND_DAY 		= 5;		--�ۼ�����
TowerDefence.TSK_ATTEND_EXCOUNT 	= 6;		--����μӴ���
TowerDefence.TSK_ATTEND_AWARD 	= 7;		--������־

TowerDefence.TSK_NEWYEAR_YANHUA 			= 8;	--ÿ����ȡ�����̻���־
TowerDefence.TSK_NEWYEAR_JINZHOUBAOZHU 	= 9; 	--ÿ����ȡһ�����䱬��
TowerDefence.TSK_NEWYEAR_LIANHUA 			= 10; --��48�����ú������
TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT = 11; 	--ÿ��ʹ�ú��������ȡ�������3��,��¼����
TowerDefence.TSK_NEWYEAR_LIANHUA_DAY 	 = 12; 	--ÿ��ʹ�ú��������ȡ�������3��,��¼��
TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL 	 = 13; 	--�ܹ�ʹ�üҴ������ߵ�
TowerDefence.TSK_MONEY 	 = 14 ;					--��һ�õľ���
TowerDefence.TSK_AWARD_FINISH	= 15;				--���ս���

TowerDefence.DEF_POINT_WIN	= 9;			--ʤ��û���
TowerDefence.DEF_POINT_TIE	= 5;			--ƽ��û���
TowerDefence.DEF_POINT_LOST	= 3;			--����û���
TowerDefence.DEF_PLAYER_MAX	= 120;	--һ��׼�������������Ӱ�������̬��ͼ����������
TowerDefence.DEF_PLAYER_TEAM	= 4;		--����һ����༸�ˣ�Ӱ�������̬��ͼ����������
TowerDefence.DEF_PLAYER_LEVEL	= 60;		--��͵ȼ�����
TowerDefence.DEF_PLAYER_COUNT	= 2;		--ÿ��Ĭ�ϿɲμӴ���
TowerDefence.DEF_PLAYER_KEEP_MAX	= 14;	--�����ۼƶ��ٳ�

TowerDefence.DEF_READY_MSG	= "<color=green>������ʣ��ʱ�䣺<color=white>%s<color>"; 
TowerDefence.DEF_READY_TIME	= Env.GAME_FPS * 270;			--׼��ʱ��;
TowerDefence.DEF_READY_TIME2	= Env.GAME_FPS * 10;				--׼��ʱ���������ɢ���飬�ȴ����������ʱ��
TowerDefence.DEF_READY_TIME_ENTER	= Env.GAME_FPS * 10;			--�볡�����ʱ�䣻
TowerDefence.DEF_READY_MAP		= {583, 584, 585};			--׼������ͼID
TowerDefence.DEF_READY_POS		= {{1619,3217}};		--׼������������,����������

TowerDefence.DEF_MAP_TEMPLATE_ID	= 586;						--��������ͼģ��ID
TowerDefence.DEF_MAP_POS			= {50848/32,102560/32};		--��������������,1589,3205
TowerDefence.WINNER_BOX		={	{18, 1, 630, 1},
								{18, 1, 631, 1},
								{18, 1, 632, 1},
								{18, 1, 632, 1},
							};			--��ʤ���齱������
--�ڴ�洢��
TowerDefence.tbGroupLists  	= TowerDefence.tbGroupLists or {};	--�����б�
TowerDefence.tbPlayerLists 	= TowerDefence.tbPlayerLists or {};  	--ѡ�ֳ��ر�
TowerDefence.nReadyTimerId 	= TowerDefence.nReadyTimerId or 0;	--׼��ʱ��timer
TowerDefence.tbMissionLists 	= TowerDefence.tbMissionLists or {};	--������mission��
TowerDefence.tbDynMapLists	= TowerDefence.tbDynMapLists or {};	--��̬������ͼ
TowerDefence.tbMpaTrapPoint	= TowerDefence.tbMpaTrapPoint or {};	--������ͼtrap��
TowerDefence.tbTowerPosition= TowerDefence.tbTowerPosition or {};	--tower�����	
TowerDefence.NPC_TYPE_ID	= TowerDefence.NPC_TYPE_ID or {};	--mission ˢ�ֵľ������ñ�
TowerDefence.NPC_SKILL	= TowerDefence.NPC_SKILL or {};		--�����Ӧ���ͷż���id
TowerDefence.NPC_AWORD	= TowerDefence.NPC_AWORD or {};	--ÿ�ֶֹ�Ӧ�Ļ��ֺ;�����

TowerDefence.SKILL_ID_ORIGINAL = 1616;						--��ʼ���ܲ�ʹ����

--ÿ��ֲ���Ӧ������id
TowerDefence.TOWERID = {	[1] = {6667, 6668,6669},				--��
						[2] = {6670,6671,6672},				--ľ
						[3] = {6673,6674,6675},				--ˮ
						[4] = {6676,6677,6678},				--��
						[5] = {6679,6680,6681},};				--��

--���ս���
TowerDefence.AWARD_FINISH = 
{
	{1,  {18,1,553,1}},
	{10, {18,1,114,10}},
	{100, {18,1,114,9}},
	{1000,{18,1,114,8}},
}
	 