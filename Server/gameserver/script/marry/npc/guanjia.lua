-- 文件名　：guanjia.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-28 21:11:54
-- 功能描述：结婚系统npc（管家）

local tbNpc = Npc:GetClass("marry_guanjia");

--=============================================================

-- 在不同地图的管家npc可以给玩家释放的buff信息
tbNpc.TB_SKILL_INFO  = {
	["city"] = {
		{nSkillId = 876, nSkillLevel = 8},
		{nSkillId = 877, nSkillLevel = 8},
		{nSkillId = 878, nSkillLevel = 8},
		},
	["village"] = {
		{nSkillId = 876, nSkillLevel = 5},
		{nSkillId = 877, nSkillLevel = 5},
		{nSkillId = 878, nSkillLevel = 5},
		},
	};

--=============================================================

function tbNpc:OnDialog()
	local szMsg = self:GetChatMsg();
	if not szMsg then
		return;
	end
	local tbOpt = 
	{
		{"Nhận lời chúc", self.GetBuffDlg, self},
		{"Để ta xem lại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetChatMsg()
	local szMsg = "";
	local szMapClass = GetMapType(me.nMapId) or "";
	if (szMapClass ~= "village" and szMapClass ~= "city") then
		return;
	end
	
	local tbNpcData = him.GetTempTable("Marry");
	if (not tbNpcData) then
		return;
	end
	
	local szMaleName = tbNpcData.szMaleName;
	local szFemaleName = tbNpcData.szFemaleName;
	if (not szMaleName or not szFemaleName) then
		return;
	end
	
	if (szMapClass == "city") then
		szMsg = string.format("Hôm nay <color=yellow> %s <color>và <color=yellow>%s <color>cử hành <color=yellow>hôn lễ Hoàng gia<color>, mọi người mau đi tìm Nguyệt Lão thôn Giang Tân tham gia.Tôi xin chúc mừng mọi người tại đây!",
			szMaleName, szFemaleName);
	elseif (szMapClass == "village") then
		szMsg = string.format("Hôm nay <color=yellow>%s<color> và <color=yellow>%s<color>cử hành<color=yellow>Hôn lễ Vương hầu<color>, mọi người mau đi tìm Nguyệt Lão thôn Giang Tân tham gia.Tôi xin chúc mừng mọi người tại đây!",
			szMaleName, szFemaleName);
	else 
		return;
	end
	
	szMsg = szMsg .. "\n  Điều kiện: \n    1. Đẳng cấp phải từ 69 trở lên và đã gia nhập môn phái \n    2. Còn độc thân";
	return szMsg;
end


function tbNpc:GetBuffDlg()
	local szMapClass = GetMapType(me.nMapId) or "";
	if (szMapClass ~= "village" and szMapClass ~= "city") then
		Dialog:Say("Rừng Hoa Phủ Kín chỉ có thể sử dụng tại các thành thị,thôn tân thủ và nơi tổ chức hôn lễ");
		return 0;
	end
	
	if (me.nLevel < 69) then
		Dialog:Say("Cấp bậc của bạn không đến 69,bạn không thể nhận được lời chúc");
		return 0;
	end
	
	if (me.nFaction == 0) then
		Dialog:Say("Bạn chưa gia nhập môn phái,không thể nhận được lời chúc");
		return 0;
	end
	
	local nPrestige = KGblTask.SCGetDbTaskInt(DBTASK_COIN_EXCHANGE_PRESTIGE)
	if nPrestige == 0 then
		Dialog:Say("Hệ thống chưa xếp loại danh vọng,hiện nay không thể nhận được lời chúc");
		return 0;
	end
	
	if (nPrestige > me.nPrestige) then
		Dialog:Say("Xếp loại danh vọng của bạn chưa đủ,không thể nhận được lời chúc\nChỉ có 5000 người xếp loại danh vọng đầu mới được nhận lời chúc");
		return 0;
	end
	
	local tbSkillInfo = self.TB_SKILL_INFO[szMapClass];
	if (not tbSkillInfo) then
		return 0;
	end
	
	local nCurDate = tonumber(os.date("%Y%m%d", GetTime()));
	local nLastGetBuffDate = me.GetTask(Marry.TASK_GROUP_ID, Marry.TASK_DATE_GETBUFF);
	if (nCurDate == nLastGetBuffDate) then
		Dialog:Say("Hôm nay bạn đã nhận được lời chúc rồi,không thể nhận thêm nữa");
		return 0;
	end
	
	local tbEvent = 
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
	}
	GeneralProcess:StartProcess("Nhận được lời chúc...", 5 * Env.GAME_FPS,
		{self.GetBuff, self, me.szName, tbSkillInfo}, nil, tbEvent);
end

function tbNpc:GetBuff(szName, tbSkillInfo)
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		return 0;
	end
	
	for _, tbInfo in pairs(tbSkillInfo) do
		pPlayer.AddSkillState(tbInfo.nSkillId, tbInfo.nSkillLevel, 2, 32400, 1, 0, 1);
	end
	local nCurDate = tonumber(os.date("%Y%m%d", GetTime()));
	pPlayer.SetTask(Marry.TASK_GROUP_ID, Marry.TASK_DATE_GETBUFF, nCurDate);
	pPlayer.Msg("Bạn đã nhận được lời chúc");
end
