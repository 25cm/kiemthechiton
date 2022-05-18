
local tbHoTro90 = Item:GetClass("tuiquahotrotanthu9x")
function tbHoTro90:OnUse()
if me.nLevel < 110 then
	local szMsg = "Mở ra bạn sẽ nhận được <color=yellow>Set đồ 10X +16 và Vũ Khí 10X +16 theo hệ phái<color>";
	local tbOpt = {
		{"<color=orange>Nhận<color>",self.NhanHoTro9x, self},
			};

	Dialog:Say(szMsg, tbOpt);
end
if me.nLevel >= 110 then
 local tbItemId	= {18,1,25502,1,0,0};
	Task:DelItem(me, tbItemId, 1);
 end
 end

function tbHoTro90:NhanHoTro9x()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId2 = {18,1,25502,1,0,0} -- Mảnh Ghép Huyền Vũ Ấn
if me.nFaction == 0 then
Dialog:Say("<color=yellow>Chưa gia nhập môn phái không thể mở<color>")
return 
end
if me.nRouteId == 0 then
Dialog:Say("Chưa chọn hệ phái")
return
end
	local tbInfo	= GetPlayerInfoForLadderGC(me.szName);
	if tbInfo.nSex == 0 and (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương Nam
		me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,810,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,267,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,751,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,761,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
			end
	if tbInfo.nSex == 1 and (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương Nữ
	me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,820,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,822,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,420,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,322,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,422,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,316,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,210,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,420,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,267,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,751,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,761,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,810,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,267,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,761,10,1,16);
		item10.Bind(1);
		local item10 = me.AddItem(2,1,751,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,820,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,822,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,420,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,322,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,422,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,316,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,210,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,420,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,267,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,761,10,1,16);
		item20.Bind(1);
		local item10 = me.AddItem(2,1,751,10,1,16);
		item10.Bind(1);		
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
		-------------
					if tbInfo.nSex == 0 and (me.nFaction == 1) and (me.nRouteId == 1) then -- Thiếu Lâm Đao
					me.AddLevel(110-me.nLevel);
			local item1 = me.AddItem(2,9,830,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,832,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,267,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,731,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,741,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
		if tbInfo.nSex == 0 and (me.nFaction == 1) and (me.nRouteId == 2) then -- Thiếu Lâm Bổng
		me.AddLevel(110-me.nLevel);
				local item1 = me.AddItem(2,9,810,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,267,10,1,16);
		item9.Bind(1)
		local item10 = me.AddItem(2,1,741,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,731,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
		---------------
			if tbInfo.nSex == 0 and (me.nFaction == 3) and (me.nRouteId == 2) then -- ĐMTT Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,850,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,268,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,2,100,10,1,16);
		item10.Bind(1);
				local item20 =  me.AddItem(2,2,90,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 3) and (me.nRouteId == 2)then -- ĐMTT Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,860,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,268,10,1,16);
		item19.Bind(1);
		local item20 =  me.AddItem(2,2,100,10,1,16);
		item20.Bind(1);
				local item20 =  me.AddItem(2,2,90,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 3) and (me.nRouteId == 1) then -- ĐMHT Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,850,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,268,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,2,90,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,2,100,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 3) and (me.nRouteId == 1) then -- ĐMHT Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,860,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,268,10,1,16);
		item19.Bind(1);
		local item20 =  me.AddItem(2,2,90,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,2,100,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 4) and (me.nRouteId == 1) then -- 5 Độc Đao Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,850,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,268,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,771,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,781,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1  and (me.nFaction == 4) and (me.nRouteId == 1) then -- 5 Độc Đao Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,860,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,268,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,771,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,781,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 4) and (me.nRouteId == 2) then -- 5 Độc Chưởng Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,870,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,872,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,268,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,781,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,771,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 4) and (me.nRouteId == 2) then -- 5 Độc Chưởng Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,880,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,882,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,268,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,781,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,771,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
        end
			if tbInfo.nSex == 0 and (me.nFaction == 11) and (me.nRouteId == 2) then -- MGK Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,850,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,268,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,1001,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,991,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 11) and (me.nRouteId == 2) then -- MGK Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,860,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,268,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,1001,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,991,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 11) and (me.nRouteId == 1) then -- Minh Giáo Chùy Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,850,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,268,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,991,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,1001,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 11) and (me.nRouteId == 1) then -- MGC Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,860,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,268,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,991,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,1001,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 12) and (me.nRouteId == 2) then -- ĐTK Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,910,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,269,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,801,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 12) and (me.nRouteId == 2) then -- ĐTK nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,920,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,269,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,821,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,801,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 12) and (me.nRouteId == 1) then -- ĐTC Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,890,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,892,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,269,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,801,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,821,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 12) and (me.nRouteId == 1) then -- ĐTC Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,900,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,902,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,269,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,801,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,821,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
		if (me.nFaction == 5) and (me.nRouteId == 1) then -- Nga Mi Chưởng
		me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,920,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,269,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,811,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,821,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
		if (me.nFaction == 5) and (me.nRouteId == 2) then -- Nga Mi Kiếm
		me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,920,10,1,16);
		item11.Bind(1)
		local item12 = me.AddItem(2,3,922,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,269,10,1,16);
		item19.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,811,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 6) and (me.nRouteId == 2) then -- TYD Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,910,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,269,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,791,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,821,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 6) and (me.nRouteId == 2) then -- TYD Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,920,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,269,10,1,16);
		item19.Bind(1);
		local item20 =  me.AddItem(2,1,791,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,821,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 6) and (me.nRouteId == 1) then --TYK Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,910,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,269,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,791,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 6) and (me.nRouteId == 1) then --TYK Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,920,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,269,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,821,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,791,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Rồng Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,950,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,270,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,851,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,831,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Rồng Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,960,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,270,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,851,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,831,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,950,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,270,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,831,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,851,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,960,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,270,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,831,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,851,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and  (me.nFaction == 8) and (me.nRouteId == 2) then -- Ma Nhẫn Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,950,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,270,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,861,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,841,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 8) and (me.nRouteId == 2) then -- Ma Nhẫn Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,960,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,270,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,861,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,841,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 8) and (me.nRouteId == 1) then -- Thiên Nhẫn Thương Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,930,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,932,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,270,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,841,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,861,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 8) and (me.nRouteId == 1) then -- THiên Nhẫn Kích Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,940,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,942,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,270,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,841,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,861,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,990,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,271,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,891,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,881,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,1000,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,271,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,891,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,881,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0  and  (me.nFaction == 9) and (me.nRouteId == 2) then -- Võ đang kiếm nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,970,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,972,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,271,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,881,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,891,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 9) and (me.nRouteId == 2) then
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,980,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,982,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,271,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,881,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,891,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 10) and (me.nRouteId == 2) then -- CLK Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,990,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,271,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,901,10,1,16);
		item10.Bind(1);
				local item20 = me.AddItem(2,1,871,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 10) and (me.nRouteId == 2) then -- CLK Nũ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,1000,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,271,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,901,10,1,16);
		item20.Bind(1);
				local item20 = me.AddItem(2,1,871,10,1,16);
		item20.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 0 and (me.nFaction == 10) and (me.nRouteId == 1) then -- CLĐ Nam
			me.AddLevel(110-me.nLevel);
		local item1 = me.AddItem(2,9,990,10,1,16);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,16);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,16);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,16);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,16);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,16);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,16);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,16);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,271,10,1,16);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,871,10,1,16);
		item10.Bind(1);
				local item10 = me.AddItem(2,1,901,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
			if tbInfo.nSex == 1 and (me.nFaction == 10) and (me.nRouteId == 1) then -- CLĐ Nữ
			me.AddLevel(110-me.nLevel);
		local item11 = me.AddItem(2,9,1000,10,1,16);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,16);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,16);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,16);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,16);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,16);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,16);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,16);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,271,10,1,16);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,871,10,1,16);
		item20.Bind(1);
				local item10 = me.AddItem(2,1,901,10,1,16);
		item10.Bind(1);
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
		end
Task:DelItem(me, tbItemId2, 1); -- Xóa Túi Hỗ Trợ Tân Thủ	
 end
