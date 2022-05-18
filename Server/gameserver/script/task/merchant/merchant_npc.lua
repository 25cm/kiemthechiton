Require("\\script\\task\\merchant\\merchant_define.lua")

local MerchantNpc = {};

Merchant.Npc = MerchantNpc;
local tbNpc = Npc:GetClass("merchant");
function tbNpc:OnDialog()
	local tbOpt = {
		{"[Thương Hội]", Merchant.Npc.OnDialog_ThuongHoi, Merchant.Npc},
		{"Kết thúc đối thoại"},
	}
	local szMsg =  [[Chủ Thương Hội: Ở đây ta có nhiệm vụ Vận Tiêu và Nhiệm vụ Thương Hội:<color=yellow>]]
	Dialog:Say(szMsg, tbOpt);
end
function MerchantNpc:OnDialog_ThuongHoi()
	local tbOpt = {
		{"Giới thiệu nhiệm vụ thương hội", Merchant.Npc.About, Merchant.Npc},
		{"Nhận thư thương hội", Merchant.Npc.GetDervielItem, Merchant.Npc},
		{"Nhận hộp thu thập Lệnh bài thương hội", Merchant.Npc.GetMerchantBox, Merchant.Npc},
		{"Shop thương hội", Shop.SellItem.OnOpenSell, Shop.SellItem},
		--{"Hủy nhiệm vụ thương hội", Merchant.Npc.CancelTask, Merchant.Npc},
		{"Kết thúc đối thoại"},
	}
	local szMsg =  [[Chủ Thương Hội: Giúp ta hoàn thành 40 nhiệm vụ ngươi có thể nhận được rât nhiều bạc và huyền tinh.
	Tham gia nhiệm vụ Thương Hội phải thỏa mãi những điều kiện sau:<color=yellow>
		1. Đạt cấp 60
		2. Uy danh giang hồ đạt 50 điểm.
		3. Hoàn thành nhiệm vụ chính tuyến lv50.
		4. Mỗi tuần chỉ nhận 1 nhiệm vụ Thương Hội.
		<color>]]
	Dialog:Say(szMsg, tbOpt);
end
function tbNpc:OnDialog_GS_VanTieu(nHuHangLevel)
	if Huhang.IsOpen ~= 1 then
		Dialog:Say("Chức năng này chưa mở,vui lòng thử lại sau");

	return 0;
	end
local tbNpc	= Npc:GetClass("huhang_npc");
tbNpc:OnDialog(nHuHangLevel);
end
function tbNpc:AddBouns()
	if Huhang.IsOpen ~= 1 then
		Dialog:Say("Chức năng này chưa mở,vui lòng thử lại sau");

	return 0;
	end
local tbNpc	= Npc:GetClass("huhang_npc");
tbNpc:AddBonus();
end

function MerchantNpc:GetMerchantBox()
	local tbFind1 = me.FindItemInBags(unpack(Merchant.MERCHANT_BOX_ITEM));
	local tbFind2 = me.FindItemInRepository(unpack(Merchant.MERCHANT_BOX_ITEM));
	if #tbFind1 > 0 or #tbFind2 > 0 then
		Dialog:Say("Đã có hộp thu thập lệnh bài Thương Hội.");
		return 0;
	end
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang của bạn đã đầy, hãy sắp xếp và thử lại.");
		return 0;
	end
	me.AddItem(unpack(Merchant.MERCHANT_BOX_ITEM));
	Dialog:Say("Bạn nhận được hộp thu thập Lệnh Bài Thương Hội");
end

function MerchantNpc:GetDervielItem()
	
	if Merchant:GetTask(Merchant.TASK_OPEN) == 1 then
		Dialog:Say("Không cần thư Thương Hội.");
		return 0;
	end
	
	if Merchant:GetTask(Merchant.TASK_TYPE) ~= Merchant.TYPE_DELIVERITEM and Merchant:GetTask(Merchant.TASK_TYPE) ~= Merchant.TYPE_DELIVERITEM_NEW then
		Dialog:Say("Không cần thư Thương Hội.");
		return 0;
	end
	
	local tbFind1 = me.FindItemInBags(unpack(Merchant.DERIVEL_ITEM));
	local tbFind2 = me.FindItemInRepository(unpack(Merchant.DERIVEL_ITEM));
	if #tbFind1 > 0 or #tbFind2 > 0 then
		Dialog:Say("Bạn đã có thư Thương Hội.")
		return 0;
	end
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang của bạn đã đầy, hãy sắp xếp và thử lại.")
		return 0;
	end	
	me.AddItem(unpack(Merchant.DERIVEL_ITEM));
end

function MerchantNpc:CancelTask()
	Task:CloseTask(Merchant.TASKDATA_ID, "giveup");
	Merchant:SetTask(Merchant.TASK_OPEN, 0);
	Merchant:SetTask(Merchant.TASK_STEP_COUNT, 0);
	Merchant:SetTask(Merchant.TASK_TYPE, 0);
	Merchant:SetTask(Merchant.TASK_STEP, 0);
	Merchant:SetTask(Merchant.TASK_LEVEL, 0);
	Merchant:SetTask(Merchant.TASK_NOWTASK, 0);	
end

function MerchantNpc:About()
	local szMsg = [[Chủ Thương Hội: Giúp ta hoàn thành 40 nhiệm vụ ngươi có thể nhận được rât nhiều bạc và huyền tinh.
	Tham gia nhiệm vụ Thương Hội phải thỏa mãi những điều kiện sau:<color=yellow>
		1. Đạt cấp 60
		2. Uy danh giang hồ đạt 50 điểm.
		3. Hoàn thành nhiệm vụ chính tuyến lv50.
		4. Mỗi tuần chỉ nhận 1 nhiệm vụ Thương Hội.
		<color>
	Nhiệm vụ Thương Hội có các loại sau:<color=yellow>
		1. Đưa thư: Đưa giấy viết thư của Thương Hội đến chỗ người chỉ định (Người Liên Lạc Thương Hội sẽ xuất hiện trong bản đồ chỉ định)
		2. Tìm vật: Thu thập đạo cụ chỉ định cho  Thương Hội (nhận được trong các hoạt động tương ứng)
		3. Sưu tầm: Đến địa điểm chỉ định sưu tầm vật phẩm chỉ định (vật phẩm được quái vật bảo vệ, phải đi cùng tổ đội)
		<color>]]
	Dialog:Say(szMsg);
end

