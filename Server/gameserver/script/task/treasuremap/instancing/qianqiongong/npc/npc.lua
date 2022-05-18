
-- ====================== 文件信息 ======================

-- 千琼宫副本 NPC 脚本
-- Edited by peres
-- 2008/07/25 AM 11:39

-- 她的眼泪轻轻地掉落下来
-- 抚摸着自己的肩头，寂寥的眼神
-- 是，褪掉繁华和名利带给的空洞安慰，她只是一个一无所有的女子
-- 不爱任何人，亦不相信有人会爱她

-- ======================================================

local tbNpc_Bag		= Npc:GetClass("purepalace_bag");				-- 装有钥匙的袋子
local tbNpc_1		= Npc:GetClass("purepalace_xiaolian_npc");		-- 第一个对话类型 NPC
local tbNpc_2		= Npc:GetClass("purepalace_xiaolian_fight");	-- 护送 NPC

local tbNpc_Hiding	= Npc:GetClass("purepalace_hiding");	-- 隐匿之处传送点
local tbNpc_Outside	= Npc:GetClass("purepalace_outside");	-- 副本出口

local tbNpc_Task	= Npc:GetClass("purepalace_lixianglan");

local tbNpc_Box		= Npc:GetClass("purepalace_box_inside");	-- 箱子


tbNpc_1.tbTrack	= {
	{1629, 3044},
	{1640, 3030},
	{1618, 3008},
	{1596, 2981},
	{1571, 2956},
}

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

function tbNpc_1:OnDialog()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.tbBossDown[1] == 1 and tbInstancing.tbBossDown[2] == 0 and tbInstancing.nGirlProStep == 0 then
		local nKeys		= me.GetItemCountInBags(18,1,183,1);
		if nKeys > 0 then
			Dialog:Say("Ngươi đã tìm thấy thuốc giải?", {
					  {"Rồi, hãy uống thuốc giải", tbNpc_1.Release, tbNpc_1, him},
					  {"Chờ đã", tbNpc_1.OnExit, tbNpc_1},
					});
		else
			Dialog:Say("Ta bị nhốt ở đây đã lâu rồi, không hiểu ta bị đầu độc bởi chất gì, toàn thân tê liệt không thể nhúc nhích. Các ngươi giúp ta khỏe lại? Ta thật không hiểu, không thù không oán vì sao đối với ta như vậy.");
			return;
		end;
	end;
	
	if tbInstancing.tbBossDown[2] == 1 and tbInstancing.nGirlProStep == 1 then
		local nKeys		= me.GetItemCountInBags(18,1,184,1);
		if nKeys > 0 and tbInstancing.tbBossDown[5] == 1 then
			Dialog:Say("Các ngươi giúp ta tìm thuốc giải độc được không?", {
					  {"Đây, ngươi thử uống thuốc này xem", tbNpc_1.Finish, tbNpc_1, him, me},
					  {"Chờ đã", tbNpc_1.OnExit, tbNpc_1},
					});
		else
			Dialog:Say("Ta còn nghĩ toàn thân không còn chút sức lực nào, xem ra thuốc giải của ngươi đã trị một phần chất độc, nghe nói trong thiên quỳnh trong cung có một viên <color=yellow>Thiên Quỳnh Bảo Châu<color>, có thể hóa giải mọi loại độc tố, người tốt, ngươi giúp ta tìm Thiên Quỳnh Bảo Châu được không?");
			return;
		end;
	end;
end;


function tbNpc_1:Release(pNpc)
	
	if not him then
		return;
	end;
	
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
		
	local nKeys		= me.GetItemCountInBags(18,1,183,1);
	
	if nKeys <=0 then
		Dialog:Say("Thế nhưng ngươi trên người cũng không có cái kia giải dược nha?");
		return;
	end;
	
	me.ConsumeItemInBags(1, 18, 1, 183, 1);

	local nCurMapId, nCurPosX, nCurPosY = him.GetWorldPos();
	him.Delete();
	
	local pFightNpc		= KNpc.Add2(2745, 20, -1, nCurMapId, nCurPosX, nCurPosY, 0, 0, 1);
	
	-- 在这里记录小怜的 ID
	tbInstancing.nGirlId	= pFightNpc.dwId;
	
	pFightNpc.szName	= "Tiểu Liên";
	pFightNpc.SetTitle("Do đội của <color=yellow>"..me.szName.."<color> hộ tống");
	pFightNpc.SetCurCamp(0);
	
	pFightNpc.RestoreLife();
	
--	pFightNpc.GetTempTable("Npc").tbOnArrive = {tbNpc.OnArrive, tbNpc, pFightNpc, me};

	pFightNpc.AI_ClearPath();
	
	for _,Pos in ipairs(self.tbTrack) do
		if (Pos[1] and Pos[2]) then
			pFightNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
		end
	end;
	
	pFightNpc.SetNpcAI(9, 50, 1,-1, 25, 25, 25, 0, 0, 0, me.GetNpc().nIndex);
	
	tbInstancing.nGirlProStep = 1;
end;


function tbNpc_1:Finish(pNpc, pPlayer)
	
	if not him then
		return;
	end;
	
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
		
	local nKeys		= me.GetItemCountInBags(18,1,184,1);
	
	if nKeys <=0 then
		Dialog:Say("Thế nhưng ngươi trên người cũng không có na khỏa trong bảo khố châu nha?");
		return;
	end;
	
	me.ConsumeItemInBags(1, 18, 1, 184, 1);

	local nCurMapId, nCurPosX, nCurPosY = him.GetWorldPos();
	him.Delete();
	
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>Tiểu Liên nuốt viên Thiên Quỳnh Bảo Châu, cười lớn một tiếng, bỗng nhiên biến mất không hình không bóng!<color>");
	
	-- 加隐藏 BOSS
	KNpc.Add2(2746, 98, 3, nMapId, 1822, 2907);
	
	-- 加一个传送点
	local pSendPos	= KNpc.Add2(2748, 1, -1, nMapId, nMapX, nMapY);
	pSendPos.szName	= "Lối vào bí mật";
	
	tbInstancing.nGirlProStep = 2;
end;


function tbNpc_1:OnExit()
	
end;


-- 护送 NPC 小怜被杀死
function tbNpc_2:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nGirlKilled	= 1;
end;


-- 打开袋子拿到解药
function tbNpc_Bag:OnDialog()
	
	local nFreeCell = me.CountFreeBagCell();
	if nFreeCell < 2 then
		Dialog:SendInfoBoardMsg(me, "Cần ít nhất <color=yellow> 2 ô trống trong hành trang<color>!");
		return;
	end;
	
	-- TODO:liucahng 10写到head中去
	GeneralProcess:StartProcess("Đang mở...", 0.5 * 18, {self.OnOpen, self, me.nId, him.dwId}, {me.Msg, "Mở thất bại"}, tbEvent);

end;

function tbNpc_Bag:OnOpen(nPlayerId, dwNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	local nFreeCell = pPlayer.CountFreeBagCell();
	if nFreeCell < 2 then
		Dialog:SendInfoBoardMsg(pPlayer, "Cần ít nhất <color=yellow> 2 ô trống trong hành trang<color>!");
		return;
	end;
	
	local pNpc = KNpc.GetById(dwNpcId);
	
	if (pNpc and pNpc.nIndex > 0) then
		
		local nMapId, nMapX, nMapY	= pNpc.GetWorldPos();
		local tbInstancing = TreasureMap:GetInstancing(nMapId);
		
		if tbInstancing.tbBossDown[1] == 1 and tbInstancing.tbBossDown[5] == 0 then
			
			pPlayer.AddItem(18, 1, 183, 1);
			pPlayer.Msg("<color=yellow>Bạn nhận được thuốc giải độc!<color>");
			-- 通知附近的玩家
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." nhận được thuốc giải độc!<color>");
					
		elseif tbInstancing.tbBossDown[5] == 1 then
			
			pPlayer.AddItem(18, 1, 184, 1);
			pPlayer.Msg("<color=yellow>Bạn nhận được Thiên Quỳnh Bảo Châu!<color>");
			-- 通知附近的玩家
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." nhận được Thiên Quỳnh Bảo Châu!<color>");

		end;
		pNpc.Delete();
	end
end;


function tbNpc_Task:OnDialog()
	
end;


function tbNpc_Hiding:OnDialog()
	
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	
	Dialog:Say("Ngươi có muốn đi vào không?", {
			  {"Có", tbNpc_Hiding.Inside, tbNpc_Hiding, me, nMapId},
			  {"Không", tbNpc_Hiding.OnExit, tbNpc_Hiding},
			});
end;

function tbNpc_Hiding:Inside(pPlayer, nMapId)
	pPlayer.NewWorld(nMapId, 1732, 2913);
end;

function tbNpc_Hiding:OnExit()
	
end;




function tbNpc_Outside:OnDialog()
	
	local nTreasureId			= TreasureMap:GetMyInstancingTreasureId(me);
		if not nTreasureId or nTreasureId <= 0 then
			me.Msg("Đọc thời gian đăng nhập thất bại, xin kiểm tra lại từ đầu!");
			return;
		end;
	local tbInfo				= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId, nMapX, nMapY	= tbInfo.MapId, tbInfo.MapX, tbInfo.MapY;
	
	Dialog:Say(
		"Bạn có muốn rời khỏi?",
		{"Có", self.SendOut, self, me, nMapId, nMapX, nMapY},
		{"Tạm thời chưa"}
	);
end;

function tbNpc_Outside:SendOut(pPlayer, nMapId, nMapX, nMapY)
	pPlayer.NewWorld(nMapId, nMapX, nMapY);
end



function tbNpc_Box:OnDialog()
	GeneralProcess:StartProcess("Mở bảo rương...", 0.5 * 18, {self.OpenTreasureBox, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
end

function tbNpc_Box:OpenTreasureBox(nPlayerId, dwNpcId)
	-- 爆物品
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	local pNpc = KNpc.GetById(dwNpcId);
	if (pNpc and pNpc.nIndex > 0) then
		pPlayer.DropRateItem(TreasureMap.szInstancingBox_Level3, TreasureMap.nTreasureBoxDropCount, -1, -1, pNpc)
		pPlayer.Msg("<color=yellow>Hoàn thành<color>")
		pNpc.Delete();
	end
end
