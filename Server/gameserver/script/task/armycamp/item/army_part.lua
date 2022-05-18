--军营任务.零件
--孙多良
--2008.08.18

local tbItem = Item:GetClass("army_part")

tbItem.nTaskGroupId = 2044;	--随机获得零件的任务变量Group
tbItem.nRate =	10; --每读一页获得零件的几率,百分比
tbItem.tbArmyHandBook = {20,1,483,1};
tbItem.tbTaskId =
{
	--随机获得零件的任务变量
	1,2,3,4,5,6,7,8,9,10,
}
tbItem.tbTaskName = {"Tiền trục","Hậu trục","Trung cốt","Cánh tả","Cánh hữu","Tiêu thạch","Lưu huỳnh","Gỗ","Thỏi đồng","Thủy ngân"};

function tbItem:OnUse()
	local tbFind1 = me.FindItemInBags(unpack(self.tbArmyHandBook));
	local tbFind2 = me.FindItemInRepository(unpack(self.tbArmyHandBook));
	if #tbFind1 <= 0 and #tbFind2 <= 0 then
		if me.CountFreeBagCell() >= 1 then
			local pItem = me.AddItem(unpack(self.tbArmyHandBook));
			if pItem then
				pItem.Bind(1);
			end
			--me.Msg("您获得了机关材料手册。")
		else
			me.Msg("Hành trang không đủ ô trống.");
			return 0;
		end
	end
	local nFull = 0;
	for ni, nTaskId in pairs(self.tbTaskId) do
		if me.GetTask(self.nTaskGroupId, nTaskId) == 0 then
			nFull = 1;
			break;
		end
	end
	if nFull == 0 then
		me.Msg("Sổ tay tài liệu cơ quan, tập hợp đủ 10 loại linh kiện có thể đến chỗ Thiên Cơ Tử đổi phần thưởng.")
		return 0;
	end
	local nR = Random(10)+1;
	if me.GetTask(self.nTaskGroupId, self.tbTaskId[nR]) == 0 then
		me.SetTask(self.nTaskGroupId, self.tbTaskId[nR], 1);
		me.Msg(string.format("Thu thập được 1 <color=yellow>%s<color> thêm vào Sổ tay tài liệu cơ quan.",self.tbTaskName[nR]));
	else
		me.Msg(string.format("Thu thập được 1 <color=yellow>%s<color>, nhưng đã có trong Sổ tay tài liệu cơ quan.",self.tbTaskName[nR]));
	end
	for ni, nTaskId in pairs(self.tbTaskId) do
		if me.GetTask(self.nTaskGroupId, nTaskId) == 0 then
			return 1;
		end
	end
	me.Msg("Đã thu thập đủ 10 loại linh kiện, hãy đến chỗ Thiên Cơ Tử để đổi phần thưởng.")
	Dialog:SendBlackBoardMsg(me, "Đã thu thập đủ 10 loại linh kiện, hãy đến chỗ Thiên Cơ Tử để đổi phần thưởng.");
	return 1;
end
