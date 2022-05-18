-----------------------------------------------------------
-- 文件名　：shenzhufengnpc.lua
-- 文件描述：神蛛峰NPC脚本
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-26 20:39:28
-----------------------------------------------------------

-- 锣
local tbLuo = Npc:GetClass("luo");
-- 传送玩家的位置
tbLuo.tbPlayerPos = {1952, 2896};

tbLuo.tbPlayText = {"Ai dám động vào vật cấm của tôi! "," Sứ thần Nhện chúa"};

-- 刷出的幼虫的位置
tbLuo.tbZhiZhuYouChongPos = { {1952, 2885}, {1946, 2907}, {1942, 2897}, {1945, 2888}, {1959, 2906}, {1953, 2910}, {1959, 2888}, {1962, 2897},}
-- 敲锣
function tbLuo:OnDialog()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	-- 可以敲鼓就不能再敲锣
	if (tbInstancing.nPlayDrumCount == 1) then
		return;
	end;
	-- 时间是否到
	if (tbInstancing.nPlayDrumTime ~= 0) then
		me.Msg("Bạn vẫn phải đợi" .. tbInstancing.nPlayDrumTime .. "Vài giây trước khi bạn có thể tiếp tục đánh cồng");
		return;
	end;
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
		-- 播放音乐
	local szMsg 	= "setting\\audio\\obj\\ss034.wav"; 
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"PlaySound", szMsg, 3});
	end;
	GeneralProcess:StartProcess("Gõ cồng", 0.5 * Env.GAME_FPS, {self.OnPlay, self, me.nId, tbInstancing, nSubWorld}, {self.BreakPlay, self, me.nId, tbPlayList, szSound, "Bị gián đoạn！"}, tbEvent);
end;

function tbLuo:BreakPlay(nPlayerId, tbPlayList, szSound, szMsg)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.Msg(szMsg);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"StopSound", szSound});
	end;	
end;

function tbLuo:OnPlay(nPlayerId, tbInstancing, nSubWorld)
	tbInstancing.nPlayDrumTime = 10;
	
	-- 传送
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbPlayText[1], self.tbPlayText[2]);
		teammate.NewWorld(tbInstancing.nMapId, self.tbPlayerPos[1], self.tbPlayerPos[2]);
		teammate.SetFightState(1);
	end;
	-- 删除幼虫
	for i = 1, #tbInstancing.tbWenZhu do
		if (tbInstancing.tbWenZhu[i]) then
			local pNpc = KNpc.GetById(tbInstancing.tbWenZhu[i]);
			if (pNpc) then
				pNpc.Delete();
			end;
		end;
	end;
	tbInstancing.tbWenZhu = {};
	-- 重新刷出幼虫
	for i = 1, 5 do
		for i = 1, #self.tbZhiZhuYouChongPos do
			local pYouChong = KNpc.Add2(4131, tbInstancing.nNpcLevel, -1 , nSubWorld, self.tbZhiZhuYouChongPos[i][1], self.tbZhiZhuYouChongPos[i][2]);
			assert(pYouChong);
			tbInstancing.tbWenZhu[#tbInstancing.tbWenZhu + 1] = pYouChong.dwId;
		end;
	end;
end;


-- 文珠
local tbWenZhu = Npc:GetClass("wenzhu");

tbWenZhu.tbDeathText = {"Các người, tôi sẽ làm cho các bạn chết xấu xí。", "Nhện chúa"};

function tbWenZhu:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then	-- 
		return;
	end;
	
	tbInstancing.nWenZhu = tbInstancing.nWenZhu + 1;
	
	if (tbInstancing.nWenZhu % 10 == 0) then
		local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbDeathText[1], self.tbDeathText[2])
		end;
	end;
	
	if (tbInstancing.nWenZhu >= 200 and tbInstancing.nPlayDrumCount == 0) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "Bây giờ bạn có thể Đánh Trống！");
			tbInstancing.nPlayDrumCount = 1;
			for i = 1, #tbInstancing.tbWenZhu do
				if (tbInstancing.tbWenZhu[i]) then
					local pNpc = KNpc.GetById(tbInstancing.tbWenZhu[i]);
					if (pNpc) then
						pNpc.Delete();
					end;
				end;
			end;
			tbInstancing.tbWenZhu = {};
		end;
	end; 
end;


-- 鼓
local tbGu = Npc:GetClass("gu");
-- 蛛母出现的位置
tbGu.tbZhuMuPos = {1976, 2851};

tbGu.tbPlayText = {"Ngươi đang tìm đến cái chết! "," Sứ thần Nhện chúa"}
-- 敲鼓
function tbGu:OnDialog()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	-- 是否可以打鼓
	if (tbInstancing.nWenZhu < 200) then
		me.Msg("Đừng đánh trống！");
		return;
	end;
	-- 是否已经敲过鼓
	if (tbInstancing.nPlayGongCount ~= 0) then
		return;
	end;
		
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	
	-- 播放音乐
	local szMsg 	= "setting\\audio\\obj\\ss033s.wav"; 
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"PlaySound", szMsg, 3});
	end;
	
	GeneralProcess:StartProcess("Đánh trống", 0.5 * 18, {self.OnPlay, self, me.nId, tbInstancing, nSubWorld}, {self.BreakPlay, self, me.nId, tbPlayList, szSound, "Bị gián đoạn！"}, tbEvent);	
end;

function tbGu:BreakPlay(nPlayerId, tbPlayList, szSound, szMsg)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.Msg(szMsg);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"StopSound", szSound});
	end;	
end;

function tbGu:OnPlay(nPlayerId, tbInstancing, nSubWorld)
	-- 是否已经敲过鼓
	if (tbInstancing.nPlayGongCount ~= 0) then
		return;
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbPlayText[1], self.tbPlayText[2])
	end;
	
	tbInstancing.nPlayGongCount = 1;
	local pZhuMu = KNpc.Add2(4132, tbInstancing.nNpcLevel, -1 , nSubWorld, self.tbZhuMuPos[1], self.tbZhuMuPos[2]);
	assert(pZhuMu);
	
	pZhuMu.AddLifePObserver(99);
	pZhuMu.AddLifePObserver(90);
	pZhuMu.AddLifePObserver(70);
	pZhuMu.AddLifePObserver(50);
	pZhuMu.AddLifePObserver(30);
	pZhuMu.AddLifePObserver(10);
	
	if (tbInstancing.nLiuYiBanOutCount ~= 0) then
		local pNpc = KNpc.Add2(4155, tbInstancing.nNpcLevel, -1, nSubWorld, 1979, 2855);
		pNpc.AddLifePObserver(40);
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Thần Chu Sứ đã xuất hiện");
	end;
end;

-- 蛛母
local tbZhuMu = Npc:GetClass("shenzhushi");

tbZhuMu.tbText = {
	[99] = {"Có vẻ như đứa con thứ hai đã bị đánh bại thảm hại, phải không?", "Tôi không thể thấy rằng bạn có một kỹ năng sâu sắc như vậy khi còn trẻ!"},
[90] = {"Mọi người đi đến nơi cao, và nước chảy về nơi thấp!", "Tốt hơn là tham gia Giáo phái Gu của chúng tôi!", "Tôi sẽ dạy bạn cách thực hành Gu!"},
[70] = {"Nếu cô không buông tha cho bà già của tôi, tôi sẽ phát điên mất!", "Con thú nhỏ thực sự biết điều gì là tốt hay xấu?"},
[50] = {"Chúng ta không có thù oán trong quá khứ và không có thù hận trong tương lai gần!", "Tại sao các bạn lại làm điều này?", "Tại sao lại làm phiền tôi với tư cách là một người phụ nữ?"},
[30] = {"Tình hình hơi tệ!", "Tôi nên xem hướng thoát thân!"},
[10] = {"Mẹ của con, con sẽ không chơi với mẹ!", "Điều này, điều này là không thể!"},
[0] = {"Tôi đánh giá quá cao bản thân mình!", "Nhện Chúa"},

}
function tbZhuMu:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();

	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	tbInstancing.nShenZhuFengPass = 1;
	
	him.SendChat(self.tbText[0][1]);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[0][1], self.tbText[0][2]);
	end;
	
	if (tbInstancing.nJinZhiShenZhuFeng) then
		local pNpc = KNpc.GetById(tbInstancing.nJinZhiShenZhuFeng);
		pNpc.Delete();
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Bạn có thể đi tiếp！");
	end;
end;

function tbZhuMu:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
	
	if (nLifePercent == 10) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.NewWorld(tbInstancing.nMapId, 1952, 2896);
			teammate.SetFightState(1);
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "Con nhện sử dụng mạng lưới tình yêu để đóng khung bạn và đồng đội của bạn！");
		end;
	end;
end;

-- 神蛛峰指引
local tbBiWuFengZhiYin = Npc:GetClass("shenzhufengzhiyin");

tbBiWuFengZhiYin.szText = "    Sứ thần nhện thần phía trước vẫn nghe gió giăng lưới tình lớn, chờ ngươi quăng mình vào lưới. Tôi vẫn ở đây, tôi biết điều đó, không phải sợ。\n\n    Chìa khóa để phá đội hình chính là chiếc gông trên Đỉnh Nhện Thần.，<color=red>Chỉ cần tiếng cồng vang lên, nhện thần sẽ lầm tưởng là các đòn tấn công của nó đang tràn ra, và chỉ cần bị hạ gục và rút lui, nhện thần có thể đánh trống để gặp sứ thần nhện thần.。<color>Cần lưu ý, một khi đánh cồng thì mọi người sẽ bị hút vào tâm đội hình, lúc này đàn nhện phải tràn ra ngoài nên các bạn hãy cẩn thận nhé! Nhớ lại! Nhớ lại！\n\n    Một khi mạng lưới tình yêu bị phá vỡ, nó có thể nhanh chóng<color=red>Đánh trống trước sảnh của sứ thần nhện<color>，Đây là ám hiệu thiên sứ thả thiên lôi để hại người, chỉ cần thiên kim bay ra thì thiên sứ cũng không sợ hãi.。";

function tbBiWuFengZhiYin:OnDialog()
	local tbOpt = {{"Kết thúc đối thoại"}, };
	Dialog:Say(self.szText, tbOpt);
end;