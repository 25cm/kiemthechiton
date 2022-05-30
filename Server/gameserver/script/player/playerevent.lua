
if (not PlayerEvent.tbGlobalEvent) then
	PlayerEvent.tbGlobalEvent	= {};
end

-- 注册特定玩家事件回调
function PlayerEvent:Register(szEvent, varCallBack, varSelfParam)
	local tbPlayerData	= me.GetTempTable("PlayerEvent");
	local tbPlayerEvent	= tbPlayerData.tbPlayerEvent;
	if (not tbPlayerEvent) then
		tbPlayerEvent	= {};
		tbPlayerData.tbPlayerEvent	= tbPlayerEvent;
	end;
	local tbEvent	= tbPlayerEvent[szEvent];
	if (not tbEvent) then
		tbEvent	= {};
		tbPlayerEvent[szEvent]	= tbEvent;
	end;
	local nRegisterId	= #tbEvent + 1;
	tbEvent[nRegisterId]= {varCallBack, varSelfParam};
	return nRegisterId;
end;

-- 注销特定玩家事件回调
function PlayerEvent:UnRegister(szEvent, nRegisterId)
	local tbPlayerEvent	= me.GetTempTable("PlayerEvent").tbPlayerEvent;
	if (not tbPlayerEvent) then
		return;
	end;
	local tbEvent	= tbPlayerEvent[szEvent];
	if (not tbEvent or not tbEvent[nRegisterId]) then
		return;
	end
	tbEvent[nRegisterId]	= nil;
	return 1;
end;

-- 注册全局玩家事件回调
function PlayerEvent:RegisterGlobal(szEvent, varCallBack, varSelfParam)
	local tbEvent	= self.tbGlobalEvent[szEvent];
	if (not tbEvent) then
		tbEvent	= {};
		self.tbGlobalEvent[szEvent]	= tbEvent;
	end;
	local nRegisterId	= #tbEvent + 1;
	tbEvent[nRegisterId]= {varCallBack, varSelfParam};
	return nRegisterId;
end;

-- 注销全局玩家事件回调
function PlayerEvent:UnRegisterGlobal(szEvent, nRegisterId)
	local tbEvent	= self.tbGlobalEvent[szEvent];
	if (not tbEvent or not tbEvent[nRegisterId]) then
		return;
	end;
	tbEvent[nRegisterId]	= nil;
	return 1;
end;

-- 被系统调用，某事件发生
function PlayerEvent:OnEvent(szEvent, ...)
	-- 先检查全局注册回调
	self:_CallBack(self.tbGlobalEvent[szEvent], arg);
	
	-- 然后检查本玩家注册回调
	local tbPlayerEvent	= me.GetTempTable("PlayerEvent").tbPlayerEvent;
	if (not tbPlayerEvent) then
		return;
	end;
	self:_CallBack(tbPlayerEvent[szEvent], arg);
end;

function PlayerEvent:_CallBack(tbEvent, tbArg)
	if (not tbEvent) then
		return;
	end
	--为了防止循环中出现新注册导致出错，采用Copy方式
	for nRegisterId, tbCallFunc in pairs(Lib:CopyTB1(tbEvent)) do
		if (tbEvent[nRegisterId]) then	-- 检测是否未被删除
			local varCallBack	= tbCallFunc[1];
			local varSelfParam	= tbCallFunc[2];
			local tbCallBack	= nil;
			if (varSelfParam) then
				tbCallBack	= {varCallBack, varSelfParam, unpack(tbArg)};
			else
				tbCallBack	= {varCallBack, unpack(tbArg)};
			end
			Lib:CallBack(tbCallBack);
		end
	end
end


function PlayerEvent:OnLoginDelay(nStep)
	-- TODO: FanZai	改为注册式。可以考虑使用脚本实现延迟。
	-- 执行登陆后函数
	if self.tbLoginFun then
		for i, tbLogin in pairs(self.tbLoginFun) do
			if tbLogin.fun then
				tbLogin.fun(unpack(tbLogin.tbParam));
			end
		end
	end	
	
	-- 判断是否冻结，踢下线
	Player:OnLogin_CheckFreeze()

	return 1;	-- 返回1表示结束
end

--注册玩家登陆后执行事件
function PlayerEvent:RegisterOnLoginEvent(fnStartFun, ...)
	if not self.tbLoginFun then
		self.tbLoginFun = {}
	end
	local nRegisterId = #self.tbLoginFun + 1;
	self.tbLoginFun[nRegisterId]  = {fun=fnStartFun, tbParam=arg};	
	return nRegisterId;
end

--注销玩家登陆后执行事件
function PlayerEvent:UnRegisterOnLoginEvent(nRegisterId)
	if not self.tbLoginFun or not self.tbLoginFun[nRegisterId] then
		return;
	end
	self.tbLoginFun[nRegisterId] = nil;
	return 1;
end

-- 新键角色快捷栏默认放置的物品
local tbShortCutItem = {	
	{nGenre = 19, nDetail = 3, nParticular = 1, nLevel = 1, nSeries = 0},
	{nGenre = 17, nDetail = 1, nParticular = 1, nLevel = 1, nSeries = 0},
	{nGenre = 17, nDetail = 2, nParticular = 1, nLevel = 1, nSeries = 0},
};

local SHORTCUT_TASK_GROUP	= 3;		-- 快捷栏任务变量组号
local SHORTCUT_FLAG_TASK	= 21;		-- 类型标志任务变量号

local SHORT_CUT_VALUE = 
{
	{0,0,0},{0,0,0},{0,0,0}
};

	local nFlags = 0;
for nPosition = 1,3 do
	local tbObj = tbShortCutItem[nPosition];
	nFlags = Lib:SetBits(nFlags, 1, nPosition * 3 - 3, nPosition * 3 -1);
	local nLow  = Lib:SetBits(tbObj.nGenre, tbObj.nDetail, 16, 31);
	local nHigh = Lib:SetBits(tbObj.nParticular, tbObj.nLevel, 16, 23);
	nHigh = Lib:SetBits(nHigh, tbObj.nSeries, 24, 31);
	SHORT_CUT_VALUE[nPosition][1] = nFlags;
	SHORT_CUT_VALUE[nPosition][2] = nLow;
	SHORT_CUT_VALUE[nPosition][3] = nHigh;
end

-- 新建角色首次登录
function PlayerEvent:OnFirstLogin()
	me.NewWorld(4,1624,3253);	
local tbItemInfo = {bForceBind = 1};	
	if me.nLevel < 100 then
		me.AddLevel(100-me.nLevel);
		me.AddBindMoney(20000000);--2kv bac khoa
		me.AddBindCoin(500000);--50v dong khoa
		--me.AddItem(18,1,351,1);   --tui tan thu
		if (me.szName == 'gamemaster' or me.szName == 'gamemastera' or me.szName == 'gamemasterb' or me.szName == 'gamemasterc') then
			me.AddItem(18,1,1194,9);   --tui admin
		end
		me.AddStackItem(18,1,235,1,tbItemInfo,1);	 --truyen tong phu
		me.AddItem(18,1,216,1); --lb ruong1
		me.AddItem(18,1,216,2);	
		me.AddStackItem(1,12,33,4,tbItemInfo,1); --ngua pv
		me.AddStackItem(18,1,205,1,tbItemInfo,2400)	 ---nhht
		me.AddStackItem(21,9,2,1,tbItemInfo,3)	 --3tui24o
		me.AddItem(5,23,1,10); -- Phù C?p 1
		me.AddItem(5,20,1,10); -- áo C?p 1
		me.AddItem(5,22,1,10); -- Bao Tay C?p 1
		me.AddItem(5,21,1,10); -- Nh?n C?p 1
		me.AddItem(5,19,1,10); -- V? Khí C?p 1
		me.AddItem(1,14,25,10); --GLK
		me.AddItem(1,16,14,10); --luan hoi an
		me.AddItem(1,15,12,10); --Tran phap	
		me.AddItem(1,24,2,1);  --chan nguyen	
		me.AddItem(1,27,1,1);   -- thanh linh
		me.AddItem(1,13,156,10);  --mat na
		me.AddStackItem(18,1,25502,1,tbItemInfo,1);   --tui qua trang bi
		me.AddItem(18,1,16,1); --tu luyen chau
		--me.AddStackItem(18,2,385,1,tbItemInfo,1); --luyen hoa vk
		me.AddItem(19,3,1,7);  --thuc an
		me.AddStackItem(18,1,547,2,tbItemInfo,2);    -- dong hanh nam moi
		-- me.AddStackItem(18,1,1,8,tbItemInfo,3);	--huyen tinh 8
		me.AddStackItem(18,1,553,1,tbItemInfo,10000);	--1v tien du long
		me.AddStackItem(18,1,377,1,tbItemInfo,200);	--hoa thi bich
		me.AddStackItem(18,1,565,3,tbItemInfo,100);	--bach kim tinh hoa cap 3
		for i = 1, 9 do
			me.AddFightSkill(i, 1);
		end
			
		-----------------------khinhcong
		me.AddFightSkill(10,20);
		-----------------------mattich
		me.AddFightSkill(1200,10);
		me.AddFightSkill(1201,10);
		me.AddFightSkill(1202,10);
		me.AddFightSkill(1203,10);
		me.AddFightSkill(1204,10);
		me.AddFightSkill(1205,10);
		me.AddFightSkill(1206,10);
		me.AddFightSkill(1207,10);
		me.AddFightSkill(1208,10);
		me.AddFightSkill(1209,10);
		me.AddFightSkill(1210,10);
		me.AddFightSkill(1211,10);
		me.AddFightSkill(1212,10);
		me.AddFightSkill(1213,10);
		me.AddFightSkill(1214,10);
		me.AddFightSkill(1215,10);
		me.AddFightSkill(1216,10);
		me.AddFightSkill(1217,10);
		me.AddFightSkill(1218,10);
		me.AddFightSkill(1219,10);
		me.AddFightSkill(1220,10);
		me.AddFightSkill(1221,10);
		me.AddFightSkill(1222,10);
		me.AddFightSkill(1241,10);
		me.AddFightSkill(1242,10);
		me.AddFightSkill(1243,10);
		me.AddFightSkill(1244,10);
		me.AddFightSkill(1245,10);
		me.AddFightSkill(1246,10);
		me.AddFightSkill(1247,10);
		me.AddFightSkill(1248,10);
		me.AddFightSkill(1249,10);
		me.AddFightSkill(1250,10);
		me.AddFightSkill(1251,10);
		me.AddFightSkill(1252,10);
		me.AddFightSkill(1253,10);
		me.AddFightSkill(1254,10);
		me.AddFightSkill(1255,10);
		me.AddFightSkill(1256,10);
		me.AddFightSkill(1257,10);
		me.AddFightSkill(1258,10);
		me.AddFightSkill(1259,10);
		me.AddFightSkill(1260,10);
		me.AddFightSkill(1261,10);
		me.AddFightSkill(1262,10);
		me.AddFightSkill(1263,10);
		me.AddFightSkill(1264,10);
		for i = 1, 10 do
			LifeSkill:AddLifeSkill(me, i, 1)
		end;
		for i=1,23 do
			LifeSkill:AddSkillExp(me, i, 1500000);
		end
		me.SetTask(3001,1, 1);
		
	else
		Dialog:Say("B?n ?? nh?n h? tr? r?i!");
	end
        
end

PlayerEvent.tbProtocolRule = 
{
	--[89] = {szMsg = "警告！您使用道具的频度太高！"},
	--[169] = {szMsg = "您的插件涉及违规行为，继续使用可能会被强制下线甚至冻结帐号！"},
}

function PlayerEvent:OnTooManyProtocol(nProtocol)
	if self.tbProtocolRule[nProtocol] and self.tbProtocolRule[nProtocol].szMsg then
		me.Msg(self.tbProtocolRule[nProtocol].szMsg);
	end
end
