-- 文件名　：chaotingyushi.lua
-- 创建者　：furuilei
-- 创建时间：2009-06-16 09:50:36

Require("\\script\\domainbattle\\task\\domaintask_def.lua");

local tbChaoTingYuShi = Npc:GetClass("chaotingyushi");
--=======================================================================
tbChaoTingYuShi.tbFollowInsertItem 	= {18, 1, 379, 1};
tbChaoTingYuShi.tbBuChangItem		= {18,1,205,1}; -- 补偿奖励的物品
tbChaoTingYuShi.BUCHANG_ITEM_HUMSHI_COUNT = 4;		-- 补偿物品奖励魂石个数

tbChaoTingYuShi.TASK_GROUP = 2097;
tbChaoTingYuShi.TASK_ID_COUNT = 10;	-- 玩家缴纳的霸主之印数量

tbChaoTingYuShi.TASK_ID_FLAG_GET_BUCHANG_STATUARY = Domain.DomainTask.TASK_ID_FLAG_GET_BUCHANG_STATUARY; -- 玩家获得雕像补偿的时间

tbChaoTingYuShi.tbAward = {
		-- 需要缴纳的霸主之印数量	物品名称		物品ID
		{nCount = 500, szName = "Huyền tinh 10(khóa)", tbItem = {18, 1, 114, 10}},
		{nCount = 140, szName = "Huyền tinh 9(khóa)", tbItem = {18, 1, 114, 9}},
		{nCount = 40,  szName = "Huyền tinh 8(khóa)", tbItem = {18, 1, 114, 8}},
		{nCount = 10,  szName = "Huyền tinh 7(khóa)", tbItem = {18, 1, 114, 7}},
		{nCount = 3,   szName = "Huyền tinh 6(khóa)", tbItem = {18, 1, 114, 6}},
		};
--=======================================================================
tbChaoTingYuShi.nCount = {};

tbChaoTingYuShi.BUCHANG_STATUARY_BAZHUZHIYIN_COUNT = Domain.DomainTask.BUCHANG_STATUARY_BAZHUZHIYIN_COUNT;

function tbChaoTingYuShi:OnDialog()
	local tbOpt = {
		{"Giao nạp bá chủ ấn", self.TakeInItem, self},
		{"Xem bảng xếp hạng", self.GetAwardInfo, self},
		{"Lãnh phần thưởng", self.GetAward, self},
		{"Tạo một bức tượng", self.BuildStatuary, self, me.szName},
		{"Lãnh thưởng mức độ tôn kính", self.GiveRevereAward, self, me.szName},
	};
	local szMsg = "Ta đang đi thu thập rải rác bá chủ ấn rải rác trên lãnh thổ。\nNếu ngươi may mắn nhận được，Có thể bàn giao lại cho ta，ta sẽ bẩm báo lên thánh thượng công lao của ngươi，ban đủ thưởng cho ngươi，số lượng thu thập càng nhiều，giải thưởng càng lớn。\nThánh thượng đã hạ lệnh：“các vi anh hùng，ai thu thập được nhiều bá chủ ấn nhất, sẽ được lên điện nghe phong thưởng và lập tượng ghi danh。”";
	local nState = Domain.DomainTask:CheckState();
	if (2 == nState) then
		if (Domain.DomainTask:CheckBuChangState() == 1) then
			table.insert(tbOpt, {"Nhận bá chủ ấn bổ chính", self.OnGiveBuChangJiangli, self, me.szName});
		end

		local tbTemp = {"Đi đến buổi lễ", me.NewWorld, 1541, 1579, 3260};
		table.insert(tbOpt, 2, tbTemp);
		szMsg = "Hoàng thượng trên triều đã tổ chức lễ biểu dương, muốn tham gia buổi lễ mời lên điện 。";
	end
	table.insert(tbOpt, {"Chỉ cần xem qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbChaoTingYuShi:TakeInItem()
	local tbOpt = {
		{"Ta muốn trả tiền", self.SureTakeInItem, self},
		{"Chỉ cần xem qua"}
	};
	local szMsg = "Ngươi nói đã thu thập được không ít bá chủ ấn。\nNgươi có chắc muốn giao nộp cho ta？";
	Dialog:Say(szMsg, tbOpt);
end

-- 放入物品
function tbChaoTingYuShi:SureTakeInItem()
	local nState = Domain.DomainTask:CheckState();
	if (0 == nState) then
		Dialog:Say("Hoạt động không mở，không thể giao nạp bá chủ ấn。");
		return;
	end
	if (2 == nState) then
		Dialog:Say("Hoạt động đã hoàn thành，không thể giao nạp bá chủ ấn。");
		return;
	end
	if (1 ~= nState) then
		return;
	end
	Dialog:OpenGift("Ta muốn trả tiền", nil, {self.OnOpenGiftOk, self});
end

-- 获取奖励
function tbChaoTingYuShi:GetAward()
	local szMsg, tbAward = self:GetAwardMsg(me);
	local tbOpt = {
		{"Ta muốn lãnh thưởng", self.SureGetAward, self, tbAward},
		{"Ta sũy nghĩ lại"}
	};
	Dialog:Say(szMsg, tbOpt);
end

-- 计算玩家能够领取的奖励
function tbChaoTingYuShi:CalcAward(nSum)
	if (nSum < 0) then
		return;
	end
	local tbAwardCount = {};
	local nLevelCount = 0;
	for i, v in ipairs(self.tbAward) do
		if (nSum == 0 or v.nCount == 0) then
			break;
		end
		nLevelCount = math.floor(nSum / v.nCount);
		nSum = nSum % v.nCount;
		if (not tbAwardCount[i]) then
			tbAwardCount[i] = {};
		end
		tbAwardCount[i].nCount = nLevelCount;
		tbAwardCount[i].szName = v.szName;
		tbAwardCount[i].tbItem = v.tbItem;
	end
	return tbAwardCount;
end

function tbChaoTingYuShi:SureGetAward(tbAward)
	local nState = Domain.DomainTask:CheckState();
	if (0 == nState) then
		Dialog:Say("Hoạt động vẫn chưa bắt đầu，không có phần thưởng cấp cho ngươi。");
		return;
	end
	if (1 == nState) then
		Dialog:Say("Hoạt động vẫn chưa kết thúc，Đợi hoạt động kết thúc có thể quay lại nhận thưởng。");
		return;
	end
	if (2 ~= nState) then
		return;
	end
	local nSum = 0;
	for i, v in ipairs (tbAward) do
		nSum = nSum + v.nCount;
	end
	if (me.CountFreeBagCell() < nSum) then
		Dialog:Say(string.format("Hành trang của của bạn không đủ chỗ trống，Cần<color=yellow>%s<color>lệnh bài mở rộng không gian", nSum));
		return;
	end
	for i, v in ipairs(tbAward) do
		for i = 1, v.nCount do
			me.AddItem(unpack(v.tbItem));
		end
	end
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Domain", "chaotingyushi", string.format("%sTrả%sbá chủ ấn，lãnh giải thưởng", me.szName, me.GetTask(self.TASK_GROUP, self.TASK_ID_COUNT)));
	me.SetTask(self.TASK_GROUP, self.TASK_ID_COUNT, 0);
	PlayerHonor:SetPlayerHonorByName(me.szName, PlayerHonor.HONOR_CLASS_KAIMENTASK, 0, 0);
end

-- 使用排行榜提供的接口来显示玩家排名
function tbChaoTingYuShi:GetAwardInfo()
	local nState = Domain.DomainTask:CheckState();
	if (2 == nState) then
		Dialog:Say("Hoạt động đã kết thúc，hiện tại không có chức năng kiểm tra bảng xếp hạng。");
		return;
	end
	local nPlayerRank = PlayerHonor:GetPlayerHonorRankByName(me.szName, PlayerHonor.HONOR_CLASS_KAIMENTASK, 0);
	local nPlayerCount = me.GetTask(self.TASK_GROUP, self.TASK_ID_COUNT);
	local nTongId = me.dwTongId;
	if (nTongId <= 0) then
		Dialog:Say("Bạn hiện không tham gia bang hội nào，không thể giao nộp bá chủ ấn và xem bảng xếp hạng。");
		return;
	end
	local cTong = KTong.GetTong(nTongId);
	if (not cTong) then
		return;
	end
	local szMsg = "";
	if (nPlayerRank > 0) then
		szMsg = string.format("Ngươi trước mắt đã giao nộp bá chủ ấn<color=yellow>%s<color>cái，Vị trí xếp hạng hiện tại<color=yellow>%s<color>Tên。", nPlayerCount, nPlayerRank);
	else
		szMsg = string.format("Ngươi trước mắt đã giao nộp bá chủ ấn<color=yellow>%s<color>cái，Tuy nhiên, do số lượng không đủ hoặc danh sách không được cập nhật và không nhập các bảng xếp hạng，tiếp tục cố gắng hơn nữa。", nPlayerCount);
	end
	local nTongCount = cTong.GetDomainBaZhu();
	szMsg = szMsg .. string.format("Hiện tại bang hội bạn tham gia đã giao nộp bá chủ ấn<color=yellow>%s<color>cái。", nTongCount);
	Dialog:Say(szMsg);
end

function tbChaoTingYuShi:Init()
	if (not self.nCount) then
		self.nCount = {};
	end
	self.nCount[me.nId] = 0;
end

-- 点击确认按钮
function tbChaoTingYuShi:OnOpenGiftOk(tbItemObj)
	self:Init();
	local bForbidItem = 0;
	for _, pItem in pairs(tbItemObj) do
		if (self:ChechItem(pItem) == 0) then
			bForbidItem = 1;
		end
	end
	if (bForbidItem == 1) then
		me.Msg("Tồn tại không phù hợp với đồ vật!")
		return 0;
	end
	local nTongId = me.dwTongId;
	if (nTongId <= 0) then
		Dialog:Say("Bạn không thuộc bang hội，không thể giao nộp bá chủ ấn。");
		return 0;
	end
	local cTong = KTong.GetTong(nTongId);
	if (not cTong) then
		return 0;
	end
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
	self:UpdateCount();
	
	return 1;
end

-- 检测物品是否符合条件
function tbChaoTingYuShi:ChechItem(pItem)
	local bForbidItem = 1;
	local szFollowItem = string.format("%s,%s,%s,%s", unpack(self.tbFollowInsertItem));
	local szItem = string.format("%s,%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel);
	
	if szFollowItem ~= szItem then
		bForbidItem = 0;
	end
	if (not self.nCount[me.nId]) then
		self.nCount[me.nId] = pItem[1].nCount;
	else
		self.nCount[me.nId] = self.nCount[me.nId] + pItem[1].nCount;
	end
	return bForbidItem;
end

-- 检查玩家是否是缴纳霸主之印最多的玩家
function tbChaoTingYuShi:IsFirst(pPlayer)
	local bFirst = 0;
--	local szName = KGblTask.SCGetDbTaskStr(DBTASK_BAZHUZHIYIN_MAX);
	local nFlag	 = Domain.tbStatuary:CheckStatuaryState(pPlayer.szName, Domain.tbStatuary.TYPE_EVENT_NORMAL);
	if (1 == nFlag) then
		bFirst = 1;
	end
	return bFirst;
end

-- 更新玩家和帮会缴纳的霸主之印的数量
function tbChaoTingYuShi:UpdateCount()
	local nTongId = me.dwTongId;
	if (nTongId <= 0) then
		return 0;
	end
	local cTong = KTong.GetTong(nTongId);
	if (not cTong) then
		return 0;
	end
	if (not self.nCount[me.nId] or self.nCount[me.nId] <= 0) then
		return 0;
	end
	local nCurCount = me.GetTask(self.TASK_GROUP, self.TASK_ID_COUNT);
	return GCExcute{"Domain:UpdateBaZhuZhiYin_GC", me.szName, nTongId, nCurCount, self.nCount[me.nId]};
end

-- 获取玩家的奖励情况
function tbChaoTingYuShi:GetAwardMsg(pPlayer)
	if (not pPlayer) then
		return;
	end
	local nPlayerCount = pPlayer.GetTask(self.TASK_GROUP, self.TASK_ID_COUNT);
	local tbAward = self:CalcAward(nPlayerCount);
	if (not tbAward) then
		return;
	end
	local szMsg = string.format("Bạn trước mắt đã giao nộp được bá chủ ấn<color=yellow>%s<color>cái，có thể nhận thưởng được những giải thưởng sau\n", nPlayerCount);
	for i, v in ipairs(tbAward) do
		if (v.nCount > 0) then
			szMsg = szMsg .. string.format("<color=yellow>%s    %s<color>\n", v.szName, v.nCount);
		end
	end
	szMsg = szMsg .. "<color=red>Lưu ý：Các giải thưởng của game thủ sẽ nhận được sau khi hoạt động kết thúc。<color>"
	return szMsg, tbAward;
end

function tbChaoTingYuShi:GiveRevereAward(szName)
	local tbOpt = {
		{"Tao xác nhận lãnh thưởng", self.SureGiveRevereAward, self, szName},
		{"Để tao suy nghĩ lại"},
		};
	local nRevere = Domain.tbStatuary:GetRevere(szName, Domain.tbStatuary.TYPE_EVENT_NORMAL);
	local szMsg = string.format("Bạn hiện tại đã đạt đến mức độ tôn kính<color=yellow>%d<color>，bạn chắc chắn muốn nhận giải thưởng mức độ này không？", nRevere);
	Dialog:Say(szMsg, tbOpt);
end

-- get horse
function tbChaoTingYuShi:SureGiveRevereAward(szName)
	-- todo: bag space check
--	local nFlag = Domain.tbStatuary:CheckStatuaryState(szName, Domain.tbStatuary.TYPE_EVENT_NORMAL);
--	if (nFlag ~= 2) then
--		Dialog:Say("Bạn hiện tại chưa thiết lập một bức tượng, không thể nhận được giải thưởng。");
--		return;
--	end
	
	local nRevere = Domain.tbStatuary:GetRevere(szName, Domain.tbStatuary.TYPE_EVENT_NORMAL);
	if (nRevere < 1500) then
		Dialog:Say("Bức tượng hiện tại của bạn mức độ tích lũy không đủ<color=yellow>1500<color>Điểm，không thể nhận phần thưởng。");
		return;
	end
	
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hành trang của bạn không đủ，Cần trống 1 ô。");
		return;
	end
	
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Domain", "chaotingyushi", string.format("Award %s a horse", me.szName));
	
	Domain.tbStatuary:DecreaseRevere(szName, Domain.tbStatuary.TYPE_EVENT_NORMAL, 1500);
	local pItem = me.AddItem(1,12,12,4);
	if (not pItem) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Domain", "chaotingyushi", string.format("Add %s a horse item failed", me.szName));
	end
	local a,b = pItem.GetTimeOut();
	pItem.Bind(1);		-- 强制绑定
	if b == 0 then
		me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/00", GetTime() + 3600 * 24 * 30));
		pItem.Sync();
	end
	local szMsg = "Bức tượng được dựng lên trong thời gian này, thành tích của bạn đã được công nhận bởi các game thủ nói chung, bước đột phá tích lũy 1500 điểm mức độ tôn kính. Thông qua các kiểm tra của Hoàng thượng。" ..
					"Giải thưởng ngựa cấp 120 của bạn sẽ khấu trừ 1500 điểm mức độ tôn kính。" ..
					"Sau đó, miễn là điểm vinh dự của bạn đạt mức độ tôn kính 1500 điểm, bạn có thể đến cửa hàng mua ngựa cấp 120。"
	Dialog:Say(szMsg, {"Đóng"});
end

-- 树立雕像
function tbChaoTingYuShi:BuildStatuary(szName)
	if (not szName or me.szName ~= szName) then
		return;
	end
	local nState = Domain.DomainTask:CheckState();
	if (0 == nState) then
		Dialog:Say("Hoạt động này vẫn chưa bắt đầu, không thể thiết lập một bức tượng。");
	end
	if (1 == nState) then
		Dialog:Say("Hoạt động chưa kết thúc, không thể thiết lập một bức tượng。");
	end
	if (2 ~= nState) then
		return;
	end
	local nFlag = Domain.tbStatuary:CheckStatuaryState(me.szName, Domain.tbStatuary.TYPE_EVENT_NORMAL);	
	local szMsg = "";
	if (0 == nFlag) then
		szMsg = "Thành tích hiện tại của bạn không đáp ứng  thiết lập sức mạnh của bức tượng。\nchỉ có thu thập đc nhìu bá chủ ấn mới có tư cách lập tượng。";
		Dialog:Say(szMsg);
		return;
	elseif (nFlag == 2) then
		Dialog:Say("Bạn đã thiết lập  bức tượng, không thể tiếp tục thiết lập");
		return;
	elseif (nFlag == 1) then
		local bFinishTask = me.GetTask(1024, 62);
		if (1 ~= bFinishTask) then
			Dialog:Say("Bạn cần phải hoàn thành<color=yellow>giải thưởng anh hùng<color>Lễ để thiết lập các bức tượng。\n<color=red>từ quan lễ bộ tiến đến，trên triều đình tại điện và đối thoại lễ bộ sách có thể tham gia nghi thức giải thưởng anh hùng。<color>");
			return;
		end
		szMsg = string.format("Thánh thượng đã hạ lệnh：các vi anh hùng，ai thu thập được nhiều bá chủ ấn nhất, sẽ được lên điện nghe phong thưởng và lập tượng ghi danh\
	\nBạn là bá chủ của trận chiến của hoạt động， thánh thượng thu thập được nhiều bá chủ ấn nhất. Thiết lập các trình độ của bức tượng.\
    \nThiết lập một bức tượng, nó mất<color=yellow>10000<color>từng yêu tố của đá ngũ hành.\
    \nBức tượng đã được dựng lên, sẽ nhận được sự thờ phượng công cộng hoặc gạt sang một bên. Để được tôn thờ, nó sẽ làm tăng sự tôn trọng của bức tượng.\
   Nếu sự tôn kính của bức tượng đã đạt<color=yellow>1500<color>Điểm，Đó là thành tích của bạn đã được sự công nhận của mọi người，Sau đó, bạn có thể đến đây để nhận được phần thưởng cuối cùng：Món quà của hoàng đế ban<color=yellow>120Mới được sử dụng<color>.");
	elseif (nFlag == 3) then
		Dialog:Say("Vị trí tượng không đủ，không thể thiết lập bức tượng！");
		return;
	end

	Dialog:Say(szMsg,
		{
			{"Ta muốn thiết lập bức tượng của mình", self.SureBuildStatuary, self},
			{"Để ta nghĩ lại"},
		});
end

function tbChaoTingYuShi:SureBuildStatuary()
	-- 获取玩家的主修门派
	local nFaction = Faction:GetGerneFactionInfo(me)[1];
	if (not nFaction) then
		nFaction = me.nFaction;
	end
	
	if (Player.FACTION_NONE == nFaction) then
		Dialog:Say("Bạn vẫn chưa tham gia môn phái nào，không thể thiết lập một bức tượng。");
		return;
	end
	if (Player.FACTION_NUM < nFaction) then
		return;
	end
	local nStoneCount = me.GetItemCountInBags(18,1,205,1);
	if (nStoneCount < 10000) then
		Dialog:Say("Năm yếu tố cần thiết để thiết lập một bức tượng đá linh hồn！");
		return;
	end
	self:WriteLog("BuildStatuary", string.format("%s use series stone %d success!", me.szName, 10000));
	local nResult = Domain.tbStatuary:AddStatuary(me.szName, Domain.tbStatuary.TYPE_EVENT_NORMAL, nFaction, me.nSex);
	if (0 == nResult) then
		self:WriteLog("BuildStatuary", string.format("%s BuildStatuary Failed!", me.szName));
		return;
	end
	if (1 == me.ConsumeItemInBags2(10000, 18,1,205,1)) then
		self:WriteLog("BuildStatuary", string.format("%s use series stone %d failed!", me.szName, 10000));
		return;
	end
end

function tbChaoTingYuShi:WriteLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Domain", "tbChaoTingYuShi", unpack(arg));
	end
end

-- 用于补偿霸主之印活动结束后剩余未交的霸主之印
function tbChaoTingYuShi:OnGiveBuChangJiangli(szPlayerName)
	if (not szPlayerName) then
		return 0;
	end
	
	local nState, szMsg = Domain.DomainTask:CheckBuChangState();
	if (0 == nState) then
		Dialog:Say(szMsg);
		return 0;
	end

	self.CONTEXT_CHANGE_HUNSHI = "1 bá chủ ấn có thể đổi 4 đá linh hồn"; 
	Dialog:OpenGift(self.CONTEXT_CHANGE_HUNSHI, nil, {self.OnBuChangOpenGiftOk, self});	
end

function tbChaoTingYuShi:OnBuChangOpenGiftOk(tbItemObj)
	local bForbidItem = 0;
	local nBaZhuCount = 0;
	local szFollowItem = string.format("%s,%s,%s,%s", unpack(self.tbFollowInsertItem));

	for _, pItem in pairs(tbItemObj) do
		local szItem = string.format("%s,%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel);
		if szFollowItem ~= szItem then
			bForbidItem = 1;
			break;
		end
		nBaZhuCount = nBaZhuCount + pItem[1].nCount;
	end
	if (bForbidItem == 1) then
		me.Msg("Tồn tại không đáp ứng vật phẩm!")
		return 0;
	end
	local nTongId = me.dwTongId;
	if (nBaZhuCount <= 0) then
		Dialog:Say("chưa đóng góp bá chủ ấn。");
		return 0;
	end
	
	local nFreeCount = me.CountFreeBagCell();
	local nHunshi = nBaZhuCount * self.BUCHANG_ITEM_HUMSHI_COUNT;
	local nHunFree = math.ceil(nHunshi / 5000);
	if (nHunFree <= 0) then
		Dialog:Say("không có thí giao bá chủ ấn！");
		return 0;
	end
	
	if (nHunFree > nFreeCount) then
		Dialog:Say(string.format("Hành trang của bạn không đủ，Bạn cần%smở rộng không gian túi。", nHunFree));
		return 0;
	end
	
	if (1 == me.ConsumeItemInBags2(nBaZhuCount,unpack(self.tbFollowInsertItem))) then
		self:WriteLog("OnBuChangOpenGiftOk", me.szName, "give bazhuzhiyin failed!");
		return 0;
	end
	local nGetNum = me.AddStackItem(self.tbBuChangItem[1], self.tbBuChangItem[2], self.tbBuChangItem[3], self.tbBuChangItem[4], {bForceBind = 1}, nHunshi);
	self:WriteLog("OnBuChangOpenGiftOk",  me.szName..",Nên được số lượng đá linh hồn：", nHunshi, "Số lượng thực tế của đá linh hồn：", nGetNum);
	
	return 1;
end
