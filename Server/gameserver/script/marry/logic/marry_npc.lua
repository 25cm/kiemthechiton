-------------------------------------------------------
-- 文件名　：marry_npc.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-01-05 00:29:41
-- 文件描述：
-------------------------------------------------------

Require("\\script\\marry\\logic\\marry_def.lua");

if (not MODULE_GAMESERVER) then
	return 0;
end

local tbNpc = Marry.DialogNpc or {};
Marry.DialogNpc = tbNpc;

-- 判断求婚
function tbNpc:CheckQiuhun()
	
	-- 系统开关
	if Marry:CheckState() ~= 1 then
		return 0;
	end

	local szOptMsg = [[


<color=yellow>Điều kiện: <color>
    1. Đẳng cấp nhân vật phải đạt <color=yellow>69<color>
    2. Cả 2 bên phải <color=yellow>Độc Thân<color> và chưa nạp cát với ai
    3. Cả 2 bên phải có <color=yellow> Độ Thân Mật<color> đạt cấp <color=yellow>3<color>.
]]
	-- 我没有结婚
	if me.IsMarried() == 1 then
		Dialog:Say("Bạn đã có phu nhân rồi, hãy về nhà với phu nhân của bạn." .. szOptMsg);
		return 0;
	end

	-- 等级69级
	if me.nLevel < 69 then
		Dialog:Say("Đẳng cấp của các hạ chưa đạt 69 không thể sử dụng." .. szOptMsg);
		return 0;
	end
	
	-- 俩人组队
	local tbMemberList, nMemberCount = me.GetTeamMemberList();
	if not tbMemberList or nMemberCount ~= 2 then
		Dialog:Say("Trong tổ đội chỉ được phép có 2 người, hãy bảo người thứ 3 tránh mặt." .. szOptMsg);
		return 0;
	end
	
	local pTeamMate = nil;
	for _, pMember in pairs(tbMemberList) do
		if pMember.szName ~= me.szName then
			pTeamMate = pMember;
		end
	end
	
	if not pTeamMate then
		return 0;
	end

	-- 同性恋
	if me.nSex == pTeamMate.nSex then
		Dialog:Say("Nạp cát không chấp nhận đồng tính." .. szOptMsg);
		return 0;
	end
	
	-- 对方没有结婚
	if pTeamMate.IsMarried() == 1 then
		Dialog:Say("Đối phương đã có đính ước với người khác rồi." .. szOptMsg);
		return 0;
	end

	-- 等级69级
	if pTeamMate.nLevel < 69 then
		Dialog:Say("Đẳng cấp của các hạ chưa đạt 69 không thể sử dụng." .. szOptMsg);
		return 0;
	end
	
	-- 我已经订婚
	if me.GetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME) ~= "" then
		Dialog:Say("Bạn đã đặt lễ rồi, không cần nạp cát nữa" .. szOptMsg);
		return 0;
	end
	
	-- 对方已经订婚
	if pTeamMate.GetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME) ~= "" then
		Dialog:Say("Đối phương đã đặt lễ, không cần nạp cát nữa." .. szOptMsg);
		return 0;
	end
	

	
	-- 在附近
	local nNearby = 0;
	local tbPlayerList = KPlayer.GetAroundPlayerList(me.nId, 50);
	if tbPlayerList then
		for _, pPlayer in ipairs(tbPlayerList) do
			if pPlayer.szName == pTeamMate.szName then
				nNearby = 1;
			end
		end
	end
	
	if nNearby ~= 1 then
		Dialog:Say("Bạn ở quá xa với đối phương, hãy tiến lại gần chút nữa..." .. szOptMsg);
		return 0;
	end
	
	return 1;
end

-- 求婚对话
function tbNpc:OnQiuhun(nItemId)
	
	if self:CheckQiuhun() ~= 1 then
		return 0;
	end

	local tbMemberList, nMemberCount = me.GetTeamMemberList();
	local pTeamMate = nil;
	for _, pMember in pairs(tbMemberList) do
		if pMember.szName ~= me.szName then
			pTeamMate = pMember;
		end
	end
	
	local szMsg = string.format("Bạn có chắc chắn muốn cùng <color=green>%s<color> làm lễ nạp cát ?", pTeamMate.szName);
	local tbOpt = 
	{
		{"Ta đồng ý", self.OnConfirmQiuhun, self, me.nId, pTeamMate.nId, nItemId},
		{"Để ta suy nghĩ lại"},
	};
	
	Dialog:Say(szMsg, tbOpt);
end

-- 确认求婚
function tbNpc:OnConfirmQiuhun(nSuitorId, nTeamMateId, nItemId)

	local pSuitor = KPlayer.GetPlayerObjById(nSuitorId);
	local pTeamMate = KPlayer.GetPlayerObjById(nTeamMateId);
	
	if not pSuitor or not pTeamMate then
		return 0;
	end
	
	-- 只要使用了求婚卡片，不论对方是否同意都得删除
	local pItem = KItem.GetObjById(nItemId);
	if pItem then
		pItem.Delete(pSuitor);
	end
	
	local szMsg = string.format("<color=green>%s<color> gửi lời nạp cát đến bạn, bạn có đồng ý ?", pSuitor.szName);
	local tbOpt = 
	{
		{"Vâng tôi đồng ý", self.OnAcceptQiuhun, self, nSuitorId, nTeamMateId},
		{"Tôi từ chối", self.OnRefuseQiuhun, self, nSuitorId, nTeamMateId},
	};
	
	Setting:SetGlobalObj(pTeamMate);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

-- 接受求婚
function tbNpc:OnAcceptQiuhun(nSuitorId, nTeamMateId)

	local pSuitor = KPlayer.GetPlayerObjById(nSuitorId);
	local pTeamMate = KPlayer.GetPlayerObjById(nTeamMateId);
	
	if not pSuitor or not pTeamMate then
		return 0;
	end
	
	-- 增加求婚关系
	if pSuitor.nSex == 0 then
		Marry:AddQiuhun(pSuitor, me);
		pSuitor.Msg(string.format("Xin chúc mừng, Nạp cát thành công bạn có <color=yellow>%s<color> là tình nhân. Bên nam có thể mua quà lễ để cử hành hôn lễ", pTeamMate.szName));
		pTeamMate.Msg(string.format("Xin chúc mừng, Nạp cát thành công bạn có <color=yellow>%s<color> là tình nhân. Bên nam có thể mua quà lễ để cử hành hôn lễ", pSuitor.szName));
	else
		Marry:AddQiuhun(me, pSuitor);
		pSuitor.Msg(string.format("Xin chúc mừng, Nạp cát thành công bạn có <color=yellow>%s<color> là tình nhân. Bên nam có thể mua quà lễ để cử hành hôn lễ", pTeamMate.szName));
		pTeamMate.Msg(string.format("Xin chúc mừng, Nạp cát thành công bạn có <color=yellow>%s<color> là tình nhân. Bên nam có thể mua quà lễ để cử hành hôn lễ", pSuitor.szName));
	end
	
	pSuitor.SendMsgToFriend(string.format("Hảo hữu của bạn <color=yellow>%s<color> đính ước với <color=yellow>%s<color> thành công.", pSuitor.szName, pTeamMate.szName));
	Player:SendMsgToKinOrTong(pSuitor, string.format(" đính ước <color=yellow>%s<color> thành công.", pTeamMate.szName));
	
	pTeamMate.SendMsgToFriend(string.format("Hảo hữu của bạn <color=yellow>%s<color> chấp nhận đính ước với <color=yellow>%s<color>.", pTeamMate.szName, pSuitor.szName));
	Player:SendMsgToKinOrTong(me, string.format(" chấp nhận đính ước với <color=yellow>%s<color>.", pSuitor.szName));
	
	-- 频道公告
	Dialog:SendBlackBoardMsg(pSuitor, string.format("Chúc mừng bạn và <color=yellow>%s<color> nạp cát thành công.", pTeamMate.szName));
	KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, string.format("<color=green>[%s]<color> đồng ý đính ước cùng <color=green>[%s]<color>, chúc 2 bạn mãi mãi hạnh phúc.", pTeamMate.szName, pSuitor.szName));

	Dbg:WriteLog("Marry", "Hệ thống phu thê", pSuitor.szName, pSuitor.szAccount, pTeamMate.szName, pTeamMate.szAccount, "Kết hôn");
end

-- 拒接求婚
function tbNpc:OnRefuseQiuhun(nSuitorId, nTeamMateId)
	
	local pSuitor = KPlayer.GetPlayerObjById(nSuitorId);
	local pTeamMate = KPlayer.GetPlayerObjById(nTeamMateId);
	
	if not pSuitor or not pTeamMate then
		return 0;
	end
	
	Dialog:SendBlackBoardMsg(pSuitor, string.format("Thật đáng tiếc, <color=green>%s<color> cự tuyệt nạp cát với ngươi", pTeamMate.szName));
end

-- 解除求婚关系
function tbNpc:OnRemoveQiuhun(nSure)
	
	-- 系统开关
	if Marry:CheckState() ~= 1 then
		return 0;
	end
	
	-- 俩人组队
	local tbMemberList, nMemberCount = me.GetTeamMemberList();
	if not tbMemberList or nMemberCount ~= 2 then
		Dialog:Say("Hai người phải cùng trong tổ đội mới có thể giải trừ nạp cát.");
		return 0;
	end
	
	local pTeamMate = nil;
	for _, pMember in pairs(tbMemberList) do
		if pMember.szName ~= me.szName then
			pTeamMate = pMember;
		end
	end
	
	if not pTeamMate then
		return 0;
	end
	
	if Marry:CheckQiuhun(me, pTeamMate) ~= 1 then
		Dialog:Say("Các ngươi trong lúc đó bất tồn tại nạp cát quan hệ, đừng tới quấy rối liễu.");
		return 0;
	end
	
	if Marry:CheckPreWedding(me.szName) == 1 or Marry:CheckPreWedding(pTeamMate.szName) == 1 then
		Dialog:Say("Các ngươi đã đặt trước liễu điển lễ, bất năng tái xin giải trừ nạp cát quan hệ.");
		return 0;
	end
	
	if not nSure then
		local szMsg = string.format("Ngươi xác định muốn giải trừ nạp cát với <color=yellow>%s<color> ? Các ngươi mỗi người cần tốn hao <color=yellow>10 vạn <color> ngân lượng.", pTeamMate.szName);
		local tbOpt = 
		{
			{"Xác nhận giải trừ", self.OnRemoveQiuhun, self, 1},
			{"Để ta suy nghĩ thêm"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	
	if me.nCashMoney < Marry.CANCEL_QIUHUN_COST then
		Dialog:Say("Ngươi trên người đích bạc bất túc 10 vạn, vô pháp xin giải trừ nạp cát.");
		return 0;
	end
	
	if pTeamMate.nCashMoney < Marry.CANCEL_QIUHUN_COST then
		Dialog:Say(string.format("%s trên người không đủ 10v bạc, không thể tiến hành giải trừ.", pTeamMate.szName));
		return 0;
	end
	
	me.CostMoney(Marry.CANCEL_QIUHUN_COST, Player.emKPAY_EVENT);
	pTeamMate.CostMoney(Marry.CANCEL_QIUHUN_COST, Player.emKPAY_EVENT);
	
	me.Msg(string.format(" Ngươi đã giải trừ nạp cát với <color=yellow>%s<color>, tiền thủ tục mất <color=yellow>%s<color> vạn lượng", pTeamMate.szName, Marry.CANCEL_QIUHUN_COST));
	pTeamMate.Msg(string.format(" Ngươi đã giải trừ nạp cát với <color=yellow>%s<color>, tiền thủ tục mất <color=yellow>%s<color> vạn lượng", me.szName, Marry.CANCEL_QIUHUN_COST));
	
	me.RemoveSpeTitle(string.format("%s giải trừ nạp cát", pTeamMate.szName));
	pTeamMate.RemoveSpeTitle(string.format("%s giải trừ nạp cát", me.szName));
	
	Marry:RemoveQiuhun(me, pTeamMate);
	
	Dbg:WriteLog("Marry", "Hệ thống phu thê", me.szName, me.szAccount, pTeamMate.szName, pTeamMate.szAccount, "双方解除求婚");
end

-- 单方面解除求婚关系
function tbNpc:OnSingleRemoveQiuhun(nSure)
	
	-- 系统开关
	if Marry:CheckState() ~= 1 then
		return 0;
	end
	
	local szQiuhunName = me.GetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME);
	if szQiuhunName == "" then
		Dialog:Say("Ngươi chưa đính ước những người khác nạp cát, không cần giải trừ nạp cát quan hệ.");
		return 0;
	end
	
	if Marry:CheckPreWedding(me.szName) == 1 then
		Dialog:Say("Ngươi đã đặt trước quà điển lễ , không thể xin giải trừ nạp cát quan hệ.");
		return 0;
	end
	
	-- 另一方自动触发解除求婚关系
	local szKeyName = Marry.tbProposalBuffer[me.szName];
	if szKeyName and szKeyName == szQiuhunName then
		me.SetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME, "");
		if me.nSex == 0 then
			me.RemoveSpeTitle(string.format("%s giải trừ nạp cát", szQiuhunName));
		else
			me.RemoveSpeTitle(string.format("%s giải trừ nạp cát", szQiuhunName));
		end
		me.Msg(string.format(" Ngươi đã giải trừ nạp cát với <color=yellow>%s<color>.", szQiuhunName));
		Marry:RemoveProposal_GS(me.szName);
		return 0;
	end
	
	if not nSure then
		local szMsg = "Ngươi quyết tâm đơn phương giải trừ nạp cát quan hệ sao? Ngươi cần tốn hao <color=yellow>20 vạn <color> ngân lượng.";
		local tbOpt = 
		{
			{"Xác nhận", self.OnSingleRemoveQiuhun, self, 2},
			{"Để ta suy nghĩ lại"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	
	if me.nCashMoney < Marry.SINGLE_QIUHUN_COST then
		Dialog:Say("Hành trang của ngươi không đủ 20v bạc không thể tiến hành giải trừ nạp cát.");
		return 0;
	end
	
	me.CostMoney(Marry.SINGLE_QIUHUN_COST, Player.emKPAY_EVENT);
	me.SetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME, "");
	me.Msg(string.format(" Ngươi đã giải trừ nạp cát với <color=yellow>%s<color> lệ phí giải trừ mất <color=yellow>%s<color> vạn lượng.", szQiuhunName, Marry.SINGLE_QIUHUN_COST));
	
	if me.nSex == 0 then
		me.RemoveSpeTitle(string.format("%s giải trừ nạp cát", szQiuhunName));
	else
		me.RemoveSpeTitle(string.format("%s giải trừ nạp cát", szQiuhunName));
	end

	KPlayer.SendMail(szQiuhunName, "Đơn phương giải trừ quan hệ nạp cát", 
		string.format("Thật đáng tiếc, <color=gold>%s<color> đã đơn phương giải trừ quan hệ nạp cát.", me.szName)
		);
		
	Marry:AddProposal_GS(szQiuhunName, me.szName);
	
	Dbg:WriteLog("Marry", "Hệ thống hôn nhân", me.szName, me.szAccount, "đơn phương hủy hôn lễ");
end 
