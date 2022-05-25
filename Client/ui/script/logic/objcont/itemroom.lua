
-- UI Object容器：对应角色道具空间的容器基类

Require("\\ui\\script\\logic\\objcont\\base.lua");

local tbObject	 = Ui.tbLogic.tbObject;
local tbMouse	 = Ui.tbLogic.tbMouse;
local tbItemRoom = tbObject:NewContainerClass("itemroom", "base");

local MAPPING_ROOM =				-- 该表注册所有的映射道具空间，即不存放道具实体，而只含有映射，在这些空间中放有映射的道具一律不显示在实际空间中
{
	Item.ROOM_MAIL,					-- 信件附件
	Item.ROOM_TRADE,				-- 交易栏
	Item.ROOM_TRADECLIENT,			-- 交易过程中对方的交易栏
	Item.ROOM_GIFT,					-- 客户端给予界面
	Item.ROOM_ENHANCE_EQUIP,		-- 装备强化/玄晶剥离装备栏空间
	Item.ROOM_ENHANCE_ITEM,			-- 装备强化/玄晶剥离玄晶放置空间
	Item.ROOM_BREAKUP,				-- 装备拆解空间
	Item.ROOM_AUCTION,
	Item.ROOM_IBSHOPCART,
};

local MAPPING_STATE =				-- 该表注册所有的映射道具空间操作状态，此种情况下不能移动角色道具
{
	UiManager.UIS_TRADE_PLAYER,		-- 交易状态
	UiManager.UIS_ACTION_GIFT,		-- 给予界面状态
	UiManager.UIS_MAIL_NEW,			-- 新建信件状态
	UiManager.UIS_EQUIP_BREAKUP, 	-- 装备拆解状态
	UiManager.UIS_EQUIP_ENHANCE,	-- 装备强化
	UiManager.UIS_EQUIP_PEEL,		-- 玄晶剥离
	UiManager.UIS_EQUIP_COMPOSE,	-- 玄晶合成
	UiManager.UIS_EQUIP_UPGRADE,	-- 印鉴升级
	UiManager.UIS_EQUIP_REFINE,		-- 装备炼化
	UiManager.UIS_EQUIP_STRENGTHEN,	-- 装备改造
	UiManager.UIS_IBSHOP_CART,
};

------------------------------------------------------------------------------------------

function tbItemRoom:init()
	self.nRoom		= Item.ROOM_MAINBAG;	-- 该容器所对应角色道具空间，默认是主背包
	self.nOffsetX	= 0;					-- 该容器所对应空间X坐标偏移
	self.nOffsetY	= 0;					-- 该容器所对应空间Y坐标偏移
	self.tbItemMap	= {};					-- 道具映射表（仅对映射空间容器有效）
end

-- 可覆盖方法：检查是否可以交换
function tbItemRoom:CheckSwitchItem(pDrop, pPick, nX, nY)
	return 1;
end

-- 公有方法：更新整个空间
function tbItemRoom:UpdateRoom()
	for j = 0, self.nLine - 1 do
		for i = 0, self.nRow - 1 do
			local nX = i + self.nOffsetX;
			local nY = j + self.nOffsetY;
			local pItem = me.GetItem(self.nRoom, nX, nY);
			local tbObj = nil;
			if pItem then
				tbObj = {};
				tbObj.nType = Ui.OBJ_OWNITEM;
				tbObj.nRoom = self.nRoom;
				tbObj.nX = nX;
				tbObj.nY = nY;
			end
			self:SetObj(tbObj, i, j);
		end
	end
end

-- 公有方法：清空整个空间
function tbItemRoom:ClearRoom()

	if (self:IsMappingRoom() ~= 1) then
		self:ClearObj();		-- 如果不是映射道具空间，只需要清除Object
		return;
	end

	-- 映射道具空间，需要自己清空间并通知更新
	local tbFind = me.FindItem(self.nRoom);
	local tbItem = {};
	if tbFind then
		for _, tb in ipairs(tbFind) do
			local tbObj = me.IsHaveItem(tb.pItem);
			if tbObj then
				table.insert(tbItem, tbObj);
			end
		end
	end

	self:ClearObj();
	me.ClearRoom(self.nRoom, self.nOffsetX, self.nOffsetY, self.nRow, self.nLine);	-- 注意只能清除容器自己所占有的那部分空间
	self.tbItemMap = {};

	for _, tb in ipairs(tbItem) do
		UiNotify:OnNotify(UiNotify.emCOREEVENT_SYNC_ITEM, tb.nRoom, tb.nX, tb.nY);	-- TODO: xyf 临时做法
	end

end

------------------------------------------------------------------------------------------
-- 覆盖方法

function tbItemRoom:CanSetObj(tbObj, nX, nY)

	if not tbObj then			-- 如果是拿出，总是允许
		return 1;
	end

	if tbObj.nType ~= Ui.OBJ_OWNITEM then
		return 0;				-- 不是角色道具不能放入
	end

	return 1;

end

function tbItemRoom:PreSetObj(tbObj)

	if not tbObj then
		return;
	end

	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
	if not pItem then
		return;					-- 找不到道具
	end

	local tbMouseObj = tbMouse.tbObj;
	if tbMouseObj and (tbMouseObj.nType == Ui.OBJ_OWNITEM) then
		local pMouse = me.GetItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY);
		if pMouse then
			if (pMouse.nIndex == pItem.nIndex) then
				return;			-- 和鼠标上道具一致
			end
		end
	end

	if (self:IsMappingRoom() ~= 1) then		-- 如果不是映射道具空间，遍历映射空间中的道具，如果存在一致道具则不允许放入
		for _, nRoom in ipairs(MAPPING_ROOM) do
			local tb = me.FindItem(nRoom);
			if tb then
				for _, tbItem in ipairs(tb) do
					if (tbItem.pItem.nIndex == pItem.nIndex) then
						return;		-- 在映射道具空间中发现一致道具
					end
				end
			end
		end
	end

	return tbObj;

end

function tbItemRoom:DoSetObj(nX, nY, tbObj)

	self.tbObjs[nY][nX] = tbObj;

	if (self:IsMappingRoom() ~= 1) then
		return;
	end

	-- 先清除位置映射表对应项
	for i, tbMap in pairs(self.tbItemMap) do
		if (tbMap.nMapX == nX) and (tbMap.nMapY == nY) then
			self.tbItemMap[i] = nil;
			break;
		end
	end

	-- 把新东西加入映射表
	if tbObj then
		local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
		local tbMap =
		{
			dwId	= pItem.dwId,				-- 以ID来标识是否同一个东西
			nRoom	= tbObj.nRoom,
			nX		= tbObj.nX,
			nY		= tbObj.nY,
			nMapX	= nX,
			nMapY	= nY,
		};
		table.insert(self.tbItemMap, tbMap);	-- 记录到位置映射表
	end

end

function tbItemRoom:CheckMouse(tbMouseObj)

	if (tbMouseObj.nType ~= Ui.OBJ_OWNITEM) then
		return 0;		-- 鼠标上不是角色道具不允许交换
	end

	local pItem = me.GetItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY);
	if (not pItem) then
		Ui:Output("[ERR] Object机制内部错误！");
		tbMouse:SetObj(nil);
		return 0;
	end

	-- 给予界面状态或交易状态不能移动角色道具
	for _, nState in ipairs(MAPPING_STATE) do
		if (UiManager:GetUiState(nState) == 1) then		-- 处于映射空间操作状态
			local bMouseMap = self:IsMappingRoom(tbMouseObj.nRoom);		-- 鼠标道具是否来自映射空间
			local bRoomMap	= self:IsMappingRoom();		-- 当前道具容器是否映射空间
			if (bMouseMap == 1) then	-- 如果鼠标道具来自映射空间
				me.SetItem(nil, tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY);	-- 清掉映射道具
			end
			if (bRoomMap == 1) then		-- 如果是放入映射空间
				return 1;				-- 总是允许该动作
			else						-- 如果是放入非映射空间
				tbMouse:SetObj(nil);	-- 先清掉鼠标，才能做后面的刷新动作
				local tbPos = me.IsHaveItem(pItem);
				if tbPos then
					UiNotify:OnNotify(UiNotify.emCOREEVENT_SYNC_ITEM, tbPos.nRoom, tbPos.nX, tbPos.nY);	-- TODO: xyf 临时做法
				end
				return 0;				-- 刷新道具实际所在位置，不允许该动作
			end
			return 0;
		end
	end

	return 1;

end

function tbItemRoom:ClickMouse(tbObj, nX, nY)

	if (tbObj.nType ~= Ui.OBJ_OWNITEM) then
		return 0;		-- 不是角色道具不允许交换
	end

	if (self:IsMappingRoom() == 1) then
		return 1;		-- 是映射道具空间则不需要下面的逻辑
	end

	local tbMouseObj = tbMouse.tbObj;
	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);

	for _, nState in ipairs(MAPPING_STATE) do
		if (UiManager:GetUiState(nState) == 1) then
			return 1;			-- 如果是映射道具空间操作状态则允许切换
		end
	end

	if (UiManager:GetUiState(UiManager.UIS_OPEN_REPOSITORY) == 1) or (UiManager:IsIdleState() == 1) then
		return 1;
	elseif UiManager:GetUiState(UiManager.UIS_TRADE_BUY) == 1 then
	elseif UiManager:GetUiState(UiManager.UIS_TRADE_SELL) == 1 then
		if (me.IsAccountLock() == 1) then
			me.Msg("Bạn đang trong trạng thái khóa, không thể bán vật phẩm");
			return;
		end
		
		if pItem.nEnhTimes > 0 then
			me.Msg("Trang bị đã cường hóa không thể bán!");
			return;
		end
		
		local nPrice =	me.GetShopSellItemPrice(pItem);
		
		if (nPrice) then
			if (nPrice + me.nCashMoney > 2000000000) then
				me.Msg("Số bạc bán được và trong túi vượt qua sự cho phép của quan phủ.");
				return;
			end
		else
			me.Msg("Vật phẩm này không thể bán.");
			return;
		end
		me.ShopSellItem(pItem, 1);
	elseif UiManager:GetUiState(UiManager.UIS_TRADE_REPAIR) == 1 then
		me.RepairEquipment(pItem.nIndex, Item.REPAIR_COMMON);
	elseif UiManager:GetUiState(UiManager.UIS_TRADE_REPAIR_EX) == 1 then
		me.RepairEquipment(pItem.nIndex, Item.REPAIR_SPECIAL);
	elseif UiManager:GetUiState(UiManager.UIS_TRADE_NPC) == 1 then
		local nShiftKey = GetKeyState(UiManager.VK_SHIFT);
		if nShiftKey >= 0 then
			UiManager:OpenWindow(Ui.UI_SHOPSELL, pItem);
		else
			me.ShopSellItem(pItem, 1);
		end
	elseif UiManager:GetUiState(UiManager.UIS_STALL_BUY) == 1 then
	elseif UiManager:GetUiState(UiManager.UIS_STALL_SETPRICE) == 1 then
		if not pItem then
			return 0;
		end
		if tbObj.nRoom ~= Item.ROOM_MAINBAG then
			me.Msg("Không thể định giá vật phẩm trong túi mở rộng.");
			return 0;
		end
		if (0 ~= pItem.IsLock()) or (0 ~= pItem.IsBind()) or (pItem.nGenre == Item.TASKQUEST) then
			me.Msg("Vật phẩm không thể giao dịch");
			return 0;
		end
		local tbParam = {};
		tbParam.varDefault 	= me.GetStallPrice(pItem);
		tbParam.tbTable		= Ui(Ui.UI_ITEMBOX);
		tbParam.fnAccept	= Ui(Ui.UI_ITEMBOX).StallMarkPrice;
		tbParam.szBanner   	= pItem.szName;
		tbParam.szTitle	   	= "Tách";
		tbParam.szTip	   	= "SL";
		tbParam.nType	   	= 0;
		tbParam.bIncDec		= 0;
		tbParam.nMaxLen		= 10;
		UiManager:OpenWindow(Ui.UI_TEXTINPUT_BANNER, tbParam, pItem.nIndex);
	elseif UiManager:GetUiState(UiManager.UIS_OFFER_SELL) == 1 then
--		UiManager:OpenWindow(Ui.UI_OFFERSELL, tbItem);		-- TODO: xyf 这里完全是乱糟糟的，再说
	elseif UiManager:GetUiState(UiManager.UIS_OFFER_SETPRICE) == 1 then
		if tbObj.nRoom ~= Item.ROOM_MAINBAG then
			me.Msg("Không thể định giá vật phẩm trong túi mở rộng.");
			return 0;
		end
		if (0 ~= pItem.IsLock()) or (0 ~= pItem.IsBind()) or (pItem.nGenre == Item.TASKQUEST) then
			me.Msg("Vật phẩm không thể giao dịch");
			return 0;
		end
		UiManager:OpenWindow(Ui.UI_OFFERMARKPRICE, pItem);
	elseif UiManager:GetUiState(UiManager.UIS_ITEM_REPAIR) == 1 then
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);
		me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
	elseif UiManager:GetUiState(UiManager.UIS_BEGIN_STALL) == 1 then
	elseif UiManager:GetUiState(UiManager.UIS_BEGIN_OFFER) == 1 then
	elseif UiManager:GetUiState(UiManager.UIS_ITEM_SPLIT) == 1 then
		if (not pItem) then
			return 0;
		end
		if (pItem.nCount <= 1) then
			me.Msg("Không thể tách vật phẩm này!");
			return 0;
		end
		local tbParam = {};
		tbParam.varDefault 	= 1;
		tbParam.tbTable		= Ui(Ui.UI_ITEMBOX);
		tbParam.fnAccept	= Ui(Ui.UI_ITEMBOX).SplitItem;
		tbParam.szBanner   	= pItem.szName;
		tbParam.szTitle	   	= "Tách";
		tbParam.szTip	   	= "SL";
		tbParam.nType	   	= 0;
		tbParam.bIncDec		= 1;
		tbParam.tbRange		= { 1, pItem.nCount - 1 };
		UiManager:OpenWindow(Ui.UI_TEXTINPUT_BANNER, tbParam, pItem);
	end

	return 0;

end

function tbItemRoom:SwitchMouse(tbMouseObj, tbObj, nX, nY)

	local pMouseItem = me.GetItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY);
	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
	if (not pMouseItem) or (not pItem) then
		Ui:Output("[ERR] Object机制内部错误！");
		tbMouse:SetObj(nil);
		return 0;
	end

	if (self:CheckSwitch(tbMouseObj, tbObj, nX, nY) ~= 1) then
		tbMouse:ResetObj();
		return 0;
	end

	if (self:IsMappingRoom() ~= 1) then
		-- 如果不是映射道具空间，调用CORE接口请求交换操作
		if (me.SwitchItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY, tbObj.nRoom, tbObj.nX, tbObj.nY) ~= 1) then
			tbMouse:ResetObj();			-- 交换失败，立刻把鼠标上的东西弹回
			return 0;
		end
	else
		-- 映射道具空间，对空间道具进行处理
		me.SetItem(pMouseItem, self.nRoom, nX + self.nOffsetX, nY + self.nOffsetY);	-- 设置道具空间
		tbMouse:SetObj(tbObj);					-- 先把容器道具放到鼠标上
		self:SetObj(tbMouseObj, nX, nY);		-- 再把鼠标道具放入容器
	end

	return 1;

end

function tbItemRoom:DropMouse(tbMouseObj, nX, nY)

	local pItem = me.GetItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY);
	if (not pItem) then
		Ui:Output("[ERR] Object机制内部错误！");
		return 0;
	end

	if (self:CheckSwitch(tbMouseObj, nil, nX, nY) ~= 1) then
		tbMouse:ResetObj();
		return 0;
	end

	if (self:IsMappingRoom() ~= 1) then
		-- 如果不是映射道具空间，调用CORE接口请求交换操作
		if (me.SwitchItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY, self.nRoom, nX + self.nOffsetX, nY + self.nOffsetY) ~= 1) then
			-- 交换失败，立刻把鼠标上的东西弹回
			tbMouse:ResetObj();
			return 0;
		end
	else
		-- 映射道具空间，对空间道具进行处理
		me.SetItem(pItem, self.nRoom, nX + self.nOffsetX, nY + self.nOffsetY);	-- 设置道具空间
		tbMouse:SetObj(nil);					-- 先清掉鼠标
		self:SetObj(tbMouseObj, nX, nY);		-- 再把鼠标道具放入容器
	end

	return 1;

end

function tbItemRoom:PickMouse(tbObj, nX, nY)

	if (self:CheckSwitch(nil, tbObj, nX, nY) ~= 1) then
		return 0;
	end

	if (self:IsMappingRoom() == 1) then
		me.SetItem(nil, self.nRoom, nX + self.nOffsetX, nY + self.nOffsetY);	-- 映射道具空间，清掉映射
	end

	return 1;

end

------------------------------------------------------------------------------------------
-- 私有方法

-- 检查指定Room是否映射道具空间
function tbItemRoom:IsMappingRoom(nRoom)
	if (not nRoom) then
		nRoom = self.nRoom;
	end
	for _, n in ipairs(MAPPING_ROOM) do
		if nRoom == n then
			return 1;
		end
	end
	return 0;
end

function tbItemRoom:CheckSwitch(tbDrop, tbPick, nX, nY)
	local pDrop = nil;
	local pPick = nil;
	if tbDrop then
		pDrop = me.GetItem(tbDrop.nRoom, tbDrop.nX, tbDrop.nY);
	end
	if tbPick then
		pPick = me.GetItem(tbPick.nRoom, tbPick.nX, tbPick.nY);
	end
	if (not pDrop) and (not pPick) then
		return 0;
	end
	return self:CheckSwitchItem(pDrop, pPick, nX, nY);
end

function tbItemRoom:RefreshItem(nRoom, nX, nY)

	if (UiManager:WindowVisible(self.szUiGroup) ~= 1) then
		return;					-- TODO: xyf 窗口不显示的时候不应该接消息，以后统一处理
	end

	local pItem		= me.GetItem(nRoom, nX, nY);	-- 在人身上找
	local tbOver	= tbMouse.tbOverObj;			-- 鼠标悬停Object
	local bMapping	= self:IsMappingRoom();			-- 是否映射空间
	local bRedirect	= 0;							-- 是否需要将空间更新事件重定向到映射空间
	local nOrgRoom  = nRoom;
	local nOrgX     = nX;
	local nOrgY     = nY;

	if (bMapping == 1) and (nRoom ~= self.nRoom) then
		-- 映射空间需更新道具映射
		for i, tbMap in pairs(self.tbItemMap) do
			if (tbMap.nRoom == nRoom) and (tbMap.nX == nX) and (tbMap.nY == nY) then
				if pItem and (pItem.dwId ~= tbMap.dwId) then
					pItem = nil;
				end
				-- 如果道具已经不存在或者仍然是先前的那个道具，更新到映射容器里
				nRoom = self.nRoom;
				nX    = tbMap.nMapX + self.nOffsetX;
				nY    = tbMap.nMapY + self.nOffsetY;
				bRedirect = 1;
				break;
			end
		end
	end

	if (nRoom ~= self.nRoom) or (nX < self.nOffsetX) or (nY < self.nOffsetY) then
		return;		-- 该道具位置不在容器对应范围之内
	end

	if tbOver and (tbOver.nType == Ui.OBJ_OWNITEM) and (tbOver.nRoom == nOrgRoom) and (tbOver.nX == nOrgX) and (tbOver.nY == nOrgY) then
		-- 发现刷新道具Obj与鼠标悬停道具Obj一致
		Wnd_HideMouseHoverInfo();		-- 先关闭Tip
		if (not pItem) then
			tbMouse.tbOverObj = nil;	-- 如果道具已经不存在，则清掉鼠标悬停道具
		else
			self:ShowItemTip(pItem);	-- 否则自动更新Tip
		end
	end

	-- 看是不是在鼠标上
	if tbMouse.tbObj and tbMouse.tbObj.nType == Ui.OBJ_OWNITEM then
		if (tbMouse.tbObj.nRoom == nOrgRoom) and (tbMouse.tbObj.nX == nOrgX) and (tbMouse.tbObj.nY == nOrgY) then
			if (not pItem) then
				tbMouse:SetObj(nil);		-- 道具已经不在了，删掉鼠标上的
			else
				local tbObj = {};
				tbObj.nType = Ui.OBJ_OWNITEM;
				tbObj.nRoom = nOrgRoom;
				tbObj.nX    = nOrgX;
				tbObj.nY    = nOrgY;
				tbMouse:SetObj(tbObj);
				tbMouse:Refresh();
			end
		end
	end

	local i = nX - self.nOffsetX;			-- 道具在容器中的实际X坐标
	local j = nY - self.nOffsetY;			-- 道具在容器中的实际Y坐标
	local tbObj = self:GetObj(i, j);

	if (not pItem) then
		if (bRedirect == 1) then
			me.SetItem(nil, nRoom, nX, nY);
		end
		self:SetObj(nil, i, j);				-- 对应道具已经不在了，从容器里删除
		return;
	end

	if (not tbObj) and (not pItem) then
		return;								-- 身上和容器里都没，结束处理
	end

	if (not tbObj) then						-- 重建Object数据结构
		tbObj = {};
		tbObj.nType = Ui.OBJ_OWNITEM;
		tbObj.nRoom = nRoom;
		tbObj.nX	= nX;
		tbObj.nY	= nY;
	end

	if (tbObj.nType == Ui.OBJ_OWNITEM) then
		if (bRedirect == 1) then
			me.SetItem(pItem, nRoom, nX, nY);
		end
		self:SetObj(tbObj, i, j);			-- 以覆盖方式更新Object数据
--		self:UpdateItemCd(pItem.nCdType);	-- 更新CD时间特效	-- TODO: xyf 因为效率问题先注释掉
	end

end

function tbItemRoom:GetFreePos()
	local nX, nY;
	for j = 0, self.nLine - 1 do
		if nX and nY then
			break;
		end
		for i = 0, self.nRow - 1 do
			if (not self.tbObjs[j]) then
				self.tbObjs[j] = {}
			end
			local tbObj = self.tbObjs[j][i];
			if not tbObj then
				nX = i;
				nY = j;
				break;
			end
		end
	end
	return nX, nY;
end

function tbItemRoom:SpecialStateRecvUse()
	local nX, nY = self:GetFreePos();
	if not nX or not nY then
		me.Msg("Chỗ trống mục tiêu đã đầy!");
		tbMouse:ResetObj();
		return 0;
	else
		self:SwitchObj(nX, nY);
	end
end

function tbItemRoom:CanSendStateUse()
	local bCanSendUse = 0;
	for i, nState in ipairs (MAPPING_STATE) do
		if UiManager:GetUiState(nState) == 1 then
			bCanSendUse = 1;
			break;
		end
	end
	return bCanSendUse;
end

function tbItemRoom:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_SYNC_ITEM,		self.RefreshItem,				self },				-- 角色道具同步事件
	};
	local tbBaseReg = tbItemRoom._tbBase.RegisterEvent(self);
	return Lib:MergeTable(tbBaseReg, tbRegEvent);
end

------------------------------------------------------------------------------------------
