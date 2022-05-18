local tbcua_bhd123 = Npc:GetClass("cua_bhd123");
function tbcua_bhd123:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}
local nNowMinute = tonumber(GetLocalDate("%M"));
			if (nNowMinute >= 5) then
			local nMapId = me.GetWorldPos();
			if (nMapId == 234) or (nMapId == 235) then
	table.insert(tbOpt, 1, {"<pic=135>Lên <color=green>Bạch Hổ Đường Tầng 2<color>", self.bhd1, self});
	end
			if (nMapId == 236) or (nMapId == 237) then
	table.insert(tbOpt, 2, {"<pic=135>Lên <color=green>Bạch Hổ Đường Tầng 2<color>", self.bhd2, self});
	end
	else
Dialog:Say("Sau phút thứ: 5 mới vào được <color=yellow>Bạch Hổ Đường Tầng 2<color>")		
	end
			if (nNowMinute >= 12) then
			local nMapId = me.GetWorldPos();
			if (nMapId == 236) or (nMapId == 237) then
	table.insert(tbOpt, 3, {"<pic=135>Lên <color=green>Bạch Hổ Đường Tầng 3<color>", self.bhd3, self});
	end
	else
Dialog:Say("Sau phút thứ: 12 mới vào được <color=yellow>Bạch Hổ Đường Tầng 3<color>")	
	end
			if (nNowMinute >= 30 and nNowMinute <= 59) then
Dialog:Say("Bạch Hổ Đường chưa mở!<color>")
	--return 0;	
	end
end;

function tbcua_bhd123:bhd1()
me.NewWorld(238,1565,3161);
end;
function tbcua_bhd123:bhd2()
me.NewWorld(239,1565,3161);
end;
function tbcua_bhd123:bhd3()
me.NewWorld(240,1565,3161);
end;
