local tbPreView 	= Ui(Ui.UI_PREVIEW)
local tbObject		= Ui.tbLogic.tbObject;
local tbPreViewMgr = Ui.tbLogic.tbPreViewMgr;

local OBJ_EQUIP_PREVIEW		= "ObjPreview";
local BTN_CLOSE 		 	= "BtnClose";
local BTN_RESET				= "BtnReset";
local BTN_LEFT				= "BtnLeft";
local BTN_RIGHT				= "BtnRight";
local TXT_NAME				= "TxtName";
local MAXDIRVIEW			= 16;

local tbObjMainCont	= {
	[0]		= 	"Obj_0",
	[4]		= 	"Obj_4",
	[6]		= 	"Obj_6",
	[8]		= 	"Obj_8",
	[10]	=	"Obj_10",
	[12]	= 	"Obj_12",
	[14]	= 	"Obj_14",
	[16]	= 	"Obj_16",
}

local BTN_EQUIP_ADD			= "EquipAdd";
local BTN_EQUIP_DEC			= "EquipDec";

 tbPreView.Init=function(self)
	self.nDirView = 0;
	self.tbTempItem	= {};
	self.nEnh = 0;
end

-- 创建期，创建OBJ容器
 tbPreView.OnCreate=function(self)
	self.tbObjPreView = {};
	self.tbObjPreView = tbObject:RegisterContainer(self.UIGROUP, OBJ_EQUIP_PREVIEW);
	
	self.tbEquipCont = {};
	for i, szText in pairs(tbObjMainCont) do
		self.tbEquipCont[i] = tbObject:RegisterContainer(self.UIGROUP, szText, 1, 1, { bSwitch = 0, bShowCd = 0, bUse = 0 });
	end	
end

 tbPreView.OnDestroy=function(self)
	tbObject:UnregContainer(self.tbObjPreView);
		for _, tbCont in pairs(self.tbEquipCont) do
		tbObject:UnregContainer(tbCont);
	end	
end

 tbPreView.OnOpen=function(self,pItem)
	self:OnCreate()
	self:Init()
	self.pPreViewItem=pItem
	self.tbPreViewPart = self:GetSelfPart()
	self:UpdatePreViewPart(pItem);
	self:UpdateEquipCont(pItem);
	self.nDirView = 0;
	self:ChangeView(1)
	self:ChangeView(-1)
	self:UpdateMainEquip(1)
	self:UpdateMainEquip(-1)
	self.nEnh = 0;
	Txt_SetTxt(self.UIGROUP, TXT_NAME, me.szName);

end

 tbPreView.OnClose=function(self)
	--tbPreViewMgr:Clear();
	--[[	for i, tb in pairs(self.tbTempItem) do
		tb.Remove();
	end;]]
self.nEnh = 0;
end


 tbPreView.OnButtonClick=function(self,szWnd, nParam)
	if (BTN_CLOSE == szWnd) then

		UiManager:CloseWindow(self.UIGROUP);

	elseif (BTN_RESET == szWnd) then
		self:ResetPreViewPart();
		--tbPreViewMgr:Clear();
		self.nDirView = 0;
	elseif (BTN_LEFT == szWnd) then
		self:ChangeView(-1);
		
	elseif (BTN_RIGHT == szWnd) then
		self:ChangeView(1);
	elseif (BTN_EQUIP_ADD == szWnd) then
		self:UpdateMainEquip(1)
	elseif (BTN_EQUIP_DEC == szWnd) then
		self:UpdateMainEquip(-1)
	end
end
 tbPreView.ResetPreViewPart=function(self)
	self.tbPreViewPart = self:GetSelfPart();
	UiNotify:OnNotify(UiNotify.emUIEVENT_PREVIEW_CHANGED);
end;
 tbPreView.ChangeView=function(self,nChange)
	
	if nChange == -1 then
		self.nDirView = self.nDirView - 1;
	elseif nChange == 1 then
		self.nDirView = self.nDirView + 1;
	end
	
	if self.nDirView > MAXDIRVIEW then
		self.nDirView = 0;	
	end
	
	if self.nDirView < 0 then
		self.nDirView = MAXDIRVIEW;
	end
	
	self:OnUpdatePreView(self.nDirView);
end
	
 tbPreView.OnUpdatePreView=function(self,nDir)
	
	local tbPart, nTemplateId, pPreViewItem = self:GetPreViewPart();
	local nItemSex = pPreViewItem.GetSex();
	local nSex = me.nSex;
	local tbObj = {};
	tbObj.nType = Ui.OBJ_NPCRES;
	tbObj.nTemplateId =nTemplateId or ((nSex == 0) and -1 or -2);
	tbObj.nAction = Npc.ACT_STAND1;
	tbObj.tbPart = tbPart;
	tbObj.nDir = nDir or 0;
	tbObj.bRideHorse = 0;
	self.tbObjPreView:SetObj(tbObj);
	UiManager:OnActiveWnd(self.UIGROUP, 1);
	
	self.nEnh = 0;
	self:UpdateEquipCont(pPreViewItem);	
end

 tbPreView.RegisterEvent=function(self)
	local tbRegEvent = {};
	tbRegEvent = self.tbObjPreView:RegisterEvent();
	return tbRegEvent;
end

 tbPreView.RegisterMessage=function(self)
	local tbRegMsg = {}
	for _, tbEquip in pairs(self.tbEquipCont) do
		tbRegMsg = Lib:MergeTable(tbRegMsg, tbEquip:RegisterMessage());
	end
	return tbRegMsg;
end

 tbPreView.RegisterEvent=function(self)
	local tbRegEvent = 
	{
		{ UiNotify.emUIEVENT_PREVIEW_CHANGED,	self.OnUpdatePreView },
	};
	return Lib:MergeTable(tbRegEvent, self.tbObjPreView:RegisterEvent());
end

 tbPreView.UpdateEquipCont=function(self,pItem)
 	local tbPart, nTemplateId, pPreViewItem =self:GetPreViewPart();
	if (not pItem) then return end
	
	self.nMaxEnhance	= Item:CalcMaxEnhanceTimes(pItem)
	for i, v in pairs(tbObjMainCont) do
		self.tbEquipCont[i]:ClearObj();
	end
	for i, v in pairs(tbObjMainCont) do
		if i<=self.nMaxEnhance then
			self.tbTempItem[i] = KItem.CreateTempItem(
				pItem.nGenre,--制作的物品
				pItem.nDetail,
				pItem.nParticular,
				pItem.nLevel,
				pItem.nSeries,--物品五行属性
				i,
				pItem.nLucky,
				pItem.GetGenInfo(),
				0,
				pItem.dwRandSeed,
				pItem.nIndex
			);
			--me.Msg(string.format(self.tbTempItem[i].nIndex));
			local tbObj	= nil;
			
			if self.tbTempItem[i] then
				tbObj = {};
				tbObj.nType = Ui.OBJ_ITEM;
				tbObj.pItem = self.tbTempItem[i];
				self.tbEquipCont[i]:SetObj(tbObj);
			end
		end
	end
end


 tbPreView.UpdateMainEquip=function(self,nAdd)
	local tbPart, nTemplateId, pPreViewItem =self:GetPreViewPart();
	--local nMaxEnhance	= Item:CalcMaxEnhanceTimes(self.pPreViewItem);
	--print("2+2",self.nMaxEnhance)
	pPreViewItem=self.pPreViewItem
	if (self.nEnh + nAdd < 0) or (self.nEnh + nAdd > self.nMaxEnhance) then
		--print("3+3",self.nEnh,nAdd)
		return
	end;

	self.nEnh = self.nEnh + nAdd;
	--me.Msg(string.format(self.nEnh));
	self.tbTempItem[0] = KItem.CreateTempItem(
				pPreViewItem.nGenre,
				pPreViewItem.nDetail,
				pPreViewItem.nParticular,
				pPreViewItem.nLevel,
				pPreViewItem.nSeries,
				self.nEnh,
				pPreViewItem.nLucky,
				pPreViewItem.GetGenInfo(),
				0,
				pPreViewItem.dwRandSeed,
				pPreViewItem.nIndex
			);
			--me.Msg(tostring(self.tbTempItem[0].nIndex));
			local tbObj	= nil;
			
			if self.tbTempItem[0] then
				tbObj = {};
				tbObj.nType = Ui.OBJ_ITEM;
				tbObj.pItem = self.tbTempItem[0];

				self.tbEquipCont[0]:SetObj(tbObj);
			end
end
 tbPreView.SetPreViewItem=function(self,pItem)
	if not pItem then
		return;
	end
	self.pPreViewItem	= pItem;
	if pItem.IsEquip() ~= 1 then
		return;	
	end
	local nSex  = me.nSex;
	local nItemSex = pItem.GetSex();
	
	if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
		UiManager:CloseWindow(Ui.UI_PREVIEW);
	end
	if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
		UiManager:OpenWindow(Ui.UI_PREVIEW,pItem);
		self.tbPreViewPart = self:GetSelfPart();
	end
	self:UpdatePreViewPart(pItem);
end
tbPreView.GetPreViewPart=function(self)
	return self.tbPreViewPart, self.nTemplateId, self.pPreViewItem;
end
tbPreView.UpdatePreViewPart=function(self,pItem)
	if not pItem then
		return;
	end
	
	local nSex  = me.nSex;
	local nItemResId = pItem.GetResourceId(nSex);
	local nItemColorScheme = pItem.GetChangeColorScheme;
		
	if pItem.nDetail == Item.EQUIP_HELM then
		self.tbPreViewPart[Npc.NPCRES_PART_HELM] =				
		{
			nResId = nItemResId or 0,
			nChangeColorScheme = nItemColorScheme or 0,
		}
		
	elseif pItem.nDetail == Item.EQUIP_ARMOR then
		self.tbPreViewPart[Npc.NPCRES_PART_ARMOR] =				
		{
			nResId = nItemResId or 0,
			nChangeColorScheme = nItemColorScheme or 0,
		}
	
	elseif pItem.nDetail == Item.EQUIP_MELEE_WEAPON or pItem.nDetail == Item.EQUIP_RANGE_WEAPON then
		self.tbPreViewPart[Npc.NPCRES_PART_WEAPON] =				
		{
			nResId = nItemResId or 0,
			nChangeColorScheme = nItemColorScheme or 0,
		}
	elseif pItem.nDetail == Item.EQUIP_MASK then
		self.nTemplateId = pItem.GetBaseAttrib()[1].tbValue[1];
	end
	UiNotify:OnNotify(UiNotify.emUIEVENT_PREVIEW_CHANGED);
end
 tbPreView.GetSelfRes=function(self)
	local pItemHead	= me.GetItem(Item.ROOM_EQUIP, Item.EQUIPPOS_HEAD, 0);		-- 帽子
	local pItemBody = me.GetItem(Item.ROOM_EQUIP, Item.EQUIPPOS_BODY, 0);		-- 衣服
	local pItemWeapon = me.GetItem(Item.ROOM_EQUIP, Item.EQUIPPOS_WEAPON, 0);	-- 武器
	local pItemHorse = me.GetItem(Item.ROOM_EQUIP, Item.EQUIPPOS_HORSE, 0);		-- 马
	
	local tbNpcRes = {};
	local nSex  = me.nSex;

	if pItemHead then
		tbNpcRes[1] = 
	 	{ 
	 		nResId = pItemHead.GetResourceId(nSex);
			nColorScheme = pItemHead.GetChangeColorScheme();
		}
	end

	if pItemBody then
		tbNpcRes[2] = 
	 	{ 
	 		nResId = pItemBody.GetResourceId(nSex);
			nColorScheme = pItemBody.GetChangeColorScheme();
		}
	end
	
	if pItemWeapon then
		tbNpcRes[3] = 
	 	{ 
	 		nResId = pItemWeapon.GetResourceId(nSex);
			nColorScheme = pItemWeapon.GetChangeColorScheme();
		}
	end

	if pItemHorse then
		tbNpcRes[4] = 
	 	{ 
	 		nResId = pItemHorse.GetResourceId(nSex);
			nColorScheme = pItemHorse.GetChangeColorScheme();
		}
	end	
	return tbNpcRes;
	
end
	
 tbPreView.GetSelfPart=function(self)

	local tbNpcRes = self:GetSelfRes();
	 
	local tbPart =
	{
		[Npc.NPCRES_PART_HELM] =
		{
			nResId = (tbNpcRes[1]) and tbNpcRes[1].nResId or 0,
			nChangeColorScheme = (tbNpcRes[1]) and tbNpcRes[1].nColorScheme or 0,
		},
		[Npc.NPCRES_PART_ARMOR] =
		{
			nResId = (tbNpcRes[2]) and tbNpcRes[2].nResId or 0,
			nChangeColorScheme = (tbNpcRes[2]) and tbNpcRes[2].nColorScheme or 0,
		},
		[Npc.NPCRES_PART_WEAPON] =
		{
			nResId = (tbNpcRes[3]) and tbNpcRes[3].nResId or 0,
			nChangeColorScheme = (tbNpcRes[3]) and tbNpcRes[3].nColorScheme or 0,
		},
		[Npc.NPCRES_PART_HORSE] =
		{
			nResId = (tbNpcRes[4]) and tbNpcRes[4].nResId or 0,
			nChangeColorScheme =  (tbNpcRes[4]) and tbNpcRes[4].nColorScheme or 0,
		},
	};	
	
	self.nTemplateId = nil;
	
	return tbPart;
end