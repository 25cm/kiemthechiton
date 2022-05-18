--������(׼����)
--�����
--2008.12.25

-- ���ε�ͼ
do return end;

Require("\\script\\mission\\esport\\esport_def.lua");


local tbMap = {};

-- ������ҽ����¼�
function tbMap:OnEnter()
	if Esport.nReadyTimerId > 0 then
		Esport:OnEnterReady(me);
		GlobalExcute{"Esport:OnJoinReady", me.nId};
		GCExcute{"Esport:OnJoinReady", me.nId};
		local nLastFrameTime = Timer:GetRestTime(Esport.nReadyTimerId);
		if Esport.nReadyState == 0 then
			nLastFrameTime = nLastFrameTime + Esport.DEF_READY_TIME2;
		end
		Esport:OpenSingleUi(me, Esport.DEF_READY_MSG, nLastFrameTime);
		Esport:UpdateMsgUi(me, "");	
		return 0;
	end
	local nLeaveMapId, nLeavePosX, nLeavePosY = Esport:GetLeavePos();
	me.NewWorld(nLeaveMapId, nLeavePosX, nLeavePosY);
end

-- ��������뿪�¼�
function tbMap:OnLeave()
	--���������˳�,ֱ��return
	if not Esport.tbPlayerLists[me.nId] or Esport.tbPlayerLists[me.nId][3] > 0 then
		return 0;
	end
	me.TeamApplyLeave();			--�뿪����
	Esport:OnLeaveReady(me);
	Esport:CloseSingleUi(me);	
	GCExcute{"Esport:LeaveGroupList", me.nId};
	GlobalExcute{"Esport:LeaveGroupList", me.nId};
end

for _, nMapId in pairs(Esport.DEF_READY_MAP) do
	local tbBattleMap = Map:GetClass(nMapId);
	for szFnc in pairs(tbMap) do
		tbBattleMap[szFnc] = tbMap[szFnc];
	end
end
