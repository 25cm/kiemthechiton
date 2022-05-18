
local tbXinshouchuansong = Item:GetClass("xinshouchuansong");

tbXinshouchuansong.nTime = 0.5;			-- 延时的时间(秒)


function tbXinshouchuansong:InitGenInfo()
	it.SetTimeOut(0, (GetTime() + 7 * 24 * 60 * 60));
	return {};
end


tbXinshouchuansong.tbHomeMap	=
{
	["Vân Trung Trấn"]	= { 1, 1389, 3102 },
 	["Vĩnh Lạc Trấn"]	= { 3, 1693, 3288 },
 	["Thạch Cổ Trấn"]	= { 6, 1572, 3106 },
 	["Long Tuyền Thôn"]	= { 7, 1510, 3268 },
 	["Long Môn Trấn"]	= { 2, 1785, 3586 },
	["Giang Tân Thôn"]	= { 5, 1597, 3131 },
	["Đạo Hương Thôn"]	= { 4, 1624, 3253 },
 	["Ba Lăng Huyện"]	= { 8, 1721, 3381 },
};


tbXinshouchuansong.tbGenreMap =
{
	["Võ Đang Phái"]	= { 14, 1435, 2991 },
 	["Ngũ Độc Giáo"]	= { 20, 1574, 3145 },
 	["Thiên Vương Bang"]	= { 22, 1663, 3039 },
	["Thiên Nhẫn Giáo"]	= { 10, 1658, 3324 },
 	["Đường Môn"]	= { 18, 1633, 3179 },
 	["Thiếu Lâm Phái"]	= {  9, 1702, 3093 },
 	["Côn Lôn Phái"]	= { 12, 1700, 3080 },
 	["Cái Bang"]	= { 15, 1606, 3245 },
	["Nga My Phái"]	= { 16, 1584, 3041 },
 	["Thúy Yên Môn"]	= { 17, 1487, 3093 },
 	["Đại Lý Đoàn Thị"]	= { 19, 1618, 3120 },
 	["Minh Giáo"]	= { 224, 1625, 3181 },
};

tbXinshouchuansong.tbJueWenPo	=
{
	["Trấn Đông Mộ Viên"]	= { 38, 1879, 3614 },
 	["Đồng Quan"]	= { 40, 1904, 3397 },
 	["Trà Mã Cổ Đạo"]	= { 43, 1671, 3452 },
 	["Phường Đúc Kiếm"]	= { 44, 1899, 3653 },
 	["Kỳ Liên Sơn"]	= { 39, 1754, 3702 },
	["Thục Nam Trúc Hải"]	= { 42, 1729, 4036 },
	["Hoài Thủy Sa Châu"]	= { 41, 1749, 3795 },
 	["Nhạc Dương Lâu"]	= { 45, 1878, 3311 },
};



function tbXinshouchuansong:OnUse()
		local szMsg = "Muốn đi đâu thì đi đó!<pic=48>";
		local tbOpt = {
			{"Tân Thủ Thôn", self.OnTransItem, self, it, self.tbHomeMap, 0},
			{"Môn phái", self.OnTransItem, self, it, self.tbGenreMap, 0},
			{"Tuyệt Vấn Pha", self.OnTransItem, self, it, self.tbJueWenPo, 0},
			{"Để ta suy nghĩ đã"},
		}
		Dialog:Say(szMsg, tbOpt)
		return 0;
		
end

function tbXinshouchuansong:OnTransItem(pItem, tbPosTb, nIsLimit, szFrom)
	local tbOpt		= {};
	local nCount	= 9;
	
	for szName, tbPos in next, tbPosTb, szFrom do
		local tbPerPos = tbPosTb[szName];
		if (nCount <= 0) then
			tbOpt[#tbOpt]	= {"Trang sau", self.OnTransItem, self, pItem, tbPosTb, nIsLimit, tbOpt[#tbOpt-1][1]};
			break;
		end
		tbOpt[#tbOpt+1]	= {szName, self.DelayTime, self, pItem, tbPerPos, nIsLimit, szName};
		nCount = nCount - 1;
	end
	tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
	Dialog:Say("Muốn đi đâu thì đi đó!<pic=48>", tbOpt);
end

function tbXinshouchuansong:DelayTime(pItem, tbPos, nIsLimit, szName)
	if (0 == me.nFightState) then				-- 玩家在非战斗状态下传送无延时正常传送
		self:TransPlayer(pItem.dwId, tbPos, nIsLimit, szName);
		return;
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
	GeneralProcess:StartProcess("Đang đưa đi….", self.nTime * Env.GAME_FPS, {self.TransPlayer, self, pItem.dwId, tbPos, nIsLimit, szName}, nil, tbEvent);
end

function tbXinshouchuansong:TransPlayer(nItemId, tbPos, nIsLimit, szName)
	local pItem = KItem.GetObjById(nItemId);
	if (not pItem) then
		return;
	end
	local nRet, szMsg = Map:CheckTagServerPlayerCount(tbPos[1]);
	if nRet ~= 1 then
		me.Msg(szMsg);
		return 0;
	end
	if (nIsLimit == 1) then
		if (me.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			me.Msg("Hủy Truyền Tống Phù thất bại!");
			return;
		end
	end
	me.Msg(string.format("Đi %s!",szName));
	me.NewWorld(unpack(tbPos));
end
