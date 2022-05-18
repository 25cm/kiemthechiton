-------------------------------------------------------
-- 文件名　：jinjimilinnpc.lua
-- 文件描述：荆棘密林NPC
-- 创建者　：ZhangDeheng
-- 创建时间：2009-03-16 10:35:31
-------------------------------------------------------

local tbNpc_1 = Npc:GetClass("hl_jiheshi");

tbNpc_1.szDesc	= "Tập Hợp Thạch"
tbNpc_1.SEND_POS	= {1702, 3328};

function tbNpc_1:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (tbInstancing.nJiHeShiTime ~= 0) then
		local szMsg = "Hiện không thể sử dụng, đợi " .. tbInstancing.nJiHeShiTime .. " giây nữa!";
		local tbOpt = {"Kết thúc đối thoại"};
		Dialog:Say(szMsg, tbOpt);
		return;
	end;
	if (tbInstancing.nJiHeShiCanUse ~= 1) then
		return ;
	end;
	
	local tbOpt = {};
	local szMsg = "Chọn đồng đội muốn triệu tập";
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		if (tbInstancing.tbPassJingJiMiLin[teammate.nId] ~= 1 and teammate.nId ~= me.nId) then
			tbOpt[#tbOpt + 1] = { teammate.szName, self.CallUp, self, tbInstancing, teammate.nId};
		end;
	end;
	if (#tbOpt == 0) then
		szMsg = "Đồng đội của bạn đã vượt qua rừng gai, không cần triệu tập!";
	end;
	tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
	Dialog:Say(szMsg, tbOpt);
end;

function tbNpc_1:CallUp(tbInstancing, nId)
	if (tbInstancing.tbPassJingJiMiLin[nId] and tbInstancing.tbPassJingJiMiLin[nId] == 1) then
		return;
	end;
	
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if (not pPlayer or pPlayer.nMapId ~= tbInstancing.nMapId) then
		return;
	end;
	
	Setting:SetGlobalObj(pPlayer);
	
	local tbPlayerDarkData	= BlackSky:GetDarkData();
	if (tbPlayerDarkData.nInDark == 1) then
		Setting:RestoreGlobalObj();
		return;
	end;
	
	local szMsg = "Đồng đội triệu tập bạn, có muốn đến ngay?";
	local tbOpt = {
			{"Có",  self.SendNewPos, self, tbInstancing},
			{"Không"},
		};
	Dialog:Say(szMsg, tbOpt);		
	Setting:RestoreGlobalObj();
end;	

function tbNpc_1:SendNewPos(tbInstancing)
	if (tbInstancing.nJiHeShiTime ~= 0) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, self.SEND_POS[1], self.SEND_POS[2]);
	tbInstancing.nJiHeShiTime	= 30;
	me.SetFightState(1);
	Task.tbArmyCampInstancingManager:Tip2MapPlayer(me.nMapId, "<color=yellow>" .. me.szName .. "<color> Đã được dịch chuyển qua rừng gai");
end;


local tbNpc_2 = Npc:GetClass("hl_round1");

tbNpc_2.szDesc 	= "Mở BOSS1"
tbNpc_2.szText 	= "<npc=4181>: Nghĩa quân? Các ngươi tới làm gì, có phải Bạch Thu Lâm phái các ngươi tới? Hay là Long Ngũ.";
tbNpc_2.tbBoss1Pos	= {1719, 3290};
tbNpc_2.EFFECT_NPC	= 2976


function tbNpc_2:OnDialog()
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss1Out ~= 0) then
		return;
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.szText, self.TalkEnd, self, him.dwId, tbInstancing);
		Setting:RestoreGlobalObj();
	end;	
end;

function tbNpc_2:TalkEnd(dwId, tbInstancing)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc or tbInstancing.nBoss1Out ~= 0) then
		return;
	end;
	
	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(self.EFFECT_NPC, 10, -1, tbInstancing.nMapId, self.tbBoss1Pos[1], self.tbBoss1Pos[2]);
	Timer:Register(0.5 * Env.GAME_FPS, self.CallBoss, self, nMapId, pNpc.dwId);
end;

function tbNpc_2:CallBoss(nMapId, dwId)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc) then
		return 0;	
	end;
	pNpc.Delete();
		
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss1Out ==1) then
		return 0 ;
	end;
		
	local pNpc = KNpc.Add2(4181, tbInstancing.nNpcLevel, -1, nMapId, self.tbBoss1Pos[1], self.tbBoss1Pos[2]);
	pNpc.CastSkill(1163, 10, -1, pNpc.nIndex);
	
	for i = 1, 9 do
		pNpc.AddLifePObserver(i * 10);
	end;
	tbInstancing.nBoss1Out = 1;	
	
	return 0;
end;

local tbNpc_1 = Npc:GetClass("hl_boss1");

tbNpc_1.szDesc 	= "BOSS1"
tbNpc_1.tbText  = {
		[90] = "Hay là ngươi còn có thể nhớ kỹ ta, hay là ngươi đã quên.",
		[80] = "Trở về đi, ở đây bất thuộc về ngươi.",
		[70] = "Ta đích thê nhi có khỏe không?",
		[60] = "Không được các ngươi quấy nhiễu chủ nhân của ta!",
		[50] = "Tuy rằng ta chỉ thị một thủ vệ đích, nhưng không nên đánh giá thấp liễu ta đích năng lực.",
		[40] = "Ta không muốn tái kiến các ngươi, thực sự.",
		[30] = "Cảm thụ được liễu mạ? Ta đích năng lực đề thăng liễu rất nhiều.",
		[20] = "Sinh bất phùng thì, anh hùng không đất dụng võ.",
		[10] = "Tái kiến liễu, bằng hữu của ta, ta sẽ không quên của ngươi.",
		[0] = "<npc=4181>: ai, mong muốn các ngươi có thể sống trở về. Nếu như ngươi năng nhìn thấy ta đích thê nhi thỉnh giúp ta chuyển cáo, ta thương hắn môn.",
	}

function tbNpc_1:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	if (self.tbText[nLifePercent]) then
		him.SendChat(self.tbText[nLifePercent]);
		
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
				teammate.Msg(self.tbText[nLifePercent], him.szName);
		end;
	end;
end;

function tbNpc_1:OnDeath(pNpc)
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	
	tbInstancing.nTrap2Pass = 1;
	tbInstancing.nJiHeShiCanUse = 0;
	
	local pNpc = KNpc.Add2(4151, 120, -1, tbInstancing.nMapId, 55200 / 32, 105056 / 32);
	pNpc.szName = "";
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.tbText[0]);
		Setting:RestoreGlobalObj();
	end;	
end;