-- 文件名　：lingpaibaoxiang.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-04-29 17:26:12
-- 描  述  ：

SpecialEvent.LaborDay = SpecialEvent.LaborDay or {};
local LaborDay = SpecialEvent.LaborDay or {};

local tbItem = Item:GetClass("lingpaibaoxiang");
function tbItem:OnUse()	
	local nTime = tonumber(GetLocalDate("%H%M"));
	if nTime >= 1900 and nTime <= 2100 then
		local tbPlayerList = KPlayer:GetAllPlayer();
		for _,pPlayer in pairs(tbPlayerList) do
			pPlayer.AddExp(1000000);
		end
		KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL,string.format( "祝贺【%s】已经打开令牌宝箱并获得奖励【全服的所有玩家同时获得1百万经验值】", me.szName));
	end
	return Item:GetClass("randomitem"):SureOnUse(LaborDay.nLingpaibaoxiang);
end
