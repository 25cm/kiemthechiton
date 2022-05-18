-- 黑屏模式，希望不會給任務系統帶來黑色的天空...

-- S
-- 黑屏模式下的回掉函數
function BlackSky:GetDarkData()
	local tbPlayerData		= me.GetTempTable("Task");
	local tbPlayerDarkData	= tbPlayerData.tbDarkData;
	if (not tbPlayerDarkData) then
		tbPlayerDarkData	= {};
		tbPlayerData.tbDarkData	= tbPlayerDarkData;
	end;
	
	return tbPlayerDarkData;
end


-- S
-- 通知客戶端，讓其黑屏，並把回調函數存入臨時Table
function BlackSky:SendDarkCommand(pPlayer, tbParam)
	if (not tbParam) then
		assert(false);
		return;	
	end
	
	if (pPlayer.nId ~= me.nId) then
		Dbg:WriteLog("Task", "Player ID Error In Dark[2]!", pPlayer.nId, me.nId);
	end
	
	local tbPlayerDarkData	= self:GetDarkData();
	local nInDark = tbPlayerDarkData.nInDark or 0;
	if (tbPlayerDarkData.tbParam) then
		assert(false or "Màn hình đen bên trên chưa xử lý xong, không nên mở nhiều cái cùng một lúc");
		return;
	end
	tbPlayerDarkData.tbParam = tbParam;
	tbPlayerDarkData.tbGRoleArgs = {player = pPlayer};
	tbPlayerDarkData.nDarkPlayerId = pPlayer.nId;
	KTask.SetBlackSky(pPlayer, 1);	-- 通知客戶端開啟黑屏模式
	
	-- 若此時為黑屏模式則不用等協議了，直接執行。
	-- 協議到的時候因為tbPlayerDarkData.tbParam為空所以不會執行任何操作
	if (nInDark == 1) then
		self:WhenEvnChange(pPlayer, 1);
	end
end

-- S
-- 孤立的Talk對話回調,它封裝了關閉的過程，沒有回調，若有回調要主動關閉
function BlackSky:SimpleTalk(pPlayer, szMsg, ...)
	self:SendDarkCommand(pPlayer, {TaskAct.NormalTalk, TaskAct, szMsg, self.GiveMeBright, self, pPlayer, unpack(arg)});
end

-- S
-- 孤立的Say對話回調，它封裝了關閉過程，沒有回掉，若有回掉要主動關閉
function BlackSky:SimpleSay(pPlayer, szMsg, ...)
	if (arg.n <= 0) then
		local tbOpt = { "Kết thúc đối thoại", self.GiveMeBright, self, pPlayer};
		self:SendDarkCommand(pPlayer, {Dialog.NormalSay, Dialog, szMsg, tbOpt});
	elseif (type(arg[1][1]) == "table") then
		local tbOpt = {};
		for _, item in pairs(arg[1]) do
			if (type(item) == "table") then
				local szDesc = item[1];
				local tbTemp = {};
				for i = 2, #item do
					tbTemp[i-1] = item[i];
				end
				if (type(szDesc) == "string") then
					table.insert(tbOpt, #tbOpt+1, {szDesc, self.GiveMeBright, self, pPlayer, unpack(tbTemp)});	
				end
			end
		end
		self:SendDarkCommand(pPlayer, {Dialog.NormalSay, Dialog, szMsg, tbOpt}); 
	else	-- 3、每一個參數一個選項，一共N個參數
		local tbOpt = {};
		for _, item in pairs(arg) do
			if (type(item) == "table") then
				local szDesc = table.remove (item, 1);
				if (type(szDesc) == "string") then
					table.insert(tbOpt, #tbOpt+1, {szDesc, self.GiveMeBright, self, pPlayer, unpack(item)});
				end
			end
			if (not tbOpt[1]) then
				tbOpt[1] = {"Kết thúc đối thoại test", self.GiveMeBright, self, pPlayer};
			end
			self:SendDarkCommand(pPlayer, {Dialog.NormalSay, Dialog, szMsg, unpack(tbOpt)});
		end 
	end;
end

-- S
-- 服務端收到黑屏完成的操作，執行回調函數,並清空它。或者收到黑屏結束
function BlackSky:WhenEvnChange(nDark)
	local tbPlayerDarkData = self:GetDarkData();
	
	if (not tbPlayerDarkData or not tbPlayerDarkData.tbGRoleArgs or not tbPlayerDarkData.tbGRoleArgs.player) then
		return;
	end
	
	if (tbPlayerDarkData.tbGRoleArgs.player.nId ~= me.nId) then
		Dbg:WriteLog("Task", "Player ID Error In Dark[2]!", pPlayer.nId, me.nId);
	end
	
	if (nDark == 1) then
		tbPlayerDarkData.nInDark = 1;
		if (not tbPlayerDarkData or not tbPlayerDarkData.tbParam) then
			return;
		end
		
		if(tbPlayerDarkData.nDarkPlayerId ~= tbPlayerDarkData.tbGRoleArgs.player.nId) then
			Dbg:WriteLog("Task", "Player ID Error In Dark!", tbPlayerDarkData.nDarkPlayerId, tbPlayerDarkData.tbGRoleArgs.player.nId);
		end
		tbPlayerDarkData.nDarkPlayerId = nil;
		
		local tbDarkData = tbPlayerDarkData.tbParam;
		local oldme = me;
		me = tbPlayerDarkData.tbGRoleArgs.player;
		if (tbDarkData) then
			Lib:CallBack(tbDarkData);
		end
		
		tbPlayerDarkData.tbParam = nil;
		me = oldme;
	elseif (nDark == 0) then
		tbPlayerDarkData.nInDark = 0;	
	end
end


-- S
-- 服務端主動結束黑屏
function BlackSky:GiveMeBright(pPlayer, ...)
	KTask.SetBlackSky(pPlayer, 0);
	local oldme = me;
	me = pPlayer;
	if (arg.n > 0) then
		Lib:CallBack(arg);
	end
	me = oldme;
end


-- C
-- 客戶端全黑並且向服務端發送指定協議
function BlackSky:BeginDark()
	Ui(Ui.UI_GUTMODEL):GutBegin(self, self.CompleteDardCallBack);
end

-- C
-- 客戶端接到停止黑屏的協議
function BlackSky:EndDark()
	Ui(Ui.UI_GUTMODEL):GutEnd(self, self.InBright);
end


-- C
-- 當客戶端全黑的時候的回調函數
function BlackSky:CompleteDardCallBack()
	KTask.SendEnvCallBack(me, 1);
end


-- C
-- 當客戶端黑屏結束的時候回掉函數
function BlackSky:InBright()
	KTask.SendEnvCallBack(me, 0);
end

-- 客戶端加上黑暗光環
function BlackSky:OnCoverBegin()
	CoreEventNotify(UiNotify.emCOREEVENT_COVER_BEGIN);
end;

-- 客戶端去除黑暗光環
function BlackSky:OnCoverEnd()
	CoreEventNotify(UiNotify.emCOREEVENT_COVER_END);
end;
