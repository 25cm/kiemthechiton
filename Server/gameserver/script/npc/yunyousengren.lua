
-- 云游僧人

local tbYunyousengren = Npc:GetClass("yunyousengren");

tbYunyousengren.nDelayTime			= 5;			-- 进度条延时的时间为5(秒)
--tbYunyousengren.tbTaskIdUsedCount	= {2007, 1};	-- 一天里使用的慈悲心经的数量的任务变量的Id
tbYunyousengren.tbCibeiItem			= {				-- 慈悲心经
	["nGenre"] 				= 18,
	["nDetailType"]			= 1,
	["nParticularType"] 	= 18,
	["nLevel"]				= 1,
};
--tbYunyousengren.tbProbability		= {				-- 每天使用地慈悲心经的数目对应的概率
--	100, 80, 70, 60, 50, 40, 30,
--};

function tbYunyousengren:OnDialog()
	local tbCibeixinjing = Item:GetClass("cibeixinjing");
	local tbOpt = 
	{
		{"Ta phải sám hối để giảm nhẹ PK", self.Repent, self},
		{"Kết thúc đối thoại"}
	}
	Dialog:Say(him.szName..": Nhiều năm nay, ta ngao du khắp nơi, tụng kinh giảng đạo, mong muốn độ hóa chúng sinh, gột rửa nghiệp chướng, để thể hiện lòng từ bi của ta.", tbOpt);
end

-- 忏悔
function tbYunyousengren:Repent()
	-- 临时判断特殊地图限制
	local nCurMapId = me.GetMapId();
	if ((nCurMapId >= 167 and nCurMapId <= 180) or (nCurMapId >= 187 and nCurMapId <= 195)) then
		me.Msg("Nơi đây cấm sử dụng vật phẩm này.");
		return 0;
	end
	if (0 >= me.nPKValue) then
		Dialog:Say("Thí chủ vô tội, không cần phải tụng kinh sám hối.");
		return;
	end
	-- 经验达到或超过-50%,不允许忏悔
	local nExpPercent = math.floor(me.GetExp() * (-100) / me.GetUpLevelExp());
	if (nExpPercent	> 50) then
		Dialog:Say(him.szName..": Điểm kinh nghiệm đã âm 50%, hối hận cũng không có ích gì, lần sau hãy đến!");
		return;
	end
	-- 没有慈悲心经，不能忏悔
	if (me.GetItemCountInBags(self.tbCibeiItem.nGenre, self.tbCibeiItem.nDetailType, self.tbCibeiItem.nParticularType, self.tbCibeiItem.nLevel) <= 0) then
		Dialog:Say(him.szName..": Thí chủ không có kinh văn, tốt nhất hãy mau đi lấy \"Từ Bi Tâm Kinh\" và tụng lại.");
		return;
	end	
	
	Dialog:Say(him.szName..": Thí chủ phải thành tâm tụng \"Từ Bi Tâm Kinh\", ăn năn hối lỗi, lòng đầy thiện ý, mới có thể giảm bớt PK. Tụng kinh ngay?", 
		{
			{"Tụng \"Từ Bi Tâm Kinh\"", self.DelayTime, self},
			{"Ta đi rồi sẽ quay lại"}
		});
end

-- self.nDelayTime(秒)的延时
function tbYunyousengren:DelayTime()
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SIT,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	}
	GeneralProcess:StartProcess("Đang tụng Từ Bi Tâm Kinh…", self.nDelayTime * Env.GAME_FPS, {self.UseItem, self}, nil, tbEvent);		
end

function tbYunyousengren:UseItem()
	if (me.ConsumeItemInBags(1, self.tbCibeiItem.nGenre, self.tbCibeiItem.nDetailType, self.tbCibeiItem.nParticularType, self.tbCibeiItem.nLevel) ~= 0) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "tbYunyousengren", "cibeixinjing not found！");
		return;
	end	
--	
--	local nReadedAmount	= me.GetTask(self.tbTaskIdUsedCount[1], self.tbTaskIdUsedCount[2]) + 1;		-- 获得任务变量的值
--	me.SetTask(self.tbTaskIdUsedCount[1], self.tbTaskIdUsedCount[2], nReadedAmount);				-- 每使用一个慈悲心经，记录每天使用次数的任务变量要加1
--	
--	local nProbability	= 0;		-- 概率（如果成功率是20%，nProbability的值为20）
--	if (nReadedAmount > #self.tbProbability) then
--		nProbability	= self.tbProbability[#self.tbProbability];
--	else
--		nProbability	= self.tbProbability[nReadedAmount];
--	end
--	 
--	if (MathRandom(100) <= nProbability) then
		me.AddPkValue(-1);
		me.Msg("Thành tâm tụng \"Từ Bi Tâm Kinh\", lòng đầy thiện ý, ăn năn hối lỗi, mới giảm được 1 PK!");
--	else
--		me.Msg("你诵读了1篇《慈悲心经》，心中杀意未减，毫无任何效果！");
--	end
end
