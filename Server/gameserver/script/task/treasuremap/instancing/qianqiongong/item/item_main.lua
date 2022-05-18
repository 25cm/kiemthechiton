
-- ====================== 文件信息 ======================

-- 千琼宫副本 ITEM 脚本
-- Edited by peres
-- 2008/08/07 PM 02:30

-- 她的眼泪轻轻地掉落下来
-- 抚摸着自己的肩头，寂寥的眼神
-- 是，褪掉繁华和名利带给的空洞安慰，她只是一个一无所有的女子
-- 不爱任何人，亦不相信有人会爱她

-- ======================================================

local tbItem_Chip 	= Item:GetClass("purepalace_chip");		-- 碎片
local tbItem_Plate	= Item:GetClass("purepalace_plate");	-- 令牌

local CHIP_NUM		= 5;	-- 合成一张令牌需要的碎片

function tbItem_Chip:OnUse()
	local nChips		= me.GetItemCountInBags(18, 1, 185, 1);
	
	if nChips < CHIP_NUM then
		Dialog:SendInfoBoardMsg(me, "<color=red>Phải có <color><color=yellow>"..CHIP_NUM.." mảnh Lệnh bài Thiên Quỳnh Cung<color><color=red> mới hợp thành được Lệnh bài Thiên Quỳnh Cung!<color>");
		return;
	else
		me.ConsumeItemInBags(CHIP_NUM, 18, 1, 185, 1);
		me.AddItem(18, 1, 186, 1);
		me.Msg("Bạn nhận được 1 <color=yellow>Lệnh bài Thiên Quỳnh Cung<color>!");
	end;
end;


function tbItem_Plate:OnUse()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	
	if nMapId ~= 39 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn phải đến <color><color=yellow>[Map 15] Kỳ Liên Sơn<color><color=red> mới mở được cửa mật chỉ Thiên Quỳnh Cung!<color>");
		return;
	end;

	if (me.nTeamId == 0) then
		me.Msg("Tổ đội mới mở được cửa mật chỉ Thiên Quỳnh Cung!");
		return;
	end

	Dialog:Say("Bạn có muốn vào phó bản Thiên Quỳnh Cung?<enter><enter><color=yellow>Kiến nghị tổ đội 6 người đạt cấp 85 hoặc cao hơn<color>.", {
			  {"Có",		self.OpenInstancing, self, me, it},
			  {"Chờ đã"},
			});

end;


function tbItem_Plate:OpenInstancing(pPlayer, pItem)
	
	if not pPlayer or not pItem then
		return;
	end;
	
	-- 临时写法
	--if (pPlayer.GetTask(2066, 287)>=6) then
		--Dialog:SendInfoBoardMsg(me, "Một tuần chỉ có thể vào phó bản <color=yellow>6<color> lần!");
		--return;
	--end;
	
	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Tổ đội mới mở được cửa mật chỉ Thiên Quỳnh Cung!");
		return;
	end

	if pPlayer.GetItemCountInBags(18, 1, 186, 1) < 1 then
		return;
	end;
	
--	pPlayer.ConsumeItemInBags(1, 18, 1, 186, 1);
	pItem.Delete(me);
	TreasureMap:AddInstancing(pPlayer, 43);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã mở được cửa mật chỉ Thiên Quỳnh Cung!<color>");
end;