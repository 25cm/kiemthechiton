
local tbPhanThuong = {};
SpecialEvent.PhanThuong = tbPhanThuong;

tbPhanThuong.TaskGourp = 3000; --task mới phải add vào gameserver\setting\player\task_def.txt
tbPhanThuong.TaskId_Day = 1; --task lưu ngày
tbPhanThuong.TaskId_Count = 2; --task lưu lần nhận
tbPhanThuong.TaskId_Last = 3; --task lưu thời gian nhận
tbPhanThuong.Relay_Time = 5*60; --thời gian giữa 2 lần nhận mình để 30p 1 lần
tbPhanThuong.Use_Max =3; --số lần nhận tối đa

function tbPhanThuong:OnDialog()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if me.GetTask(self.TaskGourp, self.TaskId_Day) < nDate then
		me.SetTask(self.TaskGourp, self.TaskId_Day, nDate);
		me.SetTask(self.TaskGourp, self.TaskId_Count, 0);
		me.SetTask(self.TaskGourp, self.TaskId_Last, 0);
	end 
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count);
	local szMsg = "";
	szMsg = string.format("Mỗi <color=yellow>5 phút online<color> hàng ngày có thể nhận thưởng, tối đa <color=yellow>%d<color> lần.\n\n",self.Use_Max);
	local szColor = "<color=Gray>"
	local szColorx = "<color>"
	szMsg = szMsg.."\n<color=green>Lần 1:<color> "..((nCount >= 1 and szColor) or "").."200 vạn bạc khóa+ 20 vạn đồng khóa<color>";
	szMsg = szMsg.."\n<color=green>Lần 2:<color> "..((nCount >= 2 and szColor) or "").."200 Tiền Du Long<color>";
	szMsg = szMsg.."\n<color=green>Lần 3:<color> "..((nCount >= 3 and szColor) or "").."200 Điểm Danh Vọng Tần Lăng - Vũ Khí<color>";
	szMsg = szMsg..string.format("\n\n<color=yellow>Hôm nay bạn đã nhận "..((nCount >= self.Use_Max and "đủ") or nCount).." phần thưởng.<color>");
	local tbOpt = {};
	if (nCount<self.Use_Max) then
		table.insert(tbOpt , {"Nhận thưởng ngay",  self.nhanthuong, self});
	end
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbPhanThuong:nhanthuong()
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count);
    if nCount >= self.Use_Max then
        Dialog:Say(string.format("Hôm nay bạn đã nhận đủ phần thưởng."));
        return 0; 
    end    
	local nLast = me.GetTask(self.TaskGourp, self.TaskId_Last);
	local nHour = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	local nSec1 = Lib:GetDate2Time(nHour);
	local nSec2 = nLast + self.Relay_Time;
		if nSec1 < nSec2 then
			if ((nSec2 - nSec1)<=60) then
				me.Msg(string.format("Còn <color=yellow>%s giây<color> nữa mới nhận được phần thưởng tiếp theo.", (nSec2 - nSec1)));
			else
				me.Msg(string.format("Còn <color=yellow>%d phút<color> nữa mới nhận được phần thưởng tiếp theo.", (nSec2 - nSec1)/60));
			end
			return 0;
		end
	if (nCount == 0) then
		me.AddBindMoney(2000000);
			me.AddBindCoin(200000); --phần thưởng thứ 1
	elseif (nCount == 1) then
		me.AddStackItem(18,1,553,1,nil,2000); --phần thưởng thứ 2
	elseif (nCount == 2) then
		me.AddRepute(9,2,200); --phần thưởng thứ 3
	end
	me.Msg(string.format("Bạn đã nhận được phần thưởng hàng ngày lần <color=yellow>%d<color>",nCount + 1));
	me.SetTask(self.TaskGourp, self.TaskId_Count, nCount + 1);
	local nHourS = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	local nSec3 = Lib:GetDate2Time(nHourS);
	me.SetTask(self.TaskGourp, self.TaskId_Last, nSec3);
end
