-------------------------------------------------------------------
--File: 	helpquestion.lua
--Author: 	sunduoliang
--Date: 	2008-3-6 16:30:24
--Describe:	帮助问答
-------------------------------------------------------------------

HelpQuestion.tbGroup = {};
HelpQuestion.QUESTION_CONFIG = "\\setting\\event\\helpquestion\\question.txt";
HelpQuestion.GROUP_CONFIG = "\\setting\\event\\helpquestion\\group.txt";
HelpQuestion.tbPlayerIdList = {};
HelpQuestion.RIGHT = 1;
HelpQuestion.WRONG = 0;
HelpQuestion.TASK_GROUP_ID = 2021;
function HelpQuestion:GetTitleTable(pPlayer)
	if pPlayer == nil then
		return 0;
	end
	local tbTitle = {};
	if self.tbGroup == nil or #self.tbGroup == 0 then
		self:LoadGroup();
	end
	local nCount = 0;
	for nGroupId, tbGroupInfo in pairs(self.tbGroup) do
		if self:CheckLimit(pPlayer, nGroupId) == 1 then
			tbTitle[nGroupId] = tbGroupInfo.szTitle;
			nCount = nCount + 1;
		end 
	end
	return tbTitle, nCount;
end

--自己指令测试使用(打开题库)
--function HelpQuestion:TestTable(pPlayer)
--	local tb = self:GetTitleTable(pPlayer)
--	local tbopt = {}
--	for x, y in pairs(tb) do
--		tbopt[#tbopt+1] = {y,self.StartGame,self,pPlayer,x}
--	end
--	Dialog:Say("题组,单服测试用.",tbopt);
--end

function HelpQuestion:StartGame(pPlayer, nGroupId)
	if pPlayer == nil then
		return 0;
	end
	if self:CheckLimit(pPlayer, nGroupId) == 0 then
		return 0;
	end
	local szAwardMsg = "";
	local nSign = 0;
	if self.tbGroup[nGroupId].nAwardMoney ~= 0 then
		szAwardMsg = string.format("<color=yellow>%s bạc<color>", self.tbGroup[nGroupId].nAwardMoney);
		nSign = 1;
	end
	if nSign == 1 then
		szAwardMsg = szAwardMsg .. " và ";
	end
	if self.tbGroup[nGroupId].nAwardCoin ~= 0 then
		szAwardMsg = string.format("%s <color=yellow>%s<color> %s khóa", szAwardMsg, self.tbGroup[nGroupId].nAwardCoin, IVER_g_szCoinName);
	end
	local szNeedMoney = "";
	nSign = 0;
	if self.tbGroup[nGroupId].nMoney > 0 then
		szNeedMoney = string.format("<color=yellow>%s bạc<color>", self.tbGroup[nGroupId].nMoney);
		nSign = 1;
	end
	if nSign == 1 then
		szNeedMoney = szNeedMoney .. " và ";
	end
	
	if self.tbGroup[nGroupId].nBindMoney > 0 then
		szNeedMoney = string.format("<color=yellow>%s bạc khóa<color>", self.tbGroup[nGroupId].nBindMoney);
	end
	
	local szMsg = string.format("    Chào mừng đến với câu hỏi kiếm hiệp đặc biệt, chỉ cần nộp %s là có thể tham gia, đáp đúng <color=yellow>%s<color> câu hỏi liên quan đến Kiếm Thế sẽ nhận được %s, nếu đáp sai hoặc bỏ cuộc sẽ không được thưởng, không trả lại %s đã nộp. Tham gia ngay?", szNeedMoney, self.tbGroup[nGroupId].nQuestionMax, szAwardMsg, szNeedMoney);
	local tbOpt =
	{
		{"Đương nhiên phải tham gia!", self.AppleGoOnGame, self, pPlayer, nGroupId},
		{"Ta chưa chuẩn bị, lát nữa hãy đến."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function HelpQuestion:AppleGoOnGame(pPlayer, nGroupId)
	if pPlayer == nil then
		return 0;
	end
	if self:CheckLimit(pPlayer, nGroupId) == 0 then
		return 0;
	end
	if pPlayer.nCashMoney < self.tbGroup[nGroupId].nMoney then
		Dialog:Say("Chà~ không đủ tiền, không được tham gia trả lời.","Ta đi nộp phí ghi danh rồi quay lại.");
		return 0;
	end
	if pPlayer.GetBindMoney() < self.tbGroup[nGroupId].nBindMoney then
		Dialog:Say("Chà~ không đủ tiền, không được tham gia trả lời.","Ta đi nộp phí ghi danh rồi quay lại.");
		return 0;
	end	
	if self.tbGroup[nGroupId].nMoney > 0 then
		if pPlayer.CostMoney(self.tbGroup[nGroupId].nMoney, Player.emKPAY_HELP_QUESTION) == 0 then
			return 0;
		end
	end
	if self.tbGroup[nGroupId].nBindMoney > 0 then
		if pPlayer.CostBindMoney(self.tbGroup[nGroupId].nBindMoney, Player.emKBINDMONEY_COST_HELP_QUESTION) == 0 then
			return 0;
		end
	end	
	self.tbPlayerIdList[pPlayer.nId] = 0;
	self:DoStartGame(pPlayer, nGroupId);
end

function HelpQuestion:DoStartGame(pPlayer, nGroupId)
	if pPlayer == nil then
		return 0;
	end
	if self:CheckLimit(pPlayer, nGroupId) == 0 then
		return 0;
	end
	self.tbPlayerIdList[pPlayer.nId] = self.tbPlayerIdList[pPlayer.nId] + 1;
	local nNowQId = self.tbPlayerIdList[pPlayer.nId];
	if self.tbGroup[nGroupId].tbQuestion == nil or #self.tbGroup[nGroupId].tbQuestion == 0 then
		self:LoadQuestion()
	end
	if nNowQId > #self.tbGroup[nGroupId].tbQuestion then
		self:Award(pPlayer, nGroupId)
		return 1;
	end
	
	local szQuestion = self.tbGroup[nGroupId].tbQuestion[nNowQId].szQuestion;
	local tbAnswser = {};
	tbAnswser[1] = {self.tbGroup[nGroupId].tbQuestion[nNowQId].szAnswer, self.CheckAnswer, self, pPlayer, nGroupId, self.RIGHT};
	
	for nQ = 1, 3 do 
		local szSelect = self.tbGroup[nGroupId].tbQuestion[nNowQId].tbSelect[nQ]
		if szSelect ~= nil and szSelect ~= "" then
			tbAnswser[#tbAnswser+1] = {self.tbGroup[nGroupId].tbQuestion[nNowQId].tbSelect[nQ], self.CheckAnswer, self, pPlayer, nGroupId, self.WRONG};
		end
	end
	tbAnswser = self:GetRandomTable(tbAnswser, #tbAnswser);
	table.insert(tbAnswser, {"Trả lời sau"});
	Dialog:Say(szQuestion, tbAnswser);
end

function HelpQuestion:CheckAnswer(pPlayer, nGroupId, nIsRight)
	if pPlayer == nil then
		return 0;
	end
	if nIsRight == self.WRONG then
		local tbOpt =
		{
			{"Thách đấu lại.", self.StartGame, self, pPlayer, nGroupId},
			{"Khoan trả lời, trả lời sau."},
		}
		Dialog:Say("Trả lời sai rồi, thử lại đi!",tbOpt);
		return 0;
	end
	if nIsRight == self.RIGHT then
		self:DoStartGame(pPlayer, nGroupId);
	end
end

function HelpQuestion:Award(pPlayer, nGroupId)
	if self.tbGroup[nGroupId].nAwardMoney ~= 0 then
		pPlayer.Earn(self.tbGroup[nGroupId].nAwardMoney, Player.emKEARN_HELP_QUESTION);
		KStatLog.ModifyAdd("jxb", "[Nơi] Từ điển kiếm hiệp", "Tổng", self.tbGroup[nGroupId].nAwardMoney);
	end
	
	if self.tbGroup[nGroupId].nAwardCoin ~= 0 then
		pPlayer.AddBindCoin(self.tbGroup[nGroupId].nAwardCoin, Player.emKBINDCOIN_ADD_HELP_QUESTION);
		pPlayer.Msg(string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> %s khóa",self.tbGroup[nGroupId].nAwardCoin, IVER_g_szCoinName));
		KStatLog.ModifyAdd("bindcoin", "[Nơi] Từ điển kiếm hiệp", "Tổng", self.tbGroup[nGroupId].nAwardCoin);
	end
	pPlayer.SetTaskBit(HelpQuestion.TASK_GROUP_ID,nGroupId,1);
	Dialog:Say("Bạn đã đáp đúng hết!");
	
	-- 完成师徒成就
	Achievement:FinishAchievement(pPlayer.nId, Achievement.JXCIDIAN);
end

function HelpQuestion:CheckLimit(pPlayer,nGroupId)
	if pPlayer == nil then
		return 0;
	end
	if pPlayer.nLevel < self.tbGroup[nGroupId].nLevel then
		--Dialog:Say("您的等级不够，不能参加本组答题。");
		return 0;
	end 	
	if pPlayer.GetTaskBit(HelpQuestion.TASK_GROUP_ID,nGroupId) ~= 0 then
		--Dialog:Say("您已经答过该题。");
		return 0;
	end
	return 1;
end

function HelpQuestion:GetRandomTable(tbitem, nmax)
	for ni = 1, nmax do
		local p = Random(nmax) + 1;
		tbitem[ni], tbitem[p] = tbitem[p], tbitem[ni];
	end
	return tbitem;	
end

function HelpQuestion:LoadQuestion()
	if self.tbGroup == nil or #self.tbGroup == 0 then
		self:LoadGroup();
	end
	local tbQuestionFile = Lib:LoadTabFile(self.QUESTION_CONFIG);
	if tbQuestionFile == nil then
		return 0;
	end
	local nLineCount = #tbQuestionFile;	--加载题库信息
	for nLine=1, nLineCount do
		local nGroupId  = tonumber(tbQuestionFile[nLine].GROUPID);
		--local nId = tonumber(tbQuestionFile[nLine].QID);
		local szQuestion = tbQuestionFile[nLine].QUESTION;
		local szAnswer = tbQuestionFile[nLine].ANSWER;
		local szSelect1 = tbQuestionFile[nLine].SELECT1;
		local szSelect2 = tbQuestionFile[nLine].SELECT2;
		local szSelect3 = tbQuestionFile[nLine].SELECT3;
		if self.tbGroup[nGroupId].tbQuestion == nil then
			self.tbGroup[nGroupId].tbQuestion = {};
		end
		local nId = #self.tbGroup[nGroupId].tbQuestion + 1;
		self.tbGroup[nGroupId].tbQuestion[nId] = {};
		self.tbGroup[nGroupId].tbQuestion[nId].szQuestion = szQuestion;
		self.tbGroup[nGroupId].tbQuestion[nId].szAnswer = szAnswer;
		self.tbGroup[nGroupId].tbQuestion[nId].tbSelect = {}
		self.tbGroup[nGroupId].tbQuestion[nId].tbSelect[1] = szSelect1;
		self.tbGroup[nGroupId].tbQuestion[nId].tbSelect[2] = szSelect2;
		self.tbGroup[nGroupId].tbQuestion[nId].tbSelect[3] = szSelect3;
		self.tbGroup[nGroupId].nQuestionMax = self.tbGroup[nGroupId].nQuestionMax + 1;
	end
end

function HelpQuestion:LoadGroup()		--加载题组信息
	self.tbGroup = {};
	local tbQuestionFile = Lib:LoadTabFile(self.GROUP_CONFIG);
	if tbQuestionFile == nil then
		return 0;
	end
	local nLineCount = #tbQuestionFile;
	for nLine=1, nLineCount do
		local nGroupId  = tonumber(tbQuestionFile[nLine].GROUPID);
		local nLevel = tonumber(tbQuestionFile[nLine].LEVEL) or 0;
		--local nGouHuo = tonumber(tbQuestionFile[nLine].GOUHUO) or 0;
		local nMoney = tonumber(tbQuestionFile[nLine].MONEY) or 0;
		local nBindMoney = tonumber(tbQuestionFile[nLine].BINDMONEY) or 0;
		local nAwardMoney = tonumber(tbQuestionFile[nLine].AWARD_MONEY) or 0;
		
		local nAwardCoin = tonumber(tbQuestionFile[nLine].AWARD_COIN) or 0;
		local szTitle = tbQuestionFile[nLine].TITLE;
		self.tbGroup[nGroupId] = {};
		self.tbGroup[nGroupId].nLevel = nLevel;
		--self.tbGroup[nGroupId].nGouHuo = nGouHuo;
		self.tbGroup[nGroupId].szTitle = szTitle;
		self.tbGroup[nGroupId].nMoney = nMoney;
		self.tbGroup[nGroupId].nBindMoney = nBindMoney;
		self.tbGroup[nGroupId].nAwardMoney = nAwardMoney;
		self.tbGroup[nGroupId].nAwardCoin = nAwardCoin;
		self.tbGroup[nGroupId].nQuestionMax = 0;
	end
end

if HelpQuestion.tbGroup == nil or #HelpQuestion.tbGroup == 0 then
	HelpQuestion:LoadGroup();
	HelpQuestion:LoadQuestion();
end
