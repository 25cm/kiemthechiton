




local tbBook = Item:GetClass("advanced_scroll");

function tbBook:OnUse()
	local nReferTaskId = it.GetGenInfo(1);
	local nMainTaskId = Task.tbReferDatas[nReferTaskId].nTaskId;
	
	if nReferTaskId==0 or nReferTaskId==nil then
		Dialog:Say("Mở Trục cuốn nhiệm vụ thất bại!");
		return;
	end;
	
	print (string.format("Apply scroll task: Main task id: %d / Refer task id: %d", nMainTaskId, nReferTaskId));
	
	Dialog:Say("Nhận Trục cuốn nhiệm vụ cấp cao này?<enter><enter>Miêu tả nhiệm vụ:"..ScrollTask:GetTaskInfo(nReferTaskId).."<enter><enter>",
				{
					{"Phải", tbBook.OnOkay, tbBook, nMainTaskId, nReferTaskId, it},
					{"Không"},
				}
		);
end;


function tbBook:OnOkay(nMainTaskId, nReferTaskId, item)
	print (string.format("Get scroll task id: Main task id: %d / Refer task id: %d", nMainTaskId, nReferTaskId));
	local tbReferTask = ScrollTask:HaveScrollTask();
	if tbReferTask then
		Dialog:Say("Đang tiến hành Trục cuốn nhiệm vụ cấp cao: <color=yellow>"..tbReferTask.szName.."<color>, phải hoàn thành hoặc bỏ mới bắt đầu Trục cuốn nhiệm vụ cấp cao mới được!");
		return;
	end;
	
	Task:DoAccept(nMainTaskId, nReferTaskId);
	item.Delete(me);
end;


function tbBook:GetTip(nState)
	local nTaskId = it.GetGenInfo(1);
	local szMain = "Trục cuốn nhiệm vụ<enter><enter>";
	
	if nTaskId==0 or nTaskId==nil then
		return szMain.."Nhận miêu tả nhiệm vụ thất bại!";
	end;
	
	szMain = szMain.."<color=yellow>Miêu tả nhiệm vụ<color>:"..ScrollTask:GetTaskInfo(nTaskId).."<enter><enter>";
	
	szMain = szMain.."Thưởng sau khi hoàn thành nhiệm vụ:<enter><enter>";
	
	szMain = szMain..ScrollTask:GetTaskAwardText(nTaskId);

	szMain = szMain.."Nhấp chuột phải vào trục cuốn nhận thông tin nhiệm vụ cụ thể";
	return szMain;
end;
