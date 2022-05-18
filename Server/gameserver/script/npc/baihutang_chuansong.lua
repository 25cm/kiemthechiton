-- 白虎堂传送NPC


local tbNpc = Npc:GetClass("baihutangchuansong");
tbNpc.nTopLevel = 90;
tbNpc.nBottomLevel = 50;

function tbNpc:Init()
	self.tbShopID =
	{
		[1] = 89, -- 少林
		[2] = 90, --天王掌门
		[3] = 91, --唐门掌门
		[4] = 93, --五毒掌门
		[5] = 95, --峨嵋掌门
		[6] = 96, --翠烟掌门
		[7] = 98, --丐帮掌门
		[8] = 97, --天忍掌门
		[9] = 99, --武当掌门
		[10] = 100, --昆仑掌门
		[11] = 92, --明教掌门
		[12] = 94, --大理段氏掌门
	}
end

tbNpc:Init();

function tbNpc:OnDialog()
	local nMapId	= me.nMapId;
	local tbOpt		= {};

		table.insert(tbOpt, {"Vào <color=green>Bạch Hổ Đường (cao)<color>", self.OnTrans, self, BaiHuTang.GaoJi});
		table.insert(tbOpt, {"Cửa hàng <color=yellow>Bạch Hổ Đường<color=red>", self.BuyReputeItem, self});
		table.insert(tbOpt, {"Kết thúc đối thoại"});
	
	Dialog:Say("<color=yellow>Bạch Hổ Đường<color> chỉ mở từ <color=green>(8h đến 18h)<color> và <color=green>(22h đến 24h)<color> hàng ngày.<enter><enter>+ Đến giờ chỉ định nhấn vào <color=red>Triệu Hồi Boss Bạch Hổ Đường<color> để gọi boss xuất hiện.<enter>+ <color=green>Thủ Lĩnh BHĐ tầng 1<color> xuất hiện khi thời gian còn: <color=gold>25phút<color>.<enter>+ <color=green>Thủ Lĩnh BHĐ tầng 2<color> xuất hiện khi thời gian còn: <color=gold>18phút<color>.<enter>+ <color=green>Thủ Lĩnh BHĐ tầng 3<color> xuất hiện khi thời gian còn: <color=gold>10phút<color>.<enter><enter>Mỗi ngày có thể tham gia <color=red>Bạch Hổ Đường<color> tối đa: <color=yellow>2 lần<color>.", tbOpt);
	
end

function tbNpc:OnTrans(nMapId)
	local nRect		= MathRandom(#BaiHuTang.tbPKPos);
	local tbPos		= BaiHuTang.tbPKPos[nRect];
	me.NewWorld(nMapId, tbPos.nX / 32, tbPos.nY / 32);
end

-- 购买白虎堂声望装备
function tbNpc:BuyReputeItem()
		local nFaction = me.nFaction;
		if nFaction <= 0 then
			Dialog:Say("Người chơi chữ trắng không mua được trang bị nghĩa quân");
			return 0;
		end
		me.OpenShop(self.tbShopID[nFaction], 1, 100, me.nSeries) --使用声望购买
end
