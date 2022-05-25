
local uiEquipEnhance 	= Ui:GetClass("equipenhance");
local tbObject   		= Ui.tbLogic.tbObject;
local tbMouse    		= Ui.tbLogic.tbMouse;
local tbTempItem 		= Ui.tbLogic.tbTempItem;

local TXT_TITLE			= "TxtTitle";
local TXT_MESSAGE		= "TxtMessage";
local BTN_CONFIRM		= "BtnOk";
local BTN_CLOSE			= "BtnClose";
local BTN_CANCEL		= "BtnCancel";
local IMG_EFFECT		= "ImgEffect";
local OBJ_EQUIP			= "ObjEquip";
local OBJ_ENHITEM		= "ObjEnhItem";
local OBJ_PREVIEW		= "ObjPreview";
local OBJ_PRE_REFINE	= "ObjPreRefine";
local LIST_MAGIC_SELECT = "LstMagicSelect";
local BTN_SELECTEQUIP	= "BtnSelectEquip";

local PREVIEW_WIDTH		= 4;
local PREVIEW_HEIGHT	= 4;

local ENHITEM_CLASS		= "xuanjing";		-- 强化道具类型：玄晶
local ENHANCE_DISCOUNT	= "enhancediscount";	--强化道具类型：强化优惠符
local ENHITEM_INDEX		= { nGenre = Item.SCRIPTITEM, nDetail = 1, nParticular = 114 };	-- 玄晶
uiEquipEnhance.pTempItem = nil;	
local tbUnUseItem = {};
local bRecastItemBindType = 0;

local MODE_TEXT = 
{ 
	[Item.ENHANCE_MODE_ENHANCE] 	= "Cường hóa trang bị", 
	[Item.ENHANCE_MODE_PEEL] 		= "Tách Huyền Tinh", 
	[Item.ENHANCE_MODE_COMPOSE]	 	= "Ghép Huyền Tinh",
	[Item.ENHANCE_MODE_UPGRADE] 	= "Nâng cấp Ấn giám",
	[Item.ENHANCE_MODE_REFINE]		= "Luyện hóa trang bị",
	[Item.ENHANCE_MODE_STRENGTHEN] 	= "Cải tạo trang bị",
};

function uiEquipEnhance:Init()
	self.nMode		      	= Item.ENHANCE_MODE_NONE;
	self.tbTempItem 	  	= {};
	self.bShowBindMsg		= 0;
	self.bShowTimeMsg		= 0;
	self.nMoneyEnoughFlag 	= 0;
	self.bShowWarnning 		= 1;
	-- by zhangjinpin@kingsoft
	self.bShowLowForbidden 	= 0;
	self.bShowHighForbidden = 0;
end

local tbEquipCont 	= { bUse = 0, nRoom = Item.ROOM_ENHANCE_EQUIP, bSendToGift = 1 };
local tbEnhItemCont = { bUse = 0, nRoom = Item.ROOM_ENHANCE_ITEM, bSendToGift = 1 };
local tbPreviewCont = { bUse = 0, bLink = 0, bSwitch = 0, bShowCd = 0, bSendToGift = 1 };
local tbPreRefineCont = { bUse = 0, bLink = 0, bSwitch = 0, bShowCd = 0, bSendToGift = 1 };

function tbEquipCont:CheckSwitchItem(pDrop, pPick, nX, nY)
	
	Ui(Ui.UI_EQUIPENHANCE):UpdateList(pDrop);
	if (not pDrop) then
		return	1;				-- 只是把东西拿出来，总是成功
	end

	if (self.nMode == Item.ENHANCE_MODE_COMPOSE) then
		me.Msg("Ghép Huyền Tinh, không được để gì vào ô này!");
		return 0;
	end
	
	if (1 ~= pDrop.IsEquip()) then
		me.Msg("Chỉ được bỏ trang bị cần " .. MODE_TEXT[self.nMode] .. " vào!");
		return 0;
	end

	if (self.nMode == Item.ENHANCE_MODE_ENHANCE) then		-- 处于强化操作状态
		if (1 == pDrop.IsWhite()) then
			me.Msg("Vật phẩm này không thể cường hóa!");
			return 0;
		end
		if (pDrop.nEnhTimes >= Item:CalcMaxEnhanceTimes(pDrop)) then
			me.Msg("Trang bị đã cường hóa tối đa!");
			return 0;
		end
		if (pDrop.nDetail < Item.MIN_COMMON_EQUIP) or (pDrop.nDetail > Item.MAX_COMMON_EQUIP) then
			me.Msg("Chỉ có thể cường hóa trang bị kích hoạt ngũ hành!");
			return 0;
		end
	elseif (self.nMode == Item.ENHANCE_MODE_PEEL) then		-- å¤„äºŽå‰¥ç¦»æ“ä½œçŠ¶æ€
		if (1 == pDrop.IsWhite()) then
			me.Msg("Không thể tách vật phẩm này!");
			return 0;
		end
		if (pDrop.nEnhTimes <= 0) then
			me.Msg("Không thể tách vật phẩm chưa cường hóa!");
			return 0;
		end
		if (pDrop.nDetail < Item.MIN_COMMON_EQUIP) or (pDrop.nDetail > Item.MAX_COMMON_EQUIP) then
			me.Msg("Chỉ được tách trang bị kích hoạt ngũ hành!");
			return 0;
		end
	elseif (self.nMode == Item.ENHANCE_MODE_UPGRADE) then
		if (pDrop.nDetail ~= Item.EQUIP_SIGNET) then
			me.Msg("Chỉ được bỏ Ấn vào để nâng cấp")
			return 0;
		end
	elseif (self.nMode == Item.ENHANCE_MODE_STRENGTHEN) then
		if (1 == pDrop.IsWhite()) then
			me.Msg("Không thể cải tạo vật phẩm này!");
			return 0;
		end
		if (pDrop.nEnhTimes <= 0) then
			me.Msg("Không thể cải tạo trang bị chưa cường hóa!");
			return 0;
		end
		if (pDrop.nDetail < Item.MIN_COMMON_EQUIP) or (pDrop.nDetail > Item.MAX_COMMON_EQUIP) then
			me.Msg("Chỉ được cải tạo trang bị đã kích hoạt ngũ hành!");
			return 0;
		end
	end
	return	1;

end

function tbEnhItemCont:CheckSwitchItem(pDrop, pPick, nX, nY)
	if (not pDrop) then
		return	1;				-- 只是把东西拿出来，总是成功
	end
	local tbEnhUi = Ui(Ui.UI_EQUIPENHANCE);
	if (tbEnhUi.nMode == Item.ENHANCE_MODE_REFINE) then
		return 1;
	end
	if (tbEnhUi.nMode == Item.ENHANCE_MODE_STRENGTHEN) then
		if (pDrop.szClass == Item.STRENGTHEN_STUFF_CLASS) or (Item.STRENGTHEN_RECIPE_CALSS[pDrop.szClass]) then
				return 1;
		else
			me.Msg("Chỉ được bỏ vào Huyền Tinh hoặc Bùa sửa");
			return 0;
		end
	end
	if (pDrop.szClass == Item.UPGRADE_ITEM_CLASS and tbEnhUi.nMode == Item.ENHANCE_MODE_UPGRADE) then
		return 1;
	elseif (tbEnhUi.nMode == Item.ENHANCE_MODE_UPGRADE) then
		me.Msg("Chỉ được bỏ vào Hồn Thạch")
		return 0;
	end
	if (pDrop.szClass ~= ENHITEM_CLASS) then
		me.Msg("Chỉ được bỏ vào Huyền Tinh!");
		return 0;
	end
	if (tbEnhUi.nMode == Item.ENHANCE_MODE_COMPOSE) then
		if (pDrop.nLevel >= 12) then
			me.Msg("Chỉ được ghép Huyền Tinh dưới cấp 12");
			return 0;
		end
	end
	
	return	1;
end

function tbPreviewCont:FormatItem(tbItem)
	local tbObj = {};
	local pItem = tbItem.pItem;
	if not pItem then
		return;
	end
	tbObj.szBgImage = pItem.szIconImage;
	tbObj.bShowSubScript = 1;		-- æ€»æ˜¾ç¤ºä¸‹æ ‡æ•°å­—
	return tbObj;
end

function tbPreviewCont:UpdateItem(tbItem, nX, nY)
	local pItem = tbItem.pItem;
	local nCount = self.tbEnhItem[pItem.nLevel];
	ObjGrid_ChangeSubScript(self.szUiGroup, self.szObjGrid, tostring(nCount), nX, nY);
	local nColor = (me.CanUseItem(pItem) ~= 1) and 0x60ff0000 or 0;
	ObjGrid_ChangeBgColor(self.szUiGroup, self.szObjGrid, nColor, nX, nY);
	ObjGrid_SetTransparency(self.szUiGroup, self.szObjGrid, pItem.szTransparencyIcon, nX, nY);
end

function uiEquipEnhance:OnCreate()
	self.tbEquipCont = tbObject:RegisterContainer(
		self.UIGROUP,
		OBJ_EQUIP,
		Item.ROOM_ENHANCE_EQUIP_WIDTH,
		Item.ROOM_ENHANCE_EQUIP_HEIGHT,
		tbEquipCont,
		"itemroom"
	);
	self.tbEnhItemCont = tbObject:RegisterContainer(
		self.UIGROUP,
		OBJ_ENHITEM,
		Item.ROOM_ENHANCE_ITEM_WIDTH,
		Item.ROOM_ENHANCE_ITEM_HEIGHT,
		tbEnhItemCont,
		"itemroom"
	);
	self.tbPreviewCont = tbObject:RegisterContainer(
		self.UIGROUP,
		OBJ_PREVIEW,
		PREVIEW_WIDTH,
		PREVIEW_HEIGHT,
		tbPreviewCont
	);
	self.tbPreRefineCont = tbObject:RegisterContainer(
		self.UIGROUP,
		OBJ_PRE_REFINE,
		1,1, tbPreRefineCont
	);
end

function uiEquipEnhance:OnDestroy()
	tbObject:UnregContainer(self.tbEquipCont);
	tbObject:UnregContainer(self.tbEnhItemCont);
	tbObject:UnregContainer(self.tbPreviewCont);
end

function uiEquipEnhance:OnOpen(nMode, nMoneyType)
	self.pTempItem = nil;
	self.pEquip = nil;
	Wnd_SetTip(self.UIGROUP, OBJ_EQUIP, "");
	if nMode == Item.ENHANCE_MODE_ENHANCE then
		UiManager:SetUiState(UiManager.UIS_EQUIP_ENHANCE);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_PEEL then
		UiManager:SetUiState(UiManager.UIS_EQUIP_PEEL);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_PREVIEW);
	elseif nMode == Item.ENHANCE_MODE_COMPOSE then
		UiManager:SetUiState(UiManager.UIS_EQUIP_COMPOSE);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_UPGRADE then
		UiManager:SetUiState(UiManager.UIS_EQUIP_UPGRADE);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_REFINE then
		UiManager:SetUiState(UiManager.UIS_EQUIP_REFINE);
		Wnd_Show(self.UIGROUP, OBJ_PRE_REFINE)
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_STRENGTHEN then
		UiManager:SetUiState(UiManager.UIS_EQUIP_STRENGTHEN);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_SIGNET then
		UiManager:SetUiState(UiManager.UIS_EQUIP_REFINE);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_ITEMPET then
		UiManager:SetUiState(UiManager.UIS_EQUIP_REFINE);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	elseif nMode == Item.ENHANCE_MODE_UPITEM then
		UiManager:SetUiState(UiManager.UIS_EQUIP_REFINE);
		Wnd_Show(self.UIGROUP, OBJ_EQUIP);
		Wnd_Show(self.UIGROUP, OBJ_ENHITEM);
	else
		return 0;
	end
	UiManager:OpenWindow(Ui.UI_ITEMBOX);
	Txt_SetTxt(self.UIGROUP, TXT_TITLE, MODE_TEXT[nMode]);
	self.nMode = nMode;
	self.nMoneyType = nMoneyType;
	self.tbEquipCont.nMode = nMode;
	self:UpdateItem();
	self:UpdateList();
end

function uiEquipEnhance:OnClose()
	me.ApplyEnhance(Item.ENHANCE_MODE_NONE, 0);		-- 通知服务端取消强化/剥离操作
	self.tbEquipCont:ClearRoom();
	self.tbEnhItemCont:ClearRoom();
	self.tbPreviewCont:ClearObj();
	if self.nMode == Item.ENHANCE_MODE_ENHANCE then
		UiManager:ReleaseUiState(UiManager.UIS_EQUIP_ENHANCE);
	elseif self.nMode == Item.ENHANCE_MODE_PEEL then
		UiManager:ReleaseUiState(UiManager.UIS_EQUIP_PEEL);
	elseif self.nMode == Item.ENHANCE_MODE_COMPOSE then
		UiManager:ReleaseUiState(UiManager.UIS_EQUIP_COMPOSE);
	elseif self.nMode == Item.ENHANCE_MODE_UPGRADE then
		UiManager:ReleaseUiState(UiManager.UIS_EQUIP_UPGRADE);
	elseif self.nMode == Item.ENHANCE_MODE_REFINE then
		UiManager:ReleaseUiState(UiManager.UIS_EQUIP_REFINE);
	elseif self.nMode == Item.ENHANCE_MODE_STRENGTHEN then
		UiManager:ReleaseUiState(UiManager.UIS_EQUIP_STRENGTHEN);
	end
	Lst_Clear(self.UIGROUP, LIST_MAGIC_SELECT);
	self.nRefineSelected = nil;
	self.pEquip = nil;
	tbTempItem:Destroy(self.pTempItem);
	self:DeleteTempAllStuff();
end

function uiEquipEnhance:UpdateList(pEquip)
	if pEquip and self.nMode == Item.ENHANCE_MODE_UPGRADE then
		local tbAttrib = pEquip.GetBaseAttrib();
		Lst_Clear(self.UIGROUP, LIST_MAGIC_SELECT);
		for i, tbMA in ipairs(tbAttrib) do
			local szDesc = FightSkill:GetMagicDesc(tbAttrib[i].szName, tbAttrib[i].tbValue, nil, 1);
			if szDesc ~= "" then
				Lst_SetCell(self.UIGROUP, LIST_MAGIC_SELECT, i, 1, szDesc);
			end
		end
	elseif self.tbProduce and self.tbTempItem and self.nMode == Item.ENHANCE_MODE_REFINE then
		for i, pItem in pairs(self.tbTempItem) do
			Lst_SetCell(self.UIGROUP, LIST_MAGIC_SELECT, i, 1, pItem.szName);
		end
	else
		Lst_Clear(self.UIGROUP, LIST_MAGIC_SELECT);
	end
end

function uiEquipEnhance:OnListSel(szWnd, nParam)
	if nParam <= 0 then
		return;
	end
	if szWnd == LIST_MAGIC_SELECT then
		if self.nMode == Item.ENHANCE_MODE_UPGRADE then
			self:UpdateItem();
		elseif self.nMode == Item.ENHANCE_MODE_REFINE then
			local nIndex = 1;
			if self.tbProduce and #self.tbProduce > 1 then
				nIndex = Lst_GetCurKey(self.UIGROUP, LIST_MAGIC_SELECT);
				if nIndex == 0 or not self.tbProduce or not self.tbProduce[nIndex] then
					return 0;
				end
				self.nRefineSelected = nIndex;
			end	
			self:UpdateRefinePreview(nParam);
		end
	end
end

function uiEquipEnhance:OnButtonClick(szWnd, nParam)
	if (szWnd == BTN_CONFIRM) then
		if self.nMoneyEnoughFlag == 0 then
			local szMoney = ""
			if self.nMoneyType == Item.BIND_MONEY and self.nMode ~= Item.ENHANCE_MODE_PEEL then
				szMoney = "Bạc khóa"
			else
				szMoney = "Bạc"
			end
			me.Msg("Không đủ "..szMoney.." để trả phí " .. MODE_TEXT[self.nMode] .. ", không thể tiến hành" .. MODE_TEXT[self.nMode] .. ".");
			return;	
		-- 
		elseif ((self.bShowHighForbidden == 1 or self.bShowLowForbidden == 1) and self.nMode == Item.ENHANCE_MODE_ENHANCE) then
			local tbMsg = {};
			tbMsg.szMsg = "";
			if self.bShowHighForbidden == 1 and self.nMode == Item.ENHANCE_MODE_ENHANCE then
				tbMsg.szMsg = "Huyền Tinh đặt vào quá nhiều, xin đừng lãng phí.";
			elseif self.bShowLowForbidden == 1 and self.nMode == Item.ENHANCE_MODE_ENHANCE then
				tbMsg.szMsg = "Xác suất thành công quá thấp, không thể cường hóa.";
			end
			tbMsg.nOptCount = 1;
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.nMode, self.nMoneyType);
		elseif (self.bShowBindMsg == 1 or (self.bShowWarnning == 1 and self.nMode == Item.ENHANCE_MODE_ENHANCE)) then
			local tbMsg = {};
			local szReason = ""
			tbMsg.szMsg = "";
			if self.bShowWarnning == 1 and self.nMode == Item.ENHANCE_MODE_ENHANCE then
				tbMsg.szMsg = "Tỷ lệ cường hóa thành công <color=red>chưa đạt 100%<color>, ";
			end
			if self.bShowBindMsg == 1 then
				if (self.nMoneyType == Item.BIND_MONEY) then
					szReason = "Bạc khóa";
				else
					szReason = "Huyền Tinh khóa";
				end
				if (self.nMode == Item.ENHANCE_MODE_ENHANCE) then
					tbMsg.szMsg = tbMsg.szMsg..string.format("Dùng <color=red>%s<color> cường hóa, trang bị sẽ <color=red>khóa<color> với nhân vật, ", szReason);
				elseif (self.nMode == Item.ENHANCE_MODE_COMPOSE) then
					tbMsg.szMsg = tbMsg.szMsg..string.format("Đã dùng <color=red>%s<color> ghép Huyền Tinh, Huyền Tinh sau khi ghép sẽ ở dạng <color=red>khóa<color>, ", szReason);
				elseif (self.nMode == Item.ENHANCE_MODE_STRENGTHEN) then
					tbMsg.szMsg = tbMsg.szMsg..string.format("Dùng <color=red>%s<color> sửa trang bị, trang bị sẽ <color=red>khóa<color> với nhân vật, ", szReason);
				end
				
			end
			tbMsg.szMsg = tbMsg.szMsg.." tiếp tục không?"
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex, nMode, nMoneyType, nProb)
				if (nOptIndex == 2) then
					me.ApplyEnhance(nMode, nMoneyType, (nProb or 0));
				end
			end
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.nMode, self.nMoneyType, self.nProb);
		elseif self.nMode == Item.ENHANCE_MODE_UPGRADE then
			local nMagicIndex = Lst_GetCurKey(self.UIGROUP, LIST_MAGIC_SELECT);
			if nMagicIndex == 0 then
				return 0;
			end
			me.ApplyUpgradeSignet(nMagicIndex, self.nMoneyType);
		elseif self.nMode == Item.ENHANCE_MODE_REFINE then
			local nIndex = 1;
			if self.tbProduce and #self.tbProduce > 1 then
				nIndex = Lst_GetCurKey(self.UIGROUP, LIST_MAGIC_SELECT);
				if nIndex == 0 or not self.tbProduce or not self.tbProduce[nIndex] then
					return 0;
				end
			end
			local szMsg = "Trang bị sau khi luyện hóa sẽ <color=green>khóa với nhân vật<color>, muốn tiếp tục luyện hóa không?";
			self:UpdateMoneyFlag(self.tbProduce[nIndex].nFee + Item:CalcRefineMoney(self.pEquip))
			if (self.nMoneyEnoughFlag == 1) then
				szMsg ="<color=red>Dùng bạc để thay thế số bạc khóa còn thiếu, <color>"..szMsg;
			end
			local tbMsg = {};
			tbMsg.szMsg = szMsg;
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex, nIdx)
				if (nOptIndex == 2) then
					me.ApplyRefine(nIdx);
				end
			end
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.tbProduce[nIndex].nIdx);
		elseif self.nMode == Item.ENHANCE_MODE_ENHANCE then
			me.ApplyEnhance(self.nMode, self.nMoneyType, (self.nProb or 0));
		elseif self.nMode == Item.ENHANCE_MODE_STRENGTHEN then
			local tbMsg = {};
			tbMsg.szMsg = "";
			if self.bShowHighForbidden == 1  then
				tbMsg.szMsg = "Huyền Tinh đặt vào quá nhiều, xin đừng lãng phí.";
				tbMsg.nOptCount = 1;
				UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.nMode, self.nMoneyType);
			elseif (self.bShowBindMsg == 1) then
				local tbMsg = {};
				local szReason = ""
				tbMsg.szMsg = "";
				if (self.nMoneyType == Item.BIND_MONEY) then
					szReason = "Bạc khóa";
				else
					szReason = "Huyền Tinh khóa";
				end
					
				tbMsg.szMsg = tbMsg.szMsg..string.format("Dùng <color=red>%s<color> sửa trang bị, trang bị sẽ <color=red>khóa<color> với nhân vật, ", szReason);
	
				tbMsg.szMsg = tbMsg.szMsg.." tiếp tục không?"
				tbMsg.nOptCount = 2;
				function tbMsg:Callback(nOptIndex, nMode, nMoneyType, nProb)
					if (nOptIndex == 2) then
						me.ApplyEnhance(nMode, nMoneyType, (nProb or 0));
					end
				end
				UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.nMode, self.nMoneyType, self.nProb);
			end
			me.ApplyEnhance(self.nMode, self.nMoneyType, (nProb or 0));
		else
			me.ApplyEnhance(self.nMode, self.nMoneyType);
		end
	elseif (szWnd == BTN_CANCEL) or (szWnd == BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	end
end

function uiEquipEnhance:ShowMsgBox(nMode, nMoneyType)
	local tbTimeMsg = {};
	tbTimeMsg.szMsg = "Đã dùng Huyền Tinh <color=red>có thời hạn<color> để ghép, Huyền Tinh sau khi ghép cũng <color=red>có thời hạn sử dụng<color>, tiếp tục không?"
	tbTimeMsg.nOptCount = 2;
	function tbTimeMsg:Callback(nOptIndex, nMode, nMoneyType)
		if (nOptIndex == 2) then
			me.ApplyEnhance(nMode, nMoneyType);
		end
	end
end

function uiEquipEnhance:UpdateEnhance(pEquip)

	if pEquip and (pEquip.nEnhTimes >= Item:CalcMaxEnhanceTimes(pEquip)) then	-- 在刚刚执行完最高级别强化操作时容器里的装备是不能再进行强化的
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Trang bị đã được cường hóa tối đa!");
		return;
	end

	local tbEnhItem = {};

	for j = 0, Item.ROOM_ENHANCE_ITEM_HEIGHT - 1 do
		for i = 0, Item.ROOM_ENHANCE_ITEM_WIDTH - 1 do
			local pEnhItem = me.GetEnhanceItem(i, j);
			if pEnhItem and (pEnhItem.szClass == ENHITEM_CLASS) then
				table.insert(tbEnhItem, pEnhItem);
			end
		end
	end

	if (not pEquip) and (#tbEnhItem <= 0) then
		local szReason = ""
		if self.nMoneyType == Item.BIND_MONEY then
			szReason = "Dùng bạc khóa để cường hóa, trang bị sau khi cường hóa sẽ khóa với nhân vật"
		else
			szReason = "Chú ý, khi dùng Huyền Tinh khóa cường hóa trang bị chưa khóa, trang bị sẽ bị khóa."
		end
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, string.format("◆Đặt trang bị muốn cường hóa vào ô trên, Huyền Tinh vào ô dưới, nhấn \"Đồng ý\" để cường hóa.\n<color=yellow>%s", szReason));
	elseif (not pEquip) and (#tbEnhItem > 0) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Đặt trang bị muốn cường hóa vào ô trên.");
	elseif pEquip and (#tbEnhItem <= 0) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Đặt Huyền Tinh vào ô dưới.");
	else
		-- by zhangjinpin@kingsoft
		local nProb, nMoney, bBind, _, nValue, nTrueProb = Item:CalcEnhanceProb(pEquip, tbEnhItem, self.nMoneyType);
		
		self.nProb = nProb;
		self:UpdateMoneyFlag(nMoney);
		local szMsg = string.format(
			"◆Lần cường hóa này sẽ thu <color=yellow>bạc %s<color> %s%d lượng %s. (Tỷ giá bạc hiện là <color=yellow>%d<color>)\n◆Dự đoán tỉ lệ cường hóa thành công: %d%%.\n",
			(self.nMoneyType == Item.NORMAL_MONEY) and " thường" or " khóa",
			(self.nMoneyEnoughFlag == 1) and "" or "<color=red>",
			nMoney,
			(self.nMoneyEnoughFlag == 1) and "" or "<color>",
			Item:GetJbPrice() * 100,
			nProb
		);
		
		-- 
		if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 then
			szMsg = "<color=yellow>◆Hoạt động ưu đãi ghép máy chủ, giảm 20% phí cường hóa trang bị\n<color>"..szMsg;
		end
		-- *************************************
		
		-- by zhangjinpin@kingsoft
		if nProb < 10 then
			self.bShowLowForbidden = 1;
		else
			self.bShowLowForbidden = 0;
		end
		
		if (nTrueProb > 120 and nValue > 16796) then
			self.bShowHighForbidden = 1;
		else
			self.bShowHighForbidden = 0;
		end
		
		if nProb < 100 then
			szMsg = szMsg .. "◆Muốn tăng tỷ lệ thành công, hãy bỏ vào nhiều Huyền Tinh hơn.\n";
			
		end
		if nProb < 100 and pEquip.nEnhTimes >= 11 then
			self.bShowWarnning = 1;
		else
			self.bShowWarnning = 0;
		end
		if pEquip.IsBind() == 1 then	-- 装备本身绑定的不提示
			self.bShowBindMsg = 0;
		else
			self.bShowBindMsg = bBind;
		end
		local szTime = me.GetItemAbsTimeout(pEquip) or me.GetItemRelTimeout(pEquip);
		if szTime then
			self.bShowTimeMsg = 1;
		else
			self.bShowTimeMsg = 0;
		end
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szMsg);
		if (#tbEnhItem > 0) then
			Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 1);
		end
	end

end

function uiEquipEnhance:UpdatePeel(pEquip)

	self.tbPreviewCont:ClearObj();		-- 先清除预览容器内容
	self:DeleteTempAllStuff();				-- 释放先前所占用的临时道具
	
	if (not pEquip) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Bỏ trang bị đã cường hóa muốn tách vào ô trên, ô dưới sẽ hiện ra kết quả sau khi tách.");
		return;
	end
	
	Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 1);
	
	if (pEquip.nEnhTimes <= 0) then		-- 在刚刚执行完剥离操作时容器里的装备是不能剥离的
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Trang bị đã được tách Huyền Tinh thành công.");
		return;
	end

	local tbEnhItem, nMoney, nBind = Item:CalcPeelItem(pEquip);
	if (not tbEnhItem) then
		return;
	end
	self:UpdateMoneyFlag(nMoney);
	local szMsg = string.format(
		"◆Tách Huyền Tinh giúp trang bị <color=yellow>khôi phục trạng thái chưa cường hóa<color>, đồng thời sẽ nhận được Huyền Tinh ở ô dưới.\n" ..
		"◆Lần tách này <color=yellow>trả lại %d lượng<color>, hãy kiểm tra ô trống trong túi rồi nhấn \"Đồng ý\".\n" ..
		"◆<color=yellow>Chú ý: Huyền Tinh tách được sẽ ở dạng khóa<color>\n", 
		nMoney);

	self.tbPreviewCont.tbEnhItem = tbEnhItem;
	Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szMsg);

	local nX = 0;
	local nY = 0;

	for nLevel, nCount in pairs(tbEnhItem) do
		if nCount > 0 then
			self:AddTempEnhItem(nLevel, nX, nY);
			if nX < Item.ROOM_ENHANCE_ITEM_WIDTH then
				nX = nX + 1;
			else
				nX = 0;
				nY = nY + 1;
			end
			if nY > Item.ROOM_ENHANCE_ITEM_HEIGHT then
				break;
			end
		end
	end

end

function uiEquipEnhance:UpdateCompose()
	local tbEnhItem = {};
	for j = 0, Item.ROOM_ENHANCE_ITEM_HEIGHT - 1 do
		for i = 0, Item.ROOM_ENHANCE_ITEM_WIDTH - 1 do
			local pEnhItem = me.GetEnhanceItem(i, j);
			if pEnhItem and (pEnhItem.szClass == ENHITEM_CLASS) then
				table.insert(tbEnhItem, pEnhItem);
			end
		end
	end

	if (#tbEnhItem <= 0) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Đặt Huyền Tinh vào ô dưới.");
	else
		local nMinLevel, nMinLevelRate, nMaxLevel, nMaxLevelRate, nFee, bBind, tbAbsTime = Item:GetComposeBudget(tbEnhItem, self.nMoneyType);
		if nMinLevel <= 0 then
			return 0;
		end
		self:UpdateMoneyFlag(nFee);
		if self.nMinLevel == 0 then
			Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Không phải Huyền Tinh, không thể ghép!");
			Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 0);
		else
			local nMinRate = math.ceil(100 * nMinLevelRate / (nMinLevelRate + nMaxLevelRate));
			local szMsg = string.format("◆Lần ghép này sẽ thu <color=yellow>bạc %s<color> %s%d lượng %s. (Tỷ giá bạc hiện là <color=yellow>%d<color>)\n◆Dự đoán ghép:\n  %d%% nhận Huyền Tinh cấp %d",
				(self.nMoneyType == Item.NORMAL_MONEY) and " thường" or " khóa",
				(self.nMoneyEnoughFlag == 1) and "" or "<color=red>",
				nFee,
				(self.nMoneyEnoughFlag == 1) and "" or "<color>",
				Item:GetJbPrice() * 100,
				nMinRate,
				nMinLevel
			);
			if nMaxLevel > 0 then
				szMsg = szMsg..string.format("\n  %d%% nhận được Huyền Tinh cấp %d", 100 - nMinRate, nMaxLevel)
			end
			if tbAbsTime then
				szMsg = szMsg..string.format("\n◆Vật phẩm ghép có hạn dùng đến <color=yellow>%d-%d-%d %d giờ %d phút<color>", unpack(tbAbsTime));
			end
			if nMaxLevel == 12 and nMinLevelRate == 0 then
				szMsg = szMsg .. "\n◆Đã có thể ghép Huyền Tinh cấp cao nhất\n";
			else
				szMsg = szMsg .. "\n◆Muốn có Huyền Tinh cấp cao, hãy bỏ vào nhiều Huyền Tinh hơn\n";
			end
			self.bShowBindMsg = bBind;
		
			Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szMsg);
			if (#tbEnhItem > 0) then
				Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 1);
			end
		end
	end

end

function uiEquipEnhance:UpdateUpgrade(pEquip)
	if not pEquip then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Bỏ Ấn vào ô trên!");
		return;
	end
	local nMagicIndex = Lst_GetCurKey(self.UIGROUP, LIST_MAGIC_SELECT);
	if nMagicIndex == 0 then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Chọn thuộc tính muốn nâng:");
		return 0;
	end
	local nCurLevel, nCurExp, nCurUpGradeExp = Item:CalcUpgrade(pEquip, nMagicIndex, 0);
	if nCurLevel >= Item.tbMAX_SIGNET_LEVEL[pEquip.nLevel] then	
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Thuộc tính này đã được nâng tối đa!");
		return;
	end
	local nItemNum = 0;
	for j = 0, Item.ROOM_ENHANCE_ITEM_HEIGHT - 1 do
		for i = 0, Item.ROOM_ENHANCE_ITEM_WIDTH - 1 do
			local pItem = me.GetEnhanceItem(i, j);
			if pItem and pItem.szClass == Item.UPGRADE_ITEM_CLASS then
				nItemNum = nItemNum + pItem.nCount;
			end
		end
	end
	if nItemNum == 0 then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Bỏ Ngũ Hành Hồn Thạch vào:");
		return 0;
	end
	local tbAttrib = pEquip.GetBaseAttrib();
	local szDesc = FightSkill:GetMagicDesc(tbAttrib[nMagicIndex].szName, tbAttrib[nMagicIndex].tbValue, nil, 1);
	local nLevel, nExp, nUpgradeExp = Item:CalcUpgrade(pEquip, nMagicIndex, nItemNum);
	local szIsFull = tonumber(nUpgradeExp);
	if (nLevel >= Item.tbMAX_SIGNET_LEVEL[pEquip.nLevel]) then
		szIsFull = "<Thuộc tính đã đạt tối đa>"
	end
	local szMsg = string.format("◆%s(%d/%d)\n<color=gold>  →Tăng %d điểm (%d/%s)<color>", szDesc, nCurExp, nCurUpGradeExp, nLevel, nExp, szIsFull);
	
	Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szMsg);
	self.nMoneyEnoughFlag = 1;
	Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 1);
end

function uiEquipEnhance:UpdateRefine()
	self.tbPreRefineCont:ClearObj();		-- 先清除预览容器内容
	self:DeleteTempAllStuff();				-- 释放先前所占用的临时道具
	Lst_Clear(self.UIGROUP, LIST_MAGIC_SELECT);
	local tbRefineItem = {};
	for j = 0, Item.ROOM_ENHANCE_ITEM_HEIGHT - 1 do
		for i = 0, Item.ROOM_ENHANCE_ITEM_WIDTH - 1 do
			local pEnhItem = me.GetEnhanceItem(i, j);
			if pEnhItem then
				table.insert(tbRefineItem, pEnhItem);
			end
		end
	end
	if #tbRefineItem == 0 then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Đặt trang bị muốn luyện hóa và Cải Tạo Đồ vào ô dưới:");
		return;
	end
	
	local pEquip, pRefineItem, tbProduce, tbRefineStuff, tbRequireItem, nRefineDegree = Item:CalcRefineItem(tbRefineItem);
	self.pEquip = pEquip;
	self.nRefineDegree = nRefineDegree;
	if (not pEquip) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Nguyên liệu hiện tại không thể luyện hóa trang bị!");
		return;
	end
	
	self.tbProduce = tbProduce;
	for _, tbProduceItem in pairs(tbProduce) do
		-- 
		local pItem = tbTempItem:Create(
			tbProduceItem.tbEquip[1],
			tbProduceItem.tbEquip[2],
			tbProduceItem.tbEquip[3],
			tbProduceItem.tbEquip[4],
			pEquip.nSeries,
			pEquip.nEnhTimes,
			pEquip.nLucky,
			nil,
			0,
			pEquip.dwRandSeed,
			pEquip.nIndex,
			pEquip.nStrengthen
			);	
		if not pItem then
			return;
		end
		table.insert(self.tbTempItem, pItem);	-- 为了释放而记录之
	end
	
	if #tbProduce > 1 then
		local szMsg = "◆Chọn trang bị muốn luyện hóa:";
		if nRefineDegree ~= 100 and #tbProduce > 0 then
			szMsg = "◆Độ luyện: <color=gold>"..nRefineDegree.."%<color> (chưa đạt 100%, cần thêm Huyền Tinh)\n"..szMsg;
		else
			szMsg = "◆Độ luyện: <color=gold>100%<color>\n"..szMsg;
		end

		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szMsg);
		self:UpdateList();
		
		if self.nRefineSelected ~= nil then
			Lst_SetCurKey(self.UIGROUP, LIST_MAGIC_SELECT, self.nRefineSelected);
			return;
		end
	elseif #tbProduce == 0 then
		print("#tbProduce == 0");
	else
		self:UpdateRefinePreview(1);
	end
end

function uiEquipEnhance:UpdateRefinePreview(nIndex)
	local pItem = self.tbTempItem[nIndex]
	if not pItem or not self.tbProduce or not self.tbProduce[nIndex] then
		return;
	end
	
	local tbObj = {};
	tbObj.nType = Ui.OBJ_TEMPITEM;
	tbObj.pItem = pItem;
	self.tbPreRefineCont:SetObj(tbObj, nX, nY);
	self:UpdateMoneyFlag(self.tbProduce[nIndex].nFee + Item:CalcRefineMoney(self.pEquip));
	
	local szRefineDegreeMsg = "◆Độ luyện: <color=gold>"..self.nRefineDegree.."%<color>";
	if self.nRefineDegree ~= 100 then
		szRefineDegreeMsg = szRefineDegreeMsg.."(Chưa đạt 100%, cần thêm Huyền Tinh)\n";
	else
		szRefineDegreeMsg = szRefineDegreeMsg.."\n";
		Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 1);
	end
	
	local szMsg = string.format("◆Lần luyện hóa này cần thu <color=yellow>bạc<color> %s%d lượng %s. (Ưu tiên dùng bạc khóa)\n",
			(self.nMoneyEnoughFlag > 0) and "" or "<color=red>",
			self.tbProduce[nIndex].nFee + Item:CalcRefineMoney(self.pEquip),
			(self.nMoneyEnoughFlag > 0) and "" or "<color>");
	
	if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 then
		szMsg = szMsg .. "<color=yellow>◆Hoạt động ưu đãi ghép máy chủ, giảm 20% phí luyện hóa trang bị\n<color>";
	end
	Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szRefineDegreeMsg..szMsg);
end
-- 
function uiEquipEnhance:UpdateStrengthen(pEquip)
	local tbStrItem = {};
	for j = 0, Item.ROOM_ENHANCE_ITEM_HEIGHT - 1 do
		for i = 0, Item.ROOM_ENHANCE_ITEM_WIDTH - 1 do
			local pStrItem = me.GetEnhanceItem(i, j);
			if pStrItem then
				table.insert(tbStrItem, pStrItem);
			end
		end
	end

	if (not pEquip) and (#tbStrItem <= 0) then
		local szReason = "";
		if self.nMoneyType == Item.BIND_MONEY then
			szReason = "Hiện đang dùng bạc khóa cải tạo trang bị, cải tạo thành công sẽ khóa với nhân vật";
		else
			szReason = "Chú ý: Dùng Huyền Tinh khóa cải tạo trang bị chưa khóa, trang bị này cũng sẽ bị khóa.";
		end
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, string.format("◆Hãy bỏ trang bị muốn cải tạo vào ô trên, Huyền Tinh vào ô dưới, sau đó nhấn \"Đồng ý\" để cải tạo.\n<color=yellow>%s", szReason));
	elseif (not pEquip) and (#tbStrItem > 0) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Bỏ trang bị muốn cải tạo vào ô trên.");
	elseif Item:CheckStrengthenEquip(pEquip) ~= 1 then
		local _, szMsg = Item:CheckStrengthenEquip(pEquip)
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "<color=yellow>◆"..szMsg.."<color>");
	elseif pEquip and (#tbStrItem <= 0) then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Hãy bỏ Huyền Tinh và Bùa sửa tương ứng vào ô dưới.");
	elseif Item:CalStrengthenStuff(pEquip, tbStrItem) == 0 then
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, "◆Hãy bỏ Huyền Tinh và Bùa sửa tương ứng vào ô dưới.");		
	else
		local nRes, szMsg, nValue, bBind, tbStuffItem, pStrengthenRecipe = Item:CalStrengthenStuff(pEquip, tbStrItem);
		local nProb, nMoney, nTrueProb = Item:CalcProb(pEquip, nValue, Item.ENHANCE_MODE_STRENGTHEN);
		if self.nMoneyType == Item.BIND_MONEY then
			bBind = 1;
		end
		self.nProb = nProb;
		self:UpdateMoneyFlag(nMoney);
		local szMsg = string.format(
			"◆Lần cải tạo này cần thu <color=yellow>bạc %s<color>%s%d lượng %s. (Tỷ giá bạc hiện là <color=yellow>%d<color>)\n*Độ cải tạo: %d%%.\n",
			(self.nMoneyType == Item.NORMAL_MONEY) and " thường" or " khóa",
			(self.nMoneyEnoughFlag == 1) and "" or "<color=red>",
			nMoney,
			(self.nMoneyEnoughFlag == 1) and "" or "<color>",
			Item:GetJbPrice() * 100,
			nProb
		);
		
		-- 
		if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 then
			szMsg = "<color=yellow>◆Hoạt động ưu đãi ghép máy chủ, giảm 20% phí cải tạo trang bị\n<color>"..szMsg;
		end
		-- *************************************
		
		if (nTrueProb > 120) then
			self.bShowHighForbidden = 1;
		else
			self.bShowHighForbidden = 0;
		end
		
		if nProb < 100 then
			szMsg = szMsg .. "◆Muốn tăng độ cải tạo, hãy bỏ vào nhiều Huyền Tinh hơn.\n";
		end
		
		if pEquip.IsBind() == 1 then	-- 装备本身绑定的不提示
			self.bShowBindMsg = 0;
		else
			self.bShowBindMsg = bBind;
		end
		local szTime = me.GetItemAbsTimeout(pEquip) or me.GetItemRelTimeout(pEquip);
		if szTime then
			self.bShowTimeMsg = 1;
		else
			self.bShowTimeMsg = 0;
		end
		Txt_SetTxt(self.UIGROUP, TXT_MESSAGE, szMsg);
		if (nProb == 100 and pStrengthenRecipe) then
			Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 1);
		end
	end
end

function uiEquipEnhance:UpdateItem()
	local pEquip = me.GetEnhanceEquip();
	Wnd_SetEnable(self.UIGROUP, BTN_CONFIRM, 0);
	if self.nMode == Item.ENHANCE_MODE_ENHANCE then
		self:UpdateEnhance(pEquip);
	elseif self.nMode == Item.ENHANCE_MODE_PEEL then
		self:UpdatePeel(pEquip);
	elseif self.nMode == Item.ENHANCE_MODE_COMPOSE then
		self:UpdateCompose();
	elseif self.nMode == Item.ENHANCE_MODE_UPGRADE then
		self:UpdateUpgrade(pEquip);
	elseif self.nMode == Item.ENHANCE_MODE_REFINE then
		self:UpdateRefine();
	elseif self.nMode == Item.ENHANCE_MODE_STRENGTHEN then
		self:UpdateStrengthen(pEquip);
	end
end

function uiEquipEnhance:OnSyncItem(nRoom, nX, nY)
	if (nRoom == Item.ROOM_ENHANCE_EQUIP) or (nRoom == Item.ROOM_ENHANCE_ITEM) then
		self:UpdateItem();
	end
end

function uiEquipEnhance:AddTempEnhItem(nLevel, nX, nY)

	local pItem = tbTempItem:Create(
		ENHITEM_INDEX.nGenre,
		ENHITEM_INDEX.nDetail,
		ENHITEM_INDEX.nParticular,
		nLevel
	);	-- 创建临时道具对象

	if not pItem then
		return;
	end

	table.insert(self.tbTempItem, pItem);	-- 为了释放而记录之

	local tbObj = {};
	tbObj.nType = Ui.OBJ_TEMPITEM;
	tbObj.pItem = pItem;
	self.tbPreviewCont:SetObj(tbObj, nX, nY);

end

function uiEquipEnhance:DeleteTempAllStuff()
	for _, pTemp in pairs(self.tbTempItem) do
		tbTempItem:Destroy(pTemp);
	end
	self.tbTempItem = {};
end

function uiEquipEnhance:OnAnimationOver(szWnd)
	if (szWnd == IMG_EFFECT) then
		Wnd_Hide(self.UIGROUP, IMG_EFFECT);	-- 播放完毕，隐藏图像
	end
end

function uiEquipEnhance:OnResult(nMode, nResult)

	self.tbEnhItemCont:ClearRoom();

	if nMode == Item.ENHANCE_MODE_ENHANCE then
		if (nResult == 1) then
			Wnd_Show(self.UIGROUP, IMG_EFFECT);
 			Img_PlayAnimation(self.UIGROUP, IMG_EFFECT);	-- 播放动画特效
			me.Msg("Cường hóa thành công!");
		elseif (nResult == 0) then
			me.Msg("Đáng tiếc, cường hóa trang bị thất bại.");
		else
			me.Msg("Không thể cường hóa trang bị!");
		end
	elseif nMode == Item.ENHANCE_MODE_PEEL then
		if (nResult == 1) then
			me.Msg("Tách Huyền Tinh thành công!");
		elseif (nResult == 0) then
			me.Msg("Đáng tiếc, tách Huyền Tinh thất bại.");
		else
			me.Msg("Không thể tách Huyền Tinh!");
		end
	elseif nMode == Item.ENHANCE_MODE_COMPOSE then
		if nResult > 0 then
			me.Msg("Đã ghép 1 Huyền Tinh cấp "..nResult.."!");
		end
	elseif nMode == Item.ENHANCE_MODE_UPGRADE then
		if nResult > 0 then
			Wnd_Show(self.UIGROUP, IMG_EFFECT);
 			Img_PlayAnimation(self.UIGROUP, IMG_EFFECT);	-- 播放动画特效
 			local pEquip = me.GetEnhanceEquip();
 			self:UpdateList(pEquip);
			me.Msg("Nâng cấp Ấn thành công!");
		end
	elseif nMode == Item.ENHANCE_MODE_STRENGTHEN then
		if (nResult > 0) then
			Wnd_Show(self.UIGROUP, IMG_EFFECT);
 			Img_PlayAnimation(self.UIGROUP, IMG_EFFECT);	-- 播放动画特效
			me.Msg("Cải tạo trang bị thành công!");
		elseif (nResult == 0) then
			me.Msg("Cải tạo trang bị thất bại!");
		end
	end

	self:UpdateItem();
end

function uiEquipEnhance:UpdateMoneyFlag(nMoney)
	if self.nMode == Item.ENHANCE_MODE_PEEL then  -- 剥离不扣钱
		self.nMoneyEnoughFlag = 1;
	elseif self.nMode == Item.ENHANCE_MODE_REFINE then -- 炼化和转移不区分绑定和非绑定银两
		if me.GetBindMoney() >= nMoney then 
			self.nMoneyEnoughFlag = 2;
		else
			self.nMoneyEnoughFlag = (me.nCashMoney + me.GetBindMoney() >= nMoney) and 1 or 0;
		end
	elseif self.nMoneyType == Item.BIND_MONEY then
		self.nMoneyEnoughFlag = (me.GetBindMoney() >= nMoney) and 1 or 0;
	else
		self.nMoneyEnoughFlag = (me.nCashMoney >= nMoney) and 1 or 0;
	end
end

function uiEquipEnhance:StateRecvUse(szUiGroup)
	if szUiGroup == self.UIGROUP then
		return;
	end
	
	if (UiManager:WindowVisible(self.UIGROUP) ~= 1) then
		return;
	end

	
	local tbObj = tbMouse:GetObj();
	if not tbObj then
		return;
	end
	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
	
	if self.nMode == Item.ENHANCE_MODE_ENHANCE then				-- 装备强化 
		if (pItem.IsEquip() == 1) then
			self.tbEquipCont:ClearRoom();
			self.tbEquipCont:SpecialStateRecvUse();
		else
			self.tbEnhItemCont:SpecialStateRecvUse();
		end						
	elseif self.nMode == Item.ENHANCE_MODE_REFINE then			-- 装备炼化
		
		self.tbEnhItemCont:SpecialStateRecvUse();	
		
	elseif (self.nMode == Item.ENHANCE_MODE_COMPOSE) then		-- 玄晶合成
		
		self.tbEnhItemCont:SpecialStateRecvUse();
		
	elseif (self.nMode == Item.ENHANCE_MODE_PEEL) then 			-- 玄晶剥离
		--if (pItem.IsEquip() == 1) then
			self.tbEquipCont:ClearRoom();
			self.tbPreviewCont:ClearObj();
		--end	
		self.tbEquipCont:SpecialStateRecvUse();
		
	elseif (self.nMode == Item.ENHANCE_MODE_UPGRADE) then		-- 印鉴升级
		
		if (pItem.nDetail == Item.EQUIP_SIGNET) then
			self.tbEquipCont:SpecialStateRecvUse();
		else
			self.tbEnhItemCont:SpecialStateRecvUse();
		end
		
	elseif (self.nMode == Item.ENHANCE_MODE_STRENGTHEN) then	-- 装备改造
		if (pItem.IsEquip() == 1) then
			self.tbEquipCont:ClearRoom();
			self.tbEquipCont:SpecialStateRecvUse();
		else
			self.tbEnhItemCont:SpecialStateRecvUse();
		end
	end
end

function uiEquipEnhance:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_SYNC_ITEM,	  	self.OnSyncItem },		-- 角色道具同步事件
		{ UiNotify.emCOREEVENT_ENHANCE_RESULT,	self.OnResult },		-- 同步强化/剥离操作结果
		{ UiNotify.emCOREEVENT_MONEY_CHANGED,	self.UpdateItem },		-- 金钱发生改变
		{ UiNotify.emUIEVENT_OBJ_STATE_USE,	self.StateRecvUse},		
	};
	Lib:MergeTable(tbRegEvent, self.tbEquipCont:RegisterEvent());
	Lib:MergeTable(tbRegEvent, self.tbEnhItemCont:RegisterEvent());
	Lib:MergeTable(tbRegEvent, self.tbPreviewCont:RegisterEvent());
	Lib:MergeTable(tbRegEvent, self.tbPreRefineCont:RegisterEvent());
	return tbRegEvent;
end

function uiEquipEnhance:RegisterMessage()
	local tbRegMsg = {};
	Lib:MergeTable(tbRegMsg, self.tbEquipCont:RegisterMessage());
	Lib:MergeTable(tbRegMsg, self.tbEnhItemCont:RegisterMessage());
	Lib:MergeTable(tbRegMsg, self.tbPreviewCont:RegisterMessage());
	Lib:MergeTable(tbRegMsg, self.tbPreRefineCont:RegisterMessage());
	return tbRegMsg;
end
