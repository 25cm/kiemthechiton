
local uiNewsMsg = Ui:GetClass("newsmsg");
local tbTimer = Ui.tbLogic.tbTimer;

uiNewsMsg.NEWSMSG_CHECKTIME		= Env.GAME_FPS / 2;		-- �����ʾ�����Ƿ���Ҫ��ʾ����Ϣ��ʱ����
uiNewsMsg.NEWSMSG_SHOWTIME		= Env.GAME_FPS * 10;	-- ÿ����Ϣ����Ļ��ͣ����ʱ��
uiNewsMsg.NEWSMSG_INTERVAl 		= Env.GAME_FPS * 30;	-- ָ��ʱ����ʧ���͵���Ϣ,��ʱ��δ��,ÿ�������ʾһ��
uiNewsMsg.NEWSMSG_TEXT			= "Main";

function uiNewsMsg:Init()
	self.tbShowList				= { First = 0, Last = -1 };
	self.tbCountTimerId 		= {};
	self.tbEndTimerId			= {};
	self.bShowing				= 0;
	self.nShowTimerId			= 0;
	self.nTimerId				= 0;
end

function uiNewsMsg:OnOpen()
	self.nTimerId = tbTimer:Register(self.NEWSMSG_CHECKTIME, self.OnTimer, self);
end

function uiNewsMsg:OnTimer()
	self:OnShow();
end

function uiNewsMsg:OnClose()
	if self.nTimerId and (self.nTimerId ~= 0) then
		tbTimer:Close(self.nTimerId);
		self.nTimerId = 0;
	end
end

function uiNewsMsg:AddShowList(szText)
	local nLast = self.tbShowList.Last + 1;
	self.tbShowList.Last = nLast;
	self.tbShowList[nLast] = szText;
end

function uiNewsMsg:PopShowList()
	local nFirst = self.tbShowList.First;
	if nFirst > self.tbShowList.Last then
		return;
	end
	local szNews = self.tbShowList[nFirst];
	self.tbShowList[nFirst] = nil;
	self.tbShowList.First = nFirst + 1
	return szNews;
end

function uiNewsMsg:OnShow()
	if (self.bShowing ~=1) then
		local szNews = self:PopShowList();
		if not szNews then
			return;
		end
		self.bShowing = 1;
		Txt_SetTxt(self.UIGROUP, self.NEWSMSG_TEXT, szNews);
		Wnd_Show(self.UIGROUP, self.NEWSMSG_TEXT);
		self.nShowTimerId = tbTimer:Register(self.NEWSMSG_SHOWTIME, self.OnShowTimer, self);
	end
end

function uiNewsMsg:OnShowTimer()
	Wnd_Hide(self.UIGROUP, self.NEWSMSG_TEXT);
	if self.nShowTimerId and (self.nShowTimerId ~= 0) then
		tbTimer:Close(self.nShowTimerId);
	end
	self.nShowTimerId = 0;
	self.bShowing = 0;
end

function uiNewsMsg:OnAddMsg(nNewsType, szText, nTime)
	if nNewsType == Env.NEWSMSG_NORMAL then
		self:AddShowList(szText);
	elseif nNewsType == Env.NEWSMSG_COUNT then
		self:AddShowList(szText);
		if nTime ~= 0 then
			local nCountTime = GetTime() + nTime;
			local nIndex = #self.tbCountTimerId + 1;
			local nCountTimerId = tbTimer:Register(self.NEWSMSG_SHOWTIME, self.OnCountTimer, self, szText, nCountTime, nIndex);
			self.tbCountTimerId[nIndex] = nCountTimerId;
		end	
	elseif nNewsType == Env.NEWSMSG_TIMEEND then
		self:AddShowList(szText);
		local nIndex = #self.tbEndTimerId + 1;
		local nEndTimerId = tbTimer:Register(self.NEWSMSG_INTERVAl, self.OnEndTimeTimer, self, szText, nTime, nIndex);
		self.tbEndTimerId[nIndex] = nEndTimerId;
	end
end

function uiNewsMsg:OnCountTimer(szText, nCountTime, nIndex)
	if GetTime() < nCountTime then
		self:AddShowList(szText)
	else
		if self.tbCountTimerId[nIndex] and (self.tbCountTimerId[nIndex] ~= 0) then
			tbTimer:Close(self.tbCountTimerId[nIndex]);
		end
		self.tbCountTimerId[nIndex] = nil;
	end
end

function uiNewsMsg:OnEndTimeTimer(szText, nTime, nIndex)
	if GetTime() < nTime then
		self:AddShowList(szText)
	else
		if self.tbEndTimerId[nIndex] and (self.tbEndTimerId[nIndex] ~= 0) then
			tbTimer:Close(self.tbEndTimerId[nIndex]);
		end
		self.tbEndTimerId[nIndex] = nil;
	end
end

function uiNewsMsg:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_NEWS_MSG,		self.OnAddMsg },
	};
	return tbRegEvent;
end
