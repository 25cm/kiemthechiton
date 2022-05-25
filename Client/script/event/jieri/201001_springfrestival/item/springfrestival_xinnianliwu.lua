-- �ļ�������xinnianliwu.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 17:12:56
-- ��  ��  ����������

local tbItem 	= Item:GetClass("gift_newyear");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbItem:OnUse()
	--local nData = tonumber(GetLocalDate("%Y%m%d"));
	--if nData < SpringFrestival.HuaDengOpenTime or nData > SpringFrestival.HuaDengCloseTime then	--��ڼ���
	--	Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
	--	return;
	--end
	
	--60Level
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s��������ʹ��������ߣ�", SpringFrestival.nLevel),{"֪����"});
		return;
	end	
	
	--����ж�
	if me.nTeamId == 0  then
		Dialog:Say("����ֻ�����͸����ѣ��㻹û����ء�", {"֪����"});
		return;		
	end
	
	--�����ж�
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("���͵��ߣ���ҪԤ��1�񱳰��ռ䣬ȥ��������ʹ�ðɡ�",{"֪����"});
		return;
	end	
	
	local tbOpt = {};
	local tbPlayerList = KTeam.GetTeamMemberList(me.nTeamId)
	for i = 1 , #tbPlayerList do
		local pPlayer = KPlayer.GetPlayerObjById(tbPlayerList[i]);
		if pPlayer and me.nId ~= tbPlayerList[i] then		
			table.insert(tbOpt, {string.format("%s",pPlayer.szName), self.Present, self, it.dwId, tbPlayerList[i]});		
		end
	end
	table.insert(tbOpt, {"ȡ��"});
	Dialog:Say("���͸����ѣ���ѡ��Ҫ���͵��ˡ�",tbOpt);
end

--��������
function tbItem:Present(nItemId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end
	local nMapId, nPosX, nPosY = me.GetWorldPos();	       		     
	local nMapId2, nPosX2, nPosY2	= pPlayer.GetWorldPos();
	local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
	if nMapId2 ~= nMapId or nDisSquare > 400 then
		Dialog:Say("���ѱ������⸽����");
		return 0;				 
	end
	--60Level
	if pPlayer.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("�Է��ȼ�����%s���������͸�����", SpringFrestival.nLevel),{"֪����"});
		return;
	end	
	--���ܶȲ���2��
	if me.GetFriendFavorLevel(pPlayer.szName) < 2 then
		Dialog:Say("����Է����ܶȲ���2������������δ����ͻ��",{"֪����"});			
		return;
	end
	--�Է����ܰ������
	local nCount = pPlayer.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_BAINIANNUMBER)
	if nCount >= SpringFrestival.nBaiNianCount then
		Dialog:Say("�����������ˣ��Է��Ѿ�������15���������",{"֪����"});			
		return;			
	end
	--�����ж�
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("���͵��ߣ���ҪԤ��1�񱳰��ռ䣬ȥ��������ʹ�ðɡ�",{"֪����"});
		return;
	end	
	if pPlayer.CountFreeBagCell() < 1 then
		Dialog:Say("���͵ĺ�����Ҫ��1�񱳰��ռ䣬�������������͸����ɣ�",{"֪����"});
		return;
	end
	
	pItem.Delete(me);	
	pPlayer.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_BAINIANNUMBER, nCount +1);
	
	Dialog:SendBlackBoardMsg(me, string.format("�������������͸���%s���Է��ܿ��ģ�",pPlayer.szName));
	Dialog:SendBlackBoardMsg(pPlayer, string.format("���յ�������%s����������濪�ģ�",me.szName));
	pPlayer.Msg(string.format("���Ѿ��յ�%s��������",nCount+1));
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData >= SpringFrestival.HuaDengOpenTime and nData <= SpringFrestival.HuaDengCloseTime then	--��ڼ�
		--���������Ʒ
		local nRant = MathRandom(100);
		for i = 1 ,#SpringFrestival.tbBaiAward do
			if nRant > SpringFrestival.tbBaiAward[i][2] and nRant <= SpringFrestival.tbBaiAward[i][3]  then
				local pItemEx = me.AddItem(unpack(SpringFrestival.tbBaiAward[i][1]));
				EventManager:WriteLog(string.format("[��������Ҽ����]�����Ѱ����������Ʒ:%s", pItemEx.szName), me);
				me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[��������Ҽ����]�����Ѱ����������Ʒ:%s", pItemEx.szName));
			end
		end
	end
	--����Է�(��������[����])
	local pItemEx = pPlayer.AddItem(unpack(SpringFrestival.tbBaiNianAward));
	pPlayer.SetItemTimeout(pItemEx, 60*24*30, 0);
	EventManager:WriteLog(string.format("[��������Ҽ����]��ú���%s���͵���������[����]", me.szName), pPlayer);
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[��������Ҽ����]��ú���%s���͵���������[����]", me.szName));
end

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = Lib:GetDate2Time(SpringFrestival.nOutTime + 10000); --����һ��
	it.SetTimeOut(0, nSec);
	return	{ };
end
