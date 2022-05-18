function GeneralProcess:GetPlayerProcessData(pPlayer)
	local tbPlayerData		= pPlayer.GetTempTable("GeneralProcess");
	local tbProcessData		= tbPlayerData.tbProcessData;
	if (not tbProcessData) then
		tbProcessData	= {
		};
		tbPlayerData.tbProcessData	= tbProcessData;
	end;
	
	return tbProcessData;
end;

-- S
function GeneralProcess:StartProcess(szTxt, nIntervalTime, tbSucCallBack, tbBreakCallBack, tbEvent)
	assert(nIntervalTime > 0);
	assert(szTxt)
	me.CloseGenerProgress();
	local tbProcessData = self:GetPlayerProcessData(me);
	tbProcessData.tbSucCallBack = tbSucCallBack;
	tbProcessData.tbBreakCallBack = tbBreakCallBack;
	
	me.StartGenerProgress(szTxt, nIntervalTime, unpack(tbEvent));
end;

-- S 对某个玩家执行进度条
function GeneralProcess:StartProcessOnPlayer(pPlayer, szTxt, nIntervalTime, tbSucCallBack, tbBreakCallBack, tbEvent)
	assert(nIntervalTime > 0);
	assert(szTxt)
	pPlayer.CloseGenerProgress();
	local tbProcessData = self:GetPlayerProcessData(pPlayer);
	tbProcessData.tbSucCallBack = tbSucCallBack;
	tbProcessData.tbBreakCallBack = tbBreakCallBack;
	
	pPlayer.StartGenerProgress(szTxt, nIntervalTime, unpack(tbEvent));
end;

-- S
function GeneralProcess:OnProgressFull()
	local tbCallBack = self:GetPlayerProcessData(me).tbSucCallBack;
	
	if (not tbCallBack) then
		return;
	end
	
	Lib:CallBack(tbCallBack);
end;

-- S
function GeneralProcess:OnBreak()
	local tbCallBack = self:GetPlayerProcessData(me).tbBreakCallBack;
	
	if (not tbCallBack) then
		return;
	end
	
	Lib:CallBack(tbCallBack);
end
