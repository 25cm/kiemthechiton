Ui.tbLogic.tbPreViewMgr = {};
local tbPreViewMgr = Ui.tbLogic.tbPreViewMgr;
local tbTempItem = Ui.tbLogic.tbTempItem;
local self=tbPreViewMgr
 tbPreViewMgr.Init=function(self)
	self.tbPreViewPart = {};
	--self.tbTempItemCont = {};
end

 tbPreViewMgr.Clear=function(self)
	--[[if #self.tbTempItemCont == 0 then
		return;	
	end
	
	for i, pItem in ipairs(self.tbTempItemCont) do
		if pItem then
			tbTempItem:Destroy(pItem);
			self.tbTempItemCont[i] = nil;
			
		end
	end]]
end

 tbPreViewMgr.LinkToPreView=function(self,nItemGenre, nDetailType, nParticularType, nLevel, nSeries)
	self:Init()
	local pItem = tbTempItem:Create(nItemGenre, nDetailType, nParticularType, nLevel, nSeries);	-- 创建临时道具对象
	print(nItemGenre, nDetailType, nParticularType, nLevel, nSeries)
	if (not pItem) then
		return;
	end	
	if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
		UiManager:CloseWindow(Ui.UI_PREVIEW);
	end
	if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
		UiManager:OpenWindow(Ui.UI_PREVIEW,pItem);
		--self.tbPreViewPart = self:GetSelfPart();
	end
	--self.tbTempItemCont[#self.tbTempItemCont + 1] = pItem;
	--self:SetPreViewItem(pItem);
end

 tbPreViewMgr.SetPreViewItem=function(self,pItem)
	if not pItem then
		return;
	end
	self.pPreViewItem	= pItem;
	if pItem.IsEquip() ~= 1 then
		return;	
	end
	local nSex  = me.nSex;
	local nItemSex = pItem.GetSex();
	--print(pItem.nItemGenre, pItem.nDetailType, pItem.nParticularType, pItem.nLevel, pItem.nSeries)
	print("sex",nItemSex)
	--if nItemSex and nSex ~= nItemSex then
	--	UiManager:OpenWindow(Ui.UI_INFOBOARD, "不能预览该装备！");
	--	return;
	--end
	
	if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
		UiManager:CloseWindow(Ui.UI_PREVIEW);
	end
	if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
		UiManager:OpenWindow(Ui.UI_PREVIEW,pItem);
		self.tbPreViewPart = self:GetSelfPart();
	end
	self:UpdatePreViewPart(pItem);
end

 tbPreViewMgr.UpdatePreViewPart=function(self,pItem)
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

 tbPreViewMgr.GetPreViewPart=function(self,tbPreViewPart,nTemplateId,pPreViewItem)
	return self.tbPreViewPart, self.nTemplateId, self.pPreViewItem;
end;

 tbPreViewMgr.ResetPreViewPart=function(self)
	self.tbPreViewPart = self:GetSelfPart();
	UiNotify:OnNotify(UiNotify.emUIEVENT_PREVIEW_CHANGED);
end;

 tbPreViewMgr.GetSelfRes=function(self)
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
	
 tbPreViewMgr.GetSelfPart=function(self)

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