--������GS
--�����
--2008.12.25

if (MODULE_GC_SERVER) then
	return 0;
end

--������������ʧ��
function Esport:SignUpFail(tbPlayerList)
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg("�μӱ�����ѩ�̵�����������");
			Dialog:SendBlackBoardMsg(pPlayer, "�μӱ�����ѩ�̵���������")
			return 0;
		end
	end
end

--�ɹ�����
function Esport:SignUpSucess(nMapId, tbPlayerList)
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.NewWorld(nMapId, unpack(self.DEF_READY_POS[MathRandom(1,#self.DEF_READY_POS)]));
		end
	end
end

--����׼����
function Esport:OnEnterReady(pPlayer)
	pPlayer.ClearSpecialState()			--�������״̬
	pPlayer.RemoveSkillStateWithoutKind(Player.emKNPCFIGHTSKILLKIND_CLEARDWHENENTERBATTLE) --���״̬
	pPlayer.DisableChangeCurCamp(1);	--���������йصı������������ھ�����ս�ı�ĳ�������Ӫ�Ĳ���
	pPlayer.SetFightState(0);	  		--����ս��״̬
	pPlayer.SetLogoutRV(1);				--����˳�ʱ������RV�������´ε���ʱ��RV(���������㣬���˳���)
	--pPlayer.SetLogOutState(Mission.LOGOUTRV_DEF_MISSION_ESPORT);			--���û�ԭ״̬; ��ͼOnEnter��LogIn˳���д�,��ʱȥ��
	pPlayer.ForbidEnmity(1);			--��ֹ��ɱ
	pPlayer.ForbidExercise(1);			--��ֹ�д�
	pPlayer.DisabledStall(1);			--��̯
	pPlayer.ForbitTrade(1);				--����
	pPlayer.nPkModel = Player.emKPK_STATE_PRACTISE;--�ر�PK����
	pPlayer.TeamDisable(1);				--��ֹ���
	--pPlayer.TeamApplyLeave();			--�뿪����
	pPlayer.nForbidChangePK	= 1;		
end

--�뿪׼����
function Esport:OnLeaveReady(pPlayer)
	pPlayer.SetFightState(0);
	pPlayer.SetCurCamp(pPlayer.GetCamp());
	pPlayer.DisableChangeCurCamp(0);
	pPlayer.nPkModel = Player.emKPK_STATE_PRACTISE;--�ر�PK����
	pPlayer.nForbidChangePK	= 0;
	pPlayer.SetDeathType(0);
	pPlayer.RestoreMana();
	pPlayer.RestoreLife();
	pPlayer.RestoreStamina();
	pPlayer.DisabledStall(0);	--��̯
	if pPlayer.IsDisabledTeam() == 1 then
		pPlayer.TeamDisable(0);--��ֹ���
	end	
	pPlayer.ForbitTrade(0);		--����
	pPlayer.ForbidEnmity(0);
	pPlayer.ForbidExercise(0);
	pPlayer.SetLogOutState(0);			--���û�ԭ״̬

end

--���߻�崻��ָ�
function Esport:LogOutRV()
	Esport:OnLeaveReady(me);
	for _, nSkillId in pairs(Esport.tbTemplateId2Skill) do
		if me.IsHaveSkill(nSkillId) == 1 then
			me.DelFightSkill(nSkillId);
		end
	end
	
	for _, nBuffId in pairs(Esport.tbTemplateId2Buff) do
		if me.GetSkillState(nBuffId) > 0 then
			me.RemoveSkillState(nBuffId);
		end
	end
	
	if me.IsHaveSkill(1312) == 1 then
		me.DelFightSkill(1312);
	end
end


--�ȽϿ�ʼƥ���߼�
function Esport:SportStartLogic()
	for nMapId, tbGroup in pairs(self.tbGroupLists) do
		
		if SubWorldID2Idx(nMapId) > 0 then
			
			local tbGroupLists = {};
			for nMem=1, self.DEF_PLAYER_TEAM do
				tbGroupLists[nMem] = {};
			end
			for _, tbGroupTemp in ipairs(tbGroup.tbGroupList) do
				if #tbGroupTemp > 0 then
					table.insert(tbGroupLists[#tbGroupTemp], tbGroupTemp);
				end
			end
			
			--����ԭ��˳��
			for _, tbGroups in ipairs(tbGroupLists) do
				for i in pairs(tbGroups) do
					local nP = MathRandom(1, #tbGroups);
					tbGroups[i], tbGroups[nP] = tbGroups[nP], tbGroups[i];
				end
			end			
			
			
			--ƥ��ԭ��
			local tbGroupMatchList = {{}};
			local tbGroupFlag = {};
			local nGroupFlag = 0; 
			local nloop = 1;	--��ֹ��ѭ��,���10000��ѭ��
			while(self:CheckGroupLists(tbGroupLists)==1 and nloop <= 10000) do
				local nCurMembers = #tbGroupMatchList;
				
				--���������Ա��������������,���½���һ���ձ�
				if #tbGroupMatchList[nCurMembers] >= self.DEF_PLAYER_TEAM then
					nCurMembers = nCurMembers + 1;
					tbGroupMatchList[nCurMembers] = {};
				end
				
				local nIsCreateNewGroup = 1;
				--���ҷ��������Ķ���������
				for nMem = self.DEF_PLAYER_TEAM, 1, -1 do
					if #tbGroupLists[nMem] > 0 then
						if  #tbGroupLists[nMem][1] > 0 and #tbGroupMatchList[nCurMembers] + #tbGroupLists[nMem][1] <= self.DEF_PLAYER_TEAM then
							nGroupFlag = nGroupFlag + 1;
							for _, nId in pairs(tbGroupLists[nMem][1]) do
								tbGroupFlag[nId] = nGroupFlag;
								table.insert(tbGroupMatchList[nCurMembers], nId);
							end
							table.remove(tbGroupLists[nMem], 1);
							nIsCreateNewGroup = 0;
						end
					end
				end
				
				--û�ҵ����������Ķ���,���½���һ���ձ�
				if nIsCreateNewGroup == 1 then
					nCurMembers = nCurMembers + 1;
					tbGroupMatchList[nCurMembers] = {};
				end
				
				nloop = nloop + 1;
			end
			
			
			local nCurMembers = #tbGroupMatchList;
			if #tbGroupMatchList[nCurMembers] <= 0 then
				table.remove(tbGroupMatchList, nCurMembers);
			end
			
			--�����ƥ���2�ӽ���ƽ������
			nCurMembers = #tbGroupMatchList;
			local nLastMembers = nCurMembers - 1;
			if math.mod(nCurMembers, 2) ~= 0 or nCurMembers == 0 then
				nLastMembers = nCurMembers + 1;
			end
			
			local tbGroupA = tbGroupMatchList[nLastMembers] or {};
			local tbGroupB = tbGroupMatchList[nCurMembers] or {};
			local nMid = math.floor((#tbGroupA + #tbGroupB)/2);
			local tbFlag = {};
			for _, nId in pairs(tbGroupA) do
				tbFlag[tbGroupFlag[nId]] = tbFlag[tbGroupFlag[nId]] or {};
				table.insert(tbFlag[tbGroupFlag[nId]], nId);
			end
			for _, nId in pairs(tbGroupB) do
				tbFlag[tbGroupFlag[nId]] = tbFlag[tbGroupFlag[nId]] or {};
				table.insert(tbFlag[tbGroupFlag[nId]], nId);
			end
			tbGroupA = {};
			tbGroupB = {};
			for _, tbGroup in pairs(tbFlag) do
				if #tbGroupA <= nMid and (#tbGroupA + #tbGroup) <= nMid then
					for _, nId in pairs(tbGroup) do
						table.insert(tbGroupA, nId);
					end
				else
					for _, nId in pairs(tbGroup) do
						table.insert(tbGroupB, nId);
					end						
				end
			end
			tbGroupMatchList[nLastMembers] = tbGroupA;
			tbGroupMatchList[nCurMembers] = tbGroupB;
			
			local nLeaveMapId, nLeavePosX, nLeavePosY = Esport:GetLeavePos()
			--�ֿ�
			if #tbGroupMatchList[nLastMembers] <=0 or #tbGroupMatchList[nCurMembers] <= 0 then
				for _, nId in pairs(tbGroupMatchList[nLastMembers]) do
					local pPlayer = KPlayer.GetPlayerObjById(nId);
					if pPlayer then
						pPlayer.Msg("���ź����㱾����ѩ�̱����ֿ��ˡ�");
						Dialog:SendBlackBoardMsg(pPlayer, "���ź����㱾����ѩ�̱����ֿ��ˡ�");
						pPlayer.NewWorld(nLeaveMapId, nLeavePosX, nLeavePosY);
					end
				end
				for _, nId in pairs(tbGroupMatchList[nCurMembers]) do
					local pPlayer = KPlayer.GetPlayerObjById(nId);
					if pPlayer then
						pPlayer.Msg("���ź����㱾����ѩ�̱����ֿ��ˡ�");
						Dialog:SendBlackBoardMsg(pPlayer, "���ź����㱾����ѩ�̱����ֿ��ˡ�");
						--self:ConsumeTask(pPlayer);
						pPlayer.NewWorld(nLeaveMapId, nLeavePosX, nLeavePosY);
					end
				end
				table.remove(tbGroupMatchList, nCurMembers);
				table.remove(tbGroupMatchList, nLastMembers);
			end
			
			--��������
			for nKey = 1, #tbGroupMatchList, 2 do
				local nTeam = math.floor(nKey/2)+1;
				self.tbDynMapLists[nMapId] = self.tbDynMapLists[nMapId] or {};
				local nDyMapId = self.tbDynMapLists[nMapId][nTeam];
				if nDyMapId then
					self.tbMissionLists[nMapId] = self.tbMissionLists[nMapId] or {};
					self.tbMissionLists[nMapId][nTeam] = self.tbMissionLists[nMapId][nTeam] or Lib:NewClass(self.Mission);
					self.tbMissionLists[nMapId][nTeam]:StartGame({nDyMapId, self.DEF_MAP_POS[1], self.DEF_MAP_POS[2]}, {nLeaveMapId, nLeavePosX, nLeavePosY});
				end
				local nCaptionAId =0;
				for _, nId in pairs(tbGroupMatchList[nKey]) do
					local pPlayer = KPlayer.GetPlayerObjById(nId);
					if pPlayer then
						if nDyMapId then
							self:ConsumeTask(pPlayer);
							if nCaptionAId == 0 then
								KTeam.CreateTeam(nId);	--��������
								nCaptionAId = nId;
							else
								KTeam.ApplyJoinPlayerTeam(nCaptionAId, nId);	--�������
							end
							self.tbPlayerLists[nId][3] = nTeam;
							self.tbMissionLists[nMapId][nTeam]:JoinPlayer(pPlayer, 1);
						else
							pPlayer.Msg("�����µ�ͼ���س����쳣��������ѩ�̱����޷�����������ϵGM��");
							pPlayer.NewWorld(nLeaveMapId, nLeavePosX, nLeavePosY);					
						end
					end
				end
				
				nCaptionAId = 0;
				for _, nId in pairs(tbGroupMatchList[nKey + 1]) do
					local pPlayer = KPlayer.GetPlayerObjById(nId);
					if pPlayer then
						if nDyMapId then
							self:ConsumeTask(pPlayer);
							if nCaptionAId == 0 then
								KTeam.CreateTeam(nId);	--��������
								nCaptionAId = nId;
							else
								KTeam.ApplyJoinPlayerTeam(nCaptionAId, nId);	--�������
							end	
							
							self.tbPlayerLists[nId][3] = nTeam;
							self.tbMissionLists[nMapId][nTeam]:JoinPlayer(pPlayer, 2);
						else
							pPlayer.Msg("�����µ�ͼ���س����쳣��������ѩ�̱����޷�����������ϵGM��");
							pPlayer.NewWorld(nLeaveMapId, nLeavePosX, nLeavePosY);
						end
					end
				end
			end
		end
	end
	return 0;
end

--����Ƿ�û�ж���
function Esport:CheckGroupLists(tbGroupLists)
	for nMem = 1, self.DEF_PLAYER_TEAM do
		if #tbGroupLists[nMem] > 0 then
			return 1;
		end
	end
	return 0;
end

--�뿪����
function Esport:GetLeavePos()
	local tbNpc = Npc:GetClass("chefu");
	for _, tbMapInfo in ipairs(tbNpc.tbCountry) do
		if SubWorldID2Idx(tbMapInfo.nId) > 0 then
			local nRandomPos = MathRandom(1, #tbMapInfo.tbSect)
			return tbMapInfo.nId, tbMapInfo.tbSect[nRandomPos][1],tbMapInfo.tbSect[nRandomPos][2];
		end
	end
	return 5, 1580, 3029;	--Ĭ�Ͻ��򳵷�
end

--��������
function Esport:ApplyDyMap(nMapId)
	local nDyCount = math.ceil(self.DEF_PLAYER_MAX / ((math.floor(self.DEF_PLAYER_TEAM / 2)+1) * 2)) + 2;
	self.tbDynMapLists[nMapId] = self.tbDynMapLists[nMapId] or {};
	local nCurCount = #self.tbDynMapLists[nMapId];
	if nCurCount < nDyCount then
		for i=1, (nDyCount - nCurCount) do
			if (LoadDynMap(Map.DYNMAP_TREASUREMAP, self.DEF_MAP_TEMPLATE_ID, nMapId) ~= 1) then
				print("������������ͼ������ѩ�̣�����ʧ�ܡ���");
			end
		end
	end
	return 0;
end

--������ͼ��̬���سɹ�
function Esport:OnLoadMapFinish(nDyMapId, nMapId)
	self.tbDynMapLists[nMapId] = self.tbDynMapLists[nMapId] or {};
	table.insert(self.tbDynMapLists[nMapId], nDyMapId);
end
