
-- ====================== �ļ���Ϣ ======================

-- ���칫��ڣ���� TRAP ��ű�
-- Edited by peres
-- 2008/03/04 PM 08:26

-- ������������ص�������
-- �������Լ��ļ�ͷ�����ȵ�����
-- �ǣ��ʵ����������������Ŀն���ο����ֻ��һ��һ�����е�Ů��
-- �����κ��ˣ��಻�������˻ᰮ��

-- ======================================================

local tbMap			= Map:GetClass(254);

local tbLevel_1		= tbMap:GetTrapClass("to_level2");
local tbLevel_2		= tbMap:GetTrapClass("to_level3");

-- �ӵ�һ���ϵ��ڶ���� Trap ��
function tbLevel_1:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	
	local nNum = 0;
	
	if tbInstancing.tbLightOpen then
		for j, i in pairs(tbInstancing.tbLightOpen) do
			print ("The tomb pillar: ", j, i);
			nNum = nNum + i;
		end;
		-- ��ջ�ƶ����ˣ�����ͨ��
		if nNum == 4 then
			return;
		end;
	end;
	
	-- ����ԭ��
	nNum = 0;
	me.NewWorld(nMapId, 1612, 3129);
	Dialog:SendInfoBoardMsg(me, "<color=red>����Ҫ����ĸ������ϵ��������ͨ����<color>");

end;

-- �ӵڶ����ϵ�������� Trap ��
function tbLevel_2:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	
	if not tbInstancing.nSmallBoss_1 or not tbInstancing.nSmallBoss_2 then
		me.NewWorld(nMapId, 1659, 3062);
		return;
	end;
	
	print("The tomb boss 1 & 2: ", tbInstancing.nSmallBoss_1, tbInstancing.nSmallBoss_2);
	
	-- ���� BOSS ��ɱ�ˣ�����ͨ��
	if tbInstancing.nSmallBoss_1 == 1 and tbInstancing.nSmallBoss_2 == 1 then
		return;
	else
		-- ����ԭ��
		me.NewWorld(nMapId, 1659, 3062);
		Dialog:SendInfoBoardMsg(me, "<color=red>һ��Ī���������������˻�����<color>");
	end;
end;
