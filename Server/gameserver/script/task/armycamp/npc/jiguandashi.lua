--机关大师
--孙多良
--2008.08.15

local tbNpc = Npc:GetClass("jiguandashi");
tbNpc.tbArmyBag = {20,1,482,1};
tbNpc.tbArmyHandBook = {20,1,483,1};
tbNpc.nTaskGroupId = 2044;	--随机获得零件的任务变量Group
tbNpc.tbTaskId =
{
	--随机获得零件的任务变量
	1,2,3,4,5,6,7,8,9,10,
}

function tbNpc:OnDialog()
	local szMsg = "Thiên địa phân âm dương, vạn vật hóa Ngũ hành, bổ trợ cho nhau, tương sinh tương khắc. Tinh túy của Cơ quan học không phải là kỹ nghệ tuyệt vời, mà là sáng tạo thuận theo tự nhiên.";
	local tbOpt = 
	{
		{"Dùng độ bền cơ quan đổi vật phẩm", Dialog.OpenShop, Dialog, 129, 10},
		{"Nhận rương cơ quan", self.GetArmyBag, self},
		--{"领取机关材料手册", self.GetArmyHandBook, self},
		{"Nhận sổ tay tài liệu cơ quan", self.recycleHandBook, self},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetArmyBag()
	if me.nLevel < 90 then
		Dialog:Say("Thiên Cơ Tử: Ngươi phải đạt cấp 90 mới đủ điều kiện tham gia sự kiện.");
		return 0;
	end
	if me.GetTask(1022,117) ~= 1 then
		Dialog:Say("Thiên Cơ Tử: Chàng trai trẻ, bạn vẫn chưa bắt đầu, hãy hoàn thành nhiệm vụ diễn tập quân đội mới trước.");		
		return 0;
	end
	local tbFind1 = me.FindItemInBags(unpack(self.tbArmyBag));
	local tbFind2 = me.FindItemInRepository(unpack(self.tbArmyBag));
	if #tbFind1 <= 0 and #tbFind2 <= 0 then
		if me.CountFreeBagCell() >= 1 then
			local pItem = me.AddItem(unpack(self.tbArmyBag));
			if pItem then
				
			end
			Dialog:Say("Thiên Cơ Tử: Ngươi đã nhận thành công rương cơ quan.")
		else
			Dialog:Say("Thiên Cơ Tử: Hành trang không đủ ô trống.");
		end
	else
		Dialog:Say("Thiên Cơ Tử: Ngươi đã nhận được rương cơ quan.")
	end
	return 0;
end

function tbNpc:GetArmyHandBook()
	local tbFind1 = me.FindItemInBags(unpack(self.tbArmyHandBook));
	local tbFind2 = me.FindItemInRepository(unpack(self.tbArmyHandBook));
	if #tbFind1 <= 0 and #tbFind2 <= 0 then
		if me.CountFreeBagCell() >= 1 then
			local pItem = me.AddItem(unpack(self.tbArmyHandBook));
			if pItem then
				pItem.Bind(1);
			end
			Dialog:Say("Thiên Cơ Tử: Ngươi đã nhận thành công sổ tay tài liệu cơ quan")
		else
			Dialog:Say("Thiên Cơ Tử: Hành trang không đủ ô trống.");
		end
	else
		Dialog:Say("Thiên Cơ Tử: Ngươi đã nhận được sổ tay tài liệu cơ quan")
	end
	return 0;
end

function tbNpc:recycleHandBook()
	local tbFind1 = me.FindItemInBags(unpack(self.tbArmyHandBook));
	if #tbFind1 <= 0 then
		Dialog:Say("Thiên Cơ Tử: Ngươi không có sổ tay tài liệu cơ quan.")
		return 0;
	end
	for i, nTaskId in pairs(self.tbTaskId) do
		if me.GetTask(self.nTaskGroupId, nTaskId) == 0 then
			Dialog:Say("Thiên Cơ Tử: Ngươi chưa thu thập đủ 10 loại linh kiện cơ quan, hãy tiếp tục thu thập rồi dến gặp ta.")
			return 0;
		end
	end
	me.ConsumeItemInBags(1,unpack(self.tbArmyHandBook));
	for i, nTaskId in pairs(self.tbTaskId) do
		me.SetTask(self.nTaskGroupId, nTaskId, 0)
	end
	me.AddExp(5000000);
	me.AddBindCoin(10000);
	me.AddStackItem(18,1,3046,1,nil,3);
	me.AddStackItem(18,1,3019,1,nil,3);
	me.Msg("Nhận được 50000000 điểm kinh nghiệm");
	me.Msg("Nhận được 1vạn đồng khóa");
	me.Msg("Nhận được 3 Rương Mảnh Ghép");
	me.Msg("Nhận được 3 Rương Vật Phẩm");
end
