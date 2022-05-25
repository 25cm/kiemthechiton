Require("\\script\\event\\collectcard\\define.lua")

local tbItem = Item:GetClass("guoqing_shoucang");
local CollectCard = SpecialEvent.CollectCard;

function tbItem:GetTip(nState)
	local nEnter = 0;
	local szTipTemp = "";
	local nCollect = 0;
	for _, tbTask in pairs(CollectCard.TASK_CARD_ID) do
		local n = 10 - string.len(tbTask[2]);
		local szBlank = "";
		for i=1, n do
			szBlank = szBlank .. " ";
		end
		if me.GetTask(CollectCard.TASK_GROUP_ID, tbTask[1]) == 1 then
			szTipTemp = szTipTemp .. string.format("<color=yellow>%s<color>%s",tbTask[2],szBlank);
			nCollect = nCollect + 1;
		else
			szTipTemp = szTipTemp .. string.format("<color=gray>%s<color>%s",tbTask[2],szBlank);
		end
		nEnter = nEnter + 1;
		if math.mod(nEnter, 4) == 0 then
			szTipTemp = szTipTemp .. "";
		end
		
	end
	local nAwarId, szDesc, nCollect, nOpenMaxCard = CollectCard:GetAward_CardBag_InFor();
	local szLuckyCard = "Tạm thời không";
	local nLuckyId = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_COLLECTCARD_RANDOM);
	if CollectCard.TASK_CARD_ID[nLuckyId] then
		szLuckyCard = CollectCard.TASK_CARD_ID[nLuckyId][2];
	end
	
	local szTip = string.format("Thẻ may mắn trong ngày: <color=gold>%s<color><enter>Đã giám định: %s thẻ<enter>Đã thu thập (%s/56): <enter>%s", 
		szLuckyCard, nOpenMaxCard, nCollect, szTipTemp);

	return szTip;
end

function tbItem:OnUse()
	return 0;
end

