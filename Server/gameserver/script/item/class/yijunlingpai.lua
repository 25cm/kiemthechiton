-- 文件名　：yijunlingpai.lua
-- 创建者　：zhouchenfei
-- 创建时间：2008-03-11 20:50:21
-- modify by zhangjinpin@kingsoft

local tbYiJun	= Item:GetClass("yijunlingpai");

function tbYiJun:OnUse()

	local pPlayer 		= me;
	local nShengWang 	= 20;
	local szSeries		= Env.SERIES_NAME[pPlayer.nSeries];
	local nValue		= pPlayer.GetWeekRepute(1,1);

	-- zhengyuhua:庆公测活动临时内容
	local nBufLevel = me.GetSkillState(881)
	if nBufLevel > 0 then
		nShengWang = nShengWang * 1.5
	end
	
	local nTimes = tonumber(it.GetExtParam(1));
	if nTimes > 0 then
		nShengWang = nShengWang * nTimes;
	end
	
	local nFlag = Player:AddRepute(pPlayer, 1, 1, nShengWang);
	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		pPlayer.Msg("Danh vọng (" .. szSeries .. ") đạt cấp cao nhất, không thể sử dụng lệnh bài.");
		return;
	end
	
	return 1;	
end
