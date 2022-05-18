--������(����������)
--�����,���ǽ�
--2008.12.25

--��������
function Esport:OpenSingleUi(pPlayer, szMsg, nLastFrameTime)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:SetBattleTimer(pPlayer,  szMsg, nLastFrameTime);
	Dialog:ShowBattleMsg(pPlayer,  1,  0); --��������
end

--�رս���
function Esport:CloseSingleUi(pPlayer)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:ShowBattleMsg(pPlayer,  0,  0); -- �رս���
end

--���½���ʱ��
function Esport:UpdateTimeUi(pPlayer, szMsg, nLastFrameTime)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:SetBattleTimer(pPlayer,  szMsg, nLastFrameTime);
end

--���½�����Ϣ
function Esport:UpdateMsgUi(pPlayer, szMsg)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:SendBattleMsg(pPlayer, szMsg);
end

--�μ�һ�α���
function Esport:ConsumeTask(pPlayer)
	--�ܳ��Σ�1
	pPlayer.SetTask(self.TSK_GROUP, self.TSK_ATTEND_TOTAL, pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_TOTAL) + 1);
	
	--������1
	local nCount = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT);
	local nExCount = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_EXCOUNT)
	if nCount > 0 then
		pPlayer.SetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT, nCount - 1);
		return 1;
	end
	if nExCount > 0 then
		pPlayer.SetTask(self.TSK_GROUP, self.TSK_ATTEND_EXCOUNT, nExCount - 1);
		return 1;
	end	
	return 0;
end

--buffɾ����bug,�޸�
function Esport:RepairSkillBuff()
	if me.IsHaveSkill(1312) == 1 then
		me.DelFightSkill(1312);
	end	
end

function Esport:TaskDayEvent()
	if self:CheckState() == 0 then
		return 0;
	end
	
	self:RepairSkillBuff();	--buffɾ����bug,��½�޸�
	
	local nNowDay 	=  Lib:GetLocalDay(GetTime())
	local nKeepDay  =  me.GetTask(self.TSK_GROUP, self.TSK_ATTEND_DAY);
		
	if me.nLevel < self.DEF_PLAYER_LEVEL or me.nFaction <= 0 then
		if me.nLevel < self.DEF_PLAYER_LEVEL then
			me.SetTask(self.TSK_GROUP, self.TSK_ATTEND_DAY, (nNowDay - 1));
			me.SetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT, 0);
		end
		return 0;
	end

	if nKeepDay <= 0 then
		nKeepDay = Lib:GetLocalDay(Lib:GetDate2Time(self.SNOWFIGHT_STATE[1])) - 1;
	end
	if (nNowDay - nKeepDay) > 0 then
	local nCount = me.GetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT) + self.DEF_PLAYER_COUNT * (nNowDay - nKeepDay);
		if nCount > self.DEF_PLAYER_KEEP_MAX then
			nCount = self.DEF_PLAYER_KEEP_MAX;
		end
		me.SetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT, nCount);
		me.SetTask(self.TSK_GROUP, self.TSK_ATTEND_DAY, nNowDay);
		self:WriteLog("���Ӵ�����"..nCount, me.nId);
	end
end

if (MODULE_GAMESERVER) then
--��ҵ�½ִ�к��������

PlayerEvent:RegisterOnLoginEvent(Esport.TaskDayEvent, Esport);

end
