-- �ļ�������mingyang_unidentify.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-31 14:16:02
-- ��  ��  ��

local tbItem 	= Item:GetClass("mingyang_unidentify");
SpecialEvent.LaborDay = SpecialEvent.LaborDay or {};
local LaborDay = SpecialEvent.LaborDay or {};
tbItem.IdentifyDuration = Env.GAME_FPS * 10;		--����ʱ��

if MODULE_GAMESERVER then

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < LaborDay.OpenTime or nData > LaborDay.CloseTime then	--��ڼ���
		Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
		return;
	end	
	Dialog:Say("��Ҫ�����������ô����Ҫ���ľ����2��㡣",
			{"ȷ������", self.Identify, self, it.dwId, 0},
			{"������"}
			);
end

--����
function tbItem:Identify(nItemId, nFlag)	
	--�����ж�
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��Ҫ1�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	--�����ж�
	if me.dwCurGTP < LaborDay.nGTPMkPMin_Couplet or me.dwCurMKP < LaborDay.nGTPMkPMin_Couplet then
		Dialog:Say(string.format("���ľ���㣬��Ҫ�����%s�㡣", LaborDay.nGTPMkPMin_Couplet), {"֪����"});
		return;
	end
	--ִ��
	if nFlag == 1 then
		self:SuccessIdentify(nItemId);
		return;
	end
	
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
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
		
	GeneralProcess:StartProcess("����...", self.IdentifyDuration, {self.Identify, self,  nItemId, 1}, nil, tbEvent);
end

--�����ɹ�
function tbItem:SuccessIdentify(nItemId)	
	local pItem = KItem.GetObjById(nItemId)	
	if pItem then
		local nLevel = pItem.nLevel;
		me.ChangeCurGatherPoint(-LaborDay.nGTPMkPMin_Couplet);	--��2w����
		me.ChangeCurMakePoint(-LaborDay.nGTPMkPMin_Couplet);	--��2w����
		pItem.Delete(me);--ɾ��һ��δ������		
		local pItemEx = me.AddItem(LaborDay.tbmingyang_identify[1], LaborDay.tbmingyang_identify[2], LaborDay.tbmingyang_identify[3], nLevel);
		if pItemEx then	
			EventManager:WriteLog(string.format("[�Ͷ��� ����Ӣ��]�������ӻ��%s",pItemEx.szName), me);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�Ͷ��� ����Ӣ��]�������ӻ��%s",pItemEx.szName));
		end
	end
end

end
