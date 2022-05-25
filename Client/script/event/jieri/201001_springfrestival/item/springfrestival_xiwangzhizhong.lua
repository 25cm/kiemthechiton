-- �ļ�������xiwangzhizhong.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-29 10:37:37
-- ��  ��  ��ϣ��֮��(��Ը�ı���Ʒ)

local tbItem 	= Item:GetClass("gift_wish");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};
tbItem.nTransferTime =  Env.GAME_FPS * 2;		--����ʱ��

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.VowTreeOpenTime or nData > SpringFrestival.VowTreeCloseTime then	--��ڼ���
		Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
		return;
	end
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s��������ʹ��������ߣ�", SpringFrestival.nLevel),{"֪����"});
		return;
	end	
	Dialog:Say("�������ϣ�������ӣ����Ե����������Ը�������������Ը������������Ը����",
			{"��ѯĿǰ��Ը���ϵ�Ը����", self.View, self},
			{"���͵���Ը����", self.Transfer, self, 0},
			{"��������"}
			);
end

--�鿴��Ը���ϵ�Ը������
function tbItem:View()
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_SPRINGFRESTIVAL_VOWNUM);
	Dialog:Say(string.format("��ǰ��Ը���ϵ�Ը������Ϊ��<color=yellow>%s<color>", nCount),{"֪����"});
end

--����
function tbItem:Transfer(nFlag)
	--ֻ����(city��faction��village��fight)��ͼ����
	local nPlayerMapId, nPosX, nPosY = me.GetWorldPos();	
	local szMapType = GetMapType(nPlayerMapId);
	if not SpringFrestival.tbTransferCondition[szMapType] then
		me.Msg("�˴�����ʹ�ø���Ʒ���ͣ�")
		return;
	end
	
	if nFlag == 1 then
		self:TransferEx();
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
		
	GeneralProcess:StartProcess("����", self.nTransferTime, {self.Transfer, self, 1}, nil, tbEvent);
end

--�����ɹ�newworld
function tbItem:TransferEx()
	me.NewWorld(unpack(SpringFrestival.tbVowTreePosition));
end

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = Lib:GetDate2Time(SpringFrestival.nOutTime)
	it.SetTimeOut(0, nSec);
	return	{ };
end
