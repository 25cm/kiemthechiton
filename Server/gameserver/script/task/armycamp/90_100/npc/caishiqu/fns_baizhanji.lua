----------------------------------------
-- 百斩吉
-- ZhangDeheng
-- 2008/10/29  8:41
----------------------------------------

local tbBaiZhanJi_Fight = Npc:GetClass("fnsbaizhanjifight");

tbBaiZhanJi_Fight.BOXID	= 4113; --打死BOSS后掉落宝箱的ID
-- 用于记录血量在一定的时候的话是否说了
tbBaiZhanJi_Fight.tbLifePercentSay =
{
	[100] = false,
	[90]  = false,
	[49]  = false,
	[9]   = false,
}

-- 每隔一定时间说的话
tbBaiZhanJi_Fight.tbOnTimerSayText = 
{
	[100] = {
		"Nhà của chúng ta dưỡng đích đều là quý báu đích hãm hại đa la phu tê kê.",
		"Lai, ôn chích kê!",
		"Tổng nghĩ có chuyện gì một bạn, thế nhưng hựu nghĩ không ra...",
		},
	[90] = {
		"Trở lại! Trở lại! Chúng ta tái ngoạn ngoạn!",
		"Xem ra, yếu cật kỷ khẩu thịt gà bổ bổ liễu! Ngừng tay!",
		"Người na, cho ta điểm khẳng đắc kê bổ sung ta nội lực!",
	},
	[49] = {
		"Ta muốn đem các ngươi đánh cho kê mao bay loạn!",
		"Ngươi nói cái gì? Ngươi xác định ngươi là tại hướng ta cầu xin tha thứ mạ?",
		"Ngươi chạy không được liễu, con gà con môn!",
	},
	[9]  = {
		"Dời đi địch nhân lực chú ý! Khán ~ hôi kê! !",
		"Ta hiện tại bắt đầu cảm nhận được bị ta ăn tươi đích kê đích cảm giác liễu!",
		"Cút ngay!",
	}, 
}

-- 血量在一定的时候说的话
tbBaiZhanJi_Fight.tbOnLifeSayText = 
{
	[100] = "Các ngươi cũng dám lai địa bàn của ta dương oai? Xem ta diều hâu trảo con gà con!",
	[90] = "Ai u đau quá, dời đi địch nhân lực chú ý! Khán ~ hôi kê! !",
	[49] = "Cơ thể có điểm toan a.",
	[9]  = "Ta... Ta... !",
}

-- 死亡时执行
function tbBaiZhanJi_Fight:OnDeath(pNpc)
	Task.tbToBeDelNpc[him.dwId] = 0;
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (tbInstancing.nBzhjTimerId and tbInstancing.nBzhjTimerId > 0) then
		Timer:Close(tbInstancing.nBzhjTimerId);
		tbInstancing.nBzhjTimerId = nil;
	end
	
	-- 掉一个宝箱
	local pBaoXiang = KNpc.Add2(self.BOXID, 1, -1, nSubWorld, nNpcPosX, nNpcPosY);
	assert(pBaoXiang)

	local pPlayer  	= pNpc.GetPlayer();
	pBaoXiang.GetTempTable("Task").nOwnerPlayerId = pPlayer.nId;
	pBaoXiang.GetTempTable("Task").CUR_LOCK_COUNT = 0;
end;

-- 每帧执行一次
function tbBaiZhanJi_Fight:OnBreath(nId)
	local pNpc = KNpc.GetById(nId);
	local nSubWorld, _, _ = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	assert(tbInstancing);
	
	if not tbInstancing.nBaiZhanJiCurSec then
		tbInstancing.nBaiZhanJiCurSec = 1;
	else
		tbInstancing.nBaiZhanJiCurSec = tbInstancing.nBaiZhanJiCurSec + 1;
	end
	
	-- 血量在100%的时候每隔20秒说一次话
	if (self:OnTimerSay(nId, 100, 100, 20)) then
		return;
	-- 血量在90% - 50% 的时候每隔10秒说一次话	
	elseif (self:OnTimerSay(nId, 90, 50, 10)) then
		return;
	-- 血量在49% - 10% 的时候每隔10秒说一次话
	elseif (self:OnTimerSay(nId, 49, 10, 10)) then
		return;
	-- 血量在9% - 0% 的时候每隔10秒说一次话
	elseif (self:OnTimerSay(nId, 9, 0, 10)) then
		return;
	-- 在血量低于9的时候说一句话
	elseif (self:OnLifePercentSay(nId, 9)) then
		return;	
	-- 在血量低于49的时候说一句话
	elseif (self:OnLifePercentSay(nId, 49)) then
		return;	
	-- 在血量低于90的时候说一句话
	elseif (self:OnLifePercentSay(nId, 90)) then
		return;	
	-- 在被攻击的时候说一句话
	elseif (self:OnLifePercentSay(nId, 100)) then
		return;
	end;
end

-- 当血量在一定百分比的时候说话
function tbBaiZhanJi_Fight:OnLifePercentSay(nId, nLifePercent)
	local pNpc = KNpc.GetById(nId);
	assert(pNpc);
	local nSubWorld, _, _ = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local nPercent = (pNpc.nCurLife / pNpc.nMaxLife) * 100;
	if (nPercent < nLifePercent and not self.tbLifePercentSay[nLifePercent]) then
		pNpc.SendChat(self.tbOnLifeSayText[nLifePercent]);
		self.tbLifePercentSay[nLifePercent] = true;
		tbInstancing.nBaiZhanJiCurSec = 0;
		return true;
	else 
		return false;
	end;
end;

-- 当血量在一定范围内 每隔一定时间说一次话
function tbBaiZhanJi_Fight:OnTimerSay(nId, nLifeMax, nLifeMin, nTime)
	local pNpc = KNpc.GetById(nId);
	assert(pNpc);
	local nSubWorld, _, _ = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local nPercent = (pNpc.nCurLife / pNpc.nMaxLife) * 100;
	if (nPercent <= nLifeMax and nLifeMin <= nPercent and tbInstancing.nBaiZhanJiCurSec % nTime == 0) then
		local nTextId = MathRandom(#self.tbOnTimerSayText[nLifeMax]);
		pNpc.SendChat(self.tbOnTimerSayText[nLifeMax][nTextId]);
		tbInstancing.nBaiZhanJiCurSec = 0;
		return true;
	else 
		return false;	
	end;	
end;

-- 对话百斩吉
local tbBaiZhanJi_Dialog = Npc:GetClass("fnsbaizhanjidialog");

function tbBaiZhanJi_Dialog:OnDialog()
	local tbPlayerTask = Task:GetPlayerTask(me) --获得玩家的任务
	local tbOpt = {};
	local szMsg = string.format("%s: Đi đi, ta ghét bị các ngươi sai vặt!", him.szName);
	
	local tbTask = tbPlayerTask.tbTasks[0x122];
	
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	if (tbTask and tbTask.nSubTaskId == 0x1D1 and tbTask.nCurStep == 4 and tbInstancing.BAIZHANJI_IS_OUT == 0) then
		szMsg = string.format("%s: ngươi là ai? Ngươi làm thế nào trà trộn vào đây?", him.szName);
		tbOpt[#tbOpt + 1] = {"[Bắt đầu chiến đấu]", self.Fight, self, me.nId, him.dwId};
	end
	
	local tbTask = tbPlayerTask.tbTasks[0x12E];
	if (tbTask and tbTask.nSubTaskId == 0x1DD and tbTask.nCurStep == 4 and tbInstancing.BAIZHANJI_IS_OUT == 0) then
		szMsg = string.format("%s: ngươi là ai? Ngươi làm thế nào trà trộn vào đây?", him.szName);
		tbOpt[#tbOpt + 1] = {"[Bắt đầu chiến đấu]", self.Fight, self, me.nId, him.dwId};
	end

	tbOpt[#tbOpt+1]	= {"[Kết thúc đối thoại]"};
	Dialog:Say(szMsg, tbOpt);
end

function tbBaiZhanJi_Dialog:Fight(nPlayerId,nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pPlayer or not pNpc) then
		return;
	end;
	
	local nSubWorld, nNpcPosX, nNpcPosY = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.BAIZHANJI_IS_OUT ~= 0) then
		return;
	end
	local pBaiZhanJi = KNpc.Add2(4111, tbInstancing.nNpcLevel, -1 , nSubWorld, nNpcPosX, nNpcPosY);
	assert(pBaiZhanJi);
	Task.tbToBeDelNpc[pBaiZhanJi.dwId] = 1;
	
	tbInstancing.nBaiZhanJiCurSec = 0;
	tbInstancing.BAIZHANJI_IS_OUT = 1;
	local tbNpc = Npc:GetClass("fnsbaizhanjifight");

	tbInstancing.nBzhjTimerId = Timer:Register(Env.GAME_FPS, tbNpc.OnBreath, tbNpc, pBaiZhanJi.dwId);
	tbInstancing.nFnsBaiZhanJiId = pBaiZhanJi.dwId;
	
	KTeam.Msg2Team(pPlayer.nTeamId, "<color=yellow>Bắt đầu chiến đấu với Bách Trảm Cát<color>!");
	pNpc.Delete();
end

		