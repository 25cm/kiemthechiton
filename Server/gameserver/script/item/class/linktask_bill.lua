




Require("\\script\\task\\linktask\\linktask_head.lua");

local tbTreasureMap = Item:GetClass("linktask_bill");

function tbTreasureMap:OnUse()

end;

function tbTreasureMap:GetTip()
	
	local szMain = [[1 tấm có thể đổi lấy Ngân phiếu, có thể đổi lấy bạc không khóa ở những địa điểm sau:<enter><enter>
					<color=orange>1. Người Liên Lạc Thương Hội Bạch Hổ Đường 2<enter>
					2. Người Liên Lạc Thương Hội xuất hiện sau khi Phó bản Phục Ngưu Sơn Quân Doanh đánh bại Thợ Cả<enter>
					3. Sư phụ gia công/chế tạo Liễu Khoát ở Tiêu Dao Cốc<enter>
					4. Quan Quân Nhu (nghĩa quân)<color><enter><enter>
	
]];
	
	local nMoney	= math.floor( (10000 * LinkTask:_CountLevelProductivity()) / 2 );
	
	szMain = szMain.."<color>Căn cứ đẳng cấp, mỗi ngân phiếu được đổi thành: "..nMoney.." bạc không khóa.<color>";
	
	return szMain;
end;
