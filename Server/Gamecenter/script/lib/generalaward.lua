-- 通用奖励相关处理

-- 取得当前玩家对话相关的临时Table
function GeneralAward:GetMyAward()
	local tbPlayerData		= me.GetTempTable("GeneralAward");
	local tbPlayerAward		= tbPlayerData.tbAward;
	if (not tbPlayerAward) then
		tbPlayerAward	= {
		};
		tbPlayerData.tbAward	= tbPlayerAward;
	end;
	
	return tbPlayerAward;
end;

-- S
function GeneralAward:SendAskAward(szMsg, tbAwards, tbCallBack)
	local tbPlayerAward = self:GetMyAward();
	tbPlayerAward.tbAwards = tbAwards;
	tbPlayerAward.tbCallBack = tbCallBack;
	me.CallClientScript({"GeneralAward:AskAward", szMsg, tbAwards})
end;

-- C
--打开通用奖励面板
-- CallClientScript({"GeneralAward:AskAward", "奖励总描述", tbS2CAward})
function GeneralAward:AskAward(szMsg, tbAward)
	-- 弹奖励面板，用户选了以后会传给服务端
	me.SetChainTaskAward(tbAward)
	CoreEventNotify(UiNotify.emCOREEVENT_TASK_AWARD, 0, szMsg);		-- 0代表无任务ID的任务
end;

-- S
function GeneralAward:OnAward(nChoice)
	local tbPlayerAward		= self:GetMyAward().tbAwards;
	
	if (not tbPlayerAward) or (tbPlayerAward == {}) then
		return;
	end;
	
	self:GetMyAward().tbAwards = nil;
	if tbPlayerAward.tbOpt then
		if (nChoice < 0 or nChoice > #tbPlayerAward.tbOpt) then
			print("[GeneralAward]: award paramer error!")
			return;
		end
	end
	-- 可选奖励
	--print("Start Give tbOpt: "..nChoice);
	if (tbPlayerAward.tbOpt and tbPlayerAward.tbOpt[nChoice]) then
		self:GiveAward(tbPlayerAward.tbOpt[nChoice]);
	end;
	-- 固定奖励
	--print("Start Give tbFix!");
	for _, tbAward in pairs(tbPlayerAward.tbFix) do
		--print("Giving tbFix!");
		self:GiveAward(tbAward);
	end;
	-- 随机奖励
	if (tbPlayerAward.tbRandom) then
		local nRand	= MathRandom();
		local nSum	= 0;
		for _, tbAward in pairs(tbPlayerAward.tbRandom) do
			nSum	= nSum + tbAward.nRate;
			if (nSum > nRand) then
				self:GiveAward(tbAward);
				break;
			end
		end
	end
	
	if (self:GetMyAward().tbCallBack) then
		Lib:CallBack(self:GetMyAward().tbCallBack);
	end
end

--S
-- 给与一组奖励
function GeneralAward:GiveAward(tbAward)
--	print("给奖励",me.szName)
	local szType	= tbAward.szType;
	local varValue	= tbAward.varValue;
	local szStatLogName = tbAward.szStatLogName;
	local nNum		= tonumber(tbAward.szAddParam1) or 1;
	if (szType == "exp") then
		--越南防沉迷，david
		if (me.GetTiredDegree() == 1) then
			varValue = math.floor(varValue*0.5);
		end;
		
		me.AddExp(varValue);
		me.Msg("Bạn nhận được <color=green>"..varValue.."<color> điểm kinh nghiệm!");
		--KStatLog.ModifyAdd("LinkTask", me.szName, "获得总经验", varValue);
		
	elseif (szType=="linktask_cancel") then
		
		local nCancel = LinkTask:GetTask(LinkTask.TSK_CANCELNUM);
			nCancel = nCancel + 1;
			LinkTask:SetTask(LinkTask.TSK_CANCELNUM, nCancel);
			me.Msg("Bạn được 1 lần hủy nhiệm vụ, còn: <color=yellow>"..nCancel.."<color> lần hủy nhiệm vụ.");
			--KStatLog.ModifyAdd("LinkTask", me.szName, "选择取消机会次数", 1);
			
	elseif (szType == "money") then
		--越南防沉迷，david
		if (me.GetTiredDegree() == 1) then
			varValue = math.floor(varValue*0.5);
		end;
		
		me.Earn(varValue, Player.emKEARN_YIJUN);
		me.Msg("Bạn nhận được <color=yellow>"..varValue.."<color> lượng bạc!");
		--KStatLog.ModifyAdd("LinkTask", me.szName, "获得银两总数", varValue);
		--KStatLog.ModifyAdd("jxb", "[Nơi]任务链", "Tổng", varValue);
		if szStatLogName then
			KStatLog.ModifyAdd("jxb", "[Nơi]"..szStatLogName, "Tổng", varValue);
		end
	elseif (szType == "bindmoney") then
		--越南防沉迷，david
		if (me.GetTiredDegree() == 1) then
			varValue = math.floor(varValue*0.5);
		end;
		
		me.AddBindMoney(varValue, Player.emKBINDMONEY_ADD_YIJUN);
		me.Msg("Bạn nhận được <color=yellow>"..varValue.."<color> bạc khóa!");
		if szStatLogName then
			KStatLog.ModifyAdd("bindjxb", "[Nơi]"..szStatLogName, "Tổng", varValue);
		end
--		KStatLog.ModifyAdd("jxb", "[Nơi]任务链", "Tổng", varValue);
				
	elseif (szType == "linktask_repute") then
		--越南防沉迷，david
		if (me.GetTiredDegree() == 1) then
			varValue[3] = math.floor(varValue[3]*0.5);
		end;
		
		me.AddRepute(unpack(varValue));
		me.Msg("Danh vọng trong nghĩa quân đã tăng <color=green>"..varValue[3].."<color> điểm!");
		
	elseif (szType == "title") then
		--AddTitle(unpack(tbAward.varValue))
	elseif (szType == "taskvalue") then
		me.SetTask(unpack(varValue));
	elseif (szType == "item") then
		for i=1, nNum do
			self:AddItem(me, varValue);
		end
		me.Msg(string.format("Bạn nhận được %s vật phẩm thưởng!", nNum));
		
	elseif (szType == "gatherpoint") then
		--越南防沉迷，david
		if (me.GetTiredDegree() == 1) then
			varValue = math.floor(tonumber(varValue)*0.5);
		end;
		
		TaskAct:AddGatherPoint(tonumber(varValue));
		me.Msg("Bạn nhận được <color=green>"..varValue.."<color> điểm hoạt lực!");
		
	elseif (szType == "makepoint") then
		--越南防沉迷，david
		if (me.GetTiredDegree() == 1) then
			varValue = math.floor(varValue*0.5);
		end;
		
		TaskAct:AddMakePoint(tonumber(varValue));
		me.Msg("Bạn nhận được <color=green>"..varValue.."<color> điểm tinh lực!");
		
	elseif (szType == "arrary") then
		for _, tbOneAward in ipairs(varValue) do
			self:GiveAward(tbOneAward);
		end;
	end;
end;


-- 加物品
function GeneralAward:AddItem(pPlayer, tbItemId)
	local tbId	= {unpack(tbItemId)};
	if (tbId[4] == 0) then
		tbId[4]	= 1;
	end;
	if (tbId[5] == -1) then
		tbId[5]	= 0;
	end;
	tbId[7]		= tbId[6];
	tbId[6]		= 0;
	tbId[8]		= 0;
	tbId[9]		= 0;
	tbId[10]	= 0;
	
	local nBind = 0;
	if tbId[11] then
		nBind = tbId[11];
		table.remove(tbId, 11);
	end;
	
	local pItem = pPlayer.AddItem(unpack(tbId));
	
	if nBind ~= 0 then
		pItem.Bind(nBind);
	end;
	return pItem;
end;
