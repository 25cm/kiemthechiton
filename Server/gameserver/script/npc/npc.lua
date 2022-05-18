-- Npc脚本类

Require("\\script\\npc\\define.lua");

if (not Npc.tbClassBase) then	-- 防止文件重载时破坏已有数据
	-- Npc基础模板，详细的在default.lua中定义
	Npc.tbClassBase	= {};

	-- Npc模板库
	Npc.tbClass	= {
		-- 默认模板，可以提供直接使用
		default	= Npc.tbClassBase,
		[""]	= Npc.tbClassBase,
	};
end;

-- 取得特定类名的Npc模板
function Npc:GetClass(szClassName, bNotCreate)
	local tbClass	= self.tbClass[szClassName];
	-- 如果没有bNotCreate，当找不到指定模板时会自动建立新模板
	if (not tbClass and bNotCreate ~= 1) then
		-- 新模板从基础模板派生
		tbClass	= Lib:NewClass(self.tbClassBase);
		-- 加入到模板库里面
		self.tbClass[szClassName]	= tbClass;
	end;
	return tbClass;
end;

-- 任何Npc对话，系统都会调用这里
function Npc:OnDialog(szClassName, szParam)
	-- 这里可以加入一些通用的Npc对话事件
	--观战模式不允许对话；
	if Looker:IsLooker(me) > 0 then
		Dialog:Say("Ai đó? Sao nghe tiếng mà không thấy người vậy?");
		return 0;
	end
	--防沉迷, 不允许和任何npc对话
	if (me.GetTiredDegree() == 2) then
		Dialog:Say("Bạn đã online quá 5h, không nhận được bất cứ hiệu quả nào.");
		return 0;
	end;
	
	local tbOpt	= {};
	local nEventFlag = 0;
	local nTaskFlag = 0;
	
	if (Task:AppendNpcMenu(tbOpt) == 1) then
		nTaskFlag = 1;
	end;
	
	local tbNpc = EventManager:GetNpcClass(him.nTemplateId);
	local tbNpcType = EventManager:GetNpcClass(szClassName);
	
	if tbNpc and EventManager.tbFun:MergeDialog(tbOpt, tbNpc) == 1 then
		nEventFlag = 1;
	end
	
	if tbNpcType and EventManager.tbFun:MergeDialog(tbOpt, tbNpcType) == 1 then
		nEventFlag = 1;
	end		

	if nEventFlag == 1 or nTaskFlag == 1 then
		local szMsg = "";
		local szMsg2 = "";
		if nEventFlag == 1 and nTaskFlag == 1 then
			szMsg = string.format("%s: Đến thật đúng lúc, ta có nhiệm vụ và hoạt động cho ngươi.", him.szName)
			szMsg2 = "Không muốn tham gia";
		elseif nEventFlag == 1 then
			szMsg = string.format("%s: Đến thật đúng lúc, ta có hoạt động cho ngươi.", him.szName)
			szMsg2 = "Ta muốn hỏi chuyện khác";
		elseif nTaskFlag == 1 then
			szMsg = string.format("%s: Đến thật đúng lúc, ta có hoạt động cho ngươi.", him.szName)
			szMsg2 = "Ta muốn hỏi chuyện khác";
		end
		tbOpt[#tbOpt+1]	= {szMsg2, self.OriginalDialog, self, szClassName, him};	
		if nTaskFlag == 1 then
			tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
		end
		Dialog:Say(szMsg, tbOpt);
		return;
	end
	
	-- 根据 szClassName 找到特定模板
	local tbClass	= self.tbClass[szClassName];
	Dbg:Output("Npc", "OnDialog", szClassName, tbClass);
	if (tbClass) then
		-- 调用模板指定的对话函数
		tbClass:OnDialog(szParam);
	end;
end;


function Npc:OnBubble(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (tbClass) then
		tbClass:OnTriggerBubble();
	end
end

function Npc:AddBubble(szClassName, nIndex, szMsg)
end
-- 原有Npc对话，提供“我不想做任务”使用，不会进行对话拦截
function Npc:OriginalDialog(szClassName, pNpc)
	-- TODO: FanZai	要对Npc指针进行检查
	him	= pNpc;
	self.tbClass[szClassName]:OnDialog();
	him	= nil;
end;

-- 任何Npc死亡，系统都会调用这里
function Npc:OnDeath(szClassName, szParam, ...)
	-- 根据 szClassName 找到特定模板
	local tbClass	= self.tbClass[szClassName];
	-- TODO:写在这里不好,将来要改!!!
	-- 如果该NPC死的时候正在被说服，删掉被说服状态
	if him.GetTempTable("Partner").nPersuadeRefCount then
		him.RemoveTaskState(Partner.nBePersuadeSkillId);
		him.GetTempTable("Partner").nPersuadeRefCount = 0;
	end
	
	-- 这里可以加入一些通用的Npc死亡事件
	local tbOnDeath	= him.GetTempTable("Npc").tbOnDeath;
	Dbg:Output("Npc", "OnDeath", szClassName, tbClass, tbOnDeath);
	if (tbOnDeath) then
		local tbCall	= {unpack(tbOnDeath)};
		Lib:MergeTable(tbCall, arg);
		local bOK, nRet	= Lib:CallBack(tbCall);	-- 调用回调
		if (not bOK or nRet ~= 1) then
			him.GetTempTable("Npc").tbOnDeath	= nil;
		end
	end
	

	
	if (tbClass) then
		-- 调用模板指定的死亡函数
		tbClass:OnDeath(unpack(arg));
	end;
	
	--npc死亡额外触发事件
	Lib:CallBack({"SpecialEvent.ExtendEvent:DoExecute","Npc_Death", him, arg[1]});
		
	if (not arg[1]) then
		return;
	end
	
	local pNpc 		= arg[1];
	local nNpcType 	= him.GetNpcType();
	local pPlayer  	= pNpc.GetPlayer();
	if (not pPlayer) then
		return;
	end

	if (1 == nNpcType) then
		self:AwardXinDe(pPlayer, 100000);
		self:AwardTeamXinDe(pPlayer, 100000);
	elseif (2 == nNpcType) then
		self:AwardXinDe(pPlayer, 200000);
		self:AwardTeamXinDe(pPlayer, 200000)
	end
	
	--活动系统调用
	EventManager:NpcDeathApi(szClassName, him, pPlayer, unpack(arg))
	
end;

function Npc:AwardTeamXinDe(pPlayer, nXinDe)
	if (nXinDe <= 0) then
		return;
	end

	local nTeamId	= pPlayer.nTeamId;
	local tbPlayerId, nMemberCount	= KTeam.GetTeamMemberList(nTeamId);
	if not tbPlayerId then
		return
	end	
	local nNpcMapId, nNpcX, nNpcY	= pPlayer.GetWorldPos();	
	for i, nPlayerId in pairs(tbPlayerId) do
		local pTPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		if pTPlayer and pTPlayer.nId ~= pPlayer.nId then
			local nPlayerMapId, nPlayerX, nPlayerY	= pTPlayer.GetWorldPos();
			if (nPlayerMapId == nNpcMapId) then
				local nDisSquare = (nNpcX - nPlayerX)^2 + (nNpcY - nPlayerY)^2;
				if (nDisSquare < 16 * 16) then -- 九屏内玩家
					self:AwardXinDe(pTPlayer, nXinDe);
				end
			end
		end
	end
	
end

function Npc:AwardXinDe(pPlayer, nXinDe)
	if (nXinDe <= 0) then
		return;
	end
	Setting:SetGlobalObj(pPlayer);
	Task:AddInsight(nXinDe);
	Setting:RestoreGlobalObj();
end

function Npc:OnArrive(szClassName, pNpc)
	--print ("Npc:OnArrive", szClassName, pNpc);
	local tbOnArrive = pNpc.GetTempTable("Npc").tbOnArrive;
	Setting:SetGlobalObj(me, pNpc, it)
	if (tbOnArrive) then
		Lib:CallBack(tbOnArrive);
	end
	Setting:RestoreGlobalObj()
end

-- 当Npc血量减少到此处触发
function Npc:OnLifePercentReduceHere(szClassName, pNpc, nPercent)
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc[%s] not found！", szClassName));
		return 0;
	end;
	
	Setting:SetGlobalObj(me, pNpc, it);
	if (tbClass.OnLifePercentReduceHere) then
		tbClass:OnLifePercentReduceHere(nPercent);
	end
	Setting:RestoreGlobalObj();
end

--设置npc随机走动AI
--nMapId		:地图Id
--nX			:X坐标32位
--nY			:Y坐标32位
--nAINpcId	:随意走动npcId(具有AI的战斗npc)
--nChatSec		:多少秒循环一次，（0或nil为5）(由nChatSec*nChatCount决定了AInpc的一次存在时间)
--nChatCount	:共循环多少次，（0或nil为1）
--nMaxSec		:存在总时间(包括了AInpc和对话npc在内的总的时间(秒), 0为无限时)
--nRange		:npc每次随机范围(32位,范围随机,（0或nil为1000）)
--nDialogNpcId	:转变成对话npc的Id(0为无对话npc转换,将始终是AInpc)
--nDialogSec	:对话npc存在时间(秒)（0或nil为10秒）
--tbChat		:npc说话内容(AInpc走到过程中的说话内容,表内随机)
--example		:local nMapId,nX,nY = me.GetWorldPos(); Npc:OnSetFreeAI(nMapId, nX*32, nY*32, 598, 0, 0, 0, 0, 2964, 0, {"唉～～～"});	
function Npc:OnSetFreeAI(nMapId, nX, nY, nAINpcId, nChatSec, nChatCount, nMaxSec, nRange, nDialogNpcId, nDialogSec, tbChat)
	
	--默认值；
	nChatSec 	= ((nChatSec==0 	or not nChatSec) 	and 5) 		or nChatSec;
	nChatCount 	= ((nChatCount==0 	or not nChatCount) 	and 1) 		or nChatCount;
	nRange 		= ((nRange==0 		or not nRange) 		and 1000) 	or nRange;
	nDialogSec 	= ((nDialogSec==0 	or not nDialogSec) 	and 10) 	or nDialogSec;
	
	local pNpc = KNpc.Add(nAINpcId, 100, -1, SubWorldID2Idx(nMapId), nX, nY);
	if pNpc then
		local tbRX =  {math.floor(MathRandom(-nRange, -math.floor(nRange*0.6))), math.floor(MathRandom(math.floor(nRange*0.6), nRange))};
		local tbRY =  {math.floor(MathRandom(-nRange, -math.floor(nRange*0.6))), math.floor(MathRandom(math.floor(nRange*0.6), nRange))};
		local nTrX =  tbRX[math.floor(MathRandom(1, 2))] or 0;
		local nTrY =  tbRY[math.floor(MathRandom(1, 2))] or 0;
		local nMovX = nX + nTrX;
		local nMovY = nY + nTrY;
		pNpc.AI_AddMovePos(nMovX, nMovY);
		pNpc.SetNpcAI(9, 0, 1,-1, 0, 0, 0, 0, 0, 0, 0);
		pNpc.GetTempTable("Npc").tbNpcFreeAI				= {};
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount = 0;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatCount 	= nChatCount;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nMaxSec 		= nMaxSec;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nAINpcId 		= nAINpcId;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatSec 		= nChatSec;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nRange 		= nRange;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogNpcId 	= nDialogNpcId;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogSec 	= nDialogSec;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.tbChat 		= tbChat;
		local nTimerId = Timer:Register(nChatSec * Env.GAME_FPS, self.OnTimerFreeAI, self, pNpc.dwId, 1);
		self._tbDebugFreeAITimer 	= self._tbDebugFreeAITimer or {};
		self._tbDebugFreeAITimer2 	= self._tbDebugFreeAITimer2 or {};
		self._tbDebugFreeAITimer[nTimerId] 	 = pNpc.dwId;
		self._tbDebugFreeAITimer2[pNpc.dwId] = nTimerId;
		Npc.tbFreeAINpcList = Npc.tbFreeAINpcList or {};
		Npc.tbFreeAINpcList[pNpc.dwId] = 1;
	end
	return 0;
end

function Npc:OnTimerFreeAI(nNpcId, nNpcType)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		local nTimerId = self._tbDebugFreeAITimer2[nNpcId];
		if nTimerId then 
			self._tbDebugFreeAITimer[nTimerId]	= nil; 
		end
		self._tbDebugFreeAITimer2[nNpcId] = nil;
		return 0;
	end
	
	local nCalcChatCount=	pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount;
	local nChatCount 	=	pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatCount;
	local nMaxSec 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nMaxSec;
	local nAINpcId 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nAINpcId;
	local nChatSec 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatSec;
	local nRange 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nRange;
	local nDialogNpcId 	= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogNpcId;
	local nDialogSec 	= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogSec;
	local tbChat 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.tbChat;
	local nMapId 		= 	pNpc.nMapId;
	local nX, nY 		= 	pNpc.GetMpsPos();
	local tbSec 		= 	{[1] = nChatSec, [2] = nDialogSec,};
	
	if nMaxSec > 0 then
		nMaxSec = nMaxSec - tbSec[nNpcType];
		if nMaxSec == 0 then
			nMaxSec = -1;
		end
	end
	
	if nMaxSec < 0 then
		Npc.tbFreeAINpcList[pNpc.dwId] = nil;
		
		---Debug
		local nTimerId = self._tbDebugFreeAITimer2[pNpc.dwId];
		self._tbDebugFreeAITimer[nTimerId]	= nil;
		self._tbDebugFreeAITimer2[pNpc.dwId] = nil;	
		---	
		
		pNpc.Delete();		
		return 0;
	end
	
	if nNpcType == 2 then
		Npc.tbFreeAINpcList[pNpc.dwId] = nil;
		
		---Debug
		local nTimerId = self._tbDebugFreeAITimer2[pNpc.dwId];
		self._tbDebugFreeAITimer[nTimerId]	= nil;
		self._tbDebugFreeAITimer2[pNpc.dwId] = nil;	
		---
		
		pNpc.Delete();
		self:OnSetFreeAI(nMapId, nX, nY, nAINpcId, nChatSec, nChatCount, nMaxSec, nRange, nDialogNpcId, nDialogSec, tbChat)
		return 0;
	end
	
	pNpc.GetTempTable("Npc").tbNpcFreeAI.nMaxSec = nMaxSec;
	if not nDialogNpcId or nDialogNpcId ==0 or nCalcChatCount < nChatCount then
		if nDialogNpcId > 0 then
			pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount = pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount + 1;
		end
		if type(tbChat) == "table" and #tbChat > 0 then
			local szChar = tbChat[math.floor(MathRandom(1, #tbChat))] or "";
			pNpc.SendChat(szChar);
		end
		return
	end
	
	Npc.tbFreeAINpcList[pNpc.dwId] = nil;
	---Debug
	local nTimerId = self._tbDebugFreeAITimer2[pNpc.dwId];
	self._tbDebugFreeAITimer[nTimerId]	= nil;
	self._tbDebugFreeAITimer2[pNpc.dwId] = nil;	
	---	
	
	pNpc.Delete();
	
	local pNpcDialog = KNpc.Add(nDialogNpcId, 100, -1, SubWorldID2Idx(nMapId), nX, nY);
	if  pNpcDialog then
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI 				= {};
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nChatCount 	= nChatCount;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nMaxSec 		= nMaxSec;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nAINpcId 	= nAINpcId;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nChatSec 	= nChatSec;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nRange 		= nRange;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nDialogNpcId = nDialogNpcId;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nDialogSec 	= nDialogSec;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.tbChat 		= tbChat;
		local nTimerId = Timer:Register(nDialogSec * Env.GAME_FPS, self.OnTimerFreeAI, self, pNpcDialog.dwId, 2);
		
		--Debug
		self._tbDebugFreeAITimer[nTimerId] 	 = pNpcDialog.dwId;
		self._tbDebugFreeAITimer2[pNpcDialog.dwId] = nTimerId;
		--Debug
		
		Npc.tbFreeAINpcList[pNpcDialog.dwId] = 1;
	end
	return 0;
end

--清空随机AINpc或DialogNpc;
--nNpcId：	清空npc的模版Id，如有对话npc，需AINpc和对话Npc都要清楚，没有填写npc模版Id默认为清空所有AINpc和对话Npc；
function Npc:OnClearFreeAINpc(nNpcId)
	if Npc.tbFreeAINpcList then
		for dwId in pairs(Npc.tbFreeAINpcList) do
			local pNpc = KNpc.GetById(dwId);
			if pNpc then
				if not nNpcId then
					pNpc.Delete();
				end
				
				if nNpcId and pNpc.nTemplateId == nNpcId then
					pNpc.Delete();
				end
			end
		end
	end
	return 0;
end

-- 获取等级数据
--	tbParam:{szAIParam, szSkillParam, szPropParam, szScriptParam}
function Npc:GetLevelData(szClassName, szKey, nSeries, nLevel, tbParam)
	-- 根据 szClassName 找到特定模板
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc[%s] not found！", szClassName));
		return 0;
	end;
	
	-- 尝试直接找到该类中的属性定义
	local tbData	= nil;
	
	if (szClassName == "") then
		tbClass	= {_tbBase=tbClass};
	end
	
	local tbBaseClasses	= {
		rawget(tbClass, "tbLevelData"),
		self.tbAIBase[tbParam[1]],
		self.tbSkillBase[tbParam[2]],
		self.tbPropBase[tbParam[3]],
		tbClass._tbBase and tbClass._tbBase.tbLevelData,
	};
	for i = 1, 5 do
		local tbBase	= tbBaseClasses[i];
		tbData	= tbBase and tbBase[szKey];
		if (tbData) then
			break;
		end;
	end;
	if (not tbData) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc[%s]:[%s] not found！", szClassName, szKey));
		return 0;
	end;
	if (type(tbData) == "function") then
		return tbData(nSeries, nLevel, tbParam[4]);
	else
		return Lib.Calc:Link(nLevel, tbData);
	end;
end;

-- 注册特定Npc死亡回调
function Npc:RegPNpcOnDeath(pNpc, ...)
	local tbPNpcData		= pNpc.GetTempTable("Npc");
	assert(not tbPNpcData.tbOnDeath, "too many OnDeath registrer on npc:"..pNpc.szName);
	tbPNpcData.tbOnDeath	= arg;
end;

-- 取消特定Npc死亡回调
function Npc:UnRegPNpcOnDeath(pNpc)
	pNpc.GetTempTable("Npc").tbOnDeath	= nil;
end;


-- 当Npc死亡掉落物品时回调
function Npc:DeathLoseItem(szClassName, pNpc, tbLoseItem)
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc[%s] not found！", szClassName));
		return 0;
	end;
	
	Setting:SetGlobalObj(me, pNpc, it);
	if (tbClass.DeathLoseItem) then
		tbClass:DeathLoseItem(tbLoseItem);
	end
	Setting:RestoreGlobalObj();
end