Require("\\script\\misc\\globaltaskdef.lua");

Xisuidao.TSKGROUP = 2011;
Xisuidao.TSKID_LINGPAICOUNT 	= 15; -- ϴ赺Ƹ
Xisuidao.TSKID_REVIVEMAPID		= 16; -- ϴ赺ǰͼid
Xisuidao.TSKID_REVIVEPOINTID	= 17; -- ϴ赺ǰ㴢ID
Xisuidao.TSKID_AWARDFREE		= 18; -- ѽϴ赺ı

Xisuidao.XISUIDAOMAPID			= 255; -- ݶϴ
Xisuidao.BATTLEMAPID			= 256; -- ݶս

Xisuidao.LIMIT_PLAYER_NUM		= 200; -- ϴ赺ưսϴ

Xisuidao.GBLTASKID_NUM			= DBTASK_XISUIDAO_PLAYER;

Xisuidao.tbDeathRevPos				= { 
		[1] = { Xisuidao.XISUIDAOMAPID, 1652, 3389}, 
	};

-- Ҫµȼʱ轱Ҫ
Xisuidao.tbLevelInfo = {
	DBTASD_SERVER_SETMAXLEVEL89,
	DBTASD_SERVER_SETMAXLEVEL99,
	DBTASD_SERVER_SETMAXLEVEL150,
};

function Xisuidao:Init()
	
end

function Xisuidao:OnEnterXisuidao_Xidian(pPlayer)
	if (60 > pPlayer.nLevel) then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Ngươi chưa đủ cấp 60, kỹ năng vẫn còn hạn chế, chưa thể vào Tẩy Tủy Đảo.");
		Setting:RestoreGlobalObj();
		return;
	end

	local nPlayerNum	= KGblTask.SCGetTmpTaskInt(Xisuidao.GBLTASKID_NUM);
	if (nPlayerNum >= self.LIMIT_PLAYER_NUM) then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Số lần vào Tẩy Tủy Đảo đã hết, ngươi không thể vào, hãy quay lại sau.");
		Setting:RestoreGlobalObj();
		return;		
	end

	if ( 1 == self:AwardFreeEnter(pPlayer) ) then
		return;
	end

	local nCount = pPlayer.GetTask(Xisuidao.TSKGROUP, Xisuidao.TSKID_LINGPAICOUNT);
	local szMsg = "";
	if (0 == nCount) then
		szMsg = "Trong đảo có thể tẩy điểm tiềm năng và kỹ năng. Lần đầu vào sẽ được miễn phí, ngươi có chắc chắn muốn vào?";
	elseif (0 < nCount and 5 > nCount) then
		szMsg = string.format("Ngươi đã vào %d lần, cần %d lệnh bài Tẩy Tủy Đảo, có thể mua tại khu Kỳ Trân Các.", nCount, nCount);
	elseif (5 <= nCount) then
		szMsg = "Vào Tẩy Tủy Đảo miễn phí.";
	else
		-- DEBUG
		return;
	end
	local tbOpt = {
			{"Ta muốn đi bây giờ", self.OnEnter, self, pPlayer, nCount},
			{"Kết thúc đối thoại"},
		};
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
	return;
end

function Xisuidao:CanDuoxiu(pPlayer)
	
	if (pPlayer.nLevel < 100) then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Cần luyện đến <color=red>cấp 100<color> mới đủ công lực phụ tu môn phái khác.");
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	local nCount = pPlayer.GetItemCountInBags(Item.SCRIPTITEM,1,16,1);
	if (nCount < 1) then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Khi phụ tu cần phải có <color=red>Tu Luyện Châu<color> để chuyển đổi sang môn phái khác bằng cách sử dụng <color=red>Tu Luyện Châu<color> để chuyển");
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	if(pPlayer.IsAccountLock() == 1)then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Tài khoản đang bị khóa, không thể thao tác!");
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	local nCurGerneCount	= #Faction:GetGerneFactionInfo(pPlayer);
	if(nCurGerneCount >= Faction.MAX_USED_FACTION)then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Ngươi đã phụ tu đủ môn phái cho phép.");
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	return 1;
end

function Xisuidao:OnEnterXisuidao_Duoxiu(pPlayer)
	local nPlayerNum	= KGblTask.SCGetTmpTaskInt(Xisuidao.GBLTASKID_NUM);
	if (nPlayerNum >= self.LIMIT_PLAYER_NUM) then
		Setting:SetGlobalObj(pPlayer);
		Dialog:Say("Số lượng người Phụ tu môn phái đã đầy.");
		Setting:RestoreGlobalObj();
		return;		
	end
	
	if (self:CanDuoxiu(pPlayer) ~= 1) then
		return;
	end
	
	local tbGerneFactionInfo = Faction:GetGerneFactionInfo(pPlayer);
	
	local szMsg = "Hiện tại có thể phụ tu thêm <color=yellow>%d<color> môn phái khác.<enter>"
	szMsg = string.format(szMsg, Faction.MAX_USED_FACTION - #tbGerneFactionInfo);
	szMsg = szMsg .. "Phụ tu môn phái là tu luyên thêm phái khác dựa trên nền tảng của phái hiện tại.<enter>Đến chỗ <color=yellow>Tẩy Tủy Đại Sư<color> trong Tẩy Tủy Đảo để Phụ tu môn phái.<enter>Các nhánh võ công trên giang hồ thiên biến vạn hóa, muốn học được tinh hoa của chúng phải chăm chỉ tập luyện, những người khác đều háo hức muốn thử, ngươi có thử không?";
	
	local tbOpt = {
		{"Tôi muốn đi bây giờ", self.EnterXisuidao_Duoxiu, self, pPlayer},
		{"Kết thúc đối thoại"},
	};
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
	return;
	
end

-- return 1, nLastGerne or 0
function Xisuidao:CanModifyDuoxiu(pPlayer)
	local tbGerneFactionInfo = Faction:GetGerneFactionInfo(pPlayer);
	local nChangeGerneIndex = Faction:GetChangeGenreIndex(pPlayer);
	local nModifyFactionNum = Faction:GetModifyFactionNum(pPlayer);
	
	if(#tbGerneFactionInfo <= 1) then
		Dialog:Say("Ngươi chưa Phụ tu môn phái nào, không thể đổi Phụ tu môn phái.");
		return 0;
	end
	
	if(pPlayer.IsAccountLock() == 1)then
		Dialog:Say("Tài khoản đang bị khóa, không thể thao tác!");
		return 0;
	end
	
	if nModifyFactionNum >= Faction:GetMaxModifyTimes(pPlayer) then
		Dialog:Say("Số lần đổi Phụ tu môn phái của ngươi đã hết.");
		return 0;
	end
	
	return 1;
end


function Xisuidao:OnEnterXisuidao_ModifyDuoxiu(pPlayer)
	Faction:InitChangeFaction(pPlayer);
	local nRes = self:CanModifyDuoxiu(pPlayer);
	if nRes == 0 then
		return;
	end
	
	local tbGerneFactionInfo = Faction:GetGerneFactionInfo(pPlayer);
	local nDelta = Faction:GetMaxModifyTimes(pPlayer) - Faction:GetModifyFactionNum(pPlayer);
	local szMsg = string.format("Hiện tại bạn còn <color=yellow>%s<color> cơ hội đổi phụ tu môn phái.<enter>Bạn có muốn đổi môn phái hiện tại đã phụ tu?", nDelta);
	local tbOpt = {{"Kết thúc đối thoại"}};
	
	for i = 2, #tbGerneFactionInfo do
		local szFactionName = Player.tbFactions[tbGerneFactionInfo[i]].szName;
		table.insert(tbOpt, 1, {szFactionName, self.SureModifyFaction, self, pPlayer, szFactionName, i});
	end
	
	Dialog:Say(szMsg, tbOpt);
	return;
end

function Xisuidao:SureModifyFaction(pPlayer, nFactionName, nFactionGerne)
	local szMsg = "Ngươi xác nhận đổi Phụ tu môn phái<color=yellow>%s<color>?<enter>Sau khi xác nhận đi tìm Tẩy Tủy Đại Sư trong Tẩy Tủy Đảo đổi phụ tu môn phái mới, hãy lựa chọn cẩn thận.";
	szMsg = string.format(szMsg, nFactionName);
	
	local tbOpt = {
		{"Tôi muốn đi bây giờ", self.EnterXisuidao_ModifyDuoXiu, self, pPlayer, nFactionGerne},
		{"Ta quay lại sau"},
		};
		
	Dialog:Say(szMsg, tbOpt);
end

-- һ
function Xisuidao:EnterXisuidao_Duoxiu(pPlayer)
	local nResult = self:CanDuoxiu(pPlayer);
	if (nResult ~= 1) then
		return;
	end
	
	local nRet, szMsg = Map:CheckTagServerPlayerCount(self.XISUIDAOMAPID)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	
	Faction:InitChangeFaction(pPlayer);
	
	local nCurGerneCount = #Faction:GetGerneFactionInfo(pPlayer);
	
	local nGerne = nCurGerneCount + 1; -- Ҫһµ
	
	Faction:SetChangeGenreIndex(pPlayer, nGerne);
	Faction:WriteLog(Dbg.LOG_INFO, "EnterXisuidao_Duoxiu", pPlayer.szName, nGerne);
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("进入洗髓岛多修，修的是第%d修。", nGerne));
	pPlayer.NewWorld(self.XISUIDAOMAPID, 1652, 3389);
	pPlayer.Msg("Vào Tẩy Tủy Đảo, ngươi có thể chọn Phụ tu môn phái.");
end

-- 
-- nGerneҪڼ
function Xisuidao:EnterXisuidao_ModifyDuoXiu(pPlayer, nGerne)
	local nRet, szMsg = Map:CheckTagServerPlayerCount(self.XISUIDAOMAPID)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	
	Faction:InitChangeFaction(pPlayer);
	local nCurGerneCount = #Faction:GetGerneFactionInfo(pPlayer);
	assert(nGerne >= 2 and nGerne <= nCurGerneCount);
	
	local nRes = self:CanModifyDuoxiu(pPlayer);
	if nRes == 0 then
		return;
	end
	
	local nCurrModifyNum = Faction:GetModifyFactionNum(pPlayer);
	Faction:SetModifyFactionNum(pPlayer, nCurrModifyNum + 1);
	Faction:SetChangeGenreIndex(pPlayer, nGerne);
	
	Faction:WriteLog(Dbg.LOG_INFO, "EnterXisuidao_ModifyDuoxiu", pPlayer.szName, nGerne);
	pPlayer.NewWorld(self.XISUIDAOMAPID, 1652, 3389);
	pPlayer.Msg("Vào Tẩy Tủy Đảo, ngươi có thể đổi Phụ tu môn phái.");
	local szLogMsg = string.format("进入洗髓岛更换辅修门派， 换的是第%d修。", nGerne);
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLogMsg);
end

-- жϸϴĻ
function Xisuidao:AwardFreeEnter(pPlayer)
	for _, nTaskId in ipairs(self.tbLevelInfo) do
		local nTime = KGblTask.SCGetDbTaskInt(nTaskId);
		if (nTime > 0) then
			local nAwardFlag = 0;
			local nFreeFlag = pPlayer.GetTask(self.TSKGROUP, self.TSKID_AWARDFREE);
			if (nFreeFlag <= 0) then
				if (nTime < GetTime()) then
					nAwardFlag = 1;
				end
			else
				if (nTime > nFreeFlag) then
					nAwardFlag = 1;
				end
			end
			if (nAwardFlag == 1) then
				local szMsg = "Vào Tẩy Tủy Đảo";
				local tbOpt = {
						{"Ta muốn đi bây giờ", self.OnFreeEnter, self, pPlayer, nTime},
						{"Kết thúc đối thoại"},
					};
				Setting:SetGlobalObj(pPlayer);
				Dialog:Say(szMsg, tbOpt);
				Setting:RestoreGlobalObj();
				return 1;
			end
		else
			break;
		end
	end
	return 0;
end

function Xisuidao:OnEnter(pPlayer, nCount)
	local nRet, szMsg = Map:CheckTagServerPlayerCount(self.XISUIDAOMAPID)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	-- жϰǷ㹻
	if (0 < nCount) then
		local nPaiCount = nCount;
		if (5 < nCount) then
			nPaiCount = 5;
		end
		local nLingpaiCount = pPlayer.GetItemCountInBags(18, 1, 79, 1);
		-- Ʋ
		if (nPaiCount > nLingpaiCount) then
			Setting:SetGlobalObj(pPlayer);
			Dialog:Say("Không đủ số lượng Lệnh bài Tẩy Tủy Đảo.");
			Setting:RestoreGlobalObj();
			return;
		end
		pPlayer.ConsumeItemInBags(nPaiCount, 18, 1, 79, 1);
	end
	if (5 > nCount) then
		nCount = nCount + 1;
		pPlayer.SetTask(self.TSKGROUP, self.TSKID_LINGPAICOUNT, nCount);
	end
	self:EnterXisuidao(pPlayer);
end

function Xisuidao:OnFreeEnter(pPlayer, nTime)
	local nRet, szMsg = Map:CheckTagServerPlayerCount(self.XISUIDAOMAPID)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	pPlayer.SetTask(self.TSKGROUP, self.TSKID_AWARDFREE, nTime);
	self:EnterXisuidao(pPlayer);
end

function Xisuidao:EnterXisuidao(pPlayer)
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Vao tay tuy dao");
	pPlayer.NewWorld(self.XISUIDAOMAPID, 1652, 3389);
	pPlayer.Msg("Vào Tẩy Tủy Đảo, có thể tẩy điểm tiềm năng và kỹ năng không giới hạn khi còn trên đảo.");
end

function Xisuidao:OnRecoverXisuidao(pPlayer)
	local nChangeGerneIndex = Faction:GetChangeGenreIndex(pPlayer);
	if nChangeGerneIndex > 0 then
		
		Faction:WriteLog(Dbg.LOG_INFO, "OnRecoverXisuidao", pPlayer.szName, nChangeGerneIndex);
		local szLogMsg = string.format("进入洗髓岛更换辅修门派， 换的是第%d修。", nChangeGerneIndex);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLogMsg);
		pPlayer.NewWorld(self.XISUIDAOMAPID, 1652, 3389);
		pPlayer.Msg("Vào Tẩy Tủy Đảo, ngươi có thể đổi Phụ tu môn phái.");
	end
end

Xisuidao:Init();

--?pl DoScript("\\script\\player\\xisuidao\\xisuidao.lua")