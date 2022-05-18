local tbItem = Item:GetClass("shengwanglingpai_baihutang")
local	tbShengWang = 
{
	[1] = 50,
	[2] = 100,
	[3] = 150,
}


function tbItem:OnUse()
	local nLevel = it.nLevel;
	local nUesd = me.GetTask(BaiHuTang.TSKGID, BaiHuTang.TASK_USED_NUM);
	local nWeek = me.GetTask(BaiHuTang.TSKGID, BaiHuTang.TASK_WEEK_ID)
	local nNowWeek = tonumber(GetLocalDate("%W"));
	local szSeries = Env.SERIES_NAME[me.nSeries];
	if nWeek ~= nNowWeek then
		me.SetTask(BaiHuTang.TSKGID, BaiHuTang.TASK_WEEK_ID, nNowWeek);
		nUesd = 0;
	end
	local nMuti = 100;
	local nBufLevel = me.GetSkillState(881)
	local nBufLevel_vn = me.GetSkillState(2211)	--越南声望令牌
	if nBufLevel > 0 or nBufLevel_vn > 0 then
		nMuti = nMuti * 1.5
	end

	local nFlag = Player:AddRepute(me, BaiHuTang.BAIHUTANG_REPUTE_CAMP, BaiHuTang.BAIHUTANG_REPUTE_CALSS, math.floor(tbShengWang[nLevel] * nMuti / 100));
	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("Bạn đã đạt danh vọng Bạch Hổ Đường (" .. szSeries .. ") cấp cao nhất, không thể sử dụng Lệnh Bài Bạch Hổ Đường");
		return;
	end
	
	me.Msg("Tuần này bạn đã sử dụng "..(nUesd + 1).." Lệnh bài danh vọng Bạch Hổ Đường!");
	me.SetTask(BaiHuTang.TSKGID, BaiHuTang.TASK_USED_NUM, nUesd + 1);
	return 1;
end

