-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(215); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ��������---21��ȥ���⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(102,1722,3790)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
	
	end;