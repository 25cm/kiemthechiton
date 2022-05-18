local tbNpc = Npc:GetClass("NangKinhMach");


local nItem = 100;
local TSK_ItemDel =
{

	[3]={18,1,3057,1}, 

}
local RATE = 100;

function tbNpc:OnDialog_1()
	local tbOpt = {
    		--{"<color=yellow>Nhận đồ dùng thử 10 phút (nên nhận thử trước khi đổi thật).", self.SelectWeapon, self},--
  			{"<color=yellow>Ta Muốn Đả Thông Kinh Mạch<color>", self.kiemtra, self},--
			{"Kết thúc đối thoại"},
		}
	local szMsg = "Mỗi lần nâng cấp tiêu tốn: <color=yellow>40 Chân Khí Hoàn<color>. <color=red>Lưu ý:<color> Cấp Kinh Mạnh càng cao tỉ lệ thành công càng thấp";

	Dialog:Say(szMsg, tbOpt);
end;

function tbNpc:kiemtra()
	local nCoin = me.GetJbCoin()

	local nCountTSD = me.GetItemCountInBags(unpack(TSK_ItemDel[3]));
	if(nCountTSD < 40) then
		Dialog:Say(string.format("Bạn chưa đủ <color=yellow>40 Chân Khí Hoàn<color>"));
		return 0;
	end

		local tbOpt= {
			{"<color=yellow>Tăng Tấn Công Cơ Bản<color> (+ Phát huy lực TCCB %) ",self.chuthien,self},
			{"<color=yellow>Tăng Sát Thương Chí Mạng<color>( + Tấn công khi đánh CM %) ",self.xungmach,self},
			{"<color=yellow>Giảm Sát Thương Chí Mạng<color> (- Chịu sát thương CM %) ",self.doimach,self},
			--{"<color=blue>Dương Khiêu Mạch <color>(+Vật công nội %) ",self.duongkhieumach,self},
			--{"<color=blue>Âm Khiêu Mạch <color>(+Vật công ngoại %) ",self.amkhieumach,self},
			--{"<color=blue>Dương Duy Mạch <color>(+Vật công nội điểm) ",self.duongduymach,self},
			--{"<color=blue>Âm Duy Mạch <color>(+Vật công ngoại điểm) ",self.amduymach,self},
			--{"<color=blue>Khí Hải <color>(+Ngoại công điểm) ",self.khihai,self},
			--{"<color=blue>Mệnh Môn <color>(+Nội công điểm) ",self.menhmon,self},
			--{"<color=blue>Thiện Trung <color>(+Sức mạnh điểm) ",self.thientrung,self},
			--{"<color=blue>Ấn Đường <color>(+Thân pháp điểm) ",self.anduong,self},			
			--{"<color=blue>Nhâm Mạch <color>(+Sinh lực điểm)",self.nhammach,self},
			{"<color=blue>Kháng Tất Cả<color> (+ Kháng tất cả điểm) ",self.tammach,self},
			{"<color=blue>Tăng Sinh Lực<color> (+ Tỷ lệ sinh lực %) ",self.docmach,self},
			{"<color=blue>Tăng Phục Hồi Sinh Lực<color> (+ Hiệu xuất phục hồi SL %) ",self.quannguyen,self},
			{"Kết thúc đối thoại."},
		}
	local szMsg = "Hãy chọn mạch mà bạn muốn đả thông";
		Dialog:Say(szMsg, tbOpt);
end;


-- function tbNpc:OnDialog_2(nType)
-- 	-- local tbOpt= {
-- 	-- 		{"<color=yellow>Nhâm Mạch ",self.nhammach,self},
-- 	-- 		{"<color=yellow>Tâm Mạch ",self.tammach,self},
-- 	-- 		{"<color=yellow>Dương Duy Mạch ",self.duongduymach,self},
-- 	-- 		{"<color=yellow>Âm Duy Mạch ",self.amduymach,self},
-- 	-- 		{"<color=yellow>Đốc Mạch ",self.docmach,self},
-- 	-- 		{"<color=yellow>Quan Nguyên ",self.quannguyen,self},
-- 	-- 		{"<color=yellow>Xung Mạch ",self.xungmach,self},
-- 	-- 		{"<color=yellow>Khí Hải ",self.khihai,self},
-- 	-- 		{"<color=yellow>Mệnh Môn ",self.menhmon,self},
-- 	-- 		{"<color=yellow>Thiện Trung ",self.thientrung,self},
-- 	-- 		{"<color=yellow>Ấn Đường ",self.anduong,self},
-- 	-- 		{"<color=yellow>Dương Khiêu Mạch ",self.duongkhieumach,self},
-- 	-- 		{"<color=yellow>Âm Khiêu Mạch ",self.amkhieumach,self},
-- 	-- 		{"<color=yellow>Đới Mạch ",self.doimach,self},
-- 	-- 		{"<color=yellow>Chu Thiền ",self.chuthien,self},
-- 	-- 		{"Kết thúc đối thoại."},
-- 	-- 	}
-- 		local szMsg = "Hãy chọn mạch mà bạn muốn đả thông";
-- 		Dialog:Say(szMsg, tbOpt);
-- end

function tbNpc:nhammach(nType)
	local nLevel = me.GetSkillLevel(1706);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1706, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Nhâm Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Nhâm Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Nhâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Nhâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1706, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Nhâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Nhâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:tammach(nType)
	local nLevel = me.GetSkillLevel(1707);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1707, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Tâm Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Tâm Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Tâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Tâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1707, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Tâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Tâm Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:duongduymach(nType)
	local nLevel = me.GetSkillLevel(1692);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1692, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Dương Duy Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Dương Duy Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Dương Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Dương Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1692, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Dương Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Dương Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end


function tbNpc:amduymach(nType)
	local nLevel = me.GetSkillLevel(1693);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1693, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Âm Duy Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Âm Duy Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Âm Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Âm Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1693, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Âm Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Âm Duy Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:docmach(nType)
	local nLevel = me.GetSkillLevel(1694);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1694, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Đốc Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Đốc Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Đốc Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Đốc Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1694, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Đốc Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Đốc Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:quannguyen(nType)
	local nLevel = me.GetSkillLevel(1695);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1695, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Quan Nguyên Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Quan Nguyên Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Quan Nguyên Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Quan Nguyên Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1695, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Quan Nguyên Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Quan Nguyên Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:xungmach(nType)
	local nLevel = me.GetSkillLevel(1696);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1696, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Xung Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Xung Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Xung Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Xung Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1696, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Xung Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Xung Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:khihai(nType)
	local nLevel = me.GetSkillLevel(1697);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1697, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Khí Hải Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Khí Hải Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Khí Hải Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Khí Hải Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1697, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Khí Hải Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Khí Hải Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:menhmon(nType)
	local nLevel = me.GetSkillLevel(1698);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1698, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Mệnh Môn Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Mệnh Môn Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Mệnh Môn Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Mệnh Môn Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1698, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Mệnh Môn Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Mệnh Môn Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:thientrung(nType)
	local nLevel = me.GetSkillLevel(1699);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1699, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Thiện Trung Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Thiện Trung Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Thiện Trung Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Thiện Trung Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1699, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Thiện Trung Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Thiện Trung Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:anduong(nType)
	local nLevel = me.GetSkillLevel(1700);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1700, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Ấn Đường Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Ấn Đường Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Ấn Đường Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Ấn Đường Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1700, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Ấn Đường Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Ấn Đường Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:duongkhieumach(nType)
	local nLevel = me.GetSkillLevel(1701);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1701, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Dương Khiêu Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Dương Khiêu Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Dương Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Dương Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1701, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Dương Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Dương Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:amkhieumach(nType)
	local nLevel = me.GetSkillLevel(1702);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1702, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Âm Khiêu Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Âm Khiêu Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Âm Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Âm Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1702, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Âm Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Âm Khiêu Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:doimach(nType)
	local nLevel = me.GetSkillLevel(1703);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1703, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Đới Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Đới Mạch Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Đới Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Đới Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1703, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Đới Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Đới Mạch Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end

function tbNpc:chuthien(nType)
	local nLevel = me.GetSkillLevel(1704);

	if nLevel < 1 then
		self:DelVatPham(nType, nIndex);
		me.AddFightSkill(1704, 1);
	local szMsg3 = "Bạn đã đả thông Thành Công <color=green>Chu Thiền Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=blue>"..me.szName.."<color> đã đả thông Thành Công <color=green>Chu Thiền Cấp 1.<color> với tỉ lệ là : <color=green>100% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		return 0;
	end
	if nLevel == 10 then
		local szMsg = "Dòng kinh mạch này đã đạt cấp độ cao nhất";
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	local nRand = 0;
	local nIndex = 0;
	-- random
		nRand = MathRandom(1, 100); -- 20
			if nRand <= (100-(nLevel*10)) then
				nIndex = 2;-- trung doc dac
			else
				nIndex = 1;-- truot
			end

	if  nLevel > 0 and nLevel < 10 and nIndex == 2 then
		self:DelVatPham(nType, nIndex);
		
		local szMsg3 = "Bạn đã đả thông <color=red>Thành Công<color> <color=green>Chu Thiền Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thành Công<color> <color=green>Chu Thiền Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
		me.AddFightSkill(1704, nLevel + 1);
		self:AddSkilKyBinh(nType, nIndex);
	elseif nLevel > 0 and nLevel< 10 and nIndex == 1 then
		self:DelVatPham(nType, nIndex);
		local szMsg3 = "Bạn đã đả thông <color=red>Thất Bại<color> <color=green>Chu Thiền Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		me.Msg(szMsg3);
		Dialog:Say(szMsg3);

		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã đả thông <color=red>Thất Bại<color> <color=green>Chu Thiền Cấp "..(nLevel+1)..".<color> với tỉ lệ là : <color=green>".. (100-(nLevel*10)) .."% <color>";
		KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
		KDialog.MsgToGlobal(szMsg);
	end

end






function tbNpc:DelVatPham(nType, nIndex)
		me.ConsumeItemInBags(40, 18, 1, 3057, 1);
end

function tbNpc:AddSkilKyBinh(nType, nIndex)
		local Skill1 = me.GetSkillLevel(1692);
		local Skill2 = me.GetSkillLevel(1693);
		local Skill3 = me.GetSkillLevel(1694);
		local Skill4 = me.GetSkillLevel(1695);
		local Skill5 = me.GetSkillLevel(1696);
		local Skill6 = me.GetSkillLevel(1697);
		local Skill7 = me.GetSkillLevel(1698);
		local Skill8 = me.GetSkillLevel(1699);
		local Skill9 = me.GetSkillLevel(1700);
		local Skill10 = me.GetSkillLevel(1701);
		local Skill11 = me.GetSkillLevel(1702);
		local Skill12 = me.GetSkillLevel(1703);
		local Skill13 = me.GetSkillLevel(1704);
		local Skill14 = me.GetSkillLevel(1707);
		local Skill15 = me.GetSkillLevel(1706);
		local dem = 0;
		if Skill1 == 10 then 
			dem = dem + 1;
		end
		if Skill2 == 10 then
			dem = dem + 1;
		end
		if Skill3 == 10 then
			dem = dem + 1;
		end
		if Skill4 == 10 then
			dem = dem + 1;
		end
		if Skill5 == 10 then
			dem = dem + 1;
		end
		if Skill6 == 10 then
			dem = dem + 1;
		end
		if Skill7 == 10 then
			dem = dem + 1;
		end
		if Skill8 == 10 then
			dem = dem + 1;
		end
		if Skill9 == 10 then
			dem = dem + 1;
		end
		if Skill10 == 10 then
			dem = dem + 1;
		end
		if Skill11 == 10 then
			dem = dem + 1;
		end
		if Skill12 == 10 then
			dem = dem + 1;
		end
		if Skill13 == 10 then
			dem = dem + 1;
		end
		if Skill14 == 10 then
			dem = dem + 1;
		end
		if Skill15 == 10 then
			dem = dem + 1;
		end
		
		if dem == 2 then 
			me.AddFightSkill(1705, 1);
		return 0;
		end

		if dem > 2 then 
			me.AddFightSkill(1705, dem-1 );
		return 0;
		end
end

