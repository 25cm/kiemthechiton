--��������������
--sunduoliang
--2008.12.30

--��������
--nResult:1 Aʤ, 2A��, 3 ƽ
function TowerDefence:AwardSingleSport(tbListA, tbListB, nResult, tbGrade_player)
	
	--ƽ
	if nResult == 3 then
		for _, nId in pairs(tbListA) do
			local pPlayer = KPlayer.GetPlayerObjById(nId);
			if pPlayer then
				self:AwardSingleTie(pPlayer)
			end
		end
		
		for _, nId in pairs(tbListB) do
			local pPlayer = KPlayer.GetPlayerObjById(nId);
			if pPlayer then
				self:AwardSingleTie(pPlayer)
			end
		end				
		return 0;
	end
	
	local tbWin = tbListA;	
	local tbLost = tbListB;
	local tbWin_Ex = tbGrade_player[1];
	local tbList_Ex = tbGrade_player[2];
	--ʤ��
	if nResult == 2 then
		tbWin = tbListB;
		tbLost = tbListA;
		tbWin_Ex = tbGrade_player[2];
		tbList_Ex = tbGrade_player[1];
	end
	
	for _, nId in pairs(tbWin) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			local nGrade = self:FindTb(tbWin_Ex, pPlayer.szName);
			self:AwardSingleWin(pPlayer,nGrade)
		end
	end
	
	for _, nId in pairs(tbLost) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			local nGrade = self:FindTb(tbList_Ex, pPlayer.szName);
			self:AwardSingleLost(pPlayer,nGrade)
		end
	end
end

function TowerDefence:AwardSingleWin(pPlayer,nGrade)
	pPlayer.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_AWARD, nGrade);
	pPlayer.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_WIN, pPlayer.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_WIN) + 1);
	self:AddHonor(pPlayer.szName, self.DEF_POINT_WIN);	
	pPlayer.Msg("��ϲ���������ʤ��")
	self:WriteLog("��ϲ���������ʤ��", pPlayer.nId);
end

function TowerDefence:AwardSingleLost(pPlayer,nGrade)
	if nGrade == 1 then
		pPlayer.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_AWARD, 3);
	end
	self:AddHonor(pPlayer.szName, self.DEF_POINT_LOST);
	pPlayer.Msg("���ź���������ڱ���������ʧ���ˣ��´μ������͡�");
	self:WriteLog("��ϲ���������ʧ��", pPlayer.nId);
end

function TowerDefence:AwardSingleTie(pPlayer)
	pPlayer.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_TIE, pPlayer.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_TIE) + 1);	
	self:AddHonor(pPlayer.szName, self.DEF_POINT_TIE);
	pPlayer.Msg("���ź���������ڱ��������кͶ��ִ�ƽ�ˣ��´μ������͡�");
	self:WriteLog("��ϲ���������ƽ��", pPlayer.nId);
end

function TowerDefence:FindTb(tbGrade,szName)
	for i, _ in ipairs(tbGrade) do
		if tbGrade[i][1] == szName then
			return i;
		end
	end
end
