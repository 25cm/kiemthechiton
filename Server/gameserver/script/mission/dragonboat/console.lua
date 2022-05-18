-- �ļ�������console.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-04-27 16:05:55
-- ��  ��  ��
Require("\\script\\mission\\dragonboat\\dragonboat_def.lua");

Esport.DragonBoatConsole = Console:New(Console.DEF_DRAGON_BOAT);
local tbBoat = Esport.DragonBoatConsole;

function tbBoat:Start()
	self.tbCfg ={
		--[׼����Id] = {tbInPos={����׼�����ĵ�},tbOutPos={�뿪׼�������ĵ�ͼ�͵�}};
		tbMap 			= {[1532]={tbInPos={1619,3224}},[1533]={tbInPos={1619,3224}},[1534]={tbInPos={1619,3224}}}; --׼����Id,���Զ���;	
		nDynamicMap		= 1535;						--��̬��ͼģ��Id
		nMaxDynamic 	= 20;				 		--��������̬��ͼ��������;
		nMaxPlayer  	= 160;						--ÿ��׼������������;
		nMinDynPlayer 	= 6;						--ÿ����������4�˲��ܿ�
		nMaxDynPlayer 	= 8;						--ÿ����������������
		nReadyTime		= 270*18;					--׼����ʱ��(��);
		tbDyInPos		= Esport.DragonBoat.MAP_POS_START;
	};
	self.tbMissionList = {};
	self.tbPlayerCfg   = {};
	self.tbPlayerMis = self.tbPlayerMis or {};		--���Id��������¼mission��
end

-- tbBoat:Start()


function tbBoat:OnMySignUp()
	
	if self.tbMissionList then
		for _, tbWaitList in pairs(self.tbMissionList) do
			for _, tbMis in pairs(tbWaitList) do
				if tbMis:IsOpen() == 1 then
					tbMis:OnGameOver();
				end
			end
		end
	end
	self.tbMissionList = {};
	self.tbPlayerMis = {};
	self.tbPlayerCfg   = {};
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, "����ڻ����۱����Ѿ���ʼ�����ˣ��뾡��ȥ�����ִ����ݴ������μӡ�����ʱ��4��30�룡");
	--end
end

--��������ʼ�
function tbBoat:OnMyStart(tbCfg)

	
	--����ǰ�ȹر�δ�رյ�mission
	
	local nWaitMapId	= tbCfg.nWaitMapId;		--׼����Id
	local nDyMapId 	 	= tbCfg.nDyMapId;		--���Id
	local tbGroupLists 	= tbCfg.tbGroupLists;	--�����б�
	self.tbMissionList = self.tbMissionList or {};
	self.tbMissionList[nWaitMapId] = self.tbMissionList[nWaitMapId] or {};	
	self.tbMissionList[nWaitMapId][nDyMapId] = Lib:NewClass(Esport.DragonBoatMission);
	local tbMission = self.tbMissionList[nWaitMapId][nDyMapId];
	tbMission:OnStart(nDyMapId);
	for nGroupId, tbGroup in pairs(tbGroupLists) do
		local nMaxPos = #self.tbCfg.tbDyInPos;
		local tbPos = self.tbCfg.tbDyInPos[MathRandom(1, nMaxPos)];
		tbMission:SetGroupJoinPos(nGroupId, nDyMapId, unpack(tbPos));	
		tbMission:SetGroupLeavePos(nGroupId, self:GetLeaveMapPos());
		for _, nPlayerId in pairs(tbGroup.tbList) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then	
				tbMission.tbSkillList[pPlayer.nId] = self.tbSkillList[pPlayer.nId];
				self.tbPlayerMis[pPlayer.nId] = tbMission;
				self.tbPlayerCfg[pPlayer.nId] = {1};
				tbMission:JoinPlayer(pPlayer, nGroupId);
			end
		end
	end
	tbMission:UpdataAllUi();
end

--�����߼�
function tbBoat:OnGroupLogic(tbCfg)
	local nGroupDivide  = 0;
	local tbKickPlayerList = {};
	for nGroup, tbGroup in ipairs(tbCfg.tbGroupLists) do
		if nGroupDivide == 0 then
			--�ж��Ƿ�4��
			if not tbCfg.tbGroupLists[nGroup + (self.tbCfg.nMinDynPlayer-1)] then
				--���治��4�飬�߳�������
				for nKickGroup = nGroup, #tbCfg.tbGroupLists do
					for _, nPlayerId in pairs(tbCfg.tbGroupLists[nKickGroup]) do
						local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
						if pPlayer then
							table.insert(tbKickPlayerList, pPlayer);
						end
					end
				end
				break;
			end
		end
		for _, nPlayerId in pairs(tbGroup) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			--���󣬷��䶯̬��ͼ��������ţ�
			if pPlayer then
				self:OnDyJoin(pPlayer, tbCfg.nDyMapIndex, nGroup);
				nGroupDivide = nGroupDivide + 1;
			end
		end
		if nGroupDivide >= self.tbCfg.nMaxDynPlayer then
			nGroupDivide = 0;
			tbCfg.nDyMapIndex = tbCfg.nDyMapIndex + 1;
		end
	end
	for _, pPlayer in pairs(tbKickPlayerList) do
		self:KickPlayer(pPlayer);
		local szMsg = "�㱻������䵽�����в���6�ˣ����ܿ������������³��ٴβ�����";
		Dialog:SendBlackBoardMsg(pPlayer, szMsg);
		pPlayer.Msg(string.format("<color=green>%s<color>",szMsg));
	end
end

--����׼�����غ�
function tbBoat:OnJoinWaitMap()
	--print("OnJoinWaitMap", me.szName);
	local tbFind = me.FindItemInBags(unpack(Esport.DragonBoat.ITEM_BOAT_ID));
	if #tbFind < 1 then
		me.Msg("������û������");
		self:KickPlayer(me);
		return 0;
	end
	local pItem = tbFind[MathRandom(1,#tbFind)].pItem;
	self.tbSkillList = self.tbSkillList or {};
	self.tbSkillList[me.nId] = pItem.dwId;
	
	me.ClearSpecialState()			--�������״̬
	me.RemoveSkillStateWithoutKind(Player.emKNPCFIGHTSKILLKIND_CLEARDWHENENTERBATTLE) --���״̬
	me.DisableChangeCurCamp(1);		--���������йصı������������ھ�����ս�ı�ĳ�������Ӫ�Ĳ���
	me.SetFightState(0);	  		--����ս��״̬
	me.SetLogoutRV(1);				--����˳�ʱ������RV�������´ε���ʱ��RV(���������㣬���˳���)
	me.ForbidEnmity(1);				--��ֹ��ɱ
	me.ForbidExercise(1);			--��ֹ�д�
	me.DisabledStall(1);			--��̯
	me.ForbitTrade(1);				--����
	me.nPkModel = Player.emKPK_STATE_PRACTISE;--�ر�PK����
	me.TeamDisable(1);				--��ֹ���
	me.TeamApplyLeave();			--�뿪����
	me.nForbidChangePK	= 1;	
	
	local szMsg = "<color=green>������ʼʣ��ʱ�䣺<color=white>%s<color>";
	local nLastFrameTime = self:GetRestTime();
	self:OpenSingleUi(me, szMsg, nLastFrameTime);
	local szBoatMsg = "\n<color=white>������������<color>";
	local szTip = Item:GetClass("dragonboat"):GetSkillTip(pItem);
	szBoatMsg = szBoatMsg .. szTip;
	self:UpdateMsgUi(me, szBoatMsg);
	Dialog:SendBlackBoardMsg(me, "�������μӶ�������۱�������ȴ�������ʼ��");
	me.SetTask(Esport.DragonBoat.TSK_GROUP, Esport.DragonBoat.TSK_RANK, 0);	--����ϴ�����
end

--�뿪׼�����غ�
function tbBoat:OnLeaveWaitMap()
	if self.tbPlayerCfg[me.nId] and self.tbPlayerCfg[me.nId][1] == 1 then
		return 0;
	end
	if self.tbPlayerMis[me.nId] and self.tbPlayerMis[me.nId]:IsOpen() == 1 then
		if self.tbPlayerMis[me.nId]:GetPlayerGroupId(me) > 0 then
			self.tbPlayerMis[me.nId]:KickPlayer(me);
			self.tbPlayerMis[me.nId] = nil;
		end
	end
	self.tbPlayerCfg[me.nId] = nil;
	me.SetFightState(0);
	me.SetCurCamp(me.GetCamp());
	me.DisableChangeCurCamp(0);
	me.nPkModel = Player.emKPK_STATE_PRACTISE;--�ر�PK����
	me.nForbidChangePK	= 0;
	me.DisabledStall(0);	--��̯
	if me.IsDisabledTeam() == 1 then
		me.TeamDisable(0);--��ֹ���
	end	
	me.ForbitTrade(0);		--����
	me.ForbidEnmity(0);
	me.ForbidExercise(0);
	me.SetLogOutState(0);			--���û�ԭ״̬	
end

--��������
function tbBoat:OnJoin()
	--print("OnJoin", me.szName)
	--me.SetFightState(1);	  		--����ս��״̬
	me.SetCurCamp(1);
	Dialog:SendBlackBoardMsg(me, "10��������ʼ���뽫���ۼ��ܷŵ��������׼��������");
end

--�뿪�����
function tbBoat:OnLeave()
	--print("OnLeave", me.szName);
	--Esport.DragonBoat:LogOutRV();
	--me.SetLogOutState(0);			--���û�ԭ״̬	
	
	if self.tbPlayerMis[me.nId] and self.tbPlayerMis[me.nId]:IsOpen() == 1 then
		if self.tbPlayerMis[me.nId]:GetPlayerGroupId(me) > 0 then
			self.tbPlayerMis[me.nId]:KickPlayer(me);
			self.tbPlayerMis[me.nId] = nil;
		end
	end
end
