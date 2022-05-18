--武林联赛令牌
--孙多良
--2008.10.14

local tbItem = Item:GetClass("wlls_token");
tbItem.tbAward = 
{
	[1] = 200,
	[2] = 400,
	[3] = 600,
	[4] = 1000,
}

function tbItem:OnUse()	
	local nFlag = Player:AddRepute(me, 7, 1, self.tbAward[it.nLevel]);

	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("您已经达到武林联赛声望最高等级，将无法使用武林联赛声望令牌");
		return;
	end	

	me.Msg(string.format("您获得<color=yellow>%s点<color>联赛声望.",self.tbAward[it.nLevel]))
	return 1;
end


