-- code by jzw
-- modify by zy

--?? DoScript("\\ui\\youlong.lua")
-- Youlongmibao.tbYoulongG:SwitchState()
-- ?? Youlongmibao.tbYoulongG:PrintAwardHistory()

Youlongmibao.tbYoulongG = Youlongmibao.tbYoulongG or {};
local tbYoulongG = Youlongmibao.tbYoulongG;


tbYoulongG.tbDate = tbYoulongG.tbDate or {};
tbYoulongG.nTimerId = tbYoulongG.nTimerId or 0;
tbYoulongG.tbItem = tbYoulongG.tbItem or {{18,1,524,0}};
tbYoulongG.szLastMsg  = tbYoulongG.szLastMsg or "";
tbYoulongG.tbAwardHistory = tbYoulongG.tbAwardHistory or {};
tbYoulongG.nStartTime = tbYoulongG.nStartTime or 0;

tbYoulongG.Msg=function(self, szMsg)
--function tbYoulongG:Msg(szMsg)
	if tbYoulongG.szLastMsg == szMsg then
		return;
	end
	me.Msg(szMsg);
	tbYoulongG.szLastMsg = szMsg;
end

tbYoulongG.SwitchState=function(self)
--function tbYoulongG:SwitchState()
	if self.nTimerId > 0 then
		self:Stop();
	else
		self:OnStart();
	end
end

tbYoulongG.OnStart=function(self)
--function tbYoulongG:OnStart()
	print("Bắt đầu auto")
	self.nStartTime = GetTime();
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId >1692 or nMyMapId < 1665) then
		me.Msg("Tới mật thất mới chạy được auto");
		return;
	end
	self = tbYoulongG;
	self:ReadFile();
	if (self.nTimerId == 0) then
		self.nTimerId = Timer:Register(1 * Env.GAME_FPS, self.OnTimer, self);
	end	
end

tbYoulongG.Stop=function(self)
--function tbYoulongG:Stop()
	self:PrintAwardHistory();
	self.tbAwardHistory = {};
	Timer:Close(Youlongmibao.tbYoulongG.nTimerId);
	self.nTimerId = 0;
	self.nStartTime = 0;
end

tbYoulongG.CheckUsefulItem=function(self)
--function tbYoulongG:CheckUsefulItem()
	local tbItemList = {};
	local tbItemObjList = {};
	local uiYoulongmibao = Ui(Ui.UI_YOULONGMIBAO);
	for i = 1, uiYoulongmibao.GRID_COUNT - 1 do
		if uiYoulongmibao.tbGridCont[i] and uiYoulongmibao.tbGridCont[i]:GetObj() then
			local pItem = uiYoulongmibao.tbGridCont[i]:GetObj().pItem;
			if pItem then
				local szId = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel);
				tbItemList[szId] = (tbItemList[szId] or 0) + 1;
				tbItemObjList[szId] = pItem;
			end
		end
	end
	for szId, nCount in pairs(tbItemList) do
		if nCount >= self.tbDate[szId][3] and self.tbDate[szId][3] > 0 then
			local pItem = tbItemObjList[szId];
			self:Msg(string.format("<color=gray>Đã tìm thấy %s:%d/%d tiếp tục, đóng<color>", pItem.szName, tbItemList[szId], self.tbDate[szId][3]));
			return 1;
		end
	end
	self:Msg("Quá xui ,AG")
	return 0;
end

tbYoulongG.OnTimer=function(self)
--function tbYoulongG:OnTimer()
	print("Đi tiếp")
	local uiGutAward = Ui(Ui.UI_YOULONGMIBAO);
	local nState = 0;
	if self:FindItem() == 0 and uiGutAward.nState ~= 1 and uiGutAward.nState ~= 4 then
		me.Msg("Không phải");
		self:Stop();
		return 0;
	end	
	if UiManager:WindowVisible(Ui.UI_YOULONGMIBAO) == 1 then	--ѡ����
		if uiGutAward.nState == 1 then
			uiGutAward.OnButtonClick(uiGutAward,"BtnGetAward");
		elseif uiGutAward.nState == 2 then
			if self:CheckUsefulItem() == 1 then
				uiGutAward.OnButtonClick(uiGutAward,"BtnContinue");
			else
				uiGutAward.OnButtonClick(uiGutAward,"BtnRestart");
			end
		elseif uiGutAward.nState == 3 then
			uiGutAward.OnButtonClick(uiGutAward,"BtnRestart");
		elseif uiGutAward.nState == 4 then
			if self:GetAward() == 1 then
				uiGutAward.OnButtonClick(uiGutAward,"BtnConfirmAward");
			else
				uiGutAward.OnButtonClick(uiGutAward,"BtnChangeCoin");
			end
			nState = 1;
		end
	else
		local nId = self:GetAroundNpcId(3690);
		if nId then
			--������
			me.CallServerScript({"ApplyYoulongmibaoRestart"});			
		end
	end
	self:AutoUseItem();
end


tbYoulongG.Split=function(self, szFullString, szSeparator)
--function tbYoulongG:Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
	    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
	    break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

tbYoulongG.AutoUseItem=function(self)
--function tbYoulongG:AutoUseItem()
	for szId, tbRow in pairs(self.tbDate) do
		if (tbRow[4] == 1) then
			local G, D, P, L = unpack(self:Split(szId, ","));			
			local tbItems = me.FindItemInBags(tonumber(G), tonumber(D), tonumber(P), tonumber(L));
			if #tbItems ~= 0 then
				me.UseItem(tbItems[1].nRoom, tbItems[1].nX, tbItems[1].nY);
				return;
			end
		end
	end
end


--function tbYoulongG:FindItem()
tbYoulongG.FindItem=function(self)	
	local tbFind = nil;
	for i = 1, #self.tbItem do
		tbFind =  me.FindItemInAllPosition(unpack(self.tbItem[i]));
		if #tbFind > 0 then
			return 1;
		end
	end
	return 0;	
end

--function tbYoulongG:GetAward()
tbYoulongG.GetAward=function(self)
	--me.Msg("���ɽ���");
	local pItem = Ui(Ui.UI_YOULONGMIBAO).tbGridCont[26]:GetObj().pItem;
	if pItem then
		local szId = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel);
		self.tbAwardHistory[pItem.szName] = (self.tbAwardHistory[pItem.szName] or 0) + 1;
		if self.tbDate[szId] then
			if self.tbDate[szId][1] == 1 then
				self:Msg("<color=gray>Phần thưởng : " .. pItem.szName);
			else
				self:Msg("<color=gray>Đổi tiền : " .. pItem.szName);
			end
			return self.tbDate[szId][1];
		end
	end
	self:Msg("Mặc định khen thưởng :" .. pItem.szName);
	return 1;
end

--function tbYoulongG:PrintAwardHistory()
tbYoulongG.PrintAwardHistory=function(self)
	local nTotalCount = 0;
	local nTime = GetTime() - self.nStartTime;
	local nHours = math.floor(nTime / 3600);
	local nMinutes = math.floor(nTime % 3600 / 60);
	local nSeconds = math.floor(nTime % 60);
	local szTime = string.format("%d:%d:%d", nHours, nMinutes, nSeconds);
	me.Msg("Kết quả");
	for szName, nCount in pairs(self.tbAwardHistory) do
		me.Msg(string.format("%s:%d个", szName, nCount));
		nTotalCount = nTotalCount + nCount;
	end
	me.Msg(string.format("Tổng số:%d tháng , sử dụng:%s, một thời gian nhất định:%d giây", nTotalCount, szTime, nTime / nTotalCount));
end

--function tbYoulongG:GetAroundNpcId(nTempId)
tbYoulongG.GetAroundNpcId=function(self, nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex;
		end
	end
	return;
end

--function tbYoulongG:ReadFile()
tbYoulongG.ReadFile=function(self)
	local tbFile = Lib:LoadTabFile("\\interface\\DuLong\\youlongmibao.txt");
	if not tbFile then
		print("Lỗi các tập tin không tồn tại",szFileName);
		return;
	end
	for nId, tbParam in ipairs(tbFile) do
		if nId >= 1 then
			local szName = tbParam.Name or "";
			local szId = tbParam.Id or "";
			local nDuiHuan = tonumber(tbParam.DuiHuan) or 1;
			local nUseful = tonumber(tbParam.Useful) or 1;
			local nAutoUse = tonumber(tbParam.AutoUse) or 0;
			if not self.tbDate then
				self.tbDate = {};
			end
			if szName ~= "" and szId ~= "" and nDuiHuan then				
				if string.find(szId, '"') then
					local nEnd = string.len(szId);
					if (nEnd) then
						szId = string.sub(szId, 2, nEnd-1);
					end					
				end
				self.tbDate[szId] = { nDuiHuan, szName, nUseful, nAutoUse}; 
			end
		end
	end
	local tbStr = {"Phần thưởng", "Tiền du long"}
	for szId,tbItem in pairs(self.tbDate) do
		local nFlag = 2 - tbItem[1];	
		me.Msg(string.format("<color=yellow>[������]<color><color=pink>%s<color>%s",tbItem[2], tbStr[nFlag]));		
	end	
end

--------ע�ᰴ��
local tCmd={ "Youlongmibao.tbYoulongG:SwitchState()", "SwitchState", "", "CTRL+Y", "CTRL+Y", "Tự động đi du long"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	-----��ݼ�CTRL+Y
