
local tbItemSongjinZhaoshu	= Item:GetClass("songjinzhaoshu");

tbItemSongjinZhaoshu.nTime	= 10;							-- 延时的时间(秒)
tbItemSongjinZhaoshu.tbCamp	= {"<color=orange>Báo danh chiến trường_Tống(%s%s)<color>", "<color=purple>Báo danh chiến trường_Kim(%s%s)<color>"};	-- 玩家的选项
tbItemSongjinZhaoshu.tbBattleSeq = {"1", "Nhị ", "3"};
tbItemSongjinZhaoshu.tbItemId = 
{ 
	[27] = 1, --普通宋金诏书
	[86] = 0, --无限宋金诏书
	[195] = 0, --无限传送符（周）
	[235] = 0, --无限传送符（月）
};	-- 各种宋金诏书的Id,1为普通,0为无限传送符

function tbItemSongjinZhaoshu:OnUse()
	local pPlayer = me;

	local nLevelId	= Battle:GetJoinLevel(pPlayer);	-- 能参加的宋金战役的等级(0玩家的等级不够不能参加,1初级,2中级,3高级)
	
	if (nLevelId == 0) then		-- 等级不够时,点击宋金诏书没有操作
		Dialog:Say("Chưa đến cấp <color=green>60<color>, không được báo danh vào chiến trường!");
		return 0;
	end

	if (pPlayer.IsFreshPlayer() == 1) then
		Dialog:Say("Ngươi chưa gia nhập môn phái, gia nhập rồi hãy quay lại!");
		return 0;
	end	

	self:SelectCamp(it.dwId, nLevelId);
	
	return 0;
end

function tbItemSongjinZhaoshu:SelectCamp(nItemId, nLevelId)
	local tbOpt		= {};
	local szBattleMapName				= Battle.NAME_GAMELEVEL[nLevelId]; 

	local nOpenCount = Battle:GetOpenCount(nLevelId, #Battle.MAPID_LEVEL_CAMP[nLevelId]);
	for j = 1,  nOpenCount do
		for i = 1, #self.tbCamp do
			local nMapId	= Battle.MAPID_LEVEL_CAMP[nLevelId][j][i];				-- nMapId是被传送至的报名点的地图Id
			tbOpt[#tbOpt+1]	= {string.format(self.tbCamp[i], szBattleMapName, self.tbBattleSeq[j]), self.TransPlayer, self, nItemId, nMapId};	-- 赞一下,觉得table这样的用法很精妙
		end
	end
	tbOpt[#tbOpt + 1]	= {"Để ta suy nghĩ đã"};	-- 退出
	local szMsgFmt	= "Đại chiến Tống Kim hết sức căng thẳng, anh hùng hào kiệt mặc sẵn áo giáp, xông pha sa trường.\n";
	local nFlag		= 0;
	
	for i=1, nOpenCount do
		local nSongnCampNum, nJinCampNum 	= Battle:GetPlayerCount(nLevelId, i);
		if (nSongnCampNum < 0 or not Battle.szLastMapName) then	-- 未开始报名时
			szMsgFmt	= szMsgFmt .. string.format("Hiện <color=yellow>%s%s<color> chưa bắt đầu báo danh.\n", szBattleMapName, self.tbBattleSeq[i]);
		else	-- 报名已开始
			szMsgFmt	= szMsgFmt .. string.format("Hiện <color=yellow>%s%s<color> bắt đầu báo danh. <color=orange>Số quân Tống: %d<color>; <color=purple>Số quân Kim: %d<color>.\n", szBattleMapName, self.tbBattleSeq[i], nSongnCampNum, nJinCampNum);
			nFlag		= 1;
		end
	end
	if (nFlag == 1) then
		szMsgFmt = szMsgFmt .. "Quân số 2 bên quá cách biệt, bên nhiều hơn tạm thời không thể báo danh."
	end
	szMsgFmt = szMsgFmt .. "Bạn muốn đến điểm báo danh nào?";
	Dialog:Say(szMsgFmt, tbOpt);
end

function tbItemSongjinZhaoshu:TransPlayer(nItemId, nMapId)
	local pPlayer = me;
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
		self:TransPlayerSucessFul(nItemId, nMapId, pPlayer.nId);
		return 0;
	end

	GeneralProcess:StartProcess("Đang đến điểm báo danh…", self.nTime * Env.GAME_FPS, {self.TransPlayerSucessFul, self, nItemId, nMapId, pPlayer.nId}, nil, tbEvent);	-- 在战斗状态下需要nTime秒的延时
end

function tbItemSongjinZhaoshu:TransPlayerSucessFul(nItemId, nMapId, nPlayerId)
	local pItem = KItem.GetObjById(nItemId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer == nil then
		return 0;
	end
	if pItem == nil then
		pPlayer.Msg("Chiêu Thư Tống Kim bạn sử dụng đã xóa, thao tác bị lỗi, hãy liên hệ GM.");
		return 0; 
	end	
	if self.tbItemId[pItem.nParticular] == nil then
		pPlayer.Msg("Không có Chiêu Thư Tống Kim, hãy liên hệ GM.");
		return 0;
	end
	if self.tbItemId[pItem.nParticular] == 1 then
		
		local nCount = pItem.nCount;
		if nCount <= 1 then
			if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
				pPlayer.Msg("Xóa Chiêu Thư Tống Kim thất bại!");
				return 0;
			end
		else
			pItem.SetCount(nCount - 1); 
		end
	end
	Battle:EnterRegistPlace(nMapId, nPlayerId);
end

