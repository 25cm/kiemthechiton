
local uiSkillBar = Ui:GetClass("skillbar");
local tbObject = Ui.tbLogic.tbObject;

uiSkillBar.OBJ_SKILL			= "ObjSkill";
uiSkillBar.DATA_KEY				= "ImmeSkill";
uiSkillBar.PROCESSANGER 		= "WndProgressAnger";

uiSkillBar.ANGERDIR		    	= "\\image\\ui\\001a\\main\\angerskill\\bg_main_full.spr";
uiSkillBar.UNANGERDIR			= "\\image\\ui\\001a\\main\\angerskill\\bg_main.spr";
uiSkillBar.ANGERPROGRESS		= "\\image\\ui\\001a\\main\\angerskill\\progress_full.spr";
uiSkillBar.UNANGERPROGRESS		= "\\image\\ui\\001a\\main\\angerskill\\progress.spr";

uiSkillBar.WEAPONSKILLIDLIMIT	= 10;
uiSkillBar.TASK_ID 				= 10;
uiSkillBar.TASK_GROUP			= 4;		-- 快捷栏任务变量组号

uiSkillBar.MAXANGER		    = 10000;
uiSkillBar.ANGERTIME		= 30;
uiSkillBar.FRAMETIME		= Env.GAME_FPS;

local tbCont = { bShowCd = 1, bUse = 0, bLink = 0, bSwitch = 0 };	-- 不允许链接操作

function uiSkillBar:OnCreate()
	self.tbCont = tbObject:RegisterContainer(self.UIGROUP, self.OBJ_SKILL, 2, 1, tbCont);
end

function uiSkillBar:OnDestroy()
	tbObject:UnregContainer(self.tbCont);
end
function uiSkillBar:OnOpen()
	self:Update();
	self:OnSetUnAngerProgress();
	self:OnSetAngerProgress();
	for i = 0, 1 do
		ObjGrid_ShowSubScript(self.UIGROUP, self.OBJ_SKILL, 1, i, 0);
	end
end


function uiSkillBar:OnSetUnAngerProgress()
	local nNowAnger, nTime = FightSkill:GetAngerState();
	Prg_SetPos(self.UIGROUP, self.PROCESSANGER, nNowAnger / self.MAXANGER * 1000);
end

function uiSkillBar:OnSetAngerProgress()
	local nNowAnger, nTime = FightSkill:GetAngerState();
	local nNowTime = GetTime();
	if (nTime > 0 and nNowTime >= nTime) then
		if (nNowTime - nTime < self.ANGERTIME) then
			local nAngerProgress = self.ANGERTIME - (nNowTime - nTime);
			Prg_SetTime(self.UIGROUP, self.PROCESSANGER, nAngerProgress * self.FRAMETIME / self.FRAMETIME * 1000, 1);
		else
			self:ResetAngerWindow();
		end
	else
		self:ResetAngerWindow();
	end
end

function uiSkillBar:ResetAngerWindow()
	Prg_Reset(self.UIGROUP, self.PROCESSANGER);
	self:OnSetUnAngerProgress();
end

function uiSkillBar:OnObjGridSwitch(szWnd, nX, nY)
	if self._disable_switch_skill then
		return;
	end
	if szWnd == self.OBJ_SKILL then
		if nX == 0 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "LEFT");
		elseif nX == 1 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "RIGHT");
		end
	end
end


local nLastErr;
local nLastMsgTime;
local nLastPopoTime;
function uiSkillBar:OnUseSkillFailed(nErr)
	local nMsgTimeSpan = 3; -- 红字消息3秒间隔
	local nPopoTimeSpan = 10; -- 弹出提示10秒间隔
	local tbMsg = 
	{
		
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_NONE] 			= "",
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_NOSKILL]			= "Không tồn tại kỹ năng này!",
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_NOHAVE]			= "Bạn chưa học kỹ năng này!",	
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_NOTARGET]		= "Phải có mục tiêu thi triển!",		-- 没有目标
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_NOMANA]			= "Nội lực không đủ!",		-- 没有蓝
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_FIGHTSTATEERR]	= "Trạng thái chiến đấu không chính xác!",		-- 战斗状态不对
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_FACTIONERR]		= "Không đúng phái, không thể sử dụng kỹ năng này!",		-- 门派不对
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_ROUTEERR]		= "Không đúng hướng, không thể sử dụng kỹ năng này!",		-- 路线不对
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_WEAPONERR]		= "Vũ khí đang trang bị không thích hợp!",		-- 武器不对
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_TARGERERR]		= "Mục tiêu không chính xác!",		-- 目标不对
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_DOMAINERR]		= "Biến thân không thể dùng kỹ năng chỉ định!",		-- 不是变身后拥有的技能
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_RIDESTATEERR]	= "Cưỡi ngựa không thể dùng kỹ năng này!",		-- 骑马状态不对
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_ANGERLIMIT]		= "Nộ mới có thể dùng kỹ năng này!",		-- 怒气技能限制
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_FORBITSKILL]		= "Trạng thái hiện tại không thể thi triển kỹ năng!",		-- 处于禁止释放技能
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_FORBITMOVE]		= "Kỹ năng này chỉ dùng khi di chuyển!",		-- 处于禁止移动
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_CDERR]			= "Kỹ năng đang trong thời gian chờ!",		-- CD时间未到
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_RADIUSERR]		= "Mục tiêu quá xa!",		-- 距离太远
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_NOSTEAL]			= "Mục tiêu không có kỹ năng hút!",		-- 没有可以偷取的技能，偷取失败
			[FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_PKVALUE]			= "Trị PK quá cao, không thể dùng kỹ năng",
	};

	if (nErr == FightSkill.USESKILL_FAILED.emFIGHTSKILL_USEFAILED_WEAPONERR) then
		if(tbMsg[nErr] and not (nLastErr == nErr and GetTime() - nLastMsgTime < nMsgTimeSpan )) then
			nLastMsgTime = GetTime();
			UiManager:OpenWindow("UI_INFOBOARD", tbMsg[nErr]);
		end
		if(tbMsg[nErr] and  not (nLastErr == nErr and GetTime() - nLastPopoTime < nPopoTimeSpan )) then
			nLastPopoTime = GetTime();
			PopoTip:ShowPopo(19, tbMsg[nErr]);
		end
	else
		if (tbMsg[nErr]) then
			me.Msg(tbMsg[nErr]);
		end;
	end;
	nLastErr = nErr;
end

function uiSkillBar:Update()
	self.tbCont:ClearObj();
	
	local tbLeftSkill    = {};
	tbLeftSkill.nType    = Ui.OBJ_FIGHTSKILL;
	tbLeftSkill.nSkillId = me.nLeftSkill;

	local tbRightSkill    = {};
	tbRightSkill.nType    = Ui.OBJ_FIGHTSKILL;
	tbRightSkill.nSkillId = me.nRightSkill;
	
	self.tbCont:SetObj(tbLeftSkill, 0, 0);
	self.tbCont:SetObj(tbRightSkill, 1, 0);

	ObjBox_Clear(self.UIGROUP, self.OBJ_LEFTSKILL or "Main");
	ObjBox_HoldObject(self.UIGROUP, self.OBJ_LEFTSKILL or "Main", Ui.CGOG_SKILL_SHORTCUT, me.nLeftSkill);
	ObjBox_Clear(self.UIGROUP, self.OBJ_RIGHTSKILL);
	ObjBox_HoldObject(self.UIGROUP, self.OBJ_RIGHTSKILL or "Main", Ui.CGOG_SKILL_SHORTCUT, me.nRightSkill);
	
	UiManager:CloseWindow("UI_SKILLTREE");
end

function uiSkillBar:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_FIGHT_SKILL_CHANGED,	self.Update },
		{ UiNotify.emCOREEVENT_ANGEREVENT,		self.OnSetAngerProgress },	
		{ UiNotify.emCOREEVENT_SETANGEREVENT, 	self.OnSetUnAngerProgress },
		{ UiNotify.emCOREEVENT_CHANGEACTIVEAURA, self.Update},
		{ UiNotify.emCOREEVENT_USESKLL_FAILED, self.OnUseSkillFailed},
	};
	return Lib:MergeTable(tbRegEvent, self.tbCont:RegisterEvent());
end

function uiSkillBar:RegisterMessage()
	local tbRegMsg = self.tbCont:RegisterMessage();
	return tbRegMsg;
end
