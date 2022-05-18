-- Œƒº˛√˚°°£∫console_gs.lua
-- ¥¥Ω®’ﬂ°°£∫sunduoliang
-- ¥¥Ω® ±º‰£∫2009-04-23 10:04:41
-- √Ë   ˆ  £∫--øÿ÷∆Ã®

if (MODULE_GC_SERVER) then
	return 0;
end

--±®√˚Ω¯≥°
function Console:ApplySignUp(nDegree, tbPlayerIdList)
	GCExcute{"Console:ApplySignUp", nDegree, tbPlayerIdList};
end

function Console:StartSignUp(nDegree)
	self:GetBase(nDegree):StartSignUp();
end

function Console:OnStartMission(nDegree)
	self:GetBase(nDegree):OnStartMission();
end

function Console:SignUpFail(tbPlayerList)
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg("ƒêƒÉng k√Ω ƒë·ªÉ tham gia chi·∫øn ƒë·∫•u qu·∫£ c·∫ßu tuy·∫øt.");
			Dialog:SendBlackBoardMsg(pPlayer, "ƒêƒÉng k√Ω tham gia chi·∫øn ƒë·∫•u")
			return 0;
		end
	end
end

function Console:SignUpSucess(nDegree, nReadyMapId, tbPlayerList)
	local tbBase = self:GetBase(nDegree);
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			if tbBase:IsOpen() == 0 then
				pPlayer.Msg("B·∫°n ƒë√£ b·ªã tr·ªçng th∆∞∆°ng, k·∫øt th√∫c l∆∞·ª£t ƒë·∫•u n√†y.");
			else
				pPlayer.NewWorld(nReadyMapId, unpack(tbBase.tbCfg.tbMap[nReadyMapId].tbInPos));
			end
		end
	end
end

function Console:OnDyJoin(nDegree, me, nDyId, tbPos, GroupId)
	local tbBase = self:GetBase(nDegree);
	tbBase:OnDyJoin(me, nDyId, tbPos, GroupId);
end

--∏±±æ…Í«Î
function Console:ApplyDyMap(nDegree, nMapId)
	local tbBase   = self:GetBase(nDegree);
	local nDyCount = tbBase.tbCfg.nMaxDynamic;
	local nDynamicMap = tbBase.tbCfg.nDynamicMap;
	local nCurCount = #self.tbDynMapLists[nMapId];
	if nCurCount < nDyCount then
		for i=1, (nDyCount - nCurCount) do
			if (LoadDynMap(Map.DYNMAP_CONSOLE, nDynamicMap, nMapId) ~= 1) then
				print("æ∫ºº»¸∏±±æµÿÕº£®–¬ƒÍ—©’Ã£©º”‘ÿ ß∞‹°£°£");
			end
		end
	end
	return 0;
end

--±»»¸µÿÕº∂ØÃ¨º”‘ÿ≥…π¶
function Console:OnLoadMapFinish(nDyMapId, nMapId)
	self.tbDynMapLists[nMapId] = self.tbDynMapLists[nMapId] or {};
	table.insert(self.tbDynMapLists[nMapId], nDyMapId);
end
