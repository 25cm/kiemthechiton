-------------------------------------------------------------------
--File: xmas_snowheap.lua
--Author: fenghewen
--Date: 2008-5-19 09:59
--Describe: ѩ��NPC�ű�
-------------------------------------------------------------------
if  MODULE_GC_SERVER then
	return;
end
local tbSnowHeapNpc = Npc:GetClass("xmas_snowheap");
tbSnowHeapNpc.nNpcId = 3471;		-- ѩ��npc��Id  --����
tbSnowHeapNpc.nDelayTime = 2;		-- ��������ȡ����
--tbSnowHeapNpc.tbSnowItem = {18,1,537,1};		--Сѩ��
tbSnowHeapNpc.tbSnowItem = {22,1,45,1};		--Сѩ��

-- ���ʰȡ���¼�
local tbEvent = 
{
	Player.ProcessBreakEvent.emEVENT_MOVE,
	Player.ProcessBreakEvent.emEVENT_ATTACK,
	Player.ProcessBreakEvent.emEVENT_SITE,
	Player.ProcessBreakEvent.emEVENT_USEITEM,
	Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
	Player.ProcessBreakEvent.emEVENT_DROPITEM,
	Player.ProcessBreakEvent.emEVENT_SENDMAIL,
	Player.ProcessBreakEvent.emEVENT_TRADE,
	Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
	Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
	Player.ProcessBreakEvent.emEVENT_LOGOUT,
	Player.ProcessBreakEvent.emEVENT_DEATH,
}

-- ����: ʰȡѩ�ѽ�������ִ��self.nDelayTime�����ʱ
function tbSnowHeapNpc:OnDialog()
	local nCheck = SpecialEvent.Xmas2008:Check();
	if nCheck ~= 1 then
		Dialog:Say(string.format("�ô�һ��ѩ���������������������������Ҳûʲô�á�"));
		return 0;
	end	
	local tbTmp = him.GetTempTable("Npc");
	if tbTmp.nMaxUse and tbTmp.nMaxUse <= 0 then
		Dialog:Say(string.format("��������ȥ��û�����κ�Сѩ�š�"));
		return 0;
	end
	local tbNpcTemp = him.GetTempTable("Npc");
	
	if not tbNpcTemp.tbPlayerList then
		tbNpcTemp.tbPlayerList = {};
	end
	local tbPlayerList = tbNpcTemp.tbPlayerList;
	if tbPlayerList[me.nId] == 1 then
		Dialog:Say("�Һ����Ѿ��ü�Сѩ���ˣ����Ǹ���������ɡ�");
		return 0;
	end		
	if me.CountFreeBagCell() < 1 then
		me.Msg("��ı����ռ䲻��!");
		return 0;
	end
	
	-- ������
	GeneralProcess:StartProcess("ѩ��ʰȡ��...", self.nDelayTime * Env.GAME_FPS, {self.DoPickUp, self, him.dwId}, nil, tbEvent);
end

function tbSnowHeapNpc:DoPickUp(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	local tbNpcTemp = pNpc.GetTempTable("Npc");
	
	if not tbNpcTemp.tbPlayerList then
		tbNpcTemp.tbPlayerList = {};
	end
	local tbPlayerList = tbNpcTemp.tbPlayerList;
	
	if tbPlayerList[me.nId] == 1 then
		Dialog:Say("�Һ����Ѿ��ü�Сѩ���ˣ����Ǹ���������ɡ�");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��ı����ռ䲻��!")
		return 0;
	end
	
	-- ��Сѩ��
	local nNum = MathRandom(1, 9);
	local nG, nD, nP, nL = unpack(self.tbSnowItem);
	me.AddStackItem(nG, nD, nP, nL, {bTimeOut=1}, nNum);
	tbPlayerList[me.nId] = 1;
	
	local tbTmp = pNpc.GetTempTable("Npc");
	if tbTmp.nMaxUse and tbTmp.nMaxUse <= 0 then
		tbTmp.nMaxUse = tbTmp.nMaxUse - 1;
	end
end
