
-- ====================== 文件信息 ======================

-- 千琼宫副本 ITEM 脚本
-- Edited by peres
-- 2008/08/07 PM 02:30

-- 她的眼泪轻轻地掉落下来
-- 抚摸着自己的肩头，寂寥的眼神
-- 是，褪掉繁华和名利带给的空洞安慰，她只是一个一无所有的女子
-- 不爱任何人，亦不相信有人会爱她

-- ======================================================

local tbItem_Plate	= Item:GetClass("damogucheng_plate");	-- 令牌

function tbItem_Plate:OnUse()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	
	if nMapId ~= 94 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn phải đến <color><color=yellow>[Map 65] Cư Diên Trạch<color><color=red> mới mở được phó bản!<color>");
		return;
	end;
	if (me.nTeamId == 0) then
		me.Msg("Tổ đội mới mở được cửa mật chỉ Đại Mạc Cổ Thành!");
		return;
	end

	Dialog:Say("Bạn có muốn vào phó bản Đại Mạc Cổ Thành?<enter><enter><color=yellow>Kiến nghị tổ đội 6 người đạt cấp 75 hoặc cao hơn<color>.", {
			  {"Có",		self.OpenInstancing, self, me, it},
			  {"Chờ đã"},
			});

end;


function tbItem_Plate:OpenInstancing(pPlayer, pItem)
	
	if not pPlayer or not pItem then
		return;
	end;
	
	-- 临时写法
	--if (pPlayer.GetTask(2066, 272)>=6) then
		--Dialog:SendInfoBoardMsg(me, "Một tuần chỉ có thể vào phó bản <color=yellow>6<color> lần!");
		--return;
	--end;
	
	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Tổ đội mới mở được cửa mật chỉ Đại Mạc Cổ Thành!");
		return;
	end

	if pPlayer.GetItemCountInBags(18, 1, 2002, 1) < 1 then
		return;
	end;
	
	pItem.Delete(me);
	TreasureMap:AddInstancing(pPlayer, 34);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã mở được cửa mật chỉ Đại Mạc Cổ Thành!<color>");
end;