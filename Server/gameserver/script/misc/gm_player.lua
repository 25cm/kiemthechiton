-- 文件名　：gm_player.lua
-- 创建者　：FanZai
-- 创建时间：2008-10-10 12:21:04
-- 文件说明：GM指令——多玩家操作系列

local tbGmPlayer	= GM.tbPlayer or {};

GM.tbPlayer	= tbGmPlayer;

tbGmPlayer.MAX_RECENTPLAYER	= 5;	-- 最近操作玩家列表

tbGmPlayer.tbRemoteList	= {};	-- 全服玩家列表，每次开主菜单刷新

function tbGmPlayer:Main()
	local tbOpt	= {
		{"Danh Sách Output Người chơi", self.OutputAllPlayer, self},
		{"Triệu tập tất cả người chơi", self.ComeHereAll, self},
		{"Danh sách người chơi", self.ListAllPlayer, self},
	};
	
	-- 最近操作玩家
	local tbRecentPlayerList	= me.GetTempTable("GM").tbRecentPlayerList or {};
	for nIndex, nPlayerId in ipairs(tbRecentPlayerList) do
		local tbInfo	= self.tbRemoteList[nPlayerId];
		if (tbInfo) then
			tbOpt[#tbOpt+1]	= {"<color=green>"..tbInfo[1], self.SelectPlayer, self, nPlayerId, tbInfo[1]};
		end
	end
	tbOpt[#tbOpt + 1]	= {"<color=gray>Kết thúc đối thoại"};

	Dialog:Say("Bạn Muốn gì<pic=20>", tbOpt);

	-- 更新全服玩家列表
	self.tbRemoteList	= {};
	GlobalExcute({"GM.tbPlayer:RemoteList_Fetch", me.nId})
	
	-- 每次都重载这个脚本
	DoScript("\\script\\misc\\gm_player.lua");
end

function tbGmPlayer:OutputAllPlayer()
	me.Msg(" ", "Danh sách người chơi hiện tại");
	for nPlayerId, tbInfo in pairs(self.tbRemoteList) do
		local szMsg	= string.format("Cấp %d %s %s", tbInfo[2],
			Player:GetFactionRouteName(tbInfo[3], tbInfo[4]), GetMapNameFormId(tbInfo[5]));
		me.Msg(szMsg, tbInfo[1]);
	end
end

function tbGmPlayer:ComeHereAll()
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg("Thiết lập tất cả!");
	self:RemoteCall_ApplyAll("me.NewWorld", nMapId, nMapX, nMapY);
end

function tbGmPlayer:ListAllPlayer()
	local tbOpt	= {};
	for nPlayerId, tbInfo in pairs(self.tbRemoteList) do
		tbOpt[#tbOpt+1]	= {"<color=green>"..tbInfo[1], self.SelectPlayer, self, nPlayerId, tbInfo[1]};
	end
	tbOpt[#tbOpt + 1]	= {"<color=gray>Kết thúc đối thoại"};
	Dialog:Say("Bạn muốn tìm gì? <pic=58>", tbOpt);
end

function tbGmPlayer:SelectPlayer(nPlayerId, szPlayerName)
	-- 插入最近操作玩家
	local tbPlayerData			= me.GetTempTable("GM");
	local tbRecentPlayerList	= tbPlayerData.tbRecentPlayerList or {};
	tbPlayerData.tbRecentPlayerList	= tbRecentPlayerList;
	for nIndex, nRecentPlayerId in ipairs(tbRecentPlayerList) do
		if (nRecentPlayerId == nPlayerId) then
			table.remove(tbRecentPlayerList, nIndex);
			break;
		end
	end
	if (#tbRecentPlayerList >= self.MAX_RECENTPLAYER) then
		table.remove(tbRecentPlayerList);
	end
	table.insert(tbRecentPlayerList, 1, nPlayerId);
	
	local tbInfo	= self.tbRemoteList[nPlayerId];
	if (not tbInfo) then
		me.Msg(string.format("[%s] Biến mất không một dấu vết...", szPlayerName));
		return;
	end
	
	local szMsg	= string.format("Tên: %s\nCấp độ: %d\nHướng luyện: %s\nChức vụ: %s",
		tbInfo[1], tbInfo[2], Player:GetFactionRouteName(tbInfo[3], tbInfo[4]),
		GetMapNameFormId(tbInfo[5]));
	
	Dialog:Say(szMsg,
		{"Kéo qua đây", self.CallSomeoneHere, self, nPlayerId},
		{"Di chuyển đến", self.RemoteCall_ApplyOne, self, nPlayerId, "GM.tbPlayer:CallSomeoneHere", me.nId},
		{"Cho rớt mạng", self.RemoteCall_ApplyOne, self, nPlayerId, "me.KickOut"},
		{"<color=gray>Kết thúc đối thoại"}
	);
end

function tbGmPlayer:CallSomeoneHere(nPlayerId)
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	self:RemoteCall_ApplyOne(nPlayerId, "me.NewWorld", nMapId, nMapX, nMapY);
end


--== 全服玩家列表 ==--
-- 将本服务器玩家列表发送出去
function tbGmPlayer:RemoteList_Fetch(nToPlayerId)
	local tbLocalPlayer = KPlayer.GetAllPlayer();
	local tbRemoteList	= {};
	for _, pPlayer in pairs(tbLocalPlayer) do
		tbRemoteList[pPlayer.nId]	= {
			pPlayer.szName,
			pPlayer.nLevel,
			pPlayer.nFaction,
			pPlayer.nRouteId,
			pPlayer.nMapId,
		};
	end
	GlobalExcute({"GM.tbPlayer:RemoteList_Receive", nToPlayerId, tbRemoteList})
end
-- 收到传回的玩家列表
function tbGmPlayer:RemoteList_Receive(nToPlayerId, tbRemoteList)
	local pPlayer	= KPlayer.GetPlayerObjById(nToPlayerId);
	if (not pPlayer) then
		return;
	end
	for nPlayerId, tbInfo in pairs(tbRemoteList) do
		self.tbRemoteList[nPlayerId]	= tbInfo;
	end
end


--== 全服/单一玩家执行 ==--
-- 申请为全服玩家执行
function tbGmPlayer:RemoteCall_ApplyAll(...)
	GlobalExcute({"GM.tbPlayer:RemoteCall_DoAll", arg})
end
-- 为本服务器玩家执行
function tbGmPlayer:RemoteCall_DoAll(tbCallBack)
	local tbLocalPlayer = KPlayer.GetAllPlayer();
	for _, pPlayer in pairs(tbLocalPlayer) do
		pPlayer.Call(unpack(tbCallBack));
	end
end
-- 申请为单一玩家执行
function tbGmPlayer:RemoteCall_ApplyOne(nToPlayerId, ...)
	GlobalExcute({"GM.tbPlayer:RemoteCall_DoOne", nToPlayerId, arg})
end
-- 为本服务器玩家执行
function tbGmPlayer:RemoteCall_DoOne(nToPlayerId, tbCallBack)
	local pPlayer	= KPlayer.GetPlayerObjById(nToPlayerId);
	if (pPlayer) then
		pPlayer.Call(unpack(tbCallBack));
	end
end


