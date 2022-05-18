--��������֮��mission
-- �ļ�������towerdefence_mission.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-05 17:21:32
-- ��  ��  ��

Require("\\script\\mission\\towerdefence\\towerdefence_def.lua")

TowerDefence.Mission = TowerDefence.Mission or Mission:New();
local tbMission = TowerDefence.Mission;

-- Mission�ó���
tbMission.TIME_FPS_REFRESH_NPC  		= Env.GAME_FPS * 1; 		--ˢһ������npcʱ����
tbMission.TIME_FPS_REFRESH_WAIT		= Env.GAME_FPS * 1; 		--ÿ����ʼ��ʾ�ȴ�ʱ��
tbMission.TIME_FPS_REST	  			= Env.GAME_FPS * 30; 		--��ʼ�����ȴ�ʱ��
tbMission.TIME_FPS_PLAY_TIME	  	= Env.GAME_FPS * 540;		--��ʱ��
tbMission.NPC_CHANGE_TIME			= Env.GAME_FPS * 14;		--ÿ�����������һ�μ����ͷű��Ӧ���ͷ�ʱ��
tbMission.NPC_TOWERUPDATA_TIME	= Env.GAME_FPS * 2;		--ÿ������������һ����

tbMission.NPC_MOVE_RAD				= 2;						--��·������İ뾶
tbMission.NPC_REFRESH_COUNT_ALL	= 12;						--�ܹ�ˢ���ٲ���
tbMission.MONEY_START				= 150;						--ϵͳ��ʼ����ҵľ�����Ŀ
tbMission.TOWERPOSITIONRAD			= 3;						--ÿ�����ѵı߳���һ��
tbMission.CASTSKILL_GROUP_NUM		= 4;						--�������Ϊ������ʩ�ż���

tbMission.REFRESH_BOSS_POINT		= {50848,	104672};			--ˢboss������
tbMission.MONEY_PER					= {50,80};					--ÿ����ϵͳ�ӵľ�����Ŀ
tbMission.NPC_CASTSKILL_TIME		= {2,3,4,5,6,7,8};				--ÿ�����Ӧ�����ͷż��ܵ�ʱ��(��)
tbMission.TOWER_MIN_LIFE_UP			= {[1] = 100, [2] = 200, [3] = 300};	--��������һ����Ҫ��Ѫ��ֵ
tbMission.PLAYER_SKILL_ID 			= {1611,1612,1613,1614,1615};		--��ҳ�ʼ�����һ�����ܣ�������Ҹ��Ķ���һ����
tbMission.PLAYER2NPC_SKILL_ID		= {1606,1607,1608,1609,1610};		--��ҳ�����ļ���
tbMission.tbFirst_Title 					= {6, 21, 1, 0};		----�ƺŽ������ػ���Ӣ����ʱ��һ����
tbMission.tbFirst_Title_Final 				= {6, 22, 1, 0};		----�ƺŽ������ػ�֮��û�зŹ�һ���֣�-todo
local tbMisEventList = 
	{
		{"countdown",		1,	"OnCountDown"},
		{"play",		tbMission.TIME_FPS_REST,		"OnPlay"},
		{"endplay", 		tbMission.TIME_FPS_PLAY_TIME, 		"OnEndPlay"},
		{"end", 		tbMission.TIME_FPS_REST, 		"OnEnd"},
	};
	
--����id��Ӧ�ĵ����
tbMission.szNpc_droprate ={
		[6682] = {"\\setting\\npc\\droprate\\qingming\\qingming.txt",1},
		[6698] = {"\\setting\\npc\\droprate\\qingming\\qingming.txt",1},
		[6701] = {"\\setting\\npc\\droprate\\qingming\\qingming.txt",1},
		[6704] = {"\\setting\\npc\\droprate\\qingming\\qingming.txt",1},
		[6683] = {"\\setting\\npc\\droprate\\qingming\\qingming_jingying.txt",1},
		[6699] = {"\\setting\\npc\\droprate\\qingming\\qingming_jingying.txt",1},
		[6702] = {"\\setting\\npc\\droprate\\qingming\\qingming_jingying.txt",1},
		[6705] = {"\\setting\\npc\\droprate\\qingming\\qingming_jingying.txt",1},
		[6684] = {"\\setting\\npc\\droprate\\qingming\\qingming_shouling.txt",1},
		[6700] = {"\\setting\\npc\\droprate\\qingming\\qingming_shouling.txt",1},
		[6703] = {"\\setting\\npc\\droprate\\qingming\\qingming_shouling.txt",1},
		[6706] = {"\\setting\\npc\\droprate\\qingming\\qingming_shouling.txt",1},
		[6685] = {"\\setting\\npc\\droprate\\qingming\\qingming_boss.txt",24},
	};   
	
tbMission.tbCallback2ContextFun = 
	{		
		OnPlay		= "SetPlayContext",
		OnCountDown		= "SetCountDownContext",
		OnEndPlay		= "SetEndContext"
	};
	
tbMission.TRANSFORM_SKILL_ID 		= 1620; -- ������
tbMission.NPC_TYPE			= {	[6682] = {"С��", 1},
								[6698] = {"С��", 1},
								[6701] = {"С��", 1},
								[6704] = {"С��", 1},
								[6683] = {"<color=blue>��Ӣ<color>", 2},
								[6699] = {"<color=blue>��Ӣ<color>", 2},
								[6702] = {"<color=blue>��Ӣ<color>", 2},
								[6705] = {"<color=blue>��Ӣ<color>", 2},
								[6684] = {"<color=purple>����<color>",3}, 
								[6700] = {"<color=purple>����<color>",3},
								[6703] = {"<color=purple>����<color>",3},
								[6706] = {"<color=purple>����<color>",3},
								[6685] = {"<color=gold>BOSS<color>",4},										
							};
tbMission.ITEM_SHOTCUT				= {{18,1,626,1,0},{18,1,627,1,0},{18,1,621,1,0},{18,1,622,1,0},{18,1,623,1,0},{18,1,624,1,0},{18,1,625,1,0}}; --��Ʒ�����

tbMission.tbNpcGenPos 		= {};		--ˢNPC��λ�� {x,y}
tbMission.tbNpcMoveLeft		= {};		--��·����·��
tbMission.tbNpcMoveRight	= {};		--��·����·��
tbMission.tbBOSSMove		= {};		--bossAI·��
tbMission.tbTowerPosition	= {};		--��td������
tbMission.tbPosition_fu		= {};		--ˢ��������

local tbGenPox = Lib:LoadTabFile("\\setting\\mission\\towerdefence\\npc_refresh_pos.txt");
local tbMove_Lift = Lib:LoadTabFile("\\setting\\mission\\towerdefence\\npc_move_left.txt");
local tbMove_Right = Lib:LoadTabFile("\\setting\\mission\\towerdefence\\npc_move_right.txt");
local tbBossMove = Lib:LoadTabFile("\\setting\\mission\\towerdefence\\boss_move.txt");
tbMission.tbTowerPosition = Lib:LoadTabFile("\\setting\\mission\\towerdefence\\td_position.txt");
local tbPosition_fu = Lib:LoadTabFile("\\setting\\mission\\towerdefence\\fu_position.txt");

for _, pos in ipairs(tbGenPox) do
    table.insert(tbMission.tbNpcGenPos, {tonumber(pos["TRAPX"])/32, tonumber(pos["TRAPY"])/32});
end

for _, pos in ipairs(tbMove_Lift) do
    table.insert(tbMission.tbNpcMoveLeft, {tonumber(pos["TRAPX"]), tonumber(pos["TRAPY"])});
end

for _, pos in ipairs(tbMove_Right) do
    table.insert(tbMission.tbNpcMoveRight, {tonumber(pos["TRAPX"]), tonumber(pos["TRAPY"])});
end

for _, pos in ipairs(tbBossMove) do
    table.insert(tbMission.tbBOSSMove, {tonumber(pos["TRAPX"]), tonumber(pos["TRAPY"])});
end

for _, pos in ipairs(tbPosition_fu) do
    table.insert(tbMission.tbPosition_fu, {tonumber(pos["TRAPX"]), tonumber(pos["TRAPY"])});
end

--�����׶ε���ʱ
function tbMission:SetEndContext(pPlayer, nTime)
	nTime = nTime or self.TIME_FPS_REST;	
	Dialog:SetBattleTimer(pPlayer, "<color=green>������������ʱ��<color=white>%s<color>\n", nTime);	
	Dialog:ShowBattleMsg(pPlayer, 1, 0);
end

-- ��ʼ����ʱ
function tbMission:OnCountDown()	
	for _, pPlayer in pairs(self:GetPlayerList()) do		
		self:SetCountDownContext(pPlayer);	
		Dialog:SendBlackBoardMsg(pPlayer, "����Ҫ�����ˣ���ҿ�����׼������");
	end
	self:GenerateAndSendMsg();
end

--��ʼˢ�ֵ���ʱ
function tbMission:SetPlayContext(pPlayer, nTime)
	nTime = nTime or self.TIME_FPS_PLAY_TIME;	
	Dialog:SetBattleTimer(pPlayer, "<color=green>����ʱ�䣺<color=white>%s<color>\n", nTime);
end

-- ������Ϸ״̬�Ļص�
function tbMission:OnPlay()
	self.nResfreshNum = 1;
	for _, pPlayer in pairs(self:GetPlayerList()) do
		self:SetPlayContext(pPlayer);
	end	
	self.tbChangeGroupTimer = self:CreateTimer(self.NPC_CHANGE_TIME, self.ChangeTime, self);
	self.UpDataTowerTimer = self:CreateTimer(self.NPC_TOWERUPDATA_TIME, self.UpDataTower, self);
	self:CastSkill();
	self:RefreshNpc(self.nResfreshNum);
end

-- ���ؽ׶ν����ص�������ʱ������Ϸ
function tbMission:OnEndPlay()
	self:BroadcastBlackBoardMsg(string.format("����������",nNumber));
	self:CloseAllTimer();
	self:ClearAllNpc();
	--ˢ���ұߵ���ʱ	
	for _, pPlayer in pairs(self:GetPlayerList()) do
		self:SetEndContext(pPlayer);
	end
	--ˢ�½���
	self:GenerateAndSendMsg();
	--����嵽tbResult��
	for nGroupId, nGrade in pairs(self.tbGrade) do
		if nGrade >= 0 then
			table.insert(self.tbResult, {nGroupId, nGrade});
		end
	end
	local sort_cmp = function (tb1, tb2)
		return tb1[2] > tb2[2];
	end
	table.sort(self.tbResult, sort_cmp);
	--�����������
	--self:SetAword();
	--�ӳ����⻷��û�зŹ�һ�����
--	if self.nLostNpc == 0 and self.ISBossOver == 1 and self.tbGrade_player[1] then
--		local szFirstName = self.tbGrade_player[1][1];
--		local pPlayer = KPlayer.GetPlayerByName(szFirstName);
--		if pPlayer and self:GetPlayerGroupId(pPlayer) >= 0 then
--			pPlayer.AddTitle(unpack(self.tbFirst_Title_Final));
--			pPlayer.SetCurTitle(unpack(self.tbFirst_Title_Final));
--		end
--	end
end

-- ��Ϣ
function tbMission:OnRest()
	for _, pPlayer in pairs(self:GetPlayerList()) do
		self:SetRestContext(pPlayer);
	end
end


--��ʼǰ����ʱ��ˢ�Ҳ����
function tbMission:SetCountDownContext(pPlayer, nTime)
	nTime = nTime or self.TIME_FPS_REST;	
	Dialog:SetBattleTimer(pPlayer, "\n<color=green>������ʼ����ʱ��<color=white>%s<color>",  nTime);
	Dialog:SendBattleMsg(pPlayer, "");	
	Dialog:ShowBattleMsg(pPlayer, 1, 0);
end

function tbMission:OnGameTimeOver()
	return 0;
end

--����ʩ�ż��ܵ�ʱ���
function tbMission:ChangeTime()
	Lib:SmashTable(self.NPC_CASTSKILL_TIME);
end

--����ʱ���ͷż���
function tbMission:CastSkill()
	for i = 1 , self.CASTSKILL_GROUP_NUM do		
		self.tbCastSkillTimer[i] = self:CreateTimer(Env.GAME_FPS * self.NPC_CASTSKILL_TIME[i], self.CastSkillEx, self, i);
	end
end

--�ͷż���
function tbMission:CastSkillEx(nId)
	for _, nNpcId in ipairs(self.tbCastSkillGroup[nId]) do
		local pNpc = KNpc.GetById(nNpcId);
		if pNpc and TowerDefence.NPC_SKILL[pNpc.nTemplateId] then
			pNpc.CastSkill(TowerDefence.NPC_SKILL[pNpc.nTemplateId], 1, 1, 1);
		end
	end
	return Env.GAME_FPS * self.NPC_CASTSKILL_TIME[nId];
end

--�ر����е�timer
function tbMission:CloseAllTimer()
	if self.tbReadyTimers then
		self.tbReadyTimers:Close();
		self.tbReadyTimers = nil;
	end
	
	if self.tbRefreshNpcTimers then
		self.tbRefreshNpcTimers:Close();
		self.tbRefreshNpcTimers = nil;
	end
		
	if self.tbChangeGroupTimer then
		self.tbChangeGroupTimer:Close();
		self.tbChangeGroupTimer = nil;		
	end
	for i = 1 ,#self.tbCastSkillTimer  do
		self.tbCastSkillTimer[i]:Close();
		self.tbCastSkillTimer[i] = nil;
	end
	if self.UpDataTowerTimer then
		self.UpDataTowerTimer:Close();
		self.UpDataTowerTimer = nil;
	end
end

--�����������߹����ܵ��յ�ص�(nTypeΪ0��ʾ�������˴�����)
function tbMission:OnDeathNpc(nNpcId, nKillerId, nType)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end
	local nTemplateId = pNpc.nTemplateId;
	if nType and nType == 0 then
		if nKillerId and self.tbTD[nKillerId] then
			self:AddAword(nTemplateId, nKillerId);
			if self.szNpc_droprate and self.szNpc_droprate[nTemplateId] then
				pNpc.DropRateItem(self.szNpc_droprate[nTemplateId][1], self.szNpc_droprate[nTemplateId][2], -1, -1, 0);
			end
		end
	else
		self.nLostNpc = self.nLostNpc + 1;
	end
	if self.tbRefreshNpcId[nNpcId] then
		self:DelRefreshNpc(nNpcId);
	end
end

--�������ｱ��
function tbMission:AddAword(nTemplateId, nKillerId)
	if  not self.tbTD[nKillerId] then
		return;
	end
	local nPlayerId = self.tbTD[nKillerId][1];
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer  then
		return;
	end	
	local nGroupId = self:GetPlayerGroupId(pPlayer);
	if nGroupId <= 0 then
		return;
	end
	self.tbGrade[nGroupId] = self.tbGrade[nGroupId] + TowerDefence.NPC_AWORD[nTemplateId][1];	
	pPlayer.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY, 
		          pPlayer.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY) + TowerDefence.NPC_AWORD[nTemplateId][2]);
	for i, tbPlayerEx in ipairs(self.tbGrade_player) do
		if tbPlayerEx[1] == pPlayer.szName then
			self.tbGrade_player[i][2] = self.tbGrade_player[i][2] +  TowerDefence.NPC_AWORD[nTemplateId][1];
		end
	end
	self:GenerateAndSendMsg();
end

function tbMission:GetGroupName(nGroup)
	return self.tbGroupName[nGroup] or tostring(nGroup);
end

-- ÿ�������
function tbMission:AddGroupName(pPlayer, nGroupId, szGroupName)
	if szGroupName then
		self.tbGroupName[nGroupId] = szGroupName;
		return;
	end
	
	if self.tbGroupName[nGroupId] then
		return;
	end
	if pPlayer.nTeamId == 0 then
		self.tbGroupName[nGroupId] = pPlayer.szName;
	else
		local tbPlayerList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
		local pCaptin = KPlayer.GetPlayerObjById(tbPlayerList[1]);
		if pCaptin then
			self.tbGroupName[nGroupId] = pCaptin.szName;
		else
			self.tbGroupName[nGroupId] = pPlayer.szName;
		end
	end
end

--���������npc
function tbMission:ClearAllNpc()
	--ɾ����ˢ�����Ĺ�
	for nNpcId, _ in pairs(self.tbRefreshNpcId) do
		local pNpc = KNpc.GetById(nNpcId);
		if pNpc then
			pNpc.Delete();			
		end
	end
	self.tbRefreshNpcId = {};
	--ɾ��boss
	if self.nRefreshBossId ~= 0 then
		local pNpc = KNpc.GetById(self.nRefreshBossId);
		if pNpc then
			pNpc.Delete();
		end
	end
	--ɾ����������ռλ
	for nNpcId, _ in pairs(self.tbTD) do
		local pNpc = KNpc.GetById(nNpcId);
		if pNpc then
			pNpc.Delete();			
		end
	end
	self.tbTD = {};
	for nId, tbPosition in ipairs(self.tbTD_Position) do
		self.tbTD_Position[nId][3] = 0;
	end
	self.nRefreshBossId = 0;
	
end

--��Ϸ�����ص�
function tbMission:OnEnd()	
	ClearMapNpc(self.nMapId);
	ClearMapObj(self.nMapId);	
	self:Close();
	return 0;
end

function tbMission:OnClose()
	if self.tbCallbackOnClose then
		Lib:CallBack(self.tbCallbackOnClose);
	end
end

function tbMission:OnDeath()
	if self:GetPlayerGroupId(me) >= 0 then
		self:KickPlayer(me);
	end
end

function tbMission:__open(tbEnterPos, tbLeavePos, nMatchType)
	if self:IsOpen() == 1 then
		print("��������֮���ظ�������");
		return;
	end
	
	self.nMapId	= tbEnterPos[1];
	self.tbMisCfg = {
		tbEnterPos				= {[0] = {tbEnterPos[1], 51456/32 ,	103488/32}, [1] = {tbEnterPos[1], 52128/32, 104160/32}},	-- ��������
		tbLeavePos				= {[0] = tbLeavePos},	-- �뿪����
		tbCamp					= {[1]=1,[2]=2},
		nPkState				= Player.emKPK_STATE_PRACTISE,
		nInLeagueState			= 1,
		nDeathPunish			= 1,
		nOnDeath				= 1,
		nForbidStall			= 1,
		--nOnKillNpc 		= 1,
		nForbidSwitchFaction	= 1,
		nLogOutRV				= Mission.LOGOUTRV_DEF_MISSION_TOWER,
	};	
	self.nStateJour 	= 0;
	self.tbGroups	= {};
	self.tbPlayers	= {};
	self.tbResult	= {};			--���
	self.tbTimers	= {};			
	self.tbTD		= {};			--������[nTDId] = {nPlayerId,���� }
	--self.tbTD_EX	= {};			--tbTD��ķ�����	[nPlayerId] = {tbTDId1,tbTDId2...},tbTDId1 = {����ֵ}
	self.tbGrade	= {};			--����[gradeId] = nNumber
	self.tbMoney	= {};			--Ǯ[nPlayerId]	= nNumber
	self.tbGrade_player = {};		--ÿ����ҵĻ���
	self.tbTD_Delete	= {};		--ÿ��ɨ��������������߽���Ҫɾ������tower  Id
	self.tbTowerPositionEx = {};	--����Ӧ����㷹����	
	self.tbRefreshNpcId = {};
	self.tbPlayerShotSkill		= {};		--ÿ���������Ŀ�ݼ�
	self.tbRefreshNpcNumber = 0;	--ÿ�����Ѿ�ˢ���ĸ���
	self.tbMisEventList	= tbMisEventList;
	self.tbCastSkillGroup = {};	--���ͷż��ܵ���	
	self.tbCastSkillTimer = {};	--�ͷż��ܵļ�ʱ��
	self.tbGroupCaptain = {};		--�ӳ���table
	self.tbTD_Position = {};
	self.tbGroupName = {};
	self.tbSkillList= {};	--���ۼ��ܱ�
	self.nRefreshBossId = 0;		--boss   id
	self.ISBossOver = 0;
	self.nGroupNum = 0;
	self.nLostNpc	= 0; 			--���ܵ�npc
	self.nAwordFlag = 0;
	self.szFirstName = "";	
	self.nMatchType = nMatchType or 0;
	self.nResfreshNum = 1;
	--��ʼ�������ͷż��ܵ���table
	for i =1 , self.CASTSKILL_GROUP_NUM do
		self.tbCastSkillGroup[i] = {};
	end
	for _, pos in ipairs(self.tbTowerPosition) do
   	 	table.insert(self.tbTD_Position, {tonumber(pos["TRAPX"])/32, tonumber(pos["TRAPY"])/32, 0});
	end
end

function tbMission:__start()
	--self.tbGameSumTimer = self:CreateTimer(self.TIME_FPS_GAMESUM, self.OnGameTimeOver, self);
	self:GoNextState();
end

-- ���ԵĻ���Ҫֱ�ӵ����
-- ������ __open, Ȼ�� JoinPlayer, ��� __start
function tbMission:StartGame(tbEnterPos, tbLeavePos)	
	self:__open(tbEnterPos, tbLeavePos);
	self:__start();
end

function tbMission:GetGroupNum()
	return self.nGroupNum;
end

--����
function tbMission:Transform(pPlayer, nGroup)	
	if pPlayer.GetSkillState(self.TRANSFORM_SKILL_ID) <= 0 then
		local nMapId, nX, nY = pPlayer.GetWorldPos();
		local tbLevel = {[0] = {1,3,5},[1] = {2,4,6}};
		if not tbLevel[pPlayer.nSex] then
			tbLevel[pPlayer.nSex] = {1,3,5};
		end
		local nSkillLevel = tbLevel[pPlayer.nSex][Random(3) + 1];
		pPlayer.CastSkill(self.TRANSFORM_SKILL_ID, nSkillLevel, nX, nY);		
	end
end

-- ��ȡ���
-- {[1] --> (nGroupId, grade), [2] --> ...}
function tbMission:GetResult()
	return self.tbResult;
end

-- �Ҳ�����
function tbMission:GenerateAndSendMsg()
	local tbMsg = {"\n������ֱ�"};	
	local tbMsgEx = {};
	local tbGradeEx = {};
	for nGroupId, nGrade in pairs(self.tbGrade) do
		if nGrade >= 0 then
			table.insert(tbGradeEx,{nGroupId, nGrade});
		end
	end
	--����	
	local sort_cmp = function (tb1, tb2)
		return tb1[2] > tb2[2];
	end
	table.sort(self.tbGrade_player, sort_cmp);
	table.sort(tbGradeEx, sort_cmp);
	for _, tbGroupGrade in ipairs(tbGradeEx) do
		table.insert(tbMsg, string.format("<color=blue>%-16s<color><color=white>%d<color>", self.tbGroupCaptain[tbGroupGrade[1]].."��", tbGroupGrade[2]));
	end
	local szMsg = table.concat(tbMsg, "\n");
	
	--��һ�����ˣ��ӹ⻷
	if self.tbGrade_player[1] and self.szFirstName ~= self.tbGrade_player[1][1] and self.tbGrade_player[1][2] ~= 0 and self.nStateJour < 4  then
		self:AddTitle(self.szFirstName, self.tbGrade_player[1][1]);
		self.szFirstName = self.tbGrade_player[1][1];
		self:BroadcastBlackBoardMsg(string.format("��һ���ƺŹ⻷��%s�����ˣ���Ҽӽ�׷�����ᣡ",self.szFirstName));		
	end
	
	if self.nMatchType ~= 2 then
		tbMsgEx = {"\n��һ��ֱ�"};	
		for _, tbGrade in ipairs(self.tbGrade_player) do
			table.insert(tbMsgEx, string.format("<color=yellow>%-16s<color><color=white>%d<color>", tbGrade[1], tbGrade[2]));	
		end
		szMsg = table.concat(tbMsgEx, "\n").."\n"..szMsg;
	end
	
	for _, pPlayer in pairs(self:GetPlayerList())do
		local szMsgEx = szMsg..string.format("\n\n<color=yellow>�Լ��ľ��ã�%s\n���ܵĹ��%s<color>\n��%s������", pPlayer.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY), self.nLostNpc, self.nResfreshNum);
		Dialog:SendBattleMsg(pPlayer, szMsgEx, 1);
	end
end

--���Ӻ�ɾ���Ե�һ���ĳƺ�
function tbMission:AddTitle(szName1,szName2)	
	local pPlayer1 = KPlayer.GetPlayerByName(szName1);
	local pPlayer2 = KPlayer.GetPlayerByName(szName2);
	if pPlayer1 and pPlayer1.FindTitle(unpack(self.tbFirst_Title)) == 1 then
		pPlayer1.RemoveTitle(unpack(self.tbFirst_Title));
		pPlayer1.SetCurTitle(0, 0, 0, 0);
	end
	if pPlayer2 then
		pPlayer2.AddTitle(unpack(self.tbFirst_Title));
		pPlayer2.SetCurTitle(unpack(self.tbFirst_Title));
	end
end

-- �Ҳ���»��ң�����
function tbMission:UpdataMsg(nPlayerId, nGroupId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBattleMsg(pPlayer, string.format("\n<color=yellow>���ã�%s\n\n���֣�%s\n\n���ܵĹ��%s<color>", pPlayer.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY), self.tbGrade[nGroupId], self.nLostNpc));
	end
end

--���ﱻ�����������ܵ����յ���ɾ������
function tbMission:DelRefreshNpc(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end
	pNpc.Delete();
	self.tbRefreshNpcId[nNpcId] = nil;
	if self.nResfreshNum == self.NPC_REFRESH_COUNT_ALL then
		self:GoNextState();
		return;
	end
	if Lib:CountTB(self.tbRefreshNpcId) == 0 then
		self.nResfreshNum = self.nResfreshNum + 1;
		self:RefreshNpc(self.nResfreshNum);
	end
	return 0;
end

--boss�����ص�
function tbMission:DelBoss(nNpcId,	nKillerId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end
	local nTemplateId = pNpc.nTemplateId;
	--pNpc.Delete();
	pNpc.DropRateItem(self.szNpc_droprate[nTemplateId][1], self.szNpc_droprate[nTemplateId][2], -1, -1, 0);
	self:AddAword(nTemplateId, nKillerId);
	self.nRefreshBossId = 0;
	if self.nResfreshNum == self.NPC_REFRESH_COUNT_ALL then
		self.ISBossOver = 1;
		self:GoNextState();
		return;
	end	
	self.nResfreshNum = self.nResfreshNum + 1;
	self:RefreshNpc(self.nResfreshNum);	
	return;
end

--td�����ص�
function tbMission:DelTower(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end
	pNpc.Delete();
	if self.tbTD[nNpcId] then
		self:SpecialTD(self.tbTD[nNpcId][1]);  --����������Ч��
		self.tbTD[nNpcId] = nil;
	end
	local nId = self.tbTowerPositionEx[nNpcId];
	self.tbTD_Position[nId][3] = 0;		--�ô���Ϊ����ֲ
	self.tbTowerPositionEx[nNpcId] = nil;
end

--�Ƿ�Ҫ����������Ч��
function tbMission:SpecialTD(nPlayerId)
	--ToDo(֮ǰ�ᵽ�����ȱ���)
end 

-- ����ˢnpc��nNumber��ʾˢ�ĵڼ�����
function tbMission:RefreshNpc(nNumber, nFlag)
	self:BroadcastBlackBoardMsg(string.format("��%s����������Ҫ�����ˣ�",nNumber));	
	if not nFlag then
		if nNumber ~= 1 then
			self:AddMoney(nNumber);
		end
		self.tbReadyTimers = self:CreateTimer(self.TIME_FPS_REFRESH_WAIT, self.RefreshNpc, self, nNumber, 1);
		return 1;
	end
	
	self.tbRefreshNpcNumber = 0;
	if (self:IsOpen() ~= 1)then
		return 0;
	end	
	if type(TowerDefence.NPC_TYPE_ID[nNumber]) == "table" then
		--����boss��	
		self:BroadcastBlackBoardMsg(string.format("��%s�����￪ʼ�����ˣ�",nNumber));
		self.tbRefreshNpcTimers = self:CreateTimer(self.TIME_FPS_REFRESH_NPC, self.RefreshNpcEx, self, nNumber);
	else
		--��boss��
		self:RefreshBoss(nNumber, 1,  0);
	end
	--ˢ��
--	Lib:SmashTable(self.tbPosition_fu);
--	for i = 1, Lib:CountTB(self:GetPlayerList()) do
--		local nNpcId = Random(5) + 6687;
--		local pNpc = KNpc.Add2(nNpcId, 1, -1, self.nMapId, self.tbPosition_fu[i][1], self.tbPosition_fu[i][2]);
--		if pNpc then
--			pNpc.SetLiveTime(Env.GAME_FPS * 60);
--		end
--	end
	return 0;
end

--��ʱ�Ӿ���
function tbMission:AddMoney(nNumber)
	local nMoney = 1;
	if math.fmod(nNumber, 5) == 0 then
		nMoney = 2;
	end
	self:BroadcastBlackBoardMsg("����������ˣ����ȫ��������");
	for nGroup=1, self:GetGroupNum() do
		for _, pPlayer in pairs(self:GetPlayerList(nGroup)) do
			pPlayer.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY, 
				pPlayer.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY) + self.MONEY_PER[nMoney] + nNumber * 4 );		
		end
	end
	self:GenerateAndSendMsg();
end

--����ɫ���
function tbMission:BroadcastBlackBoardMsg(szMsg)
	for _, pPlayer in pairs(self:GetPlayerList()) do
		Dialog:SendBlackBoardMsg(pPlayer, szMsg);
	end
end

--ˢnpc(ÿ2��ˢһ������)
function tbMission:RefreshNpcEx(nNumber)
	for i = 1, #self.tbNpcGenPos do
		local nNumberEx =  math.fmod(self.tbRefreshNpcNumber + 1, #TowerDefence.NPC_TYPE_ID[nNumber]);
		if nNumberEx == 0  then
			nNumberEx = #TowerDefence.NPC_TYPE_ID[nNumber];
		end
		local nNpcId = TowerDefence.NPC_TYPE_ID[nNumber][nNumberEx];
		local x, y = self.tbNpcGenPos[i][1], self.tbNpcGenPos[i][2];
		local pNpc = nil;		
		pNpc = KNpc.Add2(nNpcId, self.NPC_TYPE[nNpcId][2], -1, self.nMapId, x, y);		--�ȼ�����Ѫ���⻷��
		if pNpc then
			self.tbRefreshNpcId[pNpc.dwId] = 1;
			self:SetNpcMoveAI(nNumber, self.tbRefreshNpcNumber + 1, pNpc.dwId);
			pNpc.GetTempTable("Npc").nType = 0;
			pNpc.GetTempTable("Npc").tbMission = self;
			self.tbRefreshNpcNumber = self.tbRefreshNpcNumber + 1;
			--title
			if self.NPC_TYPE[nNpcId] and self.NPC_TYPE[nNpcId][2] ~= 1 then
				pNpc.SetTitle(self.NPC_TYPE[nNpcId][1]);
			end
			if self.tbRefreshNpcNumber ==  #TowerDefence.NPC_TYPE_ID[nNumber] then
				return 0;
			end
		end
	end

	return;
end

--����npc����AI
function tbMission:SetNpcMoveAI(nNumber, nCount, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	local tbNpcMove = {};
	if math.fmod(nCount, 2) == 1 then
		tbNpcMove = self.tbNpcMoveLeft;
	else
		tbNpcMove = self.tbNpcMoveRight;
	end
	for i, tbMovePos in ipairs(tbNpcMove) do
		local nRanX = self.NPC_MOVE_RAD - Random(self.NPC_MOVE_RAD * 2);
		local nRanY = self.NPC_MOVE_RAD - Random(self.NPC_MOVE_RAD * 2);
		pNpc.AI_AddMovePos((tbMovePos[1]) * 32, (tbMovePos[2]) * 32);
	end
	pNpc.SetNpcAI(9, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0);
	pNpc.SetActiveForever(1);
	pNpc.GetTempTable("Npc").tbOnArrive = {self.OnDeathNpc, self, nNpcId};
	pNpc.GetTempTable("Npc").tbMission = self;
	self:AttendNpc2Group( nNpcId);
end

--NPC����Ai
function tbMission:AttendNpc2Group(nNpcId)	
	local nGroup = Random(self.CASTSKILL_GROUP_NUM) + 1;	
	table.insert(self.tbCastSkillGroup[nGroup], nNpcId);
end

--ˢboss
function tbMission:RefreshBoss(nNumber, nFlag, nNpcId)		
	local pNpc = nil;
	if nFlag == 1 then
		self:BroadcastBlackBoardMsg("һֻ���Ķ�ħ���ˣ����������Ҫ��Ȼ����һֱ�ƻ�����ģ�");		
		local nNpcIdEx = TowerDefence.NPC_TYPE_ID[nNumber];
		local x, y = self.REFRESH_BOSS_POINT[1], self.REFRESH_BOSS_POINT[2];		
		pNpc = KNpc.Add2(nNpcIdEx, 4, -1, self.nMapId, x/32, y/32);
		if pNpc then
			pNpc.GetTempTable("Npc").nType = 1;
			pNpc.GetTempTable("Npc").tbMission = self;
		end
	else
		pNpc = KNpc.GetById(nNpcId);
	end
	if pNpc then
		self.nRefreshBossId = pNpc.dwId;
		for i, tbMovePos in ipairs(self.tbBOSSMove) do
			pNpc.AI_AddMovePos(tbMovePos[1]*32, tbMovePos[2]*32);
		end
		pNpc.SetNpcAI(9, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0);
		pNpc.SetActiveForever(1);
		self:AttendNpc2Group(nNpcId);
		pNpc.GetTempTable("Npc").tbOnArrive = { self.RefreshBoss, self, nNumber, 0, pNpc.dwId};	
	end
end


function tbMission:OnJoin(nGroupId)
	
	local nItemId = self.tbSkillList[me.nId];
	local pItem = KItem.GetObjById(nItemId);
	
	if not pItem or not me.GetItemPos(pItem) then
		self:KickPlayer(me);
		return 0;
	end
	local tbItem = Item:GetClass("td_fuzou");	
	
	for _, nGenId in pairs(tbItem.GEN_SKILL_ATTACK) do
		local nUseSkillId = pItem.GetGenInfo(nGenId, 0);
		if nUseSkillId > 0 and me.IsHaveSkill(nUseSkillId) <= 0 then
			me.AddFightSkill(nUseSkillId, 1);
		end
	end

	
	if self:GetPlayerCount(nGroupId) == 1 then
		self.nGroupNum = self.nGroupNum + 1;		
		self.tbGroupCaptain[nGroupId] = me.szName;
	end
	
	self:Transform(me, nGroupId);
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY, self.MONEY_START);
	--self.tbTD_EX[me.nId] = {};
	self.tbGrade[nGroupId] = self.tbGrade[nGroupId]  or 0;
	me.SetFightState(1);
	local nGroupIdEx = math.fmod(nGroupId,2);
	me.SetCurCamp(nGroupIdEx);
	--��¼��Ҽ��ܿ�ݼ��������µļ�
	Player:SaveShotCut(self.tbPlayerShotSkill);
	for i =1, #self.ITEM_SHOTCUT do
		FightSkill:SetShortcutItem(me, i, self.ITEM_SHOTCUT[i], 1);
	end
	--�����Լ��Ļ��ֱ�
	table.insert(self.tbGrade_player,{me.szName, 0, nGroupId});
	--������ߣ���ֹ��ҷǷ�������ǰ�ĵ��ߣ�
	self:ClearPlayerItem(me);
	local tbPlayerTempTable = me.GetPlayerTempTable();
	tbPlayerTempTable.tbMission = self;
end

function tbMission:OnLeave(nGroupId, szReason)	
	-- ���ԭ��
	if me.GetSkillState(self.TRANSFORM_SKILL_ID) > 0 then
		me.RemoveSkillState(self.TRANSFORM_SKILL_ID);
	end
	me.RestoreLife();
	me.LeaveTeam();
	--���player�ӵļ���
	for i = 1, #self.PLAYER_SKILL_ID do
		if me.IsHaveSkill(self.PLAYER_SKILL_ID[i]) == 1 then
			me.DelFightSkill(self.PLAYER_SKILL_ID[i]);
		end
	end
	--���player�Է��õ��ļ���
	for i = 1, #self.PLAYER2NPC_SKILL_ID do
		if me.IsHaveSkill(self.PLAYER2NPC_SKILL_ID[i]) == 1 then
			me.DelFightSkill(self.PLAYER2NPC_SKILL_ID[i]);
		end
	end
	--�ָ���ݼ�	
	Player:RestoryShotCut(self.tbPlayerShotSkill);
	--���������Ķ���
	self:ClearPlayerItem(me);
	-- �ص���ڴ�
	me.SetFightState(0);
	Dialog:ShowBattleMsg(me,  0,  0);
	--�������td����֮���ָ����ϵ
	--for _, nTDId in ipairs(self.tbTD_EX[me.nId]) do
	--	if self.tbTD[nTDId] then
	--		self.tbTD[nTDId] = nil;
	--	end
	--end
	--�������
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_MONEY, 0);
	--��⻷
	if me.FindTitle(unpack(self.tbFirst_Title)) == 1 then
		me.RemoveTitle(unpack(self.tbFirst_Title));
		me.SetCurTitle(0, 0, 0, 0);
	end
	--self.tbTD_EX[me.nId] = nil;
	if self:GetPlayerCount(nGroupId) == 0 and self.nStateJour < 4  and self.nAwordFlag ~= 1 then -- ȫ�����˻��������
		
		if self.nMatchType and self.nMatchType == 2 then			
			for nGroupIdEx, nGrade in pairs(self.tbGrade) do
				if nGroupId == nGroupIdEx then					
					self.tbGrade[nGroupId] = -1;
				end
			end
			--����˻���
			for i , tbPlayerEx in ipairs(self.tbGrade_player) do
				if me.szName == self.tbGrade_player[i][1] then
					self.tbGrade_player[i][2] = 0;
				end
			end
			if (self:GetPlayerCount(0) > 1) then
				return 0;
			end
		end
		if self.nMatchType ~= 2 then
			self.tbGrade[nGroupId] = -1;
		end
		self.nStateJour = 3;
		self:GoNextState();
	end
end

--������վ����λ���ǲ����ܹ���ֲ��
function tbMission:CheckeUseItem(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0, 0;
	end
	local _, nX, nY = pPlayer.GetWorldPos();
	for nId, tbPosition in ipairs(self.tbTD_Position) do
		if math.abs(nX - tbPosition[1]) < self.TOWERPOSITIONRAD  and math.abs(nY - tbPosition[2]) < self.TOWERPOSITIONRAD and tbPosition[3] ~= 1 then
			return 1, nId;
		end
	end
	return 0, 0;
end

--��ֲ��
function tbMission:AddTower(nPlayerId, nId, nItemId)
	local pItem = KItem.GetObjById(nItemId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pItem or not pPlayer then
		return 0;
	end
	local nNpcId = TowerDefence.TOWERID[pItem.nParticular - 620][1];		--������nlevel��������Ӧ���ģ�֮������scriptitem��ԭ���Ϊ��nparticular��Ϊ���������Ե�һ������Ӧ����621��1�����Լ�ȥ620
	local nX, nY = self.tbTD_Position[nId][1],self.tbTD_Position[nId][2];
	local pNpc = KNpc.Add2(nNpcId, 1, pItem.nParticular - 620, self.nMapId, nX, nY);
	if pNpc then
		self.tbTD_Position[nId][3] = 1;	--��λ�ñ���Ϊռ��
		self.tbTD[pNpc.dwId] = {pPlayer.nId, pItem.nParticular - 620};
		self.tbTowerPositionEx[pNpc.dwId] = nId;
		--table.insert(self.tbTD_EX[nPlayerId], pNpc.dwId);
		if pPlayer.GetCurCamp() == 0 then
			pNpc.SetTitle(string.format("%s��Ģ��", pPlayer.szName));
		else
			pNpc.SetTitle(string.format("<color=gold>%s��Ģ��<color>", pPlayer.szName));
		end
		pNpc.SetCurCamp(pPlayer.GetCurCamp());
		pNpc.GetTempTable("Npc").tbMission = self;
		pNpc.GetTempTable("Npc").nGrade = 1;
		pNpc.GetTempTable("Npc").nCamp = pPlayer.GetCurCamp();
		pNpc.SetMaxLife(self.TOWER_MIN_LIFE_UP[3]);
		self:SpecialTD(nPlayerId);  --����������Ч��
		return 1;
	end
	return 0;
end

--ÿ����������һ��������,����
function tbMission:UpDataTower()
	for nNpcId, tbNpc in pairs(self.tbTD) do
		local pNpc = KNpc.GetById(nNpcId);
		if pNpc then
			local nGrade = pNpc.GetTempTable("Npc").nGrade;
			if nGrade > 1 and self.TOWER_MIN_LIFE_UP[nGrade - 1] > pNpc.nCurLife then
				self:UpDataTowerEx(pNpc.dwId, -1);			--����
			elseif nGrade < 3 and self.TOWER_MIN_LIFE_UP[nGrade+1] <= pNpc.nCurLife then
				self:UpDataTowerEx(pNpc.dwId, 1);				--����
			end 
		end
	end
	for _, nNpcId in ipairs(self.tbTD_Delete) do
		self.tbTD[nNpcId] = nil;
	end
	self.tbTD_Delete = {};
	--ˢ�½��棨���ã�
	self:GenerateAndSendMsg()
end

--����������npc
function tbMission:UpDataTowerEx(nNpcId, nTypes)	
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then		
		return;
	end
	local nGrade = pNpc.GetTempTable("Npc").nGrade;
	local nMapId, nX ,nY = pNpc.GetWorldPos();
		
	local nPlayerId,nType = self.tbTD[nNpcId][1], self.tbTD[nNpcId][2];
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return
	end	
	local nCamp = pNpc.GetTempTable("Npc").nCamp;
	table.insert(self.tbTD_Delete, nNpcId);
	--self.tbTD[nNpcId] = nil;		--������ļ�¼
	local nPos = self.tbTowerPositionEx[nNpcId];
	self.tbTowerPositionEx[nNpcId] = nil;	--���λ�ü�¼
	pNpc.Delete();
	local pNpcEx = KNpc.Add2(TowerDefence.TOWERID[nType][nGrade + nTypes], nGrade + nTypes, nType, nMapId, nX, nY);
	if pNpcEx then
		pNpcEx.GetTempTable("Npc").tbMission = self;
		pNpcEx.GetTempTable("Npc").nGrade = nGrade + nTypes;
		self.tbTD[pNpcEx.dwId] = {nPlayerId, nType};
		self.tbTowerPositionEx[pNpcEx.dwId] = nPos;
		if nCamp == 0 then
			pNpcEx.SetTitle(string.format("%s��Ģ��", pPlayer.szName));
		else
			pNpcEx.SetTitle(string.format("<color=gold>%s��Ģ��<color>", pPlayer.szName));
		end
		pNpcEx.SetCurCamp(nCamp);
		pNpcEx.GetTempTable("Npc").nCamp = nCamp;
		pNpcEx.SetMaxLife(self.TOWER_MIN_LIFE_UP[3]);
		self:SpecialTD(nPlayerId);		--����������Ч��
	end
end

--���towerӵ���ߺ͵����tower��plyaer�ǲ���һ�����
function tbMission:CheckTower(nNpcId, nPlayerId)	
	local pNpc = KNpc.GetById(nNpcId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pNpc or not pPlayer then
		return 0;
	end
	if not self.tbTD[nNpcId] then
		return 0;
	end
	local nPlayerIdEx = self.tbTD[nNpcId][1];	
	local pPlayerEx = KPlayer.GetPlayerObjById(nPlayerIdEx);
	if not pPlayerEx then
		return 2;
	end
	if pPlayerEx.nTeamId ~= pPlayer.nTeamId then
		return 2;
	end
	return 1;
end

--���ý���
function tbMission:SetAword()	
	local nResult = 3;	
	if self.tbResult[1][2] > self.tbResult[2][2] then
		nResult = 1;
	elseif self.tbResult[1][2] < self.tbResult[2][2] then
		nResult = 2;
	end
	if self:GetPlayerCount(2) <= 0 then
		nResult = 1;
	end
	if self:GetPlayerCount(1) <= 0 then
		nResult = 2;
	end
	local tbResult_Ex = {};
	for i,tbPlayer in ipairs(self.tbGrade_player) do
		tbResult_Ex[tbPlayer[3]] = tbResult_Ex[tbPlayer[3]] or {};
		table.insert(tbResult_Ex[tbPlayer[3]], self.tbGrade_player[i]);
	end 
	TowerDefence:AwardSingleSport(self:GetPlayerIdList(1), self:GetPlayerIdList(2), nResult, tbResult_Ex);
	self.nAwordFlag = 1;
end

--�������������ĵ���
function tbMission:ClearPlayerItem(pPlayer)
	local tbTowerItem = pPlayer.FindClassItemInBags("tower_Item");
	local tbCanteen	=pPlayer.FindClassItemInBags("tower_canteen");
	local tbHoe = pPlayer.FindClassItemInBags("tower_hoe");
	for _,tbItem in ipairs (tbTowerItem) do
		tbItem.pItem.Delete(pPlayer);
	end
	for _,tbItem in ipairs (tbCanteen) do
		tbItem.pItem.Delete(pPlayer);
	end
	for _,tbItem in ipairs (tbHoe) do
		tbItem.pItem.Delete(pPlayer);
	end
end

-- ?pl DoScript("\\script\\mission\\tdgame\\tdgame_mission.lua")
