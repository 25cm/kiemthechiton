--������(׼����)
--�����
--2008.12.25

-- ���ε�ͼ
do return end

Require("\\script\\mission\\esport\\esport_def.lua");

local tbMap = Map:GetClass(Esport.DEF_MAP_TEMPLATE_ID);

-- ������ҽ����¼�
function tbMap:OnEnter()

end

-- ��������뿪�¼�
function tbMap:OnLeave()
	--���������˳�,ֱ��return
	local tbPlayerInfo = Esport.tbPlayerLists[me.nId]
	if not tbPlayerInfo then
		return 0;
	end
	
	if not Esport.tbMissionLists[tbPlayerInfo[1]] then
		return 0;
	end
	
	if not Esport.tbMissionLists[tbPlayerInfo[1]][tbPlayerInfo[3]] then
		return 0;
	end
	
	if Esport.tbMissionLists[tbPlayerInfo[1]][tbPlayerInfo[3]]:IsOpen() ~= 1 then
		return 0;
	end
	if Esport.tbMissionLists[tbPlayerInfo[1]][tbPlayerInfo[3]]:GetPlayerGroupId(me) >= 0 then
		Esport.tbMissionLists[tbPlayerInfo[1]][tbPlayerInfo[3]]:KickPlayer(me, "Logout");
	end
end
