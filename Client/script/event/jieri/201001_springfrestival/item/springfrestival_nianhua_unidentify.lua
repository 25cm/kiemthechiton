-- �ļ�������nianhua_unidentify.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-29 09:12:17
-- ��  ��  ��δ�������껭

local tbItem 	= Item:GetClass("picture_newyear");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};
tbItem.IdentifyDuration = Env.GAME_FPS * 10;		--�����껭�Ķ���ʱ��

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.VowTreeOpenTime or nData > SpringFrestival.VowTreeCloseTime then	--��ڼ���
		Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
		return;
	end
	Dialog:Say("�����������껭ô���������֪����ʮ����Ф���ĸ��껭�ˣ�������Ҫ�����500�㡣",
			{"ȷ������", self.Identify, self, it.dwId, 0},
			{"������"}
			);
end

--�����껭
function tbItem:Identify(nItemId, nFlag)
	--�ȼ��ж�
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s�������ܼ���������⣡",SpringFrestival.nLevel), {"֪����"});
		return;
	end
	--�����ж�
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("��Ҫ2�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	--�����ж�
	if me.dwCurGTP < SpringFrestival.nGTPMkPMin_NianHua or me.dwCurMKP < SpringFrestival.nGTPMkPMin_NianHua then
		Dialog:Say(string.format("���ľ���㣬��Ҫ�����%s�㡣", SpringFrestival.nGTPMkPMin_NianHua), {"֪����"});
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
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end
	local nNumber = MathRandom(12);
	local tbNianHua = SpringFrestival.tbNianHua_identify;
	local pItemEx = me.AddItem(tbNianHua[1], tbNianHua[2], tbNianHua[3], nNumber);
	if pItemEx then
		me.SetItemTimeout(pItemEx, 60*24*3, 0);	
		me.ChangeCurGatherPoint(-SpringFrestival.nGTPMkPMin_NianHua); 		--��500����
		me.ChangeCurMakePoint(-SpringFrestival.nGTPMkPMin_NianHua);		--��500����		
		local tbCouplet = SpringFrestival.tbNianHua_Unidentify;
		me.ConsumeItemInBags2(1, tbCouplet[1], tbCouplet[2], tbCouplet[3], tbCouplet[4], nil, -1);--ɾ��һ��δ�����Ĵ���
	
		EventManager:WriteLog("[�����������껭]�����껭��ü��������껭", me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�����������껭]�����껭��ü��������껭");
		
		--һ�����ʻ�����ֽ����е�һ��
		local nRant = MathRandom(100);
		for i = 1 ,#SpringFrestival.tbNianHua do
			if nRant > SpringFrestival.tbNianHua[i][2] and nRant <= SpringFrestival.tbNianHua[i][3]  then
				local pItem_EX = me.AddItem(unpack(SpringFrestival.tbNianHua[i][1]));
				EventManager:WriteLog(string.format("[�����������껭]��������Ʒ:%s", pItem_EX.szName), me);
				me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�����������껭]��������Ʒ:%s", pItem_EX.szName));
			end
		end	
	end
end
