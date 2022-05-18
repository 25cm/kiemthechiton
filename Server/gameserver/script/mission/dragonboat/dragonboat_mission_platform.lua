EPlatForm.BoatFight = EPlatForm.BoatFight or {};

function EPlatForm.BoatFight:GetNewMission()
	return Lib:NewClass(EPlatForm.BoatFight);	
end

-- nMatchType ��ʾ������ǻ�ս�������pvp
-- ���ǻ�ս��ô����2
-- �������pvp����3,4
function EPlatForm.BoatFight:OpenMission(tbEnterPos, tbLeavePos, nMatchType, nReadyId)
	self.tbMission = self.tbMission or Lib:NewClass(Esport.DragonBoatMission);
	self.tbMission:OpenMission(tbEnterPos, tbLeavePos, nMatchType);
	self.tbMission.tbCallbackOnClose = {self.OnMissionClose, self};
	self.tbEnterPos = tbEnterPos;
	self.nTaskId = nTaskId;
	self.tbTeamId = {};
	self.tbGroupId2LeageName = {};
	self.tbLeageName2PlayerList = {};
	self.nGroupCount = 0;
	self.nGroupId = 1;
	self.nMatchType = nMatchType;
	self.nReadyId = nReadyId or 0;
end

function EPlatForm.BoatFight:IsOpen()
	if (self.tbMission and self.tbMission.IsOpen) then
		return self.tbMission:IsOpen();
	end
	return 0;
end

function EPlatForm.BoatFight:StartGame()
	self.tbMission:OnStart();
end

--�����ӱ�
function table.subfind(tbSrc, key, value)
	for _k, _v in pairs(tbSrc) do
		if _v[key] == value then
			return _k, _v;
		end
	end
	return nil;
end

function EPlatForm.BoatFight:OnMissionClose()
	local tbRes = self.tbMission:GetResult();
	local tbScore = { 10,8,7,6,5,4,3,1 };
	if not tbRes then
		return;
	end

	local tbResFinal = {}; --[1]=szLeagueName tbPlayerList
	if (self.nMatchType == EPlatForm.DEF_STATE_MATCH_1) then
		for nPlace, tbInfo in ipairs(tbRes) do
			local tbPerson = {}; --������������һ���˵Ľ��
			tbPerson.szLeagueName = tbInfo.szName;
			tbPerson.tbPlayerList = { tbInfo.szName };
			tbPerson.nDamage = tbScore[nPlace];
			table.insert(tbResFinal, tbPerson)
		end
	elseif (self.nMatchType == EPlatForm.DEF_STATE_MATCH_2 or self.nMatchType == EPlatForm.DEF_STATE_ADVMATCH) then
		for _, tbInfo in ipairs(tbRes) do
		 	--�����������һ����Ľ��
			local _, tbGroup = table.subfind(tbResFinal, "nGroupId", tbInfo.nGroupId);
			if tbGroup == nil then
				tbGroup = {};
				tbGroup.szLeagueName = self.tbGroupId2LeageName[tbInfo.nGroupId];
				tbGroup.nGroupId = tbInfo.nGroupId;
				tbGroup.tbPlayerList = self.tbLeageName2PlayerList[tbGroup.szLeagueName];
				tbGroup.nDamage = 0;
				table.insert(tbResFinal, tbGroup)
			end
			if (tbGroup and tbGroup.szLeagueName and tbGroup.tbPlayerList) then
				local nPlace = tbInfo.nRank or 0;
				tbGroup.nDamage = tbGroup.nDamage + tbScore[nPlace] or 0;
			end
		end
	end
	table.sort(tbResFinal, function (lhl, rhl)
		return lhl.nDamage > rhl.nDamage;
	end);

	self.__tbResFinal = tbResFinal;
	EPlatForm:SendResult(tbResFinal, self.nReadyId);
end

function EPlatForm.BoatFight:GetEnterPos()
	return self.tbEnterPos;
end

function EPlatForm.BoatFight:GetGroupCount()
	return self.nGroupCount or 0;
end

function EPlatForm.BoatFight:JoinGame(tbGroup, nCampId, tbJoinItem)
	self.tbLeageName2PlayerList[tbGroup.szLeagueName] = tbGroup.tbPlayerList;

	local tbPlayer = {};
	for _, nId in ipairs(tbGroup.tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			table.insert(tbPlayer, pPlayer);
		end
	end
	
	if #tbPlayer > 0 then
		KTeam.CreateTeam(tbPlayer[1].nId);
		for i = 2, #tbPlayer do
			KTeam.ApplyJoinPlayerTeam(tbPlayer[1].nId, tbPlayer[i].nId);
		end
		
		for _, pPlayer in ipairs(tbPlayer) do
			local tbFind = {};
			-- ��֤������ʱ��ֻ��һ������
			for _, tbItemInfo in pairs(tbJoinItem) do
				if (tbItemInfo.tbItem) then
					tbFind = pPlayer.FindItemInBags(unpack(tbItemInfo.tbItem));
					if (tbFind and #tbFind > 0) then
						break;
					end
				end	
			end
		
			local pItem = tbFind[MathRandom(1,#tbFind)].pItem;
			self.tbMission.tbSkillList = self.tbMission.tbSkillList or {};
			self.tbMission.tbSkillList[pPlayer.nId] = pItem.dwId;
			self.tbMission:JoinPlayer(pPlayer, self.nGroupId);	
		end
		
		self.tbMission:AddGroupName(tbPlayer[1], self.nGroupId, tbGroup.szLeagueName);
		self.tbGroupId2LeageName[self.nGroupId] = tbGroup.szLeagueName;
		self.nGroupId = self.nGroupId + 1;
		self.nGroupCount = self.nGroupCount + 1;
	end
end

function EPlatForm.BoatFight:CloseGame()
	self.tbMission:OnGameOver();
end

function EPlatForm.BoatFight:GetPlayerGroupId(pPlayer)
	if (not pPlayer) then
		return -1;
	end
	
	if (not self.tbMission) then
		return -1;
	end
	
	if (not self.tbMission.GetPlayerGroupId) then
		return -1;
	end
	return self.tbMission:GetPlayerGroupId(pPlayer);
end

function EPlatForm.BoatFight:KickPlayer(pPlayer)
	if (not pPlayer) then
		return -1;
	end
	
	if (not self.tbMission) then
		return -1;
	end
	
	if (not self.tbMission.KickPlayer) then
		return -1;
	end
	return self.tbMission:KickPlayer(pPlayer);
end

-- ?pl DoScript("\\script\\mission\\esport\\esport_mission_eplatform.lua")
