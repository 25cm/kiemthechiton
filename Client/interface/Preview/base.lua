
-- UI Object容器基类（通用逻辑）

local tbObject	= Ui.tbLogic.tbObject;
local tbMouse	= Ui.tbLogic.tbMouse;
local tbPreViewMgr	= Ui.tbLogic.tbPreViewMgr;
local tbBase	= tbObject.tbContClass.base;



-- 链接属于自己的道具Object
 tbBase.LinkOwnItem=function(self,tbOwnItem, nX, nY)
	local pItem = me.GetItem(tbOwnItem.nRoom, tbOwnItem.nX, tbOwnItem.nY);
	if (pItem) then
		SetItemLink(pItem.nIndex);			-- 旧的装备链接机制
	end
end

-- 发送属于自己的道具Object装备预览
 tbBase.PreViewItem=function(self,tbPreViewItem, nX, nY)
	local pItem = me.GetItem(tbPreViewItem.nRoom, tbPreViewItem.nX, tbPreViewItem.nY);
	if (pItem) then
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
			UiManager:CloseWindow(Ui.UI_PREVIEW);
		end
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
			UiManager:OpenWindow(Ui.UI_PREVIEW,pItem);
		end
	end
end

 tbBase.PreViewTempItem=function(self,tbPreViewTempItem, nX, nY)
	local pItem = tbPreViewTempItem.pItem;
	if (pItem) then
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
			UiManager:CloseWindow(Ui.UI_PREVIEW);
		end
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
			UiManager:OpenWindow(Ui.UI_PREVIEW,pItem);
		end
	end
end