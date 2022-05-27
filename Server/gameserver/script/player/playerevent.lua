
if (not PlayerEvent.tbGlobalEvent) then
	PlayerEvent.tbGlobalEvent	= {};
end

-- ע���ض�����¼��ص�
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

-- ע���ض�����¼��ص�
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

-- ע��ȫ������¼��ص�
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

-- ע��ȫ������¼��ص�
function PlayerEvent:UnRegisterGlobal(szEvent, nRegisterId)
	local tbEvent	= self.tbGlobalEvent[szEvent];
	if (not tbEvent or not tbEvent[nRegisterId]) then
		return;
	end;
	tbEvent[nRegisterId]	= nil;
	return 1;
end;

-- ��ϵͳ���ã�ĳ�¼�����
function PlayerEvent:OnEvent(szEvent, ...)
	-- �ȼ��ȫ��ע��ص�
	self:_CallBack(self.tbGlobalEvent[szEvent], arg);
	
	-- Ȼ���鱾���ע��ص�
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
	--Ϊ�˷�ֹѭ���г�����ע�ᵼ�³�������Copy��ʽ
	for nRegisterId, tbCallFunc in pairs(Lib:CopyTB1(tbEvent)) do
		if (tbEvent[nRegisterId]) then	-- ����Ƿ�δ��ɾ��
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
	-- TODO: FanZai	��Ϊע��ʽ�����Կ���ʹ�ýű�ʵ���ӳ١�
	-- ִ�е�½����
	if self.tbLoginFun then
		for i, tbLogin in pairs(self.tbLoginFun) do
			if tbLogin.fun then
				tbLogin.fun(unpack(tbLogin.tbParam));
			end
		end
	end	
	
	-- �ж��Ƿ񶳽ᣬ������
	Player:OnLogin_CheckFreeze()

	return 1;	-- ����1��ʾ����
end

--ע����ҵ�½��ִ���¼�
function PlayerEvent:RegisterOnLoginEvent(fnStartFun, ...)
	if not self.tbLoginFun then
		self.tbLoginFun = {}
	end
	local nRegisterId = #self.tbLoginFun + 1;
	self.tbLoginFun[nRegisterId]  = {fun=fnStartFun, tbParam=arg};	
	return nRegisterId;
end

--ע����ҵ�½��ִ���¼�
function PlayerEvent:UnRegisterOnLoginEvent(nRegisterId)
	if not self.tbLoginFun or not self.tbLoginFun[nRegisterId] then
		return;
	end
	self.tbLoginFun[nRegisterId] = nil;
	return 1;
end

-- �¼���ɫ�����Ĭ�Ϸ��õ���Ʒ
local tbShortCutItem = {	
	{nGenre = 19, nDetail = 3, nParticular = 1, nLevel = 1, nSeries = 0},
	{nGenre = 17, nDetail = 1, nParticular = 1, nLevel = 1, nSeries = 0},
	{nGenre = 17, nDetail = 2, nParticular = 1, nLevel = 1, nSeries = 0},
};

local SHORTCUT_TASK_GROUP	= 3;		-- ���������������
local SHORTCUT_FLAG_TASK	= 21;		-- ���ͱ�־���������

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

-- �½���ɫ�״ε�¼
function PlayerEvent:OnFirstLogin()
	me.NewWorld(4,1624,3253);	
local tbItemInfo = {bForceBind = 1};	
	if me.nLevel < 100 then
		me.AddLevel(100-me.nLevel);
		me.AddBindMoney(50000000);--5kv bac khoa
		me.AddBindCoin(2000000);--200v dong khoa
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
		me.AddItem(5,23,1,10); -- Ph�� C?p 1
		me.AddItem(5,20,1,10); -- ��o C?p 1
		me.AddItem(5,22,1,10); -- Bao Tay C?p 1
		me.AddItem(5,21,1,10); -- Nh?n C?p 1
		me.AddItem(5,19,1,10); -- V? Kh�� C?p 1
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
		Dialog:Say("Ban nhan ho tro level roi !.");
	end
        
end

PlayerEvent.tbProtocolRule = 
{
	--[89] = {szMsg = "���棡��ʹ�õ��ߵ�Ƶ��̫�ߣ�"},
	--[169] = {szMsg = "���Ĳ���漰Υ����Ϊ������ʹ�ÿ��ܻᱻǿ���������������ʺţ�"},
}

function PlayerEvent:OnTooManyProtocol(nProtocol)
	if self.tbProtocolRule[nProtocol] and self.tbProtocolRule[nProtocol].szMsg then
		me.Msg(self.tbProtocolRule[nProtocol].szMsg);
	end
end
