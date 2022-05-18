


local tbSeriesInfoBook = Item:GetClass("seriesinfobook");


tbSeriesInfoBook.MSG_INFO 	= "Ngũ Hành Thư: Ngũ Hành Luân Chuyển, Vạn Vật Thay Đổi. Âm Dương Pháp, Tạo Hóa Càn Khôn."..
							  "Muốn biết mặc trang bị nào mới kích hoạt thuộc tính ngũ hành "..
							  "Xin tra xem trang bị liên quan Ngũ Hành trong Ngũ Hành Thư.";
tbSeriesInfoBook.MSG_EQUIP 	= "Trang bị bạn muốn tra xem là?";
tbSeriesInfoBook.MSG_SERIES	= "Thuộc tính Ngũ Hành của trang bị này là?";

function tbSeriesInfoBook:init()
	self.nSelEquip  		= 0;
	self.nSelSeries 		= 0;
	self.tbEquitSelItem		= {};
	self.tbSeriesSelItem	= {};
end

tbSeriesInfoBook:init();

function tbSeriesInfoBook:OnUse()
	Dialog:Say(self.MSG_INFO, {{ "Tra xem", self.OnViewEquip, self }});
end

function tbSeriesInfoBook:OnViewEquip()
	self.nSelSeries	= 0;
	self.nSelEquip	= 0;
	self.tbEquitSelItem = {};
	for i = Item.EQUIPPOS_HEAD, Item.EQUIPPOS_PENDANT do
		table.insert(self.tbEquitSelItem, { Item.EQUIPPOS_NAME[i], self.OnSelectEquip, self, i })
	end
	Dialog:Say(self.MSG_EQUIP, self.tbEquitSelItem);
end

function tbSeriesInfoBook:OnSelectEquip(nEquipPos)
	self.nSelEquip = nEquipPos;
	self:OnViewSeries();
end

function tbSeriesInfoBook:OnViewSeries()
	self.tbSeriesSelItem = {};
	for i = Env.SERIES_METAL, Env.SERIES_EARTH do
		table.insert(self.tbSeriesSelItem, { Env.SERIES_NAME[i], self.OnSelectSeries, self, i })
	end
	Dialog:Say(self.MSG_SERIES, self.tbSeriesSelItem);
end

function tbSeriesInfoBook:OnSelectSeries(nSeries)
	self.nSelSeries = nSeries;
	self:Conclusion();
end

function tbSeriesInfoBook:Conclusion()
	local nAccruedSeries = KMath.AccruedSeries(self.nSelSeries);
	local nAccrueSeries  = KMath.AccrueSeries(self.nSelSeries);
	local nEquipActive1, nEquipActive2   = KItem.GetEquipActive(self.nSelEquip);
	local nEquipActived1, nEquipActived2 = KItem.GetEquipActived(self.nSelEquip);
	
	local szMsg = "Trang bị tra xem là <color=red>"..tostring(Env.SERIES_NAME[self.nSelSeries]).."<color> - <color=red>"..
	tostring(Item.EQUIPPOS_NAME[self.nSelEquip]).."<color>. Có thể bị <color=red>"..tostring(Env.SERIES_NAME[nAccruedSeries]).."<color> - <color=red>"..
		tostring(Item.EQUIPPOS_NAME[nEquipActive1]).."<color>, <color=red>"..tostring(Item.EQUIPPOS_NAME[nEquipActive2]).."<color> kích hoạt. Có thể kích hoạt <color=red>"..
		tostring(Env.SERIES_NAME[nAccrueSeries]).."<color> - <color=red>"..tostring(Item.EQUIPPOS_NAME[nEquipActived1]).."<color> và <color=red>"..
		tostring(Item.EQUIPPOS_NAME[nEquipActived2]).."<color>.";

	local tbDialog =
	{
		{ "Tiếp tục tra xem", self.OnViewEquip, self },
		{ "Kết thúc" },
	};
	Dialog:Say(szMsg, tbDialog);

end
