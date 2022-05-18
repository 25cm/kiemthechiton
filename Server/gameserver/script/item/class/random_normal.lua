




local tbRandom = Item:GetClass("random_scroll");

function tbRandom:OnUse()
	local nReferTaskId = it.GetGenInfo(1);
	local nMainTaskId = Task.tbReferDatas[nReferTaskId].nTaskId;
	
	if nReferTaskId==0 or nReferTaskId==nil then
		Dialog:Say("Mở Trục cuốn nhiệm vụ thất bại!");
		return;
	end;
	
	print (string.format("Apply task: Main task id: %d / Refer task id: %d", nMainTaskId, nReferTaskId));
	
	Dialog:Say("Nhận nhiệm vụ này?<enter><enter>Miêu tả nhiệm vụ:"..RandomTask:GetTaskInfo(nReferTaskId).."<enter><enter>",
				{
					{"Phải", tbRandom.OnOkay, tbRandom, nMainTaskId, nReferTaskId, it},
					{"Không"},
					{"Mất trục cuốn", tbRandom.OnDeleteAsk, tbRandom, it},
				}
		);
	
end;


function tbRandom:OnOkay(nMainTaskId, nReferTaskId, item)
	print (string.format("Get task id: Main task id: %d / Refer task id: %d", nMainTaskId, nReferTaskId));
	local tbReferTask = RandomTask:HaveRandomTask();
	if tbReferTask then
		Dialog:Say("Đang làm Trục cuốn nhiệm vụ thường: <color=yellow>"..tbReferTask.szName.."<color>, phải hoàn thành hoặc bỏ mới bắt đầu Trục cuốn nhiệm vụ mới được!");
		return;
	end;
	
	Task:DoAccept(nMainTaskId, nReferTaskId);
	item.Delete(me);
end;


function tbRandom:GetTip(nState)
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


function tbRandom:OnDeleteAsk(item)
	
	local nReferTaskId = item.GetGenInfo(1);
	local nMainTaskId = Task.tbReferDatas[nReferTaskId].nTaskId;
		
	Dialog:Say("Muốn <color=yellow>bỏ Trục cuốn nhiệm vụ này<color>?<enter><enter>Miêu tả nhiệm vụ:<color=green>"..RandomTask:GetTaskInfo(nReferTaskId).."<color>",
				{
					{"Phải", tbRandom.OnDelete, tbRandom, item},
					{"Không"},
					}
				);
end;


function tbRandom:OnDelete(item)
	item.Delete(me);
	me.Msg("<color=yellow>Bỏ 1 Trục cuốn nhiệm vụ<color>!");
end;
