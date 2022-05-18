local tbNpc = Npc:GetClass("yijunshouling");

tbNpc.nTaskGroupId 		= 1021;
tbNpc.nTaskValueId		= 7;
tbNpc.nTmpDeadline		= 80204;	-- 2000年2月4日以后不会再送紫装
tbNpc.tbFaction = 
{
	{desc = "Chiến Sĩ", 		result = "<color=gold>Hệ phái phù hợp Chiến Sĩ<color>: Côn Thiếu Lâm, Thương Thiên Vương, Chùy Thiên Vương, Chùy Minh Giáo, Chiến Nhẫn, Chỉ Đoàn Thị."},
	{desc = "Thuật Sĩ",			result = "<color=gold>Hệ phái phù hợp Thuật Sĩ<color>: Chưởng Ngũ Độc, Kiếm Minh Giáo, Chưởng Nga My, Kiếm Thúy Yên, Ma Nhẫn, Khí Võ Đang, Kiếm Côn Lôn, Khí Đoàn Thị."},
	{desc = "Du Hiệp",			result = "<color=gold>Hệ phái thích hợp Du Hiệp<color>: Đao Thiếu Lâm, Tụ Tiễn Đường Môn, Đao Ngũ Độc, Chưởng Cái Bang, Côn Cái Bang, Đao Côn Lôn."},
	{desc = "Thích Khách",			result = "<color=gold>Hệ phái thích hợp Thích Khách<color>: Hãm Tĩnh Đường Môn, Đao Thúy Yên, Kiếm Võ Đang."},
	{desc = "Phụ Trợ Sư",		result = "<color=gold>Hệ phái thích hợp Phụ Trợ Sư<color>: Phụ Trợ Nga My."},
}

tbNpc.tbOperate = 
{
	{desc = "Thao tác đơn giản",				result = "<color=gold>Hệ phái thích hợp thao tác đơn giản<color>: Phụ Trợ Nga My."},
	{desc = "Xem trọng thao tác",		result = "<color=gold>Hệ phái thích hợp xem trọng thao tác<color>: Đao Thiếu Lâm, Thương Thiên Vương, Chùy Thiên Vương, Tụ Tiễn Đường Môn, Đao Ngũ Độc, Chưởng Ngũ Độc, Chùy Minh Giáo, Kiếm Minh Giáo, Chưởng Nga My, Kiếm Thúy Yên, Khí Đoàn Thị, Chưởng Cái Bang, Côn Cái Bang, Chiến Nhẫn, Ma Nhẫn, Khí Võ Đang, Kiếm Võ Đang, Đao Côn Lôn, Kiếm Côn Lôn."},
	{desc = "Tương đối xem trọng thao tác",		result = "<color=gold>Hệ phái thích hợp tương đối xem trọng thao tác<color>: Côn Thiếu Lâm, Hãm Tĩnh Đường Môn, Đao Thúy Yên, Chỉ Đoàn Thị."},
}

tbNpc.tbLonely = 
{
	{desc = "Độc Hành Hiệp",			result = "<color=gold>Hệ phái thích hợp Độc Hành Hiệp<color>: Thương Thiên Vương, Chùy Thiên Vương, Hãm Tĩnh Đường Môn, Tụ Tiễn Đường Môn, Đao Ngũ Độc, Chưởng Ngũ Độc, Chùy Minh Giáo, Đao Thúy Yên, Chỉ Đoàn Thị, Chưởng Cái Bang, Côn Cái Bang, Chiến Nhẫn."},
	{desc = "Nhóm cao thủ",		result = "<color=gold>Hệ phái thích hợp nhóm cao thủ<color>: Đao Thiếu Lâm, Côn Thiếu Lâm, Kiếm Minh Giáo, Chưởng Nga My, Phụ Trợ Nga My, Kiếm Thúy Yên, Khí Đoàn Thị, Ma Nhẫn, Khí Võ Đang, Kiếm Võ Đang, Đao Côn Lôn, Kiếm Côn Lôn."},
}

tbNpc.tbSex = 
{
	{desc = "Nam",				result = "<color=gold>Hệ phái thích hợp nam<color>: Đao Thiếu Lâm, Côn Thiếu Lâm."},
	{desc = "Nữ",				result = "<color=gold>Hệ phái thích hợp nữ<color>: Chưởng Nga My, Phụ Trợ Nga My."},
	{desc = "Cả nam lẫn nữ",		result = "<color=gold>Hệ phái thích hợp cả nam nữ<color>: Thương Thiên Vương, Chùy Thiên Vương, Đao Thúy Yên, Kiếm Thúy Yên, Hãm Tĩnh Đường Môn, Tụ Tiễn Đường Môn, Đao Ngũ Độc, Chưởng Ngũ Độc, Chùy Minh Giáo, Kiếm Minh Giáo, Chỉ Đoàn Thị, Khí Đoàn Thị, Chưởng Cái Bang, Côn Cái Bang, Chiến Nhẫn, Ma Nhẫn, Khí Võ Đang, Kiếm Võ Đang, Đao Côn Lôn, Kiếm Côn Lôn."},
}

function tbNpc:OnDialog()
	local nTaskValue = me.GetTask(self.nTaskGroupId, self.nTaskValueId);
	local szDialogMsg = "Xin chào!";
	local tbDialogOpt = {};
	table.insert(tbDialogOpt, {"Tiêu hủy đạo cụ",  Dialog.Gift, Dialog, "Task.DestroyItem.tbGiveForm"})
	if (nTaskValue == 1 or nTaskValue == 2) then
		szDialogMsg = "Đã hiểu rõ 12 đại môn phái, ta có 1 số vần đề muốn hỏi, có lẽ sẽ giúp ngươi chọn 1 môn phái phù hợp."		
		table.insert(tbDialogOpt, {"Hướng dẫn hệ phái", self.OnSelectFaction, self});
	end
	if (tonumber(GetLocalDate("%y%m%d")) <= self.nTmpDeadline) then
		local tbNpcBai = Npc:GetClass("tmpnpc");
		table.insert(tbDialogOpt, {"Tống Kim chuyên dùng phương án thể nghiệm nhân vật", tbNpcBai.OnDialog, tbNpcBai});
		table.insert(tbDialogOpt, {"Lập gia tộc", Kin.DlgCreateKin, Kin});
		table.insert(tbDialogOpt, {"Lập bang hội", Tong.DlgCreateTong, Tong});
	end
	table.insert(tbDialogOpt, {"Kết thúc đối thoại"});
	Dialog:Say(szDialogMsg, tbDialogOpt);
end;

function tbNpc:OnSelectFaction()
	local szMainMsg = "Tuyệt kỹ võ học của 12 môn phái đều có sở trường riêng, bạn muốn chọn môn phái nào?";
	Dialog:Say(szMainMsg, 
		{
			{"A："..self.tbFaction[1].desc,self.OnSelectOperate, self, 1},
			{"B："..self.tbFaction[2].desc,self.OnSelectOperate, self, 2},
			{"C："..self.tbFaction[3].desc,self.OnSelectOperate, self, 3},
			{"D："..self.tbFaction[4].desc,self.OnSelectOperate, self, 4},
			{"E："..self.tbFaction[5].desc,self.OnSelectOperate, self, 5},
		})
end

function tbNpc:OnSelectOperate(nFaction)
	self.nFaction = nFaction;
	local szMainMsg = "Khi chiến đấu mỗi môn phái sẽ có độ khó khác nhau, bạn muốn chọn môn phái nào?";
		Dialog:Say(szMainMsg, 
		{
			{"A："..self.tbOperate[1].desc,self.OnSelectLonely, self, 1},
			{"B："..self.tbOperate[2].desc,self.OnSelectLonely, self, 2},
			{"C："..self.tbOperate[3].desc,self.OnSelectLonely, self, 3},
		})	
end

function tbNpc:OnSelectLonely(nOperate)
	self.nOperate = nOperate;
	local szMainMsg = "Các môn phái đều có ưu thế khác nhau, bạn muốn làm một hiệp khách vạn lý độc hành hay một cao thủ rong ruổi chốn vạn mã thiên quân?";
	Dialog:Say(szMainMsg, 
		{
			{"A："..self.tbLonely[1].desc,self.OnSelectSex, self, 1},
			{"B："..self.tbLonely[2].desc,self.OnSelectSex, self, 2},
		})	
end

function tbNpc:OnSelectSex(nLonely)
	self.nLonely = nLonely;
	local szMainMsg = "Người sáng lập 12 môn phái có nam nữ, các môn phái được dựng nên từ sự tương dị của âm dương, bạn muốn chọn môn phái nào?";
	Dialog:Say(szMainMsg, 
		{
			{"A："..self.tbSex[1].desc, self.OnFinalyDialog, self, 1},
			{"B："..self.tbSex[2].desc, self.OnFinalyDialog, self, 2},
			{"C："..self.tbSex[3].desc, self.OnFinalyDialog, self, 3},
		})
end

function tbNpc:OnFinalyDialog(nSex)
	self.nSex = nSex;
	local szMainMsg = "Tiến cử như sau. Nếu có gì thắc mắc hãy dùng \"Tiến Cử Môn Phái\" đến chỗ ta hỏi thăm: \n\n"..
	self.tbFaction[self.nFaction].result.."\n"..
	self.tbOperate[self.nOperate].result.."\n"..
	self.tbLonely[self.nLonely].result.."\n"..
	self.tbSex[self.nSex].result;
	
	Dialog:Say(szMainMsg, 
		{
			{"Đã hiếu rõ", self.OnClose, self}	
		})
end

function tbNpc:OnClose()
	me.SetTask(self.nTaskGroupId, self.nTaskValueId, 2);
end
