-- 文件名　：playercallback.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-03-06 15:01:02
-- 描述　  ：玩家召回活动

EventManager.ExEvent = EventManager.ExEvent or {};
EventManager.ExEvent.tbPlayerCallBack = EventManager.ExEvent.tbPlayerCallBack or {};
local tbPlayerCallBack = EventManager.ExEvent.tbPlayerCallBack;

tbPlayerCallBack.DEF_PATCH 					= 0;					--批次,从0批开始,重开改批次				

tbPlayerCallBack.TASK_GROUP_OLDPLAYER 		= 2082;
tbPlayerCallBack.TASK_OLDPLAYER_HASHID 		= {9, 10, 11, 12, 13};	-- 接受常在线玩家祝福的老玩家hashID
tbPlayerCallBack.TASK_ID_GETBLESSING_COUNT 	= 14;					-- 老玩家接受祝福的次数
tbPlayerCallBack.TASK_AWARD1 				= 19;					-- 领取礼包
tbPlayerCallBack.TASK_AWARD2 				= 20;					-- 领取礼包
tbPlayerCallBack.TASK_AWARD3 				= 21;					-- 领取礼包
tbPlayerCallBack.TASK_AWARD4 				= 22;					-- 领取礼包
tbPlayerCallBack.TASK_AWARD5 				= 23;					-- 领取礼包
tbPlayerCallBack.TASK_AWARD6 				= 24;					-- 领取礼包
tbPlayerCallBack.TASK_TITLE 				= 25;					-- 给与玩家江湖前辈称号标志
tbPlayerCallBack.TASK_PATCH 				= 26;					-- 记录批次,批次不同,清空变量

tbPlayerCallBack.MAX_SENDBLESSING_COUNT 	= 5;					-- 在线玩家可以最多可以送出祝福的次数
tbPlayerCallBack.MAX_GETBLESSING_COUNT 		= 10;					-- 老玩家最多可以接受的祝福次数
tbPlayerCallBack.DEF_OLDPLAYER_ITEM 		= {18,1,114,7};			-- 老玩家奖励物品（一个有效期1个月的绑定7玄）
tbPlayerCallBack.DEF_OLDPLAYER_TITLE 		= {5,3,1,0};			-- 江湖前辈称号
tbPlayerCallBack.MAX_LEAVE_DAY				= 90;					-- 最多计算离开90天

tbPlayerCallBack.nOpen						= tbPlayerCallBack.nOpen  or 0;					-- 活动开关
tbPlayerCallBack.tbLogTime  				= {year=2009,month=2,day=20,hour=0,min=0,sec=0};	--标记时间
tbPlayerCallBack.tbLogStartTime 			= {year=2009,month=3,day=17,hour=0,min=0,sec=0};	--活动开始时间
tbPlayerCallBack.tbLogEndTime 				= {year=2009,month=3,day=20,hour=0,min=0,sec=0};	--计算离开天数的截止日期
tbPlayerCallBack.LEAGUETYPE_CALLBACK		= 6;
tbPlayerCallBack.TSKGROUP_CALLBACK			= 2082;
tbPlayerCallBack.TSKID_OLDPLAYERFLAG		= 6;	-- 标记是否是老玩家
tbPlayerCallBack.TSKID_ISRELATION			= 17;	-- 是否已经有召回关系了
tbPlayerCallBack.TSKID_RELATIONCREATETIME	= 18;	-- 创建关系的时间
tbPlayerCallBack.ITEM_AWARD1				= {
	{tbItem = {18,1,286,7}, nCount = 1, nBind = 1, nTime = 30},--7级玄晶*10
	{tbItem = {18,1,303,1}, nCount = 1, nBind = 1, nTime = 30},--黄金福袋*50
	{tbItem = {18,1,251,1}, nCount = 2, nBind = 1, nTime = 30},--秘境地图*2
	{tbItem = {18,1,299,1}, nCount = 1, nBind = 1, nTime = 30},--门派竞技高级令牌*10
	{tbItem = {18,1,304,1}, nCount = 1, nBind = 1, nTime = 30},--白虎堂高级令牌*10
	{tbItem = {18,1,300,1}, nCount = 1, nBind = 1, nTime = 30},--家族令牌（高级）*10
	{tbItem = {18,1,301,1}, nCount = 1, nBind = 1, nTime = 30},--义军令牌*20
	{tbItem = {18,1,302,1}, nCount = 1, nBind = 1, nTime = 30},--战场令牌（凤翔）*20
};

tbPlayerCallBack.DEF_DIS					= 50;

--开启开关，返回值1为开启，其他为关闭；
--IsOpen()  是否开启
--IsOpen(1) 是否是老玩家
--IsOpen(2) 是否开启并且是老玩家且在老玩家第一次上线7天内
--IsOpen(3) 是否开启并且是老玩家
--IsOpen(4) 礼官处选项的存在时间

function tbPlayerCallBack:IsOpen(pPlayer, nType)
	if EventManager.IVER_bOpenPlayerCallBack  == 0 then
		do return 0 end	-- 马来关闭老玩家回归功能
	end
	
	Setting:SetGlobalObj(pPlayer);
	local nLogNowTime  = pPlayer.GetTask(Player.COMEBACK_TSKGROUPID, Player.COMEBACK_TSKID_NOWTIME);
	local nLogLastTime = pPlayer.GetTask(Player.COMEBACK_TSKGROUPID, Player.COMEBACK_TSKID_LASTTIME);
	local nLimitTime   = os.time(self.tbLogTime);	
	local nStartTime   = os.time(self.tbLogStartTime);
	local nReturn = 0;
	if not nType then
		nReturn = self.nOpen;
	elseif nType == 1 then
		--if self.nOpen == 1 then 
			nReturn = self:CheckPlayer();
		--end
	elseif nType == 2 then
		if self.nOpen == 1 and self:CheckPlayer() == 1 then
			local nCurStartTime = nLogNowTime;
			if nLogNowTime > 0 and nLogNowTime < nStartTime then
				nCurStartTime = nStartTime;
			end
			if nCurStartTime > 0 then
				if nCurStartTime + 7 * 24 * 3600 >= GetTime() then
					nReturn = 1;
				end
			end
		end
	elseif nType == 3 then
		if self.nOpen == 1 then 
			nReturn = self:CheckPlayer();
		end	
	elseif nType == 4 then
		local nDate = tonumber(GetLocalDate("%Y%m%d"));
		if nDate >= 20090317 and nDate < 20090801 then
			nReturn = 1;
		end
	end
	
	Setting:RestoreGlobalObj();
	return nReturn;
end

--检查可参加召回活动类型接口
function tbPlayerCallBack:CheckPlayer()
	if EventManager.IVER_bOpenPlayerCallBack  == 0 then
		do return -1 end
	end
	
	if self:IsCallBackPlayer(me) == 1 then
		return 1;
	end
	return 0;
end

--获得老玩家离开天数
function tbPlayerCallBack:GetLeaveDay(pPlayer)
	if self:IsOpen(pPlayer, 1) == 0 then
		return 0;
	end
	local nLogNowTime  = pPlayer.GetTask(Player.COMEBACK_TSKGROUPID, Player.COMEBACK_TSKID_NOWTIME);
	local nLogLastTime = pPlayer.GetTask(Player.COMEBACK_TSKGROUPID, Player.COMEBACK_TSKID_LASTTIME);
	local nLimitTime   = os.time(self.tbLogTime);	
	local nStartTime   = os.time(self.tbLogStartTime);
	local nEndTime	   = os.time(self.tbLogEndTime);
	
	local nCurStartTime = nLogNowTime;
	if nLogNowTime > nEndTime then
		nCurStartTime = nEndTime;
	end
	
	if nCurStartTime < nStartTime then
		nCurStartTime = nStartTime;
	end
	local nLeaveDay = math.floor((nCurStartTime - nLogLastTime)/ (24 * 3600));
	if nLeaveDay > self.MAX_LEAVE_DAY then
		nLeaveDay = self.MAX_LEAVE_DAY;
	end
	return nLeaveDay;
end

function tbPlayerCallBack:OnDialog()
	local szMsg = "Đã bắt đầu kêu gọi người chơi cũ, kêu gọi bạn cũ có thể nhận được phần thưởng hậu hĩnh";
	local tbOpt = {
			{"Nhận hoàn trả đồng khóa", self.OnDialog_BandCoinBack, self},
			{"Ta chỉ đến xem"},
		};
	if self:IsOpen(me) == 1 then
		table.insert(tbOpt, 1, {"Khóa quan hệ mời bạn cũ ", self.OnDialog_CallBackFriend, self});
		table.insert(tbOpt, 1, {"Lời chào đón của bạn cũ", self.OnDialog_ZhuFu, self});
		table.insert(tbOpt, 1, {"Nhận Túi quà tái xuất giang hồ", self.OnDialog_Gift, self});
	end
		
	Dialog:Say(szMsg, tbOpt);
end

--六重大礼
function tbPlayerCallBack:OnDialog_Gift()
	if self:IsOpen(me, 1) ~= 1 then
		Dialog:Say("Bạn không phải người chơi cũ, không được nhận túi quà. ");
		return 0;
	end
	local szMsg = "Có 6 phần thưởng lớn dành cho người chơi cũ online, bạn chọn túi quà nào?";
	local tbOpt = {
		{"Nhận Túi quà tái xuất giang hồ", self.Gift_GetAward1, self},
		{"Nhận cơ hội mở Túi Phúc Hoàng Kim", self.Gift_GetAward2, self},
		{"Nhận cơ hội dùng Tiểu Tinh Hoạt Khí Tán", self.Gift_GetAward3, self},
		{"Nhận thêm cơ hội chúc phúc", self.Gift_GetAward4, self},
		{"Nhận giảm 20% phí cường hóa", self.Gift_GetAward5, self},
		{"Nhận ưu đãi hoàn trả đồng tiêu phí tại Kỳ Trân Các", self.Gift_GetAward6, self},
		{"Để ta xem lại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

--7级玄晶*10；黄金福袋*50；秘境地图*2；门派竞技高级令牌*10；白虎堂高级令牌*10；家族令牌（高级）*10；义军令牌*20；战场令牌（凤翔）*20；
function tbPlayerCallBack:Gift_GetAward1(nFlag)
	
	
	if not nFlag then
		local szMsg = "Túi quà Thu Di nhờ đem cho hiệp khách tái xuất giang hồ có: Huyền tinh cấp 7*10; Túi Phúc Hoàng Kim*50; Bản đồ bí cảnh*2; lệnh bài cao cấp thi đấu môn phái*10; lệnh bài cao cấp Bạch Hổ Đường*10; Lệnh Bài Gia Tộc (cao cấp)*10; Lệnh Bài Nghĩa Quân*20; lệnh bài chiến trường (Phượng Tường)*20; bạn có nhận ngay?";
		local tbOpt = {
			{"Ta muốn nhận ngay túi quà", self.Gift_GetAward1, self, 1},
			{"Ta chỉ đến xem"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD1) >= 1 then
		Dialog:Say("Bạn đã nhận Túi quà tái xuất giang hồ");
		return 0;
	end
	
	local nCount = 0;
	for _, tbItem in pairs(self.ITEM_AWARD1) do
		nCount = nCount + tbItem.nCount;
	end
	if me.CountFreeBagCell() < nCount then
		Dialog:Say(string.format("Túi của bạn không đủ, cần <color=yellow>%s<color> ô trống.", nCount));
		return 0;
	end
	for _, tbItem in pairs(self.ITEM_AWARD1) do
		for i=1, tbItem.nCount do
			local pItem = me.AddItem(unpack(tbItem.tbItem));
			if pItem then
				if tbItem.nBind then
					pItem.Bind(tbItem.nBind);
				end
				if tbItem.nTime then
					me.SetItemTimeout(pItem, tbItem.nTime*24*60, 0)
					--pItem.SetTimeOut(0, GetTime()+ tbItem.nTime*24*3600 );
					pItem.Sync();
				end
			end
		end
	end
	me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD1, 1);
	Dbg:WriteLog("tbPlayerCallBack", me.szName.."Nhận túi quà kêu gọi người chơi cũ: ", self.TASK_AWARD1);
	Dialog:Say(string.format("Nhận Túi quà tái xuất giang hồ thành công."));
end

function tbPlayerCallBack:Gift_GetAward2(nFlag)
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD2) > 0 then
		Dialog:Say("Bạn đã nhận thêm cơ hội mở Túi phúc.");
		return 0;
	end
	local nCount = self:GetLeaveDay(me) * 10;
	if not nFlag then
		local szMsg = string.format("Bạn có thể nhận thêm <color=yellow>%s<color> lần cơ hội mở Túi phúc.", nCount);
		local tbOpt = {
			{"Ta muốn nhận", self.Gift_GetAward2, self, 1},
			{"Ta chỉ đến xem"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	me.SetTask(2013,4, me.GetTask(2013,4) + nCount);
	me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD2, 1)
	Dbg:WriteLog("tbPlayerCallBack", me.szName.."Nhận túi quà kêu gọi người chơi cũ: ", self.TASK_AWARD2);	
	Dialog:Say("Nhận thêm cơ hội mở Túi phúc.");
end

function tbPlayerCallBack:Gift_GetAward3(nFlag)
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD3) > 0 then
		Dialog:Say("Bạn đã nhận thêm cơ hội sử dụng Tiểu Tinh Hoạt Khí Tán.");
		return 0;
	end
	local nCount = self:GetLeaveDay(me) * 5;
	if not nFlag then
		local szMsg = string.format("Nhận được <color=yellow>%s<color> lần sử dụng Tinh Khí Tán (nhỏ) và <color=yellow>%s<color> lần sử dụng Hoạt Khí Tán.", nCount, nCount);
		local tbOpt = {
			{"Ta muốn nhận", self.Gift_GetAward3, self, 1},
			{"Ta chỉ đến xem"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	me.SetTask(2024,20, me.GetTask(2024,20) + nCount);
	me.SetTask(2024,21, me.GetTask(2024,21) + nCount);
	me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD3, 1);
	Dbg:WriteLog("tbPlayerCallBack", me.szName.."Nhận túi quà kêu gọi người chơi cũ: ", self.TASK_AWARD3);	
	Dialog:Say("Nhận thêm cơ hội sử dụng Tiểu Tinh Hoạt Khí Tán.");	
end

function tbPlayerCallBack:Gift_GetAward4(nFlag)
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD4) > 0 then
		Dialog:Say("Bạn đã nhận thêm cơ hội chúc phúc.");
		return 0;
	end
	local nCount = self:GetLeaveDay(me) * 1;
	if not nFlag then
		local szMsg = string.format("Bạn có thể nhận thêm <color=yellow>%s<color> cơ hội chúc phúc. ", nCount);
		local tbOpt = {
			{"Ta muốn nhận", self.Gift_GetAward4, self, 1},
			{"Ta chỉ đến xem"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	Task.tbPlayerPray:AddCountByLingPai(me, nCount);
	me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD4, 1);
	Dbg:WriteLog("tbPlayerCallBack", me.szName.."Nhận túi quà kêu gọi người chơi cũ: ", self.TASK_AWARD4);		
	Dialog:Say("Nhận thêm cơ hội chúc phúc.");		
end

function tbPlayerCallBack:Gift_GetAward5(nFlag)
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD5) > 0 then
		Dialog:Say("Bạn đã nhận chúc phúc giảm 20% phí cường hóa.");
		return 0;
	end
	if me.GetSkillState(892) > 0 then
		Dialog:Say("Bạn đã có chúc phúc giảm 20% phí cường hóa, không thể nhận tiếp.");	
		return 0;
	end
	if not nFlag then
		local szMsg = string.format("Bạn nhận chúc phúc giảm 20% phí cường hóa.");
		local tbOpt = {
			{"Ta muốn nhận", self.Gift_GetAward5, self, 1},
			{"Ta chỉ đến xem"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local nTime = 7 * 24 * 3600;
	me.AddSkillState(892, 1, 2, nTime*18, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD5, 1);
	Dbg:WriteLog("tbPlayerCallBack", me.szName.."Nhận túi quà kêu gọi người chơi cũ: ", self.TASK_AWARD5);	
	Dialog:Say("Nhận lời chúc giảm 20% phí cường hóa thành công.");	
end

function tbPlayerCallBack:Gift_GetAward6(nFlag)
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD6) > 0 then
		Dialog:Say("Bạn đã nhận ưu đãi dùng đủ 500 đồng tại Kỳ Trân Các được tặng 100 đồng khóa.");
		return 0;
	end
	if me.GetSkillState(1336) > 0 then
		Dialog:Say("Bạn đã có lời chúc ưu đãi dùng đủ 500 đồng tại Kỳ Trân Các được tặng 100 đồng khóa, không thể nhận tiếp.");	
		return 0;
	end	
	local nCount = self:GetLeaveDay(me) * 1;
	if not nFlag then
		local szMsg = string.format("Bạn có thể nhận được ưu đãi dùng đủ 500 đồng tại Kỳ Trân Các được tặng 100 đồng khóa.", nCount);
		local tbOpt = {
			{"Ta muốn nhận", self.Gift_GetAward6, self, 1},
			{"Ta chỉ đến xem"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local nTime = 7 * 24 * 3600;
	me.AddSkillState(1336, 1, 2, nTime*18, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_AWARD6, 1);
	Dbg:WriteLog("tbPlayerCallBack", me.szName.."Nhận túi quà kêu gọi người chơi cũ: ", self.TASK_AWARD6);	
	Dialog:Say("Nhận chúc ưu đãi dùng đủ 500 đồng tại Kỳ Trân Các tặng 100 đồng khóa.");	
end

function tbPlayerCallBack:OnDialog_ZhuFu()
	local pPlayer = me;
	local bIsOldPlayer = self:IsOpen(pPlayer, 1);
	if (1 == bIsOldPlayer) then
		Dialog:Say("Người chơi cũ không thể chúc phúc. Trong thời hạn kêu gọi người chơi cũ, chỉ người chơi thường online được chúc người chơi cũ.");
		return 0;
	end
	local tbPlayerInfo, nCount = pPlayer.GetTeamMemberList();
	if (not tbPlayerInfo or 2 ~= nCount) then
		Dialog:Say("Bạn không trong nhóm hoặc không là nhóm 2 người, hãy xác nhận nhóm 2 người trước.");
		return 0;
	end
	local nPlayerId = tbPlayerInfo[1].nId;
	if (nPlayerId == pPlayer.nId) then
		nPlayerId = tbPlayerInfo[2].nId;
	end
	local pOldPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	

	local bIsTeamMemOldPlayer = self:IsOpen(pOldPlayer, 1);
	if (0 == bIsTeamMemOldPlayer) then
		Dialog:Say("Đồng đội của bạn không phải là người chơi cũ, không thể nhận lời chúc. Trong thời hạn kêu gọi người chơi cũ, chỉ có người chơi cũ mới có thể nhận chúc phúc của người chơi thường online.");
		return 0;
	end
	local nFavorLevel = pPlayer.GetFriendFavorLevel(pOldPlayer.szName);
	if (nFavorLevel < 2) then
		Dialog:Say("Độ thân mật dưới cấp 2, không chúc được.");
		return 0;
	end
	local nHashNameId_OldPlayer = KLib.Number2UInt(tonumber(KLib.String2Id(pOldPlayer.szName)));
	local nRUseTaskCount_OldPlayer= 0;
	local nUseTaskId_OldPlayer = 0;
	for nId, nTaskId in ipairs(self.TASK_OLDPLAYER_HASHID) do
		if tonumber(nTaskId) > 0 then
			if KLib.Number2UInt(pPlayer.GetTask(self.TASK_GROUP_OLDPLAYER, tonumber(nTaskId))) == nHashNameId_OldPlayer then
				Dialog:Say("Bạn đã chúc người chơi này rồi.");
				return 0;
			end
			
			if nUseTaskId_OldPlayer == 0 and KLib.Number2UInt(pPlayer.GetTask(self.TASK_GROUP_OLDPLAYER, tonumber(nTaskId))) == 0 then
				nUseTaskId_OldPlayer = tonumber(nTaskId);
				nRUseTaskCount_OldPlayer = nId;
			end
		end
	end
	
	if (nRUseTaskCount_OldPlayer == 0) then
		Dialog:Say("Bạn đã gửi <color=yellow>" .. self.MAX_SENDBLESSING_COUNT .. "<color> lời chúc, không thể gửi thêm nữa.");
		return 0;
	end
	
	
	local nGetBlessingCount = pOldPlayer.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_ID_GETBLESSING_COUNT);
	if (nGetBlessingCount >= self.MAX_GETBLESSING_COUNT) then
		Dialog:Say("Người chơi này đã nhận <color=yellow>" .. self.MAX_GETBLESSING_COUNT .. "<color> lời chúc, không thể nhận thêm nữa.");
		return 0;
	end
	
	
	--判断背包空间
	local nFreeCount = 1;
	if pPlayer.CountFreeBagCell() < nFreeCount then
		pPlayer.Msg(string.format("Xin lỗi, túi của bạn không đủ chỗ, cần <color=yellow>%s<color> ô trống. ", nFreeCount));
		return 0;
	end
	
	local pItem = pPlayer.AddItem(unpack(self.DEF_OLDPLAYER_ITEM));
	if (pItem) then
		pItem.Bind(1);
		pPlayer.SetItemTimeout(pItem, 30*24*60, 0)
		EventManager:WriteLog(string.format("Nhận được %s", pItem.szName), pPlayer);
	end
	pPlayer.Msg("Bạn đã gửi lời chúc cho <color=yellow>" .. pOldPlayer.szName .. "<color>.");
	
	pOldPlayer.AddSkillState(385, 7, 2, 2 * 60 * 60 * Env.GAME_FPS, 1, 0, 1);	--增加技能状态
	pOldPlayer.AddSkillState(386, 7, 2, 2 * 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	pOldPlayer.AddSkillState(387, 7, 2, 2 * 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	pOldPlayer.AddSkillState(880, 4, 2, 2 * 60 * 60 * Env.GAME_FPS, 1, 0, 1);	--幸运值880, 4级30点,，打怪经验879, 8级（110％）
	pOldPlayer.AddSkillState(879, 8, 2, 2 * 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	pOldPlayer.Msg("Bạn nhận được lời chúc của <color=yellow>" .. pPlayer.szName .. "<color>.");
	EventManager:WriteLog("Nhận buff chúc phúc", pOldPlayer);
	--Setting:RestoreGlobalObj();
	
	pPlayer.SetTask(self.TASK_GROUP_OLDPLAYER, nUseTaskId_OldPlayer, nHashNameId_OldPlayer);
	pOldPlayer.SetTask(tbPlayerCallBack.TASK_GROUP_OLDPLAYER, tbPlayerCallBack.TASK_ID_GETBLESSING_COUNT, nGetBlessingCount + 1);
end

function tbPlayerCallBack:OnDialog_CallBackFriend()
	local pMe = me;
	-- 活动结束或者没开始
	if (self:IsOpen(pMe) == 0) then
		return;
	end
	
	local ok, msg, tbOpt, pFriend = self:OldPlayer_CheckOldPlayerFriend(pMe);
	if (ok == 1 and pFriend == nil) then
		return
	end

	Setting:SetGlobalObj(pMe);
	if (0 == ok) then
		Dialog:Say(msg, tbOpt);	
	elseif (ok == 1) then
		Dialog:Say("Bạn muốn cùng hảo hữu <color=green>" .. pFriend.szName .. "<color> tạo quan hệ mời?",
			{ 
				{"Đúng, ta đồng ý", self.OnDialog_SureCallBack, self, msg, tbOpt, pMe.nId, pFriend.nId},
				{"Ta đang suy nghĩ"},
			});
	end
	Setting:RestoreGlobalObj();
end

function tbPlayerCallBack:OnDialog_SureCallBack(msg, tbOpt, nMeId, nFriendId)
	local pFriend = KPlayer.GetPlayerObjById(nFriendId);
	local pMe	= KPlayer.GetPlayerObjById(nMeId);

	if (not pFriend) then
		if (pMe) then
			pMe.Msg("Người bạn cũ có quan hệ mời đã rời mạng! ");
		end
		return;
	end
	
	if (not pMe) then
		return;
	end
	
	Setting:SetGlobalObj(pFriend);
	Dialog:Say(pMe.szName .. " sắp tạo quan hệ mời với bạn, quan hệ mời đã tạo không thể xóa, bạn chắc chắn?",
		{
			{"Ta đồng ý", self.MakeCallBackRelation, self, msg, tbOpt, nMeId, nFriendId},
			{"Ta đang suy nghĩ", self.NotMakeCallBackRelation, self, nMeId, nFriendId},	
		});
	Setting:RestoreGlobalObj();

	Setting:SetGlobalObj(pMe);
	Dialog:Say("Hãy đợi hảo hữu xác nhận!")
	Setting:RestoreGlobalObj();
end

function tbPlayerCallBack:NotMakeCallBackRelation(nMeId, nFriendId)
	local pFriend = KPlayer.GetPlayerObjById(nFriendId);
	local pMe	= KPlayer.GetPlayerObjById(nMeId);
	if (pMe) then
		Setting:SetGlobalObj(pMe);
		Dialog:Say("Đồng đội không muốn tạo quan hệ mời! ");
		Setting:RestoreGlobalObj();
		return;
	end
end

function tbPlayerCallBack:MakeCallBackRelation(szMsg, tbMsgOpt, nMeId, nFriendId)
	local pFriend = KPlayer.GetPlayerObjById(nFriendId);
	local pMe	= KPlayer.GetPlayerObjById(nMeId);
	if (not pFriend) then
		if (pMe) then
			pMe.Msg("Người bạn cũ có quan hệ mời đã rời mạng! ");
		end
		return;
	end
	
	if (not pMe) then
		if (pFriend) then
			pFriend.Msg("Hiệp khách có quan hệ mời đã rời mạng! ");
		end
		return;
	end
	
	local ok, msg, tbOpt, pPlayer = self:OldPlayer_CheckOldPlayerFriend(pMe);
	Setting:SetGlobalObj(pMe);
	if (ok == 1 and pPlayer == nil) then
		self:WriteLog("MakeCallBackRelation", pMe.szName .. "Không tìm đồng đội, không thể nào, có vấn đề");
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	if (ok == 0) then
		Dialog:Say(msg, tbOpt);
		self:WriteLog("MakeCallBackRelation", pMe.szName .. "Xem xét khả năng tạo quan hệ mời thất bại:" .. msg);
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	if (pPlayer.szName ~= pFriend.szName) then
		self:WriteLog("MakeCallBackRelation", "Khi xem xét lại, hai tên của người chơi gọi lại không giống nhau! ", pPlayer.szName, pFriend.szName);
		Setting:RestoreGlobalObj();
		return 0;
	end
	local szLeagueName		= pMe.szName;
	local szLeagueMember	= pFriend.szName;
	local pLeague			= League:FindLeague(self.LEAGUETYPE_CALLBACK, szLeagueName);
	if (pLeague) then
		if (1 == League:AddMember(self.LEAGUETYPE_CALLBACK, szLeagueName, szLeagueMember)) then
			self:SetCallBackRelationFlag(pFriend, 1);
			self:SetCallBackRelationTime(pFriend, GetTime());
			Dialog:Say(szMsg, tbMsgOpt);
			pFriend.Msg("Đã tạo quan hệ mời với đồng đội ");
			self:WriteLog("MakeCallBackRelation", "Cho người chơi [" .. szLeagueMember .. "] gia nhập người chơi [" .. szLeagueName .. "] thành công!");
		else
			self:WriteLog("MakeCallBackRelation", "1", "Cho người chơi [" .. szLeagueMember .. "] gia nhập người chơi [" .. szLeagueName .. "] thất bại!");
		end
	else
		local tbMemberList = {
				{ 
					szName = szLeagueMember,
				},
			};
		GCExcute{"League:CreateLeagueWithMember", self.LEAGUETYPE_CALLBACK, szLeagueName, tbMemberList};
		self:SetCallBackRelationFlag(pFriend, 1);
		self:SetCallBackRelationTime(pFriend, GetTime());
		Dialog:Say(szMsg, tbMsgOpt);
		pFriend.Msg("Bạn và <color=green>" .. pMe.szName .. "<color> đã tạo quan hệ mời");
		self:WriteLog("MakeCallBackRelation", "Lập chiến đội người chơi quay lại thành công", szLeagueName, szLeagueMember);
	end
	Setting:RestoreGlobalObj();
end

function tbPlayerCallBack:OldPlayer_CheckOldPlayerFriend(pMe)
	if pMe.nLevel < 80 then
		return 0
		, "Đẳng cấp chưa đủ, đạt <color=red>cấp 80<color> mới có thể tạo quan hệ mời với người bạn cũ."
		,{ {"Ta biết rồi (thoát)"} }
	end
	
	if (self:IsOpen(pMe, 1) == 1) then
		return 0
		,"Bạn là hiệp khách tái xuất giang hồ, không thể kêu gọi hiệp khách khác!"
		,{{"Ta biết rồi (thoát)"}}	
	end
	
	if (self:GetCallBackRelationFlag(pMe) == 1) then
		self:WriteLog("OldPlayer_CheckOldPlayerFriend", pMe.szName .. " có thể từng là người chơi cũ và có quan hệ mời, tuy giờ không là người chơi cũ nữa, nhưng ký hiệu chiến đội vẫn còn. ");
		return 1;
	end

	local tbTeamMemberList = KTeam.GetTeamMemberList(pMe.nTeamId);                        
	local tbPlayerId = pMe.GetTeamMemberList();                                           
	if ((not tbPlayerId) or (not tbTeamMemberList) or #tbTeamMemberList ~= 2 or Lib:CountTB(tbPlayerId) ~= 2) then
		return 0
		,"Muốn mời người chơi nào? Chỉ có tổ đội riêng <color=red>và ở gần<color> mới mời được."
		,{{"Ta biết rồi (thoát)"}} 
	end
	
	--判断队友是否在附近
	local nFlag = 0;
	local pFriend = nil;
	local nMapId, nX, nY	= pMe.GetWorldPos();
	for _, pPlayer in pairs(tbPlayerId) do
		if pPlayer.nId ~= pMe.nId then
			local nPlayerMapId, nPlayerX, nPlayerY	= pPlayer.GetWorldPos();
			if (nPlayerMapId == nMapId) then
				local nDisSquare = (nX - nPlayerX)^2 + (nY - nPlayerY)^2;
				if (nDisSquare < ((self.DEF_DIS/2) * (self.DEF_DIS/2))) then
					pFriend = pPlayer;
					nFlag = 1;
				end
			end
		end
	end
	
	if (nFlag ~= 1) then
		return 0
		,"Muốn mời người chơi nào? Không thể tạo quan hệ mời nếu không có đồng đội ở gần."
		,{{"Ta biết rồi (thoát)"}} 
	end

	if (self:IsOpen(pFriend, 1) == 0) then
		return 0
		,"Hảo hữu của bạn không phải người chơi cũ tái xuất giang hồ! "
		,{{"Ta biết rồi (thoát)"}}		
	end
	
	if (pFriend.nLevel < 79) then
		return 0
		,"Hảo hữu dưới cấp 79!"
		,{{"Ta biết rồi (thoát)"}}			
	end

	if (self:CheckRelation(pFriend) ~= 0) then
		return 0
		,"Hảo hữu đã tạo quan hệ với người khác, không thể tạo nữa ! "
		,{{"Ta biết rồi (thoát)"}}
	end
	
	return 1
	,"Hảo hữu <color=red>"..pFriend.szName.."<color> tạo quan hệ mời với bạn!"
	,{{"Cám ơn (thoát)"}}
	,pFriend	

end

-- 判断是否是老玩家，目前的判断的条件是看玩家变量是否是老玩家,出怀疑的老玩家外
function tbPlayerCallBack:IsCallBackPlayer(pPlayer)
	local nFlag = self:GetCallBackPlayerFlag(pPlayer);
	if (nFlag == Player.COMEBACK_YES_OLD or nFlag == Player.COMEBACK_DOUBT_OLD) then
		return 1;
	end
--	if (nFlag == Player.COMEBACK_DOUBT_OLD) then
--		if (pPlayer.GetTask(2027,19) > 0 or 
--			pPlayer.GetTask(2064,10) > 0 or 
--			pPlayer.GetTask(2064,10) > 0) then
--			return 1;
--		end	
--	end
	return 0;
end

-- 判断是否已经存在召回关系了
-- 1 返回表示被召回人已经召回过了，0表示没有召回
function tbPlayerCallBack:CheckRelation(pFriend)
	local szLeagueName	= self:GetRelationTeamName(pFriend);

	if (not szLeagueName) then
		return 0;
	end

	return 1;
end

-- 获取召回关系的战队名
function tbPlayerCallBack:GetRelationTeamName(pPlayer)
	if (self:GetCallBackRelationFlag(pPlayer) == 0) then
		return nil;
	end
	local szLeagueName	= League:GetMemberLeague(self.LEAGUETYPE_CALLBACK, pPlayer.szName);
	return szLeagueName;	
end

-- 判断一个玩家是否可以参加老友回归消费返还
function tbPlayerCallBack:CheckIsConsumeRelation(pPlayer)
	local nFlag = self:IsOpen(pPlayer, 1);
	-- 是否是老玩家
	if (0 == nFlag) then
		return 0;
	end
	
	nFlag = self:GetCallBackRelationFlag(pPlayer);
	-- 是否已经建立了老玩家关系
	if (0 == nFlag) then
		return 0;
	end

	local nNowTime		= GetTime();
	local nCreateTime	= self:GetCallBackRelationTime(pPlayer);
	local nCreateDay	= Lib:GetLocalDay(nCreateTime);
	local nNowDay		= Lib:GetLocalDay(nNowTime);
	local nDetDay		= nNowDay - nCreateDay;

	if (nDetDay < 0 or nDetDay > 90) then
		return 0;
	end
	return 1;
end

function tbPlayerCallBack:GetCallBackRelationFlag(pPlayer)
	return pPlayer.GetTask(self.TSKGROUP_CALLBACK, self.TSKID_ISRELATION);
end

function tbPlayerCallBack:GetCallBackRelationTime(pPlayer)
	return pPlayer.GetTask(self.TSKGROUP_CALLBACK, self.TSKID_RELATIONCREATETIME);
end

function tbPlayerCallBack:SetCallBackRelationTime(pPlayer, nTime)
	pPlayer.SetTask(self.TSKGROUP_CALLBACK, self.TSKID_RELATIONCREATETIME, nTime);
end

function tbPlayerCallBack:SetCallBackRelationFlag(pPlayer, nFlag)
	pPlayer.SetTask(self.TSKGROUP_CALLBACK, self.TSKID_ISRELATION, nFlag);
end

function tbPlayerCallBack:GetCallBackPlayerFlag(pPlayer)
	return pPlayer.GetTask(self.TSKGROUP_CALLBACK, self.TSKID_OLDPLAYERFLAG);
end

function tbPlayerCallBack:GetConsumeRate(pPlayer)
	if (self:CheckIsConsumeRelation(pPlayer) == 0) then
		return 0;
	end
	local nNowTime		= GetTime();
	local nCreateTime	= self:GetCallBackRelationTime(pPlayer);
	local nCreateDay	= Lib:GetLocalDay(nCreateTime);
	local nNowDay		= Lib:GetLocalDay(nNowTime);
	local nDetDay		= nNowDay - nCreateDay;
	
	if (nDetDay < 0) then
		return 0;
	elseif (nDetDay <= 30) then
		return 0.3;
	elseif (nDetDay <= 60) then
		return 0.2;
	elseif (nDetDay <= 90) then
		return 0.1;
	end
	return 0;
end


function tbPlayerCallBack:OnDialog_BandCoinBack()
	local pMe	= me;
	Setting:SetGlobalObj(pMe);
	-- 被怀疑的算吗？
	if (pMe.nLevel < 80) then
		Dialog:Say("Dưới cấp 80, không thể nhận hoàn trả Đồng khóa!");
		Setting:RestoreGlobalObj();
		return;				
	end

	local nFlag = self:IsOpen(pMe, 1);
	if (nFlag == 1) then
		Dialog:Say("Chưa có quan hệ mời với bạn cũ! ");
		Setting:RestoreGlobalObj();
		return;
	end
	
	local nConsume	= GetCallBackPlayerConsume(pMe.szName);
	if (nConsume <= 0) then
		Dialog:Say("Hiện không có đồng khóa để nhận, (Bạn cũ dùng tại Kỳ Trân Các và đăng nhập lại rồi mới nhận được hoàn trả đồng khóa)!");
		Setting:RestoreGlobalObj();
		return;		
	end
	local szMsg		= "Bạn có <color=yellow>" .. nConsume .. "<color> đồng khóa, bạn có muốn nhận hết? (Bạn cũ dùng tại Kỳ Trân Các và đăng nhập lại rồi mới nhận được hoàn trả đồng khóa)!";
	Dialog:Say(szMsg,
		{
			{"Xác nhận lãnh", self.GiveCallBackBindCoin, self, pMe},
			{"Để ta suy nghĩ đã"},	
		});
	Setting:RestoreGlobalObj();
end

function tbPlayerCallBack:GiveCallBackBindCoin(pMe)
	local nConsume	= GetCallBackPlayerConsume(pMe.szName);
	-- 这里要写log
	if (SetCallBackPlayerConsume(pMe.szName, 0) == 0) then
		self:WriteLog("Khấu trừ hoàn trả đồng khóa thất bại");
	end
	self:WriteLog("GiveCallBackBindCoin", "Người chơi " .. pMe.szName .. " nhận hoàn trả đồng khóa kêu gọi người chơi cũ " .. nConsume .. " đồng khóa");
	pMe.AddBindCoin(nConsume, Player.emKBINDCOIN_ADD_CALLBACK);
end

function tbPlayerCallBack:WriteLog(...)
	Dbg:WriteLogEx(Dbg.LOG_INFO, "tbPlayerCallBack", unpack(arg));
end

function tbPlayerCallBack:AddOldPlayerTitle()
	if self:IsOpen(me, 3) == 1 then
		if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_TITLE) == 0 then
			me.AddTitle(unpack(self.DEF_OLDPLAYER_TITLE));
			me.SetCurTitle(unpack(self.DEF_OLDPLAYER_TITLE));			
			me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_TITLE, 1)
			self:CheckPatch();
		end
	end
end

function tbPlayerCallBack:CheckPatch()
	if me.GetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_PATCH) < self.DEF_PATCH then
		me.SetTask(self.TASK_GROUP_OLDPLAYER, self.TASK_PATCH, self.DEF_PATCH);
		--
		--清空需要重置的变量
		--待做,需要重开再开发.
		
	end
end

if (MODULE_GAMESERVER) then
PlayerEvent:RegisterOnLoginEvent(EventManager.ExEvent.tbPlayerCallBack.AddOldPlayerTitle, EventManager.ExEvent.tbPlayerCallBack)
end
