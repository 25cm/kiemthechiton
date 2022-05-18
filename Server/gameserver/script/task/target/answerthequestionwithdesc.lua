
local tb	= Task:GetTarget("AnsewerTheQuestionWithDesc");
tb.szTargetName	= "AnsewerTheQuestionWithDesc";

tb.szColName_QId		= "Id"
tb.szColName_QContent	= "QuestionContent";	
tb.szColName_QAnswerA	= "Answer_A";
tb.szColName_QAnswerB	= "Answer_B";
tb.szColName_QAnswerC	= "Answer_C";
tb.szColName_QAnswerD	= "Answer_D";
tb.szColName_QCorrectIdx= "CorrectIdx";
tb.szColName_QPic		= "QuestionPic";


function tb:Init(nNpcTempId, nMapId, szOption, szPreDialog, szSuccDialog, szFailDialog, nErrorLimit, nPassNumber, szQLib, szRepeatMsg, bRandomMode, szBeforePop, szLaterPop, nCostMoney, szChoice, szDynamicDesc, szStaticDesc)
	self:OnIni();
	self.nNpcTempId		= nNpcTempId;
	self.szNpcName		= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId			= nMapId;
	self.szMapName		= Task:GetMapName(nMapId);
	self.szOption		= szOption;
	self.szPreDialog	= szPreDialog;
	self.szSuccDialog 	= szSuccDialog;
	self.szFailDialog 	= szFailDialog;
	self.nErrorLimit	= nErrorLimit;
	self.nPassNumber	= nPassNumber;
	self.tbQLib			= self:ParseQLib(szQLib);
	if (szRepeatMsg ~= "") then
		self.szRepeatMsg	= szRepeatMsg;
	end;
	self.bRandomMode	= bRandomMode;
	self.szBeforePop	= szBeforePop;
	self.szLaterPop		= szLaterPop;
	self.nCostMoney		= tonumber(nCostMoney);
	if (not self.nCostMoney) then
		self.nCostMoney = 0;
	end
	self.szChoice 		= szChoice;
	if (not self.szChoice or self.szChoice == "") then
		self.szChoice = "Bắt đầu trả lời";
	end
	self.szDynamicDesc	= szDynamicDesc;
	self.szStaticDesc	= szStaticDesc;
end;


function tb:OnIni()
	self.tbQLibFile = Lib:NewClass(Lib.readTabFile, "\\setting\\task\\task_question_lib.txt");
end;

function tb:ParseQLib(szQLib)
	local tbQIdSet 	= Lib:SplitStr(szQLib, ",");
	
	local tbQLib = {};
	for i = 1, #tbQIdSet do
		local tbItem = {};
		tbItem.nId 					= self.tbQLibFile:GetCell(self.szColName_QId, 		tbQIdSet[i]-1);
		tbItem.szQuestionContent	= self.tbQLibFile:GetCell(self.szColName_QContent,	tbQIdSet[i]-1);
		tbItem.szAnswer_A			= self.tbQLibFile:GetCell(self.szColName_QAnswerA,	tbQIdSet[i]-1);
		tbItem.szAnswer_B			= self.tbQLibFile:GetCell(self.szColName_QAnswerB,	tbQIdSet[i]-1);
		tbItem.szAnswer_C			= self.tbQLibFile:GetCell(self.szColName_QAnswerC,	tbQIdSet[i]-1);
		tbItem.szAnswer_D			= self.tbQLibFile:GetCell(self.szColName_QAnswerD,	tbQIdSet[i]-1);
		tbItem.nCorrectIdx			= tonumber(self.tbQLibFile:GetCell(self.szColName_QCorrectIdx,tbQIdSet[i]-1));
		tbItem.szPic				= self.tbQLibFile:GetCell(self.szColName_QPic,		tbQIdSet[i]-1);
		
		tbQLib[i] = tbItem;
	end
	
	return tbQLib;
end;



function tb:Start()
	self.bDone		= 0;
	self:Register();
end;

function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone);
	return 1;
end;

function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.bDone		= self.me.GetTask(nGroupId, nStartTaskId);
	if (not self:IsDone() or self.szRepeatMsg) then	-- 本目標是一旦達成後不會失效的
		self:Register();
	end;

	return 1;
end;

function tb:IsDone()
	return self.bDone == 1;
end;

function tb:GetDesc()
	return self.szDynamicDesc;
end;

function tb:GetStaticDesc()
	return self.szStaticDesc;
end;

function tb:Close(szReason)
	self:UnRegister();
end;


function tb:Register()
	self.tbTask:AddNpcMenu(self.nNpcTempId, self.nMapId, self.szOption, self.OnTalkNpc, self);
end;

function tb:UnRegister()
	self.tbTask:RemoveNpcMenu(self.nNpcTempId);
end;


function tb:OnTalkNpc()
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		local oldPlayer = me;
		me = self.me;
		TaskAct:Talk("Không phải bản đồ ngươi muốn tìm"..self.szNpcName.."Xin hãy đến "..self.szMapName)
		me = oldPlayer;
		return;
	end;
	if (self:IsDone()) then
		if (self.szRepeatMsg) then
			local oldPlayer = me;
			me = self.me;
			TaskAct:Talk(self.szRepeatMsg);
			me = oldPlayer;
		end;
		return;
	end;

	if (self.bRandomMode == 1) then
		Lib:SmashTable(self.tbQLib);
	end
	
	self:StartAnswer();
end;

-- 從第一題開始，逐個回答。
function tb:StartAnswer()
	self.nError 	= 0;
	self.nCurQIdx 	= 1;
	local szMsg = self.szPreDialog;
	szMsg = Lib:ParseExpression(szMsg);
	szMsg = Task:ParseTag(szMsg);
	if (self.nCostMoney > 0) then
		if (self.me.CostMoney(self.nCostMoney, Player.emKPAY_ANSWER) ~= 1) then
			self.me.Msg("Bạn không có "..self.nCostMoney.." bạc, không thể vào trả lời");
			return;
		end
	end
	
	Dialog:Say(szMsg,
				{
					{self.szChoice, self.AnswerQuestion, self, 1}
				});
end;

function tb:AnswerQuestion(nIdx)
	local szMsg = Lib:ParseExpression(self.tbQLib[nIdx].szQuestionContent);
	local szMsg = Task:ParseTag(szMsg);
	local szMsg = "<pic:"..self.tbQLib[nIdx].szPic..">"..szMsg;
	local szMsg = "<head:"..self:GetNpcPic()..">"..szMsg;
	Dialog:Say(szMsg,
				{
				   {self.tbQLib[nIdx].szAnswer_A, tb.OnSelect, self, 1, nIdx},
				   {self.tbQLib[nIdx].szAnswer_B, tb.OnSelect, self, 2, nIdx},
				   {self.tbQLib[nIdx].szAnswer_C, tb.OnSelect, self, 3, nIdx},
				   {self.tbQLib[nIdx].szAnswer_D, tb.OnSelect, self, 4, nIdx},
				   {"Trả lời sau",					  tb.OnSelect, self, -1, nIdx},
				});
end;



function tb:OnSelect(nAnswer, nIdx)
	if (nAnswer < 0) then
		return;
	end
	
	local bError = false;
	if (self.tbQLib[nIdx].nCorrectIdx ~= nAnswer) then
		self.nError = self.nError + 1;
		bError = true;
	end
	
	if (self.nError >= self.nErrorLimit) then
		local oldPlayer = me;
		me = self.me;
		TaskAct:Talk(self.szFailDialog);
		me = oldPlayer;
		return;
	end
	
	-- 及格了
	if ((self.nPassNumber <= nIdx) and (not bError)) then
		local oldPlayer = me;
		me = self.me;
		TaskAct:Talk(self.szSuccDialog, self.PassQuestion, self);
		me = oldPlayer;
		return;
	end
	
	if (bError) then
		self:AnswerQuestion(nIdx);
		self.me.Msg("Sai rồi, xin trả lời lại");
	else
		self:AnswerQuestion(nIdx + 1);
	end
end;

function tb:PassQuestion()
	self.bDone	= 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	self.me.Msg("Mục tiêu: "..self:GetStaticDesc());
	
	if (not self.szRepeatMsg) then
		self:UnRegister()	-- 本目標是一旦達成後不會失效的
	end;

	self.tbTask:OnFinishOneTag();
end

-- 根據Npc模板獲得它的圖片
function tb:GetNpcPic(nTempId)
	return ""
end;


