
local uiBaibaoxiang = Ui:GetClass("baibaoxiang");
local tbTimer = Ui.tbLogic.tbTimer;

uiBaibaoxiang.GRID_COUNT			= 22;

uiBaibaoxiang.BTN_START				= "BtnStart";
uiBaibaoxiang.BTN_CLOSE 		 	= "BtnClose";
uiBaibaoxiang.BTN_LINGJIANG			= "BtnLingjiang";
uiBaibaoxiang.BTN_LINGBI			= "BtnLingbi";

uiBaibaoxiang.BTN_TOUZHU = 
{
	[1] = {"BtnTouzhu1", 2},
	[2] = {"BtnTouzhu2", 10},
	[3] = {"BtnTouzhu3", 50},
};

uiBaibaoxiang.TXT_CAICHI			= "TxtCaichi";
uiBaibaoxiang.TXT_YINBI				= "TxtYinbi";
uiBaibaoxiang.TXT_YINBINUM			= "TxtYinbiNum";
uiBaibaoxiang.TXT_MIAOSHU			= "TxtMiaoshu";
uiBaibaoxiang.TXT_TOUZHU			= "TxtTouzhu";

uiBaibaoxiang.IMG_HIGHLIGHT 		= "ImgHighlight";
uiBaibaoxiang.IMG_FLASH				= "ImgFlash"

uiBaibaoxiang.IMG_GRID = 
{
	[1] = {"ImgGrid1", 2, 1, "ImgEffect1"},
	[2] = {"ImgGrid2", 3, 3, "ImgEffect2"},
	[3] = {"ImgGrid3", 3, 1, "ImgEffect3"},
	[4] = {"ImgGrid4", 5, 1, "ImgEffect4"},
	[5] = {"ImgGrid5", 2, 2, "ImgEffect5"},
	[6] = {"ImgGrid6", 3, 1, "ImgEffect6"},
	[7] = {"ImgGrid7", 1, 3, "ImgEffect7"},
	[8] = {"ImgGrid8", 1, 1, "ImgEffect8"},
	[9] = {"ImgGrid9", 4, 1, "ImgEffect9"},
	[10] = {"ImgGrid10", 2, 1, "ImgEffect10"},
	[11] = {"ImgGrid11", 3, 2, "ImgEffect11"},
	[12] = {"ImgGrid12", 1, 1, "ImgEffect12"},
	[13] = {"ImgGrid13", 4, 3, "ImgEffect13"},
	[14] = {"ImgGrid14", 4, 1, "ImgEffect14"},
	[15] = {"ImgGrid15", 5, 1, "ImgEffect15"},
	[16] = {"ImgGrid16", 1, 2, "ImgEffect16"},
	[17] = {"ImgGrid17", 4, 1, "ImgEffect17"},
	[18] = {"ImgGrid18", 2, 3, "ImgEffect18"},
	[19] = {"ImgGrid19", 2, 1, "ImgEffect19"},
	[20] = {"ImgGrid20", 3, 1, "ImgEffect20"},
	[21] = {"ImgGrid21", 1, 1, "ImgEffect21"},
	[22] = {"ImgGrid22", 4, 2, "ImgEffect22"},
};

uiBaibaoxiang.IMG_AWARD_LEVEL = 
{
	[1] = {"ImgLevel1", "TxtLevel1"},
	[2] = {"ImgLevel2", "TxtLevel2"},
	[3] = {"ImgLevel3", "TxtLevel3"},
	[4] = {"ImgLevel4", "TxtLevel4"},
	[5] = {"ImgLevel5", "TxtLevel5"},
	[6] = {"ImgLevel6", "TxtLevel6"},
};

uiBaibaoxiang.SPR_EFFECT = "\\image\\ui\\001a\\baibaoxiang\\img_effect.spr"
uiBaibaoxiang.SPR_RUN = "\\image\\ui\\001a\\baibaoxiang\\img_run.spr"
uiBaibaoxiang.SPR_START = "\\image\\ui\\001a\\baibaoxiang\\btn_start"..UiManager.IVER_szVnSpr;
uiBaibaoxiang.SPR_CONTINUE = "\\image\\ui\\001a\\baibaoxiang\\btn_continue"..UiManager.IVER_szVnSpr;
uiBaibaoxiang.SPR_LEVELSTAR = 
{
	[1] = "\\image\\ui\\001a\\baibaoxiang\\img_star_1.spr",
	[2] = "\\image\\ui\\001a\\baibaoxiang\\img_star_2.spr",
	[3] = "\\image\\ui\\001a\\baibaoxiang\\img_star_3.spr",
	[4] = "\\image\\ui\\001a\\baibaoxiang\\img_star_4.spr",
	[5] = "\\image\\ui\\001a\\baibaoxiang\\img_star_5.spr",
	[6] = "\\image\\ui\\001a\\baibaoxiang\\img_star_6.spr",
};

uiBaibaoxiang.tbAward = 
{
	[1] = {"Huyền Tinh", {6, 7, 8, 9, 10, 11}},
	[2] = {"Tinh hoạt", {1000, 3000, 6000, 9000, 12000, 15000}},
	[3] = {"Bạc", {10000, 30000, 60000, 90000, 120000, 150000}},
	[4] = {"Đồng khóa", {500, 1500, 3000, 6000, 9000, 12000}},
	[5] = {"Bảo rương", {1}},
	[6] = {"Vỏ sò", {1, 3, 4, 5, 6, 7}},
};


function uiBaibaoxiang:Init()
	
	self.nTimeMoveID 		= 0;
	self.nTimerDelayID 		= 0;
	self.nTimerResetID		= 0;
	self.nTimerUpdateID		= 0;
		
	self.nTimerStep			= 1;
	self.nSlowStep 			= 1;
	self.nMaxSlowStep 		= 1;
	
	self.tbSlowTime			= {};
	
	self.nLevel 			= 0;
	self.nTimes 			= 0;
	self.nType 				= 0;
	self.nTouzhu 			= 0;
	self.nResult 			= 0;
	self.nOverflow 			= 0;
	self.nContinue 			= 0;
	
	self.nCurrGrid 			= 1;
	self.nEndGrid 			= 1;
	self.nRandGrid 			= 0;
	
	self.nLastType 			= 0;		
	self.nLastLevel 		= 0;
	self.nLastTimes 		= 0;
		
	self.bOpen 				= 0;	-- window open
	self.nFlashTimes		= 0;	-- flash count
end

function uiBaibaoxiang:CheckRecover()
	
	local nTimes = me.GetTask(2086, 2);
	
	if nTimes > 0 then
		return 1;
	end
	
	return 0;
end

function uiBaibaoxiang:Recover()
	
	self.nLevel 	= me.GetTask(2086, 1);
	self.nTimes 	= me.GetTask(2086, 2);
	self.nType 		= me.GetTask(2086, 3);
	self.nTouzhu 	= me.GetTask(2086, 4);
	self.nResult 	= me.GetTask(2086, 5);
	self.nOverflow 	= me.GetTask(2086, 6);
	self.nContinue 	= me.GetTask(2086, 7);
	
	self.nLastType, self.nLastLevel, self.nRandGrid = Baibaoxiang:GetRoundResult(me, self.nTimes);
	self.nEndGrid = self:FindGridByResult(self.nLastType, self.nLastLevel, self.nRandGrid);
	
	self.nCurrGrid = self.nEndGrid;
	self.nLastTimes = self.nTimes;
	
	if self.nTouzhu > 0 then
		self:CheckTouzhu(self.nTouzhu);
		self:State_Touzhu();
	end
	
	self:State_GetResult(self.nTimes)
end

function uiBaibaoxiang:OnOpen()

	self.bOpen = 1;
	
	if self:CheckRecover() == 1 then 
		self:Recover();
	else
		self:State_Begin();
	end
	
	self.nTimerUpdateID = tbTimer:Register(10, self.OnTimerUpdate, self);
end

function uiBaibaoxiang:OnClose()
	
	if self.nTimeMoveID > 0 then
		tbTimer:Close(self.nTimeMoveID);
		self.nTimeMoveID = 0;
	end
	
	if self.nTimerDelayID > 0 then
		tbTimer:Close(self.nTimerDelayID);
		self.nTimerDelayID = 0;
	end
	
	if self.nTimerResetID > 0 then
		tbTimer:Close(self.nTimerResetID);
		self.nTimerResetID = 0;
	end
	
	if self.nTimerUpdateID > 0 then
		tbTimer:Close(self.nTimerUpdateID);
		self.nTimerUpdateID = 0;
	end
end

function uiBaibaoxiang:OnTimerUpdate()
	
	local nCoin = me.GetItemCountInBags(18, 1, 325, 1);
	
	Txt_SetTxt(self.UIGROUP, self.TXT_YINBINUM, nCoin);
	
	local nCaichi = KGblTask.SCGetDbTaskInt(DBTASK_BAIBAOXIANG_CAICHI) / 1;
	local szTxt = string.format("Tổng tích lũy ở server: %d vỏ sò", tonumber(nCaichi));
	
	Txt_SetTxt(self.UIGROUP, self.TXT_CAICHI, szTxt);	
	
	return 10;
end

function uiBaibaoxiang:DisableAllButton()
	
	local i;
	
	for i = 1, 3 do 
		Wnd_SetEnable(self.UIGROUP, self.BTN_TOUZHU[i][1], 0);
	end
	
	Wnd_SetEnable(self.UIGROUP, self.BTN_START, 0);
	Wnd_SetEnable(self.UIGROUP, self.BTN_LINGJIANG, 0);
	Wnd_SetEnable(self.UIGROUP, self.BTN_LINGBI, 0);
end

function uiBaibaoxiang:InvisibleEffect()
	
	local i;
	
	for i = 1, self.GRID_COUNT do 
		Wnd_SetVisible(self.UIGROUP, self.IMG_GRID[i][4], 0);
		Img_PlayAnimation(self.UIGROUP, self.IMG_GRID[self.nEndGrid][4], 1);	
	end
end

function uiBaibaoxiang:OnButtonClick(szWnd, nParam)
	
	if (self.BTN_CLOSE == szWnd) then
		UiManager:CloseWindow(self.UIGROUP);
	
	elseif (self.BTN_START == szWnd) then
		if self.nTouzhu > 0 then
			me.CallServerScript({"ApplyBaibaoxiangGetResult", self.nTouzhu});	
			self:State_WaitResult();
		end
		
	elseif (self.BTN_LINGJIANG == szWnd) then
		me.CallServerScript({"ApplyBaibaoxiangGetAward", 1});
		
	elseif (self.BTN_LINGBI == szWnd) then
		me.CallServerScript({"ApplyBaibaoxiangGetAward", 2});
	
	else
		local i;
		for i = 1, 3 do
			
			if (self.BTN_TOUZHU[i][1] == szWnd) then
				
				local nCoin = me.GetItemCountInBags(18, 1, 325, 1);
				
				if self.BTN_TOUZHU[i][2] <= nCoin then
					self.nTouzhu = self.BTN_TOUZHU[i][2];
					self:CheckTouzhu(self.nTouzhu);
					self:State_Touzhu();
				else
					Btn_Check(self.UIGROUP, self.BTN_TOUZHU[i][1], 0);
				end
			end
		end
	end
end

function uiBaibaoxiang:CheckTouzhu(nTouzhu)
	
	local i;
	
	for i = 1, 3 do 
		if nTouzhu == self.BTN_TOUZHU[i][2] then
			Btn_Check(self.UIGROUP, self.BTN_TOUZHU[i][1], 1);
		else
			Btn_Check(self.UIGROUP, self.BTN_TOUZHU[i][1], 0);
		end
	end
end

function uiBaibaoxiang:FindGridByResult(nType, nLevel, nRandGrid)
	
	local i;
	local tbResult = {};
	
	for i = 1, self.GRID_COUNT do 
		if self.IMG_GRID[i][2] == nType then
			if self.IMG_GRID[i][3] == nLevel then
				table.insert(tbResult, i);
			end
		end
	end
	
	if #tbResult == 0 then
		return 1;
	end	
	
	if #tbResult > 1 and nRandGrid > 0 then
		if nRandGrid >= 1 and nRandGrid <= #tbResult then
			return tbResult[nRandGrid];
		else
			return tbResult[1];
		end
	else
		return tbResult[1];
	end
end

function uiBaibaoxiang:FindGridByType(nType, nGrid)
	
	local i;
	local tbResult = {};
	
	for i = 1, self.GRID_COUNT do 
		if self.IMG_GRID[i][2] == nType and i ~= nGrid then
			table.insert(tbResult, i);
		end
	end
	
	return tbResult;
end

function uiBaibaoxiang:CacMoveGrid(nBeginGrid, nEndGrid)
	
	local tbSlowTime  =
	{
		[2] = 32,	-- 16
		[3] = 24,	-- 8
		[4] = 16,	-- 4
		[5] = 10, 	-- 2
	};
	
	local nMoveGrid = nEndGrid - nBeginGrid + self.GRID_COUNT * 3 - 30;

	tbSlowTime[1] = nMoveGrid;
	self.nFixPos = math.fmod(nMoveGrid + nBeginGrid, self.GRID_COUNT);
	self.nMaxSlowStep = #tbSlowTime;
	
	return tbSlowTime;
end

function uiBaibaoxiang:SetFrameGrid(nGrid)
	
	local i;
	for i = 1, self.GRID_COUNT do
		if nGrid == i then
			Img_SetFrame(self.UIGROUP, self.IMG_GRID[i][1], 1);
		else
			Img_SetFrame(self.UIGROUP, self.IMG_GRID[i][1], 2);
		end
	end
end

function uiBaibaoxiang:OnTimerMove()

	if self.nCurrGrid > 0 then
		Wnd_SetVisible(self.UIGROUP, self.IMG_GRID[self.nCurrGrid][4], 1);
		Img_SetImage(self.UIGROUP, self.IMG_GRID[self.nCurrGrid][4], 1, self.SPR_RUN);
		Img_PlayAnimation(self.UIGROUP, self.IMG_GRID[self.nCurrGrid][4]);
	end
	
	self.nCurrGrid = self.nCurrGrid + 1;
	
	if self.nCurrGrid > self.GRID_COUNT then
		self.nCurrGrid = self.nCurrGrid - self.GRID_COUNT;
	end
	
	return self.nTimerStep;
end

function uiBaibaoxiang:OnTimerDelay()
	
	self.nSlowStep	= self.nSlowStep + 1;
	
	if (self.nSlowStep <= self.nMaxSlowStep) then
		if (self.tbSlowTime[self.nSlowStep]) then
			if (self.nSlowStep - 1 == 1) then
				self.nCurrGrid = self.nFixPos;
			end
			self.nTimerStep = self.nTimerStep + 1;	
			return self.tbSlowTime[self.nSlowStep];
		end
	end
	
	tbTimer:Close(self.nTimeMoveID);
	tbTimer:Close(self.nTimerDelayID);

	self.nTimeMoveID 		= 0;
	self.nTimerDelayID 		= 0;
	self.nTimerStep			= 1;
	self.nSlowStep 			= 1;
	self.nMaxSlowStep 		= 1;
	self.tbSlowTime			= {};
	
	self:State_GetResult(self.nLastTimes);
end

function uiBaibaoxiang:OnTimerReset()
	tbTimer:Close(self.nTimerResetID);
	self.nTimerResetID = 0;
	self:State_Begin();
end
	
function uiBaibaoxiang:OnRecvResult(tbResult)
	
	if not tbResult then 
		return;
	end
	
	self.nLastType = tbResult.Type;
	self.nLastLevel = tbResult.Level;
	self.nLastTimes = tbResult.Times;
	self.nRandGrid = tbResult.Grid;
	
	self.nEndGrid = self:FindGridByResult(self.nLastType, self.nLastLevel, self.nRandGrid);
	self.tbSlowTime = self:CacMoveGrid(self.nCurrGrid, self.nEndGrid);

	if self.bOpen == 1 then
		self.nTimerDelayID = tbTimer:Register(self.tbSlowTime[1], self.OnTimerDelay, self);
	else
		self:State_GetResult(self.nLastTimes);
	end
end

function uiBaibaoxiang:OnReset()
	self:State_GetAward();
end

function uiBaibaoxiang:State_Begin()

	Img_SetImage(self.UIGROUP, self.BTN_START, 1, self.SPR_START);
		
	local i;
	
	for i = 1, 6 do 
		Wnd_SetVisible(self.UIGROUP, self.IMG_AWARD_LEVEL[i][1], 0);
		Txt_SetTxt(self.UIGROUP, self.IMG_AWARD_LEVEL[i][2], "");
		Wnd_SetVisible(self.UIGROUP, self.IMG_HIGHLIGHT, 0);
	end
	
	for i = 1, self.GRID_COUNT do
		Img_SetFrame(self.UIGROUP, self.IMG_GRID[i][1], 0);
	end
	
	self:DisableAllButton();
	
	self:InvisibleEffect();
	
	for i = 1, 3 do
		Wnd_SetEnable(self.UIGROUP, self.BTN_TOUZHU[i][1], 1);
	end
	
	Txt_SetTxt(self.UIGROUP, self.TXT_MIAOSHU, "Chọn số tiền muốn cược!");
	
	local nCoin = me.GetItemCountInBags(18, 1, 325, 1);
	
	if self.nTouzhu > 0 and self.nTouzhu <= nCoin then
		self:CheckTouzhu(self.nTouzhu);
		self:State_Touzhu();
	else
		self:CheckTouzhu(0);
	end
end

function uiBaibaoxiang:State_Touzhu()
	
	local i;
	
	for i = 1, self.GRID_COUNT do
		Img_SetFrame(self.UIGROUP, self.IMG_GRID[i][1], 2);
	end
	
	self:DisableAllButton();
	
	self:InvisibleEffect();
	
	for i = 1, 3 do
		Wnd_SetEnable(self.UIGROUP, self.BTN_TOUZHU[i][1], 1);
	end
	
	Wnd_SetEnable(self.UIGROUP, self.BTN_START, 1);
	
	local szTouzhu = string.format("Đã cược: %d vỏ sò", self.nTouzhu);
	Txt_SetTxt(self.UIGROUP, self.TXT_TOUZHU, szTouzhu);
	
	local szMiaoshu = string.format("Đã cược %d vỏ sò, nhấn nút để bắt đầu!", self.nTouzhu);
	Txt_SetTxt(self.UIGROUP, self.TXT_MIAOSHU, szMiaoshu);
end

function uiBaibaoxiang:State_WaitResult()
	
	self:DisableAllButton();
	
	self:InvisibleEffect();
	
	self.nTimeMoveID = tbTimer:Register(1, self.OnTimerMove, self);
end

function uiBaibaoxiang:State_GetResult(nTimes)
	
	self:DisableAllButton();
	
	self:InvisibleEffect();
	
	Wnd_SetEnable(self.UIGROUP, self.BTN_LINGJIANG, 1);
	Wnd_SetEnable(self.UIGROUP, self.BTN_LINGBI, 1);
	
	Wnd_SetEnable(self.UIGROUP, self.BTN_START, 1);
	Img_SetImage(self.UIGROUP, self.BTN_START, 1, self.SPR_CONTINUE);
	
	self:SetFrameGrid(self.nEndGrid);
	
	Wnd_SetVisible(self.UIGROUP, self.IMG_GRID[self.nEndGrid][4], 1);
	Img_PlayAnimation(self.UIGROUP, self.IMG_GRID[self.nEndGrid][4], 1);
	
	local nLevel = me.GetTask(2086, 1);
	local bContinue = me.GetTask(2086, 7);
	
	if nTimes == 1 then
		self:State_FirstResult(bContinue);
	elseif nTimes > 1 then
		if bContinue == 1 then
			self:State_SameResult(1);
		elseif bContinue == 0 then
			if nLevel == 6 then
				self:State_SameResult(0);
			else
				self:State_DifferResult(1);
			end
		end
	end
end

function uiBaibaoxiang:State_FirstResult(bContinue)
	
	local tbGrid = self:FindGridByType(self.nLastType, self.nEndGrid);
	
	if #tbGrid <= 0 then
		return;
	end
	
	local i;
	
	for i = 1, #tbGrid do
		Img_SetFrame(self.UIGROUP, self.IMG_GRID[tbGrid[i]][1], 0);
	end
	
	if bContinue == 0 then
		Wnd_SetEnable(self.UIGROUP, self.BTN_START, 0);
		Wnd_SetEnable(self.UIGROUP, self.BTN_LINGBI, 0);
	end

	self:UpdateAward(1);	
end

function uiBaibaoxiang:UpdateAward(nTimes)
	
	local i;
	
	local nTotalLevel = me.GetTask(2086, 1);
	local nFinalType = me.GetTask(2086, 3);
	
	if nFinalType == 5 then
					
		local nNum = self.tbAward[nFinalType][2][1];
		local nMultiple = self.nTouzhu / 2;
		
		local szAward = "Bảo rương" .. nNum .. ", ";

		szAward = Lib:StrFillL(szAward, 12);
		Txt_SetTxt(self.UIGROUP, self.IMG_AWARD_LEVEL[1][2], szAward .. "*" .. nMultiple);	
		Wnd_SetVisible(self.UIGROUP, self.IMG_AWARD_LEVEL[1][1], 1);
	
	else	
		for i = 1, 6 do
					
			local nNum = self.tbAward[nFinalType][2][i];
			local nMultiple = self.nTouzhu / 2;
			
			local szAward;
				
			if nFinalType == 1 then
				szAward = "Huyền Tinh " .. nNum;
			elseif nFinalType == 2 then
				szAward = nNum .. " điểm Tinh hoạt";
			elseif nFinalType == 3 then
				szAward = nNum .. " Bạc";
			elseif nFinalType == 4 then
				szAward = nNum .. " Đồng khóa";
			elseif nFinalType == 5 then
				szAward = nNum .. " Bảo rương";
			end	
			
			szAward = Lib:StrFillL(szAward, 12);
			Txt_SetTxt(self.UIGROUP, self.IMG_AWARD_LEVEL[i][2], szAward.."*"..nMultiple);
			Wnd_SetVisible(self.UIGROUP, self.IMG_AWARD_LEVEL[i][1], 1);
		end
	end
	
	Wnd_SetVisible(self.UIGROUP, self.IMG_HIGHLIGHT, 1);
	Wnd_SetPos(self.UIGROUP, self.IMG_HIGHLIGHT, 131 , 197 + 25 * (nTotalLevel - 1));

	local nNum = self.tbAward[nFinalType][2][nTotalLevel];
	local nTotalNum = nNum * self.nTouzhu / 2;
	local nCoin = self.tbAward[6][2][nTotalLevel] * self.nTouzhu / 2;
	local szCoin = nCoin .." Vỏ sò".."";
	local szMiaoshu;
	
	if nFinalType == 1 then
		szMiaoshu = (self.nTouzhu / 2) .. " Huyền Tinh " .. nNum;
	elseif nFinalType == 2 then
		szMiaoshu = nTotalNum .. " điểm Tinh hoạt";
	elseif nFinalType == 3 then
		szMiaoshu = nTotalNum .. " Bạc";
	elseif nFinalType == 4 then
		szMiaoshu = nTotalNum .. " Đồng khóa";
	elseif nFinalType == 5 then
		szMiaoshu =  nTotalNum .. " Bảo rương";
	end	

	if nFinalType == 5 then
		szMiaoshu = string.format("Chúc mừng nhận được <color=green>%s<color>", szMiaoshu);
	else 
		szMiaoshu = string.format("Chúc mừng nhận được<color=green>\n%s<color> hoặc <color=green>%s<color>", szMiaoshu, szCoin);
	end
	
	Txt_SetTxt(self.UIGROUP, self.TXT_MIAOSHU, szMiaoshu);	
end

function uiBaibaoxiang:State_SameResult(nFlag)
	
	local tbGrid = self:FindGridByType(self.nLastType, self.nEndGrid);
	
	if #tbGrid <= 0 then
		return;
	end
	
	local i;
	
	for i = 1, #tbGrid do
		Img_SetFrame(self.UIGROUP, self.IMG_GRID[tbGrid[i]][1], 0);
	end
	
	if nFlag == 0 then
		Wnd_SetEnable(self.UIGROUP, self.BTN_START, 0);
		Wnd_SetEnable(self.UIGROUP, self.BTN_LINGBI, 1);
	end
	
	Wnd_SetVisible(self.UIGROUP, self.IMG_FLASH, 1);
	Img_PlayAnimation(self.UIGROUP, self.IMG_FLASH);
	
	self:UpdateAward(nTimes);	
end

function uiBaibaoxiang:State_DifferResult(nFlag)
	
	self:DisableAllButton();
	
	for i = 1, 6 do 
		Wnd_SetVisible(self.UIGROUP, self.IMG_AWARD_LEVEL[i][1], 0);
		Txt_SetTxt(self.UIGROUP, self.IMG_AWARD_LEVEL[i][2], "");
		Wnd_SetVisible(self.UIGROUP, self.IMG_HIGHLIGHT, 0);
	end
	
	local szMiaoshu = "Thiếu chút may mắn! Hãy thử lại lần nữa!";
	Txt_SetTxt(self.UIGROUP, self.TXT_MIAOSHU, szMiaoshu);	
	
	self.nTimerResetID = tbTimer:Register(50, self.OnTimerReset, self);
end

function uiBaibaoxiang:State_GetAward()
	
	self:DisableAllButton();
	
	self:InvisibleEffect();
	
	self.nTimerResetID = tbTimer:Register(50, self.OnTimerReset, self);
end

function uiBaibaoxiang:OnAnimationOver(szWnd)
	
	if szWnd == self.IMG_FLASH then
		self.nFlashTimes = self.nFlashTimes + 1; 
		
		if self.nFlashTimes > 5 then
			self.nFlashTimes = 0;
			Wnd_SetVisible(self.UIGROUP, self.IMG_FLASH, 0);
		else
			Img_PlayAnimation(self.UIGROUP, self.IMG_FLASH);
		end
	else
		local i;
		for i = 1, self.GRID_COUNT do
			if szWnd == self.IMG_GRID[i][4] then
				Wnd_SetVisible(self.UIGROUP, self.IMG_GRID[i][4], 0);
				Img_SetImage(self.UIGROUP, self.IMG_GRID[i][4], 1, self.SPR_EFFECT);
			end
		end
	end	 
end
