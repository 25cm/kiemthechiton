local tbNpc = Npc:GetClass("NangTienMa");

function tbNpc:OnDialog_1()
	local tbOpt= {
			{"<color=yellow>Nâng cấp Kỷ Năng <color><color=green>Tiên Giới<color>",self.upgradeTien,self},
			{"<color=yellow>Nâng cấp Kỷ Năng <color><color=red>Ma Đạo<color>",self.upgradeMa,self},
			{"Kết thúc đối thoại."},
		}
		local szMsg = "Hãy chọn hoạt động mà bạn muốn tham gia";
		Dialog:Say(szMsg, tbOpt);
end


function tbNpc:upgradeTien(nType)
	local nLevel = me.GetSkillLevel(1443);
	local nCount1 = me.GetItemCountInBags(18,1,3057,1);
	local nCount2 = me.GetItemCountInBags(18,1,3024,1);

	if nLevel < 1 then
		Dialog:Say("Bạn Chưa Vào <color=green>Tiên Giới<color>");
		return 0;
	end

	if nLevel == 10 then
		Dialog:Say("Bạn Nâng Cấp Max <color=green>Kỷ Năng Tiên Giới<color>");
		return 0;
	end

	if nLevel < 5 and (nCount1 < 500) or (nCount2 < 50) then
		Dialog:Say("Bạn Cần chuẩn bị trong hành trang <color=green>\n500 Chân Khí Hoàn \n50 Tiền Xu<color>");
		return 0;
	end

	if nLevel >= 5 and (nCount1 < 1000) or (nCount2 < 50) then
		Dialog:Say("Bạn Cần chuẩn bị trong hành trang <color=green>\n1000 Chân Khí Hoàn \n50 Tiền Xu<color>");
		return 0;
	end

	if nLevel < 5 and nCount1 > 499 and nCount2 > 49 then
		me.ConsumeItemInBags(500, 18, 1, 3057, 1); -- Chân khí hoàn
		me.ConsumeItemInBags(50, 18, 1, 3024, 1); -- Tiền Xu

		me.AddFightSkill(1443,nLevel + 1);
		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã nâng cấp thành công <color=green> Kỷ Năng Tiên Giới Cấp " ..(nLevel + 1).."<color>";
			KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg)
			KDialog.MsgToGlobal(szMsg);
		--me.ConsumeItemInBags(VatPhamCanThiet[x][i], 18,1,190,1);
	end

	if nLevel >= 5 and nCount1 > 999 and nCount2 > 49 then
		me.ConsumeItemInBags(1000, 18, 1, 3057, 1); -- Chân khí hoàn
		me.ConsumeItemInBags(50, 18, 1, 3024, 1); -- Tiền Xu

		me.AddFightSkill(1443,nLevel + 1);
		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã nâng cấp thành công <color=green> Kỷ Năng Tiên Giới Cấp " ..(nLevel + 1).."<color>";
			KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg)
			KDialog.MsgToGlobal(szMsg);
		--me.ConsumeItemInBags(VatPhamCanThiet[x][i], 18,1,190,1);
	end

end;


function tbNpc:upgradeMa(nType)
	local nLevel = me.GetSkillLevel(1444);
	local nCount1 = me.GetItemCountInBags(18,1,3057,1);
	local nCount2 = me.GetItemCountInBags(18,1,3024,1);

	if nLevel < 1 then
		Dialog:Say("Bạn Chưa Vào <color=green>Ma Đạo<color>");
		return 0;
	end

	if nLevel == 10 then
		Dialog:Say("Bạn Nâng Cấp Max <color=green>Kỷ Năng Ma Đạo<color>");
		return 0;
	end

	if nLevel < 5 and (nCount1 < 500) or (nCount2 < 50) then
		Dialog:Say("Bạn Cần chuẩn bị trong hành trang <color=green>\n500 Chân Khí Hoàn \n50 Tiền Xu<color>");
		return 0;
	end

	if nLevel >= 5 and (nCount1 < 1000) or (nCount2 < 50) then
		Dialog:Say("Bạn Cần chuẩn bị trong hành trang <color=green>\n1000 Chân Khí Hoàn \n50 Tiền Xu<color>");
		return 0;
	end

	if nLevel < 5 and nCount1 > 499 and nCount2 > 49 then
		me.ConsumeItemInBags(500, 18, 1, 3057, 1); -- Chân khí hoàn
		me.ConsumeItemInBags(50, 18, 1, 3024, 1); -- Tiền Xu

		me.AddFightSkill(1444,nLevel + 1);
		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã nâng cấp thành công <color=green> Kỷ Năng Ma Đạo Cấp " ..(nLevel + 1).."<color>";
			KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg)
			KDialog.MsgToGlobal(szMsg);
		--me.ConsumeItemInBags(VatPhamCanThiet[x][i], 18,1,190,1);
	end

	if nLevel >= 5 and nCount1 > 999 and nCount2 > 49 then
		me.ConsumeItemInBags(1000, 18, 1, 3057, 1); -- Chân khí hoàn
		me.ConsumeItemInBags(50, 18, 1, 3024, 1); -- Tiền Xu

		me.AddFightSkill(1444,nLevel + 1);
		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã nâng cấp thành công <color=green> Kỷ Năng Ma Đạo Cấp " ..(nLevel + 1).."<color>";
			KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg)
			KDialog.MsgToGlobal(szMsg);
		--me.ConsumeItemInBags(VatPhamCanThiet[x][i], 18,1,190,1);
	end

end;

local tbNpc = Npc:GetClass("DoiTienMa");

function tbNpc:OnDialog_1()
	local tbOpt= {
			{"<color=yellow>Từ <color><color=green>Tiên Giới<color> Vào <color=green>Ma Đạo<color>",self.Tutiensangma,self},
			{"<color=yellow>Từ <color><color=green>Ma Đạo<color> Vào <color=green>Tiên Giới<color>",self.Tumasangtien,self},
			{"Kết thúc đối thoại."},
		}
		local szMsg = "Mỗi Lần Đổi Cần <color=pink>200 Tiền xu và 2000 Chân Khí Đơn<color>";
		Dialog:Say(szMsg, tbOpt);
end

function tbNpc:Tutiensangma()
	local nLevelT = me.GetSkillLevel(1443);
	local nCount1 = me.GetItemCountInBags(18,1,3057,1);
	local nCount2 = me.GetItemCountInBags(18,1,3024,1);
	if nLevelT < 1 then
		Dialog:Say("Bạn Không Thuộc <color=green>Tiên Giới<color>");
		return 0;
	end

	if nLevelT > 0 and nCount1 < 2000 or nCount2 < 200 then
		Dialog:Say("Bạn Còn Thiếu <color=green>\n"..(2000-nCount1).." Chân Khí Hoàn \n"..(200-nCount2).." Tiền Xu<color>");
		return 0;
	end

	if nLevelT > 0 and nCount1 > 1999 and nCount2 > 199 then
		me.DelFightSkill(1443);
		me.ConsumeItemInBags(200, 18, 1, 3024, 1);
		me.ConsumeItemInBags(2000,	18,	1,	3057,	1);
		me.AddFightSkill(1444,nLevelT);
		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã rời <color=green> Tiên Giới<color> Gia Nhập <color=red> Ma Đạo <color>";
			KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg)
			KDialog.MsgToGlobal(szMsg);
	end
end

function tbNpc:Tumasangtien()
	local nLevelT = me.GetSkillLevel(1444);
	local nCount1 = me.GetItemCountInBags(18,1,3057,1);
	local nCount2 = me.GetItemCountInBags(18,1,3024,1);
	if nLevelT < 1 then
		Dialog:Say("Bạn Không Thuộc <color=red>Ma Đạo<color>");
		return 0;
	end

	if nLevelT > 0 and nCount1 < 2000 or nCount2 < 200 then
		Dialog:Say("Bạn Còn Thiếu <color=green>\n"..(2000-nCount1).." Chân Khí Hoàn \n"..(200-nCount2).." Tiền Xu<color>");
		return 0;
	end

	if nLevelT > 0 and nCount1 > 1999 and nCount2 > 199 then
		me.DelFightSkill(1444);
		me.ConsumeItemInBags(200, 18, 1, 3024, 1);
		me.ConsumeItemInBags(2000,	18,	1,	3057,	1);
		me.AddFightSkill(1443,nLevelT);
		local szMsg = "Người chơi <color=pink>"..me.szName.."<color> đã rời <color=red> Ma Đạo <color> Gia Nhập <color=green> Tiên Giới<color>";
			KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg)
			KDialog.MsgToGlobal(szMsg);
	end
end



