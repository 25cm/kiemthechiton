-------GlobalExcute({"Dialog:GlobalNewsMsg_GS","Mỗi ngày vào <color=green>buổi trưa: (từ 12h đến 13h) hoặc buổi tối: (từ 20h đến 21h)<color> <color=gold>NPC Đoán Hoa Đăng<color>: <color=red>Nhan Như Ngọc<color> sẽ xuất hiện tại các Tân Thủ Thôn các nhân sĩ hãy tìm gặp để trà lời các câu hỏi để giành các phần thưởng giá trị!"});
-----KDialog.MsgToGlobal("Mỗi ngày vào <color=green>buổi trưa: (từ 12h đến 13h) hoặc buổi tối: (từ 20h đến 21h)<color> <color=gold>NPC Đoán Hoa Đăng<color>: <color=yellow>Nhan Như Ngọc<color> sẽ xuất hiện tại các Tân Thủ Thôn các nhân sĩ hãy tìm gặp để trà lời các câu hỏi để giành các phần thưởng giá trị!");
------------------------------------------------------------

	--File: 	GuessGame.lua

	--Author: 	sunduoliang

	--Date: 	2008-2-28 17:30:24

	--Describe:	Đoán Hoa Đăng, gây ra

	-------------------------------------------------------------------

if MODULE_GC_SERVER then

return 0;

end

local BEGIN = 1;
local START = 2;
local GAMEOVER=3;
GuessGame.ANNOUCE_STATE_TRANS =
{
-- tiêu chí, thời gian, số lần, chấp hành hàm số, đúng giờ thông cáo
{BEGIN,	1 * 60 * Env. GAME_FPS, 5, "WaitGame", " <color=red>Đoán Hoa Đăng<color> vào lúc (12h - 12h30) hoặc (20h - 20h30) sắp diễn ra, các nhân sĩ hãy đến <color=green>Đạo Hương Thôn<color> để tham gia."},
{START,	5 * 60 * Env. GAME_FPS, 7, "StartGame", " NPC <color=red>Nhan Như Ngọc<color> đã xuất hiện ở vị trí mới. Các nhân sĩ hãy mau chóng tìm kiếm để trả lời câu hỏi vòng tiếp theo."},
{GAMEOVER,0 * 60 * Env. GAME_FPS, 1, "GameOver", " <color=red>Đoán Hoa Đăng<color> vào lúc (12h - 12h30) hoặc (20h - 20h30) đã kết thúc."},
}

GuessGame.nAnnouceState = 0;	-- giai đoạn
GuessGame.nAnnouceCount = 0;	-- từng giai đoạn đích mỗi luân
GuessGame.TBCONFIG = 	-- đố đèn trap điểm [ địa đồ ID] = "trap.txt "

{
[1] = "\\setting\\event\\guessgame\\npctrap\\yunzhongzhen.txt",
[2] = "\\setting\\event\\guessgame\\npctrap\\longmenzhen.txt",
[3] = "\\setting\\event\\guessgame\\npctrap\\yonglezhen.txt",
[4] = "\\setting\\event\\guessgame\\npctrap\\daoxiangcun.txt",
[5] = "\\setting\\event\\guessgame\\npctrap\\jiangjincun.txt",
[6] = "\\setting\\event\\guessgame\\npctrap\\shiguzhen.txt",
[7] = "\\setting\\event\\guessgame\\npctrap\\longquncun.txt",
[8] = "\\setting\\event\\guessgame\\npctrap\\balinjun.txt",
}

GuessGame.TBWEIWANG =
{-- vi tích phân, uy vọng, cống hiến
GRADE  = {100, 150, 200, 250, 300},
WEIWANG = { 2,  3,  4,  5,  6},
GONGXIAN= {	 20, 25, 30, 35, 40},
}

GuessGame.NPC_CHAT = {
"Thế giới võ lâm muôn màu muôn vẻ, <color=red>Đoán Hoa Đăng<color> đang diễn ra hết sức náo nhiệt.",
"Thật nhiều vấn đề không hiểu hết. Vị đại hiệp này có sẵn lòng giúp ta trả lời câu hỏi không ?",
};

GuessGame.NPC_ID = 2703;	-- xoát npc đích mẫu ID
GuessGame.NPC_AI_ID = 3633;	-- xoát AInpc mẫu ID
GuessGame.NPC_LEVEL = 1;		-- xoát npc đích đẳng cấp
GuessGame.NPC_SERIES = Env. SERIES_NONE; -- xoát npc đích ngũ hành thuộc tính
GuessGame.TASK_GROUP_ID = 2012;		-- nhiệm vụ lượng biến đổi, ghi lại nhiệm vụ group
GuessGame.TASK_ALLCOUNT_ID = 1;		-- nhiệm vụ lượng biến đổi, ghi lại cá nhân đáp đề tổng đề sổ
GuessGame.TASK_DATE_ID 	= 2;			-- nhiệm vụ lượng biến đổi, ghi lại đáp đề ngày
GuessGame.TASK_COUNT_ID = 3;			-- nhiệm vụ lượng biến đổi, ghi lại cá nhân một vòng đáp đề đề sổ
GuessGame.TASK_STATE_ID = 4;			-- nhiệm vụ lượng biến đổi, ghi lại ngoạn gia tham gia ngày hôm nay đích đệ mấy luân
GuessGame.TASK_WRONG_ID = 5;			-- nhiệm vụ lượng biến đổi, ghi lại đáp đề lệch lạc đề hào ID
GuessGame.TASK_WRONG_COUNT = 6;		-- nhiệm vụ lượng biến đổi, ghi lại liên tục đáp thác đề mục số lần
GuessGame.TASK_SHARE_ID = 7;			-- nhiệm vụ lượng biến đổi, ghi lại chia xẻ cấp đội viên số lần
GuessGame.TASK_GRADE_ID = 8;			-- nhiệm vụ lượng biến đổi, ghi lại cá nhân đoạt được vi tích phân
GuessGame.TASK_ATTEND_GAME_ID = 9;			-- nhiệm vụ lượng biến đổi, ghi lại cá nhân có hay không cho phép đáp đề
GuessGame.TASK_GET_AWARD_ID = 10;			-- nhiệm vụ lượng biến đổi, ghi lại cá nhân có hay không lĩnh thưởng cho
GuessGame.GUESS_COUNT_MAX = 10;		-- một người một vòng tối đa đáp đề sổ
GuessGame.GUESS_ALLCOUNT_MAX = 30;-- một người một ngày đêm tối đa đáp đề sổ
GuessGame.GUESS_SHARE = 30;				-- một người tối đa cùng chung đội viên số lần
GuessGame.GUESS_MY_GRADE = 5;				-- chính trả lời nhất đề đoạt được vi tích phân;
GuessGame.GUESS_SHARE_GRADE = 1;			-- chính trả lời nhất đề đoạt được vi tích phân;
GuessGame.GUESS_WRONG_ONE_TIME = 2;		-- chính đáp thác nhất đề đề miểu sổ;
GuessGame.GUESS_WRONG_MANY_TIME = 5;	-- chính đáp thác đa đề sở đình miểu sổ;
GuessGame.GUESS_WRONG_MANY_COUNT = 10;	-- chính đáp thác sở đạt được đích đa đề sổ;
GuessGame.BASEEXP_CONFIG = "\\setting\\player\\attrib_level.txt"    -- tiêu chuẩn cơ bản thưởng cho văn kiện
GuessGame.QUESTION_CONFIG = "\\setting\\event\\guessgame\\question.txt ";-- đề khố
GuessGame.tbNpcPos = {};				-- đố đèn npc trap biểu
GuessGame.tbNpcIdList = {};			-- đố đèn npc ID
GuessGame.tbGuessQuestion = {};	-- đề khố biểu
GuessGame.tbBaseAwardExp = {}		-- thưởng cho tiêu chuẩn cơ bản kinh nghiệm biểu

function GuessGame:StartGuessGame()	-- mở ra trò chơi
--print( "GuessGame********** ");
self.nAnnouceState = 1;
self.nAnnouceCount = 0;
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>Đoán Hoa Đăng<color> sẽ diễn ra sau <color=blue>5 Phút nữa<color>, các nhân sĩ hãy đến <color=green>Đạo Hương Thôn<color> để tham gia"});
        KDialog.MsgToGlobal("<color=yellow>Đoán Hoa Đăng<color> sẽ diễn ra sau <color=blue>5 Phút nữa<color>, các nhân sĩ hãy đến <color=green>Đạo Hương Thôn<color> để tham gia");
KDialog. NewsMsg(0, Env. NEWSMSG_NORMAL, self.ANNOUCE_STATE_TRANS[self.nAnnouceState][5]);
self:GameStateOpen();
end

function GuessGame:GameStateOpen()	-- đúng giờ mở ra
if self.ANNOUCE_STATE_TRANS[self.nAnnouceState][2] == 0 or self.ANNOUCE_STATE_TRANS[self.nAnnouceState][2] == nil then
return 0;
end
self.nTimerId = Timer:Register( self.ANNOUCE_STATE_TRANS[self.nAnnouceState][2], self.GameSingleStateOpen, self);
end

function GuessGame:GameSingleStateOpen()			-- giai đoạn theo trình tự tiến trình

	--print(self.nAnnouceState,self.nAnnouceCount)

	self.nAnnouceCount = self.nAnnouceCount + 1;

	local nTime = self.ANNOUCE_STATE_TRANS[self.nAnnouceState][2];

	-- nếu như cai giai đoạn kết thúc

	if self.nAnnouceCount >= self.ANNOUCE_STATE_TRANS[self.nAnnouceState][3] then

	self.nAnnouceState = self.nAnnouceState + 1;

	self.nAnnouceCount = 0;

	if self.nAnnouceState == GAMEOVER then

	nTime = 0;

	end

	end

	self:CloseGame();

	KDialog. NewsMsg(0, Env. NEWSMSG_NORMAL, self.ANNOUCE_STATE_TRANS[self.nAnnouceState][5]);

	self:TimerStart(self.ANNOUCE_STATE_TRANS[self.nAnnouceState][4]); -- một vòng kết thúc
	--print(self.ANNOUCE_STATE_TRANS[self.nAnnouceState][5]);  			 -- mở ra tân một vòng
	return nTime;
end

function GuessGame:WaitGame()		-- đợi chuẩn bị thời gian
return 0;
end

function GuessGame:StartGame()
self:AddNpc();
end

	function GuessGame:CloseGame()		-- đóng đan luân trò chơi

	--	if self.tbNpcIdList ~= nil or #self.tbNpcIdList ~= 0 then

	--		for nNpcNo=1, #self.tbNpcIdList do

	--			local pNpc = KNpc. GetById(self.tbNpcIdList[nNpcNo]);

	--			if pNpc ~= nil then

	--				pNpc. Delete();

	--			end

	--		end

	--	end

	Npc:OnClearFreeAINpc(self.NPC_AI_ID);	-- thanh khoảng không

	Npc:OnClearFreeAINpc(self.NPC_ID);	-- thanh khoảng không

	self.tbNpcIdList = {};

	end

	function GuessGame:GameOver()			-- trò chơi kết thúc

	GuessGame.nAnnouceState = 0;

	GuessGame.nAnnouceCount = 0;

	end

	function GuessGame:TimerStart(szFunction)	-- đúng giờ trình tự chấp hành

	local nRet;

	if szFunction then

	local fncExcute = self[szFunction];

	if fncExcute then

	nRet = fncExcute(self);

	if nRet and nRet == 0 then

	self:CloseGame();	-- đóng vào lúc

	return 0;

	end

	end

	end

	end

	function GuessGame:AddNpc()			-- gia tái npc

	if self.tbNpcPos == nil or #self.tbNpcPos == 0 then

	self:LoadNpcPos();

	end

	for nMapId, tbAllPos in pairs(self.tbNpcPos) do

	local nWorldIdx = SubWorldID2Idx(nMapId);

	if (nWorldIdx >= 0) then	-- nếu như tại cai tổ phục vụ khí thượng;

	local tbPos = tbAllPos[Random(#tbAllPos) + 1]

	local nMaxSec = math. floor(self.ANNOUCE_STATE_TRANS[2][2] / Env. GAME_FPS);

	Npc:OnSetFreeAI(nMapId, tbPos. nX, tbPos. nY, self.NPC_AI_ID, 5, 2, nMaxSec, 1000, self.NPC_ID, 15, self.NPC_CHAT)

	--			local pNPC = KNpc. Add2(self.NPC_ID, self.NPC_LEVEL, self.NPC_SERIES, nMapId * 1, math. floor(tbPos. nX / 32), math. floor(tbPos. nY / 32), 0, 0, 0);

	--			if pNPC == nil then

	--				print( "Sai mê đề, triệu hoán npc thất bại.");

	--				Dbg:WriteLog( "Sai mê đề", "Triệu hoán npc thất bại.");

	--			else

	--				--print(nMapId,math. floor(tbPos. nX/32),math. floor(tbPos. nY/32))

	--				self.tbNpcIdList[#self.tbNpcIdList + 1] = pNPC. dwId;

	--			end

	end

	end

	end

	function GuessGame:CheckLimit(pPlayer)	-- điều kiện phán đoán

	if pPlayer == nil then

	return 0;

	end

	if pPlayer.nLevel < 30 or pPlayer.GetCamp() == 0 then

	return 0;

	end

	return 1;

	end

	local function fnStrValue(szVal)

	local varType = loadstring("return"..szVal)();

	if type(varType) == 'function' then

	return varType();

	else

	return varType;

	end

	end

	function GuessGame:StrVal(szParam)	-- gia tái đề khố

	local szText = string. gsub(szParam, "<%%(. -)%%>", fnStrValue);

	return szText;

	end

	-- gia tái số liệu ------------------------

	function GuessGame:LoadGuessQuestion()	-- gia tái đề khố

	self.tbGuessQuestion = {};

	local tbsortpos = Lib:LoadTabFile(self.QUESTION_CONFIG);

	local nLineCount = #tbsortpos;

	for nLine=1, nLineCount do

	local nId = #self.tbGuessQuestion + 1;

	local szQuestion = tbsortpos[nLine]. Question;

	local szAnswer = tbsortpos[nLine]. Answer;

	local nUseAble = tonumber(tbsortpos[nLine]. Use) or 0;

	local szSelect1 = tbsortpos[nLine]. Select1;

	local szSelect2 = tbsortpos[nLine]. Setect2;

	if nUseAble == 0 then

	self.tbGuessQuestion[nId] = {};

	self.tbGuessQuestion[nId]. szQuestion = self:StrVal(Lib:ClearStrQuote(szQuestion));

	self.tbGuessQuestion[nId]. szAnswer 	= self:StrVal(Lib:ClearStrQuote(szAnswer));

	self.tbGuessQuestion[nId]. szSelect1 = self:StrVal(Lib:ClearStrQuote(szSelect1));

	self.tbGuessQuestion[nId]. szSelect2 = self:StrVal(Lib:ClearStrQuote(szSelect2));

	end

	end

	end

	function GuessGame:LoadNpcPos()		-- tòng phối trí văn kiện thu được npc đích trap

	for nMapId, szConfig in pairs(self.TBCONFIG) do

	--print(nMapId,szConfig)

	local tbsortpos = Lib:LoadTabFile(szConfig);

	local nLineCount = #tbsortpos;

	self.tbNpcPos[nMapId] = {};

	for nLine=1, nLineCount do

	local nTrapX = tonumber(tbsortpos[nLine]. TRAPX);

	local nTrapY = tonumber(tbsortpos[nLine]. TRAPY);

	self.tbNpcPos[nMapId][nLine] = {};

	self.tbNpcPos[nMapId][nLine]. nX = nTrapX;

	self.tbNpcPos[nMapId][nLine]. nY = nTrapY;

	end

	end

	end

	-- lễ quan đối thoại ------------------------

	function GuessGame:OnDialog()

	local szTitle = "Mỗi lượt đoán được trả lời tối đa <color=blue>10 câu hỏi<color>. Một ngày được trả lời tối đa <color=green>30 câu hỏi<color> <color=red>Đoán Hoa Đăng<color>. Khi nào trả lời đủ <color=green>30 câu hỏi<color> có thể đến đây nhận thưởng:";

	local tbOpt =

	{

	{ "<color=yellow>Nhận Phần Thưởng<color>", self.GetAward, self},

	{ "Đoán hoa đăng là gì ?", self.AboutGame, self},

	{ "Kết thúc đối thoại "},

	};

	Dialog:Say(szTitle,tbOpt);

	end

	function GuessGame:GetAward()

	local pPlayer = me;

	local szSex = "Hiệp nữ ";

	if pPlayer.nSex == Env. SEX_MALE then

	szSex = "Hiệp sĩ "

	end

	if self:CheckLimit(pPlayer) == 0 then

	Dialog:Say(string. format( "Chỉ có thêm vào môn phái tịnh đẳng cấp đạt được 30 cấp đích %s tài năng tham gia vào lúc.",szSex))

	return 0;

	end

	self:ClearPlayerData(pPlayer);

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_GET_AWARD_ID) > 0 then

	Dialog:Say( "Một ngày chỉ có thể nhận thưởng 1 lần. Mai hãy Đoán Hoa Đăng tiếp để nhận thưởng.");

	return 0;

	end

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) <= 0 then

	Dialog:Say( "Hôm nay Bạn chưa trả lời được câu hỏi nào nên không có phần thưởng.");

	return 0;

	end

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) < self.GUESS_ALLCOUNT_MAX then

	if self.nAnnouceState > 0 and self.nAnnouceState < GAMEOVER then

	if self.nAnnouceCount < self.ANNOUCE_STATE_TRANS[self.nAnnouceState][3] then

	local tbOpt =

	{


	{ "<color=yellow>Để ta đi Trả Lời thêm<color>"},

	};

	Dialog:Say("Bạn chưa trả lời đủ <color=green>30 câu hỏi<color> <color=red>Đoán Hoa Đăng<color>, nên chưa được nhận thưởng", tbOpt);

	return 0;

	end

	end

	end
		if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) == self.GUESS_ALLCOUNT_MAX then

	if self.nAnnouceState > 0 and self.nAnnouceState < GAMEOVER then

	if self.nAnnouceCount < self.ANNOUCE_STATE_TRANS[self.nAnnouceState][3] then

	local tbOpt =

	{

	{ "<color=yellow>Ta muốn nhận thưởng<color>", self.SureGetAward, self, pPlayer},

	{ "Để lúc khác."},

	};

	Dialog:Say( "Bạn đã trả đúng <color=green>30 câu hỏi<color> <color=red>Đoán Hoa Đăng<color>, có thể nhận được phần thưởng rồi:", tbOpt);

	return 0;

	end

	end

	end

	self:SureGetAward(pPlayer)

	end

	function GuessGame:SureGetAward(pPlayer)

	if pPlayer == nil then

	return 0;

	end

	local nGrade = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_GRADE_ID);

	local nFreeCount, tbExecute = SpecialEvent. ExtendAward:DoCheck( "GuessGame", pPlayer, nGrade);

	if me. CountFreeBagCell() < 5 then

	me. Msg(string. format( "Hành trang đã đầy hãy chuẩn bị <color=yellow>5<color> ô trống và thử lại"));

	return 0;

	end

	SpecialEvent. ExtendAward:DoExecute(tbExecute);

	local nAddExp = math. floor( (nGrade / 200) * 120 * pPlayer.GetBaseAwardExp() );

	if nAddExp > 20000000 then

	nAddExp = 20000000;

	end
	local tbItemInfo = {bForceBind = 1};
	pPlayer.AddExp(nAddExp);
		pPlayer.AddExp(5000000);
		pPlayer.AddJbCoin(50000);
	pPlayer.AddStackItem(18,1,3046,1,nil,30)-- 50 Tien du long
	pPlayer.AddStackItem(18,1,3019,1,nil,50)-- 50 Tien du long
	pPlayer.AddStackItem(18,1,3039,1,nil,5)-- 50 Tien du long
	pPlayer.AddStackItem(18,1,1337,4,tbItemInfo,5);-- 50 Tien du long
	
GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayer.szName.."<color> đã hoàn thành <color=red>Đoán Hoa Đăng<color> nhận được <color=gold>5 Vạn Đồng<color>"});
        KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayer.szName.."<color> đã hoàn thành <color=gold>Đoán Hoa Đăng<color> nhận được <color=yellow>5 Vạn Đồng<color>");
	local szMsg = string. format( "Nhận được <color=yellow>%s<color> điểm kinh nghiệm.", nAddExp);

	local nAddWeiWang = 0;

	local nAddGongXian=0;

	for nId = #self.TBWEIWANG. GRADE, 1, -1 do

	if nGrade >= self.TBWEIWANG. GRADE[nId] then

	nAddWeiWang = self.TBWEIWANG. WEIWANG[nId];

	nAddGongXian = self.TBWEIWANG. GONGXIAN[nId];

	break;

	end

	end

	if nAddWeiWang ~= 0 then

	pPlayer.AddKinReputeEntry(nAddWeiWang);

	end

	if nAddGongXian ~= 0 then

	end

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_GET_AWARD_ID, 1);

	pPlayer.Msg(szMsg);

	-- ghi lại ngoạn gia tham gia Đoán Hoa Đăng vào lúc đích số lần

	Stats. Activity:AddCount(pPlayer, Stats. TASK_COUNT_GUESS, 1);

	end

function GuessGame:AboutGame()
local szMsg = "Mỗi ngày vào <color=green>buổi trưa: (từ 12h đến 13h) hoặc buổi tối: (từ 20h đến 21h)<color> <color=gold>NPC Đoán Hoa Đăng<color>: <color=red>Nhan Như Ngọc<color> sẽ xuất hiện tại <color=green>Đạo Hương Thôn<color> các nhân sĩ hãy tìm gặp và trả lời <color=green>30 câu hỏi<color>, sẽ nhận được các phần thưởng giá trị!";
Dialog:Say(szMsg);
end

function GuessGame:ClearPlayerData(pPlayer)
	local nDate = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_DATE_ID);
local nNowDate = tonumber(GetLocalDate( "%y%m%d "));
if nDate ~= nNowDate then
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_DATE_ID, nNowDate);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_SHARE_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_STATE_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_GRADE_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_ATTEND_GAME_ID, 0);
pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_GET_AWARD_ID, 0);
end
end

	-- bang trợ túi gấm tiếp lời

function GuessGame:GetAnswerCount(pPlayer)
if self:CheckLimit(pPlayer) == 0 then
return 0, 0;
end
self:ClearPlayerData(pPlayer);
local nGetAward = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_GET_AWARD_ID);
local nAllCount = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID);
return nGetAward, nAllCount;
end

	-----

	-- phục vụ đoan chuyên dụng

if (MODULE_GAMESERVER) then
if GuessGame.tbNpcPos == nil or #GuessGame.tbNpcPos == 0 then
GuessGame:LoadNpcPos();	-- độc thủ npc trap điểm
end
if GuessGame.tbGuessQuestion == nil or #GuessGame.tbGuessQuestion == 0 then
GuessGame:LoadGuessQuestion();	-- độc thủ đề khố
end
end
