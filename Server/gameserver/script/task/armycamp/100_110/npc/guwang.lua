-----------------------------------------------------------
-- 文件名　：guwang.lua
-- 文件描述：蛊王
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-27 11:19:16
-----------------------------------------------------------

-- 蛊王
local tbGuWang = Npc:GetClass("guwang");

-- 转变的NPC
tbGuWang.tbChangeNpcTemplateId 	= {4156, 4157, 4158, 4159, 4160, 4161, 4162};
-- 蛊神
tbGuWang.tbGuSheng				= {4153, 1820, 2841};

tbGuWang.tbText = {
{"Bạn sẽ sớm hiểu khoảng cách là gì!", "Khoảng cách về sức mạnh! Chính là nó!"},
{"Nhìn xem đây là ai?", "Đừng làm điều đó!", "Là tôi! Tại sao tôi lại ở đây?", "Dừng lại, làm sao chúng ta có thể giết nhau?", "Dừng lại, đây là Âm mưu của Gu King ! "," Tại sao bạn không tin tôi? "},
{"Tong'er, anh có thực sự cam tâm nhìn em chết như thế này không?", "Sao anh có thể trách em về chuyện này?", "Làm ơn, giúp em!", "Chà, ý trời cuối cùng cũng khó vi phạm ! "," Bạn phải chuẩn bị! ",},
{{"Đây là Ý Chúa!", "Cổ Thần"}, {"Tôi không thể nghĩ ra!", "Tôi sẽ có một ngày như vậy!", "Bị đánh bại bởi những kẻ nhỏ bé này!"}},
}

function tbGuWang:OnDeath(pNpc)
	local nEntryWayRate = MathRandom(100);
	
	KNpc.Add2(2793, 1, -1, him.nMapId, 1820, 2836); 
	
	local pPlayer  	= pNpc.GetPlayer();
	-----------------------------------------------------------
        pPlayer.AddJbCoin(100000);--5v ??ng khóa
		pPlayer.AddStackItem(18,1,1331,2,nil,2);
		pPlayer.AddExp(10000000)
		pPlayer.AddBindMoney(500000);
		pPlayer.AddBindCoin(50000);--5v ??ng khóa
		pPlayer.AddStackItem(18,1,553,1,nil,100);	--100 tien du long			
		pPlayer.Msg("Bạn đã tiêu diệt <color=blue>Boss cuối Bách Man Sơn<color> nhận được: <color=yellow>10 vạn đồng thường<color>");
----------------------------------------------------------		
        GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi<color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Quân Doanh <color=red>Bách Man Sơn<color> nhận được <color=gold>10 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi<color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Quân Doanh <color=gold>Bách Man Sơn<color> nhận được <color=yellow>10 Vạn Đồng<color>");

		-----------------------------------------------------------------
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	
	if (nEntryWayRate > 1000) then	
		-- 开出秘径
		
		local pEntryway = KNpc.Add2(4176, 110, -1, him.nMapId, 1820, 2846);
		local tbNpcData = pEntryway.GetTempTable("Task");
		tbNpcData.nEntrancePlayerId = pPlayer.nId;
		
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "Xuất hiện 1 cánh cổng thần bí");
		end;
	end;
	
	-- 用于老玩家召回任务完成任务记录
--	local tbMemberList = pPlayer.GetTeamMemberList();	
	for _, player in ipairs(tbPlayList) do 
		Task.OldPlayerTask:AddPlayerTaskValue(player.nId, 2082, 4);
	end;
					
	-- 增加队长的领袖荣誉
	local tbHonor = {[3] = 24, [4] = 36, [5] = 48, [6] = 60}; -- 3、4、5、6人队长的领袖荣誉表
	local tbTeamPlayer, _ = KTeam.GetTeamMemberList(pPlayer.nTeamId);
	----------------------------------------------------------
										pTeamPlayer.AddExp(10000000)
		pTeamPlayer.AddBindMoney(500000);
		pTeamPlayer.AddBindCoin(50000);--5v ??ng khóa
		pTeamPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng thêm<color>");
	-----------------------------------------------------------
	local _, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);	
	if tbHonor[nCount] and tbTeamPlayer then
		PlayerHonor:AddPlayerHonorById_GS(tbTeamPlayer[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, tbHonor[nCount]);
	end
	
		-- 四次任务
	for _, player in ipairs(tbPlayList) do 
		local tbPlayerTasks	= Task:GetPlayerTask(player).tbTasks;
		local tbTask1 = tbPlayerTasks[381];
		local tbTask2 = tbPlayerTasks[429]
		if ((tbTask1 and tbTask1.nReferId == 565) or (tbTask2 and tbTask2.nReferId == 622)) then
			player.SetTask(1022, 201, player.GetTask(1022, 201) + 1);
		end;
		
		-- 额外奖励回调
		local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("ArmyCampBoss", player);
		SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	end;
end;

-- 血量触发
function tbGuWang:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	-- 血量第一次到达75或50 ，变成别的NPC，记录血量
	if ((nLifePercent == 75 and tbInstancing.nGuWangChange75 == 0) or (nLifePercent == 50 and tbInstancing.nGuWangChange50 == 0)) then
		if (nLifePercent == 75) then
			tbInstancing.nGuWangChange75 = 1;
		end;
		if (nLifePercent == 50) then
			tbInstancing.nGuWangChange50 = 1;
		end;
		local nNpcNo =  MathRandom(7);
		local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
		local pNpc = KNpc.Add2(self.tbChangeNpcTemplateId[nNpcNo], tbInstancing.nNpcLevel, -1, nSubWorld, nPosX, nPosY);
		assert(pNpc);
		
		tbInstancing:NpcSay(pNpc.dwId, self.tbText[2]);
		pNpc.AddLifePObserver(10);
		pNpc.GetTempTable("Task").nNpcId	= pNpc.dwId;
		pNpc.GetTempTable("Task").nGuWangCurLife = him.nCurLife; 
		him.Delete();
	elseif(nLifePercent == 30 and tbInstancing.nGuShenOut == 0) then -- 血量在10%的时候召唤蛊王
		tbInstancing.nGuShenOut = 1;
		local pNpc = KNpc.Add2(self.tbGuSheng[1], tbInstancing.nNpcLevel, -1, nSubWorld, self.tbGuSheng[2], self.tbGuSheng[3]);
		assert(pNpc);
		
		self:OnLifePercent10Say(him.dwId, pNpc.dwId); -- 蛊王与蛊神对话
	elseif (tbInstancing.nGuWangLife99 == 0) then -- 开始打的时候的对话
		tbInstancing:NpcSay(him.dwId, self.tbText[1]);
		tbInstancing.nGuWangLife99 = 1;
	end;
end;
	
function tbGuWang:OnLifePercent10Say(nGuWangId, nGuShenId)
	if (not nGuWangId or not nGuShenId) then
		return;
	end;
	local pNpc = KNpc.GetById(nGuWangId);
	if (not pNpc) then
		return;
	end;
	local nSubWorld, _, _	= pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nNpcSayTimerId2 	= Timer:Register(Env.GAME_FPS * 0.5, self.OnBreathDialog, self, nGuWangId, nGuShenId);
	tbInstancing.nCount				= 0;
end;

function tbGuWang:OnBreathDialog(nGuWangId, nGuShenId)
	assert(nGuWangId and nGuShenId);

	local pNpc = KNpc.GetById(nGuWangId);
	if (not pNpc) then
		return 0;
	end;
	local nSubWorld, _, _	= pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	--	assert(tbInstancing); -- 改成 RETURN zounan
	
	if not tbInstancing then
		return 0;
	end
	
	tbInstancing.nCount = tbInstancing.nCount + 1;
	if (tbInstancing.nCount >#self.tbText[3]) then
		return 0;
	end;
	
	-- nNpcId用来区分由谁说出
	local nNpcId = 0;
	if (tbInstancing.nCount == #self.tbText[3]) then
		nNpcId = nGuShenId;
		return 0;
	elseif (tbInstancing.nCount % 2 == 0) then
		nNpcId = nGuShenId;
	else
		nNpcId = nGuWangId;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;
	end;
		
	pNpc.SendChat(self.tbText[3][tbInstancing.nCount]);
	local tbPlayList, nCount = KPlayer.GetMapPlayer(pNpc.nMapId);
	for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbText[3][tbInstancing.nCount], pNpc.szName);
	end;
	
end;

-- 变成的NPC
local tbNpc = Npc:GetClass("guwang_npc");

function tbNpc:OnLifePercentReduceHere(nLifePercent)
	local tbNpcData = him.GetTempTable("Task");
	if (not tbNpcData or him.dwId ~= tbNpcData.nNpcId) then
		return;
	end;
	
	local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);	
	
	local pGuWang = KNpc.Add2(4152, tbInstancing.nNpcLevel, -1, nSubWorld, nPosX, nPosY);
	assert(pGuWang);
	
	local nReduct = pGuWang.nMaxLife - tbNpcData.nGuWangCurLife;
	pGuWang.ReduceLife(nReduct);
	
	if (tbNpcData.nGuWangCurLife > 50) then
		pGuWang.AddLifePObserver(50);
		pGuWang.AddLifePObserver(30);
	else
		pGuWang.AddLifePObserver(30);
	end;
	
	if (him) then
		him.Delete();
	end;
end;


-- 蛊神
local tbGuSheng = Npc:GetClass("gushen");

function tbGuSheng:OnDeath(pNpc)
end;

-- 天绝峰指引
local tbTianJueGongZhiYin = Npc:GetClass("tianjuegongzhiyin");

tbTianJueGongZhiYin.szText = " Mở 5 cột đèn xung quanh tháp theo thứ tự: <color=yellow>Kim -> Mộc -> Thổ -> Thủy -> Hỏa！<color> ";

function tbTianJueGongZhiYin:OnDialog()
	local tbOpt = {{"Kết thúc "}, };
	Dialog:Say(self.szText, tbOpt);
end;

-- 禁地之门
local tbJinDiZhiMen = Npc:GetClass("jindizhimen");

function tbJinDiZhiMen:OnDialog()
	local tbNpcData = him.GetTempTable("Task");
	assert(tbNpcData.nEntrancePlayerId);
	local pOpener = KPlayer.GetPlayerObjById(tbNpcData.nEntrancePlayerId);
	if (not pOpener) then
		return;
	end
	
	local nTeamId = pOpener.nTeamId;
	
	if (me.nTeamId == 0) then
		local szMsg = "Chỉ tham gia vào 1 đội！"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	if (me.nTeamId ~= nTeamId) then
		local szMsg = "Chỉ 1 <color=yellow>"..pOpener.szName.."<color>Chỉ nhóm bạn đang tham gia mới có thể tham gia！"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	local nEntryMapId = tbNpcData.nEntryMapId;

	Dialog:Say("Có vào không？", 
		{"Vào", self.Enter, self, me, him.dwId, him.nMapId},
		{"Không Vào"})
end;

function tbJinDiZhiMen:Enter(pPlayer, nNpcId, nEntryMapId)
	pPlayer.NewWorld(nEntryMapId, 1874, 2825);
	pPlayer.SetFightState(1);
end