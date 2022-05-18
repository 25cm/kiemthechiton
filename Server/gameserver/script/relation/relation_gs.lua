-----------------------------------------------------
--文件名		：	relation_gs.lua
--创建者		：	zouying@kingsoft.net
--创建时间		：	2008-11-06
--功能描述		：	人际关系服务器脚本
------------------------------------------------------
if (not MODULE_GAMESERVER) then
	return;
end

Relation.tbc2sFun = {}

function Relation:AddAwared(pPlayerApp, szDstName, tbData)
	
	if (not tbData or not szDstName or not pPlayerApp) then
		return 0;
	end
	local nBindCoin = 0;
	local szMsg = "";
	if (tbData.nAwardApp == 1) then
		 szMsg = self:GetShowMsg(szDstName, tbData.nLevel, tbData.nAwardCoin, tbData.nAppGiveCount, tbData.nAppLeftCount, tbData.nAppHaveCount);
		pPlayerApp.Msg(szMsg);
		nBindCoin = (tbData.nAppGiveCount + 1)* tbData.nAwardCoin;		
		pPlayerApp.AddBindCoin(nBindCoin, Player.emKBINDCOIN_ADD_RELATION);
	end
	
	return 1;
end

function Relation:GetShowMsg(szDstName, nLevel, nAward, nGiveCount, nLeftCount, nHaveCount)
	local szMsg = string.format("Bạn và <color=yellow>%s<color> độ thân mật lên cấp %d, nhận được %d %s.", szDstName, nLevel, nAward, IVER_g_szCoinName);
									
	local szMsgInfo = string.format("Ngoài ra, 1 hảo hữu có thể nhận được phần thưởng %d lần, Mật hữu có thể nhận thưởng <color=yellow>%d lần<color>.", nGiveCount, nLeftCount);
	local szMsgOtherInfo = string.format("Bạn và %d thân mật tăng lên, nhận được %d phần thưởng cấp %d. Còn có thể nhận thưởng <color=yellow>%d lần<color>.", nLevel, nHaveCount, nLevel, nLeftCount);
	local szLastMsg = "";					
	if (nGiveCount == 0) then
		szLastMsg = szMsg ..szMsgOtherInfo;
	else
		szLastMsg = szMsg .. szMsgInfo;
	end
	return szLastMsg;
end

function Relation:CanDoRelationOpt(szAppName)
	local szErrMsg = "";
	if (not szAppName) then
		return 0, szErrMsg;
	end
	local pAppPlayer = KPlayer.GetPlayerByName(szAppName);
	if (pAppPlayer.IsAccountLock() ~= 0) then
		szErrMsg = "Tài khoản đang ở trạng thái khóa, không thể thực hiện.";
		return 0, szErrMsg;
	end
	return 1;
end

-- 添加人际关系
-- 参数分别为申请人姓名，对方姓名，关系类型，是否是主位（0表示次位，1表示主位，默认为1）
function Relation:AddRelation_GS(szAppName, szDstName, nType, nRole)
	if (not szAppName or not szDstName or not nType or szAppName == szDstName or
		0 == self:CheckRelationType(nType)) then
		return;
	end
	local pAppPlayer = KPlayer.GetPlayerByName(szAppName);
	if (not pAppPlayer) then
		return;
	end
	local nCanOpt, szErrMsg = self:CanDoRelationOpt(szAppName);
	if (0 == nCanOpt) then
		if ("" ~= szErrMsg) then
			pAppPlayer.Msg(szErrMsg);
		end
		return;
	end
	nRole = nRole or 1;
	if (0 ~= nRole and 1 ~= nRole) then
		nRole = 1;
	end
	if (KPlayer.CheckRelation(szAppName, szDstName, nType) == 1) then
		pAppPlayer.Msg(string.format("Thêm thất bại, Bạn và [%s] đã có mối quan hệ khác, có thể là sổ đen hoặc cừu sát hãy kiểm tra lại.", szDstName));
		return;
	end
	
	GCExcute{"Relation:AddRelation_GC", szAppName, szDstName, nType, nRole};
end

function Relation:AddRelation_C2S(szDstName, nType, nRole)
	local szAppName = me.szName;
	if (not szAppName or not szDstName or not nType or szAppName == szDstName or
		0 == self:CheckRelationType(nType)) then
		return;
	end
	nRole = nRole or 1;
	if (0 ~= nRole and 1 ~= nRole) then
		nRole = 1;
	end
	self:AddRelation_GS(szAppName, szDstName, nType, nRole);
end
Relation.tbc2sFun["AddRelation_C2S"] = Relation.AddRelation_C2S;

-- 删除人际关系
-- 参数分别为申请人姓名，对方姓名，关系类型，是否是主位（0表示次位，1表示主位，默认为1）
function Relation:DelRelation_GS(szAppName, szDstName, nType, nRole)
	if (not szAppName or not szDstName or not nType or szAppName == szDstName or
		0 == self:CheckRelationType(nType)) then
		return;
	end
	local pAppPlayer = KPlayer.GetPlayerByName(szAppName);
	if (not pAppPlayer) then
		return;
	end
	local nCanOpt, szErrMsg = self:CanDoRelationOpt(szAppName);
	if (0 == nCanOpt) then
		if ("" ~= szErrMsg) then
			pAppPlayer.Msg(szErrMsg);
		end
		return;
	end
	nRole = nRole or 1;
	if (0 ~= nRole and 1 ~= nRole) then
		nRole = 1;
	end
	if (KPlayer.CheckRelation(szAppName, szDstName, nType) == 0) then
		return;
	end
	
	GCExcute{"Relation:DelRelation_GC", pAppPlayer.nId, szDstName, nType, nRole};
	
end

function Relation:DelRelation_C2S(szDstName, nType, nRole)
	local szAppName = me.szName;
	if (not szAppName or not szDstName or not nType or szAppName == szDstName or
		0 == self:CheckRelationType(nType)) then
		return;
	end
	nRole = nRole or 1;
	if (0 ~= nRole and 1 ~= nRole) then
		nRole = 1;
	end
	
	-- 某些特殊的关系，不允许通过客户端发送指令来删除
	if (nType == Player.emKPLAYERRELATION_TYPE_COUPLE or
		nType == Player.emKPLAYERRELATION_TYPE_TRAINED or
		nType == Player.emKPLAYERRELATION_TYPE_TRAINING or
		nType == Player.emKPLAYERRELATION_TYPE_BUDDY) then
		return;
	end
	
	self:DelRelation_GS(szAppName, szDstName, nType, nRole);
end
Relation.tbc2sFun["DelRelation_C2S"] = Relation.DelRelation_C2S;

-- 增加亲密度
-- nMethod 增加亲密度途径 0正常途径，1通过ib道具（默认是0）
function Relation:AddFriendFavor(szAppName, szDstName, nFavor, nMethod)
	nMethod = nMethod or 0;
	if (nMethod ~= 0 and nMethod ~= 1) then
		nMethod = 1;
	end
	if (not szAppName or not szDstName or szAppName == szDstName or nFavor <= 0) then
		return;
	end
	local pAppPlayer = KPlayer.GetPlayerByName(szAppName);
	if (not pAppPlayer) then
		return;
	end
	
	-- 不是好友关系，不添加亲密度
	if (KPlayer.CheckRelation(szAppName, szDstName, Player.emKPLAYERRELATION_TYPE_BIDFRIEND, 1) == 0) then
		return;
	end
	
	GCExcute{"Relation:AddFriendFavor_GC", szAppName, szDstName, nFavor, nMethod};
end

function Relation:GetMsgById(nPlayerId, szDstName, nType, nMsgId)
	if (nMsgId < 0) then
		return;
	end
	
	local szMsg = "";
	if (nMsgId == self.emKEADDRELATION_SUCCESS) then
		if (nType == Player.emKPLAYERRELATION_TYPE_ENEMEY) then
			szMsg = string.format("Bạn đã thêm [%s] vào danh sách kẻ thù.", szDstName);
		elseif (nType == Player.emKPLAYERRELATION_TYPE_BLACKLIST) then
			szMsg = string.format("Bạn đã thêm [%s] vào danh sách đen.", szDstName);
		elseif (nType == Player.emKPLAYERRELATION_TYPE_TMPFRIEND) then
			szMsg = string.format("Bạn và [%s] trở thành hảo hữu.", szDstName);
		end
	elseif (nMsgId == self.emKEHAVE_RELATION) then
		szMsg = string.format("Thêm thất bại, Bạn và [%s]  đã có mối quan hệ khác, có thể là sổ đen hoặc cừu sát hãy kiểm tra lại.", szDstName);
	elseif (nMsgId == self.emKEPLAYER_NOTONLINE) then
		szMsg = "Thêm thất bại, người bạn chỉ định không có trên mạng.";
	else
		if (nType == Player.emKPLAYERRELATION_TYPE_BINDFRIEND or
			nType == Player.emKPLAYERRELATION_TYPE_SIBLING) then
			szMsg = string.format("Thêm thất bại, [%s] đã có trong danh sách quan hệ của bạn.", szDstName);
		else
			szMsg = "Thêm thất bại, người chơi không tồn tại hoặc không đáp ứng điều kiện trở thanh hảo hữu của bạn.";
		end
	end
	
	return szMsg;
end

function Relation:TellPlayerMsg_GS(nPlayerId, szDstName, nType, nMsgId)
	if (nPlayerId <= 0 or nMsgId < 0) then
		return;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local szMsg = self:GetMsgById(nPlayerId, szDstName, nType, nMsgId);
	if (szMsg) then
		pPlayer.Msg(szMsg);
	end
end

-- 在玩家上线的时候获取密友关系即将一年到期的信息，并且给出玩家提示
function Relation:GetCloseFriendTimeInfo_GS(bExchangeServerComing)
	if (not bExchangeServerComing or 1 == bExchangeServerComing) then
		return;
	end
	
	local nPlayerId = me.nId;
	if (nPlayerId <= 0) then
		return;
	end
	
	local tbCloseFrientList = me.GetRelationList(Player.emKPLAYERRELATION_TYPE_BUDDY);
	local tbTrainedList = me.GetRelationList(Player.emKPLAYERRELATION_TYPE_TRAINED, 1);
	local tbIntroduceList = me.GetRelationList(Player.emKPLAYERRELATION_TYPE_INTRODUCTION, 1);
	if (#tbCloseFrientList == 0 and #tbTrainedList == 0 and #tbIntroduceList == 0) then
		return;
	end
	
	GCExcute{"Relation:GetCloseFriendTimeInfo_GC", nPlayerId};
end

-- tbTimeInfo = {{"nPlayerId" = XXX, "nTime" = XXX}, {}, ...}
function Relation:GetCloseFriendTimeInfo_GS2(nPlayerId, tbTimeInfo)
	if (Lib:CountTB(tbTimeInfo) == 0 or nPlayerId <= 0) then
		return;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local tbRelationName = {
		[Player.emKPLAYERRELATION_TYPE_BUDDY] = "Mật Hữu",
		[Player.emKPLAYERRELATION_TYPE_INTRODUCTION] = "Giới thiệu về Mật Hữu",
		[Player.emKPLAYERRELATION_TYPE_TRAINED] = "Quan hệ Mật Hữu"
		};
	
	local szMsg = "";
	for _, tbInfo in pairs(tbTimeInfo) do
		local nTime = tbInfo.nTime;
		local nRemainDay = math.floor(nTime / (24 * 3600));
		if (nTime >= 0 and nRemainDay >= 0 and nRemainDay < self.TIME_NOTIFYONEYEAR and
			tbRelationName[tbInfo.nType]) then
			szMsg = szMsg .. string.format("Bạn và <color=yellow>%s<color> %s sẽ hết hạn sau 1 tuần nữa.", tbInfo.szPlayerName,
				tbRelationName[tbInfo.nType]);
			pPlayer.Msg(szMsg);
			szMsg = "";
		end
	end
end

-- 开除当前弟子
function Relation:DelTrainingStudent(szStudentName)
	local tbNpc	= Npc:GetClass("renji");
	tbNpc:DelTrainingStudent1(szStudentName);
end
Relation.tbc2sFun["DelTrainingStudent"] = Relation.DelTrainingStudent;

function Relation:AddShituTitle_GS(szStudentName, szTeacherName)
	local pStudent = KPlayer.GetPlayerByName(szStudentName);
	local pTeacher = KPlayer.GetPlayerByName(szTeacherName);
	local nTitleEndTime = GetTime() + 3600 * 24 * 365 * 10;	-- 称号的有效期上线暂定为10年
	
	-- 为徒弟增加自定义称号
	if (pStudent) then
		local szStudentTitle = szTeacherName .. "Sư Đồ";
		pStudent.AddSpeTitle(szStudentTitle, nTitleEndTime, "gold");
		EventManager:WriteLog("Quan he su do"..szStudentTitle, pStudent);
	end
	
	-- 为师傅增加自定义称号，如果原来已经有其他的师徒称号，替换掉
	if (pTeacher) then
		local szCurTitle, szPlayerName = Relation:FindTitleAndName("Sư Phụ", pTeacher);
		if (szCurTitle and szPlayerName) then
			pTeacher.RemoveSpeTitle(szCurTitle);
		end
		local szTeacherTitle = szStudentName .. "Sư Phụ";
		pTeacher.AddSpeTitle(szTeacherTitle, nTitleEndTime, "gold");
		EventManager:WriteLog("Quan he su do"..szTeacherTitle, pTeacher);
	end
end

-- 为师徒双发发放师徒传送符
function Relation:SendChuansongfu_GS(nStudentId, nTeacherId)
	local pStudent = KPlayer.GetPlayerObjById(nStudentId);
	local pTeacher = KPlayer.GetPlayerObjById(nTeacherId);
	
	if (pStudent) then
		Setting:SetGlobalObj(pStudent);
		local tbNpc	= Npc:GetClass("renji");
		tbNpc:GetShiTuChuanSongFu(1);
		Setting:RestoreGlobalObj();
	end
	
	if (pTeacher) then
		Setting:SetGlobalObj(pTeacher);
		local tbNpc	= Npc:GetClass("renji");
		tbNpc:GetShiTuChuanSongFu(1);
		Setting:RestoreGlobalObj();
	end
end

-- 注册通用上线事件
PlayerEvent:RegisterGlobal("OnLogin", Relation.GetCloseFriendTimeInfo_GS, Relation);
