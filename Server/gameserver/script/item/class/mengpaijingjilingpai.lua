
local tbLingPai = Item:GetClass("mengpaijingjilingpai");
tbLingPai.ADD_SHENGWANG = {30, 60, 100}	-- 令牌等级对应增加的门派声望
tbLingPai.USED_LIMIT	= 5;

function tbLingPai:OnUse()
	local nLevel = it.nLevel;
	if (nLevel < 1 or nLevel > 3) then
		return 0;
	end
	if (me.nFaction == 0) then
		me.Msg("Chưa nhập môn phái!");
		return 0;
	end
	local szFactionName = Player:GetFactionRouteName(me.nFaction);
	local nUesd = me.GetTask(FactionBattle.TASK_GROUP_ID, FactionBattle.TASK_USED_LINGPAI);
	local nTime = me.GetTask(FactionBattle.TASK_GROUP_ID, FactionBattle.TASK_LINGPAI_DATE)
	local nNowDate = tonumber(GetLocalDate("%y%m%d"));
	if nTime ~= nNowDate then
		me.SetTask(FactionBattle.TASK_GROUP_ID, FactionBattle.TASK_LINGPAI_DATE, nNowDate);
		nUesd = 0;
	end
	local nMuti = 100;
	local nBufLevel = me.GetSkillState(881)
	local nBufLevel_vn = me.GetSkillState(2211)	--越南声望令牌
	if nBufLevel > 0 or nBufLevel_vn > 0 then
		nMuti = nMuti * 1.5
	end
	
	local nFlag = Player:AddRepute(me, Player.CAMP_FACTION, me.nFaction, math.floor(self.ADD_SHENGWANG[nLevel] * nMuti / 100));
	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("Đã đạt đến" .. szFactionName .. " đẳng cấp cao nhất Danh Vọng môn phái, không thể dùng Lệnh Bài Thi Đấu Môn Phái");
		return;
	end

	me.Msg("Hôm nay đã dùng "..(nUesd + 1).." Lệnh Bài Thi Đấu Môn Phái!");
	me.SetTask(FactionBattle.TASK_GROUP_ID, FactionBattle.TASK_USED_LINGPAI, nUesd + 1);
	return 1;
end
