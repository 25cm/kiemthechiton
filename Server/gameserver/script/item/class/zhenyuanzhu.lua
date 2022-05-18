local tbZhenzhus = Item:GetClass("jxsf8_zhenyuanzhu");

function tbZhenzhus:OnUse()
	local szMsg = "Chân nguyên tu luyện, hộ thể cường thân. Phát quang thiên hạ.";
	local tbOpt = {
		{"Tu Luyện thuộc tính <color=gold>Thứ Nhất<color>", self.tuluyen1, self, it},
		{"Tu Luyện thuộc tính <color=gold>Thứ Hai<color>", self.tuluyen2, self, it},
		{"Tu Luyện thuộc tính <color=gold>Thứ Thứ Ba<color>", self.tuluyen3, self, it},
		{"Tu Luyện thuộc tính <color=gold>Thứ Tư<color>", self.tuluyen4, self,it},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end




function tbZhenzhus:tuluyen1(pThisItem)

	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(1 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem);
	end
	Item:UpgradeZhenYuanNoItem(pItem,25,1);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính thứ nhất tăng <color=gold> 25 điểm<color>.", me.szName));
	
end

function tbZhenzhus:tuluyen2(pThisItem)
	
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(2 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem);
	end
	Item:UpgradeZhenYuanNoItem(pItem,25,2);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính thứ hai tăng <color=gold> 25 điểm<color>.", me.szName));
	
end

function tbZhenzhus:tuluyen3(pThisItem)
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(3 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem);
	end
	Item:UpgradeZhenYuanNoItem(pItem,25,3);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính thứ ba tăng <color=gold> 25 điểm<color>.", me.szName));
	
end

function tbZhenzhus:tuluyen4(pThisItem)
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(4 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem);
	end
	Item:UpgradeZhenYuanNoItem(pItem,25,4);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính thứ tư tăng <color=gold> 25 điểm<color>.", me.szName));
	
end

	
	
	
	
	
	
	
	
	
	