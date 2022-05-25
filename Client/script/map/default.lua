
local tbMapBase	= Map.tbMapBase;

tbMapBase.tbTraps		= nil;	-- Trap点类库

function tbMapBase:CallParam(tbSwitchExec, bIn)
	for _, fnCallBack in pairs(tbSwitchExec) do
		 Lib:CallBack({fnCallBack, Map.tbSwitchs, bIn});
	end
end

function tbMapBase:OnEnterState(tbSwitchExec)
	self:CallParam(tbSwitchExec, 1);	-- 通用开关
end

function tbMapBase:RegisterMapEnterFun(szKey, fnExcute, ...)
	if not self.tbEnterMapFun then
		self.tbEnterMapFun = {};	-- 玩家进入地图事件函数表
	end
	self.tbEnterMapFun[szKey] = {fnProcess = fnExcute, tbParam = arg};
end

function tbMapBase:UnregisterMapEnterFun(szKey)
	if (not self.tbEnterMapFun or not self.tbEnterMapFun[szKey] )then
		return 0;
	end
	self.tbEnterMapFun[szKey] = nil;
end

function tbMapBase:ExcuteEnterFun()
	if not self.tbEnterMapFun then
		return 0;
	end
	for _, tbExcute in pairs(self.tbEnterMapFun) do
		tbExcute.fnProcess(unpack(tbExcute.tbParam));
	end
end

function tbMapBase:RegisterMapLeaveFun(szKey, fnExcute, ...)
	if not self.tbLeaveMapFun then
		self.tbLeaveMapFun = {};	-- 玩家进入地图事件函数表
	end
	self.tbLeaveMapFun[szKey] = {fnProcess = fnExcute, tbParam = arg};
end

function tbMapBase:UnregisterMapLeaveFun(szKey)
	if (not self.tbLeaveMapFun or not self.tbLeaveMapFun[szKey] )then
		return 0;
	end
	self.tbLeaveMapFun[szKey] = nil;
end

function tbMapBase:ExcuteLeaveFun()
	if not self.tbLeaveMapFun then
		return 0;
	end
	for _, tbExcute in pairs(self.tbLeaveMapFun) do
		tbExcute.fnProcess(unpack(tbExcute.tbParam));
	end
end

function tbMapBase:OnEnterConsole()
end

function tbMapBase:OnEnter()
end

function tbMapBase:OnEnter2()
end

function tbMapBase:OnLeaveState(tbSwitchExec)
	self:CallParam(tbSwitchExec, 0);	-- 通用开关
end

function tbMapBase:OnDyLoad(nDynMapId)
end

function tbMapBase:OnLeaveConsole()
end

function tbMapBase:OnLeave()
end

function tbMapBase:GetTrapClass(szClassName, bNotCreate)
	if (not self.tbTraps) then
		self.tbTraps	= {};
	end
	local tbTrap	= self.tbTraps[szClassName];
	if (not tbTrap and bNotCreate ~= 1) then
		tbTrap	= Lib:NewClass(Map.tbTrapBase);
		tbTrap.szName	= szClassName;
		tbTrap.tbMap	= self;
		self.tbTraps[szClassName]	= tbTrap;
	end
	return tbTrap;
end

function tbMapBase:OnPlayerTrap(szClassName)
	self:GetTrapClass(szClassName):OnPlayer();
end
function tbMapBase:OnNpcTrap(szClassName)
	self:GetTrapClass(szClassName):OnNpc();
end

local tbTrapBase	= Map.tbTrapBase;

function tbTrapBase:OnPlayer()
	local tbToPos	= self.tbMap.tbTransmit[self.szName];
	Map:DbgOut("OnPlayerTrap:", me.szName, self.tbMap.nMapId, self.szName, tbToPos);
	if (tbToPos) then
		local nRet, szMsg = Map:CheckTagServerPlayerCount(tbToPos[1]);
		if nRet ~= 1 then
			me.Msg(szMsg);
			return 0;
		end
		me.NewWorld(tbToPos[1], tbToPos[2], tbToPos[3]);
		if (tbToPos[4] ~= "") then
			me.SetFightState(tonumber(tbToPos[4]));
		end
		
		if (tbToPos[5] and tbToPos[5] > 0) then
			Player:AddProtectedState(me, 5);
		else
			Player:AddProtectedState(me, 0);
		end
	end
end

function tbTrapBase:OnNpc()
	Map:DbgOut("OnNpcTrap:", him.szName, self.tbMap.nMapId, self.szName);
end

