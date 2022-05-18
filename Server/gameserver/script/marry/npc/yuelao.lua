-- 文件名　：yuelao.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-07 11:08:45
-- 功能描述：结婚npc，月老

local tbNpc = Npc:GetClass("marry_yuelao");
--==========================================================

tbNpc.LEVEL_PINGMIN		= 1;	-- 平民
tbNpc.LEVEL_GUIZU		= 2;	-- 贵族
tbNpc.LEVEL_WANGHOU		= 3;	-- 王侯
tbNpc.LEVEL_HUANGJIA	= 4;	-- 皇家

tbNpc.MINLEVEL_APPWEDDING	= 50;	-- 求婚的最低等级要求

tbNpc.MONEY_BASE = 200000;		-- 首次修改婚期需要上缴费用20W
tbNpc.RETE = 5;					-- 每次修改，需要缴纳费用是上次的5倍

tbNpc.tbLibaoGDPL = {"18-1-603-1", "18-1-603-2", "18-1-603-3", "18-1-603-4",
					"18-1-594-1", "18-1-594-2", "18-1-594-3", "18-1-594-4"};

tbNpc.tbWeddingInfo = {
	[tbNpc.LEVEL_PINGMIN]	= {szName = "Hiệp Sỹ",},
	[tbNpc.LEVEL_GUIZU]		= {szName = "Quý Tộc",},
	[tbNpc.LEVEL_WANGHOU]	= {szName = "Vương Hầu",},
	[tbNpc.LEVEL_HUANGJIA]	= {szName = "Hoàng Gia",},
	};

--==========================================================

function tbNpc:OnDialog()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local szMsg = "Quan quan con chim gáy, tại hà chi châu. Yểu điệu thục nữ, quân tử hảo cầu. Giá vị đại hiệp, nhìn ra được: ngươi cho dù đang ở giang hồ, cũng có đồng người trong lòng cùng suốt đời đích mỹ hảo nguyện vọng a!";
	local tbOpt = {};
	table.insert(tbOpt, {"<color=yellow>Tham dự lễ cưới<color>", Marry.SelectServer, Marry});
	table.insert(tbOpt, {"Đặt Lễ", self.AppWeddingDlg, self});
	table.insert(tbOpt, {"Tham quan lễ đường", self.PreViewWeddingPlaceDlg, self});
	table.insert(tbOpt, {"Tin tức điển lễ", self.QueryWeddingInfoDlg, self});
	table.insert(tbOpt, {"Lĩnh hiệp lữ tín vật", self.GetWeddingRing, self});
	table.insert(tbOpt, {"Hàn gắn quan hệ hiệp lữ", self.XiufuCoupleRelationDlg, self});
	table.insert(tbOpt, "Kết thúc đối thoại");
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:QueryWeddingInfoDlg()
	local szMsg = "Có thể kiểm tra tình hình cưới xin ở chỗ ta";
	local tbOpt = {
		{"Kiểm tra tình hình điển lễ", self.QueryMyWeddingInfo, self},
		{"Kiểm tra điển lễ của người khác", self.QueryOthersWeddingInfo, self},
		{"Kiểm tra ngày điển lễ", self.QuerySpedayWedingInfo, self},
		{"Trở về trang trước", self.OnDialog, self},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 查询自己的婚礼信息
function tbNpc:QueryMyWeddingInfo()
	Marry:QueryWedding(1, me.szName);
end

-- 查询他人的婚礼信息
function tbNpc:QueryOthersWeddingInfo()
	Dialog:AskString("Nhân vật của người chơi", 16, self.OnAcceptSpeMsg, self);
end

function tbNpc:OnAcceptSpeMsg(szPlayerName)
	local nLen = GetNameShowLen(szPlayerName);
	if nLen <= 0 or nLen > 32 then
		Dialog:Say("Nhập tên quá giới hạn, vui lòng thử lại.");
		return;
	end
	Marry:QueryWedding(1, szPlayerName);
end

-- 查找指定日期的婚礼信息
function tbNpc:QuerySpedayWedingInfo()
	local szMsg = "Bạn có thể chọn bạn muốn truy vấn ngày của các thông tin về buổi lễ vào những ngày sau đây.";
	local tbOpt = self:GetQueryDate();
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetQueryDate()
	local nCurTime = GetTime();
	local tbOpt = {};
	for i = 1, 7 do
		local nTime = nCurTime + i * 3600 * 24;
		local nDate = tonumber(os.date("%d%m%Y", nTime));
		local szDate = tostring(os.date("%d-%m-%Y", nTime));
		table.insert(tbOpt, {szDate, self.QueryByDate, self, nDate});
	end
	return tbOpt;
end

function tbNpc:QueryByDate(nDate)
	Marry:QueryWedding(2, nDate);
end

function tbNpc:CheckLevel(nLevel)
	if (not nLevel) then
		return 0;
	end
	if (nLevel < self.LEVEL_PINGMIN or nLevel > self.LEVEL_HUANGJIA) then
		return 0;
	end
	
	return 1;
end

--=====================================================================

function tbNpc:CanXiufuCoupleRelation()
	local szErrMsg = "";
	
	local bHasPreWedding, szCoupleName, nPreWeddingDate, nWeddingLevel = Marry:CheckPreWedding(me.szName);
	if (0 == bHasPreWedding) then
		szErrMsg = "Bạn đã không tổ chức buổi lễ, không có thể sửa chữa các mối quan hệ.";
		return 0, szErrMsg;
	end
	
	local tblMemberList, nMemberCount = me.GetTeamMemberList()
	if (nMemberCount ~= 2) then
		szErrMsg = "Sửa chữa quan hệ hiệp lữ cần có 2 người mới thực hiện được.";
		return 0, szErrMsg;
	end
	
	local cTeamMate = tblMemberList[1];
	for _, pPlayer in pairs(tblMemberList) do
		if (pPlayer.szName ~= me.szName) then
			cTeamMate = pPlayer;
			break;
		end
	end
	
	if (me.IsMarried() == 1 or cTeamMate.IsMarried() == 1) then
		szErrMsg = "Bạn đã có hiệp lữ, không thể sử dụng chức năng này";
		return 0, szErrMsg;
	end
	
	local bHasPreWedding, szCoupleName, nPreWeddingDate, nWeddingLevel = Marry:CheckPreWedding(me.szName);
	if (szCoupleName ~= cTeamMate.szName) then
		szErrMsg = "Đồng đội của bạn không phải là hiệp lữ của bạn.";
		return 0, szErrMsg;
	end
	
	local nCurDate = tonumber(os.date("%d%m%Y", GetTime()));
	local nCurHour = tonumber(os.date("%H", GetTime()));
	if (nCurDate <= nPreWeddingDate or (nCurDate == nPreWeddingDate + 1 and nCurHour < 7)) then
		szErrMsg = "Buổi lễ chưa kết thúc, thông qua quá trình bình thường của buổi lễ, không được sử dụng đạo cụ ở đây";
		return 0, szErrMsg;
	end
	
	return 1;
end

function tbNpc:XiufuCoupleRelationDlg()
	local bCanOpt, szErrMsg = self:CanXiufuCoupleRelation();
	if (0 == bCanOpt) then
		if (szErrMsg ~= "") then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local szMsg = "Nếu lễ theo lịch trình, nhưng đối với một số lý do không tham gia, dẫn đến không tham dự buổi lễ sau đó có thể sử dụng tùy chọn này để điền vào các mối quan hệ.";
	
	local tblMemberList, nMemberCount = me.GetTeamMemberList()
	if (nMemberCount ~= 2) then
		return 0;
	end

	local tbOpt = {
		{"Sửa chữa bây giờ", self.XiufuCoupleRelation, self, tblMemberList[1].szName, tblMemberList[2].szName},
		{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:XiufuCoupleRelation(szName1, szName2)
	local pMale = KPlayer.GetPlayerByName(szName1);
	local pFemale = KPlayer.GetPlayerByName(szName2);
	if (not pMale or not pFemale) then
		return 0;
	end
	if (pMale.nSex == 1) then
		pMale, pFemale = pFemale, pMale;
	end
	Relation:AddRelation_GS(pMale.szName, pFemale.szName, Player.emKPLAYERRELATION_TYPE_COUPLE, 1);
	pMale.Msg("Mối quan hệ của bạn đã được thay đổi, giờ bạn là hiệp khách lữ liễu.");
	pFemale.Msg("Mối quan hệ của bạn đã được thay đổi, giờ bạn là hiệp khách lữ liễu.");
	
	Marry:SetTitle(pMale, pFemale);
end

--=====================================================================

function tbNpc:GetWeddingRing()

	if (0 ~= me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDING_RING)) then
		Dialog:Say("Bạn đã nhận thưởng vật phẩm, không nên lặp đi lặp lại.");
		return 0;
	end
	
	local szCoupleName = me.GetCoupleName();
	if (not szCoupleName or szCoupleName == "") then
		Dialog:Say("Các ngươi chính trở thành hiệp lữ hậu trở lại lĩnh hiệp lữ tín vật ba.");
		return 0;
	end
	
	local nWeddingLevel = me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_WEDDING_LEVEL);
	if (nWeddingLevel <= 0 or nWeddingLevel > 4) then
		return 0;
	end
	
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hành trang của bạn không đủ chỗ trống, vui lòng dọn dẹp và thử lại.");
		return 0;
	end
	
	local pItem = me.AddItem(18, 1, 595, nWeddingLevel);
	if (pItem) then
		pItem.SetCustom(Item.CUSTOM_TYPE_EVENT, szCoupleName);
		me.SetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDING_RING, 1);
	end
end

function tbNpc:PreViewWeddingPlaceDlg()
	local tbNpc = Npc:GetClass("marry_yuelao2");
	tbNpc:OnDialog();
end

-- 前往指定地图参观婚礼场地
function tbNpc:PreViewWeddingPlace(nLevel)
	if (0 == self:CheckLevel(nLevel)) then
		return 0;
	end
	
	local tbMap = Marry.MAP_PREVIEW_INFO[nLevel];
	if tbMap then
		me.NewWorld(unpack(tbMap));
	end
end

function tbNpc:CheckWeddingCond(nLevel)
	if (0 == self:CheckLevel(nLevel)) then
		return 0;
	end
	
	local szErrMsg = "";
	local tblMemberList, nMemberCount = me.GetTeamMemberList()
	if (2 ~= nMemberCount) then
		szErrMsg = "Như vậy sự kiện, làm thế nào có thể một vấn đề tầm thường. Đàn ông và phụ nữ cả hai đội một lần nữa đặt phòng.";
		return 0, szErrMsg;
	end
	local cTeamMate	= tblMemberList[1];
	for i = 1, #tblMemberList do
		if (tblMemberList[i].szName ~= me.szName) then
			cTeamMate = tblMemberList[i];
		end
	end
	
	if (me.nLevel < self.MINLEVEL_APPWEDDING or
		cTeamMate.nLevel < self.MINLEVEL_APPWEDDING) then
		szErrMsg = string.format("Hai bên nam nữ cần đạt đẳng cấp <color=yellow>%s<color>.", self.MINLEVEL_APPWEDDING);
		return 0, szErrMsg;
	end
	
	if (me.nSex ~= 0 or cTeamMate.nSex ~= 1) then
		szErrMsg = "Bạn không thể đặt lễ, hãy gọi người nam đến";
		return 0, szErrMsg;
	end
	
	if (1 == me.IsMarried() or 1 == cTeamMate.IsMarried()) then
		szErrMsg = "Các ngươi đã có quan hệ hiệp lữ, không thể thực hiện.";
		return 0, szErrMsg;
	end
	
	local bIsNearby = 0;
	local tbPlayerList = KPlayer.GetAroundPlayerList(me.nId, 50);
	if (tbPlayerList) then
		for _, pPlayer in ipairs(tbPlayerList) do
			if (pPlayer.szName == cTeamMate.szName) then
				bIsNearby = 1;
			end
		end
	end
	if (0 == bIsNearby) then
		szErrMsg = "Người yêu của bạn xa như thế nào ?";
		return 0, szErrMsg;
	end
	
	local nReSelectTime = me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_TIME_RESELECTDATE);
	if (nReSelectTime > 0) then
		local nNeedMoney = self.MONEY_BASE * nReSelectTime;
		if (me.nCashMoney < nNeedMoney) then
			szErrMsg = string.format("Bạn đã thay đổi ngày kết hôn lần thứ <color=yellow>%s<color>, cần phải nộp phí làm thủ tục<color=yellow>%s<color>. lần sau mang đủ tiền đến nhé",
				nReSelectTime, nNeedMoney);
			return 0, szErrMsg;
		end
	end
	
	if Marry:CheckQiuhun(me, cTeamMate) ~= 1 then
		szErrMsg = "Mời bạn nạp cát cho người yêu trước rồi hãy đến tìm tôi. Một trong hai người đến cửa hàng hôn lễ mua túi Nạp Cát rồi sử dụng thẻ Nạp Cát trong đó";
		return 0, szErrMsg;
	end
	
	return 1;
end

function tbNpc:AppWeddingDlg()
	
	if me.nSex == 1 then
		Dialog:Say("Bên nam phải giữ lễ vật trước khi đặt hôn lễ.color=green>Nhắc nhở:\n1, Lễ vật hôn lễ có thể mua ở cửa hàng hôn lễ\n2, Bên nữ nếu mua nhầm vật phẩm hôn lễ có thể đổi thành hoa tình\n3, Có thể nâng cấp vật phẩm cao cấp hơn thay cho vật phẩm cấp thấp đã chọn lần trước<color>");
		return 0;
	end
	
	if (me.IsMarried() == 1) then
		Dialog:Say("Bạn đã có quan hệ hiệp lữ với người khác, không thể tiến hành thao tác vừa chọn");
		return 0;
	end
	
	local szMsg = "Xin mời bỏ ra các vật phẩm chưa sử dụng đến,bắt đầu đặt hôn lễ\n<color=green>Nhắc nhở\n1Vật phẩm có thể mua tại cửa hàng\n2Bên nữ nếu mua nhầm vật phẩm hôn lễ có thể đổi thành hoa tình\n3Có thể nâng cấp vật phẩm cao cấp hơn vật phẩm cấp thấp đã chọn lần trước\n<color>";
	local nReSelectTime = me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_TIME_RESELECTDATE);
	if (nReSelectTime > 0) then
		local nNeedMoney = self.MONEY_BASE * nReSelectTime;
		szMsg = szMsg .. string.format("\n<color=red>Chú ý:<color>Bạn đã thay đổi lựa chọn hôn lễ<color=yellow>%s<color>lần，cần phải mất phí <color=yellow>%s<color>đồng.",
			nReSelectTime, nNeedMoney);
	end
	
	local tbOpt = {
		{"Đặt quà điển lễ", self.GetLibao, self},
		{"Tôi cần suy nghĩ đã"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetLibao()
	Dialog:OpenGift("Xin bỏ Túi Quà Điển Lễ vào<color=green>\Có thể nâng cấp vật phẩm cao cấp thay cho vật phẩm cấp thấp đã chọn lần trước.Những vật phẩm đã sử dụng ở địa điểm hôn lễ không thể đặt hôn lễ được nữa", nil, {self.OnOpenGiftOk, self});
end

function tbNpc:ChechItem(tbItem)
	local bRighitItem = 0;
	for _, szGDPL in pairs(self.tbLibaoGDPL) do
		local szItem = string.format("%s-%s-%s-%s",tbItem[1].nGenre, tbItem[1].nDetail,
			tbItem[1].nParticular, tbItem[1].nLevel);
		if (szGDPL == szItem) then
			bRighitItem = 1;
			break;
		end
	end
	return bRighitItem;
end

function tbNpc:OnOpenGiftOk(tbItemObj)
	if (Lib:CountTB(tbItemObj) ~= 1) then
		Dialog:Say("Vật phẩm bạn bỏ ra không đúng, chỉ cần bạn bỏ ra một Túi Quà Điển Lễ là đủ");
		return 0;
	end
	
	local tbItem = tbItemObj[1];
	if (self:ChechItem(tbItem) == 0) then
		Dialog:Say("Bạn chưa bỏ ra Túi Quà Điển Lễ, xin mời xác nhận rồi đợi lần sau");
		return 0;
	end
	
	local pItem = tbItem[1];
	
	local tbQiuhunLibao = Item:GetClass("marry_xinhunlibao");
	if (tbQiuhunLibao:IsNewItem(pItem) ~= 1) then
		Dialog:Say("Túi Quà Điển Lễ này đã sử dụng rồi,không thể dùng đặt hôn lễ nữa");
		return 0;
	end

	local nWeddingLevel = pItem.nLevel;
	
	local nPreWeddingLevel = me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_WEDDING_LEVEL);
	if (pItem.nLevel < nPreWeddingLevel) then
		Dialog:Say("Không thể lựa chọn lại hôn lễ. Xin mời bỏ ra Túi Quà Điển Lễ đồng đẳng hoặc cao cấp hơn");
		return 0;
	end
	
	local bCanWedding, szErrMsg = self:CheckWeddingCond(nWeddingLevel);
	if (0 == bCanWedding) then
		if (szErrMsg and szErrMsg ~= "") then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local tblMemberList, nMemberCount = me.GetTeamMemberList()
	if (2 ~= nMemberCount) then
		return 0;
	end
	local cTeamMate	= tblMemberList[1];
	for i = 1, #tblMemberList do
		if (tblMemberList[i].szName ~= me.szName) then
			cTeamMate = tblMemberList[i];
		end
	end
	
	if (pItem.szCustomString and pItem.szCustomString ~= "" and
		cTeamMate.szName ~= pItem.szCustomString) then
		Dialog:Say(string.format("Túi Quà Điển Lễ này chỉ có thể dùng và <color=yellow>%s<color> để xác nhận và thay đổi ngày hôn lễ",
			pItem.szCustomString));
		return 0;
	end

	-- self:SelectDate(pItem, nWeddingLevel, nPlaceLevel);
	local szMsg = string.format("Bạn đồng ý dùng Túi Quà Điển Lễ này để đặt <color=yellow>%s<color> hôn lễ không ?",
		self.tbWeddingInfo[nWeddingLevel].szName);
	local tbOpt = {
		{"Tôi đồng ý", self.SureAppWedding, self, pItem.dwId},
		{"Tôi suy nghĩ đã"},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 是否确定要预定婚期
function tbNpc:SureAppWedding(dwItemId)
	local pItem = KItem.GetObjById(dwItemId);
	if (not pItem) then
		return;
	end
	local nWeddingLevel = pItem.nLevel;
	local szMsg = "Căn cứ vào cấp bậc Túi Quà của bạn, Bạn có thể lựa chọn các địa điểm tổ chức hôn lễ dưới đây";
	local tbOpt = {};
	for i = nWeddingLevel, self.LEVEL_PINGMIN, -1 do
		local szOpt = string.format("Lễ đường <color=yellow>%s<color>", self.tbWeddingInfo[i].szName);
		table.insert(tbOpt, {szOpt, self.SelectDate, self, dwItemId, i});
	end
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:SelectWeddingPlace(nWeddingLevel, nPlaceLevel)
	local szMsg = "Bỏ Túi Quà Điển Lễ vào, Ta sẽ sắp xếp lễ đường tương ứng cho ngươi.";
	local tbOpt = {
		{"Bỏ vào", self.GetLibao, self, nWeddingLevel, nPlaceLevel},
		{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetDateOpt(dwItemId, nPlaceLevel, nStartOrderTime)
	local tbOpt = {};
	local pItem = KItem.GetObjById(dwItemId);
	if (not pItem) then
		return;
	end
	local nWeddingLevel = pItem.nLevel;
	if (nWeddingLevel == self.LEVEL_HUANGJIA) then
		local nTuesdayTime = 0;
		local nTime = GetTime();
		if (nStartOrderTime) then
			nTime = nStartOrderTime;
		end
		for i = 1, 7 do
			nTime = nTime + 3600 * 24;
			local nWeekday = tonumber(os.date("%w", nTime));
			if (2 == nWeekday) then
				nTuesdayTime = nTime;
				break;
			end
		end
	
		local nStartTime = nTuesdayTime;
		local nEndTime = nTuesdayTime + 3600 * 24 * 6;
		for i = 1, 4 do
			local szStartDay = os.date("Ngày %d Tháng %m Năm %Y", nStartTime);
			local szEndDay = os.date("Ngày %d Tháng %m Năm %Y", nEndTime);
			local szOpt = string.format("<color=yellow>%s - %s<color>", szStartDay, szEndDay);
			local nDate = tonumber(os.date("%Y%m%d", nStartTime));
			if (Marry:CheckAddWedding(nWeddingLevel, nDate) == 1) then
				table.insert(tbOpt, {szOpt, self.GetDateOpt_HuangJia, self, dwItemId, nPlaceLevel, nStartTime});
			end
			
			nStartTime = nStartTime + 3600 * 24 * 7;
			nEndTime = nEndTime + 3600 * 24 * 7;
		end
	else
		local nTime = GetTime();
		if (nStartOrderTime) then
			nTime = nStartOrderTime;
		end
		for i = 1, 7 do
			nTime = nTime + 3600 * 24;
			local szDate = tostring(os.date("ngày %d tháng %m năm %Y ", nTime));
			local nDate = tonumber(os.date("%d%m%Y", nTime));
			if (Marry:CheckAddWedding(nWeddingLevel, nDate) == 1) then
				table.insert(tbOpt, {string.format("<color=yellow>%s<color>", szDate), self.SelectCertainDate, self, dwItemId, nPlaceLevel, nTime});
			end
		end
	end
	table.insert(tbOpt, {"Trở về", self.SureAppWedding, self, dwItemId});
	return tbOpt;
end

-- 皇家婚礼的再次选择日期选项（因为皇家婚礼的举办时间是一周只举行一次，需要再次确定是在那天举行婚礼）
function tbNpc:GetDateOpt_HuangJia(dwItemId, nPlaceLevel, nStartTime)
	local szMsg = "Xin mời lựa chọn ngày cử hành hôn lễ của bạn:";
	local tbOpt = {};
	for i = 0, 6 do
		local nTime = nStartTime + i * 3600 * 24;
		local szDate = tostring(os.date("ngày %d tháng %m năm %Y", nTime));
		local nDate = tonumber(os.date("%d %m %Y", nTime));
		table.insert(tbOpt, {string.format("<color=yellow>%s<color>", szDate), self.SelectCertainDate, self, dwItemId, nPlaceLevel, nTime});
	end
	table.insert(tbOpt, {"Trở về", self.SureAppWedding, self, dwItemId});
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:SelectDate(dwItemId, nPlaceLevel)
	local szMsg = "Xin mời lựa chọn ngày bạn thích dưới đây";
	local nStartOrderTime = Lib:GetDate2Time(Marry.START_TIME) - 3600 * 24;
	if GetTime() > nStartOrderTime then
		nStartOrderTime = GetTime();
	end
	local tbOpt = self:GetDateOpt(dwItemId, nPlaceLevel, nStartOrderTime);
	if (#tbOpt == 1) then
		szMsg = "Ngày này đã đủ hôn lễ,mời bạn chọn ngày khác";
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:CheckDate(nTime, nWeddingLevel)
	local szErrMsg = "";
	local nOk = Marry:CheckAddWedding(nWeddingLevel, nTime);
	if nOk ~= 1 then
		szErrMsg = "Ngày hôm này đã đủ hôn lễ, mời bạn chọn ngày khác";
		return 0, szErrMsg;
	end
	return 1;
end

function tbNpc:SelectCertainDate(dwItemId, nPlaceLevel, nTime)
	local nDate = tonumber(os.date("%d%m%Y", nTime));
	local pItem = KItem.GetObjById(dwItemId);
	if (not pItem) then
		return 0;
	end
	local bCanSelect, szErrMsg = self:CheckDate(nDate, pItem.nLevel);
	if (0 == bCanSelect) then
		if (szErrMsg ~= "") then
			Dialog:Say(szErrMsg,
				{{"Chọn lại ngày", self.SelectDate, self, dwItemId, nPlaceLevel},
				{"Kết thúc đối thoại"},}
				);
		end
		return 0;
	end
	
	local szDate = tostring(os.date("ngày %d tháng %m năm %Y", nTime));
	local szMsg = string.format("Bạn đã định ngày cử hành hôn lễ vào ngày: <color=yellow>%s<color>, Hãy xác nhận để ấn định ngày cử hành", szDate);
	local tbOpt = {
		{"Tôi đồng ý", self.SureSelectDate, self, dwItemId, nPlaceLevel, nTime},
		{"Tôi muốn chọn lại", self.SelectDate, self, dwItemId, nPlaceLevel},
		{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:SureSelectDate(dwItemId, nPlaceLevel, nTime)
	local pItem = KItem.GetObjById(dwItemId);
	--if (not pItem) then
	--	return 0;
	--end
	
	local nDate = tonumber(os.date("%d%m%Y", nTime));
	local nCurDate = tonumber(os.date("%d%m%Y", GetTime()));
	if (nDate <= nCurDate) then
		Dialog:Say("Ngày trước đó không thể đặt được.");
		return 0;
	end
	
	local tblMemberList, nMemberCount = me.GetTeamMemberList()
	if (2 ~= nMemberCount) then
		return 0;
	end
	
	local cTeamMate	= tblMemberList[1];
	for i = 1, #tblMemberList do
		if (tblMemberList[i].szName ~= me.szName) then
			cTeamMate = tblMemberList[i];
		end
	end
	
	-- 服务器增加预订婚礼
	local nWeddingLevel = pItem.nLevel;
	if Marry:CheckAddWedding(nWeddingLevel, nDate) ~= 1 then
		return 1;
	end
	
	Marry:AddWedding_GS(nWeddingLevel, nDate, {me.szName, cTeamMate.szName, nPlaceLevel}, dwItemId, nTime);
end
