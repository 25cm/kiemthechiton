-------------------------------------------------------------------
--File: 	
--Author: 	sunduoliang
--Date: 	2008-4-14 9:00
--Describe:	乾坤符
-------------------------------------------------------------------
Require("\\script\\item\\class\\qiankunfulogic.lua");

-- 乾坤符
local tbItem = Item:GetClass("qiankunfu");
tbItem.nTime = 2;							-- 延时的时间(秒)
function tbItem:OnUse()
	local pPlayer = me;
	self:ShowOnlineMember(it.dwId, pPlayer.nId);
	return 0;
end

function tbItem:ShowOnlineMember(nItemId, nPlayerId)

	local tbOnlineMember = {};
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	local tbTeamMemberList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
	if tbTeamMemberList == nil then
		Dialog:Say("Không có đồng đội, không thể dùng Càn Khôn Phù!");
		return 0;
	else
		for _, nMemPlayerId in pairs(tbTeamMemberList) do
			if nMemPlayerId ~= nPlayerId then
				local szMemName = KGCPlayer.GetPlayerName(nMemPlayerId);
				local nOnline = KGCPlayer.OptGetTask(nMemPlayerId, KGCPlayer.TSK_ONLINESERVER);
				local szOnline = "[Rời mạng]";
				if nOnline > 0 then
					szOnline = "[Online]";
				end
				tbOnlineMember[#tbOnlineMember + 1]= {string.format("%s%s", szMemName, szOnline), self.SelectMember, self, nMemPlayerId, nPlayerId, nOnline, nItemId};
			end
		end	
	end	
	
	if (#tbOnlineMember <= 0) then
		Dialog:Say("Không có đồng đội, không thể dùng Càn Khôn Phù!");
		return 0;
	end
	tbOnlineMember[#tbOnlineMember + 1] = {"Đóng"};
	Dialog:Say("Bạn muốn đến đồng đội nào?", tbOnlineMember);
end


function tbItem:SelectMember(nMemberPlayerId, nPlayerId, nOnline, nItemId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end	
	if nOnline <= 0 then
		Dialog:Say("Đồng đội này không online, không thể đến.");
		return 0;
	end
	local szMemberName = KGCPlayer.GetPlayerName(nMemberPlayerId);
	local nNowOnline = KGCPlayer.OptGetTask(nMemberPlayerId, KGCPlayer.TSK_ONLINESERVER);
	if nNowOnline <= 0 then
		Dialog:Say("Đồng đội này đã offline, không thể đến.");
		return 0;
	end
	local tbEvent	= {						-- 会中断延时的事件
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
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	};
	if (0 == pPlayer.nFightState) then				-- 玩家在非战斗状态下传送无延时正常传送
		self:DoSelectMember(nMemberPlayerId, nPlayerId, nItemId)
		return 0;
	end
	GeneralProcess:StartProcess(string.format("Đang đến đồng đội [%s]…",szMemberName), self.nTime * Env.GAME_FPS, {self.DoSelectMember, self, nMemberPlayerId, nPlayerId, nItemId}, nil, tbEvent);	-- 在战斗状态下需要nTime秒的延时
end

-- 功能:	传送玩家去报名点
-- 参数:	nMapId 要传至的报名点的Id
function tbItem:DoSelectMember(nMemberPlayerId, nPlayerId, nItemId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	local nOnline = KGCPlayer.OptGetTask(nMemberPlayerId, KGCPlayer.TSK_ONLINESERVER);
	if nOnline <= 0 then
		Dialog:Say("Đồng đội này đã offline, không thể đến.");
		return 0;
	end	
	if Item.tbQianKunFu:CheckMember(nPlayerId,nMemberPlayerId) ~= 1 then
		pPlayer.Msg("Đồng đội này không có, hoặc đã rời khỏi đội!");
		return 0;		
	end
	GCExcute({"Item.tbQianKunFu:SelectMemberPos", nMemberPlayerId, nPlayerId, nItemId});
end


function tbItem:GetTip(nState)
	local nUseCount = it.GetGenInfo(1,0)
	local nLastCount = Item.tbQianKunFu.tbItemList[it.nParticular] - nUseCount;
	local szTip = "";
	szTip = szTip..string.format("<color=0x8080ff>Nhấn chuột phải dùng<color>\n");
	szTip = szTip..string.format("<color=yellow>Số lần dùng còn: %s<color>",nLastCount);
	return szTip;
end

