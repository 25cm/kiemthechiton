-- �ļ�������mission.lua
-- �����ߡ���zhaoyu
-- ����ʱ�䣺2009/10/26 14:39:51
-- ��  ��  ��
Require("\\script\\mission\\mentor\\mentor.lua");

Esport.MentorMission = Mission:New();
local tbMission = Esport.MentorMission;
local Mentor = Esport.Mentor;

function tbMission:OnStart(nDyMapId)
	-- �趨��ѡ������
	self.tbMisCfg	= {
		nFightState	= 1,						-- ս��״̬
		nPkState		= Player.emKPK_STATE_PRACTISE,--ս��ģʽ
		nDeathPunish	= 1,
		nForbidSwitchFaction	= 1,
		nOnDeath		= 1,
		nOnKillNpc		= 1,
		tbDeathRevPos	= { {nDyMapId, Mentor.ENTER_X, Mentor.ENTER_Y} },
		tbEnterPos 		= { {nDyMapId, Mentor.ENTER_X, Mentor.ENTER_Y} },
	}
	self.nMisMapId = nDyMapId;
	self:Reset();
end

--���õ���ʼ״̬
function tbMission:Reset()
	self.bStarted 				= false;
	self.nDegree 				= 0; --��ȡ��������
	self.nStep 					= 0; --�����¼�Id
	self.nApprenticePlayerId 	= nil; --ͽ�ܵ�Player
	self.nMasterPlayerId 		= nil; --ʦ����Player
	self.tbAiNpcList = {};
	
	tbMission.tbMonsterList = 
		{--nNpcId	nNpcCount
			[2459] = 0,		--����1�¼�һС��
			[2460] = 0,		--����1�¼�����������
			[2461] = 0,		--����1�¼�������NPC,��ֵ���Ա���Ϊһ������ֵ��ֵ����0ʱ��ʾ���ڻ��ͣ���ֵΪ0ʱ��ʾ�������
			[2464] = 0,		--����2��BOSS
			[2465] = 0,		--����2��BOSS
			[2467] = 0,		--����3BOSS
		}

	ClearMapNpc(self.nMisMapId);
	ClearMapObj(self.nMisMapId);
end

function tbMission:OnOpen()

	self:Reset();
	self:InitGame();
end

--��ʼ����Ϸ��������ʱ��meֻ����ͽ��
function tbMission:InitGame()
	local pApprenticePlayer = Mentor:GetApprentice(me.nId);
	local pMasterPlayer = Mentor:GetMaster(me.nId);
	self.nApprenticePlayerId = pApprenticePlayer.nId;	--����ͽ�ܵ�PlayerId
	self.nMasterPlayerId = pMasterPlayer.nId;			--����ʦ����PlayerId
	self:JoinPlayer(pApprenticePlayer, 1);				--����ͽ�ܵ�����������ʼ��self.tbMisCfg�е��������
	self:JoinPlayer(pMasterPlayer, 1);					--����ʦ��������������ʼ��self.tbMisCfg�е��������	
	self.nApprenticeLevel = pApprenticePlayer.nLevel;	--ͽ�ܵȼ�
	self.nMasterLevel	  = pMasterPlayer.nLevel;		--ʦ���ȼ�
	self.nDegree = Mentor:GetDegree(self.nApprenticePlayerId);	
	self:ResetCurDegree();

	--�۳�ͽ�ܸ�������
	local nDaily = pApprenticePlayer.GetTask(Mentor.nGroupTask, Mentor.nSubDailyTimes);
	local nWeek = pApprenticePlayer.GetTask(Mentor.nGroupTask, Mentor.nSubWeeklyTimes);
	pApprenticePlayer.SetTask(Mentor.nGroupTask, Mentor.nSubDailyTimes, nDaily - 1);
	pApprenticePlayer.SetTask(Mentor.nGroupTask, Mentor.nSubWeeklyTimes, nWeek - 1);
	
	self.tbFightTimer = self:CreateTimer(Mentor.TIMEOUT * 60 * Env.GAME_FPS, self.OnGameOver, self); --������ʱ
	local szMsg = string.format("���Ɽ�Ѿ���������������%d�������������", Mentor.TIMEOUT);
	self:SendMessage(szMsg);
	
	--�ڴ��ͽ��븱��֮ǰ�ж�����������Ƿ���������ߣ���������ж��Ƿ�Ϸ�
	self:ClearShituItem();
end

--����nDegree��nStep���npc��bClear��Ϊ�������ԭ��npc
function tbMission:RefreshNpc(bClear)

	local tbSetting = Mentor.tbSetting;
	local nLevel;
	if bClear then
		ClearMapNpc(self.nMisMapId);
		
		--����¼����������������
		for _, nNpcCount in pairs(self.tbMonsterList) do
			nNpcCount = 0;
		end
	end

	local pApprenticePlayer = KPlayer.GetPlayerObjById(self.nApprenticePlayerId);
	local pMasterPlayer = KPlayer.GetPlayerObjById(self.nMasterPlayerId);
	for _, tbValue  in ipairs(Mentor.tbSetting) do
		if tonumber(tbValue.nDegree) == self.nDegree and tonumber(tbValue.nStep) == self.nStep then
			if tonumber(tbValue.nLevel) == -1 then
				nLevel = self.nMasterLevel;
			elseif tonumber(tbValue.nLevel) == -2 then
				nLevel = self.nApprenticeLevel;
			else
				nLevel = tbValue.nLevel;
			end
			if tonumber(tbValue.bRoute) == 0 then
				local pNpc = KNpc.Add2(tonumber(tbValue.nNpcId), tonumber(nLevel), -1,
					self.nMisMapId, tbValue.nX / 32, tbValue.nY / 32, 0, tonumber(tbValue.nNpcType));
				self.tbAiNpcList[tonumber(tbValue.nNpcId)] = pNpc.dwId;
			elseif  tonumber(tbValue.bRoute) == 1 then
				local dwId = self.tbAiNpcList[tonumber(tbValue.nNpcId)];
				local pNpc = KNpc.GetById(dwId)	
				pNpc.AI_AddMovePos(tonumber(tbValue.nX), tonumber(tbValue.nY));
			end
			--��¼ָ�����͹���ĸ��� 
			if self.tbMonsterList[tonumber(tbValue.nNpcId)] then
				self.tbMonsterList[tonumber(tbValue.nNpcId)] = self.tbMonsterList[tonumber(tbValue.nNpcId)] + 1;
			end
		end
	end
	
end

--�����Ѿ�׼���ã���ʼ��Ϸ
--function tbMission:OnGameStart() 
--end

--���������������ӽ�ͷnpc
function tbMission:BeginGame()
	self.bStarted = true;
	self:RefreshNpc();
	return 0;
end

function tbMission:GoNextStep()
	--�����ǰ���ȴ���3���������ˣ�д����־���رո���
	if self.nDegree > Mentor.WEEKLY_SCHEDULE then
		local pMasterPlayer 	= KPlayer.GetPlayerObjById(self.nMasterPlayerId);
		local pApprenticePlayer = KPlayer.GetPlayerObjById(self.nApprenticePlayerId);
		Dbg:WriteLog("Mentor_shitufuben", string.format("����{%s, %s}��ʦͽ�����еĽ��ȴ��ڵ�ǰ������ƣ���", 
			pMasterPlayer.szName, pApprenticePlayer.szName));
		
		self:EndGame(); --ǿ�ƹرո���
	end
	
	self.nStep = self.nStep + 1;
	local fnCall = Mentor.tbGameStepFunc[self.nDegree][self.nStep];
	if fnCall == nil then	
		--�ɹ�����˵�ǰ���ȣ���¼���������
		local pApprenticePlayer = KPlayer.GetPlayerObjById(self.nApprenticePlayerId);
		
		if pApprenticePlayer then
			local nTaskDegree = pApprenticePlayer.GetTask(Mentor.nGroupTask, Mentor.nSubCurDegree);
			
			if nTaskDegree ~= self.nDegree and nTaskDegree == 1 then		--�ոո�����ÿ�ܵ��������
				pApprenticePlayer.SetTask(Mentor.nGroupTask, Mentor.nSubCurDegree, nTaskDegree);
			elseif nTaskDegree == self.nDegree then
				pApprenticePlayer.SetTask(Mentor.nGroupTask, Mentor.nSubCurDegree, self.nDegree + 1);
			else
				--�ߵ�������������쳣���
				local pMasterPlayer 	= KPlayer.GetPlayerObjById(self.nMasterPlayerId);
				Dbg:WriteLog("Mentor_shitufuben",  string.format("����{%s, %s}��ʦͽ�����еĽ����쳣����", 
					pMasterPlayer.szName, pApprenticePlayer.szName)); 	
			end
		end
		
		self:EndGame();
	elseif type(fnCall) == "function" then
		self:CreateTimer(5 * Env.GAME_FPS, fnCall, self);
	end;
end

--��������¼��ص�
function tbMission:OnDeath()

	--����1��ĳ�����������Ҫ���ø���,ֻ��Ҫ�Ѹ���Ҵ��͵�������ʼ�㼴��
	
	--��������Ҵ��͵�������ʼ��
	me.ReviveImmediately(0);
	me.SetFightState(1);
	if self.nDegree ~= 1 then
		local pOtherPlayerId = (me.nId == self.nApprenticePlayerId) and self.nMasterPlayerId or self.nApprenticePlayerId;
		local pOtherPlayer = KPlayer.GetPlayerObjById(pOtherPlayerId);
		--����һ����Ҵ��͵�������ʼ��
		if pOtherPlayer and pOtherPlayer.nMapId == self.nMisMapId then
			pOtherPlayer.NewWorld(unpack(self.tbMisCfg.tbEnterPos[1]));
		end

		--���ø�������
		self:ResetCurDegree();
	end
end

--����ǰ��������Ϊ�ս���ʱ��״̬
function tbMission:ResetCurDegree()
	--���������NPC
	ClearMapNpc(self.nMisMapId);
	
	--��������ȫ��0
	tbMission.tbMonsterList = 
		{--nNpcId	nNpcCount
			[2459] = 0,		--����1�¼�һС��
			[2460] = 0,		--����1�¼�����������
			[2461] = 0,		--����1�¼�������NPC,��ֵ���Ա���Ϊһ������ֵ��ֵ����0ʱ��ʾ���ڻ��ͣ���ֵΪ0ʱ��ʾ�������
			[2464] = 0,		--����2��BOSS
			[2465] = 0,		--����2��BOSS
			[2467] = 0,		--����3BOSS
		}
	
	--�����¼��ظ�������
	self.nStep = 0;
	self:GoNextStep();
	
	--���õ�ʱ�������ܵ���ɾ��
	--��������£�ֻ��Ҫ�ж�ͽ�ܾͿ����ˣ������ʦ��Ҳ���жϣ��������ʦ��Ҳ�е��ߵ����
	self:ClearShituItem();
end

--���ɱ��NPC�¼��ص�
function tbMission:OnKillNpc()
	assert(him);
	
	if not self.tbMonsterList or not self.tbMonsterList[him.nTemplateId] then
		return;
	end
	
	if self.tbMonsterList[him.nTemplateId] <= 0 then
		return;
	end
	
	self.tbMonsterList[him.nTemplateId] = self.tbMonsterList[him.nTemplateId] - 1;
	
	if self:IsAllMonstersClear() == 1 then
		--�������˽���2����Ϊ����2ɱ������BOSS������timer�ر�
		if self.tbTimer_Boss2 then
			self.tbTimer_Boss2 = nil;
		end
		self:GoNextStep();
	else
		--����2������������⣬��Ҫ�ó������������ж�
		if self.nDegree == 2 then
			--����2��ֻ��ɱ�������е�һ��BOSS����һ��timer
			
			--���ڸ�NPC֮������ϱ�DEL�������ﱣ�����������Ϣ���Ա��ڸ����NPC
			local tbNpcInfo = {};
			tbNpcInfo.nTemplateId = him.nTemplateId;
			tbNpcInfo.nLevel = him.nLevel;
			tbNpcInfo.nX, tbNpcInfo.nY = him.GetMpsPos();
			tbNpcInfo.nNpcType = him.GetNpcType();

			self.tbTimer_Boss2 = self:CreateTimer(5 * Env.GAME_FPS, self.OnKillOneOfBoss2, self, tbNpcInfo);		--��Ҫ��5����ɱ������һ��BOSS
		end
	end
end

--���self.tbMonsterList���������ֵ��Ϊ0���򷵻�1�����򷵻�0
function tbMission:IsAllMonstersClear()
	for _, nNpcCount in pairs(self.tbMonsterList) do
		if nNpcCount ~= 0 then
			return 0;
		end
	end
	
	return 1;
end

--5����û��ɱ����һNPC�������NPC
function tbMission:OnKillOneOfBoss2(tbNpcInfo)
	KNpc.Add2(tbNpcInfo.nTemplateId, tbNpcInfo.nLevel, -1, self.nMisMapId, tbNpcInfo.nX/32, tbNpcInfo.nY/32, 0, tbNpcInfo.nNpcType);
	self.tbMonsterList[tbNpcInfo.nTemplateId] = 1;		--������֮����Ϊ��û��ɱ�������
	return 0;
end

--�¼�һ��ˢһ����ʦ�������൱��С��
function tbMission:BeginGame1_1()
	self:RefreshNpc();
	return 0;
end

--�¼�����ˢ�������죬ˢ������NPC
function tbMission:BeginGame1_2()
	--self:RefreshNpc();
	return 0;
end

--�¼�����ˢ����·�ϵĹ֣�������������
function tbMission:BeginGame1_3()
	self:RefreshNpc();
	--ɾ���Ի�NPC
	local dwId = self.tbAiNpcList[2458];
	local pNpc = KNpc.GetById(dwId);
	pNpc.Delete();

	--������NPC����AI
	dwId = self.tbAiNpcList[2461];
	self.dwProtecNpcId = dwId;		--��¼����NPC��ID���Ա��NPC��ɱ��ʱ�ܹ�ͨ����ֵ�ҵ�mission
	pNpc = KNpc.GetById(dwId);
	pNpc.SetNpcAI(9, nAttact or 0, bRetort or 1, -1, 25, 25, 25, 0, 0, 0, 0);
	pNpc.GetTempTable("Npc").tbOnArrive = { self.OnArrive, self };
	
	return 0;
end

--����NPC����ָ���ص�
function tbMission:OnArrive()
	tbMission.tbMonsterList[2461] = 0;
	if  self:IsAllMonstersClear() == 1 then
		self:GoNextStep();
	end
end

--ˢ��2��ս��NPC
function tbMission:BeginGame2_1()
	self:RefreshNpc();
	return 0;
end
	
--ˢ��ս��NPC
function tbMission:BeginGame3_1()
	self:RefreshNpc(true);
	self:GoNextStep();
	return 0;
end

--NPC�ٻ�����
function tbMission:BeginGame3_2()
	self:RefreshNpc();
	return 0;
end

--����ʱ�䵽
function tbMission:OnGameOver()
	local szMsg = "���ź������Ɽ�Ѿ��رգ��´�Ŭ���ɡ�";
	self:SendMessage(szMsg);
	self:ClearShituItem();
	self:TransPlayerOut();
	self:Close();
	return 0;
end

--��ʦͽ������Ϣ
function tbMission:SendMessage(szMsg)
	local pApprenticePlayer = KPlayer.GetPlayerObjById(self.nApprenticePlayerId);
	local pMasterPlayer = KPlayer.GetPlayerObjById(self.nMasterPlayerId);
	if pApprenticePlayer then
		Dialog:SendInfoBoardMsg(pApprenticePlayer, szMsg);
	end
	if pMasterPlayer then
		Dialog:SendInfoBoardMsg(pMasterPlayer, szMsg);
	end
end

function tbMission:TransPlayerOut()
	local tbLeavePos = {Mentor.LEAVE_MAP, Mentor.LEAVE_X, Mentor.LEAVE_Y };
	
	local pApprenticePlayer = KPlayer.GetPlayerObjById(self.nApprenticePlayerId);
	local pMasterPlayer = KPlayer.GetPlayerObjById(self.nMasterPlayerId);
	
	if pApprenticePlayer and pApprenticePlayer.nMapId == self.nMisMapId then
		pApprenticePlayer.NewWorld(unpack(tbLeavePos));
	end
	
	if pMasterPlayer and pMasterPlayer.nMapId == self.nMisMapId then
		pMasterPlayer.NewWorld(unpack(tbLeavePos));
	end
end

function tbMission:BeginAward()
	self.tbFightTimer = nil;
	self.tbAwardTimer = self:CreateTimer(Mentor.AwardTimer * Env.GAME_FPS, self.EndGame, self);	--5���Ӻ��˳�����
	--��ʼ�������������...
end

--�ɹ���ɸ���
function tbMission:EndGame()
	--����ҳ�����
	self:ClearShituItem();
	self:TransPlayerOut();
	self:Close();
	
	return 0;
end

function tbMission:OnClose()
	--self:ClearMapNpc(self.nMisMapId);
	self:Reset();
	Mentor:ReleaseMission(self);
end

--����뿪����
function tbMission:OnLeave()
	--�����������
	me.SetFightState(0);
end

function tbMission:ReEnterMission(nPlayerId)
	--�ڴ��ͽ��븱��֮ǰ�ж�����������Ƿ���������ߣ���������ж��Ƿ�Ϸ�
	local pOldMe = me;
	me = KPlayer.GetPlayerObjById(nPlayerId);
	
	local tbFindBoom = GM:GMFindAllRoom(Esport.Mentor.tbBoom);
	local tbFindFreeze = GM:GMFindAllRoom(Esport.Mentor.tbFreeze);
	local tbFindInfo = {};
	Lib:MergeTable(tbFindInfo, tbFindBoom);
	Lib:MergeTable(tbFindInfo, tbFindFreeze);
	self:CheckShituItem(tbFindInfo);
	
	me.NewWorld(unpack(self.tbMisCfg.tbEnterPos[1]));
	self:JoinPlayer(me, 1);
	
	me = pOldMe;
end	

function tbMission:ClearShituItem()
	
	local pApprenticePlayer = KPlayer.GetPlayerObjById(self.nApprenticePlayerId)
	local pMasterPlayer = KPlayer.GetPlayerObjById(self.nMasterPlayerId);
	
	local pOldMe = me;
	local pTeamMember = {pApprenticePlayer, pMasterPlayer};	--����ֻ����������
	for i = 1, #pTeamMember do			
	   	me = pTeamMember[i];
	   	if me then
			local tbFindBoom = GM:GMFindAllRoom(Esport.Mentor.tbBoom);
			local tbFindFreeze = GM:GMFindAllRoom(Esport.Mentor.tbFreeze);
			local tbFindInfo = {};
			Lib:MergeTable(tbFindInfo, tbFindBoom);
			Lib:MergeTable(tbFindInfo, tbFindFreeze);
			self:CheckShituItem(tbFindInfo);
		end
	end
	
	me = pOldMe;
end

function tbMission:CheckShituItem(tbFindInfo)
	if not tbFindInfo then
		return;
	end
	
	for _, tbBoomItem in pairs(tbFindInfo) do
		GM:_ClearOneItem(tbBoomItem.pItem, tbBoomItem.pItem.IsBind(), tbBoomItem.pItem.nCount);
	end
		
	--�������Ҳ���ͽ�ܣ�����Ҫ���ǽ��Ϸ����������ɾ�������
	if self.nApprenticePlayerId ~= me.nId then
		return;
	end
		
	if self.nDegree == 1 and self.nStep == 3 then		
		me.AddItem(unpack(Esport.Mentor.tbBoom));
	end
	if self.nDegree == 3 and self.nStep == 2 then
		me.AddItem(unpack(Esport.Mentor.tbFreeze));
	end		
end
Mentor.tbGameStepFunc = {
	{  tbMission.BeginGame, tbMission.BeginGame1_1, tbMission.BeginGame1_2, tbMission.BeginGame1_3 },
	{  tbMission.BeginGame, tbMission.BeginGame2_1 },
	{  tbMission.BeginGame, tbMission.BeginGame3_1, tbMission.BeginGame3_2 },
};
	