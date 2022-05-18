-- �ļ�������toweritem.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-10 16:42:59
-- ��  ��  ��

local tbTower = Item:GetClass("tower_Item");
function tbTower:OnUse()
	local tbPlayerTempTable = me.GetPlayerTempTable();
	local tbMission = tbPlayerTempTable.tbMission;	
	
	if tbMission:IsOpen() ~= 1 then
		me.Msg("ʱ�����ԣ���ʹ�ò��ˣ�")
		return 0;
	end
	--�ڶ��׶η��ؽ׶β�����ֲ��
	if tbMission.nStateJour > 3 then
		me.Msg("ʱ�����ԣ����ڲ���ʹ�������");
		return 0;
	end
	local nFlag , nId = tbMission:CheckeUseItem(me.nId);
	
	if nFlag  == 0 then
		me.Msg("�ô�������ֲ�");
		return 0;
	end
	if tbMission:AddTower(me.nId, nId, it.dwId) == 1 then
		return 1;
	end
	return 0;
end


