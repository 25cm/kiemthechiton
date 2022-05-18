-------------------------------------------------------------------
--File: jbreturn.lua
--Author: luobaohang
--Date: 2008-9-24 22:51:59
--Describe: 金币消耗返还脚本
-------------------------------------------------------------------

--Dbg.tbDbgMode.jbreturn	= 1;	-- 调试

jbreturn.REBATE_RATE	= 10;	-- 固定10倍优惠

jbreturn.tbPermitIp = jbreturn.tbPermitIp or {	-- 支持重载，方便内网测试
	["219.131.196.66"] = 1,
	["219.141.176.227"] = 1,
	["219.141.176.228"] = 1,
	["219.141.176.229"] = 1,
	["114.255.44.131"] = 1,
	["114.255.44.132"] = 1,
	["114.255.44.133"] = 1,	
	["222.35.61.94"] = 1,
	["221.237.177.90"] = 1,
	["221.237.177.91"] = 1,
	["221.237.177.92"] = 1,
	["221.237.177.93"] = 1,
	["221.237.177.94"] = 1,
	["221.237.177.95"] = 1,
	["218.24.136.208"] = 1,
	["113.106.106.2"] = 1,
	["113.106.106.98"] = 1,
	["113.106.106.99"] = 1,
	["221.4.212.138"] = 1,
	["221.4.212.139"] = 1,
	["103.106.106.2"] = 1,
	["218.24.136.210"] = 1,
	["218.24.136.211"] = 1,
	["218.24.136.212"] = 1,
};

jbreturn.tbMonLimit	= {
	[0]	= 0,
	[1]	= 100,
	[2]	= 300,
	[3]	= 500,
	[4]	= 1000,
	[5]	= 2000,
	[6]	= 5000,
	[9]	= math.huge,
};

jbreturn.tbSpecial	= {
	{0, "Đổi lấy lượng bạc ràng buộc",	"SelectReturnType", 1},
	{0, "Đổi lấy tiền vàng ràng buộc",	"SelectReturnType", 2},
	{0, "Đổi mã thông báo võ sư",	"BuyGaoshouling"},
	{0, "Mua vật phẩm tri kỷ đồng hành", "BuyPartnerItem"},
	{0, "Mua tiền xu cổ của rồng", "BuyYoulongCoin"},
	{2, "Trói vàng để mua He Choi",	"BuyHSB"},
	{9, "Trói vàng để mua thỏi bạc băng đảng",	"BuyTongFund"},
	{0, "Tôi muốn biết các quy tắc trả lại điểm nội bộ",	"ReturnHelp"};
};

jbreturn.tbRefundItem	= {
	{
		szName	= "Vàng thỏi",
		tbLevel	= {
			{349, 500},	-- 道具ID，价格
			{350, 5000},
		},
	}, {
		szName	= "Thỏi vàng",
		tbLevel	= {
			{351, 500},
			{352, 5000},
		},
	},
};

-- 是否是允许IP
function jbreturn:IsPermitIp(pPlayer)
	local szIp	= pPlayer.GetPlayerIpAddress();
	local nPos	= string.find(szIp, ":");
	if (nPos) then
		szIp	= string.sub(szIp, 1, nPos - 1);
	end
	return self.tbPermitIp[szIp] or 0;
end

-- 测试用激活内部优惠
function jbreturn:ActiveAccount(nMonLimit, nSpecial)
	nMonLimit	= nMonLimit or 2;
	nSpecial	= nSpecial or 0;
	local nOldValue	= me.nRebateMultiple;
	local nNewValue	= nMonLimit + nSpecial * 10;
	if (nNewValue > nOldValue) then
		me.AddExtPoint(7, (nNewValue - nOldValue) * 10000);
	else
		me.PayExtPoint(7, (nOldValue - nNewValue) * 10000);
	end
	me.Msg(string.format("Kích hoạt ưu đãi nội bộ(%d,%d)！", nMonLimit, nSpecial));
end

-- 旧账号激活2009新内部优惠
function jbreturn:OldActiveAccount(pPlayer)
	local nOldValue	= pPlayer.nRebateMultiple;
	local nNewValue	= 0;
	if (nOldValue == 10) then
		nNewValue	= 2;
	elseif (nOldValue == 11) then
		nNewValue	= 96;
	else
		return nOldValue;
	end
	if (nNewValue > nOldValue) then
		pPlayer.AddExtPoint(7, (nNewValue - nOldValue) * 10000);
	else
		pPlayer.PayExtPoint(7, (nOldValue - nNewValue) * 10000);
	end
	pPlayer.Msg("您已成功激活<color=yellow>2009新内部优惠<color>！");
	self:WriteLog(Dbg.LOG_INFO, "OldActiveAccount", pPlayer.szName, pPlayer.szAccount, nOldValue, nNewValue);
	return nNewValue;
end

-- 获取每月兑换额度
function jbreturn:GetMonLimit(pPlayer)
	local nValue	= pPlayer.nRebateMultiple;
	if (nValue == 0) then
		return 0;
	end
	if (tonumber(GetLocalDate("%Y%m%d")) < 20091203) then	-- 尚在激活期
		nValue	= self:OldActiveAccount(pPlayer);
	end
	local nLimitLevel	= math.mod(nValue, 10);
	return self.tbMonLimit[nLimitLevel] or 0;
end

-- 获取特殊权限对话（未做激活处理）
function jbreturn:GetSpecialOption(pPlayer)
	local tbOption	= {};
	local nValue	= pPlayer.nRebateMultiple;
	local nSpecial	= math.floor(nValue / 10);
	for _, tb in ipairs(self.tbSpecial) do
		if (nSpecial >= tb[1]) then
			tbOption[#tbOption + 1]	= {tb[2], self[tb[3]], self, unpack(tb, 4)};
		end
	end
	return tbOption;
end

function jbreturn:GainBindCoin()
	if (self:IsPermitIp(me) ~= 1) then
		return 0;
	end
	
	local nMonLimit	= self:GetMonLimit(me);
	if (nMonLimit <= 0) then
		return 0;
	end
	
	local nConsumedValue	= me.nConsumedValue;
	local nMonCharge		= me.nMonCharge;
	local nRefundAvailable	= math.min(nMonLimit, nMonCharge) * 100 - nConsumedValue;
	if (nRefundAvailable < 0) then
		nRefundAvailable	= 0;
	end
	local tbOption	= self:GetSpecialOption(me);
	local tbNpc	= Npc:GetClass("renji");
	tbOption[#tbOption + 1]	= {"我只是想领取密友返还的绑定金币", tbNpc.GetIbBindCoin, tbNpc};
	tbOption[#tbOption + 1]	= {"<color=gray>关闭"};
	
	local szMsgFmt	= [[
<color=red>您的帐号是内部流通帐号<color>
您每月可以使用金币换取<color=yellow>%s<color>金币的绑定金币或绑定银两，<color=yellow>换取后金币将被扣除<color>。
本月充值<color=yellow>%d<color>金币。
已兑换过<color=yellow>%d<color>金币。
还可兑换<color=yellow>%d<color>金币。

请选择您希望兑换的类型：]];
	
	Dialog:Say(string.format(szMsgFmt, (nMonLimit == math.huge and "无限") or nMonLimit * 100,
		nMonCharge * 100, nConsumedValue, nRefundAvailable), tbOption);
	
	return 1;
end

-- nType 1:绑银，2：绑金 nLevel:等级(大/小) nCount个数
function jbreturn:_GetRefundOption(nType, nLevel, nCount)
	local nRate		= self:GetRebateRate(nType);
	local tbItem	= self.tbRefundItem[nType].tbLevel[nLevel];
	--将500金币兑换成
	local szMsg = string.format("将%d金币兑换成%s%s", tbItem[2] * nCount, tbItem[2] * nRate * nCount, self.tbRefundItem[nType].szName);
	return {szMsg, self.PrepareRefund, self, nType, nLevel, nCount};
end


function jbreturn:SelectReturnType(nType)
	Dialog:Say("请选择兑换额度：", {
		self:_GetRefundOption(nType, 1, 1),
		self:_GetRefundOption(nType, 1, 2),
		self:_GetRefundOption(nType, 1, 4),
		self:_GetRefundOption(nType, 2, 1),
		self:_GetRefundOption(nType, 2, 2),
		self:_GetRefundOption(nType, 2, 4),
		self:_GetRefundOption(nType, 2, 10),
		{"<color=gray>关闭"}
	});
	
end

function jbreturn:PrepareRefund(nType, nLevel, nCount)
	if (me.IsInPrison() == 1) then
		me.Msg("天牢里不能兑换。");
		return 0;
	end	
	
	local tbItem	= self.tbRefundItem[nType].tbLevel[nLevel];
	local nConsume	= me.nConsumedValue + tbItem[2] * nCount;

	if (nConsume > self:GetMonLimit(me) * 100) then
		me.Msg("您的每月兑换额度不足以完成兑换，请下个月再来。<pic=20>");
		return 0;
	end
	if (nConsume > me.nMonCharge * 100) then
		me.Msg("您本月充值额度不足以兑换，想要继续兑换，请充值。<pic=20>");
		return 0;
	end
	if (nType == 1	-- 换绑银需要检查携带上限
		and tbItem[2] * self:GetRebateRate(nType) * nCount + me.GetBindMoney() > me.GetMaxCarryMoney()) then
		Dialog:Say(string.format("您的绑定银两将超出<color=yellow>%s两<color>的上限，请用掉一部分再来！<pic=26>", me.GetMaxCarryMoney()));
		return 0;
	end
	me.ApplyAutoBuyAndUse(tbItem[1], nCount);
	return 1;
end

function jbreturn:ReturnHelp()
	Dialog:Say(
		string.format("在充值当月，您可以按一定比例将金币兑换为绑定金币或绑定银两。兑换比例是您的返还倍数(<color=yellow>%d倍<color>)，金币兑换总量不能超过当月充值的金币数量。\n\n此功能仅限公司内部帐号，并且只有从公司IP登录游戏才可看到。", self.REBATE_RATE),
		{
			{ "返回上一页", self.GainBindCoin, self },
			{ "Kết thúc đối thoại" }
		});
end

function jbreturn:BuyTongFund()
	Dialog:Say("请选择购买的帮会银锭种类:",
		{
			{"帮会银锭（小）", self.ExcuteBuyTongFund, self, 1},
			{"帮会银锭（大）", self.ExcuteBuyTongFund, self, 2},
			{"取消"}
		});
end

function jbreturn:BuyHSB()
	local szMsg	= string.format("当前声望：%d级 %d点\n", me.GetReputeLevel(9, 2), me.GetReputeValue(9, 2));
	szMsg	= szMsg .. "请选择购买秦岭·和氏璧的数量:\n<color=yellow>【注：购买后直接增加声望，不会获得道具】";
	Dialog:Say(szMsg,
		{
			{"1个（100点声望）", self.ExcuteBuyHSB, self, 1},
			{"10个（1000点声望）", self.ExcuteBuyHSB, self, 10},
			{"100个（10000点声望）", self.ExcuteBuyHSB, self, 100},
			{"取消"}
		});
end

function jbreturn:ExcuteBuyHSB(nCount)
	if me.GetReputeLevel(9, 2) >= 3 then
		me.Msg("使用<color=yellow>秦岭·和氏璧<color>只能使<color=green>秦始皇陵·发丘门<color>声望最高增加到<color=yellow>3<color>级！");
		return;
	end
	local nCoin	= nCount * 10000;
	if (me.nBindCoin < nCoin) then
		Dialog:Say("您的绑定金币不足！");
		return;
	end
	if (Player:AddRepute(me, 9, 2, nCount * 100)==1) then
		Dialog:Say("您的声望已达上限！");
		return;
	end
	me.AddBindCoin(-nCoin, Player.emKBINDCOIN_COST_JBRETURN);
	self:BuyHSB();
end

jbreturn.tbTongSyceeCost = { [1] = 1000, [2] = 10000 }
jbreturn.tbBindItemInfo =
{
		nil,		--五行，默认无
		nil,			--		强化次数，默认0
		nil,				--	幸运
		nil,						
		nil, 			--	装备随机品质
		nil,					
		nil,				--	随机种子
		1,					--	强制绑定默认0
		nil,				--		是否会超时
 		nil,					--		是否消息通知
};
function jbreturn:ExcuteBuyTongFund(nType)
	local nCost = self.tbTongSyceeCost[nType];
	if not nCost or nCost <= 0 then
		return;
	end
	if me.AddBindCoin(-nCost, Player.emKBINDCOIN_COST_JBRETURN) == 1 then
		local pItem = me.AddItemEx(18, 1, 284, nType, self.tbBindItemInfo);
		if pItem then
			pItem.SetTimeOut(0, GetTime()+ 30*24*3600 );
			pItem.Sync();
		end
	else
		Dialog:Say("您的绑定金币不足！");
	end
end

function jbreturn:GetRebateRate(nType)
	local nRate	= self.REBATE_RATE;
	if (nType == 1) then		-- 绑银比率
		-- 获取金币汇率
		local nJbPrice = KJbExchange.GetPrvAvgPrice();
		nRate	= nRate * math.max(100, nJbPrice);
	end
	return nRate;
end

-- 购买武林高手令牌
function jbreturn:BuyGaoshouling()	
	local tbOpt = 
	{
		{"高级武林高手令牌（金）", self.DoBuyGaoshouling, self, 1},
		{"高级武林高手令牌（木）", self.DoBuyGaoshouling, self, 2},
		{"高级武林高手令牌（水）", self.DoBuyGaoshouling, self, 3},
		{"高级武林高手令牌（火）", self.DoBuyGaoshouling, self, 4},
		{"高级武林高手令牌（土）", self.DoBuyGaoshouling, self, 5},
		{"Kết thúc đối thoại"}
	};
	Dialog:Say("请选择购买的高级武林高手令牌种类：", tbOpt);
end

function jbreturn:DoBuyGaoshouling(nType)
	local tbWard = 
	{
		[1] = {373, "挑战武林高手(金)"},
		[2] = {374, "挑战武林高手(木)"},
		[3] = {375, "挑战武林高手(水)"},
		[4] = {376, "挑战武林高手(火)"},
		[5] = {377, "挑战武林高手(土)"},
	};
	local nWareId = tbWard[nType][1];
	if not nWareId then
		return;
	end

	local nLevel = me.GetReputeLevel(6, nType);
	if not nLevel then
		return;
	end
	
	if me.CheckLevelLimit(6, nType) == 1 then
		me.Msg("对不起，您的".. tbWard[nType][2] .."声望已经达到上限。");
		return;
	end
	
	if me.GetJbCoin() < 500 then
		me.Msg("对不起，您的金币不够。");
		return;
	end
	
	me.ApplyAutoBuyAndUse(nWareId, 1);
end

-- 绑金购买亲密度道具
function jbreturn:BuyPartnerItem()
	local tbOpt = 
	{
		{"普通的精魄（100绑金）", self.DoBuyPartnerItem, self, 1},
		{"特别的精魄（1000绑金）", self.DoBuyPartnerItem, self, 2},
		{"奇妙的精魄（10000绑金）", self.DoBuyPartnerItem, self, 3},
		{"菩提果（5000绑金）", self.DoBuyPartnerItem, self, 4},
		{"同伴特殊材料（3000绑金）", self.DoBuyPartnerItem, self, 5},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say("请选择要购买的同伴亲密度道具种类：", tbOpt);
end

function jbreturn:DoBuyPartnerItem(nType)
	
	local tbItem = 
	{
		[1] = {18, 1, 544, 1, 100},
		[2] = {18, 1, 544, 2, 1000},
		[3] = {18, 1, 544, 3, 10000},
		[4] = {18, 1, 564, 1, 5000},
		[5] = {18, 1, 556, 1, 3000},
	};
	
	if not tbItem[nType] then
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("请留下1格背包空间，再来购买道具。");
		return 0;
	end
	
	local nCoin	= tbItem[nType][5];
	if me.nBindCoin < nCoin then
		Dialog:Say("您的绑定金币不足，无法购买道具。");
		return 0;
	end
	
	local pItem = me.AddItemEx(tbItem[nType][1], tbItem[nType][2], tbItem[nType][3], tbItem[nType][4], {bForceBind = 1});
	if pItem then
		me.AddBindCoin(-nCoin, Player.emKBINDCOIN_COST_JBRETURN);
	end
end

-- 绑金购买游龙古币
function jbreturn:BuyYoulongCoin()
	
	local nChange = me.GetTask(2056, 3);
	local nSpecial = math.floor(me.nRebateMultiple / 10);
	local szMsg = string.format("您本月已经购买了<color=yellow>%s<color>个游龙古币，还能继续购买<color=yellow>%s<color>个游龙古币。\n\n请选择要购买的游龙古币数量：",
		nChange, ((self:GetMonLimit(me) == math.huge or nSpecial >= 2) and "无限") or math.max(self:GetMonLimit(me) * 2 - nChange, 0));
	
	local tbOpt = 
	{
		{"100游龙古币（5000绑金）", self.DoBuyYoulongCoin, self, 1},
		{"200游龙古币（10000绑金）", self.DoBuyYoulongCoin, self, 2},
		{"1000游龙古币（50000绑金）", self.DoBuyYoulongCoin, self, 3},
		{"2000游龙古币（100000绑金）", self.DoBuyYoulongCoin, self, 4},
		{"Kết thúc đối thoại"},
	};
	
	Dialog:Say(szMsg, tbOpt);
end

function jbreturn:DoBuyYoulongCoin(nType)
	
	local tbCost = 
	{
		[1] = {5000, 100},
		[2] = {10000, 200},
		[3] = {50000, 1000},
		[4] = {100000, 2000},
	};
	
	if not tbCost[nType] then
		return 0;
	end
	
	local nChange = me.GetTask(2056, 3);
	local nSpecial = math.floor(me.nRebateMultiple / 10);
	if nSpecial < 2 then
		if nChange + tbCost[nType][2] > self:GetMonLimit(me) * 2 then
			Dialog:Say("对不起，您的选择将超出本月的限额，无法进行购买。");
			return 0;
		end
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("请留下1格背包空间，再来购买游龙古币。");
		return 0;
	end

	if me.nBindCoin < tbCost[nType][1] then
		Dialog:Say("您的绑定金币不足，无法进行购买。");
		return;
	end
	
	me.AddStackItem(18, 1, 553, 1, {bForceBind = 1}, tbCost[nType][2]);
	me.AddBindCoin(-tbCost[nType][1]);
	
	me.SetTask(2056, 3, nChange + tbCost[nType][2]);
end

function jbreturn:ResetYoulongLimit()
	local nMonLimit	= self:GetMonLimit(me);
	if nMonLimit <= 0 then
		return 0;
	end
	me.SetTask(2056, 3, 0);
end

PlayerSchemeEvent:RegisterGlobalMonthEvent({jbreturn.ResetYoulongLimit, jbreturn});
