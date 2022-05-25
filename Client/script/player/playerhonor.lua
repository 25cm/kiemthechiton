-- 文件名　：playerhonor.lua
-- 创建者　：zhouchenfei
-- 创建时间：2008-10-07 17:44:24


PlayerHonor.HONOR_CLASS_WULIN		= 1;	-- 荣誉大类，武林荣誉
PlayerHonor.HONOR_CLASS_FACTION		= 2;	-- 荣誉大类，门派荣誉
PlayerHonor.HONOR_CLASS_WLLS		= 3;	-- 荣誉大类，联赛荣誉
PlayerHonor.HONOR_CLASS_BATTLE		= 4;	-- 荣誉大类，战场荣誉
PlayerHonor.HONOR_CLASS_LINGXIU		= 5;	-- 荣誉大类，领袖荣誉
PlayerHonor.HONOR_CLASS_AREARBATTLE	= 6;	-- 荣誉大类，领土争夺战荣誉
PlayerHonor.HONOR_CLASS_BAIHUTANG	= 7;	-- 荣誉大类，白虎堂荣誉
PlayerHonor.HONOR_CLASS_MONEY		= 8;	-- 荣誉大类，财富荣誉
PlayerHonor.HONOR_CLASS_SPRING		= 9;	-- 荣誉大类，飞絮崖荣誉
PlayerHonor.HONOR_CLASS_DRAGONBOAT	= 10;	-- 荣誉大类，禅境花园荣誉（清明节活动）
PlayerHonor.HONOR_CLASS_WEIWANG		= 11;	-- 荣誉大类，江湖威望荣誉
PlayerHonor.HONOR_CLASS_PRETTYGIRL	= 12;	-- 荣誉大类，美女大选荣誉
PlayerHonor.HONOR_CLASS_XOYOGAME	= 13;	-- 荣誉大类，逍遥荣誉
PlayerHonor.HONOR_CLASS_KAIMENTASK	= 14;	-- 荣誉大类，开门任务
PlayerHonor.HONOR_CLASS_EVENTPLANT_PLAYER	= 15;	-- 荣誉大类，活动平台个人积分

PlayerHonor.WEALTH_TASK_GROUP		= 2053;	-- 玩家装备排行任务变量

PlayerHonor.OPENSHOWLEVELTIME		= 1228072200; -- 12/01/08 03:10:00 开放等级显示

PlayerHonor.TSK_GROUP				= 2054;	-- 其他任务变量
PlayerHonor.TSK_ID_REFRESH_TIME		= 1;	-- 上次刷新荣誉值时间GetTime()+1，没刷新过的是0
PlayerHonor.TSK_ID_HONORLEVEL_WULIN	= 2;	-- 荣誉等级（存盘用）
PlayerHonor.TSK_ID_HONORLEVEL_LINGXIU = 3;	-- 领袖等级
PlayerHonor.TSK_ID_HONORLEVEL_MONEY	= 4;	-- 财富等级
PlayerHonor.TSK_ID_COSUME_VALUE	= 5;		-- 消耗计价值量
PlayerHonor.TSK_ID_PARTNER_VALUE = 6;		-- 同伴价值量
PlayerHonor.TSK_ID_COSUME_VALUE_HIGH = 7	-- 消耗计价值量高位

PlayerHonor.tbHonorName	= {
		[PlayerHonor.HONOR_CLASS_WULIN] 		= "Võ Lâm";
		[PlayerHonor.HONOR_CLASS_FACTION]		= "Môn Phái";
		[PlayerHonor.HONOR_CLASS_WLLS]			= "Liên Đấu";
		[PlayerHonor.HONOR_CLASS_BATTLE]		= "Tống Kim";
		[PlayerHonor.HONOR_CLASS_LINGXIU] 		= "Thủ Lĩnh";
		[PlayerHonor.HONOR_CLASS_AREARBATTLE]	= "Tranh Đoạt";
		[PlayerHonor.HONOR_CLASS_BAIHUTANG]		= "Bạch Hổ";
		[PlayerHonor.HONOR_CLASS_MONEY]			= "Tài Phú";
		[PlayerHonor.HONOR_CLASS_SPRING]		= "Gia tộc đoàn viên";
		[PlayerHonor.HONOR_CLASS_DRAGONBOAT]	= "Vinh dự Thiền Cảnh Hoa Viên";
		[PlayerHonor.HONOR_CLASS_WEIWANG]		= "Vinh dự Uy danh giang hồ";
		[PlayerHonor.HONOR_CLASS_PRETTYGIRL]	= "Vinh dự mỹ nữ";
		[PlayerHonor.HONOR_CLASS_KAIMENTASK]	= "Nhiệm vụ Khai Môn";
	};

PlayerHonor.tbFacContext = {
		[0] = "Võ Lâm";
		[1] = "Thiếu Lâm";
		[2] = "Thiên Vương";
		[3] = "Đường Môn";
		[4] = "Ngũ Độc";
		[5] = "Nga My";
		[6] = "Thúy Yên";
		[7] = "Cái Bang";
		[8] = "Thiên Nhẫn";
		[9] = "Võ Đang";
		[10] = "Côn Lôn";
		[11] = "Minh Giáo";
		[12] = "Đoàn Thị ";
	};
	
PlayerHonor.tbFacName = {
		[0] = "Võ Lâm";
		[1] = "Thiếu Lâm";
		[2] = "Thiên Vương";
		[3] = "Đường Môn";
		[4] = "Ngũ Độc";
		[5] = "Nga My";
		[6] = "Thúy Yên";
		[7] = "Cái Bang";
		[8] = "Thiên Nhẫn";
		[9] = "Võ Đang";
		[10] = "Côn Lôn";
		[11] = "Minh Giáo";
		[12] = "Đoàn Thị";
	};

PlayerHonor.tbBookToValue = 
{
	[1] = 150000,
	[2] = 450000,
	[3] = 1000000, --粽子
}

PlayerHonor.tbHonorLevelInfo	= {
	["wulin"]	= {
		nHonorId	= PlayerHonor.HONOR_CLASS_WULIN,
		nLevelTaskId= PlayerHonor.TSK_ID_HONORLEVEL_WULIN;
		szName		= "Võ Lâm",
		tbLevel		= {};
	},
	["money"]	= {
		nHonorId	= PlayerHonor.HONOR_CLASS_MONEY,
		nLevelTaskId= PlayerHonor.TSK_ID_HONORLEVEL_MONEY;
		szName		= "Tài Phú",
		tbLevel		= {};
	},
	["lingxiu"]	= {
		nHonorId	= PlayerHonor.HONOR_CLASS_LINGXIU,
		nLevelTaskId= PlayerHonor.TSK_ID_HONORLEVEL_LINGXIU;
		szName		= "Thủ Lĩnh",
		tbLevel		= {};
	},
};

function PlayerHonor:GetHonorName(nClass, nType)
	return self.tbHonorName[nClass];
end

function PlayerHonor:Init()
	self.tbHonorSettings = {};
	
	local tbData	= Lib:LoadTabFile("\\setting\\player\\honor_level.txt", {LEVEL=1,MAXRANK=1,MINVALUE=1});
	local tbHonorLevelInfo	= self.tbHonorLevelInfo;
	for _, tbRow in ipairs(tbData) do
		tbHonorLevelInfo[tbRow.TYPE].tbLevel[tbRow.LEVEL]	= {
			nLevel		= tbRow.LEVEL,
			nMaxRank	= tbRow.MAXRANK,
			nMinValue	= tbRow.MINVALUE,
			szName		= tbRow.NAME,
		};
		if (tbRow.TYPE == "money") then
			tbHonorLevelInfo[tbRow.TYPE].tbLevel[tbRow.LEVEL].nMaxValue = math.floor(tbRow.MINVALUE * 1.5);
		else
			tbHonorLevelInfo[tbRow.TYPE].tbLevel[tbRow.LEVEL].nMaxValue = 0;
		end
	end

	self:_InitWuLinHonorSetting();
	self:_InitLingXiuHonorSetting();
	self:_InitMoneyHonorSetting();
	self:_InitFactionHonorSetting();
	self:_InitWllsHonorSetting();
	self:_InitSongJinBattleHonorSetting();
	self:_InitAreaBattleHonorSetting();
	self:_InitBaiHuTangHonorSetting();
	self:_InitEventHonorSetting();

	if (MODULE_GAMECLIENT) then
		self.tbPlayerHonorData.tbHonorData = self.tbHonorSettings
	end
end

-- 武林荣誉
function PlayerHonor:_InitWuLinHonorSetting()
	local nClass = self.HONOR_CLASS_WULIN;
	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Võ Lâm"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;	
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;

	self.tbHonorSettings[1] = {};
	self.tbHonorSettings[1].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[1].szName			= "     <color=yellow>Vinh Dự Võ Lâm<color>";
end

-- 领袖荣誉
function PlayerHonor:_InitLingXiuHonorSetting()
	local nClass = self.HONOR_CLASS_LINGXIU;

	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Thủ Lĩnh"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;	
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;
	
	self.tbHonorSettings[2] = {};
	self.tbHonorSettings[2].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[2].szName			= "     <color=red>Vinh Dự Thủ Lĩnh<color>";	
end

-- 财富荣誉
function PlayerHonor:_InitMoneyHonorSetting()
	local nClass = self.HONOR_CLASS_MONEY;
	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Tài Phú"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;
	
	self.tbHonorSettings[3] = {};
	self.tbHonorSettings[3].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[3].szName			= "     <color=green>Vinh Dự Tài Phú<color>";	
end

-- 门派荣誉
function PlayerHonor:_InitFactionHonorSetting()
	local nClass = self.HONOR_CLASS_FACTION;
	local tbHonorSubList = {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Môn Phái"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;
	tbHonorSubList[2]			= {};
	tbHonorSubList[2].szName	= "Bổn Môn"
	tbHonorSubList[2].nValue	= 0;
	tbHonorSubList[2].nRank		= 0;
	tbHonorSubList[2].nClass	= nClass;
	tbHonorSubList[2].nLevel	= 0;

	self.tbHonorSettings[4] = {};
	self.tbHonorSettings[4].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[4].szName			= "Môn Phái";
end

-- 联赛荣誉
function PlayerHonor:_InitWllsHonorSetting()
	local nClass = self.HONOR_CLASS_WLLS;
	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Liên Đấu"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;

	self.tbHonorSettings[5] = {};
	self.tbHonorSettings[5].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[5].szName			= "Liên Đấu";	
end

-- 宋金战场荣誉
function PlayerHonor:_InitSongJinBattleHonorSetting()
	local nClass = self.HONOR_CLASS_BATTLE;
	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Tống Kim"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;	
	
	self.tbHonorSettings[6] = {};
	self.tbHonorSettings[6].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[6].szName			= "Tống Kim";	
end

-- 区域争夺战
function PlayerHonor:_InitAreaBattleHonorSetting()
	local nClass = self.HONOR_CLASS_AREARBATTLE;
	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Tranh Đoạt"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;	
	
	self.tbHonorSettings[7] = {};
	self.tbHonorSettings[7].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[7].szName			= "Tranh Đoạt";	
end

-- 白虎堂
function PlayerHonor:_InitBaiHuTangHonorSetting()
	local nClass = self.HONOR_CLASS_BAIHUTANG;
	local tbHonorSubList		= {};
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Bạch Hổ"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= nClass;
	tbHonorSubList[1].nLevel	= 0;	
	
	self.tbHonorSettings[8] = {};
	self.tbHonorSettings[8].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[8].szName			= "Bạch Hổ";	
end

-- 新年活动
function PlayerHonor:_InitEventHonorSetting()
	local tbHonorSubList		= {};
--	tbHonorSubList[1]			= {};
--	tbHonorSubList[1].szName	= "民族大团圆"
--	tbHonorSubList[1].nValue	= 0;
--	tbHonorSubList[1].nRank		= 0;
--	tbHonorSubList[1].nClass	= self.HONOR_CLASS_SPRING;
--	tbHonorSubList[1].nLevel	= 0;	
	
	tbHonorSubList[1]			= {};
	tbHonorSubList[1].szName	= "Vinh dự Thiền Cảnh Hoa Viên"
	tbHonorSubList[1].nValue	= 0;
	tbHonorSubList[1].nRank		= 0;
	tbHonorSubList[1].nClass	= self.HONOR_CLASS_DRAGONBOAT;
	tbHonorSubList[1].nLevel	= 0;	
	
	tbHonorSubList[2]			= {};
	tbHonorSubList[2].szName	= "Uy danh giang hồ"
	tbHonorSubList[2].nValue	= 0;
	tbHonorSubList[2].nRank		= 0;
	tbHonorSubList[2].nClass	= self.HONOR_CLASS_WEIWANG;
	tbHonorSubList[2].nLevel	= 0;
	
--	tbHonorSubList[3]			= {};
--	tbHonorSubList[3].szName	= "武林大会英雄贴"	--"美女荣誉"
--	tbHonorSubList[3].nValue	= 0;
--	tbHonorSubList[3].nRank		= 0;
--	tbHonorSubList[3].nClass	= self.HONOR_CLASS_PRETTYGIRL;
--	tbHonorSubList[3].nLevel	= 0;	

	tbHonorSubList[3]			= {};
	tbHonorSubList[3].szName	= "Bá Chủ Ấn"
	tbHonorSubList[3].nValue	= 0;
	tbHonorSubList[3].nRank		= 0;
	tbHonorSubList[3].nClass	= self.HONOR_CLASS_KAIMENTASK;
	tbHonorSubList[3].nLevel	= 0;		
	
	self.tbHonorSettings[9] = {};
	self.tbHonorSettings[9].tbHonorSubList	= tbHonorSubList
	self.tbHonorSettings[9].szName			= "Vinh Dự Hoạt Động";	
end

function PlayerHonor:GetHonorLevel(pPlayer, nClass)
	local nLevel = 0;
	
	if (self.HONOR_CLASS_WULIN == nClass) then -- 武林荣誉等级
		nLevel = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_HONORLEVEL_WULIN);
	elseif (self.HONOR_CLASS_LINGXIU == nClass) then	-- 领袖荣誉等级
		nLevel = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_HONORLEVEL_LINGXIU);
	elseif (self.HONOR_CLASS_MONEY == nClass) then	-- 财富荣誉等级
		nLevel = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_HONORLEVEL_MONEY);	
	end
	return nLevel;
end

-- gamecenter脚本---------------------------------------------------------------------------

if (MODULE_GC_SERVER) then
	
	function PlayerHonor:OnSchemeUpdateHonorLadder()
		local nCurTime = GetTime();
		local nWeekDay	= tonumber(os.date("%w", nCurTime));
		self:DbgOut_GC("OnSchemeUpdateHonorLadder", "Open Honor", nWeekDay);
		
		local nDay	= tonumber(GetLocalDate("%d"));
		self:DbgOut_GC("OnSchemeUpdateSongJinBattleHonorLadder", "Open Honor", nDay);
		-- 先衰减
		if (28 == nDay) then
			print(string.format("OnSchemeLoadFactionHonorLadder Decrease Honor  nDay = %d", nDay));
			DecreaseFactionHonor();		
			print(string.format("OnSchemeUpdateSongJinBattleHonorLadder Decrease Honor  nDay = %d", nDay));
			DecreaseSongJinHonor();	
			DecreaseLeaderHonor();	-- 领袖荣誉衰减		
		end
		
		self:OnSchemeLoadFactionHonorLadder();
		self:OnSchemeUpdateSongJinBattleHonorLadder();		
		
		
		if (1 == nWeekDay) then
			self:UpdateWuLinHonorLadder();
			self:UpdateMoneyHonorLadder();
			self:UpdateLeaderHonorLadder();
		
			KGblTask.SCSetDbTaskInt(DBTASD_HONOR_LADDER_TIME, GetTime());
			GlobalExcute({"PlayerHonor:OnLadderSorted"});			
			
			print(string.format("OnSchemeUpdateHonorLadder Update Honor  nDay = %d", nWeekDay));
		end
		
		--飞絮崖荣誉点
		local nCurDate = tonumber(os.date("%Y%m%d", nCurTime));
		--if nCurDate >= Esport.SNOWFIGHT_STATE[1] and nCurDate <= Esport.SNOWFIGHT_STATE[2] then
		--self:UpdateSpringHonorLadder();
		--end
		
		--龙舟荣誉榜(考虑到合服,领奖期间不进行排行)(合服后,排名一样的名次会自动清0)
		if (nCurDate <= TowerDefence.SNOWFIGHT_STATE[2] + 1 or nCurDate > TowerDefence.SNOWFIGHT_STATE[1]) then
		self:OnSchemeUpdateDragonBoatHonorLadder();
		end

		GlobalExcute{"Ladder:RefreshLadderName"};
	end
	
	-- 武林荣誉
	function PlayerHonor:UpdateWuLinHonorLadder()
		print("Xếp hạng Võ Lâm bắt đầu");
		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_WULIN];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Võ Lâm";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	
		UpdateLadderDataForFaction(nType, 0);
		-- 分榜
		for i=1, 12 do
			local tbSubShow = GetTotalLadderPart(nType + i, 1, 10);
			local szSubContext	= szDate .. self.tbFacContext[i];
			local szLadderName	= self.tbFacContext[i];
			self:SetShowLadder(tbSubShow, nType + i, szLadderName, szSubContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		end
		print("Xếp hạng Võ Lâm kết thúc");
	end
	
	-- 财富荣誉
	function PlayerHonor:UpdateMoneyHonorLadder()
		print("Xếp hạng Tài Phú bắt đầu");
		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_MONEY];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);
		-- 这里执行价值量变化函数
		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Tài Phú";	
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		self:GetHonorStatInfo(self.HONOR_CLASS_MONEY, 100, "moneyhonor", "Money");
		print("Xếp hạng Tài Phú kết thúc");
	end
	
	-- 领袖荣誉
	function PlayerHonor:UpdateLeaderHonorLadder()
		print("Xếp hạng Thủ Lĩnh bắt đầu");
		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_LINGXIU];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);
		-- 这里执行价值量变化函数
		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Thủ Lĩnh";	
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		print("Xếp hạng Thủ Lĩnh kết thúc");
	end
	
		-- 飞絮崖荣誉榜
	function PlayerHonor:UpdateSpringHonorLadder()
		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_SPRING];

		if (not tbLadderCfg) then
			return 0;
		end		
		
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);
		-- 这里执行价值量变化函数
		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. tbLadderCfg.szLadderName;	
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		GlobalExcute{"Ladder:RefreshLadderName"};
	end
	
		-- 逍遥荣誉榜
	function PlayerHonor:UpdateXoyoLadder(nFlag)
		print("Xếp hạng Tiêu Dao Cốc bắt đầu");
		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_XOYOGAME];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);
		-- 这里执行价值量变化函数
		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Tiêu Dao";	
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		GlobalExcute{"Ladder:RefreshLadderName"};
		
		print("Xếp hạng Tiêu Dao Cốc kết thúc");
		
		if (0 == nFlag) then
			return;
		end
		SetXoyoAwardResult();
	end
	
	-- 门派荣誉
	function PlayerHonor:OnSchemeLoadFactionHonorLadder()
		self:DbgOut_GC("OnSchemeLoadFactionHonorLadder", "Update faction honor");

		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_FACTION];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Môn Phái";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	
		UpdateLadderDataForFaction(nType, 1);
		-- 分榜
		for i=1, 12 do
			local tbSubShow = GetTotalLadderPart(nType + i, 1, 10);
			local szSubContext	= szDate .. self.tbFacContext[i];
			local szLadderName	= self.tbFacContext[i];
			self:SetShowLadder(tbSubShow, nType + i, szLadderName, szSubContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		end
	end
	
		-- 宋金荣誉
	function PlayerHonor:OnSchemeUpdateSongJinBattleHonorLadder()
		self:DbgOut_GC("OnSchemeUpdateSongJinBattleHonorLadder", "Update songjin battle honor");

		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_BATTLE];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Tống Kim";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	end
	
		-- 禅境花园荣誉（清明节活动）
	function PlayerHonor:OnSchemeUpdateDragonBoatHonorLadder()
		self:DbgOut_GC("OnSchemeUpdateDragonBoatHonorLadder", "Update DragonBoat honor");

		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_DRAGONBOAT];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Bảng vinh dự Thiền Cảnh Hoa Viên";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	end
	
	function PlayerHonor:OnSchemeUpdateWeiwangHonorLadder()
		self:DbgOut_GC("OnSchemeUpdateWeiwangHonorLadder", "Update DragonBoat honor");

		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_WEIWANG];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Uy danh";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	end	

	function PlayerHonor:OnSchemeUpdatePrettygirlHonorLadder()
		self:DbgOut_GC("OnSchemeUpdatePrettygirlHonorLadder", "Update DragonBoat honor");

		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_PRETTYGIRL];
		
		if (not tbLadderCfg) then
			return 0;
		end
		
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Mỹ Nữ";		--"Tuyển chọn mỹ nữ";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
		GlobalExcute{"Ladder:RefreshLadderName"};
	end		
	
	function PlayerHonor:OnSchemeUpdateKaimenTaskHonorLadder()
		self:DbgOut_GC("OnSchemeUpdateKaimenTaskHonorLadder", "Update DragonBoat honor");

		local nType = 0;
		local tbLadderCfg = Ladder.tbLadderConfig[self.HONOR_CLASS_KAIMENTASK];
		nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
		UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

		local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
		local nNowTime	= GetTime();
		local tbToday	= os.date("*t", nNowTime - 3600*24);
		local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
		local szContext = szDate .. "Bá Chủ Ấn";
		self:SetShowLadder(tbShowLadder, nType, tbLadderCfg.szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	end		

	function PlayerHonor:SetShowLadder(tbLadderResult, nType, szLadderName, szContext, szPlayerContext, szSimpleInfo)
		if (not tbLadderResult) then
			print("Tại đây không có số liệu xếp hạng....");
			return;
		end
		
		if (not szLadderName) then
			return;
		end
		
		DelShowLadder(nType);
		AddNewShowLadder(nType);
		SetShowLadderName(nType, szLadderName, string.len(szLadderName) + 1);
		self:ProcessShowLadderDetail(tbLadderResult, nType, szContext, szLadderName, szPlayerContext, szSimpleInfo);
	end
	
	function PlayerHonor:ProcessShowLadderDetail(tbLadderResult, nType, szContext, szLadderName, szPlayerContext, szSimpleInfo)
		local tbShowWorldLadder = {};
		for i, tbInfo in ipairs(tbLadderResult) do
			local tbPlayerInfo = GetPlayerInfoForLadderGC(tbInfo.szPlayerName);
			if (tbPlayerInfo) then
				local tbShowInfo = {};
				tbShowInfo.szName		= tbInfo.szPlayerName;
				tbShowInfo.szTxt1		= string.format(szSimpleInfo, tbInfo.dwValue);
				tbShowInfo.szContext	= string.format(szPlayerContext, tbInfo.dwValue);
				tbShowInfo.dwImgType	= tbPlayerInfo.nSex;
				tbShowInfo.szTxt2		= Player:GetFactionRouteName(tbPlayerInfo.nFaction, tbPlayerInfo.nRoute);
				tbShowInfo.szTxt3		= string.format("Cấp %d", tbPlayerInfo.nLevel);
				local szKinName			= tbPlayerInfo.szKinName
				if (not szKinName or string.len(szKinName) <= 0) then
					szKinName	= "Không phải thành viên gia tộc";
				end
				tbShowInfo.szTxt4 = "Gia tộc: " .. szKinName;
				
				local szTongName			= tbPlayerInfo.szTongName
				if (not szTongName or string.len(szTongName) <= 0) then
					szTongName	= "Không phải thành viên bang hội";
				end
				tbShowInfo.szTxt5 = "Bang hội: " .. szTongName;
				tbShowInfo.szTxt6	= "0";
				tbShowWorldLadder[#tbShowWorldLadder + 1] = tbShowInfo;
			end
		end
		SetShowLadder(nType, szContext, string.len(szContext) + 1, tbShowWorldLadder);
		SetShowLadderName(nType, szLadderName, string.len(szLadderName) + 1);
	end
	
	function PlayerHonor:DbgOut_GC(szMode, ...)
		Dbg:Output("PlayerHonor", szMode, unpack(arg));
	end
	
	function PlayerHonor:AddPlayerHonor(nPlayerId, nClass, nType, nAddHonor)
		local nHonor = GetPlayerHonor(nPlayerId, nClass, nType);
		SetPlayerHonor(nPlayerId, nClass, nType, nAddHonor + nHonor);
	end
	
	function PlayerHonor:SetPlayerHonor(nPlayerId, nClass, nType, nAddHonor)
		SetPlayerHonor(nPlayerId, nClass, nType, nAddHonor);
	end
	
	function PlayerHonor:SetPlayerHonorByName(szName, nClass, nType, nHonor)
		SetPlayerHonorByName(szName, nClass, nType, nHonor);
	end
	
	function PlayerHonor:SetPlayerXoyoPointsByName(szName, nHonor)
		SetXoyoPointsByName(szName, nHonor);
	end
	
	function PlayerHonor:GetPlayerHonorByName(szName, nClass, nType)
		return GetPlayerHonorByName(szName, nClass, nType);
	end
	
	function PlayerHonor:GetPlayerHonor(nPlayerId, nClass, nType)
		return GetPlayerHonor(nPlayerId, nClass, nType);
	end

	function PlayerHonor:GetPlayerHonorRank(nPlayerId, nClass, nType)
		return GetPlayerHonorRank(nPlayerId, nClass, nType);
	end

	function PlayerHonor:GetPlayerHonorRankByName(szName, nClass, nType)
		return GetPlayerHonorRankByName(szName, nClass, nType);
	end
end



-- gameserver脚本---------------------------------------------------------------------------
if (MODULE_GAMESERVER) then
	
function PlayerHonor:SendHonorData()
	local nPlayerId	= me.nId;
	local nFaction	= me.nFaction;
	local nTime		= GetTime();
	
	local tbHonorData = {};
	for nRow, tbSetting in ipairs(self.tbHonorSettings) do
		local tbHonorSubList = {};
		
		for nType, tbData in ipairs(tbSetting.tbHonorSubList) do
			local nClass	= tbData.nClass;
			local tbHonorDataDetail		= {};
			tbHonorDataDetail.szName	= tbData.szName;
			local nValue	= 0;
			local nRank		= 0;

			local nSmallType = 0;
			if (self.HONOR_CLASS_FACTION == nClass) then
				nSmallType = nType - 1;
			end

			nValue	= GetPlayerHonor(nPlayerId, nClass, nSmallType);
			nRank	= GetPlayerHonorRank(nPlayerId, nClass, nSmallType);

			tbHonorDataDetail.nValue	= nValue;
			tbHonorDataDetail.nRank		= nRank;
			tbHonorDataDetail.nLevel	= 0;
			tbHonorDataDetail.nClass	= nClass;
			tbHonorSubList[nType] 		= tbHonorDataDetail;
		end
		
		tbHonorData[nRow]	= {};
		tbHonorData[nRow].tbHonorSubList	= tbHonorSubList;
		tbHonorData[nRow].szName			= tbSetting.szName;
	end
	me.CallClientScript({"PlayerHonor:OnSyncHonorData", tbHonorData});
end

function PlayerHonor:AddPlayerHonor(pPlayer, nClass, nType, nAddHonor)
	local szHonorName = self:GetHonorName(nClass, nType);
	if (not szHonorName) then
		return;
	end
	local nHonor = GetPlayerHonor(pPlayer.nId, nClass, nType);
	SetPlayerHonorByName(szHonorName, nClass, nType, nAddHonor + nHonor);
	GCExcute({"PlayerHonor:AddPlayerHonor", pPlayer.nId, nClass, nType, nAddHonor});
	pPlayer.Msg("Điểm " .. szHonorName .. " của bạn tăng " .. string.format("%d", nAddHonor));
end

function PlayerHonor:AddPlayerHonorById_GS(nPlayerId, nClass, nType, nAddHonor)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		PlayerHonor:AddPlayerHonor(pPlayer, nClass, nType, nAddHonor);
	else
		GCExcute({"PlayerHonor:AddPlayerHonor", nPlayerId, nClass, nType, nAddHonor});
	end
end

function PlayerHonor:SetPlayerHonor(nPlayerId, nClass, nType, nAddHonor)
	GCExcute({"PlayerHonor:SetPlayerHonor", nPlayerId, nClass, nType, nAddHonor});
end

function PlayerHonor:SetPlayerHonorByName(szName, nClass, nType, nHonor)
	GCExcute({"PlayerHonor:SetPlayerHonorByName", szName, nClass, nType, nHonor});
end

function PlayerHonor:SetPlayerXoyoPointsByName(szName, nHonor)
	GCExcute({"PlayerHonor:SetPlayerXoyoPointsByName", szName, nHonor});
end

function PlayerHonor:GetPlayerHonorByName(szName, nClass, nType)
	return GetPlayerHonorByName(szName, nClass, nType);
end

function PlayerHonor:GetPlayerHonor(nPlayerId, nClass, nType)
	return GetPlayerHonor(nPlayerId, nClass, nType);
end

function PlayerHonor:GetPlayerHonorRank(nPlayerId, nClass, nType)
	return GetPlayerHonorRank(nPlayerId, nClass, nType);
end

function PlayerHonor:GetPlayerHonorRankByName(szName, nClass, nType)
	return GetPlayerHonorRankByName(szName, nClass, nType);
end

function PlayerHonor:AddConsumeValue(pPlayer, nValue, szWay)
	
	if not pPlayer or nValue < 0 then
		return 0;
	end
	local nLowValue = KLib.Number2UInt(pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE));
	local nHighValue = KLib.Number2UInt(pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE_HIGH)) * 10^9;
	local nConsumeValue = nLowValue + nHighValue + nValue;
	local nSaveLowValue = math.mod(nConsumeValue, 10^9);
	local nSaveHighValue = math.floor(nConsumeValue / 10^9);
	pPlayer.SetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE, nSaveLowValue);
	pPlayer.SetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE_HIGH, nSaveHighValue);
	Dbg:WriteLog("AddConsumeValue", nValue, pPlayer.szAccount, pPlayer.szName, (szWay or "Không rõ đường dẫn"))
	self:UpdataMaxWealth(pPlayer);
end


end


-- 客户端脚本 ------------------------------------------------------------------------------
if (MODULE_GAMECLIENT) then

if (not PlayerHonor.tbPlayerHonorData) then
	PlayerHonor.tbPlayerHonorData = {};
	PlayerHonor.tbPlayerHonorData.tbHonorData	= {};
	PlayerHonor.tbPlayerHonorData.nSaveTime		= 0;
end

function PlayerHonor:ApplyHonorData()
	local nNowTime	= GetTime();
	local tbPlayerHonorData	= self.tbPlayerHonorData;
	if (tbPlayerHonorData and tbPlayerHonorData.nSaveTime > 0 and nNowTime - tbPlayerHonorData.nSaveTime <= 10) then
		return;
	end
	me.CallServerScript{"HonorDataApplyCmd"};
end

function PlayerHonor:OnSyncHonorData(tbHonorData)
	if (not tbHonorData) then
		return;
	end
	local nNowTime			= GetTime();
	
	for _, tbDate in ipairs(tbHonorData) do
		local tbSubDate = tbDate.tbHonorSubList;
		for nType, tbInfo in ipairs(tbSubDate) do
			local nClass = tbInfo.nClass;
			tbInfo.nLevel = self:GetHonorLevel(me, nClass);
		end
	end
	
	PlayerHonor.tbPlayerHonorData.tbHonorData	= tbHonorData;
	PlayerHonor.tbPlayerHonorData.nSaveTime		= nNowTime;
	CoreEventNotify(UiNotify.emCOREEVENT_HONORDATAREFRESH);
end

end

function PlayerHonor:CalcHonorLevel(nHonorValue, nHonorRank, szTypeName)
	local nRetLevel	= 0;
	for nLevel, tb in ipairs(self.tbHonorLevelInfo[szTypeName].tbLevel) do
		if (nHonorRank > 0) then
			if ((nHonorRank > tb.nMaxRank or nHonorValue < tb.nMinValue) and (tb.nMaxValue <= 0 or nHonorValue < tb.nMaxValue)) then
				break;
			end
		else
			if (tb.nMaxValue <= 0 or nHonorValue < tb.nMaxValue) then
				break;
			end
		end
		nRetLevel	= nLevel;
	end
	return nRetLevel;
end

function PlayerHonor:RefreshHonorLevel(pPlayer)
	local nLadderTime	= KGblTask.SCGetDbTaskInt(DBTASD_HONOR_LADDER_TIME) + 1;	-- 按照+1计算，保证不会有0
	local nRefreshTime	= pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_REFRESH_TIME);
	
	if (nRefreshTime == nLadderTime) then	-- 排行后此玩家没有刷新过
		local nHonorLevel = self:GetPlayerMaxHonorLevel(pPlayer);
		pPlayer.SetHonorLevel(nHonorLevel);	-- 设定当前荣誉等级
		return;
	end

	local nHonorLevel	= 0;
	local szLevelName	= "";
	local tbMyLevel		= {};
	local tbLevelDate	= {};	-- 三种荣誉等级存储位置
	for szType, tbTypeInfo in pairs(self.tbHonorLevelInfo) do
		local nHonorId		= tbTypeInfo.nHonorId;
		local nHonorRank	= self:GetPlayerHonorRank(pPlayer.nId, nHonorId, 0);
		local nHonorValue	= self:GetPlayerHonor(pPlayer.nId, nHonorId, 0);
		local nThisLevel	= self:CalcHonorLevel(nHonorValue, nHonorRank, szType);
		if (nThisLevel > 0) then
			tbMyLevel[#tbMyLevel+1]	= string.format("Hạng %s cấp %d", tbTypeInfo.szName, nThisLevel);
			if (nThisLevel > nHonorLevel) then
				nHonorLevel	= nThisLevel;
				szLevelName	= tbTypeInfo.tbLevel[nThisLevel].szName;
			end
		end
		tbLevelDate[szType] = nThisLevel;
	end
	
	local szMyLevel	= table.concat(tbMyLevel, "、");
	if (nHonorLevel > 0) then	-- 有排名时要发一封通知邮件
		local szMailMsg		= string.format([[
　　
　　Xếp hạng vinh dự của bạn vào 3 giờ sáng hôm nay là: %s, nội dung chi tiết vào xem ở <link=openwnd:Bảng xếp hạng,UI_LADDER>.
　　Đồng thời, bạn nhận được chức %s, có thể đến chỗ <color=yellow>Chủ Tiền Trang mua trang bị quan trọng nhất trong Kiếm Thế - Phi Phong<color>, bạn có thể xem nội dung cụ thể vào xem ở <link=openwnd:Cẩm nang trợ giúp,UI_HELPSPRITE>.
]],
			szMyLevel, szLevelName);
		KPlayer.SendMail(pPlayer.szName, "Đổi mới Xếp hạng vinh dự", szMailMsg);
	end
	
	self:WriteLog(Dbg.LOG_INFO, "RefreshHonorLevel", pPlayer.szName, nHonorLevel, szMyLevel, nRefreshTime, nLadderTime);

	pPlayer.SetHonorLevel(nHonorLevel);	-- 设定当前荣誉等级
	for szType, nLevel in pairs(tbLevelDate) do
		self:SavePlayerHonorLevel(pPlayer, szType, nLevel);
	end
	pPlayer.SetTask(self.TSK_GROUP, self.TSK_ID_REFRESH_TIME, nLadderTime);	-- 记录刷新时间
	self:ClearMaxWealth(pPlayer);
end

function PlayerHonor:GetPlayerMaxHonorLevel(pPlayer)
	local nHonorLevel = 0;
	for szType, tbTypeInfo in pairs(self.tbHonorLevelInfo) do
		local nLevelTaskId	= tbTypeInfo.nLevelTaskId;
		local nThisLevel	= pPlayer.GetTask(self.TSK_GROUP, nLevelTaskId);
		if (nThisLevel > 0) then
			if (nThisLevel > nHonorLevel) then
				nHonorLevel	= nThisLevel;
			end
		end
	end
	return nHonorLevel;	
end

function PlayerHonor:SavePlayerHonorLevel(pPlayer, szType, nLevel)
	local tbInfo = self.tbHonorLevelInfo[szType];
	if (tbInfo and tbInfo.nLevelTaskId > 0) then
		pPlayer.SetTask(self.TSK_GROUP, tbInfo.nLevelTaskId, nLevel);
	end
end

function PlayerHonor:OnLadderSorted()
	for _, pPlayer in ipairs(KPlayer.GetAllPlayer()) do
		self:RefreshHonorLevel(pPlayer);
	end
end

function PlayerHonor:OnLogin()
	if GLOBAL_AGENT then
		local nHonorLevel = self:GetPlayerMaxHonorLevel(me);
		me.SetHonorLevel(nHonorLevel);	-- 设定当前荣誉等级
	else 
		self:UpdataEquipWealth(me, Item.EQUIPPOS_MANTLE)
		self:RefreshHonorLevel(me);
	end
	self:SendHonorData();
end

function PlayerHonor:UpdataEquipWealth(pPlayer, nEquipPos, bClear)
	local nTaskId = nEquipPos + 1;
	if not pPlayer then
		return 0;
	end
	if (nEquipPos >= Item.EQUIPPOS_NUM) then
		return 0;
	end

	local nValue1	= self:CaculateTotalEquipValue(pPlayer, Item.ROOM_EQUIPEX, Item.ROOM_EQUIP, nEquipPos);
	local nValue2	= self:CaculateTotalEquipValue(pPlayer, Item.ROOM_EQUIP, Item.ROOM_EQUIPEX, nEquipPos);

	local nTotleValue = math.max(nValue1, nValue2);

	local nCurMax = pPlayer.GetTask(self.WEALTH_TASK_GROUP, nTaskId);
	if (nTotleValue > nCurMax) or (bClear and bClear == 1) then
		pPlayer.SetTask(self.WEALTH_TASK_GROUP, nTaskId, nTotleValue);
	end
	if (nTotleValue > nCurMax) and (not bClear or bClear ~= 1) then		-- 清数据的时候不在这里更新
		self:UpdataMaxWealth(pPlayer);
	end
end

--刷新记录的同伴价值量
function PlayerHonor:UpdatePartnerValue(pPlayer, bClear)
	local nPartnerValue = Partner:GetPartnerValue(pPlayer.GetPartner(pPlayer.nActivePartner));
	local nTaskPartnerValue = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_PARTNER_VALUE);
	if nPartnerValue > nTaskPartnerValue or bClear == 1 then
		pPlayer.SetTask(self.TSK_GROUP, self.TSK_ID_PARTNER_VALUE, nPartnerValue);
		if bClear ~= 1 then
			self:UpdataMaxWealth(pPlayer);
		end
	end
end

function PlayerHonor:CaculateTotalEquipValue(pPlayer, nRoomType1, nRoomType2, nEquipPos)
	local nTotleValue = 0;
	-- 先计算后备装备栏的强化价值量
	local pEquip = pPlayer.GetItem(nRoomType1, nEquipPos, 0);
	if pEquip then
		local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
		if (tbSetting) then
			local nTypeRate = ((tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100) or 1;
			local nEnhTimes = pEquip.nEnhTimes;
			repeat
				local nEnhValue = tbSetting.m_tbEnhanceValue[nEnhTimes] or 0;
				nTotleValue = nTotleValue + nEnhValue * nTypeRate;
				nEnhTimes = nEnhTimes - 1;
			until (nEnhTimes <= 0);
				
			--需要算上改造价值量  added by dengyong 2009-11-12
			if pEquip.nStrengthen == 1 then
				local nStrengthenValue = tbSetting.m_tbStrengthenValue[pEquip.nEnhTimes] or 0;
				nTotleValue = nTotleValue + nStrengthenValue * nTypeRate;
			end			
		end
	end
	-- 再取装备价值量
	pEquip = pPlayer.GetItem(nRoomType2, nEquipPos, 0);
	if pEquip then
		nTotleValue = nTotleValue + pEquip.nValue;
	end

	return nTotleValue;
end

function PlayerHonor:UpdataMaxWealth(pPlayer)
	local nTotleValue = 0;
	-- 获取各个位置的装备总和
	for i = 1, Item.EQUIPPOS_NUM do
		nTotleValue = nTotleValue + pPlayer.GetTask(self.WEALTH_TASK_GROUP, i);
	end
	local tbWuLin = Item:GetClass("wulinmiji");
	local tbXiShui = Item:GetClass("xisuijing");

	for i, tbParam in ipairs(tbWuLin.tbBook) do
		if self.tbBookToValue[i] then
			nTotleValue = nTotleValue + self.tbBookToValue[i] * pPlayer.GetTask(tbParam[2], tbParam[3]);
		end
	end
	for i, tbParam in ipairs(tbXiShui.tbBook) do
		if self.tbBookToValue[i] then
			nTotleValue = nTotleValue + self.tbBookToValue[i] * pPlayer.GetTask(tbParam[2], tbParam[3]);
		end
	end
	
	nTotleValue = nTotleValue + 1000000 * pPlayer.GetTask(2040, 20);	--加技能月饼（彩云追月）
	nTotleValue = nTotleValue + 1000000 * pPlayer.GetTask(2040, 21);	--加潜能月饼（沧海月明）
	
	--计算同伴价值量，zhaoyu 2009/12/16 14:51:54
	nTotleValue = nTotleValue + pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_PARTNER_VALUE);	
	
	-- 计算消耗型财富的累加
	local nLowValue = KLib.Number2UInt(pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE));
	local nHighValue = KLib.Number2UInt(pPlayer.GetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE_HIGH)) * 10^9;
	nTotleValue = nTotleValue + nHighValue + nLowValue;
	
	self:WriteLog(Dbg.LOG_INFO, "UpdataMaxWealth", pPlayer.szName, pPlayer.nId, PlayerHonor.HONOR_CLASS_MONEY , 0, nTotleValue);
	nTotleValue = math.floor(nTotleValue / 10000);
	self:SetPlayerHonor(pPlayer.nId, PlayerHonor.HONOR_CLASS_MONEY , 0, nTotleValue); --通过玩家id设置财富
end

function PlayerHonor:ClearMaxWealth(pPlayer)
	for i = 0, Item.EQUIPPOS_NUM - 1 do
		self:UpdataEquipWealth(pPlayer, i, 1);
	end
	self:UpdatePartnerValue(pPlayer, 1)
	self:UpdataMaxWealth(pPlayer);
end

function PlayerHonor:GetHonorStatInfo(nHonorClass, nMaxSize, szFileName, szHonorName)
	local szGateway		= GetGatewayName();
	local nLadderType	= GetLadderTypeByDataType(nHonorClass, 0);
	if (not szFileName or string.len(szFileName) <= 0) then
		print("PlayerHonor:GetHonorStatInfo there is no szFileName!!!");
		return;
	end
	
	if (not szHonorName or string.len(szHonorName) <= 0) then
		print("PlayerHonor:GetHonorStatInfo there is no szHonorName!!!");
		return;
	end
	
	if (nHonorClass <= 0) then
		print("PlayerHonor:GetHonorStatInfo there is no nHonorClass!!!");
		return;
	end

	print("PlayerHonor:GetHonorStatInfo() start ", szFileName);
	
	local szOutFile = "\\playerladder\\" .. szFileName .. "_" .. szGateway .. ".txt";
	
	local szTime	= os.date("%Y-%m-%d %H:%M:%S", GetTime());
	
	local szContext = "Rank\tGateWay\tAccount\tPlayerName\tFaction\tRoute\tLevel\tSex\tKinName\tTongName\t" .. szHonorName .. "Honor\t" .. szTime .. "\n";
	
	--"排名\t所在区服\t账号\t角色名\t门派\t路线\t玩家等级\t性别\t家族\t帮会\t" .. szHonorName .. "荣誉值\n";

	for i=1, 100 do
		local tbLadderInfo = GetPlayerLadderInfoByRank(nLadderType, i);
		if (tbLadderInfo) then
			local tbInfo = GetPlayerInfoForLadderGC(tbLadderInfo.szPlayerName);
			if (tbInfo) then
				local szOut = i .. "\t" .. szGateway .. "\t" .. tbInfo.szAccount .. "\t" .. tbLadderInfo.szPlayerName .. "\t" .. Player:GetFactionRouteName(tbInfo.nFaction) .. "\t" .. Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute) .. "\t" .. tbInfo.nLevel .. "\t" .. Player.SEX[tbInfo.nSex] .. "\t";

				if (string.len(tbInfo.szKinName) > 0) then
					szOut = szOut .. tbInfo.szKinName .. "\t";
				else
					szOut = szOut .. "Không gia tộc\t";
				end 

				if (string.len(tbInfo.szTongName) > 0) then
					szOut = szOut .. tbInfo.szTongName .. "\t";
				else
					szOut = szOut .. "Không bang hội\t";
				end
				szOut = szOut .. tbLadderInfo.dwValue .. "\n";
				szContext = szContext .. szOut;
			end
		end
	end
	KFile.WriteFile(szOutFile, szContext);

	for i=1, GbWlls.DEF_ADV_MAXGBWLLS_MONEY_RANK do
		local tbLadderInfo = GetPlayerLadderInfoByRank(nLadderType, i);
		if (tbLadderInfo) then
			Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWlls_Join_" .. szHonorName, i, tbLadderInfo.szPlayerName, tbLadderInfo.dwValue);
		end
	end


	print("PlayerHonor:GetHonorStatInfo() end\n");
end

PlayerHonor:Init();

if (MODULE_GAMESERVER) then
	PlayerEvent:RegisterGlobal("OnLogin", PlayerHonor.OnLogin, PlayerHonor);
--	PlayerSchemeEvent:RegisterGlobalWeekEvent({PlayerHonor.OnWeekEvent_DecreaseFactionHonor, PlayerHonor});
end
