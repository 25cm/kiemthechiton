------------------------------------------------------
-- 文件名　：tianyanmiyuwan.lua
-- 创建者　：dengyong
-- 创建时间：2009-12-07 11:35:10
-- 描  述  ：甜言蜜语丸，用来说服NPC成为自己的同伴
------------------------------------------------------

local tbItem = Item:GetClass("tianyanmiyuwan");

tbItem.nProcessTime 			  = 0.5;		-- 使用道具过程中，需要读条15秒
tbItem.nPersuadeSkillId          = 1526;	-- 说服状态，玩家
tbItem.nBePersuadeSkillId 		  = 1527;	-- 被说服状态，

-- 参数应该为选中NPC的ID
function tbItem:OnUse(nParam)
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Hoạt động đồng hành đã đóng, không thể dùng thẻ");
		return 0;
	end
	
	local dwId = nParam;
	local pNpc = KNpc.GetById(dwId);
	
	if dwId == 0 or not pNpc then
		me.Msg("Hãy chọn 1 NPC rồi sử dụng đạo cụ này!");
		return 0;
	end

	-- 是否满足说服的条件
	local nRes, varMsg = Partner:TryToPersuade(me, pNpc, it.nLevel);
	if nRes == 0 then
		me.Msg(varMsg);		-- 不能说服，返回错误信息
		Partner:SendClientMsg(varMsg);
		return 0;
	end
	
	-- 可以说服了，读条。。
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
	

	-- 还需要对玩家和NPC添加特殊状态，表明是在读条过程中
	if not me.GetTempTable("Partner").nPersuadeRefCount then
		me.GetTempTable("Partner").nPersuadeRefCount = 0;
	end
	me.GetTempTable("Partner").nPersuadeRefCount = me.GetTempTable("Partner").nPersuadeRefCount + 1;
	
	me.AddSkillState(self.nPersuadeSkillId, 1, 1, self.nProcessTime * Env.GAME_FPS);
	
	local nCount = pNpc.GetTempTable("Partner").nPersuadeRefCount or 0;
	if nCount <= 0 then
		pNpc.AddTaskState(self.nBePersuadeSkillId);
		nCount = 0;
	end
	
	pNpc.GetTempTable("Partner").nPersuadeRefCount = nCount + 1;	
	
	GeneralProcess:StartProcess("Đang thuyết phục...", self.nProcessTime * Env.GAME_FPS, 
		{Partner.CreatePartner, Partner, me.nId, dwId, it.dwId}, 
		{self.OnBreak, self, me.nId, pNpc.dwId}, 
		tbEvent);
	
	return 0;
end 

-- 从客户端得到选择中的NPC对象，并把ID返回给服务器
-- 如果没有选择NPC对象，返回0
function tbItem:OnClientUse()
	local pSelectNpc = me.GetSelectNpc();
	if not pSelectNpc then
		return 0;
	end

	return pSelectNpc.dwId;
end

-- 被打断后，去除特殊状态
function tbItem:OnBreak(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	
	if pPlayer and pPlayer.GetTempTable("Partner").nPersuadeRefCount <= 1 then
		pPlayer.RemoveSkillState(self.nPersuadeSkillId);
		pPlayer.GetTempTable("Partner").nPersuadeRefCount = 0;
	else
		pPlayer.GetTempTable("Partner").nPersuadeRefCount = pPlayer.GetTempTable("Partner").nPersuadeRefCount - 1;
	end	
	
	if not pNpc or not pNpc.GetTempTable("Partner").nPersuadeRefCount then
		return;
	end
		
	pNpc.GetTempTable("Partner").nPersuadeRefCount = pNpc.GetTempTable("Partner").nPersuadeRefCount - 1;
	if pNpc.GetTempTable("Partner").nPersuadeRefCount <= 0 then
		pNpc.RemoveTaskState(self.nBePersuadeSkillId);
	end

end