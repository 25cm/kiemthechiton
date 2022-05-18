if not MODULE_GAMESERVER then
	return;
end
function HoCauCa:AddHoCauCa_GS()
		local nMapIndex = SubWorldID2Idx(4);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=green>Sự Kiện Vớt Cá Mắc Cạn<color> vào lúc <color=gold>(16h00 - 20h00)<color> xuất hiện tại <pos=4,1616,3250> . Mau chân tới vớt cá hoàn toàn miễn phí nào các nhân sĩ"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=green>Sự Kiện Vớt Cá Mắc Cạn<color> vào lúc <color=gold>(16h00 - 20h00)<color> xuất hiện tại <pos=4,1616,3250> . Mau chân tới vớt cá hoàn toàn miễn phí nào các nhân sĩ");
	KDialog.MsgToGlobal("<color=green>Sự Kiện Vớt Cá Mắc Cạn<color> vào lúc <color=gold>(16h00 - 20h00)<color> xuất hiện tại <pos=4,1616,3250> . Mau chân tới vớt cá hoàn toàn miễn phí nào các nhân sĩ");	
KNpc.Add2(30036, 1, 0, 4, 1617, 3249)
KNpc.Add2(30036, 1, 0, 4, 1620, 3245)
KNpc.Add2(30036, 1, 0, 4, 1613, 3253)

end
function HoCauCa:XoaHoCauCa_GS()
		local nMapIndex = SubWorldID2Idx(4);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=green>Sự Kiện Vớt Cá Mắc Cạn<color> vào lúc <color=blue>(16h15 - 20h15)<color> đã kết thúc. Các nhân sĩ hãy tham gia sự kiện <color=red>Oẳn Tù Tì<color> tại <color=green>NPC Bé Thả Diều<color> vào lúc (16h15 - 20h15)"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=green>Sự Kiện Vớt Cá Mắc Cạn<color> vào lúc <color=blue>(16h15 - 20h15)<color> đã kết thúc. Các nhân sĩ hãy tham gia sự kiện <color=red>Oẳn Tù Tì<color> tại <color=green>NPC Bé Thả Diều<color> vào lúc (16h15 - 20h15)");
	KDialog.MsgToGlobal("<color=green>Sự Kiện Vớt Cá Mắc Cạn<color> vào lúc (16h15 - 20h15) đã kết thúc. Các nhân sĩ hãy tham gia sự kiện <color=gold>Oẳn Tù Tì<color> tại <color=green>NPC Bé Thả Diều<color> vào lúc (16h15 - 20h15)");	
ClearMapNpcWithName(4, "Cá Mắc Cạn");
end