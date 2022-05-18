if not MODULE_GAMESERVER then
	return;
end
function RuongPhoiXuatHien:AddRuongVK_GS()
		local nMapIndex = SubWorldID2Idx(26);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Rương Bảo Kiếm<color> xuất hiện tại Dương Châu Phủ , mau tới nhặt phôi !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Rương Bảo Kiếm<<color> xuất hiện tại Dương Châu Phủ , mau tới nhặt phôi !<color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Rương Bảo Kiếm<<color> xuất hiện tại Dương Châu Phủ , mau tới nhặt !<color>");	
	KNpc.Add2(9635, 255, 0, 26, 1601, 3179)
	KNpc.Add2(9635, 255, 0, 26, 1506, 3161)
	KNpc.Add2(9635, 255, 0, 26, 1568, 3184)
	KNpc.Add2(9635, 255, 0, 26, 1540, 3176)
	KNpc.Add2(9635, 255, 0, 26, 1533, 3190)
	KNpc.Add2(9635, 255, 0, 26, 1536, 3215)
	KNpc.Add2(9635, 255, 0, 26, 1541, 3240)
	KNpc.Add2(9635, 255, 0, 26, 1521, 3261)
	KNpc.Add2(9635, 255, 0, 26, 1507, 3247)
	KNpc.Add2(9635, 255, 0, 26, 1501, 3273)
	
	end
function RuongPhoiXuatHien:AddRuongTS_GS()
		local nMapIndex = SubWorldID2Idx(29);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Rương Bảo Giáp<color> xuất hiện tại Lâm An Phủ , mau tới nhặt phôi !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Rương Bảo Giáp<<color> xuất hiện tại Lâm An Phủ , mau tới nhặt phôi !<color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Rương Bảo Giáp<<color> xuất hiện tại Lâm An Phủ , mau tới nhặt !<color>");	
	KNpc.Add2(9634, 255, 0, 29,1608, 3943)
	KNpc.Add2(9634, 255, 0, 29, 1602, 3927)
	KNpc.Add2(9634, 255, 0, 29, 1634, 3917)
	KNpc.Add2(9634, 255, 0, 29, 1598, 3882)
	KNpc.Add2(9634, 255, 0, 29, 1580, 3859)
	KNpc.Add2(9634, 255, 0, 29, 1562, 3856)
	KNpc.Add2(9634, 255, 0, 29, 1550, 3834)
	KNpc.Add2(9634, 255, 0, 29, 1521, 3812)
	KNpc.Add2(9634, 255, 0, 29, 1505, 3779)
	KNpc.Add2(9634, 255, 0, 29, 1481, 3752)
	
	end
function RuongPhoiXuatHien:AddRuongGiap_GS()
		local nMapIndex = SubWorldID2Idx(24);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Rương Trang Sức<color> xuất hiện tại Phượng Tường Phủ , mau tới nhặt phôi !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Rương Trang Sức<<color> xuất hiện tại Phượng Tường Phủ , mau tới nhặt phôi !<color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Rương Trang Sức<<color> xuất hiện tại Phượng Tường Phủ , mau tới nhặt !<color>");	
	KNpc.Add2(9626, 255, 0, 24, 1762, 3507)
	KNpc.Add2(9626, 255, 0, 24, 1768, 3495)
	KNpc.Add2(9626, 255, 0, 24, 1787, 3494)
	KNpc.Add2(9626, 255, 0, 24, 1800, 3495)
	KNpc.Add2(9626, 255, 0, 24, 1832, 3466)
	KNpc.Add2(9626, 255, 0, 24, 1820, 3485)
	KNpc.Add2(9626, 255, 0, 24, 1837, 3500)
	KNpc.Add2(9626, 255, 0, 24, 1848, 3511)
	KNpc.Add2(9626, 255, 0, 24, 1870, 3535)
	KNpc.Add2(9626, 255, 0, 24, 1866, 3558)	
	end