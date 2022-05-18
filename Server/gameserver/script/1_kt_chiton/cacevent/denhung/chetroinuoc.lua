local tbCheTroiNuoc = Item:GetClass("chetroinuoc");
tbCheTroiNuoc.TaskId_Count = 1;
tbCheTroiNuoc.TASK_GROUP_ID1 = 3011;
function tbCheTroiNuoc:OnUse()
local nCount555 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
if nCount555 > 300 then
Dialog:SendBlackBoardMsg(me, string.format("Mỗi nhân vật sử dụng tối đa 300 Chè Trôi Nước trong suốt thời gian sự kiện"));
return 
end
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
local tbItemId2	= {18,1,20310,1,0,0};
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 10000);
	

	local tbRate = {4900, 4700, 250, 150};
	local tbAward = {1 ,2, 3, 4};
	

	for i = 1, 4 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
		if (tbAward[nIndex]==1) then
	me.AddStackItem(18,1,1,7,nil,1); -- 1 HT7
	Dialog:SendBlackBoardMsg(me, string.format("Sử dụng ".. nCount555+1 .." Chè Trôi Nước. Còn ".. 300 - (nCount555+1) .." Chưa Dùng"));
	Task:DelItem(me, tbItemId2, 1);
	me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
	end
	---------
		if (tbAward[nIndex]==2) then
	me.AddStackItem(18,1,205,1,nil,100); -- 100 NHHT
	Dialog:SendBlackBoardMsg(me, string.format("Sử dụng ".. nCount555+1 .." Chè Trôi Nước. Còn ".. 300 - (nCount555+1) .." Chưa Dùng"));
	Task:DelItem(me, tbItemId2, 1);
	me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
	end
	----------
		if (tbAward[nIndex]==3) then
	me.AddStackItem(18,1,377,1,nil,2); -- 2 HTB
	Dialog:SendBlackBoardMsg(me, string.format("Sử dụng ".. nCount555+1 .." Chè Trôi Nước. Còn ".. 300 - (nCount555+1) .." Chưa Dùng"));
	Task:DelItem(me, tbItemId2, 1);
	me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
	end
	----------
		if (tbAward[nIndex]==4) then
	me.AddStackItem(18,1,402,1,nil,5); -- 5 Chân Nguyên TLĐ
	Dialog:SendBlackBoardMsg(me, string.format("Sử dụng ".. nCount555+1 .." Chè Trôi Nước. Còn ".. 300 - (nCount555+1) .." Chưa Dùng"));
	Task:DelItem(me, tbItemId2, 1);
	me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
	end
	if me.GetTask(3011,1) == 100 then
me.AddStackItem(18,1,205,1,nil,5000) -- 5k NHHT
me.AddExp (150000000) -- 150tr EXP
me.AddStackItem(18,1,377,1,nil,20) -- 20 HTB
me.AddStackItem(18,1,402,1,nil,10) -- 10 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,4,nil,10) -- 10 Thánh Linh Bảo Hạp Hồn
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
end
--- 200 ---
if me.GetTask(3011,1) == 200 then
me.AddStackItem(18,1,205,1,nil,10000) -- 1v NHHT
me.AddExp (200000000) -- 200tr EXP
me.AddStackItem(18,1,377,1,nil,20) -- 20 HTB
me.AddStackItem(18,1,402,1,nil,13) -- 13 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,4,nil,13) -- 13 Thánh Linh Bảo Hạp Hồn
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
end
--- 300 ---
if me.GetTask(3011,1) == 300 then
me.AddStackItem(18,1,205,1,nil,15000) -- 1v5 NHHT
me.AddExp (300000000) -- 300tr EXP
me.AddStackItem(18,1,377,1,nil,20) -- 20 HTB
me.AddStackItem(18,1,402,1,nil,13) -- 13 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,4,nil,13) -- 13 Thánh Linh Bảo Hạp Hồn
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
end
end