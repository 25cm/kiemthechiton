-- �ļ�������canteen.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-15 15:01:53
-- ��  ��  ��ˮ���ű�

local tbCanteen = Item:GetClass("tower_canteen");

function tbCanteen:OnUse(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		me.Msg("�Բ�����û��Ŀ���ǲ���ʹ�õģ�")
		return 0;
	end
	local tbPlayerTempTable = me.GetPlayerTempTable();
	local tbMission = tbPlayerTempTable.tbMission;	
	
	if tbMission:IsOpen() ~= 1 then
		me.Msg("ʱ�����ԣ���ʹ�ò��ˣ�")
		return 0;
	end	
	
	local nFlag  =  tbMission:CheckTower(nNpcId, me.nId) ;
	local tbMsg ={
		 [0]="ֻ�ж�ֲ�����ʹ�ø��";
		 [2]="��ֲ�ﲻ�����Ƕ���ģ���ˮ���������ﰡ��";
		}
	if nFlag ~= 1 then
		me.Msg(tbMsg[nFlag]);
		return 0;
	end
	local nMapId, nX, nY = pNpc.GetWorldPos();
	local _, nX2, nY2 = me.GetWorldPos();
	local nDistance = (nX2 - nX) * (nX2 - nX) + (nY2 - nY) * (nY2 - nY);
	if nDistance > 30 then
		me.Msg("Ҫ����ֲ�����ʹ��Ŷ");
		return;
	end
	if pNpc.nCurLife  < pNpc.nMaxLife then
		self:ChangeTowerLife(pNpc);
		return 1;
	end
	me.Msg("��ֲ���Ѿ���Ѫ�ˣ����ǲ�Ҫ�˷�ˮ����");
	return ;
end

function tbCanteen:OnClientUse()
	local pNpc = me.GetSelectNpc();
	if not pNpc then
		return 0;
	end
	return pNpc.dwId;
end

function tbCanteen:ChangeTowerLife(pNpc)
	pNpc.CastSkill(1621,1,-1,pNpc.nIndex);
end
