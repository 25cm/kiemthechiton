
-- ====================== 文件信息 ======================

-- 万花谷副本 ITEM 脚本
-- Edited by peres
-- 2008/11/10 PM 01:50

-- 她的眼泪轻轻地掉落下来
-- 抚摸着自己的肩头，寂寥的眼神
-- 是，褪掉繁华和名利带给的空洞安慰，她只是一个一无所有的女子
-- 不爱任何人，亦不相信有人会爱她

-- ======================================================


local tbItem_Map 			= Item:GetClass("wanhuagu_map");		-- 万花谷入口地图
local tbItem_Key			= Item:GetClass("wanhuagu_key");		-- 钥匙
local tbItem_BearSkin		= Item:GetClass("wanhuagu_bearskin");	-- 熊皮
local tbItem_Medicament		= Item:GetClass("wanhuagu_medicament");	-- 隐身药
local tbItem_Drink			= Item:GetClass("wanhuagu_drink");		-- 女儿红
local tbItem_Flute			= Item:GetClass("wanhuagu_flute");		-- 笛子

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
	Player.ProcessBreakEvent.emEVENT_ATTACKED,
	Player.ProcessBreakEvent.emEVENT_DEATH,
	Player.ProcessBreakEvent.emEVENT_LOGOUT,
}

function tbItem_Map:OnUse()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	
	if nMapId ~= 30 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn phải tới <color><color=yellow> [Map 5] Chiến Trường Cổ<color><color=red> để mở bản đồ này!<color>");
		return;
	end;

	if (me.nTeamId == 0) then
		me.Msg("Tổ đội mới mở được Vạn Hoa Cốc!");
		return;
	end

	Dialog:Say("Bạn có muốn vào phó bản? <enter><enter><color=yellow>Kiến nghị tổ đội 6 người cấp 95 hoặc cao hơn vào phó bản.<color>。", {
			  {"Có",		self.OpenInstancing, self, me, it},
			  {"Đợi đã"},
			});
end;

function tbItem_Map:OpenInstancing(pPlayer, pItem)
	
	if not pPlayer or not pItem then
		return;
	end;
	
	-- 临时写法
	--if (pPlayer.GetTask(2066, 344)>=6) then
		--Dialog:SendInfoBoardMsg(me, "Một tuần chỉ có thể tham gia phó bản <color=yellow>6<color> lần!");
		--return;
	--end;

	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Tổ đội mới mở được Vạn Hoa Cốc!");
		return;
	end

	if pPlayer.GetItemCountInBags(18, 1, 245, 1) < 1 then
		return;
	end;
	
	pItem.Delete(me);
	TreasureMap:AddInstancing(pPlayer, 61);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã mở cổng vào Vạn Hoa Cốc!<color>");
	
	KStatLog.ModifyAdd("mixstat", "Mở lối vào Vạn Hoa Cốc", "Tổng", 1);
end;


function tbItem_Medicament:OnUse()
	if TreasureMap:GetPlayerMapTemplateId(me) ~= 344 then
		Dialog:SendInfoBoardMsg(me, "Chỉ sử dụng trong phó bản <color=yellow>Vạn Hoa Cốc<color>!");
		return;
	end;
	GeneralProcess:StartProcess("Đang sử dụng...", Env.GAME_FPS * 0.5, {self.ItemUsed, self, it, me}, nil, tbEvent);	
end;

function tbItem_Medicament:ItemUsed(pItem, pPlayer)
	if not pPlayer then return; end;
	-- 加隐身技能
	pPlayer.GetNpc().CastSkill(122,30,-1,pPlayer.GetNpc().nIndex);
	pItem.Delete(pPlayer);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." uống thuốc, cơ thể bỗng thay đổi!<color>");
end;



function tbItem_Drink:OnUse()
	if TreasureMap:GetPlayerMapTemplateId(me) ~= 344 then
		Dialog:SendInfoBoardMsg(me, "Chỉ sử dụng trong phó bản <color=yellow>Vạn Hoa Cốc<color>!");
		return;
	end;
	
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	local _, nDistance = TreasureMap:GetDirection({nMapX, nMapY}, {1609, 3042});
	
	if nDistance > 10 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Không thể sử dụng ở đây<color>");
		return;
	end;
		
	GeneralProcess:StartProcess("Mở...", Env.GAME_FPS * 0.5, {self.ItemUsed, self, it, me, nMapId}, nil, tbEvent);
end;

function tbItem_Drink:ItemUsed(pItem, pPlayer, nMapId)
	if not pPlayer then return; end;
	
	local nMapId, nMapX, nMapY	= pPlayer.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if not tbInstancing.nBoss_6_Ready then tbInstancing.nBoss_6_Ready = 0; end;
	
	if tbInstancing.nBoss_6_Ready == 1 then
		return
	end;
	
	KNpc.Add2(2773, 100, 4, nMapId, 1610, 3042, 0, 0, 1);
	tbInstancing.nBoss_6_Ready = 1;
	pItem.Delete(pPlayer);
end;


function tbItem_Flute:OnUse()
	if TreasureMap:GetPlayerMapTemplateId(me) ~= 344 then
		Dialog:SendInfoBoardMsg(me, "Chỉ sử dụng trong phó bản <color=yellow>Vạn Hoa Cốc<color>!");
		return;
	end;

	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local _, nDistance = TreasureMap:GetDirection({nMapX, nMapY}, {1595, 2890});
	
	if nDistance > 36 then
		Dialog:SendInfoBoardMsg(me, "<color=yellow>Sử dụng sáo có thể vỗ về mãnh thú<color>");
		return;
	end;
		
	GeneralProcess:StartProcess("Thổi sáo...", Env.GAME_FPS * 0.5, {self.ItemUsed, self, it, me}, nil, tbEvent);
end;

function tbItem_Flute:ItemUsed(pItem, pPlayer)
	
	if not pPlayer then return; end;
	
	local nMapId, nMapX, nMapY	= pPlayer.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.nBoss_5_Ready == 1 then
		return
	end;
	
	if tbInstancing then
		local pNpc_1	= KNpc.GetById(tbInstancing.dwIdLeopard_1);
		local pNpc_2	= KNpc.GetById(tbInstancing.dwIdLeopard_2);
		if pNpc_1 and pNpc_2 then
			pNpc_1.Delete();
			pNpc_2.Delete();
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." thổi sáo, làm mãnh thú bình tĩnh lại.<color>");
		end;
		
		KNpc.Add2(2772, 100, 3, nMapId, 1588, 2887, 0, 0, 1);
		tbInstancing.nBoss_5_Ready	= 1;
		pItem.Delete(pPlayer);
		
	end;
	
end;