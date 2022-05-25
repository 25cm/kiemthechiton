
if not SpecialEvent.CollectCard then
	SpecialEvent.CollectCard = {};
end
local CollectCard = SpecialEvent.CollectCard;
CollectCard.TIME_STATE	=
{
	20120410000000,	--卡片收集开启
	20120502000000,	--卡片收集结束，卡册兑换奖励开始,
	20120507000000,	--卡册兑换奖励结束，火炬评选开始,

--	20090921000000,	--卡片收集开启
--	20091011000000,	--卡片收集结束，卡册兑换奖励开始,
--	20091018000000,	--卡册兑换奖励结束，火炬评选开始,

--	20080831220000,	--火炬评选结束,领取火炬奖励开始
--	20080914240000,	--领取火炬奖励结束
}

CollectCard.CARD_BAG = {18,1,461,1}; --卡册
CollectCard.ITEM_CARD_ORG = {18,1,402,1}; --盛夏活动卡（未鉴定）
CollectCard.TASK_GROUP_ID = 2069;

CollectCard.TASK_COUNT_ID	= 1;	--民族大团圆卡（未鉴定）每天使用数量
CollectCard.TASK_DATE_ID	= 2;	--民族大团圆卡（未鉴定）天
CollectCard.TASK_COLLECT_COUNT	= 3;	--民族大团圆卡（未鉴定）已开数量
CollectCard.TASK_COLLECT_FINISH	= 4;	--收集满56张标志
CollectCard.TASK_CARD_BAG_AWARD_FINISH = 70;				--卡册换取奖励，标志安全起见


CollectCard.AWARD_WEIWANG 	   = {{30,1}};	--威望对应奖励活动卡{达到威望，活动卡个数}
CollectCard.CARD_DATA_LIMIT_MAX = 8;--民族大团圆卡（未鉴定）每天最大使用数量
CollectCard.CARD_LIMIT_MAX = 100;	--民族大团圆卡（未鉴定）最大使用数量
--CollectCard.ITEM_GOLDTOKEN = {18,1,179,2};	--黄金令牌
--CollectCard.ITEM_WHITETOKEN = {18,1,179,1};	--白银令牌
--CollectCard.ITEM_GOLDHUOJU = {18,1,182,4};	--黄金火炬

CollectCard.AWARD_CARD_BASEEXP = 60;		--普通奖励
CollectCard.AWARD_CARD_BINDMONEY = 5000;	--普通奖励
CollectCard.AWARD_CARD_COIN = 50;			--普通奖励

CollectCard.AWARD_LUCKCARD_BASEEXP = 60;		--幸运奖励
CollectCard.AWARD_LUCKCARD_BINDMONEY = 50000;	--幸运奖励
CollectCard.AWARD_LUCKCARD_COIN = 500;			--幸运奖励

CollectCard.FILE_BAOXIANG = "\\setting\\event\\collectcard\\baoxiang.txt"

CollectCard.TASK_CARD_ID =
{
	--物品Id = {变量，名字};
	[403] = {6 ,"Mông Cổ"},
	[404] = {7 ,"Hồi"},
	[405] = {8 ,"Tây Tạng"},
	[406] = {9 ,"Duy Ngô Nhĩ"},
	[407] = {10,"Miêu"},
	[408] = {11,"Di"},
	[409] = {12,"Choang"},
	[410] = {13,"Bố Y"},
	[411] = {14,"Triều Tiên"},
	[412] = {15,"Mãn"},
	[413] = {16,"Đồng"},
	[414] = {17,"Dao"},
	[415] = {18,"Bạch"},
	[416] = {19,"Thổ Gia"},
	[417] = {20,"Hà Nhì"},
	[418] = {21,"Cát Táp Khắc"},
	[419] = {22,"Thái"},
	[420] = {23,"Lê"},
	[421] = {24,"Lật Túc"},
	[422] = {25,"Ngõa"},
	[423] = {26,"Dư"},
	[424] = {27,"Cao Sơn"},
	[425] = {28,"Lạp Hỗ"},
	[426] = {29,"Thủy"},
	[427] = {30,"Đông Hương"},
	[428] = {31,"Nạp Tây"},
	[429] = {32,"Cảnh Pha"},
	[430] = {33,"Kha Nhĩ Khắc Tư"},
	[431] = {34,"Thổ"},
	[432] = {35,"Đạt Oát Nhĩ"},
	[433] = {36,"Mục Lão"},
	[434] = {37,"Khương"},
	[435] = {38,"Bố Lãng"},
	[436] = {39,"Tát Lạp"},
	[437] = {40,"Mao Nam"},
	[438] = {41,"Ngật Lão"},
	[439] = {42,"Tích Bá"},
	[440] = {43,"A Xương"},
	[441] = {44,"Phổ Mễ"},
	[442] = {45,"Tháp Cát Khắc"},
	[443] = {46,"Nộ"},
	[444] = {47,"Ô Tư Biệt Khắc"},
	[445] = {48,"Nga La Tư"},
	[446] = {49,"Ngạc Ôn Khắc"},
	[447] = {50,"Đức Ngang"},
	[448] = {51,"Bảo An"},
	[449] = {52,"Dụ Cố"},
	[450] = {53,"Kinh"},
	[451] = {54,"Tháp Tháp Nhĩ"},
	[452] = {55,"Độc Long"},
	[453] = {56,"Ngạc Xuân Luân"},
	[454] = {57,"Hách Triết"},
	[455] = {58,"Môn Ba"},
	[456] = {59,"Lạc Ba"},
	[457] = {60,"Cơ Nặc"},
	[458] = {61,"Hán"},
}
--  [459] = "千里共婵娟"

CollectCard.CARD_START_ID = 403;	--体育卡开始ID
CollectCard.CARD_END_ID	  = 458;	--体育卡结束ID

function CollectCard:__debug_clear_my_card_record()
	for _, tbData in pairs(self.TASK_CARD_ID) do
		local nTaskId = tbData[1];
		me.SetTask(self.TASK_GROUP_ID, nTaskId, 0);
	end
	
	me.SetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID, 0 );
	me.SetTask(self.TASK_GROUP_ID, CollectCard.TASK_DATE_ID, 0);
	me.SetTask(self.TASK_GROUP_ID, CollectCard.TASK_COLLECT_COUNT, 0);
	me.SetTask(self.TASK_GROUP_ID, CollectCard.TASK_COLLECT_FINISH, 0);
	me.Msg("Xóa hết")
end

function CollectCard:__debug_pritnt_luckycard()
	local nLuckyCardId = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_COLLECTCARD_RANDOM);
	if nLuckyCardId == 0 then
		me.Msg("Không phải thẻ may mắn");
	else
		if self.TASK_CARD_ID[nLuckyCardId] then
			me.Msg(self.TASK_CARD_ID[nLuckyCardId][2]);
		else
			me.Msg("Có bug: ", nLuckyCardId);
		end
	end
end


--  [奖励等级] --> {[CARD_BAG_AWARD表索引] --> 对应的奖品所需的卡片数量, ...}
-- 
CollectCard.CARD_BAG_AWARD_STEP = 
{
	--  [1] [2] [3] [4] [5] [6] [7]
	[1]={28, 26, 23, 20, 16, 12, 4},	--收集总数少于40张奖励表
	[2]={28, 26, 23, 0, 0, 0, 0},		--收集总数40-49张奖励表
	[3]={28, 26, 0, 0, 0, 0, 0},		--收集总数50张奖励表
}

CollectCard.CARD_BAG_AWARD =
{
	[1] = {18,1,178,4}, --盛夏活动黄金宝箱
	[2] = {18,1,178,3}, --盛夏活动白银宝箱
	[3] = {18,1,178,2}, --盛夏活动青铜宝箱
	[4] = {18,1,178,1}, --盛夏活动黑铁宝箱
	[5] = {18,1,114,6}, --绑定的6级玄晶
	[6] = {18,1,114,5}, --绑定的5级玄晶
	[7] = {18,1,114,4}, --绑定的4级玄晶
}

--CollectCard.HUOJU_AWARD_STEP = {10000, 3500, 1000, 300, 80, 20}
--CollectCard.HUOJU_AWARD =
--{
--	[1] = {tbItem={18,1,179,2}, nBind=1, nTimeLimit = 43200}, --黄金令牌
--	[2] = {tbItem={18,1,179,1}, nBind=1, nTimeLimit = 43200}, --白银令牌
--	[3] = {tbItem={18,1,1,10}, nBind=1}, --10级玄晶
--	[4] = {tbItem={18,1,1,9}, nBind=1}, --9级玄晶
--	[5] = {tbItem={18,1,1,8}, nBind=1}, --8级玄晶
--	[6] = {tbItem={18,1,1,7}, nBind=1}, --7级玄晶
--}

function CollectCard:WriteLog(szLog, nPlayerId)
	if nPlayerId then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) then
			Dbg:WriteLog("SpecialEvent.CollectCard", "Thu thập Thẻ hoạt động Thịnh Hạ", pPlayer.szAccount, pPlayer.szName, szLog);
			return 1;
		end
	end
	Dbg:WriteLog("SpecialEvent.CollectCard", "Thu thập Thẻ hoạt động Thịnh Hạ", szLog);

end

local __get_boots_1 = function(pPlayer)
	pPlayer.AddRepute(10,1,1500);
	return {};
end

local __get_boots_2 = function(pPlayer)
	pPlayer.AddRepute(10,1,500);
	return {};
end

CollectCard.tbFinalAwardNationalDay09 = 
{-- 名次   gdpl       数量
	{1,   {repute={10,1,1500}},0},	--声望
	{10,  {repute={10,1,500}},0},	--声望
	{100, {item={18,1,462,1}},5},
	{500, {item={18,1,462,1}},3},
	{1000,{item={18,1,355,1}},2},
	{2000,{item={18,1,355,1}},1},
	{3000,{item={18,1,114,8}},1},
};

-- 09年国庆卡片收集活动结束后奖励
-- 有奖return {g,d,p,l}, nNum 
-- 没奖return nil
function CollectCard:GetFinalAwardNationalDay09(nRank, nCardNum, pPlayer)
	if (nRank <= 0 or nRank > 3000) then
		if nCardNum >= 60 then
			return 2, {18,1,114,8}, 1;
		else
			return 0;
		end
	end
	
	for _, tbData in ipairs(self.tbFinalAwardNationalDay09) do
		if nRank <= tbData[1] then
			if tbData[2].repute then
				return 1, tbData[2].repute, tbData[3];
			end
			if tbData[2].item then
				return 2, tbData[2].item, tbData[3];
			end
		end
	end
	return 0;
end

