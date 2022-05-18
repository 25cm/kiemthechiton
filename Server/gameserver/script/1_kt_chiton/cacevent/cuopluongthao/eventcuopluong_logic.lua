if not MODULE_GAMESERVER then
	return;
end
function CuopLuong:TrieuTapGiacNgoaiXam_GS()
		local nMapIndex = SubWorldID2Idx(133);
	if nMapIndex < 0 then
		return;
	end
	GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>Xe Chở Lương Thảo<color> của Triều Đình sắp bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình sắp bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");
KDialog.MsgToGlobal("<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình sắp bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");	
end
function CuopLuong:GiacNgoaiXam1_GS()
		local nMapIndex = SubWorldID2Idx(133);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 35, 0, 133, 1709, 3467)
KNpc.Add2(30020, 35, 0, 133, 1709, 3467)
KNpc.Add2(30016, 35, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
--------------------------------------
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30016, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
---------------------------------------
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30016, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
-------------------------------
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
-------------------------------

GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");
KDialog.MsgToGlobal("<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");	
end
function CuopLuong:GiacNgoaiXam2_GS()
		local nMapIndex = SubWorldID2Idx(28);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 35, 0, 133, 1726, 3455)
KNpc.Add2(30020, 35, 0, 133, 1726, 3455)
KNpc.Add2(30016, 35, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
----------------------------------
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30016, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
---------------------------------
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30016, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
-------------------------
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
---------------------------

-----------------------------
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");
KDialog.MsgToGlobal("<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");	
end
function CuopLuong:GiacNgoaiXam3_GS()
		local nMapIndex = SubWorldID2Idx(133);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 35, 0, 133, 1714, 3488)
KNpc.Add2(30020, 35, 0, 133, 1714, 3488)
KNpc.Add2(30016, 35, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
--------------------------
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30016, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
---
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30016, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
---
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
----------------------
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");
KDialog.MsgToGlobal("<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");	
end
function CuopLuong:GiacNgoaiXam4_GS()
		local nMapIndex = SubWorldID2Idx(133);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 35, 0, 133, 1734, 3477)
KNpc.Add2(30020, 35, 0, 133, 1734, 3477)
KNpc.Add2(30016, 35, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
KNpc.Add2(30019, 50, 0, 133, 1734, 3477)
KNpc.Add2(30020, 50, 0, 133, 1734, 3477)
----
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30016, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
KNpc.Add2(30020, 50, 0, 133, 1709, 3467)
KNpc.Add2(30019, 50, 0, 133, 1709, 3467)
---
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30016, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
KNpc.Add2(30020, 50, 0, 133, 1726, 3455)
KNpc.Add2(30019, 50, 0, 133, 1726, 3455)
-------
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
KNpc.Add2(30019, 50, 0, 133, 1714, 3488)
KNpc.Add2(30020, 50, 0, 133, 1714, 3488)
------------

------

GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");
KDialog.MsgToGlobal("<color=yellow>Xe Chở Lương Thảo<color> của Triều Đình đang bị <color=blue>Sơn Tặc<color> tấn công tại <color=green><pos=133,1722,3471> Lương Sơn Bạc<color>. Các hào kiệt hãy nhanh chóng đến giải cứu");	
end

function CuopLuong:XoaLak_GS()
		local nMapIndex = SubWorldID2Idx(133);
	if nMapIndex < 0 then
		return;
	end

	end