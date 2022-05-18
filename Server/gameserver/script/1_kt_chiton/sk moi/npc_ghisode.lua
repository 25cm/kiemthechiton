local tbNpc = Npc:GetClass("ghisode");

tbNpc.TIMEREG_MAX =	1800;
tbNpc.TIMEREG_MIN	=	2000;
tbNpc.TASK_GR_LD =	3009;
tbNpc.TASK_ID_GHISO	=	1;
tbNpc.TASK_ID_SOTIEN = 2;

tbNpc.TASK_ID_GHISO_LO	=	3;
tbNpc.TASK_ID_SOTIEN_LO = 4;


function tbNpc:GhiSoDe()
		local nCurTime = tonumber(os.date("%H%M", GetTime()));
		if (nCurTime >= tbNpc.TIMEREG_MAX and nCurTime < tbNpc.TIMEREG_MIN) then
					Dialog:Say("Mỗi ngày chỉ nhận ghi số từ <color=yellow>20h00<color> ngày hôm trước đến <color=yellow>18h00<color> ngày hôm sau.Sau thời gian đó sẽ khóa sổ.Tổng kết và chờ kết quả để trao thưởng.");
					return 0;
		end
	local tbOpt = 
	{
		{"Ta muốn tham gia.", self.GhiSoDe01, self},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Ghi Số Xổ Số Kiến Thiết Miền Bắc sẽ tốn một khoản tiền đặt cược.Chỉ nhận Bạc Không Khóa.Nhà ngươi có muốn tham gia.", tbOpt);
end
function tbNpc:GhiSoDe01()
	local tbOpt = 
	{
		{"Ta muốn Đặt cược <color=yellow>1 ăn 70.", self.GhiSoDe02, self},
		{"Ta muốn Đặt cược <color=yellow>23 ăn 80.", self.GhiSoLo02, self},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Bạn muốn tham gia đặt cược theo tỷ lệ như thế nào?", tbOpt);
end
function tbNpc:GhiSoDe02()
	local szOptMsg = [[

<color=green>Quy Tắc:：<color>
    1.Đặt cược theo tỷ lệ 1 ăn 70 sẽ dựa vào <color=red> 2 số cuối giải đặc biệt.<color>
	2.Nếu bạn đặt cược trúng thưởng,Chúng tôi sẽ trả lại các bạn gấp <color=red>70 lần <color>số tiền các bạn đặt cược.
	3.Nếu Bạn đặt cược không trúng,bạn sẽ mất số tiền đặt cược.
	4.Một khi đã quyết định tham gia.bạn không thể thu hồi số tiền.
	5.Một ngày bạn có thể tham gia đặt cược nhiều lần.
	6.Tiền sẽ được gửi thư cho các bạn,thuế suất các bạn phải chịu.
	7.Số Tiền Đặt Cược tối thiểu là <color=red>50 vạn lượng.
]];

	local tbOpt = 
	{
		{"Ta muốn tham gia.", self.GhiSoDe03, self},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Khi tham gia,bạn phải tuân thủ những quy tắc sau đây:"..szOptMsg, tbOpt);
end
function tbNpc:GhiSoDe03()
local nMyMoney	= me.nCashMoney; --GetCash();
	if (nMyMoney < 500000) then
		Dialog:Say("Không đủ <color=red>50 Vạn Lượng<color>, có đủ rồi hãy quay lại.");
		return 0;
	end
    Dialog:AskNumber("Nhập số tiền.", nMyMoney, self.SoTien, self);
end
function tbNpc:SoTien(szMoney)
	if (szMoney < 500000) then
		Dialog:Say("Số tiền đặt cược phải lớn hơn <color=red>50 Vạn Lượng.", {"Nhập lại", self.GhiSoDe03, self}, {"Kết thúc đối thoại"});
		return 0;
	end
	me.Msg(string.format("Bạn muốn đặt cược <color=yellow>%s lượng",szMoney));
	me.SetTask(tbNpc.TASK_GR_LD,tbNpc.TASK_ID_SOTIEN,szMoney);
    Dialog:AskNumber("Nhập con số bạn dự đoán.", 99, self.ConSo, self);
end
function tbNpc:ConSo(szConSo)
local nSoTien = 	me.GetTask(tbNpc.TASK_GR_LD,tbNpc.TASK_ID_SOTIEN);
	if (not szConSo) then
		Dialog:Say("Bạn phải nhập một con số cụ thể", {"Nhập lại", self.GhiSoDe03, self}, {"Kết thúc đối thoại"});
		return 0;
	end
	me.SetTask(tbNpc.TASK_GR_LD,tbNpc.TASK_ID_GHISO,szConSo);
	
	if (szConSo <10 and szConSo >=0) then
	szConSo = "0"..szConSo;
	end
	local tbOpt = 
	{
		{"Ta muốn tham gia.", "GM.tbGMRole:SendMail_De", self},
		{"Kết thúc đối thoại"},
	}
		Dialog:Say(string.format("Bạn xác nhận muốn đặt cược con số <color=red>%s<color> với số tiền là <color=yellow>%s lượng.",szConSo,nSoTien), tbOpt);
end
function tbNpc:GhiSoLo02()
	local szOptMsg = [[

<color=green>Quy Tắc:：<color>
    1.Đặt cược theo tỷ lệ 23 ăn 80 sẽ dựa vào <color=red> 2 số cuối tất cả các giải<color>
	2.Nếu bạn đặt cược trúng thưởng,Chúng tôi sẽ trả lại các bạn gấp theo tỷ lệ số tiền các bạn đặt cược.
	3.Nếu Bạn đặt cược không trúng,bạn sẽ mất số tiền đặt cược.
	4.Một khi đã quyết định tham gia.bạn không thể thu hồi số tiền.
	5.Một ngày bạn có thể tham gia đặt cược nhiều lần.
	6.Tiền sẽ được gửi thư cho các bạn,thuế suất các bạn phải chịu.
	7.Số Tiền Đặt Cược tối thiểu là <color=red>230 vạn lượng.
]];

	local tbOpt = 
	{
		{"Ta muốn tham gia.", self.GhiSoLo03, self},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Khi tham gia,bạn phải tuân thủ những quy tắc sau đây:"..szOptMsg, tbOpt);
end
function tbNpc:GhiSoLo03()
local nMyMoney	= me.nCashMoney; --GetCash();
	if (nMyMoney < 2300000) then
		Dialog:Say("Không đủ <color=red>23 Vạn Lượng<color>, có đủ rồi hãy quay lại.");
		return 0;
	end
    Dialog:AskNumber("Nhập số tiền.", nMyMoney, self.SoTienLo, self);
end
function tbNpc:SoTienLo(szMoney)
	if (szMoney < 2300000) then
		Dialog:Say("Số tiền đặt cược phải lớn hơn <color=red>230 Vạn Lượng.", {"Nhập lại", self.GhiSoLo03, self}, {"Kết thúc đối thoại"});
		return 0;
	end
	me.Msg(string.format("Bạn muốn đặt cược <color=yellow>%s lượng",szMoney));
	me.SetTask(tbNpc.TASK_GR_LD,tbNpc.TASK_ID_SOTIEN,szMoney);
    Dialog:AskNumber("Nhập con số bạn dự đoán.", 99, self.ConSoLo, self);
end
function tbNpc:ConSoLo(szConSo)
local nSoTien = 	me.GetTask(tbNpc.TASK_GR_LD,tbNpc.TASK_ID_SOTIEN);
	if (szConSo == "" or szConSo < 0) then
		Dialog:Say("Bạn phải nhập một con số cụ thể", {"Nhập lại", self.GhiSoLo03, self}, {"Kết thúc đối thoại"});
		return 0;
	end
	me.SetTask(tbNpc.TASK_GR_LD,tbNpc.TASK_ID_GHISO,szConSo);
	
	if (szConSo <10 and szConSo >=0) then
	szConSo = "0"..szConSo;
	end
	local tbOpt = 
	{
		{"Ta muốn tham gia.", "GM.tbGMRole:SendMail_Lo", self},
		{"Kết thúc đối thoại"},
	}
		Dialog:Say(string.format("Bạn xác nhận muốn đặt cược con số <color=red>%s<color> với số tiền là <color=yellow>%s lượng.",szConSo,nSoTien), tbOpt);
	end
