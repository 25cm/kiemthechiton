function GM:DoCommand(szCmd)
	DoScript("\\script\\misc\\gm.lua");	-- 每次都重载这个脚本
	print("GmCmd["..tostring(me and me.szName).."]:", szCmd);
	
	local fnCmd, szMsg	= loadstring(szCmd, "[GmCmd]");
	if (not fnCmd) then
		error("Do GmCmd failed:"..szMsg);
	else
		setfenv(fnCmd, GM);
		return fnCmd();
	end
end

if (MODULE_GC_SERVER) then
function GM:AddOnLine(szGate, szAccount, szName, nSDate, nEDate, szScript)
	return SpecialEvent.CompensateGM:AddOnLine(szGate, szAccount, szName, nSDate, nEDate, szScript);
end

function GM:AddOnNpc(szGate, szAccount, szName, nSDate, nEDate, tbAward)
	return SpecialEvent.CompensateGM:AddOnNpc(szGate, szAccount, szName, nSDate, nEDate, tbAward);
end

function GM:DelOnLine(szGate, szAccount, szName, nLogId, nGcManul, szResult)
	return SpecialEvent.CompensateGM:DelOnLine(szGate, szAccount, szName, nLogId, nGcManul, szResult);
end

function GM:DelOnNpc(szGate, szAccount, szName, nLogId, nGcManul, szResult)
	return SpecialEvent.CompensateGM:DelOnNpc(szGate, szAccount, szName, nLogId, nGcManul, szResult);
end

function GM:ClearDateOut()
	return SpecialEvent.CompensateGM:ClearDateOut();
end

function GM:SetFree(szPlayerName)	
	GlobalExcute{"Player:SetFree", szPlayerName};
end
function GM:Arrest(szPlayerName, nJailTerm)
	GlobalExcute{"Player:Arrest", szPlayerName, nJailTerm};
end

function GM:AddFriendFavorByHand(szAppName, szDstName, nFavor, nMethod)
	if (not szAppName or not szDstName or szAppName == szDstName or nFavor <= 0) then
		return;
	end
	local nAppId = KGCPlayer.GetPlayerIdByName(szAppName);
	local nDstId = KGCPlayer.GetPlayerIdByName(szDstName);
	local bByHand = 1;
	nMethod = nMethod or 0;
	local nCanAddFavor = Relation:CheckCanAddFavor(nAppId, nDstId, nFavor, nMethod);
	if (1 == nCanAddFavor) then
		KRelation.AddFriendFavor(nAppId, nDstId, nFavor, nMethod, bByHand);
		KRelation.SyncFriendInfo(nAppId, nDstId);
	end
end

function GM:ModifyIBWare(tbWareInfo, bSave)
	if (not tbWareInfo) then
		return;
	end
	
	IbShop:SaveIbshopCmd(tbWareInfo, bSave or 1);
	return ModifyIBWare(tbWareInfo);
end

function GM:AddIbWare(tbWareInfo)
	tbWareInfo = IbShop:PreEditIBWare(tbWareInfo);
	if (not tbWareInfo) then
		return;
	end
	
	return AddIBWare(tbWareInfo);
end

function GM:DelIbWare(tbWareInfo, bSave)
	if (not tbWareInfo) then
		return;
	end
	
	return DelIBWare(tbWareInfo);
end

function GM:ShowAllWareInfo()
	local tbWareInfo = ShowAllWareInfo();
	Lib:ShowTB(tbWareInfo);
end

else	-- if (MODULE_GC_SERVER) then

function GM:GMFindAllRoom(varItem)
	local tbResult = {};
	local tbRoom = {};
	Lib:MergeTable(tbRoom, Item.BAG_ROOM );
	Lib:MergeTable(tbRoom, Item.REPOSITORY_ROOM );
	Lib:MergeTable(tbRoom, {Item.ROOM_RECYCLE, Item.ROOM_EQUIP, Item.ROOM_EQUIPEX} );
	
	for _, nRoom in ipairs(tbRoom) do
		local tbFind;
		if type(varItem) == "string" then
			tbFind = me.FindClassItem(nRoom, varItem);
		elseif type(varItem) == "table" then
			tbFind = me.FindItem(nRoom, unpack(varItem));
		else
			Dbg:WriteLog("_GM_XF", "FindItemError", type(varItem), varItem);
		end
		if (tbFind) then
			for _, tbItem in ipairs(tbFind) do
				tbItem.nRoom = nRoom;
			end
			Lib:MergeTable(tbResult, tbFind);
		end
	end
	return tbResult;
end

function GM:ClearPlayerXuan(tbXuan)
	local tbXJ = self:GMFindAllRoom("xuanjing");
	for _, tbItem in pairs(tbXJ) do 
		local nL = tbItem.pItem.nLevel;
		if tbXuan[nL] and tbItem.pItem.IsBind() ~= 1 and tbXuan[nL][1] > 0 then 
			local nRet = me.DelItem(tbItem.pItem);
			if nRet == 1 then 
				tbXuan[nL][1] = tbXuan[nL][1] - 1;
				Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ 1"..nL.." Huyền (không khóa)");
			end 
		elseif tbXuan[nL] and tbItem.pItem.IsBind() == 1 and tbXuan[nL][2] > 0 then
			local nRet = me.DelItem(tbItem.pItem);
			if nRet == 1 then 
				tbXuan[nL][2] = tbXuan[nL][2] - 1;
				Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ 1"..nL.." Huyền (khóa)");
			end 
		end 
	end
end


function GM:_ClearOneItem(pItem, bBind, nNum, fnCheck)
	local nCount = pItem.nCount
	local tbBindInfo = {[0] = "Vật phẩm không khóa", [1] = "Vật phẩm khóa"};
	if (nNum > 0) and (pItem.IsBind() == bBind) and 
		(not fnCheck or fnCheck(pItem) == 1) then
		local szName = pItem.szName;
		if nNum >= nCount then
			local nRet = me.DelItem(pItem);
			if nRet then
				nNum = nNum - nCount;
				Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ "..tbBindInfo[bBind], nCount.." ", szName);
			end
		else
			pItem.SetCount(nCount - nNum);
			Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ "..tbBindInfo[bBind], nCount.." ", szName);
			nNum = 0;
		end
	end
	return nNum;
end


function GM:ClearPlayerItem(varItem, nBindNum, nUnBindNum, fnCheck)
	local tbFind = self:GMFindAllRoom(varItem);
	for _, tbItem in ipairs(tbFind) do
		if nBindNum > 0 and tbItem.pItem.IsBind() == 1 then
			nBindNum = self:_ClearOneItem(tbItem.pItem, 1, nBindNum, fnCheck)
		elseif nUnBindNum > 0 and tbItem.pItem.IsBind() == 0 then
			nUnBindNum = self:_ClearOneItem(tbItem.pItem, 0, nUnBindNum, fnCheck)
		end
	end
	if nBindNum > 0 then
		Dbg:WriteLog("_GM_XF", me.szName, " còn lại chưa khấu trừ"..nBindNum.." ");
	end
	if nUnBindNum > 0 then
		Dbg:WriteLog("_GM_XF", me.szName, " còn lại chưa khấu trừ"..nUnBindNum.." ");
	end
	if nBindNum == 0 and nUnBindNum == 0 then
		Dbg:WriteLog("_GM_XF", me.szName, " khấu trừ thành công");
	end
end

function GM:DegradeEquip(tbEquip)
	for _, tbPos in ipairs(tbEquip) do 
		local pEquip = me.GetItem(unpack(tbPos));
		if pEquip then 
			local nEnhTimes = math.max(0,pEquip.nEnhTimes - math.abs(tbPos[4]));
			pEquip.Regenerate(
				pEquip.nGenre,
				pEquip.nDetail,
				pEquip.nParticular,
				pEquip.nLevel,
				pEquip.nSeries,
				nEnhTimes,
				pEquip.nLucky,
				pEquip.GetGenInfo(),
				0,
				pEquip.dwRandSeed,
				0
			); 
			Dbg:WriteLog("_GM_XF", me.szName, pEquip.szName, "Cấp cường hóa giảm còn cấp "..pEquip.nEnhTimes.."");
		end 
	end
end

function GM:ClearMoney(nMoney, nBindMoney, nBindCoin)
	if me.CostMoney(nMoney, 0)==1 then
		Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ bạc thành công "..nMoney);
	else
		local nCurMoney = me.nCashMoney;
		me.CostMoney(nCurMoney);
		Dbg:WriteLog("_GM_XF", me.szName, "Bạc cần khấu trừ "..nMoney, "Thực khấu "..nCurMoney);
	end
	
	if me.CostBindMoney(nBindMoney, Player.emKBINDMONEY_COST_GM) ==1 then
		Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ bạc khóa thành công "..nBindMoney);
	else
		local nCurMoney = me.GetBindMoney();
		me.CostBindMoney(nCurMoney, Player.emKBINDMONEY_COST_GM);
		Dbg:WriteLog("_GM_XF", me.szName, "Bạc khóa cần khấu trừ "..nBindMoney, "Thực khấu "..nCurMoney);
	end 
	
	if me.AddBindCoin(-nBindCoin, Player.emKBINDCOIN_COST_GM) ==1 then
		Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ Đồng khóa thành công "..nBindCoin);
	else
		local nCurMoney = me.nBindCoin;
		me.AddBindCoin(-nCurMoney, Player.emKBINDCOIN_COST_GM);
		Dbg:WriteLog("_GM_XF", me.szName, "Đồng khóa cần khấu trừ "..nBindCoin, "Thực khấu "..nCurMoney);
	end 
end

function GM:DelPlayerRoomItem(tbItem)
	for _, tbRoom in ipairs(tbItem) do
		local pItem = me.GetItem(unpack(tbRoom));
		if pItem then
			local szName = pItem.szName;
			if me.DelItem(pItem) == 1 then
				Dbg:WriteLog("_GM_XF", me.szName, "Khấu trừ vật phẩm nhân vật", szName);
			end
		else
			Dbg:WriteLog("_GM_XF", me.szName, "Không thể thu vật phẩm của nhân vật", unpack(tbRoom));
		end
	end
end

end		-- if (MODULE_GC_SERVER) then	else

setmetatable(GM, {__index=_G});
setfenv(1, GM);

function GetRobot(nFromId, nToId)
	local tbAllPlayer	= KPlayer.GetAllPlayer();
	local tbRobot		= {};
	local nCount	= 0;
	nToId	= nToId or nFromId;
	for _, pPlayer in pairs(tbAllPlayer) do
		local szName	= pPlayer.szAccount;
		if (string.sub(szName, 1, 5) == "robot") then
			local nRobotId	= tonumber(string.sub(szName, 6));
			if (nRobotId and nRobotId >= nFromId and nRobotId <= nToId) then
				nCount	= nCount + 1;
				tbRobot[nRobotId]	= pPlayer;
			end
		end
	end
	
	return tbRobot, nCount;
end

function CallRobot(nFromId, nToId, nRange)
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	local tbRobot, nCount	= GetRobot(nFromId, nToId);
	nRange	= nRange or 0;
	nMapX	= nMapX - nRange - 1;
	nMapY	= nMapY - nRange - 1;
	for _, pPlayer in pairs(tbRobot) do
		pPlayer.NewWorld(nMapId, nMapX + MathRandom(nRange * 2 + 1), nMapY + MathRandom(nRange * 2 + 1));
	end
	me.Msg(nCount.." robot(s) called!");
end

function PowerUp(nLevel)
	if (nLevel) then
		ST_LevelUp(nLevel);
	end
	me.AddFightSkill("Thê Vân Tung", 60);
	me.AddFightSkill("Vô Hình Cổ", 60);
	me.Earn(10000000, 0);			-- 1000W银子
end

function BuildTong()
	me.SetCurCamp(4)
	SetCamp(4)
	SetTask(99, 1)
	CreateTong(1)
	AddLeadExp(10011100)
end

function ShowOnline()
	me.Msg("Srv:["..GetServerName().."] Online:"..KPlayer.GetPlayerCount());
end
function ShowGMCmd()
	Say("GM Command List",7,"DoSct","RunSctFile","ReloadSct","ReloadAll","ShowGMCmd","GetPlayerInfo","Woooo!");
end

function RESTORE()
	me.RestoreMana();
	me.RestoreLife();
	me.RestoreStamina();
end

function CallNpc(varNpcIdOrName, nLevel, nSeries, nNoRevive, nGoldType)
	local w,x,y = me.GetWorldPos();
	local 	mapindex = SubWorldID2Idx(w);
	if (mapindex < 0 ) then
		me.Msg("Get MapIndex Error.");
		return
	end
	local nNpcId	= 0;
	if (type(varNpcIdOrName) == "string") then
		nNpcId	= KNpc.GetTemplateIdByName(varNpcIdOrName);
		if (nNpcId <= 0) then
			me.Msg("Npc:%s not found!", varNpcIdOrName);
			return;
		end
	else
		nNpcId	= varNpcIdOrName;
	end
	local nRet	= KNpc.Add2(nNpcId, nLevel or 1, nSeries or 0, w, x, y, nNoRevive or 1, nGoldType or 0)
	me.Msg("AddNpc:"..varNpcIdOrName.." ("..tostring(nRet)..")");
	return nRet;
end

function ShowTask(nGroup, nTaskId)
	me.Msg("Get task: "..me.GetTask(nGroup, nTaskId));
end

function CheckTask()
	local tbTask	= me.GetAllTask();
	local tbId		= {};
	for nId, nValue in pairs(tbTask) do
		tbId[#tbId+1]	= nId;
	end
	table.sort(tbId);
	local tbBack	= {};
	for _, nId in ipairs(tbId) do
		tbBack[#tbBack+1]	= {nId, tbTask[nId]};
	end
	tbBack[#tbBack+1]	= {0xffffffff, 0};	-- 保护
	
	local tbBackTask	= GM.tbBackTask or {};
	GM.tbBackTask		= tbBackTask;
	
	local tbBackOld	= tbBackTask[me.szName] or {{0xffffffff, 0}};
	local nIdx1	= 1;
	local nIdx2	= 1;
	local nCount	= math.max(#tbBackOld, #tbBack) - 1;
	local nDifCount	= 0;
	while (nIdx1 <= nCount and nIdx2 <= nCount) do
		local tbTask1	= tbBackOld[nIdx1];
		local tbTask2	= tbBack[nIdx2];
		local nId		= 0;
		local nValue1	= 0;
		local nValue2	= 0;
		if (tbTask1[1] > tbTask2[1]) then
			nId		= tbTask2[1];
			nValue2	= tbTask2[2];
			nIdx2	= nIdx2 + 1;
		elseif (tbTask1[1] < tbTask2[1]) then
			nId		= tbTask1[1];
			nValue1	= tbTask1[2];
			nIdx1	= nIdx1 + 1;
		else
			nId		= tbTask1[1];
			nValue1	= tbTask1[2];
			nValue2	= tbTask2[2];
			nIdx1	= nIdx1 + 1;
			nIdx2	= nIdx2 + 1;
		end
		if (nValue1 ~= nValue2) then
			nDifCount	= nDifCount + 1;
			print(string.format("%d,%d\t%d => %d", math.floor(nId/65536), math.mod(nId,65536), nValue1, nValue2));
		end
	end	
	
	print("Different Count:", nDifCount);
	tbBackTask[me.szName]	= tbBack;
end


function AddScrollTask()
	ScrollTask:AddScroll();
end

function AddScrollTaskByNum(szNum)
	szNum = tonumber(szNum, 16);
	ScrollTask:AddScroll(szNum);
end

function StartRandomTask(nTaskId)
	RandomTask:OnStart();
end

function ShowWorldPos()
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg(string.format("%d,\t%d,\t%d", nMapId, nMapX, nMapY));
end

function OutputWorldPos(szPosName)
	if (szPosName == nil) then
		szPosName = "";
	end
	
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg(string.format("<color=yellow>%s<color>:\t%d,\t%d,\t%d", szPosName, nMapId, nMapX, nMapY));
	
	if (g_szPosOutputFileKey == nil) then
		g_szPosOutputFileKey = "pos_output";
		if (KFile.TabFile_Load("\\log\\pos_output.txt", g_szPosOutputFileKey, "true") ~= 1) then
			me.Msg("Mở file \\log\\pos_output.txt thất bại");
			return;
		end
	end
	local nFileRowCount = KFile.TabFile_GetRowCount(g_szPosOutputFileKey);
	if (nFileRowCount == 0) then
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 1, "POS_NAME");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 2, "MAP_ID");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 3, "MAP_X");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 4, "MAP_Y");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 5, "MINIMAP_X");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 6, "MINIMAP_Y");
		nFileRowCount = 1;
	end
	local nPosNameRow = KFile.TabFile_Search(g_szPosOutputFileKey, 1, szPosName, 1);
	if (nPosNameRow <= 0) then
		nPosNameRow = nFileRowCount + 1;
	end
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 1, szPosName);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 2, nMapId);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 3, nMapX);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 4, nMapY);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 5, math.floor(nMapX / 8));
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 6, math.floor(nMapY / 16));
	KFile.TabFile_Save(g_szPosOutputFileKey);
end

function LPAI(nCount)
	if (nCount < 1) then
		me.Msg("Số lượng không đúng");
		return;
	end
	for i=1, nCount do
		me.AddItem(18, 1, 79, 1);
	end
end

function TI(nSelect)
	local tbItem	= Item:GetClass("tempitem");
	if (nSelect == 1) then
		tbItem:OnTransPak(tbItem.tbMap);
	elseif (nSelect == 2) then
		tbItem:OnSkillPak();
	elseif (nSelect == 3) then
		GM.tbPlayer:Main();
	else
		Dialog:Say("-= Đạo cụ tạm thời =-\n\nĐỉnh~~<pic=47>",
			{"Túi Truyền Tống", TI, 1},
			{"Túi Kỹ Năng", TI, 2},
			{"Túi Người Chơi", TI, 3},
			{"Kết thúc đối thoại"}
		);
	end
end

function sj()
	Battle:GM();
end

function KickOutAccount()
	
end

function Msg2Player(varValue)
	me.Msg(tostring(varValue))
end

function LoadLevelLadder()
	GCExcute({"Ladder:LoadLevelLadder"});
end

function SetGongXun()
	GCExcute({"Battle:UpdateRank"});
end

function GetLadder(nType)
	local tbLadder, szContext = GetShowLadder(nType);
	if (not tbLadder) then
		print("Không có bảng xếp hạng");
		return;
	end
	print("szContext = ", szContext);
	for key, value in pairs(tbLadder) do
		print(key);
		if (value) then
			for ke, pv in pairs(value) do
				print(ke, pv);
			end
		end
	end
end

function ShowMapStat()
	local tbPlayer = KPlayer.GetAllPlayer();
	local tbCount = {};
	for _, pPlayer in pairs(tbPlayer) do
		local nMapId = pPlayer.nMapId;
		local nCount = tbCount[nMapId] or 0;
		tbCount[nMapId] = nCount + 1;
	end
	for nMapId, nCount in pairs(tbCount) do
		print("Map["..nMapId.."]: ", nCount, GetMapNameFormId(nMapId));
	end
end

function _linktask(n)
	me.ChangeCurMakePoint(1000000);
	me.ChangeCurGatherPoint(1000000);
	for i=1, n do
		for j=2, 18, 2 do
			for k=1, 3 do
				me.AddItem(22, 1, j, k);
			end
		end 
	end
	for n=1,10 do 
		LifeSkill:SetSkillLevel(me, n, 100) 
	end
	for i=1, n do
		for j=66, 68 do
			for k=1, 4 do
				me.AddItem(18,1,j,k);
			end
		end
	end
end

function _stlt(level, year, month, day, hour, min)
	local tbDate = { year = year,month = month,day = day,hour = hour or 0, min = min or 0};
	local nSecTime =  Lib:GetSecFromNowData(tbDate);
	Player.tbOffline.tbOpenLevelLimitTime[level] = nSecTime;
end

function _ofl()
	Player.tbOffline:GM();
end

function _gett(nTime)
	local tbDate = os.date("*t", nTime);
	print("========================")
	for key, value in pairs(tbDate) do
		print("key, value = ", key, value);
	end
	print("========================")
end

function AddDNews(nKey, szTitle, szMsg, nEndTime)
	local nTime = GetTime() + nEndTime; 
	Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nTime, GetTime());
end


function AddMyManPaiNew()
	if (me.nFaction <= 0) then
		me.Msg("Chưa gia nhập môn phái");
		return;
	end
	GCExcute({"FactionBattle:InitFactionNewsTable"});
	GCExcute({"FactionBattle:RecNewsForNewsMan", me.nFaction, me.szName});
end

function AddMyDa()
	if (me.nFaction <= 0) then
		me.Msg("Chưa gia nhập môn phái");
		return;
	end
	local tbManPai = {};
	tbManPai[me.nFaction] = me.szName;
	GCExcute({"FactionElect:RecNewsForMenPaiDaShiXiong", tbManPai});
end

function GM:KickOut(szName)
	local nId = KGCPlayer.GetPlayerIdByName(szName);
	if not nId or nId <= 0 then
		return szName.." rolename is not exist";
	end	
	if (MODULE_GC_SERVER) then
		return GlobalExcute{"GM:KickOut", szName};
	else	
		local pPlayer=KPlayer.GetPlayerObjById(nId);
		if pPlayer then
		  pPlayer.KickOut();
		end
	end
end
