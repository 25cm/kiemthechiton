--中秋节
--2008.09.01
--孙多良

local tbEvent = {};
SpecialEvent.ZhongQiu2008 = tbEvent;

tbEvent.TIME_STATE = 
{
	20120817,
	20120830,
	20121011,
}

--材料
tbEvent.ITEM_MERIAL = {
	{22,1,31,1}, --月桂花
	{22,1,33,1}, --莲子粉
}

tbEvent.AWARD_WEIWANG = {{100,2},{30,1}};	--威望对应奖励{达到威望，个数}

tbEvent.TASK_GROUP_ID = 2046;
tbEvent.TASK_WEIWANG_AWARD = 1;	--江湖声望领取奖励。
tbEvent.TASK_USE_MOON = 2;	--使用月满西楼月饼数量

tbEvent.USEITEM_MAX_MOON = 25;	--使用月满西楼数量最大上限

tbEvent.RECIPEID_MERIAL1 = 1346;	--月桂配方
tbEvent.RECIPEID_MERIAL2 = 1347;	--莲子配方
tbEvent.RECIPEID_MOONCAKE = 1348;	--月饼配方

tbEvent.PRODUCTSET = 
{
	{
		tbItem = {18,1,197,1,0,0};
		nRate  = 99;
	},
	{
		tbItem = {18,1,198,1,0,0};
		nRate  = 1;
	},
}

tbEvent.PRODUCTSET_INKIN = 
{
	{
		tbItem = {18,1,197,1,0,0};
		nRate  = 95;
	},
	{
		tbItem = {18,1,198,1,0,0};
		nRate  = 5;
	},
}


tbEvent.NEWS_INFO = 
{
	{
		nKey = 15,
		szTitle = "Trung Thu [Hắc Kiếm]",
		szMsg = [[
Thời Gian: <color=yellow>17 tháng 8 -> 30 tháng 8<color>
    
Các Hoạt Động :
    Trong thời gian diễn ra sự kiện, Bạn có thể thu thập các nguyên liệu làm bánh. Sử dụng kỹ năng sống chế tạo và đổi Bánh Trung Thu
    
   Bạn có thể kiếm được Nguyên Liệu bằng cách tham gia:
   Bạch Hổ Đường, Tống Kim, Thi Đấu Môn phái.......
   Phần Thưởng:
   Mở Bảo Rương Tuyết Trượng bạn có thể nhận được :
   Mã bài Tuyệt Thế Tuyết Vũ, Mã Bài Hỏa Kỳ Lân, Mã bài Tuyết Hồn, Các loại Bánh Ít ......
   Vật phẩm Nguyệt Mãn Tây Lâu sử dụng nhận được lak cấp 10, may mắn cấp 6, kinh nghiệm 70% trong 1h
   Hoàng Kim Khánh Hạ Lệnh sử dụng nhận được những Hiệu Quả Đặc Biệt
    <color=yellow>Lưu ý: Để làm được Bánh Trung Thu bạn phải gia nhập Gia Tộc<color>
]],
	},
}