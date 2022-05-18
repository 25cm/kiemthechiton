
local tbItem = Item:GetClass("xiulianwan");
tbItem.TaskGourp = 2067;
tbItem.TaskId_Day = 8;
tbItem.TaskId_Count = 9;
tbItem.Use_Max = 20;

function tbItem:OnUse()
	local nDate = tonumber(GetLocalDate("%y%m%d"));
	if me.GetTask(self.TaskGourp, self.TaskId_Day) < nDate then
		me.SetTask(self.TaskGourp, self.TaskId_Day, nDate);
		me.SetTask(self.TaskGourp, self.TaskId_Count, 0);
	end 
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count)
	if nCount >= self.Use_Max then
		Dialog:Say("Mỗi ngày chỉ được dùng tối đa 20 Tu Luyện Hoàn.");
		return 0;
	end
	
	local tbXiuLianZhu = Item:GetClass("xiulianzhu");
	if tbXiuLianZhu:GetReTime() > 13.5 then
		Dialog:Say("Thời gian tu luyện của bạn còn hơn 13.5 giờ, không thể sử dụng Tu Luyện Hoàn.");
		return 0;
	end
	tbXiuLianZhu:AddRemainTime(30);	
	me.Msg(string.format("Thời gian tu luyện của bạn đã tăng <color=green>0.5 giờ<color>, hôm nay bạn đã dùng <color=yellow>%s viên<color> Tu Luyện Hoàn.",nCount + 1));
	me.SetTask(self.TaskGourp, self.TaskId_Count, nCount + 1);
	return 1;
end
