

Require("\\ui\\script\\logic\\objcont\\itemroom.lua");

local tbObject 	  = Ui.tbLogic.tbObject;
local tbMouse	  = Ui.tbLogic.tbMouse;
local tbEquipRoom = tbObject:NewContainerClass("equiproom", "itemroom");


function tbEquipRoom:init()
	self.bShowCd	= 0;			-- 不显示CD特效
	self.bUse		= 0;			-- 不能使用
end


function tbEquipRoom:CheckSwitchItem(pDrop, pPick, nX, nY)

	if (not pDrop) then
		return 1;				-- 拿起操作
	end

	if (pDrop.IsEquip() ~= 1) or (me.CanUseItem(pDrop) ~= 1) then
		return 0;				-- 放下的不是装备或不能装备
	end
	
	local nEquipPos = KItem.EquipType2EquipPos(pDrop.nDetail);
	if nEquipPos >= Item.EQUIPPOS_NUM and self.nRoom == Item.ROOM_PARTNEREQUIP then
		nEquipPos = nEquipPos - Item.EQUIPPOS_NUM;
	end
		
	if (nEquipPos ~= self.nOffsetX and self.nRoom ~= Item.ROOM_EQUIPEX2) or
		(self.nRoom == Item.ROOM_EQUIPEX2 and nEquipPos ~= nX + self.nOffsetX + nY) or
		(self.nRoom == Item.ROOM_PARTNEREQUIP and pDrop.IsPartnerEquip() == 0)then
		return 0;
	end

	if (self.nRoom == Item.ROOM_PARTNEREQUIP and me.nPartnerCount == 0) then
		me.Msg("Hiện tại ngươi không có đồng hành, không thể mặc trang bị đồng hành!");
		return 0;
	end
	
	if (pDrop.nBindType == Item.BIND_NONE) or (pDrop.IsBind() == 1) then
		return 1;				-- 已经绑定或不需要绑定
	end
	if (pDrop.nGenre == Item.EQUIP_PARTNER) and (pDrop.IsBind() == 0) then
		local tbMsg = {};
		tbMsg.szMsg = "Sau khi mặc Trang bị đồng hành vào sẽ tự động khóa, bạn muốn mặc không?";
		tbMsg.nOptCount = 2;
		function tbMsg:Callback(nOptIndex, pItem)
			if (nOptIndex == 2) and pItem then
				me.UseItem(pItem);
			end
		end
		UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, pDrop);
		return;
	end
	local tbMsg = {};
	tbMsg.szMsg = "Trang bị sẽ khóa, sau khi khóa không thể vứt bỏ và giao dịch với người chơi khác, khóa không?";
	tbMsg.nOptCount = 2;
	function tbMsg:Callback(nOptIndex, pEquip, nRoom, nX, nY, AAA)
		if (nOptIndex == 2) then
			local tbPos = me.GetItemPos(pEquip);
			if tbPos then
				me.SwitchItem(nRoom, nX, nY, tbPos.nRoom, tbPos.nX, tbPos.nY);	
			end
		end
	end

	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, pDrop, self.nRoom, nX + self.nOffsetX, nY + self.nOffsetY);
	return 0;

end

function tbEquipRoom:RefreshItem(nRoom, nX, nY)

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
		for i, tbMap in pairs(self.tbItemMap) do
			if (tbMap.nRoom == nRoom) and (tbMap.nX == nX) and (tbMap.nY == nY) then
				if pItem and (pItem.dwId ~= tbMap.dwId) then
					pItem = nil;
				end
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
		Wnd_HideMouseHoverInfo();		-- 先关闭Tip
		if (not pItem) then
			tbMouse.tbOverObj = nil;	-- 如果道具已经不存在，则清掉鼠标悬停道具
		else
			self:ShowItemTip(pItem);	-- 否则自动更新Tip
		end
	end

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
	end
	UiNotify:OnNotify(UiNotify.emUIEVENT_EQUIP_REFRESH);	-- TODO: 给装备耐久刷新用的
end
