
local uiCompose = Ui:GetClass("compose");

local BTN_TYPE		= {"BtnUnbind","BtnBind","BtnMixed"};
local BTN_RESET		= "BtnReset";
local BTN_COMPOSE	= "BtnCompose";
local BTN_CLOSE		= "BtnClose";
local EDIT_LEVEL	= "EdtLevel";
local BTN_SHEZHI			= "BtnShezhi";
local EDIT_NUM		= {"EdtNum1","EdtNum2","EdtNum3","EdtNum4","EdtNum5","EdtNum6","EdtNum7","EdtNum8"};

uiCompose.nTimer = 0;
local nCount={};
local nType = 2;
local nLevel = 5;
local Num = {13,0,6,2,4,0,2,3};

function uiCompose:OnOpen(nParam)
	local szData = KFile.ReadTxtFile("\\user\\compose_HT\\"..me.szName.."_compose.txt");
	if szData then
		local tbSplit = Lib:SplitStr(szData, "#^@");
		if tbSplit[1] then
			nType = tonumber(tbSplit[1])-1;
		end
		if tbSplit[2] then
			nLevel = tonumber(tbSplit[2]);
		end
		for i = 1, #Num do
			Num[i] = tonumber(tbSplit[i+2]);
		end
	end
	self:UpdateInt(Num);
	self:UpdateButton(nType,self.nTimer);
end

function uiCompose:UpdateInt(Num)
	Edt_SetInt(self.UIGROUP, EDIT_LEVEL, nLevel);
	for i = 1, #EDIT_NUM do
		Edt_SetInt(self.UIGROUP, EDIT_NUM[i], Num[i]);
	end
end

function uiCompose:UpdateButton(nType,nTimer)
	for i = 1, #BTN_TYPE do
		Btn_Check(self.UIGROUP, BTN_TYPE[i], 0);
	end
	Btn_Check(self.UIGROUP, BTN_TYPE[nType+1], 1);
	if self.nTimer == 0 then
		Btn_SetTxt(self.UIGROUP, BTN_COMPOSE, "Bắt đầu");
	else
		Btn_SetTxt(self.UIGROUP, BTN_COMPOSE, "Ngừng");
	end
end

function uiCompose:OnClose()
	local nLevel = Edt_GetInt(self.UIGROUP, EDIT_LEVEL);
	local szData = tostring((nType+1)).."#^@"..tostring(nLevel);
	local Num = {};
	for i = 1, #EDIT_NUM do
		Num[i] = Edt_GetInt(self.UIGROUP, EDIT_NUM[i]);
		szData = szData.."#^@"..tostring(Num[i]);
	end
	KFile.WriteFile("\\user\\compose_HT\\"..me.szName.."_compose.txt", szData);
end

function uiCompose:OnEditChange(szWnd, nParam)
	if (szWnd == EDIT_LEVEL) then
		nLevel = Edt_GetInt(self.UIGROUP, EDIT_LEVEL);
		if nLevel > 11 then
			Edt_SetInt(self.UIGROUP, EDIT_LEVEL, 11);
		end
	else
		for i = 1, #EDIT_NUM do
			if szWnd == EDIT_NUM[i] then
				local Num = {};
				nLevel = Edt_GetInt(self.UIGROUP, EDIT_LEVEL);
				Num[i] = Edt_GetInt(self.UIGROUP, EDIT_NUM[i]);
				if nLevel < 2 then
					Edt_SetInt(self.UIGROUP, EDIT_LEVEL, 2);
				end
				if math.floor(i/2) < (i/2) then
					Num[i+1] = Edt_GetInt(self.UIGROUP, EDIT_NUM[i+1]);
					if Num[i] == 0 and Num[i+1] ~= 0 then
						Edt_SetInt(self.UIGROUP, EDIT_NUM[i+1], 0);
					elseif Num[i] > 16-Num[i+1] then
						Edt_SetInt(self.UIGROUP, EDIT_NUM[i], 16-Num[i+1]);
					end
				elseif math.floor(i/2) == (i/2) then
					Num[i-1] = Edt_GetInt(self.UIGROUP, EDIT_NUM[i-1]);
					if Num[i-1] == 0 and Num[i] ~= 0 then
						Edt_SetInt(self.UIGROUP, EDIT_NUM[i], 0);
					elseif Num[i] > 16-Num[i-1] then
						Edt_SetInt(self.UIGROUP, EDIT_NUM[i], 16-Num[i-1]);
					end
				end
			end
		end
	end
end

function uiCompose:ScrReload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\GhepHT\\Compose.lua");
	me.Msg("<color=blue>Tự động tải lại hoàn thành! ");
end

function uiCompose:OnButtonClick(szWnd, nParam)
	if szWnd == BTN_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == BTN_SHEZHI) then
           uiCompose.ScrReload();
	elseif szWnd == BTN_COMPOSE then
		self:SwitchCompose();
		self:UpdateButton(nType,self.nTimer);
	elseif szWnd == BTN_RESET then
		self:Reset();
	else
		for i = 1, #BTN_TYPE do
			if szWnd == BTN_TYPE[i] then
				nType = i-1;
			end
		end
		self:UpdateButton(nType,self.nTimer);
	end
end

function uiCompose:PreCompose()
	if UiManager:WindowVisible(Ui.UI_COMPOSE) == 1 then
		nLevel = Edt_GetInt(self.UIGROUP, EDIT_LEVEL);
		for i = 1, #EDIT_NUM do
			Num[i] = Edt_GetInt(self.UIGROUP, EDIT_NUM[i]);
			if math.floor(i/2) < (i/2) and Num[i] == 0 then
				Num[i] = 1000;
			end
		end
	else
		local szData = KFile.ReadTxtFile("\\user\\compose_HT\\"..me.szName.."_compose.txt");
		if szData then
			local tbSplit = Lib:SplitStr(szData, "#^@");
			if tbSplit[1] then
				nType = tonumber(tbSplit[1])-1;
			end
			if tbSplit[2] then
				nLevel = tonumber(tbSplit[2]);
			end
			for i = 1, #Num do
				Num[i] = tonumber(tbSplit[i+2]);
				if math.floor(i/2) < (i/2) and Num[i] == 0 then
					Num[i] = 1000;
					Num[i+1] = 1000;
				end
			end
		end
	end
end

function uiCompose:Reset()
	nType = 2;
	nLevel = 5;
	Num = {3,0,3,0,3,0,3,0};
	self.nTimer = 0;
	self:UpdateInt(Num);
	self:UpdateButton(nType,self.nTimer);
end
------------------------------------------------------------
function uiCompose:SwitchCompose()
	if self.nTimer == 0 then
		self:PreCompose();
		me.Msg("<color=yellow>Bắt đầu ghép Huyền Tinh");
		self.nTimer = Timer:Register(1 * Env.GAME_FPS,self.Hexuan,self,nType,nLevel,Num);
	else
		Timer:Close(self.nTimer);
		self.nTimer = 0;
		me.Msg("<color=yellow>Ngừng ghép Huyền Tinh");
	end
end

function uiCompose:Hexuan(n,l,Num)
	local nMoneyType = Item.BIND_MONEY;
	if n == 0 or me.GetBindMoney()< 10000 then
		nMoneyType = Item.NORMAL_MONEY;
	end
	if self:CanCompose(n,l,Num) == 1 then
		if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then
			for i=1,l do
				if (Num[2] == 0 and nCount[i] >= Num[1] and i<= l) or (Num[2] > 0 and (i+1)<= l and nCount[i] >= Num[1] and nCount[i+1] >= Num[2]) then
					--me.Msg(Num[1].." viên Huyền Tinh cấp "..i.." + "..Num[2].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[1]);
					self:PutXuanjing(i+1,n,Num[2]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				elseif (Num[4] == 0 and nCount[i] >= Num[3] and i<= l) or (Num[4] > 0 and (i+1)<= l and nCount[i] >= Num[3] and nCount[i+1] >= Num[4]) then
					--me.Msg(Num[3].." viên Huyền Tinh cấp "..i.." + "..Num[4].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[3]);
					self:PutXuanjing(i+1,n,Num[4]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				elseif (Num[6] == 0 and nCount[i] >= Num[5] and i<= l) or (Num[6] > 0 and (i+1)<= l and nCount[i] >= Num[5] and nCount[i+1] >= Num[6]) then
					--me.Msg(Num[5].." viên Huyền Tinh cấp "..i.." + "..Num[6].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[5]);
					self:PutXuanjing(i+1,n,Num[6]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				elseif (Num[8] == 0 and nCount[i] >= Num[7] and i<= l) or (Num[8] > 0 and (i+1)<= l and nCount[i] >= Num[7] and nCount[i+1] >= Num[8]) then
					--me.Msg(Num[7].." viên Huyền Tinh cấp "..i.." + "..Num[8].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[7]);
					self:PutXuanjing(i+1,n,Num[8]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				end
			end
		else
			me.Msg("Chuẩn bị ghép Huyền tinh ...");
			self:GotoYelian(nMoneyType);
			return;
		end
	else
		if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then
			UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE);
			UiManager:CloseWindow(Ui.UI_ITEMBOX);
			me.Msg("<color=green>Ghép Huyền Tinh đã hoàn thành.");
		else
			if me.nMapId <= 0 then 
				return; 
			end
			me.Msg("<color=green>Không có đủ Huyền Tinh để ghép");
		end
		if self.nTimer ~= 0 then
			Timer:Close(self.nTimer);
			self.nTimer = 0;
		end
		self:UpdateButton(nType,self.nTimer);
		return 0;
	end
end


function uiCompose:CanCompose(n,l,Num)
	local can = 0;
	for i = 1, l do
		if n == 0 then
			nCount[i] = me.GetItemCountInBags(18,1,1,i,-1,0);
			--me.Msg("<color=yellow>Huyền Tinh cấp "..i.." (không khóa) có: <color><color=green>"..nCount[i].." viên<color>");
		elseif n == 1 then
			nCount[i] = me.GetItemCountInBags(18,1,114,i);
			nCount[i] = nCount[i] + me.GetItemCountInBags(18,1,1,i,-1,1);
			--me.Msg("<color=yellow>Huyền Tinh cấp "..i.." (khóa) có: <color><color=green>"..nCount[i].." viên<color>");
		elseif n == 2 then
			nCount[i] = me.GetItemCountInBags(18,1,1,i,-1,0);
			nCount[i] = nCount[i] + me.GetItemCountInBags(18,1,1,i,-1,1);
			nCount[i] = nCount[i] + me.GetItemCountInBags(18,1,114,i);
			--me.Msg("<color=yellow>Huyền Tinh cấp "..i.." có: <color><color=green>"..nCount[i].." viên<color>");
		end
	end
	for i = 1, l do
		if (Num[2] == 0 and nCount[i] >= Num[1] and i<= l) or (Num[2] > 0 and (i+1)<= l and nCount[i] >= Num[1] and nCount[i+1] >= Num[2]) then
			can = 1;
		end
		if (Num[4] == 0 and nCount[i] >= Num[3] and i<= l) or (Num[4] > 0 and (i+1)<= l and nCount[i] >= Num[3] and nCount[i+1] >= Num[4]) then
			can = 1;
		end
		if (Num[6] == 0 and nCount[i] >= Num[5] and i<= l) or (Num[6] > 0 and (i+1)<= l and nCount[i] >= Num[5] and nCount[i+1] >= Num[6]) then
			can = 1;
		end
		if (Num[8] == 0 and nCount[i] >= Num[7] and i<= l) or (Num[8] > 0 and (i+1)<= l and nCount[i] >= Num[7] and nCount[i+1] >= Num[8]) then
			can = 1;
		end
	end
	return can;
end


function uiCompose:GotoYelian(nMoneyType)
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then
		return;
	end
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	local n = 1;
	if nMoneyType == Item.NORMAL_MONEY then
		n = 2;
	end
	if (me.nMapId <30 and me.nMapId >22) or (me.nMapId <9 and me.nMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..me.nMapId..",3574,1,"..n});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3574,1,"..n});
	end
end


function uiCompose:PutXuanjing(l,n,count)
	local k = 0;
	if count == 0 then
		return;
	end
	for nCont = 1, 11 do
		for j = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nLine - 1 do
			for i = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRow - 1 do
--			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j)
			--local pItem = me.GetMainBagItem(i,j);
				local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].tbObjs[j][i]
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1
							Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont]:UseObj(tbObj,i,j)
							if k >= count then
								return 1
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1
							Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont]:UseObj(tbObj,i,j)
							if k >= count then
								return 1
							end
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1;
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return;
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1;
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1;
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return;
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1;
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1;
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return;
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1;
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end
	return 0;
end


Ui:RegisterNewUiWindow("UI_COMPOSE", "compose", {"a", 250, 150}, {"b", 400, 200}, {"c", 500, 250});

local tCmd={ [[
		if UiManager:WindowVisible(Ui.UI_COMPOSE) == 0 and Ui(Ui.UI_COMPOSE).nTimer == 0 then
			UiManager:OpenWindow(Ui.UI_COMPOSE);
		elseif UiManager:WindowVisible(Ui.UI_COMPOSE) == 1 and Ui(Ui.UI_COMPOSE).nTimer == 0 then
			UiManager:CloseWindow(Ui.UI_COMPOSE);
		end
	]], "UI_COMPOSE", "", "Shift+X", "Shift+X", "Ghép HT"};
        AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
LoadUiGroup(Ui.UI_COMPOSE, "compose.ini");