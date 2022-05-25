

FightSkill.tbState	= {};

FightSkill.tbState.tbTipFunc	= {
	[0]	= function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local szTip	= self:MsgDesc(szMsg, bBuff);
		szTip	= szTip..self:LevelDesc(nLevel).."\n";
		szTip	= szTip..self:AttribDesc(nSkillId, nLevel);
		if (nTotalTime > 0) then
			szTip	= szTip.."Thời gian còn: "..Lib:FrameTimeDesc(nLeftTime);
		end;
		return szTip;
	end,
	[49] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local szTip	= self:MsgDesc(szMsg, bBuff);
		return szTip;
	end,
	[65]	= function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local szTip	= self:MsgDesc(szMsg, bBuff);
		szTip	= szTip..self:LevelDesc(nLevel).."\n";
		szTip	= szTip..self:AttribDesc(nSkillId, nLevel);
		if (nTotalTime > 0) then
			szTip	= szTip.."Thời gian còn: "..Lib:FrameTimeDesc(nLeftTime).."\n";
		end;
		return szTip.."Kinh nghiệm còn: <color=gold>".. me.GetTask(1023, 3) .. " điểm<color>";
	end,
	[78] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local tbSkillInfo	= KFightSkill.GetSkillInfo(nSkillId, nLevel);
		local szTip	= "<color=green>" .. tbSkillInfo.szName .. "<color>";
		szTip	= szTip..self:LevelDesc(nLevel).."\n";
		szTip	= szTip..self:AttribDesc2(tbSkillInfo);
		return szTip;
	end,
	[148] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		return "Khi tăng cấp Ngũ Hành Ấn, hiệu quả Hồn Thạch tăng 20%\nPhí cường hóa trang bị giảm 20%\nThời gian tu luyện mỗi ngày tăng 30 phút\nSử dụng Lệnh Bài Nghĩa Quân, Lệnh Bài Bạch Hổ Đường, Lệnh Bài Gia Tộc, Lệnh Bài Tống Kim, Lệnh Bài Thi Đấu Môn Phái, danh vọng thu được tăng 50%\nThời gian còn: "..Lib:FrameTimeDesc(nLeftTime)
	end,
	[342] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		if nLeftTime > Item.VALID_PEEL_TIME * Env.GAME_FPS then
			local nTime = Lib:FrameTimeDesc(nLeftTime - Item.VALID_PEEL_TIME * Env.GAME_FPS);
			return string.format("Sau <color=yellow>%s<color=red> có thể chuyển hoặc tách 1 trang bị cường hóa cấp 12 trở lên.<color>", nTime);
		else
			return "Trạng thái hiện tại có thể chuyển hoặc tách trang bị cường hóa cấp 12 trở lên, thời gian còn: "..Lib:FrameTimeDesc(nLeftTime);
		end
	end,
	[303] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		nSkillId, nLevel = me.GetNpc().GetStealSkill();
		szMsg = KFightSkill.GetSkillName(nSkillId);
		local szTip	= self:MsgDesc(szMsg, bBuff);
		szTip	= "Hiện tại đã trộm: "..szTip;
		szTip	= szTip..self:LevelDesc(nLevel).."\n";
		szTip	= szTip..self:AttribDesc3(nSkillId, nLevel);
		if (nTotalTime > 0) then
			szTip	= szTip.."Thời gian sử dụng còn: "..Lib:FrameTimeDesc(nLeftTime);
		end;
		return szTip;
	end,
	[430] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local nValid_TIME = Partner.DEL_USABLE_MAXTIME - Partner.DEL_USABLE_MINTIME;
		if nLeftTime > nValid_TIME * Env.GAME_FPS then
			local nTime = Lib:FrameTimeDesc(nLeftTime - nValid_TIME * Env.GAME_FPS);
			return string.format("Sau <color=yellow>%s<color=red> có thể xóa 1 đồng hành trên cấp %0.1f hoặc kỹ năng %d trở lên.<color>", 
				nTime, Partner.DELLIMITSTARLEVEL, Partner.DELLIMITSKILLCOUNT);
		else
			return string.format("Trạng thái hiện tại có thể xóa 1 đồng hành trên cấp %0.1f hoặc kỹ năng %d trở lên, thời gian còn: %s", 
				Partner.DELLIMITSTARLEVEL, Partner.DELLIMITSKILLCOUNT, Lib:FrameTimeDesc(nLeftTime));
		end
	end,
	[431] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local nValid_TIME = Partner.PEEL_USABLE_MAXTIME - Partner.PEEL_USABLE_MINTIME;
		if nLeftTime > nValid_TIME * Env.GAME_FPS then
			local nTime = Lib:FrameTimeDesc(nLeftTime - nValid_TIME * Env.GAME_FPS);
			return string.format("Sau <color=yellow>%s<color=red> có thể trùng sinh 1 đồng hành cấp %0.1f hoặc trên.<color>", 
				nTime, Partner.PEELLIMITSTARLEVEL);
		else
			return string.format("Ở trạng thái hiện tại có thể trùng sinh 1 %0.1f cấp sao hoặc đồng thành trên, thời gian còn: %s",
				Partner.PEELLIMITSTARLEVEL, Lib:FrameTimeDesc(nLeftTime));
		end
	end,
	[432] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local szTip	= self:MsgDesc(szMsg, bBuff);
		return szTip;
	end,
	[470] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local nValid_TIME = Partner.BIND_PARTNERQUIP_MAXTIME - Partner.BIND_PARTNERQUIP_MINTIME;
		if nLeftTime > nValid_TIME * Env.GAME_FPS then
			local nTime = Lib:FrameTimeDesc(nLeftTime - nValid_TIME * Env.GAME_FPS);
			return string.format("Sau khi <color=yellow>%s<color=red> có thể mở khóa 1 trang bị đồng hành.<color>", nTime);
		else
			return string.format("Trạng thái hiện tại có thể mở khóa 1 trang bị đồng hành, thời gian còn: %s", Lib:FrameTimeDesc(nLeftTime));
		end
	end,
	[476] = function(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
		local nValid_TIME = Item.tbZhenYuan.UNBIND_MAX_TIME - Item.tbZhenYuan.UNBIND_MIN_TIME;
		if nLeftTime > nValid_TIME * Env.GAME_FPS then
			local nTime = Lib:FrameTimeDesc(nLeftTime - nValid_TIME * Env.GAME_FPS);
			return string.format("Sau <color=yellow>%s<color=red> có thể mở khóa chân nguyên.<color>", nTime);
		else
			return string.format("Với trạng thái hiện tại có thể mở khóa chân nguyên, còn: %s", Lib:FrameTimeDesc(nLeftTime));
		end
	end,
};

function FightSkill.tbState:MsgDesc(szMsg, bBuff)
	return string.format("<color=%s>%s<color>", (bBuff == 1 and "green") or "red", szMsg)
end

function FightSkill.tbState:AttribDesc(nSkillId, nLevel)
	if (nSkillId <= 0) then
		return "";
	end
	local tbInfo		= KFightSkill.GetStateInfo(nSkillId, nLevel);

	return self:AttribDesc2(tbInfo);
end

function FightSkill.tbState:AttribDesc2(tbSkillInfo)
	local tbMsg = {};
	local szSkillMsg = "";
	local tbDefault = FightSkill:GetClass("default")
	tbDefault:GetAllMagicsDesc(tbMsg, tbSkillInfo);
	for _, szDesc in ipairs(tbMsg) do
		szSkillMsg = szSkillMsg..szDesc.."\n";
	end
	
	return szSkillMsg;
end

function FightSkill.tbState:AttribDesc3(nSkillId, nLevel)
	if (nSkillId <= 0) then
		return "";
	end
	local tbInfo	= KFightSkill.GetSkillInfo(nSkillId, nLevel);
	local nTrueTime = KFightSkill.GetSkillInfo(1212, self:GetSkillLevel(1212)).nStateTime
	if tbInfo.nIsAura == 1 then 
		nTrueTime = nTrueTime;
	else
		nTrueTime = math.min(nTrueTime,tbInfo.nStateTime);
	end
	nTrueTime = math.floor(nTrueTime / Env.GAME_FPS * 10) / 10
	local szTimeTip = string.format("<color=white>Thời gian duy trì: <color><color=gold> %s giây<color>\n", nTrueTime)

	return self:AttribDesc2(tbInfo)..szTimeTip;
end

function FightSkill.tbState:LevelDesc(nLevel)
	if (nLevel <= 0) then
		return "";
	end
	return string.format(" [cấp %d]", nLevel);
end

function FightSkill.tbState:GetTip(nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime)
	local fnTip	= self.tbTipFunc[nId] or self.tbTipFunc[0];
	return fnTip(self, nId, nSkillId, nLevel, szMsg, bBuff, nType, nLeftTime, nTotalTime);
end

function FightSkill.tbState:GetSkillLevel(nSkillId)
	local fnFindSkillLevel = function(tbSkillList)
		for _, tbSkill in pairs(tbSkillList) do
			if (tbSkill.uId ==nSkillId) then
				return tbSkill.nLevel;
			end
		end
	end
	for i = 0, 2 do
		local tbSkillList = me.GetFightSkillList(i);
		local nLevel = fnFindSkillLevel(tbSkillList);
		if (nLevel) then
			return nLevel;
		end
	end
end
