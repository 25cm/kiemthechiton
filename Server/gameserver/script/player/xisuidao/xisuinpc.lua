local tbXisuidashi = Npc:GetClass("xisuidashi");

function tbXisuidashi:OnDialog()
	local tbOpt = {};
	
	local nChangeGerneIdx = Faction:GetChangeGenreIndex(me);
	if(nChangeGerneIdx >= 1)then
		local szMsg;
		if(Faction:Genre2Faction(me, nChangeGerneIdx) > 0 )then --
			szMsg = "Đổi Phụ tu môn phái";
		else
			szMsg = "Phụ tu môn phái";
		end
		table.insert(tbOpt, {szMsg, self.OnChangeGenreFaction, self, me});
	end
	
	table.insert(tbOpt, {"Tẩy điểm tiềm năng", self.OnResetDian, self, me, 1});
	table.insert(tbOpt, {"Tẩy điểm kỹ năng", self.OnResetDian, self, me, 2});
	table.insert(tbOpt, {"Tẩy điểm tiềm năng và kỹ năng", self.OnResetDian, self, me, 0});
	table.insert(tbOpt, {"Để suy nghĩ lại đã"});

	local szMsg = "Ta sẽ giúp ngươi phân phối lại điểm tiềm năng và kỹ năng. Phía sau có 1 sơn động phân phối xong có thể đến đó để thử nghiệm hiệu quả. Nếu không vừa ý thì quay lại tìm ta. Khi hài lòng thì truyền tống môn phái sẽ đưa ngươi về.";
	Dialog:Say(szMsg, tbOpt);
end

function tbXisuidashi:OnResetDian(pPlayer, nType)
	local szMsg = "";
	if (1 == nType) then
		pPlayer.SetTask(2,1,1);
		pPlayer.UnAssignPotential();
		szMsg = "Tẩy tủy thành công! Ngươi có thể phân phối lại điểm tiềm năng.";
	elseif (2 == nType) then
		pPlayer.ResetFightSkillPoint();
		szMsg = "Tẩy tủy thành công! Ngươi có thể phân phối lại điểm kỹ năng.";
	elseif (0 == nType) then
		pPlayer.ResetFightSkillPoint();
		pPlayer.SetTask(2,1,1);
		pPlayer.UnAssignPotential();
		szMsg = "Tẩy tủy thành công! Ngươi có thể phân phối lại điểm tiềm năng và kỹ năng.";
	end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

function tbXisuidashi:OnChangeGenreFaction(pPlayer)
	local tbOpt	= {};
	local nFactionGenre = Faction:GetChangeGenreIndex(pPlayer);
	for nFactionId, tbFaction in ipairs(Player.tbFactions) do
		if (Faction:CheckGenreFaction(pPlayer, nFactionGenre, nFactionId) == 1) then
			table.insert(tbOpt, {tbFaction.szName, self.OnChangeGenreFactionSelected, self, pPlayer, nFactionId});
		end
	end
	table.insert(tbOpt,{"Kết thúc đối thoại"});
	
	local szMsg = "Chọn Phụ tu môn phái.";
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbXisuidashi:OnChangeGenreFactionSelected(pPlayer, nFactionId)
	
	local nGenreId		 = Faction:GetChangeGenreIndex(pPlayer);
	local nPrevFaction   = Faction:Genre2Faction(pPlayer, nGenreId);
	local nResult, szMsg = Faction:ChangeGenreFaction(pPlayer, nGenreId, nFactionId);
	if(nResult == 1)then
		if (nPrevFaction == 0) then -- һζ
			szMsg = "Phụ tu môn phái ngươi chọn là %s, sử dụng Tu Luyện Châu có thể tiến hành đổi môn phái, đồng thời <color=yellow>Ngũ Hành Ấn và Phi Phong<color> sẽ tự động đổi sang ngũ hành tương thích với môn phái nhưng vẫn <color=yellow>giữ lại đẳng cấp và thuộc tính<color>.<enter>Sau khi đổi phụ tu môn phái, có thể tự tăng điểm, mua vũ khí thích hợp ở chỗ <color=yellow>Thương Nhân<color> và thử nghiệm hiệu quả tại sơn động.<enter>Nếu không vừa ý quay lại tìm ta đổi Phụ tu môn phái. Sau khi hài lòng đến chỗ <color=yellow>Truyền Tống Môn Phái<color> để rời đảo.<enter>Hãy cẩn thận vì sau khi rời đảo sẽ <color=yellow>không thể đổi<color> Phụ tu môn phái."
		else
			szMsg = "Phụ tu môn phái của ngươi đã đổi thành %s, sử dụng Tu Luyện Châu có thể tiến hành đổi môn phái, đồng thời <color=yellow>Ngũ Hành Ấn và Phi Phong<color> sẽ tự động đổi sang ngũ hành tương thích với môn phái nhưng vẫn <color=yellow>giữ lại đẳng cấp và thuộc tính<color>.<enter>Sau khi đổi phụ tu môn phái, có thể tự tăng điểm, mua vũ khí thích hợp ở chỗ <color=yellow>Thương Nhân<color> và thử nghiệm hiệu quả tại sơn động.<enter>Nếu không vừa ý quay lại tìm ta đổi Phụ tu môn phái. Sau khi hài lòng đến chỗ <color=yellow>Truyền Tống Môn Phái<color> để rời đảo.<enter>Hãy cẩn thận vì sau khi rời đảo sẽ <color=yellow>không thể đổi<color> Phụ tu môn phái."
		end
		szMsg = string.format(szMsg, Player.tbFactions[nFactionId].szName);
	end
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

local tbXisuimenpai = Npc:GetClass("xisuimenpaichuansongren");

function tbXisuimenpai:OnDialog()
	local nChangeGerne = Faction:GetChangeGenreIndex(me); 
	local szMsg;
	if(nChangeGerne > 0)then -- 
		szMsg = "Sau khi chọn Phụ tu môn phái, ta có thể đưa ngươi về môn phái.";
	else
		szMsg = "Sau khi tẩy điểm, ta có thể đưa ngươi về môn phái.";
	end
	
	local tbOpt = {
			{"Rời khỏi Tẩy Tủy Đảo", self.OnCheckLeave, self, me},
			{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbXisuimenpai:OnCheckLeave(pPlayer)
	local nChangeGerne = Faction:GetChangeGenreIndex(pPlayer); 
	local szMsg, tbOpt;
	if(nChangeGerne > 0)then -- 
		if(Faction:Genre2Faction(pPlayer, nChangeGerne) <= 0)then
			szMsg = "Ngươi chưa chọn Phụ tu môn phái, hãy tìm Tẩy Tủy Đại Sư để Phụ tu môn phái, xong rồi đến tìm ta.";
		elseif(pPlayer.IsAccountLock() == 1)then
			szMsg = "Tài khoản bị khóa không thể thực hiện thao tác.";
		else
			szMsg = "<enter>Hãy cẩn thận vì sau khi rời khỏi đảo <color=yellow>sẽ không thể<color> Phụ tu môn phái. Ngươi có muốn rời khỏi không?";
			tbOpt = {
					{"Rời khỏi", self.OnLeave, self, pPlayer},
					{"Để ta suy nghĩ lại"},
				};
		end	
	else
		szMsg = "Sau khi tẩy tủy xong, ta sẽ đưa ngươi về môn phái.";
		tbOpt = {
				{"Rời khỏi Tẩy Tủy Đảo", self.OnLeave, self, pPlayer},
				{"Kết thúc đối thoại"},
			};
	end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbXisuimenpai:OnLeave(pPlayer)
	local nChangeFactionIndex = Faction:GetChangeGenreIndex(pPlayer);
	local nChangedFaction;
	if (nChangeFactionIndex > 0) then -- 
		nChangedFaction = Faction:Genre2Faction(pPlayer, nChangeFactionIndex);
		Faction:WriteLog(Dbg.LOG_INFO, "tbXisuimenpai:OnLeave", pPlayer.szName, nChangeFactionIndex, nChangedFaction);
		Faction:SetChangeGenreIndex(pPlayer, 0);
	end
	
	assert(pPlayer.nFaction);
	Npc.tbMenPaiNpc:Transfer(pPlayer.nFaction);
	
	if (nChangeFactionIndex > 0) then
		pPlayer.Msg("Phụ tu môn phái:" .. Player.tbFactions[nChangedFaction].szName);
	end
end
