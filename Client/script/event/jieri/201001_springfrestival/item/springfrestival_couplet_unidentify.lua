-- �ļ�������couplet_UnIdentify.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 16:03:45
-- ��  ��  ��δ�����Ķ���

local tbItem 	= Item:GetClass("distich");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};
tbItem.IdentifyDuration = Env.GAME_FPS * 10;		--����ʱ��

if MODULE_GAMESERVER then

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.HuaDengOpenTime or nData > SpringFrestival.HuaDengCloseTime then	--��ڼ���
		Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
		return;
	end	
	Dialog:Say("��Ҫ�����������ô����Ҫ���ľ����1000�㣬���������Ϳ���֪�����������ĸ��������ˡ�",
			{"ȷ������", self.Identify, self, it.dwId, 0},
			{"������"}
			);
end

--����
function tbItem:Identify(nItemId, nFlag)
	--�ȼ��ж�
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s�������ܼ���������⣡",SpringFrestival.nLevel), {"֪����"});
		return;
	end
	--�����ж�
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��Ҫ1�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	--�����ж�
	if me.dwCurGTP < SpringFrestival.nGTPMkPMin_Couplet or me.dwCurMKP < SpringFrestival.nGTPMkPMin_Couplet then
		Dialog:Say(string.format("���ľ���㣬��Ҫ�����%s�㡣", SpringFrestival.nGTPMkPMin_Couplet), {"֪����"});
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
		me.ChangeCurGatherPoint(-SpringFrestival.nGTPMkPMin_Couplet);	--��1000����
		me.ChangeCurMakePoint(-SpringFrestival.nGTPMkPMin_Couplet);	--��1000����
		local tbCouplet = SpringFrestival.tbCouplet_Unidentify;
		me.ConsumeItemInBags2(1, tbCouplet[1], tbCouplet[2], tbCouplet[3], tbCouplet[4], nil, -1);--ɾ��һ��δ�����Ķ���
		local  nTimes = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT) or 0;
		me.SetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT,nTimes + 1);
		local pItemEx = me.AddItem(unpack(SpringFrestival.tbCouplet_identify));--�����Ķ���
		if pItemEx then
			local nNumber = MathRandom(#SpringFrestival.tbCoupletList);
			local nPart = MathRandom(2);
			pItemEx.SetGenInfo(1, nNumber);		--�����Ǹ�����
			pItemEx.SetGenInfo(2, nPart);			--������������������
			pItemEx.Sync();
		end
		
		EventManager:WriteLog("[��������������]����������ü������Ķ���", me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[��������������]����������ü������Ķ���");
	end
end

end

function tbItem:GetTip()
	local nTimes = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT) or 0;
	return string.format("���Ѿ��������Ĵ�������%s", nTimes);
end
