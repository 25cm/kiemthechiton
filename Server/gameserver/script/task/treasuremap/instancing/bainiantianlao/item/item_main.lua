

local tbItem_Plate	= Item:GetClass("qianqiongong_plate");	-- 令牌


function tbItem_Plate:OnUse()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	
	if nMapId ~= 31 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn phải đến <color><color=yellow>[Map 5] Quán Trọ Long Môn<color><color=red> mới mở được cửa mật chỉ Đào Chu Công Nghi Chủng!<color>");
		return;
	end;
	if (me.nTeamId == 0) then
		me.Msg("Tổ đội mới mở được cửa mật chỉ Bách Niên Thiên Lao!");
		return;
	end

	Dialog:Say("Bạn có muốn vào phó bản Bách Niên Thiên Lao?<enter><enter><color=yellow>Kiến nghị tổ đội 6 người đạt cấp 85 hoặc cao hơn<color>.", {
			  {"Có",		self.OpenInstancing, self, me, it},
			  {"Chờ đã"},
			});

end;


function tbItem_Plate:OpenInstancing(pPlayer, pItem)
	
	if not pPlayer or not pItem then
		return;
	end;
	
	-- 临时写法
	--if (pPlayer.GetTask(2066, 253)>=6) then
		--Dialog:SendInfoBoardMsg(me, "Một tuần chỉ có thể vào phó bản <color=yellow>6<color> lần!");
		--return;
	--end;
	
	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Tổ đội mới mở được cửa mật chỉ Bách Niên Thiên Lao!");
		return;
	end

	if pPlayer.GetItemCountInBags(18, 1, 2000, 1) < 1 then
		return;
	end;

	pItem.Delete(me);
	TreasureMap:AddInstancing(pPlayer, 10);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã mở được cửa mật chỉ Bách Niên Thiên Lao!<color>");
end;