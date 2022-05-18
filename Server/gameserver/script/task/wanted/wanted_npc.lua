--官府通缉任务
--孙多良
--2008.08.06
Require("\\script\\task\\wanted\\wanted_def.lua");

function Wanted:OnDialog()
	local nFlag = self:Check_Task();
	if nFlag == 1 then
		self:OnDialog_Finish()
	elseif nFlag == 2 then
		self:OnDialog_NoFinish()
	elseif nFlag == 3 then
		self:OnDialog_NoAccept()
	else
		self:OnDialog_Accept()
	end
end

function Wanted:OnDialog_Accept()
	local szMsg = string.format("Bổ Đầu Hình Bộ: Gần đây bọn Hải tặc luôn gây hại cho dân, ngươi có đồng ý giúp đỡ Nha Môn bắt giữ chúng để trừ hại cho dân?\n\n<color=yellow>Hôm nay ngươi còn %s lần<color>", self:GetTask(self.TASK_COUNT));
	local tbOpt = {
		{"Ta muốn truy bắt Hải Tặc", self.SingleAcceptTask, self},
		{"<color=green>Giới thiệu về HĐ truy bắt Hải Tặc<color>", self.gthaitac, self},
		{"<color=yellow>Dùng Danh Bổ Lệnh Đổi phần thưởng<color>", self.OnGetAward, self},
		{"Để ta suy nghĩ đã"},
	}
	if me.IsCaptain() == 1 then
		table.insert(tbOpt, 1, {"<color=red>Ta muốn cùng đồng đội truy bắt Hải Tặc<color>", self.CaptainAcceptTask, self})
	end
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:OnDialog_NoAccept()
	local szMsg = string.format("Bổ Đầu Hình Bộ: Gần đây bọn Hải tặc luôn gây hại cho dân, ngươi có đồng ý giúp đỡ Nha Môn bắt giữ chúng để trừ hại cho dân? Nhưng ta thấy ngươi vẫn chưa đủ thực lực, sau khi đạt cấp 50 hãy quay lại tìm ta.");
	local tbOpt = {
		{"Ta biết rồi"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:OnDialog_Finish()
	local nTask = Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID].nReferId;
	local szMsg = self:CreateText(nTask)
	local tbOpt = {
		{"Hoàn thành nhiệm vụ, đến nhận thưởng", self.FinishTask, self},
		{"<color=yellow>Dùng Danh Bổ Lệnh Đổi phần thưởng<color>", self.OnGetAward, self},
		{"Để ta suy nghĩ đã"},		
	}
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:OnDialog_NoFinish()
	local nTask = Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID].nReferId;
	local szMsg = self:CreateText(nTask)
	local tbOpt = {
		{"Ta muốn hủy nhiệm vụ", self.CancelTask, self},
		{"<color=yellow>Dùng Danh Bổ Lệnh Đổi phần thưởng<color>", self.OnGetAward, self},
		{"Để ta suy nghĩ đã"},	
	};
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:CreateText(nTask)
	local szMsg = string.format("Tên nhiệm vụ: [<color=green>Tuy bắt Hải Tặc %s<color>]\nMiêu tả nhiệm vụ: Nghe nói<color=green> Hải Tặc %s<color> gần đây xuất hiện tại <color=yellow>%s<color>, tọa độ <color=yellow>(%s,%s)<color>, ngươi phải truy bắt hắn về quy án, khôi phục an ninh nơi đó.",self.TaskFile[nTask].szTaskName, self.TaskFile[nTask].szTaskName, self.TaskFile[nTask].szMapName, math.floor(self.TaskFile[nTask].nPosX/8), math.floor(self.TaskFile[nTask].nPosY/16));
	return szMsg;	
end

function Wanted:OnGetAward()
	local szMsg = "Bổ Đầu Hình Bộ: Bọn Hải tặc đã bị bắt về quy án, triều đình ban thưởng. Các vị đại hiệp có thể đem Danh Bổ Lệnh đến đổi phần thưởng.";
	local tbOpt = 
	{
		{"40 <color=green>Danh Bổ Lệnh<color> = 1 <color=yellow>Vạn Đồng<color>",self.mg, self},
		{"20 <color=green>Danh Bổ Lệnh<color> = 1 <color=yellow>LB Triệu Hồi Boss TDC<color>",self.lbtdc, self},
		{"Để ta suy nghĩ đã"}
	}
	Dialog:Say(szMsg, tbOpt);
end

	
function Wanted:mg()
	 local tbNpc = Npc:GetClass("doirmg1");
	 tbNpc:OnDialog_1();
end;
function Wanted:vp()
	 local tbNpc = Npc:GetClass("doirvp1");
	 tbNpc:OnDialog_1();
end;
function Wanted:lbtdc()
	 local tbNpc = Npc:GetClass("lbtdc");
	 tbNpc:OnDialog_1();
end;
function Wanted:gthaitac()
	local szMsg = "Giới thiệu về hoạt động Săn Hải Tặc :";
	local tbOpt = 
	{	
		{"<color=green>Hướng Dẫn Hoạt Động<color>" , self.hdhd, self};
		{"<color=yellow>Phần Thưởng<color>" , self.phanthuong, self};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end
function Wanted:hdhd()
	local szMsg = "Hướng Dẫn Hoạt Động:";
	local tbOpt = 
	{	
		{"<color=green>Số Nhiệm Vụ Săn Hải Tặc Hàng Ngày: 10Lần/1ngày<color>"};
		{"<color=green>Số Nhiệm Vụ Săn Hải Tặc Tích Lũy Tối Đa: 30Lần<color>"};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end
function Wanted:phanthuong()
	local szMsg = "<color=yellow>Phần Thưởng<color> Nhận Được Khi Hoàn Thành Nhiệm Vụ:";
	local tbOpt = 
	{	
	    {"<color=yellow>Đồng Thường/ Rương Mảnh Ghép/ Rương Vật Phẩm/ Pháo Hoa/ Tiền Du Long/ Danh Bổ Lệnh/ Kinh Nghiệm...<color>"};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end