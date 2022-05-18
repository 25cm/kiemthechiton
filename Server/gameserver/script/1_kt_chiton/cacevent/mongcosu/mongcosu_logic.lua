if not MODULE_GAMESERVER then
	return;
end
function DaiChienQuanMongCo:ThongBaoLan1_GS()
		local nMapIndex = SubWorldID2Idx(130);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> chuẩn bị tấn công <color=blue><pos=130,1720,3457> Mông Cổ Vương Đình<color>. Các nhân sĩ mau mau tới khiêu chiến";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end

function DaiChienQuanMongCo:ThongBaoLan2_GS()
		local nMapIndex = SubWorldID2Idx(238);
	if nMapIndex < 0 then
		return;
	end
	local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 2<color> đã xuất hiện ở <color=gold>Tầng 2 - Bạch Hổ Đường_Âm [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(2684, 115, 0, 238, 1578, 3147)
	end
function DaiChienQuanMongCo:ThongBaoLan3_GS()
			local nMapIndex = SubWorldID2Idx(239);
	if nMapIndex < 0 then
		return;
	end
	local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 2<color> đã xuất hiện ở <color=gold>Tầng 2 - Bạch Hổ Đường_Dương [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(2684, 115, 0, 239, 1578, 3147)
	end
function DaiChienQuanMongCo:ThongBaoLan4_GS()
			local nMapIndex = SubWorldID2Idx(240);
	if nMapIndex < 0 then
		return;
	end
	local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 3<color> đã xuất hiện ở <color=gold>Tầng 3 - Bạch Hổ Đường [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(2688, 120, 0, 240, 1578, 3147)
	end
function DaiChienQuanMongCo:TrieuTapMember_GS()
		local nMapIndex = SubWorldID2Idx(234);
	if nMapIndex < 0 then
		return;
	end

	end
function DaiChienQuanMongCo:AddQuanLinhMC_GS()
		local nMapIndex = SubWorldID2Idx(130);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> đang tấn công tại <color=blue><pos=130,1720,3457> Mông Cổ Vương Đình<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)	
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
KNpc.Add2(30029, 50, 0, 130, 1721, 3449)
KNpc.Add2(30030, 50, 0, 130, 1729, 3457)
KNpc.Add2(30031, 50, 0, 130, 1720, 3466)
KNpc.Add2(30032, 50, 0, 130, 1712, 3457)
KNpc.Add2(30033, 50, 0, 130, 1719, 3454)
KNpc.Add2(30034, 50, 0, 130, 1723, 2460)
end
------------
function DaiChienQuanMongCo:AddMCSNhat_GS()
		local nMapIndex = SubWorldID2Idx(235);
	if nMapIndex < 0 then
		return;
	end

end
function DaiChienQuanMongCo:AddMCSNguyet_GS()
		local nMapIndex = SubWorldID2Idx(234);
	if nMapIndex < 0 then
		return;
	end
local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 1<color> đã xuất hiện ở <color=gold>Tầng 1 - Bạch Hổ Đường_Đông [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(2663, 110, 0, 234, 1578, 3146)
end
function DaiChienQuanMongCo:AddMCSPhong_GS()
		local nMapIndex = SubWorldID2Idx(235);
	if nMapIndex < 0 then
		return;
	end
local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 1<color> đã xuất hiện ở <color=gold>Tầng 1 - Bạch Hổ Đường_Nam [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(2663, 110, 0, 235, 1578, 3146)
end
-------------------------------
function DaiChienQuanMongCo:AddMCSVan_GS()
		local nMapIndex = SubWorldID2Idx(237);		
	if nMapIndex < 0 then
		return;
	end

end
function DaiChienQuanMongCo:AddMCSLoi_GS()
		local nMapIndex = SubWorldID2Idx(237);	
	if nMapIndex < 0 then
		return;
	end
local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 1<color> đã xuất hiện ở <color=gold>Tầng 1 - Bạch Hổ Đường_Bắc [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(2663, 110, 0, 237, 1578, 3146)
end
function DaiChienQuanMongCo:AddMCSDien_GS()
		local nMapIndex = SubWorldID2Idx(4);
	if nMapIndex < 0 then
		return;
	end
local msg = "Bạn đang chơi <color=gold>Kiếm Thế Chí Tôn<color> Phiên Bản 2.0 được phát triển và chia sẻ bởi Team: <color=green>ThànhBG và CôngHmc<color>. Mọi thắc mắc hãy liên hệ với <color=White>FanPage Kiếm Thế Chí Tôn<color> để được hỗ trợ";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
end