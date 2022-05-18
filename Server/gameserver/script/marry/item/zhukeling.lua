-- 文件名　：zhukeling.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-09 14:14:26
-- 功能描述：结婚道具（逐客令）

local tbItem = Item:GetClass("marry_zhukeling");

--=================================================

tbItem.MAX_RANGE = 20;
tbItem.NUM_PER_PAGE = 15;

--=================================================

-- 从客户端得到选择中的NPC对象，并把ID返回给服务器
-- 如果没有选择NPC对象，返回0
function tbItem:OnClientUse()
	local pSelectNpc = me.GetSelectNpc();
	if not pSelectNpc then
		return 0;
	end

	return pSelectNpc.dwId;
end

function tbItem:CanUse(pItem)
	local szErrMsg = "";
	
	local nPrivilegeLevel = self:GetLevel(me.nMapId, me.szName);
	if (nPrivilegeLevel < 2) then
		szErrMsg = "Trục Khách Lệnh chỉ 2 vị hiệp lữ hay huynh đệ kết nghĩa và mật hữu của họ mới có thể dùng, bạn không thể dùng.";
		return 0, szErrMsg;
	end
	
	local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId) or {};
	local bIsCurMapItem = 0;	-- 是否是当前地图可以使用的物品
	for _, szName in pairs(tbCoupleName) do
		if (szName == pItem.szCustomString) then
			bIsCurMapItem = 1;
			break;
		end
	end
	if (0 == bIsCurMapItem) then
		szErrMsg = "Vật phẩm này không phải của 2 vị hiệp lữ đang tổ chức buổi lễ, không thể dùng!";
		return 0, szErrMsg;
	end
	
	return 1;
end

-- 参数应该为选中NPC的ID
function tbItem:OnUse(nParam)
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local nNpcId = nParam;
	local pNpc = KNpc.GetById(nNpcId);
	if (0 == nNpcId or not pNpc) then
		me.Msg("Xin chọn 1 người chơi rồi mới sử dụng đạo cụ này.");
		return 0;
	end
	local pPlayer = pNpc.GetPlayer();
	if (not pPlayer) then
		me.Msg("Xin chọn 1 người chơi rồi mới sử dụng đạo cụ này.");
		return 0;
	end
	
	local bCanUse, szErrMsg = self:CanUse(it);
	if (0 == bCanUse) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local tbEvent = 
	{
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
	}

	GeneralProcess:StartProcess("Chuẩn bị đuổi…", 5 * Env.GAME_FPS,
		{self.SelectPlayer, self, pPlayer.szName, me.szName, it.dwId}, nil, tbEvent);

end

function tbItem:SelectPlayer(szDstName, szAppName , nItemId)
	if (0 == self:CanBeBanished(szDstName)) then
		Dialog:Say("Không thể trục xuất, người này là hiệp lữ hoặc huynh đệ kết nghĩa của họ, có quan hệ mất thiết.");
		return;
	end
	local szMsg = string.format("Bạn xác định muốn đuổi <color=yellow>%s<color> ra khỏi buổi lễ ?", szDstName);
	local tbOpt = {
		{"Đồng ý", self.SureSelectPlayer, self, szDstName, szAppName, nItemId},
		{"Để ta suy nghĩ lại đã!"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:SureSelectPlayer(szDstName, szAppName, nItemId)
	local pPlayer = KPlayer.GetPlayerByName(szDstName);
	local pItem = KItem.GetObjById(nItemId);
	if (pPlayer and pItem) then
		pItem.Delete(me);
		Setting:SetGlobalObj(pPlayer);
		Marry:KickPlayer(pPlayer.nMapId, pPlayer);
		Dialog:Say("Ngại quá! Bạn đã bị mời khỏi buổi lễ.");
		Setting:RestoreGlobalObj();
	end
	pPlayer = KPlayer.GetPlayerByName(szAppName);
	pPlayer.Msg(string.format("Bạn đã mời <color=yellow>%s<color> ra khỏi buổi lễ.", szDstName));
end

-- 判断一个人是否可以被驱逐（可以驱逐比自己权限低的角色）
function tbItem:CanBeBanished(szName)
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		return 0;
	end
	
	local nHisLevel = self:GetLevel(pPlayer.nMapId, szName);
	if (nHisLevel == 0) then
		return 0;
	end
	
	local nMyLevel = self:GetLevel(me.nMapId, me.szName);
	if (nMyLevel <= nHisLevel) then
		return 0;
	end
	
	return 1;
end

-- 获取权限等级
function tbItem:GetLevel(nMapId, szName)
	if (not nMapId or nMapId <= 0 or not szName) then
		return 0;
	end
	return Marry:GetWeddingPlayerLevel(nMapId, szName);
end
