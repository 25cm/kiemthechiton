-- 李金财脚本

local LiJinCai	= Npc:GetClass("jbexchange_npc");

if (not MODULE_GAMESERVER) then
	return;
end

LiJinCai.tbInfomation = 
{
	[1] = "Để vào được giao diện giao dịch đồng. Hãy đến 7 thành thị lớn chọn NPC <color=gold>Lý Cẩm Tài<color> Trong đó bạn có thể chọn giao dịch từ đồng qua bạc, hoặc từ bạc qua đồng tùy vào nhu cầu của bạn.";
	[2] = "Trong giao diện giao dịch đồng, chọn bán đồng giá đơn vị là giá bạn muốn bán /1 đồng. số lượng cần bán, Giá tổng là số tiền bán bạn nhận được đã trừ 1% phí";
	[3] = "Trong giao diện giao dịch đồng, chọn mua đồng giá đơn vị là giá bạn muốn mua /1 đồng. số lượng cần mua, Giá tổng là số đồng bạn nhận được, Khi mua đồng không mất phí.";
	[4] = "Với mỗi giao dịch bán đồng lấy bạc, người bán đồng sẽ chịu 1% thuế của tổng giao dịch. Số tiền này sẽ dùng để đầu tư trang thiết bị của ";
	
}
-- 定义对话事件
function LiJinCai:OnDialog()
Dialog:Say("NPC chưa mở");
end
