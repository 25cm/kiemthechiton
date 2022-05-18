-------------------------------------------------------
-- 文件名　：yemingzhu.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-06-10 10:34:06
-- 文件描述：
-------------------------------------------------------

-- 定义标示名字："\\setting\\item\\001\\other\scriptitem.txt"
local tbYemingzhuItem = Item:GetClass("qinling_yemingzhu");

function tbYemingzhuItem:OnUse()
	
	local tbOpt = {
		{"Đúng", Boss.Qinshihuang.OnUseYemingzhu, Boss.Qinshihuang, me.nId},
		{"Không"},
	}
	
	local nNum = Boss.Qinshihuang:GetCostNum(me);
	local szMsg = string.format("Sau khi sử dụng Dạ Minh Châu, tạm thời có thể giảm bớt khí độc lan vào cơ thể <color=yellow>trong 1 giờ<color>, <color=yellow>do công lực mỗi người khác nhau, số lượng Dạ Minh Châu cần dùng cũng khác nhau<color>, bạn cần sử dụng <color=yellow>%d<color> Dạ Minh Châu mới có hiệu quả, có muốn sử dụng?", nNum);
	Dialog:Say(szMsg, tbOpt);
	
	-- 不消失
	return 0;
end
