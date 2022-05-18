-------------------------------------------------------
-- 文件名　：longwutaiye.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-11-16 14:21:55
-- 文件描述：修改原有逻辑结构
-------------------------------------------------------

local tbJie = Npc:GetClass("longwutaiye");

function tbJie:OnDialog()

	local szMsg = "Ta có thể giúp gì cho ngươi";
	local tbOpt = {};
	
	if (Youlongmibao.bOpen and Youlongmibao.bOpen == 1) then
		table.insert(tbOpt, {"Tạp hóa Nguyệt Ảnh Thạch", self.Challenge, self});
		table.insert(tbOpt, {"Tạp hóa Du Long", self.OpenYouLongShop, self});
	end
	
	if (Partner.bOpenPartner == 1) then
		table.insert(tbOpt, {"Du long là gì", self.OnSelectPartnerDesc, self});
		--table.insert(tbOpt, {"Đổi nguyên liệu đặc biệt", self.ChangePartnerMiJi, self});
		--table.insert(tbOpt, {"Mở khóa trang bị đồng hành", self.SplitPartnerJinghua, self});
	end	
	
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData >= SpecialEvent.SpringFrestival.HuaDengOpenTime and nData <= SpecialEvent.SpringFrestival.HuaDengCloseTime then	--活动期间内启动服务器		
		table.insert(tbOpt, 1, {"Dùng bộ sưu tập sách đổi lấy phần thưởng", SpecialEvent.SpringFrestival.GetAward, SpringFrestival});	
	end
	
	if Esport:CheckState(3) == 1 then
		table.insert(tbOpt, 1, {"Hoạt động năm mới", Esport.GetItemJinZhouBaoZu, Esport});
	end	
	
	local task_value = me.GetTask(1022,115);
	if task_value == 1 then
		table.insert(tbOpt, 1, {"Vào tàng kiếm sơn trang", self.Send2NewWorld, self});
		szMsg = string.format("%s：bạn đã đến，"..me.szName, him.szName);
	end;
	
	if (Partner.bOpenPartner == 1) then	
		local nPartnerDelState = Partner:GetDelState(me);
		if nPartnerDelState == 1 then
			table.insert(tbOpt, 4, {"Hủy quan hệ đồng hành", self.OnSelectPartnerDel, self, 1});
		else
			table.insert(tbOpt, 4, {"Khôi phục đồng hành", self.OnSelectPartnerDel, self, 0});
		end
		
		local nPartnerPeelState = Partner:GetPeelState(me);
		if nPartnerPeelState == 1 then
			table.insert(tbOpt, 5, {"Tái sinh đồng hành", self.OnSelectPartnerPeel, self, 1});
		else
			table.insert(tbOpt, 5, {"Thu hồi đồng hành tái sinh", self.OnSelectPartnerPeel, self, 0});
		end
	end

	table.insert(tbOpt, {"Ta Chỉ tình cờ đi qua"});

	Dialog:Say(szMsg, tbOpt);
end

function tbJie:Send2NewWorld()
	me.NewWorld(477,1631,3099);
	me.SetFightState(0);
end

function tbJie:OpenYouLongShop()
	me.OpenShop(167, 3);
end

function tbJie:Challenge()
	
	me.OpenShop(166, 3);
	do return end;
	
	Dialog:OpenGift("Hãy đặt nguyệt ảnh thạch vào", nil, {Youlongmibao.OnChallenge, Youlongmibao});
end

function tbJie:OnSelectPartnerDesc()
	Dialog:Say("    Để hiểu được hoạt động đồng hành vui lòng nhấn F12 để tìm hiểu");
end

function tbJie:OnSelectPartnerDel(nState)
	local szMsg = "";
	local tbOpt = {};
	
	if nState == 1 then
		if me.nPartnerCount == 0 then
			szMsg = "Bạn không có đồng hành";
			Dialog:Say(szMsg);
			return;
		end
	
		szMsg = string.format("Sau %d giờ sẽ thực hiện hủy bỏ đồng hành, bạn có chắc chắn ？", 
			Partner.DEL_USABLE_MINTIME/3600, Partner.DELLIMITSTARLEVEL);
		tbOpt =
		{
			{"Đồng ý", Partner.ApplyDelPartner, Partner, me.nId},
			{"Kết thúc đối thoại"},
		}
	else
		local nPeelTime = me.GetTask(Partner.TASK_DEL_PARTNER_GROUPID, Partner.TASK_DEL_PARTNER_SUBID);
		local nDiff = GetTime() - nPeelTime;
		
		if nDiff <= Partner.DEL_USABLE_MINTIME then	
			szMsg = string.format("Bạn đã gửi yêu cầu hủy bỏ，%0.1f giờ để thực hiện, bạn có chắc chắn ？", 
				(Partner.DEL_USABLE_MINTIME - nDiff)/3600);
		elseif nDiff >= Partner.DEL_USABLE_MAXTIME then
			me.Msg("Bạn gửi một yêu cầu loại bỏ đã hết hạn, xin vui lòng thử lại");
			return;
		else
			szMsg = string.format("Bạn gửi một ứng dụng đã bắt đầu có hiệu lực, bạn có thể  đồng hành %0.1f ! Bạn có muốn thu hồi?", 
				Partner.DELLIMITSTARLEVEL);
		end	
			
		tbOpt = 
		{
			{"Đồng ý", Partner.CancelDelPartner, Partner, me.nId},
			{"Kết thúc đối thoại"},
		}
	end
		
	Dialog:Say(szMsg, tbOpt);
end

function tbJie:OnSelectPartnerPeel(nState)
	local szMsg = "";
	local tbOpt = {};
	
	if nState == 1 then
		if me.nPartnerCount == 0 then
			szMsg = "Bạn không có đồng hành";
			Dialog:Say(szMsg);
			return;
		end
		
		szMsg = string.format("%d giờ,  sau khi nộp Bồ Đề quả tái sinh đồng hành % 0.1f, xác định tái sinh ?", 
			(Partner.PEEL_USABLE_MINTIME/3600), Partner.PEELLIMITSTARLEVEL);
		tbOpt =
		{
			{"Đồng ý", Partner.ApplyPeelPartner, Partner, me.nId},
			{"Kết thúc đối thoại"},
		}
	else
		local nPeelTime = me.GetTask(Partner.TASK_PEEL_PARTNER_GROUPID, Partner.TASK_PEEL_PARTNER_SUBID);
		local nDiff = GetTime() - nPeelTime;
		
		if nDiff <= Partner.PEEL_USABLE_MINTIME then	
			szMsg = string.format("Bạn đã gửi yêu cầu tái sinh đồng hành %0.1f nhưng bạn có thể quyết định hủy bỏ thao tác vừa chọn ？", 
				(Partner.PEEL_USABLE_MINTIME - nDiff)/3600);
		elseif nDiff >= Partner.PEEL_USABLE_MAXTIME then
			me.Msg("Yêu cầu của bạn đã quá hạn, vui lòng thử lại");
			return;
		else
			szMsg = string.format("Bạn đã gửi yêu cầu và bắt đầu có hiệu lực, bạn có thể sử dụng %0.1f đồng hành Bồ Đề trái cây tái sinh! Bạn có muốn thu hồi?",
				Partner.PEELLIMITSTARLEVEL);
		end	
			
		tbOpt = 
		{
			{"Đồng ý", Partner.CancelPeelPartner, Partner, me.nId},
			{"Kết thúc đối thoại"},
		}
	end
	
	Dialog:Say(szMsg, tbOpt);
end

--同伴特殊材料兑换同伴秘籍
function tbJie:ChangePartnerMiJi()
	local szMsg = "Dùng nguyên liệu đồng hành đặc biệt có thể trao đổi đồng hành(Khóa)：\n nguyên liệu sơ(khóa) đổi được <color=yellow>6 sao <color> cần <color=yellow>5<color> nguyên liệu đặc biệt \n nguyên liệu trung(Khóa) đổi được đồng hành <color=yellow> 6 sao và 6 sao rưỡi <color> cần <color=yellow>5<color> nguyên liệu đặc biệt \n Nguyên liệu đồng hành cao cấp <color=yellow> Đồng hành 8 sao hoặc hơn <color> cần <color=yellow>30<color> nguyên liệu，ngươi muốn trao đổi gì nào ？";
	local tbOpt = 
	{
		{"Ta muốn đổi đồng hành sơ", self.ChangePartnerMiJExi, self, 1},
		{"Ta muốn đổi đồng hành trung", self.ChangePartnerMiJExi, self, 2},
		{"Ta muốn đổi đồng hành cao", self.ChangePartnerMiJExi, self, 3},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbJie:ChangePartnerMiJExi(nLevel)
	local tbType = {1, 5, 30} --三个级别兑换的个数
	local szContent = string.format("Hãy đặt vào <color=yellow>%s<color> nguyên liệu đặc biệt", tbType[nLevel]);
	Dialog:OpenGift(szContent, nil, {tbJie.OnOpenGiftOk, tbJie, nLevel});
end

function tbJie:OnOpenGiftOk(nLevel, tbItemObj)
	local tbType = {1, 5, 30} --三个级别兑换的个数
	local szPartnerCaiLiao = "18,1,556,1"; 	--同伴特殊材料的gdpl
	--数量判断
	local nCount = 0;
	for i = 1, #tbItemObj do
		nCount = nCount + tbItemObj[i][1].nCount;
	end
	if nCount ~= tbType[nLevel] then
		Dialog:Say("Số lượng không đủ", {"Ta biết rồi"});
		return 0;
	end
	--物品判定
	for i = 1, #tbItemObj do
		local pItem = tbItemObj[i][1];
		local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel);
		if szKey ~= szPartnerCaiLiao then
			Dialog:Say("Loại nguyên liệu không đúng", {"Ta biết rồi"});
			return 0;
		end
	end
	--背包判定
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang đã đầy, hãy thu xếp rồi nhận lại",{"Ta biết rồi"});
		return 0;
	end
	--删除交的东西
	for i = 1, #tbItemObj do
		local pItem = tbItemObj[i][1];
		pItem.Delete(me);
	end
	local pItemEx = me.AddItem(18, 1, 554, nLevel);
	if pItemEx then
		pItemEx.Bind(1);
		me.SetItemTimeout(pItemEx, 60*24*30, 0);
		EventManager:WriteLog(string.format("[兑换同伴秘籍]获得物品:%s",pItemEx.szName), me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[兑换同伴秘籍]获得物品:%s",pItemEx.szName));
	else
		EventManager:WriteLog(string.format("[兑换同伴秘籍]获得失败，扣除材料%s个",nCount), me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[兑换同伴秘籍]获得失败，扣除材料%s个",nCount));		
	end
end

-- by zhangjinpin@kingsoft
function tbJie:SplitPartnerJinghua()
	local szMsg = "Ở đây bạn có thể dùng <color=yellow> Đồng hành（4 kỹ năng）<color> tách thành <color=yellow> Đồng hành（3 kỹ năng）<color>";
	szMsg = szMsg .. "<color=green>（1 nguyên liệu cao cấp，có thể tách thành 10 nguyên liệu bạch kim）<color>";
	Dialog:OpenGift(szMsg, nil, {tbJie.OnSplitPartnerJinghua, tbJie});
end

function tbJie:OnSplitPartnerJinghua(tbItem)
	
	local tbItemIdIn = {18, 1, 565, 4};
	local tbItemIdOut = {18, 1, 565, 3};
	
	local nExCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		if szKey == string.format("%s,%s,%s,%s", unpack(tbItemIdIn)) then
			nExCount = nExCount + pItem.nCount;
		end
	end
	
	if nExCount <= 0 then
		Dialog:Say("Xin vui lòng đặt vào đúng số lượng yêu cầu");
		return 0;
	end
	
	local nNeed = KItem.GetNeedFreeBag(tbItemIdOut[1], tbItemIdOut[2], tbItemIdOut[3], tbItemIdOut[4], nil, nExCount * 10);
	if me.CountFreeBagCell() < nNeed then
		Dialog:Say(string.format("Hãy thu xếp hành trang đủ %s ô rồi thử lại", nNeed));
		return 0;
	end
	
	local nExTempCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		if szKey == string.format("%s,%s,%s,%s", unpack(tbItemIdIn)) then
			me.DelItem(pItem);
			nExTempCount = nExTempCount + pItem.nCount;
		end
		if nExTempCount >= nExCount then
			break;
		end
	end
	
	me.AddStackItem(tbItemIdOut[1], tbItemIdOut[2], tbItemIdOut[3], tbItemIdOut[4], nil, nExCount * 10);
end
