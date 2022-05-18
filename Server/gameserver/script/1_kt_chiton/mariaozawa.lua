local tbMariaOzawa = Npc:GetClass("mariaozawa");

tbMariaOzawa.TaskGourp = 3029; 
tbMariaOzawa.TaskId_Day = 1; 
tbMariaOzawa.TaskId_Count = 2; 
tbMariaOzawa.TaskId_Last = 3; 
tbMariaOzawa.Relay_Time = 7200; 
tbMariaOzawa.Use_Max = 2;  -- so lan giao thong trong ngay

function tbMariaOzawa:OnDialog()
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải có 5 Ô trống trong Túi mới được đổi phần thưởng!");
		return 0;
	end

	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if me.GetTask(self.TaskGourp, self.TaskId_Day) < nDate then
		me.SetTask(self.TaskGourp, self.TaskId_Day, nDate);
		me.SetTask(self.TaskGourp, self.TaskId_Count, 0);
		me.SetTask(self.TaskGourp, self.TaskId_Last, 0);
	end 
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count);
	local szMsg = string.format("Đổi Đặc Sản 12 Môn Phái lấy <color=yellow>(5 vạn đồng + VP)<color>. Mỗi ngày chỉ đổi tối đa: <color=Green>2 Lần<color>");
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count);
	    if nCount >= self.Use_Max then
        Dialog:Say(string.format("Hôm nay đã đổi: <color=Green>2 Lần<color> rồi. Không thể đổi tiếp"));
        return 0; 
    end  
	
	--------------------------------------------------------
		local nLast = me.GetTask(self.TaskGourp, self.TaskId_Last);
	local nHour = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	local nSec1 = Lib:GetDate2Time(nHour);
	local nSec2 = nLast + self.Relay_Time;
		if nSec1 < nSec2 then
			if ((nSec2 - nSec1)<=60) then
				me.Msg(string.format("Hôm nay bạn đã hoàn thành NV <color=green>1 lần<color>. Còn <color=yellow>%s giây<color> nữa mới đổi <color=yellow>Vật Phẩm<color> lần 2 được.", (nSec2 - nSec1)));
			else
				me.Msg(string.format("Hôm nay bạn đã hoàn thành NV <color=green>1 lần<color>. Còn <color=yellow>%d phút<color> nữa mới đổi <color=yellow>Vật Phẩm<color> lần 2 được.", (nSec2 - nSec1)/60));
			end
			return 0;
		end
	--------------------------------------------------
	local tbItemId1 = {18,1,134,1,0,0}; -- Dong tien vang
	local tbItemId2 = {18,1,135,1,0,0}; -- vk1
	local tbItemId3 = {18,1,136,1,0,0}; -- vk1
	local tbItemId4 = {18,1,137,1,0,0}; -- vk1
	local tbItemId5 = {18,1,138,1,0,0}; -- vk1
	local tbItemId6 = {18,1,139,1,0,0}; -- vk1
	local tbItemId7 = {18,1,140,1,0,0}; -- vk1
	local tbItemId8 = {18,1,141,1,0,0}; -- vk1
	local tbItemId9 = {18,1,142,1,0,0}; -- vk1
	local tbItemId10 = {18,1,143,1,0,0}; -- vk1
	local tbItemId11 = {18,1,144,1,0,0}; -- vk1
	local tbItemId12 = {18,1,145,1,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,134,1);
	local nCount2 = me.GetItemCountInBags(18,1,135,1);
	local nCount3 = me.GetItemCountInBags(18,1,136,1);
	local nCount4 = me.GetItemCountInBags(18,1,137,1);
	local nCount5 = me.GetItemCountInBags(18,1,138,1);
	local nCount6 = me.GetItemCountInBags(18,1,139,1);
	local nCount7 = me.GetItemCountInBags(18,1,140,1);
	local nCount8 = me.GetItemCountInBags(18,1,141,1);
	local nCount9 = me.GetItemCountInBags(18,1,142,1);
	local nCount10 = me.GetItemCountInBags(18,1,143,1);
	local nCount11 = me.GetItemCountInBags(18,1,144,1);
	local nCount12 = me.GetItemCountInBags(18,1,145,1);
	if nCount1 >= 1 and nCount2 >=1 and nCount3 >=1 and nCount4 >=1 and nCount5 >=1 and nCount6 >=1 and nCount7 >=1 and nCount8 >=1 and nCount9 >=1 and nCount10 >=1 and nCount11 >=1 and nCount12 >=1 then
  
if (nCount == 0) or (nCount == 1) or (nCount == 2) then

local szMsg = "Đổi Đặc Sản 12 Môn Phái lấy <color=yellow>(5 vạn đồng + VP)<color>. Hôm nay <color=yellow>"..me.szName.."<color> đã đổi Vật Phẩm <color=cyan>"..nCount.."<color> lần"; 
local tbOpt = { 
{"Đã tìm đủ: <color=yellow>Đồng ý đổi Thưởng<color>", self.vatpham, self},
}; 
Dialog:Say(szMsg, tbOpt);
me.Msg(string.format("<color=yellow>Đổi Vật Phẩm thành công lần thứ <color=cyan>%d<color><color> ",nCount + 1));

	me.SetTask(self.TaskGourp, self.TaskId_Count, nCount + 1);
	local nHourS = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	local nSec3 = Lib:GetDate2Time(nHourS);
	me.SetTask(self.TaskGourp, self.TaskId_Last, nSec3);
 	end
    else
		Dialog:Say("Nhiệm vụ thu thập <color=yellow>Đặc Sản 12 Môn Phái<color> đổi lấy <color=yellow>(5 vạn đồng + VP)<color>. Hôm nay <color=yellow>"..me.szName.."<color> đã đổi Vật Phẩm <color=cyan>"..nCount.."<color> lần. Khi nào đủ <color=yellow>Đặc Sản 12 Môn Phái<color> để trong Rương hãy đến tìm ta để đổi phần thưởng. <color=yellow>Đặc Sản<color> mua tại <color=green>Thương Nhân Thần Bí<color> 12 môn phái với giá 1 Bạc, thời gian sử dụng trong: <color=blue>12 Phút<color>. <color=green>Thương Nhân Thần Bí<color> di chuyển quanh <color=yellow>[Map] Môn Phái<color>. Mỗi ngày được đổi phần thưởng tối đa <color=red>2 Lần<color>. Mỗi lần cách nhau <color=red>2 giờ<color>. Lên tạo tổ đội hoặc nhóm nhiều người để truy tìm cho nhanh")
end
end

---------------- qua trinh giao thong
function tbMariaOzawa:vatpham()
	local tbItemInfo = {bForceBind = 1};
	local tbItemId1 = {18,1,134,1,0,0}; -- Dong tien vang
	local tbItemId2 = {18,1,135,1,0,0}; -- vk1
	local tbItemId3 = {18,1,136,1,0,0}; -- vk1
	local tbItemId4 = {18,1,137,1,0,0}; -- vk1
	local tbItemId5 = {18,1,138,1,0,0}; -- vk1
	local tbItemId6 = {18,1,139,1,0,0}; -- vk1
	local tbItemId7 = {18,1,140,1,0,0}; -- vk1
	local tbItemId8 = {18,1,141,1,0,0}; -- vk1
	local tbItemId9 = {18,1,142,1,0,0}; -- vk1
	local tbItemId10 = {18,1,143,1,0,0}; -- vk1
	local tbItemId11 = {18,1,144,1,0,0}; -- vk1
	local tbItemId12 = {18,1,145,1,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,134,1);
	local nCount2 = me.GetItemCountInBags(18,1,135,1);
	local nCount3 = me.GetItemCountInBags(18,1,136,1);
	local nCount4 = me.GetItemCountInBags(18,1,137,1);
	local nCount5 = me.GetItemCountInBags(18,1,138,1);
	local nCount6 = me.GetItemCountInBags(18,1,139,1);
	local nCount7 = me.GetItemCountInBags(18,1,140,1);
	local nCount8 = me.GetItemCountInBags(18,1,141,1);
	local nCount9 = me.GetItemCountInBags(18,1,142,1);
	local nCount10 = me.GetItemCountInBags(18,1,143,1);
	local nCount11 = me.GetItemCountInBags(18,1,144,1);
	local nCount12 = me.GetItemCountInBags(18,1,145,1);
	if nCount1 >= 1 and nCount2 >=1 and nCount3 >=1 and nCount4 >=1 and nCount5 >=1 and nCount6 >=1 and nCount7 >=1 and nCount8 >=1 and nCount9 >=1 and nCount10 >=1 and nCount11 >=1 and nCount12 >=1 then
	
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 1);
	Task:DelItem(me, tbItemId3, 1);
	Task:DelItem(me, tbItemId4, 1);
	Task:DelItem(me, tbItemId5, 1);
	Task:DelItem(me, tbItemId6, 1);
	Task:DelItem(me, tbItemId7, 1);
	Task:DelItem(me, tbItemId8, 1);
	Task:DelItem(me, tbItemId9, 1);
	Task:DelItem(me, tbItemId10, 1);
	Task:DelItem(me, tbItemId11, 1);
	Task:DelItem(me, tbItemId12, 1);
	me.AddExp(5000000);
	me.AddJbCoin(50000);
	me.AddBindCoin(50000);
	me.AddStackItem(18,1,3046,1,nil,20);-- 50 Tien du long
	me.AddStackItem(18,1,3019,1,nil,40);-- 50 Tien du long
	me.AddStackItem(18,1,3039,1,nil,5);-- 50 Tien du long
	
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> hoàn thành <color=red>NV Thu Thập Đặc Sản 12 Môn Phái<color> nhận được <color=gold>5 Vạn Đồng<color>");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> hoàn thành <color=gold>NV Thu Thập Đặc Sản 12 Môn Phái<color> nhận được <color=yellow>5 Vạn Đồng<color>");
	me.Msg("Bạn hoàn thành nhiệm vụ nhận được <color=yellow>5 Triệu Kinh Nghiệm<color> ");
	me.Msg("Bạn hoàn thành nhiệm vụ nhận được <color=yellow>5 Vạn Đồng<color> ");
	me.Msg("Bạn hoàn thành nhiệm vụ nhận được <color=yellow>5 Vạn Đồng Khóa<color> ");
	end
end;
