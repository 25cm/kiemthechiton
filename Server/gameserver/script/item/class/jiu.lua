local tbJiuItem	= Item:GetClass("jiu");
local JIU_AVOID_TIME = 1.5 * 3600; -- 酒的有效期限

tbJiuItem.nJiuSkillId 		= 378;
tbJiuItem.nLastTime		= 180;							-- 各种酒使用后的持续时间
tbJiuItem.tbJiuId			= {48, 49, 50, 51, 52};			-- 各种酒的Id
tbJiuItem.tbJiuName		= {"Rượu Tây Bắc Vọng", "Rượu Đạo Hoa Hương", "Rượu Nữ Nhi Hồng", "Rượu Hạnh Hoa Thôn", "Rượu Thiêu Đao Tử"};	-- 每一种酒的Name
tbJiuItem.tbQuotiety	= {								-- 同时喝一种酒的数量对应的加经验的倍数(百分比)
	[0]	= 100,
	[1]	= 110,
	[2]	= 120,
	[3]	= 130,
	[4]	= 140,
	[5]	= 150,
	[6]	= 160,
};

tbJiuItem.nTaskJiuSkillId = 477; 	--任务专用酒就能Id
tbJiuItem.ntaskLastTime = 120;		--任务专用酒持续时间
tbJiuItem.tbTaskJiuId	= 97			-- 任务专用酒
tbJiuItem.tbTaskJiuName = {"Rượu Chiến Thần"};
tbJiuItem.tbTaskQuotiety	= {								-- 同时喝一种酒的数量对应的加经验的倍数(百分比)
	[0]	= 100,
	[1]	= 100,
	[2]	= 110,
	[3]	= 120,
	[4]	= 130,
	[5]	= 140,
	[6]	= 150,
};

tbJiuItem.nEventJiuSkillId = 799; 	--任务专用酒就能Id
tbJiuItem.nEventLastTime = 300;		--任务专用酒持续时间
tbJiuItem.tbEventJiuId	= 196			-- 活动酒－王老吉
tbJiuItem.tbEventJiuName = {"Trà Vương Lão Cát"};
tbJiuItem.tbEventQuotiety	= {		-- 同时喝一种酒的数量对应的在原有基础上加经验的倍数(百分比)
	[0]	= 0,
	[1]	= 10,
	[2]	= 10,
	[3]	= 10,
	[4]	= 10,
	[5]	= 10,
	[6]	= 10,
};


function tbJiuItem:InitGenInfo()
	it.SetTimeOut(1, JIU_AVOID_TIME);
	return	{ };
end


function tbJiuItem:OnUse()
	if it.nParticular == self.tbTaskJiuId then
		me.AddSkillState(self.nTaskJiuSkillId, 1, 1, self.ntaskLastTime * Env.GAME_FPS, 0);
		self:HintMsg(self.tbTaskJiuName[1]);
		return 1;
	end
	
	if it.nParticular == self.tbEventJiuId then
		me.AddSkillState(self.nEventJiuSkillId, 1, 1, self.nEventLastTime * Env.GAME_FPS, 0, 1);
		self:HintMsg(self.tbEventJiuName[1]);
		return 1;
	end	
	
	for i = 1, #self.tbJiuId do
		if (it.nParticular == self.tbJiuId[i]) then
			local nSkillLevel = me.GetSkillState(self.nJiuSkillId)
			if nSkillLevel > 0 then
				local szMsg = string.format("Đã uống 1 bình <color=blue>%s<color>, uống tiếp <color=blue>%s<color> sẽ <color=yellow> làm mất hiệu quả ban đầu<color>", self.tbJiuName[nSkillLevel], self.tbJiuName[i]);
				me.Msg(szMsg);
			end
			me.AddSkillState(self.nJiuSkillId, i, 1, self.nLastTime * Env.GAME_FPS, 0, 1);
			if me.nFightState == 0 then
				return 1;
			end
			self:HintMsg(self.tbJiuName[i]);
			break;
		end
	end

	return 1;	-- OnUse函数中返回0不删除;返回1表示删除
end


function tbJiuItem:HintMsg(szJiuName)
	if me.nTeamId > 0 then
		local tbPlayerIdList = KTeam.GetTeamMemberList(me.nTeamId);		
		for _, nPlayerId in pairs(tbPlayerIdList) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then
				pPlayer.Msg(string.format("[%s] đã uống 1 bình %s, nhận được kinh nghiệm lửa trại.", me.szName, szJiuName));
			end
		end
	else
		me.Msg(string.format("Đã uống 1 bình %s, nhận được kinh nghiệm lửa trại.", szJiuName));
	end
end

function tbJiuItem:CalcQuotiety(tbPlayerId)
	local tbDrinkedNum = {	0, 0, 0, 0, 0}
	if #tbPlayerId == 0 then
		return 0 , 100;
	end
	local tbPlayerName = {};
	for i, nPlayerId in pairs(tbPlayerId) do
		local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			local nSkillLevel = pPlayer.GetSkillState(self.nJiuSkillId);
			if (nSkillLevel > 0) then
				tbDrinkedNum[nSkillLevel] = tbDrinkedNum[nSkillLevel] + 1;
				if tbPlayerName[self.tbJiuName[nSkillLevel]] == nil then
					tbPlayerName[self.tbJiuName[nSkillLevel]] = {};
				end
				table.insert(tbPlayerName[self.tbJiuName[nSkillLevel]], pPlayer.szName);
			end	
		end
	end
	local nMaxTimes		= 0;
	local nCurDrinkId	= 0;
	for i = 1, #(tbDrinkedNum) do
		if (tbDrinkedNum[i] > nMaxTimes) then
			nCurDrinkId = i;
			nMaxTimes = tbDrinkedNum[i];
		end
	end
	if nMaxTimes > 6 then
		nMaxTimes = 6;
	end
	return nMaxTimes, self.tbQuotiety[nMaxTimes], self.tbJiuName[nCurDrinkId], tbPlayerName;
end

function tbJiuItem:CalcTaskQuotiety(tbPlayerId)
	if #tbPlayerId == 0 then
		return 0 , 100;
	end
	local nDrinkedNum = 0;
	for i, nPlayerId in pairs(tbPlayerId) do
		local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			local nTaskSkillLevel = pPlayer.GetSkillState(self.nTaskJiuSkillId);
			if (nTaskSkillLevel > 0) then
				nDrinkedNum = nDrinkedNum + 1;
			end			
		end
	end
	return nDrinkedNum, self.tbTaskQuotiety[nDrinkedNum], self.tbTaskJiuName[1];	
end

function tbJiuItem:CalcEventQuotiety(tbPlayerId)
	if #tbPlayerId == 0 then
		return 0 , 100;
	end
	local nDrinkedNum = 0;
	local szEventJiuName;
	for i, nPlayerId in pairs(tbPlayerId) do
		local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			local nEventSkillLevel = pPlayer.GetSkillState(self.nEventJiuSkillId);
			if (nEventSkillLevel > 0) then
				nDrinkedNum = nDrinkedNum + 1;
				szEventJiuName = self.tbEventJiuName[1];
			end
		end
	end
	return nDrinkedNum, self.tbEventQuotiety[nDrinkedNum], szEventJiuName;
end

function tbJiuItem:CalcOtherQuotiety(tbPlayerId, nSkillId)
	if #tbPlayerId == 0 then
		return 0;
	end
	local nDrinkedNum = 0;
	for i, nPlayerId in pairs(tbPlayerId) do
		local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			local nTaskSkillLevel = pPlayer.GetSkillState(nSkillId);
			if (nTaskSkillLevel > 0) then
				nDrinkedNum = nDrinkedNum + 1;
			end
		end
	end
	return nDrinkedNum;	
end
