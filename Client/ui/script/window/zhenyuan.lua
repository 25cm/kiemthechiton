-----------------------------------------------------
--ÎÄ¼þÃû		£º	zhenyuan.lua
--´´½¨Õß		£º	zhoupengfeng
--´´½¨Ê±¼ä		£º	2010-06-28
--¹¦ÄÜÃèÊö		£º	Õ½¶·Á¦
------------------------------------------------------

local uiZhenYuan = Ui:GetClass("zhenyuan");

local tbObject   = Ui.tbLogic.tbObject;
local tbMouse    = Ui.tbLogic.tbMouse;

uiZhenYuan.BTN_CLOSE				= "BtnClose";
uiZhenYuan.BTN_OK					= "BtnOk";
uiZhenYuan.BTN_CANSEL				= "BtnCansel";
uiZhenYuan.OBJ_REFINE				= "ObjRefine";
uiZhenYuan.OBJ_EXP					= "ObjExp";
uiZhenYuan.OBJ_EXPBOOK				= "ObjExpBook";
uiZhenYuan.TXT_TIP					= "TxtTip";
uiZhenYuan.TXT_TIPEXP				= "TxtTipExp";
uiZhenYuan.TXT_BALANCEEXP			= "TxtExpBalance"
uiZhenYuan.LST_ATTR					= "LstAttr";
uiZhenYuan.IMG_EFFECT				= "ImgEffect";
uiZhenYuan.BTNLEVEL1				= "BtnLevel1";
uiZhenYuan.BTNLEVEL10				= "BtnLevel10";
uiZhenYuan.BTNLEVELALL				= "BtnLevelAll";
uiZhenYuan.BTN_LEVEL				= "BtnLevel";
uiZhenYuan.BTN_APPLYUNBIND			= "BtnApplyUnBind";
uiZhenYuan.BTN_BIND					= "BtnBind";
uiZhenYuan.BTN_UNBIND				= "BtnUnBind";
uiZhenYuan.TXT_ZHENYUANINTRODUCE	= "TxtZhenYuanInfo";

uiZhenYuan.PAGE_SET					= "PageSet";
-- Ò³Ãæ
uiZhenYuan.tbPAGES					=
{
	{szBtn = "BtnPageExperience",		szPage = "PageExperience",		},
	{szBtn = "BtnPageRefine",			szPage = "PageRefine",			},
	{szBtn = "BtnPageMain",				szPage = "PageMain",			},
}

local nPos1 = 0;
local nPos2 = 1;
local nPos3 = 2;

--local tbRefineCont1		= { nOffsetX = nPos1, bUse = 0, nRoom = Item.ROOM_ZHENYUAN_REFINE, bSendToGift = 1};
--local tbRefineCont2		= { nOffsetX = nPOs2, bUse = 0, nRoom = Item.ROOM_ZHENYUAN_REFINE, bSendToGift = 1};
--local tbRefineCont3		= { nOffsetX = nPos3, bUse = 0, nRoom = Item.ROOM_ZHENYUAN_REFINE, bSendToGift = 1};
local tbRefineCont1		= { bUse = 0, nRoom = Item.ROOM_ZHENYUAN_REFINE_MAIN, bSendToGift = 1};
local tbRefineCont2		= { bUse = 0, nRoom = Item.ROOM_ZHENYUAN_REFINE_CONSUME, bSendToGift = 1};
local tbRefineCont3		= { bUse = 0, nRoom = Item.ROOM_ZHENYUAN_REFINE_RESULT, bSendToGift = 1};
local tbXiuLianCont		= { bUse = 0, nRoom = Item.ROOM_ZHENYUAN_XIULIAN_ZHENYUAN, bSendToGift = 1};
local tbBookCont		= { bUse = 0, nRoom = Item.ROOM_ZHENYUAN_XIULIAN_ITEM, bSendToGift = 1};

-- Á¶»¯
function tbRefineCont1:CheckSwitchItem(pDrop, pPick, nX, nY)
	if (pDrop) then
		if Ui(Ui.UI_ZHENYUAN).nRefineResult == 1 then
			Ui(Ui.UI_ZHENYUAN).nRefineResult = 0;
			Ui(Ui.UI_ZHENYUAN).tbObjRefine3:ClearRoom(nil, 0, 0);
		end
		
		local ret = Item.tbZhenYuan:CheckRefineItem(pDrop, 1);
		if (1 ~= ret) then
			me.Msg(ret);
			return 0;
		end
		
		-- todo delete 
		--[[
		if (3 == nX) then
			return 0;		-- Á¶»¯ºóÕæÔª¸ñ ²»ÄÜ·ÅÕæÔª
		end
		
		if (pDrop.szClass ~= "zhenyuan") then
			me.Msg("Ö»ÄÜ·ÅÖÃÕæÔª£¡");
			return	0;
		end
		
		if(2 == nX) then
			if (1 == Item.tbZhenYuan:GetEquiped(pDrop)) then
				me.Msg("Ö»ÄÜ·ÅÖÃÎ´»¤ÌåµÄÕæÔª£¡");
				return 0;
			end
		elseif(1 == nX) then
			if(1 == Ui(Ui.UI_ZHENYUAN):IsPrefect(pDrop)) then
				me.Msg("¸ÃÕæÔªËùÓÐ×ÊÖÊÒÑÂú£¬²»ÐèÒªÁ¶»¯£¡");
				return 0;
			end
		end	
		--]]
	end
	
	Ui(Ui.UI_ZHENYUAN):PlaceZhenYuanRefine(1, pDrop);
	
	return 1;
end

function tbRefineCont2:CheckSwitchItem(pDrop, pPick, nX, nY)
	if (pDrop) then
		if Ui(Ui.UI_ZHENYUAN).nRefineResult == 1 then
			Ui(Ui.UI_ZHENYUAN).nRefineResult = 0;
			Ui(Ui.UI_ZHENYUAN).tbObjRefine3:ClearRoom(nil, 0, 0);
		end
		
		local ret = Item.tbZhenYuan:CheckRefineItem(pDrop, 2);
		if (1 ~= ret) then
			me.Msg(ret);
			return 0;
		end
		
		-- todo delete
		--[[
		if (3 == nX) then
			return 0;		-- Á¶»¯ºóÕæÔª¸ñ ²»ÄÜ·ÅÕæÔª
		end
		
		if (pDrop.szClass ~= "zhenyuan") then
			me.Msg("Ö»ÄÜ·ÅÖÃÕæÔª£¡");
			return	0;
		end
		
		if(2 == nX) then
			if (1 == Item.tbZhenYuan:GetEquiped(pDrop)) then
				me.Msg("Ö»ÄÜ·ÅÖÃÎ´»¤ÌåµÄÕæÔª£¡");
				return 0;
			end
		elseif(1 == nX) then
			if(1 == Ui(Ui.UI_ZHENYUAN):IsPrefect(pDrop)) then
				me.Msg("¸ÃÕæÔªËùÓÐ×ÊÖÊÒÑÂú£¬²»ÐèÒªÁ¶»¯£¡");
				return 0;
			end
		end	
		--]]
	end
	
	Ui(Ui.UI_ZHENYUAN):PlaceZhenYuanRefine(2, pDrop);
	
	return 1;
end

function tbRefineCont3:CheckSwitchItem(pDrop, pPick, nX, nY)
	-- Ê¼ÖÕÄÜÄÃ³öÀ´
	if pPick then
		Ui(Ui.UI_ZHENYUAN).nRefineResult = 0;
		return 1;
	end
	
	-- ²»ÄÜ·ÅÈë
	return 0;
end

-- ÐÞÁ¶
function tbXiuLianCont:CheckSwitchItem(pDrop, pPick, nX, nY)
	if (pDrop) then
		if (pDrop.szClass ~= "zhenyuan") then
			me.Msg("Chỉ có thể bỏ vào chân nguyên!");
			return	0;
		end
		if (Item.tbZhenYuan:GetLevel(pDrop) == 120) then
			me.Msg("Chân nguyên này đã đạt tối đa, không cần tu luyện!"); 
			return 0;
		end
	end
	Ui(Ui.UI_ZHENYUAN):PlaceZhenYuanXiuLian(pDrop);
	return 1;
end

function tbBookCont:CheckSwitchItem(pDrop, pPick, nX, nY)
	if (pDrop) then
		if (pDrop.szClass ~= "partnerexpbook") then
			me.Msg("Chỉ có thể bỏ vào Sách kinh nghiệm đồng hành!");
			return 0;
		end
		-- todo ÊÇ·ñÌí¼Ó¼ì²â¹ý¶à¾­ÑéÊé
	end	
	return Ui(Ui.UI_ZHENYUAN):PlaceExpBook(pDrop, pPick, nX, nY);
end

-- ÅÐ¶ÏÕæÔªËùÓÐ×ÊÖÊÊÇ·ñÒÑÂú
function uiZhenYuan:IsPrefect(pItem)
	local nAttrMax = 20;
	if (nAttrMax == Item.tbZhenYuan:GetAttribPotential1(pItem)
		and nAttrMax == Item.tbZhenYuan:GetAttribPotential2(pItem)
		and nAttrMax == Item.tbZhenYuan:GetAttribPotential3(pItem)
		and nAttrMax == Item.tbZhenYuan:GetAttribPotential4(pItem)
		) then
		return 1;
	end
	return 0;
end

--uiZhenYuan.szTipRefine		= "ÇëÔÚÉÏ·½·ÅÈëÕæÔª£¬Á¶»¯ºó<color=orange>¸±ÕæÔª½«ÏûÊ§<color>£¡ÒÑ»¤ÌåÕæÔªÖ»ÄÜ×÷ÎªÖ÷ÕæÔªÁ¶»¯¡£<enter>ÇëÑ¡ÔñÁ¶»¯";
uiZhenYuan.tbTip			=
{
	{
		"Hãy bỏ vào chân nguyên, sau khi luyện hóa <color=orange>chân nguyên phụ sẽ biến mất<color>!<enter>Chân nguyên đã hộ thể chỉ có thể xem như luyện hóa chân nguyên chính.",
		"Hãy chọn thuộc tính luyện hóa (<color=red>cần %s Bạc<color>):<enter>",
	},	-- Á¶»¯
	
	{
		"★ Trước khi dùng sách exp, chân nguyên hãy đánh quái lên cấp",
		"★ Dùng sách exp sẽ lên cấp nhanh (không hạn chế số sách)",
	},	-- ÐÞÁ¶
}

local nPXIULIAN = 1;
local nPREFINE = 2;
local nPGMAIN = 3;
local nExpBookMaxNum = 18;

function uiZhenYuan:CanOpenWnd()
	if Item.tbZhenYuan.bOpen and Item.tbZhenYuan.bOpen == 1 then
		return 1;
	end
	
	Ui:ServerCall("UI_TASKTIPS", "Begin", "Hệ thống chân nguyên chưa mở, xin hãy đợi");
	return 0;
end

function uiZhenYuan:Init()
	self.nCurPageIndex = nPREFINE;
	self.nRefineResult = 0;
end

function uiZhenYuan:OnCreate()
	self:CreateObjContainer();
end

-- Ïú»ÙOBJÈÝÆ÷
function uiZhenYuan:OnDestroy()
	tbObject:UnregContainer(self.tbObjRefine1);
	tbObject:UnregContainer(self.tbObjRefine2);
	tbObject:UnregContainer(self.tbObjRefine3);
	tbObject:UnregContainer(self.tbObjXiuLianZhenYuan);
	tbObject:UnregContainer(self.tbObjExpBook);
end

function uiZhenYuan:CreateObjContainer()
	-- Á¶»¯¸ñ×Ó
	self.tbObjRefine = {};
	for i = 1, 3 do
		--local tbCont = tbRefineCont;
		--tbCont.nOffsetX = i;
		--self.tbObjRefine[i].CheckSwitchItem = self.CheckSwitchItem;
	end
	
	self.tbObjRefine1 = tbObject:RegisterContainer(
			self.UIGROUP, 
			(self.OBJ_REFINE..1), 
			1, 1, 
			tbRefineCont1,
			"itemroom"
			);
			
	self.tbObjRefine2 = tbObject:RegisterContainer(
			self.UIGROUP, 
			(self.OBJ_REFINE..2), 
			1, 1, 
			(tbRefineCont2),
			"itemroom"
			);
			
	self.tbObjRefine3 = tbObject:RegisterContainer(
			self.UIGROUP, 
			(self.OBJ_REFINE..3), 
			1, 1, 
			(tbRefineCont3),
			"itemroom"
			);
	
	-- ÐÞÁ¶ ÕæÔª¸ñ×Ó
	self.tbObjXiuLianZhenYuan = tbObject:RegisterContainer(
			self.UIGROUP, 
			(self.OBJ_EXP), 
			1, 1, 
			tbXiuLianCont, 
			"itemroom"
			);
		
	-- ÐÞÁ¶ ¾­ÑéÊé¸ñ×Ó	
	self.tbObjExpBook = tbObject:RegisterContainer(
			self.UIGROUP, 
			(self.OBJ_EXPBOOK), 
			6, 3, 
			tbBookCont, 
			"itemroom"
			);
end

function uiZhenYuan:OnOpen()
	me.ApplyZhenYuanEnhance(Item.tbZhenYuan.emZHENYUAN_ENHANCE_OPENWINDOW);
	
	if (self.bFirstOpen) then	-- µÚÒ»´Î´ò¿ª
		self.bFirstOpen = 1;
		self:CreateObjContainer();
	end
	self.nCurPageIndex = nPXIULIAN;		--1.Á¶»¯·ÖÒ³£¬2.ÐÞÁ¶·ÖÒ³
	self:UpdatePage(self.nCurPageIndex);
	self:UpdateObjCont();
	
	--UiManager:OpenWindow(Ui.UI_ITEMBOX);
end

function uiZhenYuan:OnClose()
	me.ApplyZhenYuanEnhance(Item.tbZhenYuan.emZHENYUAN_ENHANCE_NONE);
	if (self.nCurPageIndex == nPREFINE) then
		self:RefineCansel();
		UiManager:ReleaseUiState(UiManager.UIS_ZHENYUAN_REFINE);
	else
		self:XiuLianCansel();
		UiManager:ReleaseUiState(UiManager.UIS_ZHENYUAN_XIULIAN);
	end
end

function uiZhenYuan:OnButtonClick(szWnd, nParam)
	local nPage = self.nCurPageIndex;
	if (szWnd == self.BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
    elseif (szWnd == self.BTN_OK) then
    	if (nPREFINE == nPage) then
    		self:ClickRefine();
    	else
    		self:ClickXiuLian();
    	end
    elseif (szWnd == self.BTN_CANSEL) then
    	UiManager:CloseWindow(self.UIGROUP);
    --[[
    elseif szWnd == self.BTNLEVEL1 then
    	self:ApplyLiLianExp(1);
    elseif szWnd == self.BTNLEVEL10 then
    	self:ApplyLiLianExp(2);
    elseif szWnd == self.BTNLEVELALL then
    	self:ApplyLiLianExp(3);
    	--]]
    elseif szWnd == self.BTN_LEVEL then
    	-- TODO
    	UiManager:CloseWindow(self.UIGROUP);
    	me.CallServerScript({ "ZhenYuanCmd", "ApplyUseLilianTime"});
    elseif szWnd == self.BTN_UNBIND then
    	me.CallServerScript({ "ZhenYuanCmd", "SwitchBind", me.nId, Item.SWITCHBIND_UNBIND});
    elseif szWnd == self.BTN_BIND then
    	me.CallServerScript({ "ZhenYuanCmd", "SwitchBind", me.nId, Item.SWITCHBIND_BIND});
    elseif szWnd == self.BTN_APPLYUNBIND then
    	me.CallServerScript({ "ZhenYuanCmd", "ApplyUnBind", me.nId});
    end
    
    for i = 1,3 do
        if (szWnd == self.tbPAGES[i].szBtn) then
            self.nCurPageIndex	= i;
            self:UpdatePage(self.nCurPageIndex);
            return;
        end
    end
end

function uiZhenYuan:UpdatePage(nPage)
	PgSet_ActivePage(self.UIGROUP, self.PAGE_SET, self.tbPAGES[nPage].szPage);
	Wnd_SetVisible(self.UIGROUP, self.BTN_OK, 1);
	Wnd_SetVisible(self.UIGROUP, self.BTN_CANSEL, 1);
	if (nPREFINE == nPage) then	-- Á¶»¯
		self:XiuLianCansel();
		Btn_SetTxt(self.UIGROUP, self.BTN_OK, "Luyện hóa");
		UiManager:ReleaseUiState(UiManager.UIS_ZHENYUAN_XIULIAN);
		UiManager:SetUiState(UiManager.UIS_ZHENYUAN_REFINE);
		self:UpdateTips(1);
	elseif (nPXIULIAN == nPage) then				-- ÐÞÁ¶
		self:RefineCansel();
		self:UpdateLiLianInfo();
		Btn_SetTxt(self.UIGROUP, self.BTN_OK, "Tu luyện");
		UiManager:ReleaseUiState(UiManager.UIS_ZHENYUAN_REFINE);
		UiManager:SetUiState(UiManager.UIS_ZHENYUAN_XIULIAN);
		self:UpdateTips(1);
	elseif (nPGMAIN == nPage) then
		Wnd_Hide(self.UIGROUP, self.BTN_OK);
		Wnd_Hide(self.UIGROUP, self.BTN_CANSEL);
		UiManager:ReleaseUiState(UiManager.UIS_ZHENYUAN_REFINE);
		UiManager:ReleaseUiState(UiManager.UIS_ZHENYUAN_XIULIAN);
		self:XiuLianCansel();
		self:RefineCansel();
		self:UpdateHelpPage();
	end
end

function uiZhenYuan:UpdateHelpPage()
	local nApplyTime = me.GetTask(Item.tbZhenYuan.TASK_GID_UNBIND, Item.tbZhenYuan.TASK_SUBID_UNBIND);
	if nApplyTime == 0 or GetTime() - nApplyTime < 0 or GetTime() - nApplyTime > Item.tbZhenYuan.UNBIND_MAX_TIME then
		Btn_SetTxt(self.UIGROUP, self.BTN_APPLYUNBIND, "Xin mở");
		Wnd_SetEnable(self.UIGROUP, self.BTN_UNBIND, 0);
	else
		Btn_SetTxt(self.UIGROUP, self.BTN_APPLYUNBIND, "Hủy mở");
		if (GetTime() - nApplyTime < Item.tbZhenYuan.UNBIND_MIN_TIME) then
			Wnd_SetEnable(self.UIGROUP,self.BTN_UNBIND, 0);
		else
			Wnd_SetEnable(self.UIGROUP, self.BTN_UNBIND, 1);
		end
	end	
	
	local szText = [[    Chân nguyên được ngưng tụ từ đồng hành cấp 1, chỉ có 1 bộ phận đồng hành có thể ngưng tụ thành chân nguyên, được thể hiện rõ trong giao diện đồng hành.
		<color=green>1. Thuộc tính chân nguyên<color><enter>    Mỗi chân nguyên có 4 dòng thuộc tính, trị thuộc tính thể hiện đẳng cấp của thuộc tính đó, cấp thuộc tính càng cao hiệu quả càng ưu việt.
		<color=green>2. Cấp sao tư chất thuộc tính chân nguyên<color><enter>    Cấp sao bên dưới mỗi dòng thuộc tính thể hiện tư chất của thuộc tính đó. Cấp sao càng cao, trị thuộc tính tăng càng nhiều sau khi thăng cấp chân nguyên.
		 <color=green>3. Tu luyện chân nguyên<color><enter>    Tu luyện là chỉ sự thăng cấp chân nguyên, thăng cấp mới có thể nâng cao những thuộc tính khác.
		 <color=green>4. Luyện hóa chân nguyên<color><enter>    Việc thăng cấp tư chất thuộc tính chân nguyên được gọi là luyện hóa chân nguyên.
		<color=green>5. Giá trị của chân nguyên<color><enter>    Cấp tư chất thuộc tính quyết định giá trị của chân nguyên, giá trị càng cao, xếp hạng chân nguyên càng cao, sau khi trang bị vào người, sức chiến đấu cộng thêm cũng nhiều hơn.
		<color=green>6. Khóa và mở khóa chân nguyên<color><enter>    Có thể khóa chân nguyên thông qua nút chức năng bên dưới, đương nhiên cũng có thể mở khóa. Để mở khóa cần phải xin phép, thời gian xin mở khóa là 3 ngày!
		<color=green>7. Kinh nghiệm chuyển thành thời gian luyện tập<color><enter>    Các vị hiệp sĩ có thể dùng tu vi bản thân để tiến hành tu luyện, dùng kinh nghiệm chuyển thành kinh nghiệm luyện tập của chân nguyên.
	    <color=orange>Thông tin chi tiết hãy xem trong Cẩm nang trợ giúp F12 - Chi tiết - Chân nguyên<color>]];
	
	Txt_SetTxt(self.UIGROUP, self.TXT_ZHENYUANINTRODUCE, szText);
end

function uiZhenYuan:OnAnimationOver(szWnd)
	if (szWnd == self.IMG_EFFECT) then
		Wnd_Hide(self.UIGROUP, self.IMG_EFFECT);	-- ²¥·ÅÍê±Ï£¬Òþ²ØÍ¼Ïñ
	end
end

function uiZhenYuan:OnListSel(szWnd, nParam)
	if szWnd == self.LST_ATTR then
		local nKey = Lst_GetCurKey(self.UIGROUP, self.LST_ATTR);
		self.nSelect = nKey;
		local pItem = me.GetItem(Item.ROOM_ZHENYUAN_REFINE_CONSUME, 0, 0);
		if not pItem then
			Txt_SetTxt(self.UIGROUP, self.TXT_TIP, "Hãy bỏ vào chân nguyên phụ!");
			return;
		end
		self:UpdateTips(2, self.tbAttrList[nKey].szTip);
		if (self.nCurPageIndex == nPREFINE) then
			self:UpdateRefine();
		end
	end
end

-- ¸üÐÂÒ³ÃæÕýÖÐµÄÌáÊ¾ÎÄ×Ö
function uiZhenYuan:UpdateTips(nTipId, szTipEx, szTipEx2)
	local nPage = self.nCurPageIndex;
	if (nPREFINE == nPage) then
		local szTip = self.tbTip[1][nTipId];
		if (szTipEx) then
			szTip = szTip .. szTipEx;
		end
		Txt_SetTxt(self.UIGROUP, self.TXT_TIP, szTip);
	else
		local szTip = self.tbTip[2][1];
		if (szTipEx) then
			szTip = szTip .. szTipEx;
		end
		szTip = szTip .. "<enter>";
		szTip = szTip .. self.tbTip[2][2];
		if (szTipEx2) then
			szTip = szTip .. szTipEx2;
		end
		Txt_SetTxt(self.UIGROUP, self.TXT_TIPEXP, szTip);
	end
end

-- Á¶»¯Ãæ°å£º·ÅÈëÕæÔª nType = 1 Ö÷ÕæÔª or = 2  ¸±ÕæÔª or = 0 Çå¿Õ
function uiZhenYuan:PlaceZhenYuanRefine(nType, pItem)
	self:UpdateTips(1);
	if (not nType or 0 == nType) then	
		self.tbAttrList = nil;
		self:UpdateAttrList();
		return;
	end
	
	local pLocItem1 = nil;
	local pLocItem2 = nil;
	
	if (1 == nType) then
		pLocItem1 = pItem;
		pLocItem2 = self:GetZhenYuanRefine2();
	end

	if (2 == nType) then
		pLocItem1 = self:GetZhenYuanRefine1();
		pLocItem2 = pItem;
	end
	
	if (pLocItem1) then	-- Ö÷ÕæÔª
		self:UpdateTips(1);
		self.tbAttrList = {};
		
		local tbAttrName = {};
		for i = 1, 4 do
			local nAttrMagicId = Item.tbZhenYuan:GetAttribMagicId(pLocItem1, i);
			local szAttrName = Item.tbZhenYuan:GetAttribTipName(nAttrMagicId);
			tbAttrName[i] = szAttrName;
		end
		local tbAttrVal = {};
		tbAttrVal[1] = Item.tbZhenYuan:GetAttribPotential1(pLocItem1);
		tbAttrVal[2] = Item.tbZhenYuan:GetAttribPotential2(pLocItem1);
		tbAttrVal[3] = Item.tbZhenYuan:GetAttribPotential3(pLocItem1);
		tbAttrVal[4] = Item.tbZhenYuan:GetAttribPotential4(pLocItem1);
		for i = 1, 4 do
			local szAttrStar = Item.tbZhenYuan:GetAttribStar(tbAttrVal[i]);
			self.tbAttrList[i] = {string.format("%s£º ", tbAttrName[i]), string.format("<color=gold>%s<color>", szAttrStar), "", color = nil, szTip = nil};
		end
		
		if (pLocItem2) then	-- ¸±ÕæÔª
			if (not self.tbAttrList) then
				print("[zhenyuan]:self.tbAttrList is nil");
				return;
			end
				
			local tbResult = Item.tbZhenYuan:GetAttribRefineInfo(pLocItem1, pLocItem2);
			if (tbResult) then
				for i = 1, 4 do
					if (tbResult[i]) then
						--self.tbAttrList[i].color = "green";
						local nAddedMin = tbResult[i][1][1];
						local szStarAddedMin = Item.tbZhenYuan:GetAttribStar(nAddedMin);
						local nMinProb = tbResult[i][1][2];
						local nAddedMax = tbResult[i][2][1];
						local szStarAddedMax = Item.tbZhenYuan:GetAttribStar(nAddedMax);
						local nMaxProb = tbResult[i][2][2];
							
						self.tbAttrList[i][1] = string.format("<color=green>%s<color>", self.tbAttrList[i][1]);
						self.tbAttrList[i][3] = string.format("<color=green>Ôö¼Ó<color> <color=gold>%s<color>", szStarAddedMin);
						--self.tbAttrList[i].szTip = string.format("<color=orange> %d%%¸ÅÂÊÔö¼Ó <color><color=gold>%s<color>", nMinProb, szStarAddedMin); -- ÌáÊ¾Óï¾ä
						self.tbAttrList[i].szTip = string.format("<color=orange>%d%% tỉ lệ vượt mức tăng <color> <color=gold>%s<color>", (100-nMinProb), "¡î");
					end
				end		
			end
			self:UpdateTips(2);
		end
	else
		self.tbAttrList = nil;
	end
	
	self:UpdateAttrList(self.tbAttrList);
end

function uiZhenYuan:GetStarStr(dwValue)
	local szStar = "";
	local nFloor = math.floor(dwValue);
	for i = 1, nFloor do
		szStar = szStar .. "★";
	end
	if (dwValue ~= nFloor) then
		szStar = szStar .. "☆";
	end
	return szStar;
end

--[[
-- Á¶»¯µÄÕæÔª£¬ nPos = 1->3 ¶ÔÓ¦ Ö÷ÕæÔª¡¢¸±ÕæÔª¡¢Á¶»¯ºóÕæÔª
function uiZhenYuan:GetZhenYuanRefine(nPos)
	-- todo change
	if (nPos1 == nPos) then
		--
		return self.pItem1;
	else
		--return me.GetItem(Item.ROOM_ZHENYUAN_REFINE_CONSUME, 0, 0);
		return self.pItem2;
	end
end
--]]

-- Á¶»¯Ö÷ÕæÔª
function uiZhenYuan:GetZhenYuanRefine1()
	return me.GetItem(Item.ROOM_ZHENYUAN_REFINE_MAIN, 0, 0);
end

-- Á¶»¯¸±ÕæÔª
function uiZhenYuan:GetZhenYuanRefine2()
	return me.GetItem(Item.ROOM_ZHENYUAN_REFINE_CONSUME, 0, 0);
end

-- ÐÞÁ¶µÄÕæÔª
function uiZhenYuan:GetZhenYuanXiuLian()
	local pItem = me.GetItem(Item.ROOM_ZHENYUAN_XIULIAN_ZHENYUAN, 0, 0);
	return pItem;
end

-- ¸ñ×ÓÖÐµÄ¾­ÑéÊé nX¡¢nY³ýÍâ
function uiZhenYuan:GetExpBookTab(pDrop, pPick, nX, nY)
	local tbExpBook = {};

	local nCnt = 1; 
	-- ¾­ÑéÊé¸ñ×ÓÎª 3*6 ¹²18¸ö
	for i = 0, 5 do
		for j = 0, 2 do
			local pItem = me.GetItem(Item.ROOM_ZHENYUAN_XIULIAN_ITEM, i, j);
			if (pItem and (i ~= nX or j ~= nY)) then
				tbExpBook[nCnt] = pItem;
				nCnt = nCnt + 1;
			end
		end
	end

	if (pDrop) then
		--tbExpBook[nY * 6 + nX] = pDrop;
		tbExpBook[nCnt] = pDrop;
	end
	
	return tbExpBook;
end

-- ¸üÐÂÕæÔªÊôÐÔÁÐ±í
function uiZhenYuan:UpdateAttrList(tbAttrList)
	Lst_Clear(self.UIGROUP, self.LST_ATTR);
	if (not tbAttrList) then
		return ;
	end
	for i = 1, #tbAttrList do
		local szCell1 = tbAttrList[i][1];
		local szCell2 = tbAttrList[i][2]; 
		local szCell3 = tbAttrList[i][3];
		local szColor = tbAttrList[i].color;
		if (szColor and string.len(szColor) > 0) then
			szCell1 = string.format("<color=%s>%s<color>", szColor, tbAttrList[i][1]);
			szCell2 = string.format("<color=%s>%s<color>", szColor, tbAttrList[i][2]);
			szCell3 = string.format("<color=%s>%s<color>", szColor, tbAttrList[i][3]);
		end
		Lst_SetCell(self.UIGROUP, self.LST_ATTR, i, 1, szCell1);
		Lst_SetCell(self.UIGROUP, self.LST_ATTR, i, 2, szCell2);
		Lst_SetCell(self.UIGROUP, self.LST_ATTR, i, 3, szCell3);
	end
end

-- µã»÷°´Å¥ Á¶»¯
function uiZhenYuan:ClickRefine()
       
    local pItemRefine = self:GetZhenYuanRefine1(); -- Ö÷ÕæÔª
    local pItemSub = self:GetZhenYuanRefine2(); -- ¸±ÕæÔª    
    if ((not pItemRefine) or (not pItemSub)) then
    	me.Msg("Hãy đặt vào Chân nguyên chính-phụ muốn luyện hóa!");
    	return;
    end 
    
    local nSelectAttrId = Lst_GetCurKey(self.UIGROUP, self.LST_ATTR);
    if not nSelectAttrId or nSelectAttrId <= 0 or nSelectAttrId > Item.tbZhenYuan.ATTRIB_COUNT then
    	me.Msg("Xin chọn các thuộc tính muốn luyện hóa để tiến hành!");
    	return;
    end
    
    local nAttrMagicId = Item.tbZhenYuan:GetAttribMagicId(pItemRefine, nSelectAttrId);
    --local szSubZhenYuan  = pItemSub.szName;
    
    -- Á¶»¯
    local nRet = Item.tbZhenYuan:ApplyRefine(pItemRefine, pItemSub, nAttrMagicId);
 
end

-- Êó±êÂÓ¹ýÁÐ±í
function uiZhenYuan:OnListOver(szWnd, nItemIndex)
	local nAttrId = Lst_GetCurKey(self.UIGROUP, self.LST_ATTR) + 1;
	if (szWnd == self.LIST_MEMBER) and nItemIndex >= 0 then
		nAttrId = nItemIndex + 1;
		--self.szTipSelected = self.tbAttrList[nAttrId].szTip;
	end
	--self:UpdateTips(2, self.tbAttrList[nAttrId].szTip);
end

-- È¡ÏûÁ¶»¯
function uiZhenYuan:RefineCansel()
	-- todo
    for i = 1, 3 do
		--self.tbObjRefine[i]:ClearRoom();
	end
	self.tbObjRefine1:ClearRoom();
	self.tbObjRefine2:ClearRoom();
	self.tbObjRefine3:ClearRoom();
	self:PlaceZhenYuanRefine();
end

-- µã»÷°´Å¥ ÐÞÁ¶
function uiZhenYuan:ClickXiuLian()
	me.ApplyZhenYuanEnhance(Item.tbZhenYuan.emZHENYUAN_ENHANCE_XIULIAN)
end

-- todo ´íÎó·´À¡

-- È¡ÏûÐÞÁ¶
function uiZhenYuan:XiuLianCansel()
	-- todoo
	self.tbObjXiuLianZhenYuan:ClearRoom();
	self.tbObjExpBook:ClearRoom();
	self:PlaceZhenYuanXiuLian();
end

-- ·ÅÈëÕæÔª ÐÞÁ¶
function uiZhenYuan:PlaceZhenYuanXiuLian(pItem)
	self:UpdateTips(1);
	
	if (not pItem) then
		--self:UpdateTips(1);
		return;
	end
	
	local tbExpBook = self:GetExpBookTab();
	
	self:UpdateXiuLianTip(pItem, tbExpBook);
end

function uiZhenYuan:PlaceExpBook(pDrop, pPick, nX, nY)

	local tbExpBook = self:GetExpBookTab(pDrop, pPick, nX, nY);
	
	local pZhenYuan = self:GetZhenYuanXiuLian();
	if (not pZhenYuan) then
		me.Msg("Hãy bỏ vào chân nguyên cần tu luyện!");
		return 0;
	end
	--[[
	if (pDrop) then
		table.insert(tbExpBook, pDrop);
	end--]]
	
	return self:UpdateXiuLianTip(pZhenYuan, tbExpBook);
end

function uiZhenYuan:UpdateXiuLianTip(pItem, tbExpBook)
	local szTipEx1 = "";
	local szTipEx2 = "";
	if (not pItem) then
		self:UpdateTips(1, "", "");
		return 0;
	end
	
	local nLevelOld = Item.tbZhenYuan:GetLevel(pItem);
	
	if (tbExpBook and Lib:CountTB(tbExpBook) >= 1) then
		local bOver, nLevelNew, nExpRemain = Item.tbZhenYuan:GetExpAdded(pItem, tbExpBook);
		if (1 == bOver) then
			me.Msg("Bạn đã bỏ quá nhiều Sách kinh nghiệm đồng hành!");
			return 0;
		end
		szTipEx2 = string.format("   Chân nguyên cấp: %0.2f <color=gold>→ %0.2f<color><enter>", nLevelOld, nLevelNew);
	end

	local nLiLianTime = me.GetTask(Item.tbZhenYuan.EXPSTORE_TASK_MAIN, Item.tbZhenYuan.EXPSTORE_TASK_SUB);
	if (0 < nLiLianTime) then
		local nLevelUp = Item.tbZhenYuan:CalExpFromTime(pItem, nLiLianTime);
		if (0 < math.floor(nLevelUp)) then
			szTipEx1 = string.format("   Kinh nghiệm luyện tập hiện tại có thể làm cho chân nguyên này tăng đến <color=gold>cấp %d<color>!", (nLevelOld + nLevelUp));
		end
	end
	self:UpdateTips(1, szTipEx1, szTipEx2);
	return 1;
end

function uiZhenYuan:UpdateRefine()
	for i = 1, 3 do
		--Lib:ShowTB(self.tbObjRefine[i]);
		--self.tbObjRefine[i]:UpdateRoom();
	end
end

function uiZhenYuan:UpdateXiuLian()
	self:UpdateLiLianInfo();
	--self.tbObjXiuLianZhenYuan:UpdateRoom();
	--self.tbObjExpBook:UpdateRoom();
end

function uiZhenYuan:UpdateLiLianInfo()
	local nLiLianTime = me.GetTask(Item.tbZhenYuan.EXPSTORE_TASK_MAIN, Item.tbZhenYuan.EXPSTORE_TASK_SUB);
	local tbEnable = {0, 0, 0};
	local pItem = me.GetItem(Item.ROOM_ZHENYUAN_XIULIAN_ZHENYUAN, 0, 0);

	if pItem and nLiLianTime > 0 then
		local nLevelUp = Item.tbZhenYuan:CalExpFromTime(pItem, nLiLianTime);
		if nLevelUp >= 1 then
			tbEnable[1] = 1;
		end
		
		if nLevelUp >= 10 then
			tbEnable[2] = 1;
		end
	end
	
	if nLiLianTime > 0 then
		tbEnable[3] = 1;
		Wnd_SetEnable(self.UIGROUP,		self.BTN_LEVEL, 	1);
	else
		Wnd_SetEnable(self.UIGROUP,		self.BTN_LEVEL, 	0);
	end
	
	--[[
	Wnd_SetEnable(self.UIGROUP,		self.BTNLEVEL1, 	tbEnable[1]);
	Wnd_SetEnable(self.UIGROUP,		self.BTNLEVEL10, 	tbEnable[2]);
	Wnd_SetEnable(self.UIGROUP,		self.BTNLEVELALL, 	tbEnable[3]);
	--]]
	
	local szTime = "Kinh nghiệm<enter>";
	szTime = szTime..string.format("%dh%dphút", math.floor(nLiLianTime/60), nLiLianTime%60);
	Txt_SetTxt(self.UIGROUP, 	self.TXT_BALANCEEXP, 	szTime);
end

function uiZhenYuan:OnSyncItem(nRoom, nX, nY)
	self:UpdateObjCont();
end


function uiZhenYuan:UpdateObjCont()
	local nPage = self.nCurPageIndex;
	if (nPREFINE == nPage) then
		self:UpdateRefine();
	else
		self:UpdateXiuLian();
	end
end


-- ×¢²áÊÂ¼þ¸üÐÂ»Øµ÷
function uiZhenYuan:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_SYNC_ITEM,		self.OnSyncItem},
		{ UiNotify.emCOREEVENT_ENHANCE_ZHENYUAN_RESULT,	self.OnResult },
		{ UiNotify.emUIEVENT_OBJ_STATE_USE,		self.StateRecvUse},		
	};
	for i = 1, 3 do
		--tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjRefine[i]:RegisterEvent());
	end
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjRefine1:RegisterEvent());
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjRefine2:RegisterEvent());
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjRefine3:RegisterEvent());
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjXiuLianZhenYuan:RegisterEvent());
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjExpBook:RegisterEvent());
	return tbRegEvent;
end

-- ×¢²á¼¼ÄÜ½çÃæOBJµÄÏûÏ¢»Øµ÷
function uiZhenYuan:RegisterMessage()
	local tbRegMsg = {};
	for i = 1, 3 do
		--tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjRefine[i]:RegisterMessage());
	end
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjRefine1:RegisterMessage());
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjRefine2:RegisterMessage());
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjRefine3:RegisterMessage());
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjXiuLianZhenYuan:RegisterMessage());
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjExpBook:RegisterMessage());
	return tbRegMsg;
end

function uiZhenYuan:OnResult(nMode, nResult)
	if (Item.tbZhenYuan.emZHENYUAN_ENHANCE_REFINE == nMode) then
		if (nResult == 1) then
			Item.tbZhenYuan:RefineResult(self.tbObjRefine1, self.tbObjRefine3);	
 			-- ²¥·ÅÌØÐ§
			Wnd_Show(self.UIGROUP, self.IMG_EFFECT);
   	 		Img_PlayAnimation(self.UIGROUP, self.IMG_EFFECT);
   	 		
   	 		-- Á¶»¯³É¹¦Ö®ºó£¬½á¹û¸ñ×ÓÖÐÓÐ¶«Î÷£¬ÔÚÏÂ´Î×ö²Ù×÷µÄÊ±ºòÒª½«Õâ¸ö¸ñ×ÓÀïµÄ¶«Î÷µ¯³ö
   	 		self.nRefineResult = 1;	   	 		
   	 		
   	 		local pItemRefine = self:GetZhenYuanRefine1(); -- Ö÷ÕæÔª
    		local pItemSub = self:GetZhenYuanRefine2(); -- ¸±ÕæÔª
    		if (not pItemRefine or not pItemSub) then 
    			return;
    		end
		else
			me.Msg("Chân nguyên không thể luyện hóa!");
		end
		self:UpdateTips(1);
	elseif(Item.tbZhenYuan.emZHENYUAN_ENHANCE_XIULIAN == nMode) then
		--self.tbObjXiuLianZhenYuan:ClearRoom();
		self.tbObjExpBook:ClearRoom();
		self:UpdateLiLianInfo();
		
		self:UpdateXiuLianTip();
	end
end

function uiZhenYuan:ApplyLiLianExp(nType)
	local pItem = me.GetItem(Item.ROOM_ZHENYUAN_XIULIAN_ZHENYUAN, 0, 0);
	if pItem then
		me.CallServerScript({ "ZhenYuanCmd", "ApplyUseLilianTime", pItem.dwId, nType});
	else
		me.Msg("Hãy bỏ vào chân nguyên cần tăng kinh nghiệm!");
	end
end

function uiZhenYuan:OnMouseEnter(szWnd)
	local szTip = "";
	if szWnd == self.BTNLEVELALL or szWnd == self.BTNLEVEL1 or szWnd == self.BTNLEVEL10 then
		szTip = "Dùng kinh nghiệm luyện tập thăng cấp chân nguyên, có thể chọn mật độ thăng cấp<enter>Nếu cấp chân nguyên đã đầy, kinh nghiệm luyện tập còn dư có thể tích lũy và sử dụng";
	end
	if szWnd == self.BTN_LEVEL then
		szTip = "Dùng kinh nghiệm luyện hóa thăng cấp chân nguyên, có thể đặt vào nhiều chân nguyên!";
	end
	
	if szTip ~= "" then
		Wnd_ShowMouseHoverInfo(self.UIGROUP, szWnd, "", szTip);
	end
end

function uiZhenYuan:StateRecvUse(szUiGroup)
	if szUiGroup == self.szUiGroup then
		return;
	end
	
	if (UiManager:WindowVisible(self.UIGROUP) ~= 1) then
		return;
	end
	
	if self.nCurPageIndex ~= nPXIULIAN then
		return;
	end
	
	local tbObj = tbMouse:GetObj();
	if not tbObj then
		return;
	end
	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
	
	if (pItem.IsEquip() == 1) then
		self.tbObjXiuLianZhenYuan:ClearRoom();
		self.tbObjXiuLianZhenYuan:SpecialStateRecvUse();
	else
		self.tbObjExpBook:SpecialStateRecvUse();
	end	
end
