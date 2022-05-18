local tbCuahangnew = Npc:GetClass("cuahangnew");

function tbCuahangnew:OnDialog()
	DoScript("\\script\\npc\\cuahangnew.lua");
	local szMsg = "Xin chào, bạn muốn mua gì?";
	local tbOpt = {
			{"<pic=135> Cửa Hàng <color=red>Tiền Du Long<color>",self.DanhVongVatPham_KTCT_OK,self};
	        {"<pic=135> Cửa Hàng <color=blue>Nguyệt Ảnh Thạch",self.shopmatna,self};
			{"<pic=135> Cửa Hàng <color=green>Ngoại Trang<color> <color=yellow>[ Nón ]<color>",self.shopitempet,self};
			{"<pic=135> Cửa Hàng <color=green>Ngoại Trang<color> <color=yellow>[ Áo ]<color>",self.shopngoaitrang,self};
			{"<pic=135> Cửa Hàng <color=yellow>Vũ Khí Tần Lăng<color>",self.shopvktl,self};
			{"<pic=135> Cửa Hàng <color=gold>Võ Lâm Liên Đấu<color>",self.ShopLiendau,self};
			{"<pic=135> Cửa Hàng <color=gold>Tranh Đoạt Lãnh Thổ<color>",self.Shoptranhdoat,self};
			--{"<pic=135> Shop <color=green>Trang Bị Bá Vương<color>",self.ShopTrangBiBaVuong_KTCT,self};
			--{"<pic=135> Shop <color=green>Trang Bị Sát Thần<color>",self.ShopTrangBiSatThan_KTCT,self};
			{"Kết thúc đối thoại"},
			};
Dialog:Say(szMsg, tbOpt);
end

function tbCuahangnew:shopmatna()
me.OpenShop(166,3)
end

function tbCuahangnew:shopitempet()
me.OpenShop(226,3)
end
function tbCuahangnew:shopngoaitrang()
me.OpenShop(227,3)
end

function tbCuahangnew:ShopTrangBiBaVuong_KTCT()
me.OpenShop(200,3)
end
function tbCuahangnew:ShopTrangBiSatThan_KTCT()
me.OpenShop(210,3)
end
function tbCuahangnew:DanhVongVatPham_KTCT_OK()
me.OpenShop(189,3)
end

function tbCuahangnew:shopvktl()
local szMsg = "Chọn Shop cần mở:";
local tbOpt = {
		{"Shop Vũ Khí Hệ <color=yellow>Kim<color>",self.Svukhi1,self};
		{"Shop Vũ Khí Hệ <color=green>Mộc<color>",self.Svukhi2,self};
		{"Shop Vũ Khí Hệ <color=blue>Thủy<color>",self.Svukhi3,self};
		{"Shop Vũ Khí Hệ <color=red>Hỏa<color>",self.Svukhi4,self};
		{"Shop Vũ Khí Hệ <color=gold>Thổ<color>",self.Svukhi5,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbCuahangnew:Svukhi1()
me.OpenShop(156, 1);
end

function tbCuahangnew:Svukhi2()
me.OpenShop(157, 1);
end

function tbCuahangnew:Svukhi3()
me.OpenShop(158, 1);
end

function tbCuahangnew:Svukhi4()
me.OpenShop(159, 1);
end

function tbCuahangnew:Svukhi5()
me.OpenShop(160, 1);
end


function tbCuahangnew:ShopLiendau()
    me.OpenShop(134,1);
end
----------------------------------------------------------------------------------
function tbCuahangnew:Shoptranhdoat()
    me.OpenShop(147,1);
end