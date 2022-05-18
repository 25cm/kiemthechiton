-- 文件名　：weddingring.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-10 11:59:56
-- 功能描述：结婚戒指
-- modify by zhangjinpin@kingsoft 2010-01-29

local tbItem = Item:GetClass("marry_weddingring");

--==========================================================

tbItem.KISS_DISTANCE = 50;	-- 使用接吻技能需要的最大距离

tbItem.LEVEL_PINGMIN = 1;
tbItem.LEVEL_GUIZU = 2;
tbItem.LEVEL_WANGHOU = 3;
tbItem.LEVEL_HUANGJIA = 4;

tbItem.tbExpRate = {120, 120, 120, 120};

--==========================================================

function tbItem:CanUse(pItem)
	if (not pItem) then
		return 0;
	end
	
	local szErrMsg = "";
	if (me.IsMarried() == 0) then
		szErrMsg = "Bạn đã tổ chức 1 đám cưới với người yêu của mình";
		return 0, szErrMsg;
	end
	
	local szCustom = pItem.szCustomString;
	local szCoupleName = me.GetCoupleName();
	if (not szCustom or szCustom == "" or not szCoupleName or "" == szCoupleName) then
		return 0, szErrMsg;
	end
	if (szCustom ~= szCoupleName) then
		szErrMsg = string.format("Điều này chứng tỏ bạn và<color=yellow>%s<color>người yêu bạn ", szCustom);
		return 0, szErrMsg;
	end
	
	return 1;
end


function tbItem:OnUse()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local bCanUse, szErrMsg = self:CanUse(it);
	if (0 == bCanUse) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local szMsg = "Nhẫn cưới là nhân chứng tình cảm của bạn với người yêu của mình.";
	local tbOpt = self:GetChoice(it.nLevel) or {};
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:GetChoice(nLevel)
	local tbOpt = {};
	if (not nLevel or nLevel < self.LEVEL_PINGMIN or nLevel > self.LEVEL_HUANGJIA) then
		return;
	end
	
	-- 亲吻技能，所有档次的都有
	table.insert(tbOpt, {"Quà mừng", self.CoupleKiss, self});
	
	-- 夫妻经验加成，所有档次都有
	if (0 == me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_EXP_RATE)) then
		table.insert(tbOpt, {"Bạn phải có quà mới nhận được tiền thưởng", self.GetAddExpState, self, nLevel});
	else
		table.insert(tbOpt, {"<color=gray>Bạn phải có quà mới nhận được tiền thưởng<color>", self.AlreadyUseDlg, self});
	end
	
	-- 夫妻传送，贵族以上档次的才有
	if (nLevel >= self.LEVEL_GUIZU) then
		table.insert(tbOpt, {"Quà mừng", self.Come2Couple, self});
	else
		table.insert(tbOpt, {"<color=gray>Quà mừng<color>", self.NeedUpdateRingDlg, self});
	end
	
	-- 新婚光环，王侯以上级别才有
	if (nLevel >= self.LEVEL_WANGHOU) then
		if (0 == me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDING_TITLE)) then
			table.insert(tbOpt, {"Quà mừng", self.AddWeddingGuangHuan, self});
		else
			table.insert(tbOpt, {"<color=gray>Quà mừng<color>", self.AlreadyUseDlg, self});
		end
	else
		table.insert(tbOpt, {"<color=gray>Quà mừng<color>", self.NeedUpdateRingDlg, self});
	end
	
	-- 新婚坐骑，皇家以上档次才有
	if (nLevel >= self.LEVEL_HUANGJIA) then
		if (me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDIGN_HORSE) == 0) then
			table.insert(tbOpt, {"Nhận quà", self.GetWeddingHorse, self});
		else
			table.insert(tbOpt, {"<color=gray>Nhận quà<color>", self.AlreadyUseDlg, self});
		end
	else
		table.insert(tbOpt, {"<color=gray>Nhận quà<color>", self.NeedUpdateRingDlg, self});
	end
	
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	return tbOpt;
end

function tbItem:AlreadyUseDlg()
	Dialog:Say("Bạn đã có chức năng này");
	return;
end

function tbItem:NeedUpdateRingDlg()
	Dialog:Say("Theo lễ cưới của bạn không thể sử dụng tính năng này");
	return;
end

-- 增加新婚光环
function tbItem:AddWeddingGuangHuan()
	Marry:SetAdvTitle(me, me.nSex);
	me.SetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDING_TITLE, 1);
end

-- 夫妻经验加成
function tbItem:GetAddExpState(nLevel)
	local nExpRate = self.tbExpRate[nLevel];
	me.SetTask(Marry.TASK_GROUP_ID, Marry.TASK_EXP_RATE, nExpRate);
	local szMsg = string.format("Bạn và người yêu bạn nhận quà mừng<color=yellow>%s%%<color>Kinh nghiệm tiền thưởng", nExpRate);
	Dialog:Say(szMsg);
end

-- 获取新婚坐骑
function tbItem:GetWeddingHorse()
	local bHaveGetHorse = me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDIGN_HORSE);
	if (bHaveGetHorse ~= 0) then
		return;
	end
	
	if (me.nSex == 0) then
		me.AddItem(1, 12, 25, 4);
	else
		me.AddItem(1, 12, 26, 4);
	end
	me.SetTask(Marry.TASK_GROUP_ID, Marry.TASK_GET_WEDDIGN_HORSE, 1);
	Dialog:Say("Bạn đã có quà là con ngựa");
	
	Dbg:WriteLog("Marry", "Hôn nhân hệ thống", me.szName, me.szAccount, "Để có 1 con ngựa cưới");
end

-- KISS
function tbItem:CoupleKiss()
	if (me.IsMarried() == 0) then
		return;
	end
	local szCoupleName = me.GetCoupleName();
	if (not szCoupleName) then
		return;
	end
	local bIsNearby = 0;
	local tbPlayerList = KPlayer.GetAroundPlayerList(me.nId, 50);
	for _, pPlayer in pairs(tbPlayerList) do
		if (szCoupleName == pPlayer.szName) then
			bIsNearby = 1;
			break;
		end
	end
	if (0 == bIsNearby) then
		Dialog:Say("Bạn và người yêu của bạn không đứng cùng nhau, không thể truyền đạt tình cảm.");
		return;
	end
	
	me.CastSkill(1558, 1, -1, me.GetNpc().nIndex);
end

-- 夫妻传送
function tbItem:Come2Couple()
	if (me.IsMarried() == 0) then
		return;
	end
	local szCoupleName = me.GetCoupleName();
	if (not szCoupleName) then
		return;
	end
	local nCoupleId = KGCPlayer.GetPlayerIdByName(szCoupleName);
	local nOnline = KGCPlayer.OptGetTask(nCoupleId, KGCPlayer.TSK_ONLINESERVER);
	if (0 == nOnline) then
		Dialog:Say("Mỗi người đến khác, không có quà.");
		return;
	end
	
	if Item:CheckIsUseAtMap(me.nMapId, "chuangsong") ~= 1 then
		return 0;
	end
	
	-- 会中断延时的事件
	local tbEvent	= 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	};
	
	-- 玩家在非战斗状态下传送无延时正常传送
	if (0 == me.nFightState) then
		self:DoSelectMember(nCoupleId, me.nId)
		return 0;
	end
	
	-- 在战斗状态下需要nTime秒的延时	
	GeneralProcess:StartProcess(string.format("Được gửi đi[%s]Đó là...", szCoupleName), self.nTime * Env.GAME_FPS, {self.DoSelectMember, self, nCoupleId, me.nId}, nil, tbEvent);
end

function tbItem:DoSelectMember(nCoupleId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	local nOnline = KGCPlayer.OptGetTask(nCoupleId, KGCPlayer.TSK_ONLINESERVER);
	if nOnline <= 0 then
		Dialog:Say("Đã được sử dụng không thể gửi đến người khác");
		return 0;
	end
	GCExcute({"Item.tbFuQiChuanSongFu:SelectMemberPos", nCoupleId, nPlayerId});
end

