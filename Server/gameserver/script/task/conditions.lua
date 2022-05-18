function TaskCond:IsFinished(nTaskId, nTaskIdx)
	if (Task:GetFinishedIdx(nTaskId) >= nTaskIdx) then
		return 1
	end
	local szFailDesc = "";
	szFailDesc = "Chưa hoàn thành "..self.tbReferDatas[nTaskIdx].szName;
	return nil, szFailDesc;
end

function TaskCond:IsLevelAE(nLevel)
	if (me.nLevel >= nLevel) then
		return 1
	end
	local szFailDesc = "";
	szFailDesc = "Chưa đạt đến cấp "..nLevel..".";
	return nil, szFailDesc;
end

function TaskCond:IsLevelMax(nLevel)
	if (me.nLevel <= nLevel) then
		return 1;
	end
	local szFailDesc = "";
	szFailDesc = "Đã trên cấp " .. nLevel .. ".";
	return nil, szFailDesc;
end

-- 注意可以有門派無關，無門無派是0
function TaskCond:IsFaction(nFaction)
	if (me.nFaction == nFaction) then
		return 1
	end
	return nil, "Môn phái không phù hợp"
end

function TaskCond:NotThisFaction(nFaction)
	if (me.nFaction ~= nFaction) then
		return 1;
	end
	
	return nil, "Môn phái không phù hợp";
end

function TaskCond:IsFactionMember(szFailDesc)
	if (me.nFaction > 0) then
		return 1;
	end
	return nil, szFailDesc;
end

function TaskCond:HaveMoney(nValue)
	if (me.nCashMoney >= nValue) then
		return 1
	end
	local szFailDesc = "";
	szFailDesc = "Thiếu hiện kim"..nValue;
	return nil, szFailDesc;
end

function TaskCond:HaveSkill(nSkillId)
	if (me.GetSkillLevel(nSkillId) >= 0) then
		return 1
	end
	return nil, "Kỹ năng chưa đạt yêu cầu"
end

function TaskCond:IsPkAE(nValue)
	if (me.nPKValue >= nValue) then
		return 1;
	end
	local szFailDesc = "";
	szFailDesc = "Chưa đạt PK "..nValue;
	return nil, szFailDesc;
end

function TaskCond:IsAtPos(nMapId, nPosX, nPosY, nR)
	local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
	if (nMapId == nMyMapId or nMapId == 0) then
		if (nPosX == 0) then
			return 1;
		else
			local nMyR	= ((nPosX-nMyPosX)^2 + (nPosY-nMyPosY)^2)^0.5;
			if (nMyR < nR) then
				return 1;
			end;
		end;
	end;
	return nil, "Chưa đến vị trí chỉ định";
end;
function TaskCond:IsAtPos_Player(nMapId, nPosX, nPosY, nR,nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0
	end
	local nMyMapId, nMyPosX, nMyPosY	= pPlayer.GetWorldPos();
	if (nMapId == nMyMapId or nMapId == 0) then
		if (nPosX == 0) then
			return 1;
		else
			local nMyR	= ((nPosX-nMyPosX)^2 + (nPosY-nMyPosY)^2)^0.5;
			if (nMyR < nR) then
				return 1;
			end;
		end;
	end;
	return nil, "Chưa đến vị trí chỉ định";
end;

function TaskCond:IsNpcAtPos(nNpcId, nMapId, nPosX, nPosY, nR)
	if (nNpcId and nNpcId > 0) then
		local pNpc = KNpc.GetById(nNpcId);
		local nHimMapId, nHimPosX, nHimPosY  = pNpc.GetWorldPos();
		if (nHimMapId == nMapId) then
			if (nPosX == 0) then
				return 1;
			else
				local nMyR	= ((nPosX-nHimPosX)^2 + (nPosY-nHimPosY)^2)^0.5;
				if (nMyR < nR) then
					return 1;
				end;
			end;
		end
	else
		return nil, "Không có Npc chỉ định";
	end
	
	return nil, "Npc chưa đến vị trí chỉ định";
end;

function TaskCond:IsReputeAE(nCamp, nClass, nLevel, nValue)
	local nMyLevel	= me.GetReputeLevel(nCamp, nClass);
	local nMyValue	= me.GetReputeValue(nCamp, nClass);
	if (nMyLevel and nMyValue) then
		if (nMyLevel > nLevel) then
			return 1;
		elseif (nMyLevel == nLevel and nMyValue >= nValue) then
			return 1;
		end;
	end;
	return nil, "Danh vọng chưa đạt yêu cầu";
end;

function TaskCond:HaveTitleAE(byTitleGenre, byTitleDetailType, byTitleLevel)
	local tbTitles	= me.GetAllTitle(nCamp, nClass);
	for _, tbTitle in ipairs(tbTitles) do
		if (tbTitle.byTitleGenre == byTitleGenre and
			tbTitle.byTitleDetailType == byTitleDetailType and
			tbTitle.byTitleLevel >= byTitleLevel) then
			return 1;
		end;
	end;
	return nil, "Danh hiệu chưa đạt yêu cầu";
end;


function TaskCond:HaveTitle(byTitleGenre, byTitleDetailType, byTitleLevel, dwTitleParam)
	local tbTitles	= me.GetAllTitle(nCamp, nClass);
	for _, tbTitle in ipairs(tbTitles) do
		if (tbTitle.byTitleGenre == byTitleGenre and
			tbTitle.byTitleDetailType == byTitleDetailType and
			tbTitle.byTitleLevel == byTitleLevel and
			tbTitle.dwTitleParam == dwTitleParam) then
			return 1;
		end;
	end;
	return nil, "Danh hiệu chưa đạt yêu cầu";
end;


function TaskCond:HaveBagSpace(nNeedSpace)
	local nFreeCell = me.CountFreeBagCell();
	if (not nNeedSpace) then
		nNeedSpace = 1;
	end
	if (nFreeCell >= nNeedSpace) then
		return 1;
	end
	
	return nil, "Hành trang không đủ chỗ";
end;


function TaskCond:IsRefFinished(nRefSubId)
	local tbNeedReferData = Task.tbReferDatas[nRefSubId];	-- 需要判斷的引用子任務數據
	local nNeedRefIdx = tbNeedReferData.nReferIdx; 			-- 需要完成的引用子任務索引號
	local nTaskId	  	= tbNeedReferData.nTaskId;				-- 此子任務所屬的任務
	
	
	local nCurReferId = Task:GetFinishedRefer(nTaskId)
	if (nCurReferId > 0) then
		local nCurRefIdx = Task.tbReferDatas[nCurReferId].nReferIdx;	
		if (nCurRefIdx >= nNeedRefIdx) then
			return 1;
		end
	end
	
	return nil, "Chưa hoàn thành nhiệm vụ chỉ định";
end;

function TaskCond:NeedSex(nNeedMale)
	if (me.nSex == nNeedMale) then
		return 1;
	end

	return nil, "Giới tính không đúng yêu cầu";
end;

function TaskCond:HasBlueEquip()
	for i = 0, Item.EQUIPPOS_NUM do
		pItem = me.GetEquip(i);
		if (pItem) then
			if (pItem.nGenre == Item.EQUIP_GENERAL) and (pItem.IsWhite() ~= 1) then
				return 1;
			end
		end
	end
	
	return nil, "Bạn không có trang bị màu lam";
end

function TaskCond:HaveItem(tbItem)
	if (Task:GetItemCount(me, tbItem) >= 1) then
		return 1;
	end
	
	return nil, "Bạn không có vật phẩm này";
end

function TaskCond:HaveBitItem(tbItem, nCount)	
	assert(nCount >= 1);
	if (Task:GetItemCount(me, tbItem) >= nCount) then
		return 1;
	end
	local szItemName = KItem.GetNameById(tbItem[1], tbItem[2], tbItem[3], tbItem[4]);
	
	return nil, "Bạn không có "..nCount..", "..szItemName;
end

-- 判斷玩家身上有指定道具
function TaskCond:UsingMask(nMaskId, nLevel)
	local pItem = me.GetEquip(Item.EQUIPPOS_MASK)
	
	if (pItem and pItem.nLevel >= nLevel and pItem.nParticular == nMaskId) then
		return 1;
	end
		
	return nil, "Bạn không có mặt nạ chỉ định!";
end


function TaskCond:RequireTaskValue(nGroupId, nTaskId, nValue, szDesc)
	assert(nGroupId > 0 and nTaskId > 0);
	
	--防沉迷, 不健康時間不能領取任務
	if (me.GetTiredDegree() == 2) then
		return 0;
	end
	
	if (me.GetTask(nGroupId, nTaskId) == nValue) then
		return 1;
	end
	
	return nil, szDesc;
end

function TaskCond:HaveRoute(szDesc)
	if (me.nRouteId > 0) then
		return 1;
	end
	
	return nil, szDesc;
end

function TaskCond:CanAddCountItemIntoBag(tbItem, nCount)
	if (nCount <= 0) then
		return 1;
	end
	
	local tbItems = {};	
	for i = 1, nCount do
		tbItems[#tbItems + 1] = tbItem;
	end
	
	return self:CanAddItemsIntoBag(tbItems);
end


function TaskCond:CanAddItemsIntoBag(tbItems)

	local tbDesItems = {};

	for _, tbItem in ipairs(tbItems) do
		local tbBaseProp = KItem.GetItemBaseProp(tbItem[1], tbItem[2], tbItem[3], tbItem[4]);
		if tbBaseProp then
			local tbDes =
			{
				nGenre		= tbItem[1],
				nDetail		= tbItem[2],
				nParticular	= tbItem[3],
				nLevel		= tbItem[4],
				nSeries		= (tbBaseProp.nSeries > 0) and tbBaseProp.nSeries or tbItem[5],
				bBind		= KItem.IsItemBindByBindType(tbBaseProp.nBindType),
				nCount 		= 1;
			};
			table.insert(tbDesItems, tbDes);
		end
	end

	if (me.CanAddItemIntoBag(unpack(tbDesItems)) == 1) then
			return 1;
	end
		
	return nil, "Hành trang không đủ chỗ, không thể nhận vật phẩm!";

end

function TaskCond:IsKinReputeAE(nRepute)
	if MODULE_GAMECLIENT then
		return 1;
	end
	local szFailDesc = "";
	if (me.nPrestige >= nRepute) then
		return 1
	end
	
	szFailDesc = "Uy danh giang hồ chưa đạt "..nRepute.." điểm";
	return nil, szFailDesc;
end

function TaskCond:TaskValueLessThen(nGroupId, nTaskId, nTaskValue, szErrorDesc)
	if (me.GetTask(nGroupId, nTaskId, nTaskValue) < nTaskValue) then
		return 1;
	end
	
	return nil, szErrorDesc;
end


function TaskCond:RequireTaskValueBit(nGroupId, nTaskId, nBitNum, bBit, szErrorDesc)
	local nValue = me.GetTask(nGroupId, nTaskId);
	assert(nBitNum <= 16 and nBitNum >= 1);
	
	local nBit = KLib.GetBit(nValue, nBitNum);
	if ((nBit == 1 and bBit) or (nBit == 0) and not bBit) then
		return 1;
	end
	
	return nil, szErrorDesc;
end

function TaskCond:RequireTime(nStartTime, nEndTime, szErrorDesc)
	local nDate = tonumber(os.date("%Y%m%d", GetTime()));
	if (nStartTime <= nDate and nDate <= nEndTime) then
		return 1;
	end;
	return nil, szErrorDesc;
end;

function TaskCond:HaveTeacher(szErrorDesc)
	if not MODULE_GAMESERVER then
		local tbTrain = me.Relation_GetTrainingRelation();
		if tbTrain then
			for _, tbInfo in pairs(tbTrain) do
				if (tbInfo.nRole == 1 and tbInfo.nLevel > me.nLevel) then
					return 1;
				end;
			end;
		end
		return nil, szErrorDesc; 
	else 
		-- nType 用來表示已經出師和未出師都要得到
		local nType = Player.emKPLAYERRELATION_TYPE_TRAINING + Player.emKPLAYERRELATION_TYPE_TRAINED;
		local pszTeacher = me.GetTrainingTeacher(nType);
		if (pszTeacher == nil) then
			return nil, szErrorDesc; 
		end
		local tbInfo = GetPlayerInfoForLadderGC(pszTeacher);
		if (not tbInfo or not tbInfo.nLevel or tbInfo.nLevel <= me.nLevel) then
			return nil, szErrorDesc;
		end
		local tbTrainStudentList = me.GetTrainingStudentList();
		if (tbTrainStudentList) then
			return nil, szErrorDesc;
		end;
		return 1;
	end;
end;

function TaskCond:RequirRepute(nValue, szErrorDesc)
	if (me.nPrestige < nValue) then
		return nil, szErrorDesc;
	end;
	return 1;
end;

function TaskCond:RequirScript(varFunc, nTure, szErrorDesc)
	local fnFunc, tbSelf	= KLib.GetValByStr(varFunc);
	if not fnFunc then
		return 1;
	end
	if fnFunc(tbSelf) == tonumber(nTure) then
		return 1
	end
end;
