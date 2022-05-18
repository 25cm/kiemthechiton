
-- ====================== 文件信息 ======================

-- 万花谷副本 NPC 脚本
-- Edited by peres
-- 2008/11/09 PM 16:53

-- 她的眼泪轻轻地掉落下来
-- 抚摸着自己的肩头，寂寥的眼神
-- 是，褪掉繁华和名利带给的空洞安慰，她只是一个一无所有的女子
-- 不爱任何人，亦不相信有人会爱她

-- ======================================================

Require("\\script\\task\\treasuremap\\instancing\\wanhuagu\\main.lua");

local tbNpc_Captain			= Npc:GetClass("wanhuagu_captain");
local tbNpc_Boss_1			= Npc:GetClass("wanhuagu_boss_1");
local tbNpc_TaoZi_Fight_1	= Npc:GetClass("wanhuagu_taozi_fight_1");
local tbNpc_TaoZi_Fight_Npc	= Npc:GetClass("wanhuagu_taozi_npc");
local tbNpc_TaoZi_Fight_2	= Npc:GetClass("wanhuagu_taozi_fight_2");
local tbNpc_QingQing_Fight	= Npc:GetClass("wanhuagu_qingqing_fight");
local tbNpc_QingQing_Npc	= Npc:GetClass("wanhuagu_qingqing_npc");
local tbNpc_Boss_2			= Npc:GetClass("wanhuagu_boss_2");
local tbNpc_Boss_3			= Npc:GetClass("wanhuagu_boss_3");
local tbNpc_Boss_Male_4		= Npc:GetClass("wanhuagu_boss_male_4");
local tbNpc_Boss_Female_4	= Npc:GetClass("wanhuagu_boss_female_4");
local tbNpc_Boss_5			= Npc:GetClass("wanhuagu_boss_5");
local tbNpc_Boss_6			= Npc:GetClass("wanhuagu_boss_6");
local tbNpc_Soldier			= Npc:GetClass("wanhuagu_soldier");
local tbNpc_BlackBear		= Npc:GetClass("wanhuagu_blackbear");
local tbNpc_Oryx			= Npc:GetClass("wanhuagu_oryx");
local tbNpc_Leopard			= Npc:GetClass("wanhuagu_leopard");
local tbNpc_Boss_6_Npc		= Npc:GetClass("wanhuagu_boss_6_npc");
local tbNpc_Boss_6_Fight	= Npc:GetClass("wanhuagu_boss_6_fight");

local tbNpc_Door			= Npc:GetClass("wanhuagu_door_1");
local tbNpc_Aster			= Npc:GetClass("wanhuagu_aster");
local tbNpc_Bag				= Npc:GetClass("wanhuagu_bag_1");
local tbNpc_Bag_2			= Npc:GetClass("wanhuagu_bag_2");

local tbNpc_TalkNpc_1		= Npc:GetClass("wanhuagu_talk_npc_1");		-- 牧童
local tbNpc_TalkNpc_2		= Npc:GetClass("wanhuagu_talk_npc_2");		-- 绵羊

local tbNpc_TalkNpc_3		= Npc:GetClass("wanhuagu_talk_npc_3");		-- 船夫
local tbNpc_Boss_3_talk		= Npc:GetClass("wanhuagu_boss_3_talk");		-- 药剂师对话

local tbNpc_Box				= Npc:GetClass("wanhuagu_box");				-- 箱子
local tbNpc_TaoZi_Talk_2	= Npc:GetClass("wanhuagu_taozi_npc_2");		-- 陶子对话2

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


-- 杀死铁莫西
function tbNpc_Captain:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nCaptainFight = 1;
end;

-- 陶子对话
function tbNpc_TaoZi_Fight_Npc:OnDialog()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.nTaoZiEscort == 0 then
		local szTalk	= [[<color=red><npc=2762><color>: các ngươi nhất định phải bang giúp ta! Giá vạn hoa cốc vốn là một rời xa trần thế đích tiểu đảo, vài thập niên lai, để tránh né chiến loạn dữ trên giang hồ đích báo thù, mấy vị hữu duyên lầm nhập đến đó đích kỳ nhân dị sĩ đều an an ổn ổn đích giữ lại.<end>
							<color=red><npc=2762><color>: nhưng mà vài ngày tiền chẳng từ đâu mà đến đích một người man tộc đi thuyền đi tới trên đảo, tại du đãng liễu một đoạn thời gian hậu rốt cục phát hiện liễu vạn hoa cốc đích nhập khẩu, giá nhập khẩu đại môn <color=red> chỉ có ta hòa ta muội muội xanh hai người đích cái chìa khóa hợp cùng một chỗ <color> tài năng mở, mà muội muội vừa bị nhất man tộc thủ lĩnh lỗ liễu khứ!<end>
							<color=red><npc=2762><color>: nếu như điều không phải các ngươi, vừa khả năng ta cũng...<end>
							<color=red><npc=2762><color>: van cầu các ngươi! Để không phá phôi giá chỗ Niết bàn, tương xanh muội muội tòng trong tay bọn họ giải cứu ra đi!]];
							
		TaskAct:Talk(szTalk, self.TalkEnd, self, him.dwId, me.nId);
	
	end;
end;


function tbNpc_TaoZi_Fight_Npc:TalkEnd(nNpcId, nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId)
	local pNpc		= KNpc.GetById(nNpcId);
	
	if not pPlayer or not pNpc then return 1; end;
	
	local nMapId, nMapX, nMapY	= pNpc.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.nTaoZiEscort == 1 then
		return 1;
	end;
	
	if pPlayer and pNpc then
		pNpc.Delete();
		tbInstancing.pTaoZi_Fight_2 = tbInstancing:AddSeekNpc(2763, 50, 1598, 3177, tbInstancing.tbTaoZiSeekPos, 0, pPlayer, 1, self);		
		if tbInstancing.pTaoZi_Fight_2 then
			tbInstancing.dwTaoZi_Fight_2 = tbInstancing.pTaoZi_Fight_2.dwId;
		end;
		tbInstancing.nTaoZiEscort = 1;
	end;
end;


function tbNpc_TaoZi_Fight_Npc:OnArrive(pFightNpc, pPlayer)
	print ("tbNpc_TaoZi_Fight_Npc:OnArrive");
	local nMapId, nMapX, nMapY	= pFightNpc.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nTaoZiEscort = 2;
	pFightNpc.SendChat("Xem kìa! Lại có một đám man binh tới!");
	
end;

function tbNpc_TaoZi_Fight_1:OnDeath()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nTaoZi_Death	= 1;
	tbInstancing.nDoorOpen		= 1;
	
	-- 删掉大门
	local pNpcDoor = KNpc.GetById(tbInstancing.dwIdDoor);
	if pNpcDoor then pNpcDoor.Delete(); end;	
end;

function tbNpc_TaoZi_Fight_2:OnDeath()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nTaoZi_Death	= 1;
	tbInstancing.nDoorOpen		= 1;
	
	-- 删掉大门
	local pNpcDoor = KNpc.GetById(tbInstancing.dwIdDoor);
	if pNpcDoor then pNpcDoor.Delete(); end;
		
end;


function tbNpc_Soldier:OnDeath()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nSoldierFight = tbInstancing.nSoldierFight + 1;
	
	print ("tbInstancing.nSoldierFight：", tbInstancing.nSoldierFight);
end;


function tbNpc_Boss_1:OnDeath()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	local pQingQing_Fight_1 = KNpc.GetById(tbInstancing.dwQingQing_F_1);
	if pQingQing_Fight_1 then
		pQingQing_Fight_1.Delete();
	end;
	
	if tbInstancing.nTaoZi_Death == 0 then
		local pTaoZi_Fight_2 = KNpc.GetById(tbInstancing.dwTaoZi_Fight_2);
		pTaoZi_Fight_2.Delete();
		
		-- 加对话 NPC
		tbInstancing:AddNpc(tbInstancing.tbNpcPos[6], nMapId);
		tbInstancing:AddNpc(tbInstancing.tbNpcPos[7], nMapId);
		
		-- 加袋子
		tbInstancing:AddNpc(tbInstancing.tbObjPos[6], nMapId);
		
		tbInstancing.nBoss_1	= 1;
	end;
	
end;


function tbNpc_Boss_2:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	tbInstancing:AddNpc(tbInstancing.tbObjPos[9], nMapId);
end;

function tbNpc_Boss_2:OnLifePercentReduceHere(nLifePercent)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 50 and tbInstancing.tbBossLifePoint[2] == 0 then
		-- 在这里生产可重生的熊
		for i=14, 16 do
			KNpc.Add2(tbInstancing.tbNpcPos[i][1],
						tbInstancing.tbNpcPos[i][2],
						-1,
						nMapId,
						tbInstancing.tbNpcPos[i][4],
						tbInstancing.tbNpcPos[i][5],
						1,
						0,
						1);
		end;
		tbInstancing.tbBossLifePoint[2] = 1;
		him.SendChat("Mau ra đây, mãnh thú của ta!");
	end;
end;


function tbNpc_Boss_3:OnDeath()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nBoss_3	= 1;
	
	-- 删除障碍物
	for i=1, #tbInstancing.tb_dwIdAster do
		local pNpc	= KNpc.GetById(tbInstancing.tb_dwIdAster[i]);
		if pNpc then
			pNpc.Delete();
		end;
	end;
	
	-- 变成非战斗状态
	tbInstancing:AddNpc(tbInstancing.tbNpcPos[13], nMapId);	
end;


-- 击败柳生时出现袋子
function tbNpc_Boss_Male_4:OnDeath()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);	
	tbInstancing:AddNpc(tbInstancing.tbObjPos[7], nMapId);
	
	tbInstancing.nBoss_4	= 1;
end;

-- 柳生 60% 血量时贾茹出现
function tbNpc_Boss_Male_4:OnLifePercentReduceHere(nLifePercent)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 60 and tbInstancing.tbBossLifePoint[4] == 0 then
		tbInstancing:AddNpc(tbInstancing.tbBossPos[5], nMapId);
		tbInstancing.tbBossLifePoint[4] = 1;
		him.SendChat("Cổ Như, ta đang bị thương rất nặng...");
	end;
	
end;	


function tbNpc_Boss_5:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	tbInstancing:AddNpc(tbInstancing.tbObjPos[10], nMapId);
end;

function tbNpc_Boss_6:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	KNpc.Add2(2597, 1, -1, nMapId, nMapX, nMapY);
	local tbInstancing = TreasureMap:GetInstancing(nMapId);	
	
	-- 加船夫
	tbInstancing:AddNpc(tbInstancing.tbNpcPos[12], nMapId);
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
	---------------------------------------------
		pPlayer.AddJbCoin(100000);--5v ??ng khóa
				pPlayer.AddExp(10000000)
		pPlayer.AddStackItem(18,1,1331,2,nil,2);
		pPlayer.AddBindMoney(300000);
		pPlayer.AddBindCoin(50000);--5v ??ng khóa
		pPlayer.Msg("Bạn đã tiêu diệt <color=green>Boss cuối Vạn Hoa Cốc<color> nhận được: <color=yellow>10 vạn đồng thường<color>");
		
-----------------------------------------------
        GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Tàng Bản Đồ <color=red>Vạn Hoa Cốc<color> nhận được <color=gold>10 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Tàng Bản Đồ <color=gold>Vạn Hoa Cốc<color> nhận được <color=yellow>10 Vạn Đồng<color>");
	
	--------------------------------------------------
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss2"], 28, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
		--KNpc.Add2(2597, 1, -1, nMapId, 1608, 3028);
		
		-- 副本任务的处理
		local tbTeamMembers, nMemberCount	= pPlayer.GetTeamMemberList();
				---------------------------------------------------
		-----------------------------------------------------
		-- 师徒成就：副本万花谷
		TreasureMap:GetAchievement(tbTeamMembers, Achievement.FUBEN_WANHUA, pPlayer.nMapId);
		
		if (not tbTeamMembers) or (nMemberCount <= 0) then
			TreasureMap:InstancingTask(pPlayer, tbInstancing.nMapTemplateId);
			return;
		else
			for i=1, nMemberCount do
				local pNowPlayer	= tbTeamMembers[i];

				TreasureMap:InstancingTask(pNowPlayer, tbInstancing.nMapTemplateId);
			end
		end
		
		-- 用于老玩家召回任务完成任务记录
		local tbMemberList = pPlayer.GetTeamMemberList();	
		for _, player in ipairs(tbMemberList) do 
			Task.OldPlayerTask:AddPlayerTaskValue(player.nId, 2082, 5);
		end;
	end;
	
	-- 加箱子
	for i=11, 13 do
		tbInstancing:AddNpc(tbInstancing.tbObjPos[i], nMapId);
	end;
	
	KStatLog.ModifyAdd("mixstat", "Giết boss để vượt cấp "," Tổng số tiền ", 1);
	
end;


function tbNpc_Door:OnDialog()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	local nKeys		= me.GetItemCountInBags(18,1,246,1);
	
	if nKeys > 0 then
		GeneralProcess:StartProcess("Mở...", 0.5 * 18, {self.OnOpened, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
	end;
	
end;

-- 用钥匙打开大门
function tbNpc_Door:OnOpened(nPlayerId, dwNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;

	local pNpc = KNpc.GetById(dwNpcId);
	if (pNpc and pNpc.nIndex > 0) then
		local nMapId, nMapX, nMapY	= pNpc.GetWorldPos();
		local tbInstancing = TreasureMap:GetInstancing(nMapId);
		tbInstancing.nDoorOpen = 1;
		me.ConsumeItemInBags(1, 18, 1, 246, 1);
		pNpc.Delete();
	end;
end;

function tbNpc_Aster:OnDialog()
	return;
end;


-- 打开袋子拿到钥匙
function tbNpc_Bag:OnDialog()
	
	local nFreeCell = me.CountFreeBagCell();
	if nFreeCell < 2 then
		Dialog:SendInfoBoardMsg(me, "Cần <color=yellow>2 hoặc nhiều hơn<color> ô trống trong hành trang!");
		return;
	end;
	
	-- TODO:liucahng 10写到head中去
	GeneralProcess:StartProcess("Mở...", 0.5 * 18, {self.OnOpened, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);

end;

function tbNpc_Bag:OnOpened(nPlayerId, dwNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;

	local pNpc = KNpc.GetById(dwNpcId);
	if (pNpc and pNpc.nIndex > 0) then
		
		local nMapId, nMapX, nMapY	= pNpc.GetWorldPos();
		local tbInstancing = TreasureMap:GetInstancing(nMapId);	
		
		if tbInstancing.nBoss_1 == 1 and tbInstancing.nBoss_3 == 0 then
			pPlayer.AddItem(18, 1, 246, 1);
			pPlayer.Msg("<color=yellow>Bạn đã lấy được chìa khóa!<color>");	
			-- 通知附近的玩家
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." lấy được chìa khóa!<color>");
		elseif tbInstancing.nBoss_3 == 1 then
			pPlayer.AddItem(18, 1, 249, 1);
			pPlayer.Msg("<color=yellow>Bạn đã nhặt được Vò Rượu Nữ Nhi Hồng!<color>");	
			-- 通知附近的玩家
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." nhặt được Vò Rượu Nữ Nhi Hồng!<color>");		
		end;
		pNpc.Delete();
	end;
end;


function tbNpc_Bag_2:OnDialog()
	local nFreeCell = me.CountFreeBagCell();
	if nFreeCell < 2 then
		Dialog:SendInfoBoardMsg(me, "Cần <color=yellow>2 hoặc nhiều hơn<color> ô trống trong hành trang!");
		return;
	end;
	
	-- TODO:liucahng 10写到head中去
	GeneralProcess:StartProcess("Mở...", 0.5 * 18, {self.OnOpened, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
end;

function tbNpc_Bag_2:OnOpened(nPlayerId, dwNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;

	local pNpc = KNpc.GetById(dwNpcId);
	if (pNpc and pNpc.nIndex > 0) then
		pPlayer.AddItem(18, 1, 250, 1);
		pPlayer.Msg("<color=yellow>Bạn đã lấy được ống sáo!<color>");	
		-- 通知附近的玩家
		TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." lấy được ống sáo!<color>");
		pNpc.Delete();	
	end;
end;


function tbNpc_TalkNpc_1:OnDialog()
	local szTalk	= [[<color=red><npc=2787><color>: ô ô ô... Phía trước đích đào lâm lý hữu hai hung ác độc địa đích hoa báo, bả ta đích dương một chút tựu cấp cắn chết! Thính xanh tả thuyết, <color=orange>trong rừng hữu một chi cây sáo<color>, chỉ cần thổi lên, những... dã thú này sẽ an tĩnh lại...<end>
						<color=red><npc=2787><color>: bất quá trừ phi các ngươi năng <color=orange>len lén tiêu sái quá khứ<color> không bị này dã thú thấy, bằng không nghìn vạn lần không nên tới gần chúng nó! Chúng nó thật sự là thái nguy hiểm liễu!]];
						
	TaskAct:Talk(szTalk, Npc:GetClass("wanhuagu_talk_npc_1").TalkEnd, Npc:GetClass("wanhuagu_talk_npc_1"), him, me);
end;

function tbNpc_TalkNpc_1:TalkEnd(pNpc, pPlayer)
	Dialog:SendBlackBoardMsg(pPlayer, "Từ nhỏ đồng na biết được, tưởng trấn an hoa báo, phải đắc bắt được kỳ phía sau đích cây sáo");
end;

function tbNpc_TalkNpc_2:OnDialog()
	Dialog:Say("咩………………………………");
end;

-- 船夫对话
function tbNpc_TalkNpc_3:OnDialog()
	local nTreasureId			= TreasureMap:GetMyInstancingTreasureId(me);
		if not nTreasureId or nTreasureId <= 0 then
			me.Msg("Lỗi không thể vào được, vui lòng sử dụng phù để về thành!");
			return;
		end;
	local tbInfo				= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId, nMapX, nMapY	= tbInfo.MapId, tbInfo.MapX, tbInfo.MapY;
	
	Dialog:Say(
		"Khách quan lai lặc, thế nào? Tại trên đảo có hay không đã du ngoạn được rồi? Nếu như tưởng trở lại nói, tiểu lục cái này tống nâm đoạn đường.",
		{"Đúng vậy", self.SendOut, self, me, nMapId, nMapX, nMapY},
		{"Tạm thời không"}
	);
end;

function tbNpc_TalkNpc_3:SendOut(pPlayer, nMapId, nMapX, nMapY)
	pPlayer.NewWorld(nMapId, nMapX, nMapY);
end;


-- 黄散一对话
function tbNpc_Boss_3_talk:OnDialog()
	Dialog:Say(
		"Được rồi, các ngươi thắng, tưởng muốn dược tựu hòa ta nói ba, thiên hạ không có ta làm không được đích tễ thuốc, chỉ cần các ngươi năng bả tài liệu cảo lai!",
		{"Chế thuốc ẩn thân [cần 10 Da Gấu]", self.MakeIt, self, me},
		{"Để lại"}
	);	
	return;
end;


function tbNpc_Boss_3_talk:MakeIt(pPlayer)
	local nBearSkin		= pPlayer.GetItemCountInBags(18,1,247,1);
	if nBearSkin < 10 then
		Dialog:Say("Ha! Ngươi hiện tại không đủ <color=yellow>10 Da Gấu<color>, biệt phiến lão tử!");
		return;
	end;
	pPlayer.ConsumeItemInBags(10, 18, 1, 247, 1);
	pPlayer.AddItem(18,1,248,1);
	Dialog:Say("Được rồi, đây là ẩn thân dược cho ngươi, cần phải sử dụng cẩn thận, nhớ <color=yellow>thời gian tối đa chỉ có thể duy trì trong vòng 1 phút<color>.");
	return;
end;



function tbNpc_Box:OnDialog()
	GeneralProcess:StartProcess("Mở rương", 0.5 * 18, {self.OpenTreasureBox, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
end;

function tbNpc_Box:OpenTreasureBox(nPlayerId, dwNpcId)
	-- 爆物品
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	local pNpc = KNpc.GetById(dwNpcId);
	if (pNpc and pNpc.nIndex > 0) then
		pPlayer.DropRateItem(TreasureMap.szInstancingBox_Level3, TreasureMap.nTreasureBoxDropCount, -1, -1, pNpc)
		pPlayer.Msg("<color=yellow>Mở thành công!<color>")
		pNpc.Delete();
	end
end


function tbNpc_QingQing_Npc:OnDialog()
	local szTalk	= [[<color=red><npc=2765><color>: cảm tạ các ngươi, như vậy an tĩnh đích sơn cốc thực sự bất năng dễ dàng tha thứ này man nhân nhúng chàm. Dù sao ta cũng vậy một người tòng các địa phương phiêu bạt tới được nhân, biết rõ một phần bình tĩnh thị cỡ nào khó có được đích không đổi.<end>
						<color=red><npc=2765><color>: được rồi, đây là tiến nhập vạn hoa cốc đích cái chìa khóa, bên trong có chút nhân đĩnh thú vị ni, nếu như các ngươi nguyện ý, khả dĩ hòa bọn họ luận bàn một phen.]];
						
	TaskAct:Talk(szTalk, self.TalkEnd, self, him.dwId, me.nId);
end;

function tbNpc_QingQing_Npc:TalkEnd()
	return 1;
end;


function tbNpc_TaoZi_Talk_2:OnDialog()
	local szTalk	= [[<color=red><npc=2792><color>: Đào Tử: Cảm tạ các ngươi đuổi đi này man nhân, đây là vạn hoa cốc đích cái chìa khóa, nếu như tưởng bái phỏng trong cốc đích này kỳ nhân dị sĩ nói mượn đi thôi, tin tưởng các ngươi sẽ thích thượng ở đây đích.<end>
						<color=red><npc=2792><color>: Ồ, được rồi, trong cốc ở chỗ sâu trong có một thị rượu như mạng đích hòa thượng, quanh năm khó gặp hình bóng. Có người nói người này võ công thâm bất khả trắc, trong cốc đích không người nào bất kính thứ ba phân, nếu như các ngươi may mắn năng gặp phải nói nghìn vạn lần cẩn thận lời nói và việc làm, hắn thích nhất cùng người luận bàn võ nghệ liễu. Đương nhiên, nếu như đánh bại liễu hắn các ngươi coi như là cao thủ liễu... Ha ha.]];
						
	TaskAct:Talk(szTalk, self.TalkEnd, self, him.dwId, me.nId);
end;

function tbNpc_TaoZi_Talk_2:TalkEnd()
	return 1;
end;