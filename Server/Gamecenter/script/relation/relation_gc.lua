-- 文件名　：relation_gc.lua
-- 创建者　：furuilei
-- 创建时间：2009-08-03 10:25:21
-- 功能描述：gamecenter的人际关系逻辑

if (not MODULE_GC_SERVER) then
	return;
end

-- 判断是否可以添加关系
function Relation:CheckCanAddRelation(nAppId, nDstId, nType, nRole)
	-- 对方不在线
	local nDstOnline = KGCPlayer.OptGetTask(nDstId, KGCPlayer.TSK_ONLINESERVER);
	if (nDstOnline <= 0) then
		return self.emKEPLAYER_NOTONLINE;
	end
	
	-- 数据没有加载完
	local nAppIsLoadEnd = KRelation.CheckIsLoadEnd(nAppId);
	local nDstIsLoadEnd = KRelation.CheckIsLoadEnd(nDstId);
	if (nAppIsLoadEnd == 0 or nDstIsLoadEnd == 0) then
		return self.emKEADDRELATION_FAIL;
	end
	
	-- 检查冲突和依赖关系
	local nCheckDepRep = KRelation.CheckCreateDepRep(nType, nRole, nAppId, nDstId);
	if (0 == nCheckDepRep) then
		return self.emKEADDRELATION_FAIL;
	end
	
	-- 是否可以添加关系
	local nCanAddRelation = KRelation.CanCreateRelation(nType, nRole, nAppId, nDstId);
	if (nCanAddRelation == 0) then
		return self.emKEADDRELATION_FAIL;
	end
	
	return self.emKEADDRELATION_SUCCESS;
end

-- 添加关系
function Relation:AddRelation_GC(szAppName, szDstName, nType, nRole)	
	local nAppId = KGCPlayer.GetPlayerIdByName(szAppName);
	local nDstId = KGCPlayer.GetPlayerIdByName(szDstName);
	if (not nAppId or not nDstId or nAppId <= 0 or nDstId <= 0) then
		return;
	end
	
	local nResult = self:CheckCanAddRelation(nAppId, nDstId, nType, nRole);
	if (nResult ~= self.emKEADDRELATION_SUCCESS) then
		self:TellPlayerMsg_GC(nAppId, szDstName, nType, nResult);
		return;
	else
		nResult = KRelation.CreateRelation(nType, nAppId, nDstId, nRole);
		self:TellPlayerMsg_GC(nAppId, szDstName, nType, nResult);
	end
end

-- 判断是否可以删除关系
function Relation:CheckCanDelRelation(nAppId, nDstId, nType, nRole)
	-- 数据是否加载完成
	local nAppIsLoadEnd = KRelation.CheckIsLoadEnd(nAppId);
	if (nAppIsLoadEnd == 0) then
		return 0;
	end
	
	-- 检查冲突和依赖关系
	local nCheckDepRep = KRelation.CheckDelDepRep(nType, nRole, nAppId, nDstId);
	if (0 == nCheckDepRep) then
		return 0;
	end
	
	return 1;
end


-- 删除关系
function Relation:DelRelation_GC(nAppId, szDstName, nType, nRole)
	local nDstId = KGCPlayer.GetPlayerIdByName(szDstName);
	if (not nDstId or nAppId == nDstId) then
		return;
	end
	
	local nCanDelRelation = self:CheckCanDelRelation(nAppId, nDstId, nType, nRole);
	if (1 == nCanDelRelation) then
		KRelation.DelRelation(nType, nAppId, nDstId, nRole);
	end
end

-- 检查是否可以增加亲密度
function Relation:CheckCanAddFavor(nAppId, nDstId, nFavor, nMethod)
	-- 某一方不在线
	local nDstOnline = KGCPlayer.OptGetTask(nDstId, KGCPlayer.TSK_ONLINESERVER);
	local nAppOnline = KGCPlayer.OptGetTask(nAppId, KGCPlayer.TSK_ONLINESERVER);
	if (nDstOnline <= 0 or nAppOnline <= 0) then
		return 0;
	end
	
	-- 数据没有加载完
	local nAppIsLoadEnd = KRelation.CheckIsLoadEnd(nAppId);
	local nDstIsLoadEnd = KRelation.CheckIsLoadEnd(nDstId);
	if (nAppIsLoadEnd == 0 or nDstIsLoadEnd == 0) then
		return 0;
	end
	
	return 1;
end

-- 增加亲密度
function Relation:AddFriendFavor_GC(szAppName, szDstName, nFavor, nMethod)
	if (not szAppName or not szDstName or szAppName == szDstName or nFavor <= 0) then
		return;
	end
	local nAppId = KGCPlayer.GetPlayerIdByName(szAppName);
	local nDstId = KGCPlayer.GetPlayerIdByName(szDstName);
	
	local nCanAddFavor = self:CheckCanAddFavor(nAppId, nDstId, nFavor, nMethod);
	if (1 == nCanAddFavor) then
		KRelation.ResetLimtWhenCrossDay(nAppId, nDstId);
		KRelation.AddFriendFavor(nAppId, nDstId, nFavor, nMethod);
		KRelation.SyncFriendInfo(nAppId, nDstId);
	end
end

-- 给玩家返还提示信息
function Relation:TellPlayerMsg_GC(nPlayerId, szDstName, nType, nMsgId)
	if (nPlayerId <= 0 or not szDstName or nMsgId < 0) then
		return;
	end
	local nOnline = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	if (nOnline > 0) then
		GSExcute(nOnline, {"Relation:TellPlayerMsg_GS", nPlayerId, szDstName, nType, nMsgId});
	end
end

-- 在玩家上线的时候获取密友关系即将一年到期的信息，并且给出玩家提示
function Relation:GetCloseFriendTimeInfo_GC(nPlayerId)
	if (nPlayerId <= 0) then
		return;
	end
	
	local tbTimeInfo = KRelation.GetCloseFriendTimeInfo(nPlayerId);
	if (not tbTimeInfo or Lib:CountTB(tbTimeInfo) == 0) then
		return;
	end
	
	local tbInfo = {};
	for i, v in pairs(tbTimeInfo) do
		-- 如果剩余时间是0，就表示该关系需要删除
		if (v.nTime == 0) then
			KRelation.DelOverTimeRelation(v.nType, nPlayerId, v.nPlayerId, v.bAsMaster);
		end
		
		-- 把剩余时间的信息通知玩家
		local szPlayerName = KGCPlayer.GetPlayerName(v.nPlayerId);
		if (szPlayerName) then
			local tbTemp = {};
			tbTemp.szPlayerName = szPlayerName;
			tbTemp.nTime = v.nTime;
			tbTemp.nType = v.nType;
			table.insert(tbInfo, tbTemp);
		end
	end
	
	GlobalExcute{"Relation:GetCloseFriendTimeInfo_GS2", nPlayerId, tbInfo};
end

-- 添加师徒关系的后续处理
function Relation:ProcessAfterAddShitu(nStudentId, nTeacherId)
	if (not nStudentId or not nTeacherId or nStudentId <= 0 or nTeacherId <= 0) then
		return;
	end
	self:AddShituTitle_GC(nStudentId, nTeacherId);
	self:SendChuansongfu(nStudentId, nTeacherId);
end

-- 为师父双方发放师徒传送符
function Relation:SendChuansongfu(nStudentId, nTeacherId)
	if (not nStudentId or not nTeacherId or nStudentId <= 0 or nTeacherId <= 0) then
		return;
	end
	GlobalExcute{"Relation:SendChuansongfu_GS", nStudentId, nTeacherId};
end

-- 增加师徒称号
function Relation:AddShituTitle_GC(nStudentId, nTeacherId)
	if (not nStudentId or not nTeacherId or nStudentId <= 0 or nTeacherId <= 0) then
		return;
	end
	
	local szStudentName = KGCPlayer.GetPlayerName(nStudentId);
	local szTeacherName = KGCPlayer.GetPlayerName(nTeacherId);
	GlobalExcute{"Relation:AddShituTitle_GS", szStudentName, szTeacherName};
end
