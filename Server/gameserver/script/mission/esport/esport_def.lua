--����������
--�����.���ǽ�
--2008.12.24

--ѩ�̻��ض���
Esport.SNOWFIGHT_ITEM_SINGLEWIN	= 	{18,1,282,1}	--������������һ��

Esport.SNOWFIGHT_ITEM_JINZHOUBAOZHU	= 	{18,1,278,1}	--���䱬��

Esport.SNOWFIGHT_ITEM_EXCOUNT	= 	{18,1,280,1}	--������������Զ����òμӴ���

Esport.SNOWFIGHT_STATE = {
	[1] = 20090114,	--���ʼʱ��
	[2] = 20090213,	--�����ʱ��
	[3] = 20090220,	--��Ʒ��ʧ��
	[4] = 20090121,	--��ֵ�����ú������ʱ�俪ʼ
	[5] = 20090201,	--��ֵ�����ú������ʱ�����
}

--�����ʱ��
Esport.SNOWFIGHT_TIME_SCHTASK = 
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
 2300, 2330,
 0000, 0030,
 };

--������ϵͳ��ض���

--�����������
Esport.TSK_GROUP 			= 2064;		--������
Esport.TSK_ATTEND_TOTAL 	= 1;		--�μ�����
Esport.TSK_ATTEND_WIN 		= 2;		--�μ�ʤ��
Esport.TSK_ATTEND_TIE 		= 3;		--�μ�ƽ��
Esport.TSK_ATTEND_COUNT 	= 4;		--ÿ��ɲμӴ�������¼����
Esport.TSK_ATTEND_DAY 		= 5;		--�ۼ�����
Esport.TSK_ATTEND_EXCOUNT 	= 6;		--����μӴ���
Esport.TSK_ATTEND_AWARD 	= 7;		--������־

Esport.TSK_NEWYEAR_YANHUA 	= 8;		--ÿ����ȡ�����̻���־
Esport.TSK_NEWYEAR_JINZHOUBAOZHU = 9 	--ÿ����ȡһ�����䱬��
Esport.TSK_NEWYEAR_LIANHUA = 10 		--��48�����ú������
Esport.TSK_NEWYEAR_LIANHUA_COUNT = 11 	--ÿ��ʹ�ú��������ȡ�������3��,��¼����
Esport.TSK_NEWYEAR_LIANHUA_DAY 	 = 12 	--ÿ��ʹ�ú��������ȡ�������3��,��¼��
Esport.TSK_NEWYEAR_LIGUAN_DAY 	 = 13 	--ÿ��ֻ�������ˢ������ٴ���ȡһ���������,��¼��

Esport.DEF_POINT_WIN	= 6;		--ʤ��û���
Esport.DEF_POINT_TIE	= 4;		--ƽ��û���
Esport.DEF_POINT_LOST	= 3;		--����û���
Esport.DEF_PLAYER_MAX	= 120;		--һ��׼�������������Ӱ�������̬��ͼ����������
Esport.DEF_PLAYER_TEAM	= 6;		--����һ����༸�ˣ�Ӱ�������̬��ͼ����������
Esport.DEF_PLAYER_LEVEL	= 50;		--��͵ȼ�����
Esport.DEF_PLAYER_COUNT	= 2;		--ÿ��Ĭ�ϿɲμӴ���
Esport.DEF_PLAYER_KEEP_MAX	= 14;	--�����ۼƶ��ٳ�

Esport.DEF_PLAYER_EXP_WIN	= 120;	--ʤ�����120���ӻ�׼����
Esport.DEF_PLAYER_EXP_LOST	= 90;	--ʧ�ܻ�ƽ���90���ӻ�׼����

Esport.DEF_READY_MSG	= "<color=green>������ʣ��ʱ�䣺<color=white>%s<color>"; 
Esport.DEF_READY_TIME	= Env.GAME_FPS * 595;			--׼��ʱ��;
Esport.DEF_READY_TIME2	= Env.GAME_FPS * 5;				--׼��ʱ���������ɢ���飬�ȴ����������ʱ��
Esport.DEF_READY_TIME_ENTER	= Env.GAME_FPS * 10;			--�볡�����ʱ�䣻
Esport.DEF_READY_MAP		= {1504, 1505, 1506};			--׼������ͼID
Esport.DEF_READY_POS		= {{1607,3183}};		--׼������������,����������

Esport.DEF_MAP_TEMPLATE_ID	= 1507;						--��������ͼģ��ID
Esport.DEF_MAP_POS			= {50848/32,102560/32};		--��������������,1589,3205

--�ڴ�洢��
Esport.tbGroupLists  	= Esport.tbGroupLists or {};	--�����б�
Esport.tbPlayerLists 	= Esport.tbPlayerLists or {};  	--ѡ�ֳ��ر�
Esport.nReadyTimerId 	= Esport.nReadyTimerId or 0;	--׼��ʱ��timer
Esport.tbMissionLists 	= Esport.tbMissionLists or {};	--������mission��
Esport.tbDynMapLists	= Esport.tbDynMapLists or {};	--��̬������ͼ

Esport.SKILL_ID_SNOWBALL_ORIGINAL = 1300;

-- Npc ������
-- {[ģ��Id] = skill_id, ... }
Esport.tbTemplateId2Skill = 
	{[3609] = 1301, [3610] = 1302, [3611] = 1304, [3612] = 1306, [3613] = 1308, [3614] = 1309,
     [4290] = 1452, [4291] = 1453, [4292] = 1454, [4293] = 1455, [4294] = 1456,
    };

-- {[color] = trap_id, ... }
Esport.tbTemplateId2Trap = {[3615] = 1315, [3628] = 1316, [3629] = 1317, [3630] = 1318, [3631] = 1320,
    [4295] = 1315, [4296] = 1316, [4297] = 1317, [4298] = 1318, [4299] = 1320,
    };

-- {[ģ��Id] = buff_id, ... }
Esport.tbTemplateId2Buff = 
	{[3616] = 1312, [3624] = 1314, [3625] = 1311, [3626] = 1313,};
	
Esport.tbSkill2Level = 
	{[1301] = 3,	[1302] = 2,	[1304] = 2, [1306] = 2, [1308] = 2, [1309] = 4,
	 [1311] = 10,	[1312] = 1, [1313] = 1, [1314] = 1, [1315] = 3, [1316] = 3, [1317] = 5,
	 [1318] = 3,	[1320] = 3, 
	 [1452] = 1,	[1453] = 1, [1454] = 1, [1455] = 1, [1456] = 1,
	 };

Esport.tbSkill2Time = 
	{[1301] = 30,	[1302] = 30,	[1304] = 30, [1306] = 30, [1308] = 30, [1309] = 30,
	 [1311] = 30,	[1312] = 30, 	[1313] = 30, [1314] = 20, 
	 }; 

Esport.tbSkill2Original = 
	{
	 [1452] = 1451, [1453] = 1451, [1454] = 1451, [1455] = 1451, [1456] = 1451,
	}
	
Esport.tbBlizzardPos1 = 
{
	{50304,102304},
	{50400,103040},
	{50848,102048},
	{50816,103200},
	{51424,102048},
	{51200,102976},
	{51264,102400},
}
	 