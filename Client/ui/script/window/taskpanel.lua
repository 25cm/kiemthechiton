




local uiTaskPanel 	= Ui:GetClass("taskpanel");
local tbObject 		= Ui.tbLogic.tbObject;
local tbTempData	= Ui.tbLogic.tbTempData;
local tbAwardInfo 	= Ui.tbLogic.tbAwardInfo;

uiTaskPanel.WND_TASK_INFO		= "ScrollTaskInfo";
uiTaskPanel.WND_TASK_DESC		= "ScrollTaskDesc";
uiTaskPanel.TXT_TASK_NUM 		= "TxtTaskNum";				-- 任务的总数量
uiTaskPanel.OUTLOOK_TASK_LIST	= "OutLookTask";			-- OUTLOOK 控件的 TaskList
uiTaskPanel.TXT_TASK_TEXT 		= "TaskText";				-- 任务的文字描述
uiTaskPanel.TXT_TASK_DESC		= "TaskDesc";				-- 任务的详细步骤描述
uiTaskPanel.BTN_TASK_INFO		= "BtnTaskInfo";
uiTaskPanel.BTN_TASK_DESC		= "BtnTaskDesc";
uiTaskPanel.BTN_SHARE_TASK		= "BtnShareTask";
uiTaskPanel.BTN_GIVEUP_TASK		= "BtnGiveupTask";
uiTaskPanel.BTN_TRACK_TASK		= "BtnTrackTask";
uiTaskPanel.BTN_CLOSE			= "BtnClose";

uiTaskPanel.WND_FIX_AWARD	=
{
	"WndFixAward",
	{ "ObjFix1", 	"ObjFix2", 		"ObjFix3", 		"ObjFix4",		"ObjFix5" 		},
	{ "ImgFix1Bg", 	"ImgFix2Bg", 	"ImgFix3Bg", 	"ImgFix4Bg", 	"ImgFix5Bg"		}
};

uiTaskPanel.WND_OPTIONAL_AWARD	=
{
	"WndOptionalAward",
	{ "ObjOptional1", 	"ObjOptional2", 	"ObjOptional3", 	"ObjOptional4",		"ObjOptional5" 	 },
	{ "ImgOptional1Bg", "ImgOptional2Bg", 	"ImgOptional3Bg",	"ImgOptional4Bg",	"ImgOptional5Bg" },
};

uiTaskPanel.MAP_INFO_NEW	= -1; -- 表示地图需要自行回到新手村才开始寻
uiTaskPanel.MAP_INFO_CITY	= -2; -- 表示地图需要自行回到城市才开始寻
uiTaskPanel.MAP_INFO_FACTION= -3; -- 表示地图需要自行回到门派才开始寻

function uiTaskPanel:OnCreate()
	self.tbFixCont = {};
	self.tbOptionalCont = {};
	for i, tbAward in ipairs(self.WND_FIX_AWARD[2]) do
		self.tbFixCont[i] = tbObject:RegisterContainer(self.UIGROUP, tbAward, 4, 2, nil, "award");
	end
	for i, tbAward in ipairs(self.WND_OPTIONAL_AWARD[2]) do
		self.tbOptionalCont[i] = tbObject:RegisterContainer(self.UIGROUP, tbAward, 4, 2, nil, "award");
	end
end

function uiTaskPanel:OnDestroy()
	for _, tbCont in ipairs(self.tbFixCont) do
		tbObject:UnregContainer(tbCont);
	end
	for _, tbCont in ipairs(self.tbOptionalCont) do
		tbObject:UnregContainer(tbCont);
	end
end

function uiTaskPanel:Init()
	self.m_tbTaskIdMap	= { [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {} };
	self.tbAwardInfo	= {}; 	-- 显示物品 Tips 所专用的 table
	self.nInitDone		= 0;	-- 判断界面是否已经初始化完毕，包括控件，如果 OUTLOOK 控件没有初始化，则不能做任何东西
end

function uiTaskPanel:WriteStatLog()
	Log:Ui_SendLog("Giao diện nhiệm vụ F4", 1);
end

function uiTaskPanel:OnOpen()
	self:WriteStatLog();
	Ui(Ui.UI_SIDEBAR):WndOpenCloseCallback(self.UIGROUP, 1);

	self:EmptyTaskInfo();
	self:InitData();
	self:ShowTotalTaskNum();

	Wnd_Show(self.UIGROUP, self.WND_TASK_INFO);
	Wnd_Hide(self.UIGROUP, self.WND_TASK_DESC);

	if self:HaveThisTask(tbTempData.nSelectTaskId) and (tbTempData.nSelectTaskId > 0) then
		local nGroupIdx, nItemIdx = self:GetItemLocalByTask(tbTempData.nSelectTaskId);
		OutLookPanelSelItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, nGroupIdx, nItemIdx);
		self:SelectTask(tbTempData.nSelectTaskId);
		return;
	end

	
	local nSelIdx = 0;
	for i = 1, 5 do
		if (GetOutLookGroupItemCount(self.UIGROUP, self.OUTLOOK_TASK_LIST, i) ~= 0) then
			nSelIdx = i;
			break;
		end
	end
	OutLookPanelSelItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, nSelIdx, 0);
end

function uiTaskPanel:OnClose()
	Ui(Ui.UI_SIDEBAR):WndOpenCloseCallback(self.UIGROUP, 0);
end

function uiTaskPanel:UpdateTaskList()
	OutLookPanelClearAll(self.UIGROUP, self.OUTLOOK_TASK_LIST);
	AddOutLookPanelColumnHeader(self.UIGROUP, self.OUTLOOK_TASK_LIST,"");
	SetOutLookHeaderWidth(self.UIGROUP, self.OUTLOOK_TASK_LIST, 0, 20);
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Hướng dẫn");
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Quân doanh");
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Chính tuyến");
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Thế giới");
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Giang hồ");
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Ngẫu nhiên");
	AddOutLookGroup(self.UIGROUP, self.OUTLOOK_TASK_LIST, "Truyền thuyết");
end

function uiTaskPanel:OnOutLookItemSelected(szWndName, nGroupIndex, nItemIndex)
	if (nGroupIndex == 0) then
		self:EmptyTaskInfo();
		
		local szInfo = "";
		if (me.nLevel >= 90) then
			szInfo = szInfo.."<color=Gold>Cách nhận danh vọng quân doanh: <color=White>\nĐọc binh pháp, tham gia chính tuyến phó bản	.\n<color=Gold>Cách nhận Cơ Quan Học Tạo Đồ và độ bền cơ quan: <color=White>\nĐọc Cơ quan thư, tham gia phó bản hằng ngày.\n\n<color=White>";
			
	    
			local tbCampList = Task:GetMaxLevelCampTaskInfo(me);
			if (tbCampList and #tbCampList > 0) then
				szInfo = szInfo.."<color=Gold>Hiện có thể nhận nhiệm vụ quân doanh:<color=White>\n";
			end
			
			for _, tbInfo in ipairs(tbCampList) do
				szInfo = szInfo.."<color=yellow>"..tbInfo[2].."<color=White>\n";
				szInfo = szInfo..tbInfo[3].."\n";
			end
		  szInfo = szInfo.."\n";
		end
		
		local tbRangeDesc = Task:GetLevelRangeDesc(me);
		if tbRangeDesc then
			  szInfo = szInfo.."<color=Gold>Miêu tả cấp đoạn: <color=White>\n";
			  szInfo = szInfo..tbRangeDesc;
			  szInfo = szInfo.."\n\n";
	  end
		
		local tbInfoList = Task:GetMinLevelMainTaskInfo(me);
		if (tbInfoList and #tbInfoList > 0) then
			szInfo = szInfo.."<color=Gold>Hiện có thể nhận nhiệm vụ chính tuyến:<color=White>\n";
			
		  for _, tbInfo in ipairs(tbInfoList) do
		  	if (tbInfo) then
			  	szInfo = szInfo.."<color=yellow>"..tbInfo[2].."<color=White>\n";
			  	szInfo = szInfo..tbInfo[3].."\n";
		  	end
		  end
		szInfo = szInfo.."\n";
		
		end
		
		local tbTaskListInfo =  Task:GetBranchTaskTable(me);
		if (tbTaskListInfo and #tbTaskListInfo > 0) then
			szInfo = szInfo.."<color=Gold>Hiện có thể nhận nhiệm vụ thế giới:<color=White>\n";
		end
	
		for _,tbInfo in ipairs(tbTaskListInfo) do
			if (tbInfo) then
				szInfo = szInfo.."<color=yellow>"..tbInfo[2].."<color=White>\n";
				szInfo = szInfo..tbInfo[3].."\n";
			end
		end
		
		LinkPanelSetText(self.UIGROUP, self.TXT_TASK_TEXT, szInfo);
		tbTempData.nSelectTaskId = 0;
		return;
	end
	local nTaskId = self.m_tbTaskIdMap[nGroupIndex][nItemIndex + 1];
	tbTempData.nSelectTaskId = nTaskId;
	self:LayoutTaskInfo(nTaskId);
end

function uiTaskPanel:ShowTotalTaskNum()
	Txt_SetTxt(self.UIGROUP, self.TXT_TASK_NUM, "Số nhiệm vụ: "..Task:GetPlayerTask(me).nCount.." / "..20);
end

function uiTaskPanel:LayoutTaskInfo(nTaskId)
	local szGoalWndName = self.TXT_TASK_TEXT;
	local szDescWndName = "";
	local bFix, bChoice;
	self:EmptyTaskInfo();
	if Task:GetTaskType(nTaskId) == "Task" then
		self:FormatGoal(nTaskId);
		bFix, bChoice = self:FillAwardGroup(nTaskId);
		self:FormatDesc(nTaskId);
	elseif  Task:GetTaskType(nTaskId) == "LinkTask" then
		local szLinkTask	= self:LinkTaskTextOut();
		szLinkTask = szLinkTask..Lib:StrTrim(self:GetCurTargetDesc(nTaskId), "\n");
		LinkPanelSetText(self.UIGROUP, szGoalWndName, szLinkTask);
	elseif Task:GetTaskType(nTaskId) == "WantedTask" then
		local szText = "Tên nhiệm vụ: "..self:GetCurRefName(nTaskId).."\n\n";
		szText = szText .. "Miêu tả:\n    "..self:GetSubDesc(nTaskId).."\n\n";
		szText = szText .."Mục tiêu:\n"..Lib:StrTrim(self:GetCurTargetDesc(nTaskId), "\n").."\n\n";	--目标
		LinkPanelSetText(self.UIGROUP, szGoalWndName, szText);
	end;

	local nMainDescLeft, nMainDescTop  = Wnd_GetPos(self.UIGROUP, szGoalWndName)
	local _, nMainDescHeight =  Wnd_GetSize(self.UIGROUP, szGoalWndName); -- 获得任务描述
	local nCurrTop = nMainDescTop + nMainDescHeight + 10;

	local nGroupLeft, nGroupTop = Wnd_GetPos(self.UIGROUP, self.WND_FIX_AWARD[1]);
	if bFix == 1 then
		Wnd_SetPos(self.UIGROUP, self.WND_FIX_AWARD[1], nGroupLeft, nCurrTop);
		local nGroupWidth, nGroupHeight = Wnd_GetSize(self.UIGROUP, self.WND_FIX_AWARD[1]);
		nCurrTop = nCurrTop + nGroupHeight + 10;
	else
		Wnd_SetPos(self.UIGROUP, self.WND_FIX_AWARD[1], nGroupLeft, 0);
	end
	if bChoice == 1 then
		Wnd_SetPos(self.UIGROUP, self.WND_OPTIONAL_AWARD[1], nGroupLeft, nCurrTop);
	else
		Wnd_SetPos(self.UIGROUP, self.WND_OPTIONAL_AWARD[1], nGroupLeft, 0);
	end
	ScrPnl_Update(self.UIGROUP, self.WND_TASK_INFO);
end

function uiTaskPanel:FormatGoal(nTaskId)
	local szGoalWndName = self.TXT_TASK_TEXT;
	local szTotleDesc = "";

	local szStepState = "";
	local tbPlayerTask = Task:GetPlayerTask(me) --获得一个玩家所有的任务
	local tbTask = tbPlayerTask.tbTasks[nTaskId];
	local tbSubTaskData = tbTask.tbSubData;

	if (tbTask.nCurStep > 0) then
		
		if nTaskId == Merchant.TASKDATA_ID then
			szStepState  = Merchant:GetTask(Merchant.TASK_STEP_COUNT).." / "..Merchant.TASKDATA_MAXCOUNT;
		else
			local szCurStep = tostring(tbTask.nCurStep);
			local szTotleStep = tostring(#tbSubTaskData.tbSteps);
			szStepState  = szCurStep.." / "..szTotleStep;
		end
	else
		szStepState = "(Chưa nhận thưởng)";
	end

	local szDegree =  self:GetCurRefDegree(nTaskId);
	if (szDegree ~= "") then
		szDegree = " ["..szDegree.."]";
	end

	szTotleDesc = szTotleDesc..self:GetTaskName(nTaskId).."\n";
	szTotleDesc = szTotleDesc.."Tên nhiệm vụ con: "..self:GetCurRefName(nTaskId)..szDegree.."\n\n";
	szTotleDesc = szTotleDesc.."Hiện ở ("..szStepState.."): "..Lib:StrTrim(self:GetCurStepDesc(nTaskId), "\n").."\n\n";		--步骤描述
	szTotleDesc = szTotleDesc.."Mục tiêu:\n"..Lib:StrTrim(self:GetCurTargetDesc(nTaskId), "\n").."\n\n";	--目标
	szTotleDesc = szTotleDesc..self:GetStepAwardDesc(nTaskId);
	LinkPanelSetText(self.UIGROUP, szGoalWndName, szTotleDesc);
end

function uiTaskPanel:FormatDesc(nTaskId)

	local szDescWndName = self.TXT_TASK_DESC;
	local szTotleDesc = "";


	szTotleDesc = szTotleDesc..self:GetCurRefName(nTaskId).."\n";
	szTotleDesc = szTotleDesc..self:GetCurRefDesc(nTaskId).."\n";
	szTotleDesc = szTotleDesc..self:GetCurTotleStepDesc(nTaskId).."\n";	-- 步骤描述
	LinkPanelSetText(self.UIGROUP, szDescWndName, szTotleDesc);
end

function uiTaskPanel:FillAwardGroup(nTaskId)
	local tbAwards = Task:GetAwardsForMe(nTaskId);
	local bFix = 0;
	local bChoice = 0;
	for i = 1, #self.WND_FIX_AWARD[2] do
		if tbAwards.tbFix and tbAwards.tbFix[i] then
			local tbAward = tbAwards.tbFix[i];
			self:AddAwardObj(self.tbFixCont[i], tbAward);
			Wnd_Show(self.UIGROUP, self.WND_FIX_AWARD[3][i]);
		else
			Wnd_Hide(self.UIGROUP, self.WND_FIX_AWARD[3][i]);
		end
	end
	if tbAwards.tbFix and #tbAwards.tbFix > 0 then
		Wnd_Show(self.UIGROUP, self.WND_FIX_AWARD[1]);
		bFix = 1;
	else
		Wnd_Hide(self.UIGROUP, self.WND_FIX_AWARD[1]);
	end

	for i = 1, #self.WND_OPTIONAL_AWARD[2] do
		if tbAwards.tbOpt and tbAwards.tbOpt[i] then
			local tbAward = tbAwards.tbOpt[i];
			self:AddAwardObj(self.tbOptionalCont[i], tbAward);
			Wnd_Show(self.UIGROUP, self.WND_OPTIONAL_AWARD[3][i]);
		else
			Wnd_Hide(self.UIGROUP, self.WND_OPTIONAL_AWARD[3][i]);
		end
	end
	if tbAwards.tbOpt and #tbAwards.tbOpt > 0 then
		Wnd_Show(self.UIGROUP, self.WND_OPTIONAL_AWARD[1]);
		bChoice = 1
	else
		Wnd_Hide(self.UIGROUP, self.WND_OPTIONAL_AWARD[1]);
	end
	return bFix, bChoice;
end

function uiTaskPanel:AddAwardObj(tbCont, tbAward)
	self:RemoveTempItem(tbCont);	-- 容器里原来有东西则回收
	if (not tbAward) then
		return;
	end
	local nTaskId = self:GetCurrTaskId();
	if (not nTaskId or nTaskId <= 0) then
		return;
	end
	local tbPlayerTask	= Task:GetPlayerTask(me);
	local tbTask = tbPlayerTask.tbTasks[nTaskId];
	if (not tbTask) then
		return;
	end
	local nReferId = tbTask.nReferId;
	
	local tbObj = tbAwardInfo:GetAwardInfoObj(tbAward, nTaskId, nReferId);
	if (not tbObj) then
		return;
	end
	tbCont:SetObj(tbObj);
end

function uiTaskPanel:RemoveTempItem(tbCont)
	local tbObj = tbCont:GetObj();
	tbAwardInfo:DelAwardInfoObj(tbObj);
	tbCont:SetObj(nil);
end

function uiTaskPanel:EmptyTaskInfo()
	for i in ipairs(self.WND_FIX_AWARD[2]) do
		self:RemoveTempItem(self.tbFixCont[i]);
		Wnd_Hide(self.UIGROUP, self.WND_FIX_AWARD[3][i])
	end
	Wnd_Hide(self.UIGROUP, self.WND_FIX_AWARD[1]);
	for i in ipairs(self.WND_OPTIONAL_AWARD[2]) do
		self:RemoveTempItem(self.tbOptionalCont[i]);
		Wnd_Hide(self.UIGROUP, self.WND_OPTIONAL_AWARD[3][i])
	end
	Wnd_Hide(self.UIGROUP, self.WND_OPTIONAL_AWARD[1]);
	LinkPanelSetText(self.UIGROUP, self.TXT_TASK_TEXT, "");
end

function uiTaskPanel:OnButtonClick(szWndName, nParam)

	if (szWndName == self.BTN_TASK_INFO) then
		Wnd_Hide(self.UIGROUP, self.WND_TASK_DESC);
		Wnd_Show(self.UIGROUP, self.WND_TASK_INFO);
	elseif (szWndName == self.BTN_TASK_DESC) then
		Wnd_Hide(self.UIGROUP, self.WND_TASK_INFO);
		Wnd_Show(self.UIGROUP, self.WND_TASK_DESC);
	elseif (szWndName == self.BTN_SHARE_TASK) then --共享, 按钮为添加一任务
		local nTaskId = self:GetCurrTaskId();
		if (nTaskId == nil or nTaskId <= 0) then
			return;
		end
		self:OnShareTask(nTaskId);
	elseif (szWndName == self.BTN_GIVEUP_TASK) then -- 放弃一个任务
		local nTaskId = self:GetCurrTaskId();
		if (nTaskId == nil or nTaskId <= 0) then
			return;
		end
		local tbPlayerTask	= Task:GetPlayerTask(me);
		local tbTask = tbPlayerTask.tbTasks[nTaskId];
		if (not tbTask.tbReferData.bCanGiveUp) then
			me.Msg("Hủy thất bại: Không thể hủy nhiệm vụ này");
			return;
		end
		local tbMsg	= {};
		tbMsg.szMsg = "Muốn hủy nhiệm vụ không?";
		tbMsg.nOptCount = 2;
		function tbMsg:Callback(nOptIndex, nTaskId)
			if (nOptIndex == 2) and nTaskId and (nTaskId > 0) then
				local tbPlayerTask	= Task:GetPlayerTask(me);
				local nReferId = tbPlayerTask.tbTasks[nTaskId].nReferId;
				KTask.SendGiveUp(me, nTaskId, nReferId, 1);
			end
		end
		UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, nTaskId);
	elseif (szWndName == self.BTN_TRACK_TASK) then -- 追踪，
		self:OnTrackTask();
	elseif (szWndName == self.BTN_CLOSE) then -- 关闭按钮
		UiManager:CloseWindow(self.UIGROUP);
	end

end


function uiTaskPanel:InitData()

	self:UpdateTaskList();
	local nOutLookIdx, szTaskName = 0, "";
	AddOutLookItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, 0, {"Hướng dẫn nhiệm vụ"});

	local tbPlayerTask = Task:GetPlayerTask(me);
	for _, tbTask in pairs(tbPlayerTask.tbTasks) do
		nOutLookIdx, szTaskName = self:AddTask(tbTask.nTaskId);
		AddOutLookItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, nOutLookIdx, {szTaskName});
	end

	self.nInitDone	= 1;
end


function uiTaskPanel:RefreshTask(nTaskId, nReferId, nSaveGroup)
	if (UiManager:WindowVisible(self.UIGROUP) ~= 1) then
		return;
	end
	
	local nHaveThisTask = self:HaveThisTask(nTaskId);
	
	if (nSaveGroup == 0) then
		if (nHaveThisTask) then
			self:RemoveTask(nTaskId);
		end
	else
		if (nHaveThisTask) then
			if (self:GetCurrTaskId() == nTaskId) then
				self:SelectTask(nTaskId);
			end
			
			if (Ui(Ui.UI_TASKTRACK):IsBeTracked(nTaskId)) then
				Ui(Ui.UI_TASKTRACK):Refresh();
			end
		else
			local nOutLookIdx, szTaskName = self:AddTask(nTaskId);
			if (self.nInitDone == 1) and (nOutLookIdx - 1 >= 0) then
				AddOutLookItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, nOutLookIdx, {szTaskName});
				local nGroupIdx, nItemIdx	= self:GetItemLocalByTask(nTaskId);
				OutLookPanelSelItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, nGroupIdx, nItemIdx);
				self:SelectTask(nTaskId);
			end
		end
	end
	
	self:ShowTotalTaskNum();
end

function uiTaskPanel:SelectTask(nTaskId)
	self:LayoutTaskInfo(nTaskId);
end

function uiTaskPanel:AddTask(nTaskId)
	local nTaskIconIdx	= self:GetTaskIconIdx(nTaskId);
	local szTaskName 	= self:GetTaskName(nTaskId);
	local nTaskType 	= self:GetTaskType(nTaskId);
	local nTaskMapIndex = self:GetTaskMapIndex(nTaskType);
	for i = 1, #self.m_tbTaskIdMap do
		if (nTaskMapIndex == i) then
			if (self.m_tbTaskIdMap[i]~={}) and (self.m_tbTaskIdMap[i]~=nil) then
				for _, tbTaskMap in pairs(self.m_tbTaskIdMap[i]) do -- 如果已经有这个任务，则返回
					if (tbTaskMap == nTaskId) then
						return i, szTaskName;
					end
				end
			end
			table.insert(self.m_tbTaskIdMap[i], nTaskId);
			return i, szTaskName;
		end
	end
end

function uiTaskPanel:GetTaskMapIndex(nTaskType)
	if (nTaskType == Task.emType_Main) then
		return 2; 
	elseif (nTaskType == Task.emType_Branch) then
		return 3;
	elseif (nTaskType == Task.emType_World) then
		return 4;
	elseif (nTaskType == Task.emType_Random) then
		return 5;
	elseif (nTaskType == Task.emType_Camp) then
		return 1;
	end
	
	return 5;
end

function uiTaskPanel:HaveThisTask(nDestTaskId)
	for i = 1, #self.m_tbTaskIdMap do
		if (self.m_tbTaskIdMap[i]) then
			for _, nTaskId in pairs(self.m_tbTaskIdMap[i]) do -- 如果已经有这个任务，则返回
				if (nTaskId == nDestTaskId) then
					return 1;
				end
			end
		end
	end
end

function uiTaskPanel:GetItemLocalByTask(nTaskId)
	for j, tbTaskMap in ipairs(self.m_tbTaskIdMap) do
		for i = 1, #tbTaskMap do
			if tbTaskMap[i] == nTaskId then
				return j, i - 1;
			end
		end
	end
end

function uiTaskPanel:FindFirstTask()
	if Task:GetPlayerTask(me).nCount<=0 then return 0; end;
	for j, tbTaskMap in ipairs(self.m_tbTaskIdMap) do
		for i = 1, #tbTaskMap do
			if tbTaskMap[i] > 0 then
				return tbTaskMap[i];
			end
		end
	end
end

function uiTaskPanel:RemoveTask(nTaskId)
	for j, tbTaskMap in ipairs(self.m_tbTaskIdMap) do
		for i = 1, #tbTaskMap do
			if (tbTaskMap[i] == nTaskId) then
				if (self:GetCurrTaskId() == nTaskId) then
					self:EmptyTaskInfo();
					LinkPanelSetText(self.UIGROUP, self.TXT_TASK_TEXT, "");
					LinkPanelSetText(self.UIGROUP, self.TXT_TASK_DESC, "");
				end
				table.remove(tbTaskMap, i);
				if self.nInitDone == 1 then
					DelOutLookItem(self.UIGROUP, self.OUTLOOK_TASK_LIST, j, i - 1);
				end
				return;
			end
		end
	end
end

function uiTaskPanel:OnShareTask(nTaskId)
	if (nTaskId and nTaskId > 0) then
		local tbPlayerTask	= Task:GetPlayerTask(me);
		local nReferId = tbPlayerTask.tbTasks[nTaskId].nReferId;
		KTask.SendShare(me, nTaskId, nReferId, 1);
	end
end

function uiTaskPanel:OnTrackTask()
	local nCurrTaskId = self:GetCurrTaskId();
	if (nCurrTaskId == nil or nCurrTaskId <= 0) then
		return;
	end
	if (Ui(Ui.UI_TASKTRACK):IsBeTracked(nCurrTaskId)) then
		Ui(Ui.UI_TASKTRACK):RemoveTrackedTask(nCurrTaskId);
	else
		Ui(Ui.UI_TASKTRACK):AddTrackedTask(nCurrTaskId);
	end
end

function uiTaskPanel:OnLinkClick(szWnd, szLinkInfo)
	local tbLinkClass, szLink	= self:ParseLink(szLinkInfo);
	tbLinkClass:OnClick(szLink);
end

function uiTaskPanel:OnLinkRClick(szWnd, szLinkInfo)
	local tbLinkClass, szLink	= self:ParseLink(szLinkInfo);
	tbLinkClass:OnRClick(szLink);
end

function uiTaskPanel:OnLinkHover(szWnd, szLinkInfo)
	local tbLinkClass, szLink	= self:ParseLink(szLinkInfo);
	local szTip	= tbLinkClass:GetTip(szLink);
	Wnd_ShowMouseHoverInfo(self.UIGROUP, self.WND_TASK_INFO, "", szTip);
end

function uiTaskPanel:ParseLink(szLinkInfo)
	local tbSplit	= Lib:SplitStr(szLinkInfo, "=");

	local tbLinkClass	= UiManager.tbLinkClass[tbSplit[1]];
	local szLink	= tbSplit[2];
	return tbLinkClass, szLink;
end

function uiTaskPanel:GetCurrTaskId()
	return tbTempData.nSelectTaskId;
end


function uiTaskPanel:GetTaskType(nTaskId)
	return tonumber(Task.tbTaskDatas[nTaskId].tbAttribute.TaskType);
end

function uiTaskPanel:GetTaskName(nTaskId)
	return Task:GetTaskName(nTaskId);
end

function uiTaskPanel:GetTaskDesc(nTaskId)
	return Task:GetTaskDesc(nTaskId);
end

function uiTaskPanel:GetCurRefName(nTaskId)
	local tbPlayerTask	= Task:GetPlayerTask(me);

	local tbTask		= tbPlayerTask.tbTasks[nTaskId];
	return tbTask.tbReferData.szName;
end

function uiTaskPanel:GetCurRefDegree(nTaskId)
	local tbPlayerTask	= Task:GetPlayerTask(me);

	local tbTask = tbPlayerTask.tbTasks[nTaskId];
	
	local szDegreeDesc = Task:GetRefSubTaskDegreeDesc(tbTask.tbReferData.nReferId) or "";
	
	return szDegreeDesc;
end


function uiTaskPanel:GetCurRefDesc(nTaskId)
	local tbPlayerTask	= Task:GetPlayerTask(me);
	local tbTask		= tbPlayerTask.tbTasks[nTaskId];
	local tbStepsDesc	= tbTask.tbReferData.tbDesc.szMainDesc;
	return tbStepsDesc or "";
end

function uiTaskPanel:GetSubDesc(nTaskId)
	local tbPlayerTask	= Task:GetPlayerTask(me);
	local nReferId = tbPlayerTask.tbTasks[nTaskId].nReferId
	local nSubTaskId = Task.tbReferDatas[nReferId].nSubTaskId;
	if Task.tbSubDatas[nSubTaskId] then
		return Task.tbSubDatas[nSubTaskId].szDesc;
	end
	return "";
end

function uiTaskPanel:GetCurStepDesc(nTaskId)
	local tbPlayerTask	= Task:GetPlayerTask(me);
	local tbTask		= tbPlayerTask.tbTasks[nTaskId];
	if (tbTask.nCurStep > 0) then
		local tbStepsDesc	= tbTask.tbReferData.tbDesc.tbStepsDesc;
		if (tbStepsDesc) then
			local szDsc = Task:ReplaceName_Link(tbStepsDesc[tbTask.nCurStep]);
			return szDsc or "";
		end
	else		
		local szDsc = Task:ReplaceName_Link(tbTask.tbReferData.szReplyDesc);
		return szDsc or "";
	end
	return "";
end

function uiTaskPanel:GetStepAwardDesc(nTaskId)
	local tbPlayerTask	= Task:GetPlayerTask(me);
	local tbTask		= tbPlayerTask.tbTasks[nTaskId];
	local tbSubData		= tbTask.tbSubData;
	local tbCurStep		= tbSubData.tbSteps[tbTask.nCurStep];

	if (tbCurStep) then
		if (tbCurStep.szAwardDesc and tbCurStep.szAwardDesc ~= "") then
			local szTotleDesc = "<color=Gold>Phần thưởng: <color=White>\n"
			return Lib:StrTrim(szTotleDesc..tbCurStep.szAwardDesc, "\n");
		else
			return "";
		end
	else
		return "";
	end
end

function uiTaskPanel:GetCurTargetDesc(nTaskId)
	local szTotleDesc 	= "";
	local tbPlayerTask	= Task:GetPlayerTask(me);
	local tbTask		= tbPlayerTask.tbTasks[nTaskId];

	local tbCurTags = tbTask.tbCurTags;
	for _, tbCurTag in ipairs(tbCurTags) do
		local szFinishTag = "   (Đã hoàn thành)"
		local szTagDesc = tbCurTag:GetDesc();
		if (szTagDesc and szTagDesc ~="") then
			if (tbCurTag:IsDone()) then
				szTotleDesc = szTotleDesc.."<color=Green>"..tbCurTag:GetDesc()..szFinishTag.."<color=White>\n";
			else
				szTotleDesc = szTotleDesc.."<color=Red>"..tbCurTag:GetDesc().."<color=White>\n";
			end
		end
	end
	
	if (szTotleDesc) then
		szTotleDesc = string.gsub(szTotleDesc, "Thu Lâm", "Bạch Thu Lâm");
	end

	return (szTotleDesc) or "";
end

function uiTaskPanel:GetCurTotleStepDesc(nTaskId)

	local tbPlayerTask	= Task:GetPlayerTask(me);
	local tbTask		= tbPlayerTask.tbTasks[nTaskId];
	local tbStepsDesc	= tbTask.tbReferData.tbDesc.tbStepsDesc;

	local szStepsDesc = "";
	if (tbStepsDesc) then
		for i = 1, tbTask.nCurStep do
			if (tbStepsDesc[i]) then
				szStepsDesc = szStepsDesc.."  "..tbStepsDesc[i].."\n";
			end
		end
	end

	Lib:StrTrim(szStepsDesc, "\n");
	return szStepsDesc or "";

end

function uiTaskPanel:GetTaskIconIdx(nTaskId)
	return tonumber(Task.tbTaskDatas[nTaskId].tbAttribute.TaskIconIndex);
end

function uiTaskPanel:GetAwardIconPath(nIconIndex)
	return KTask.GetIconPath(nIconIndex);
end


function uiTaskPanel:GetItemAwardInfo(nTaskId, tbItem, nItemType)

	local nGenre, nDetail, nParticular, nLevel, nSeries = unpack(tbItem);

	if nLevel == 0 then nLevel = 1; end;
	if nSeries == -1 then nSeries = 0; end;

	local pItem = nil;

	if not self.tbAwardInfo[nTaskId] then
		self.tbAwardInfo[nTaskId] = {};
	end

	local szItemKey = tostring(nGenre..","..nDetail..","..nParticular..","..nLevel);

	if not self.tbAwardInfo[nTaskId][szItemKey] then
		self.tbAwardInfo[nTaskId][szItemKey] = {};
		pItem = KItem.CreateTempItem(nGenre, nDetail, nParticular, nLevel, nSeries);
		if not pItem then
			return "";
		end
		self.tbAwardInfo[nTaskId][szItemKey] = {pItem.szName, pItem.szIconImage};
		pItem.Remove();
	end

	return unpack(self.tbAwardInfo[nTaskId][szItemKey]);
end

function uiTaskPanel:LinkTaskTextOut()
	local szMainText	= "Nhiệm vụ của Bao Vạn Đồng:\n\nNghĩa quân kiên trì giao chiến với quân Kim ở vùng Bắc Giang. Chinh chiến quanh năm, quân lương, tiếp viện, quân y đã tiêu hết từ các nơi cung ứng.\n\nDo 2 nước lúc đánh lúc hòa, thiệt hại nhiều, các thương nhân tiếp viện quân lương nhưng thấy Nghĩa quân không tiến triển gì nên dần giảm cung cấp. Bạch Thu Lâm buộc phải tự xoay sở để tạm thời giải quyết khó khăn.\n\nBiện pháp khả thi trước mắt là để Bao Vạn Đồng đứng ra nhờ hào kiệt thiên hạ đóng góp, giúp Thu Di giải quyết khó khăn, hãy cố gắng hoàn thành nhiệm vụ Bao Vạn Đồng giao.\n\n";

	szMainText = szMainText.."Nhiệm vụ Bao Vạn Đồng hiện tại:\n";

	return szMainText;

end;

function uiTaskPanel:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_TASK_REFRESH,		self.RefreshTask	},
	};
	for i in ipairs(self.WND_FIX_AWARD[2]) do
		tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbFixCont[i]:RegisterEvent());
	end
	for i in ipairs(self.WND_OPTIONAL_AWARD[2]) do
		tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbOptionalCont[i]:RegisterEvent());
	end
	return tbRegEvent;
end

function uiTaskPanel:RegisterMessage()
	local tbRegMsg = {};
	for i in ipairs(self.WND_FIX_AWARD[2]) do
		tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbFixCont[i]:RegisterMessage())
	end
	for i in ipairs(self.WND_OPTIONAL_AWARD[2]) do
		tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbOptionalCont[i]:RegisterMessage())
	end
	return tbRegMsg;
end
