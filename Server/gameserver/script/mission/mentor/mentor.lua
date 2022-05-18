-- �ļ�������menter.lua
-- �����ߡ���zhaoyu
-- ����ʱ�䣺2009/10/26 14:39:01
-- ��  ��  ��ʦͽ��������

Esport.Mentor = Esport.Mentor or {};
local Mentor = Esport.Mentor;
--Mentor.tbMissList = {};

Require("\\script\\mission\\mentor\\mentor_def.lua");

--����һ����ͼ����ʼ״̬
function Mentor:ResetMap(nDynMapId)

end

--�����븱��������
--1������������2
--2����ʦͽ��ϵ��ͽ��δ��ʦ�ҵȼ�С��ʦ����
--3��ͽ�ܸ������ȣ�������������
--4��������ͼ����δ��
--����������ʱ����1�����򷵻�0����ʾ��ʾ��Ϣ
function Mentor:CheckEnterCondition(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local nTeamId = pPlayer.nTeamId;
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId);
	if not anPlayerId or not nPlayerNum or nPlayerNum ~= 2 then 
		Dialog:Say("������ʦͽ������Ӳ��ܽ��룡");
		return 0;
	end
	
	--ȡ����������һ��Ա��Id
	local nOtherPlayerId = (anPlayerId[1] == pPlayer.nId) and anPlayerId[2] or anPlayerId[1];
	local pOtherPlayer = KPlayer.GetPlayerObjById(nOtherPlayerId);
	--�ж϶����������Ա���Ƿ���δ��ʦ��ʦͽ��ϵ
	if pOtherPlayer and pPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) ~= pOtherPlayer.szName 
		and pOtherPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) ~= pPlayer.szName then	
		Dialog:Say("��ȷ��������ʦͽ��ϵ��ͽ�ܻ�δ��ʦ��");
		return 0;
	end
	
	local aLocalPlayer, nLocalPlayerNum = me.GetTeamMemberList()
	if nPlayerNum ~= nLocalPlayerNum or pOtherPlayer.nMapId ~= pPlayer.nMapId then
		Dialog:Say("ʦ����ͽ��һͬǰ�����ܽ��븱������")
		return 0
	end
	
	--�ж϶������ĸ���ͽ��
	local pStudent = (self:CheckApprentice(pPlayer.nId) == 1) and pPlayer or pOtherPlayer;
	local pTeacher = (self:CheckMaster(pPlayer.nId) == 1) and pPlayer or pOtherPlayer;
	
	--ͽ�ܵĵȼ�����С��ʦ���ĵȼ�
	if pStudent.nLevel >= pTeacher.nLevel then
		Dialog:Say("ͽ�ܵĵȼ����ܴ���ʦ���ĵȼ���");
		return 0;
	end
	
	--�ж�ͽ���Ƿ��н���
	if self:GetDegree(pStudent.nId) == 0 then
		Dialog:Say("��ȷ��ͽ�ܵ����ҵ��ܻ��и������ȣ�");
		return 0;
	end

	--�жϸ�����ͼ�Ƿ�����
	if self:IsMapFull() == 1 then
		Dialog:Say("������ͼ����������������������");
		return 0;
	end
		
	return 1;
end

function Mentor:GetApprentice(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local nTeamId = pPlayer.nTeamId;
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId);
	if not anPlayerId or not nPlayerNum or nPlayerNum ~= 2 then 
		print("����������������")
		return nil;
	end
	
	--ȡ����������һ��Ա��Id
	local nOtherPlayerId = (anPlayerId[1] == pPlayer.nId) and anPlayerId[2] or anPlayerId[1];
	local pOtherPlayer = KPlayer.GetPlayerObjById(nOtherPlayerId);
	
	if not pOtherPlayer then
		return;
	end
	--�ж϶����������Ա���Ƿ���δ��ʦ��ʦͽ��ϵ
	if pPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) ~= pOtherPlayer.szName 
		and pOtherPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) ~= pPlayer.szName then	
		print("ʦͽ��ϵ��������")
		return nil;
	end
	
	--�ж϶������ĸ���ͽ��
	local pStudent = (self:CheckApprentice(pPlayer.nId) == 1) and pPlayer or pOtherPlayer;
	
	return pStudent;
end


function Mentor:GetMaster(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local nTeamId = pPlayer.nTeamId;
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId);
	if not anPlayerId or not nPlayerNum or nPlayerNum ~= 2 then 
		return nil;
	end
	
	--ȡ����������һ��Ա��Id
	local nOtherPlayerId = (anPlayerId[1] == pPlayer.nId) and anPlayerId[2] or anPlayerId[1];
	local pOtherPlayer = KPlayer.GetPlayerObjById(nOtherPlayerId);
	
	if not pOtherPlayer then
		return;
	end
	
	--�ж϶����������Ա���Ƿ���δ��ʦ��ʦͽ��ϵ
	if pPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) ~= pOtherPlayer.szName 
		and pOtherPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) ~= pPlayer.szName then	
		return nil;
	end
	
	--�ж϶������ĸ���ʦ��
	local pTeacher = (self:CheckMaster(pPlayer.nId) == 1) and pPlayer or pOtherPlayer;
	
	return pTeacher;
end

--����Ƿ��Ƕ����е�ͽ��
function Mentor:CheckApprentice(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local nTeamId = pPlayer.nTeamId;
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId);
	--�������������㸱������
	if not anPlayerId or not nPlayerNum or nPlayerNum ~= 2 then
		return 0;
	end
	
	local nOtherPlayerId = anPlayerId[1] == nPlayerId and anPlayerId[2] or anPlayerId[1];
	local pOtherPlayer = KPlayer.GetPlayerObjById(nOtherPlayerId);
	if not pOtherPlayer then 
		return 0;
	end
	
	if pPlayer.GetTrainingTeacher() ~= pOtherPlayer.szName then
		return 0;
	end

	return 1;
end

--����Ƿ��Ƕ����е�ʦ��
function Mentor:CheckMaster(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local nTeamId = pPlayer.nTeamId;
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId);
	--�������������㸱������
	if not anPlayerId or not nPlayerNum or nPlayerNum ~= 2 then
		return 0;
	end
	
	local nOtherPlayerId = anPlayerId[1] == nPlayerId and anPlayerId[2] or anPlayerId[1];
	local pOtherPlayer = KPlayer.GetPlayerObjById(nOtherPlayerId);
	
	if not pOtherPlayer then
		return 0;
	end
	
	if pPlayer.szName ~= pOtherPlayer.GetTrainingTeacher() then
		return 0;
	end
	
	return 1;
end

--��ȡ�������ȣ�����1��2��3
--����0ʱ��ʾ��ǰ���ܽ��븱��
function Mentor:GetDegree(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	
	local bSetDaily, bSetWeekly = 0, 0;	--Ҫ��Ҫ�ȸ�����/�ܽ��� (1ΪҪ��0Ϊ��Ҫ)
	local nLastDayTime = pPlayer.GetTask(self.nGroupTask, self.nSubLastDayTime);
	local nLastWeekTime = pPlayer.GetTask(self.nGroupTask, self.nSubLastWeekTime);
	
	local nNowTime = GetTime();
	if 0 ~= nLastDayTime then
		local nLastTime_day = Lib:GetLocalDay(nLastDayTime);
		local nNowTime_day	= Lib:GetLocalDay(nNowTime);
		if nNowTime_day - nLastTime_day >= 1 then
			bSetDaily = 1;	
		end
	else
		bSetDaily = 1;
	end
	
	if 0 ~= nLastWeekTime then
		local nLastTime_week = Lib:GetLocalWeek(nLastWeekTime);
		local nNowTime_week = Lib:GetLocalWeek(nNowTime);
		if nNowTime_week - nLastTime_week >= 1 then
			bSetWeekly = 1;
		end
	else
		bSetWeekly = 1;
	end
	
	if bSetDaily == 1 then
		pPlayer.SetTask(self.nGroupTask, self.nSubLastDayTime, nNowTime);
		self:ResetDailyTask(nPlayerId);
	end
	
	if bSetWeekly == 1 then
		pPlayer.SetTask(self.nGroupTask, self.nSubLastWeekTime, nNowTime);
		self:ResetWeeklyTask(nPlayerId);
	end
	
	local nDailyRemain  = pPlayer.GetTask(self.nGroupTask, self.nSubDailyTimes);			--����ʣ�����
	local nWeeklyRemain = pPlayer.GetTask(self.nGroupTask, self.nSubWeeklyTimes);			--����ʣ�����
	local nCurDegree 	= pPlayer.GetTask(self.nGroupTask, self.nSubCurDegree);				--��ǰ�ܽ���
	
	--������ջ���ܵ�ʣ�����Ϊ0�����ܽ��븱�� 
	if nDailyRemain <= 0 or nWeeklyRemain <= 0 or nCurDegree > self.WEEKLY_SCHEDULE then
		return 0;
	end
	
	
	return pPlayer.GetTask(self.nGroupTask, self.nSubCurDegree);
end

function Mentor:GetMission(pNpc)
	if not pNpc then
		print("��Ч��NPC����")
		return;
	end
	
	local nId = 0;
	if pNpc.nId then		--����Ҷ���
		nId = pNpc.nId;
	elseif pNpc.dwId then	--��NPC����
		nId = pNpc.dwId;
	else					--���ᵽ�������ɡ�
		return;
	end
	
	for i = 1, Mentor.MAX_MAP_COUNT do
		if Mentor.tbMissList[i].nApprenticePlayerId == nId 
			or Mentor.tbMissList[i].nMasterPlayerId == nId 
			or Mentor.tbMissList[i].dwProtecNpcId == nId then
				return Mentor.tbMissList[i];
		end
	end
end

function Mentor:SetGame1(tbMission)

end

function Mentor:SetGame2(tbMission)

end

function Mentor:SetGame3(tbMission)

end

function Mentor:GetNpcList(nStep)
	
end

--�жϸ������������Ƿ��Ѵ����ޣ�����1�ǣ�0��
function Mentor:IsMapFull()
	for _, tbMiss in pairs(self.tbMissList) do
		if (tbMiss.nUsed == 0) then
			return 0;
		end
	end
	
	return 1;
end

--ÿ��0������FB����
function Mentor:ResetDailyTask(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	
	--ֻ�е���ǰ�����ͽ�ܣ���ʦ����δ��ʦ����ʱ�򣬿��������������
	if pPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) then	
		pPlayer.SetTask(self.nGroupTask, self.nSubDailyTimes, self.DAILY_SCHEDULE);	--ÿ��ɽ�FBһ��
	end
end

--ÿ������FB����
function Mentor:ResetWeeklyTask(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	--ֻ�е���ǰ�����ͽ�ܣ���ʦ����δ��ʦ����ʱ�򣬿��������������
	if pPlayer.GetTrainingTeacher(self.RELATIONTYPE_TRAINING) then
		pPlayer.SetTask(self.nGroupTask, self.nSubWeeklyTimes, self.WEEKLY_SCHEDULE);	--ÿ�ܿɽ���������
		pPlayer.SetTask(self.nGroupTask, self.nSubCurDegree, 1);		--ÿ�ܽ������ã�����1��ʼ
	end
end

function Mentor:Init()
	Mentor.tbMissList = {};
	for i = 1, Mentor.MAX_MAP_COUNT do
		local tbMis = Lib:NewClass(Esport.MentorMission);
		if (Map:LoadDynMap(Map.DYNMAP_TREASUREMAP, Mentor.TEMPLATE_MAP_ID, {self.OnLoadMapFinish, self, i}) ~= 1) then
			Dbg:WriteLog("Mentor_shitufuben", "ʦͽ������ͼ����ʧ�ܡ�", i);
		else
			table.insert(Mentor.tbMissList, tbMis);
			tbMis.nMisIndex = i;
		end
	end
end

function Mentor:PreStartMission()
	assert(me);
	if self:CheckEnterCondition(me.nId) == 1 then
		local tbMiss = self:AllocMission();
		if tbMiss then
			tbMiss:Open();
			return 1;
		else
			return 0;
		end			
	end
end

function Mentor:AllocMission()
	for _, tbMis in pairs(Mentor.tbMissList) do
		if (tbMis.nUsed == 0) then
			tbMis.nUsed = 1;
			return tbMis;
		end
	end
end

function Mentor:ReleaseMission(tbMis)
	if (tbMis.nUsed == 1) then
		tbMis.nUsed = 0;
	end
end

function Mentor:OnLoadMapFinish(nMisIndex, nDynMapId)
	local tbMis = Mentor.tbMissList[nMisIndex];
	tbMis:OnStart(nDynMapId);
	tbMis.nUsed = 0;
end

function Mentor:LoadSetting()
	Mentor.tbSetting = Lib:LoadTabFile("\\setting\\mission\\mentor\\mentor.txt");
end

Mentor:LoadSetting();

if MODULE_GAMESERVER then
	--ע��GS�����¼���ͬ����ͼ���ñ�
	ServerEvent:RegisterServerStartFunc(Mentor.Init, Mentor);
	
	--ע�����������ʱ�޸Ļص�
	--PlayerSchemeEvent:RegisterGlobalDailyEvent({Mentor.ResetDailyTask, Mentor});	--ע��ÿ������FB���ȵĻص�
	--PlayerSchemeEvent:RegisterGlobalWeekEvent({Mentor.ResetWeeklyTask, Mentor});	--ע��ÿ������FB���ȵĻص�
end