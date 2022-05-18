-- 文件名　：mask_card.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-03-19 18:55:03
-- 描  述  ：道具卡片

local tbItem = Item:GetClass("mask_card2");

tbItem.tbMask = {	{1, 13, 44, 1},
				{1, 13, 45, 1},
			   };

function tbItem:OnUse()
	local szInfo = "Chọn mặt nạ muốn nhận:";
	local tbOpt ={
			{"[Mặt nạ] Ông già Noel (30 ngày)",	self.AddMask, self, 1, it.dwId},
			{"[Mặt nạ] Thiếu nữ Noel (30 ngày)", self.AddMask, self, 2, it.dwId},
			{"Đóng"},
		};
	Dialog:Say(szInfo,tbOpt);
	return 0;
end

function tbItem:AddMask(nType, nItemId)
	local pItem =  KItem.GetObjById(nItemId);
	if pItem then
		pItem.Delete(me);
		me.AddItem(unpack(self.tbMask[nType]));
	end
end
	