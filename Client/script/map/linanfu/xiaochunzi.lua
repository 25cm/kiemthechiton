
local tbNpc = Npc:GetClass("xiaochunzi");

local tbTaskValue	= {
	[1]	= {"Tẩm Cung Hoàng Thượng", 518,1582,3211,0},
	[2]	= {"Tẩm Cung Thái Hoàng Thái Hậu", 519, 1582,3211,0},
	[3]	= {"Tẩm Cung Thái Hoàng Thái Hậu", 520, 1582,3211,0},
	[4]	= {"Tẩm Cung Thái Hoàng Thái Hậu", 521, 1582,3211,0},
	[5]	= {"Hoàng Cung Đại Điện", 523,1580,3258,1},
}

function tbNpc:OnDialog()
		Dialog:Say("Nếu ngươi bất cẩn ra khỏi phòng nhiệm vụ, không thể làm tiếp nhiệm vụ, hãy đến tìm ta. Ta sẽ đưa ngươi trở vào bản đồ nhiệm vụ. Giờ ngươi đến nhờ giúp hay làm nhiệm vụ? Làm nhiệm vụ thì nói tên nhiệm vụ, nhờ giúp thì nói ra việc cần giúp.",{
				   {"Ta đến nhờ giúp", tbNpc.Talk, tbNpc},
				   {"Kết thúc đối thoại"},
			});
end;

function tbNpc:Talk()
		Dialog:Say("Xem ra ngươi đã gặp rắc rối, chuẩn bị xong ta sẽ đưa ngươi đi.",{
				   {"Xong rồi", tbNpc.GoNow, tbNpc},
				   {"Kết thúc đối thoại"},
			});
end;

function tbNpc:GoNow()
	local nTask	= me.GetTask(1024, 39);
	
	if nTask == 0 then
		Dialog:Say("Ngươi không có nhiệm vụ, mọi thứ rất thuận lợi!");
		return;
	end;
	
	if tbTaskValue[nTask] then
		Dialog:Say("Đi nào"..tbTaskValue[nTask][1]..", ngươi chắc muốn đi chứ?",{
				   {"Phải, mau lên nào", self.Send, self, me, tbTaskValue[nTask][2], tbTaskValue[nTask][3], tbTaskValue[nTask][4], tbTaskValue[nTask][5]},
				   {"Kết thúc đối thoại"}
			});
		return;
	end;
end;


function tbNpc:Send(pPlayer, nMapId, nMapX, nMapY, nFightState)
	pPlayer.NewWorld(nMapId, nMapX, nMapY);
	pPlayer.SetFightState(nFightState);
end;


