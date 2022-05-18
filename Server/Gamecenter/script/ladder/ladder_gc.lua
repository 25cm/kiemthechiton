-- 文件名　：ladder_gc.lua
-- 创建者　：zhouchenfei
-- 创建时间：2008-03-20 16:40:25

Require("\\script\\player\\playerhonor.lua");
Require("\\script\\ladder\\define.lua")

-- Ladder.tbLadderConfig 排行榜配置table
--
--
function Ladder:InitLadderConfig()
	self.tbLadderConfig	= {
		[PlayerHonor.HONOR_CLASS_WULIN] 		= { 
				nLadderClass	= self.LADDER_CLASS_WULIN, 
				nLadderType		= self.LADDER_TYPE_WULIN_HONOR_WULIN,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_WULIN,
				nEffectNum		= 5000,
				szLadderName	= "Võ lâm",
				szPlayerContext	= "Vinh dự: %d\n Nhấp vào Liệt kê xem xếp hạng\n Chủ Tiền Trang có bán Phi Phong\n",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,
		},
		[PlayerHonor.HONOR_CLASS_FACTION]		= {
				nLadderClass	= self.LADDER_CLASS_WULIN, 
				nLadderType		= self.LADDER_TYPE_WULIN_HONOR_FACTION,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_FACTION,
				nEffectNum		= 1000,
				szLadderName	= "Môn phái",
				szPlayerContext	= "Vinh dự: %d",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 1,	
		},
		[PlayerHonor.HONOR_CLASS_WLLS]			= {
				nLadderClass	= self.LADDER_CLASS_WLLS, 
				nLadderType		= self.LADDER_TYPE_WLLS_HONOR,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_WLLS,
				nEffectNum		= 5000,
				szLadderName	= "Liên đấu",
				szPlayerContext	= "Vinh dự: %d",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,	
		},
		[PlayerHonor.HONOR_CLASS_BATTLE]		= {
				nLadderClass	= self.LADDER_CLASS_WULIN, 
				nLadderType		= self.LADDER_TYPE_WULIN_HONOR_SONGJINBATTLE,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_BATTLE,
				nEffectNum		= 1000,
				szLadderName	= "Tống Kim",
				szPlayerContext	= "Vinh dự: %d",	
				szPlayerSimpleInfo = "%d điểm",	
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,			
		},
		[PlayerHonor.HONOR_CLASS_LINGXIU]		= {
				nLadderClass	= self.LADDER_CLASS_LINGXIU, 
				nLadderType		= self.LADDER_TYPE_LINGXIU_HONOR_LINGXIU,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_LINGXIU,
				nEffectNum		= 5000,
				szLadderName	= "Thủ Lĩnh",
				szPlayerContext	= "Vinh dự: %d\n Nhấp vào Liệt kê xem xếp hạng\n Chủ Tiền Trang có bán Phi Phong\n",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,
		},
		[PlayerHonor.HONOR_CLASS_AREARBATTLE]	= {
				nLadderClass	= self.LADDER_CLASS_LINGXIU, 
				nLadderType		= self.LADDER_TYPE_LINGXIU_HONOR_AREABATTLE,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_AREARBATTLE,
				nEffectNum		= 1000,
				szLadderName	= "Tranh Đoạt",
				szPlayerContext	= "Vinh dự: %d",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 0,
				nSubLadderLoad	= 0,
		},
		[PlayerHonor.HONOR_CLASS_BAIHUTANG]		= {
				nLadderClass	= self.LADDER_CLASS_LINGXIU, 
				nLadderType		= self.LADDER_TYPE_LINGXIU_HONOR_BAIHUTANG,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_BAIHUTANG,
				nEffectNum		= 1000,
				szLadderName	= "Bạch Hổ Đường",
				szPlayerContext	= "Vinh dự: %d",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 0,
				nSubLadderLoad	= 0,
		},
		[PlayerHonor.HONOR_CLASS_MONEY]			= {
				nLadderClass	= self.LADDER_CLASS_MONEY, 
				nLadderType		= self.LADDER_TYPE_MONEY_HONOR_MONEY,
				nLadderSmall	= 0,
				nDataClass		= PlayerHonor.HONOR_CLASS_MONEY,
				nEffectNum		= 5000,
				szLadderName	= "Tài Phú",
				szPlayerContext	= "Vinh dự: %d\n Nhấp vào Liệt kê xem xếp hạng\n Chủ Tiền Trang có bán Phi Phong\n",	
				szPlayerSimpleInfo = "%d điểm",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,
		},
		[PlayerHonor.HONOR_CLASS_SPRING]		= {
				nLadderClass	= self.LADDER_CLASS_LADDER, 
				nLadderType		= self.LADDER_TYPE_LADDER_ACTION,
				nLadderSmall	= self.LADDER_TYPE_LADDER_ACTION_SPRING,
				nDataClass		= PlayerHonor.HONOR_CLASS_SPRING,
				nEffectNum		= 5000,
				szLadderName	= "Gia tộc đoàn viên",
				szPlayerContext	= "Thu thập: %d\n Nhấp vào Liệt kê xem xếp hạng\n",	
				szPlayerSimpleInfo = "%d",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,		
		},
		[PlayerHonor.HONOR_CLASS_DRAGONBOAT]		= {
				nLadderClass	= self.LADDER_CLASS_LADDER, 
				nLadderType		= self.LADDER_TYPE_LADDER_ACTION,
				nLadderSmall	= self.LADDER_TYPE_LADDER_ACTION_DRAGONBOAT,
				nDataClass		= PlayerHonor.HONOR_CLASS_DRAGONBOAT,
				nEffectNum		= 5000,
				szLadderName	= "Thiền Cảnh Hoa Viên",
				szPlayerContext	= "Vinh dự: %d\n Nhấp vào Liệt kê xem xếp hạng\n",	
				szPlayerSimpleInfo = "%d điểm",	
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,
				nNoChangeRank	= 1,	
		},
		[PlayerHonor.HONOR_CLASS_WEIWANG]		= {
				nLadderClass	= self.LADDER_CLASS_LADDER, 
				nLadderType		= self.LADDER_TYPE_LADDER_ACTION,
				nLadderSmall	= self.LADDER_TYPE_LADDER_ACTION_WEIWANG,
				nDataClass		= PlayerHonor.HONOR_CLASS_WEIWANG,
				nEffectNum		= 5000,
				szLadderName	= "Uy danh",
				szPlayerContext	= "Vinh dự: %d\n Nhấp vào Liệt kê xem xếp hạng\n",	
				szPlayerSimpleInfo = "%d điểm",	
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,
				nNoChangeRank	= 1,
		},
		[PlayerHonor.HONOR_CLASS_PRETTYGIRL]		= {
				nLadderClass	= self.LADDER_CLASS_LADDER, 
				nLadderType		= self.LADDER_TYPE_LADDER_ACTION,
				nLadderSmall	= self.LADDER_TYPE_LADDER_ACTION_PRETTYGIRL,
				nDataClass		= PlayerHonor.HONOR_CLASS_PRETTYGIRL,
				nEffectNum		= 5000,
				szLadderName	= "Mỹ nữ",
				szPlayerContext	= "Số phiếu: %d\n Nhấp vào Liệt kê xem xếp hạng\n",	
				szPlayerSimpleInfo = "%d phiếu",
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,
		},				
		[PlayerHonor.HONOR_CLASS_XOYOGAME]		= {
				nLadderClass	= self.LADDER_CLASS_LADDER, 
				nLadderType		= self.LADDER_TYPE_LADDER_ACTION,
				nLadderSmall	= self.LADDER_TYPE_LADDER_ACTION_XOYOGAME,
				nDataClass		= PlayerHonor.HONOR_CLASS_XOYOGAME,
				nEffectNum		= 5000,
				szLadderName	= "Tiêu Dao Cốc",
				szPlayerContext	= "%d",	
				szPlayerSimpleInfo = "%d",	
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,	
		},
		[PlayerHonor.HONOR_CLASS_KAIMENTASK]		= {
				nLadderClass	= self.LADDER_CLASS_LADDER, 
				nLadderType		= self.LADDER_TYPE_LADDER_ACTION,
				nLadderSmall	= self.LADDER_TYPE_LADDER_ACTION_KAIMENTASK,
				nDataClass		= PlayerHonor.HONOR_CLASS_KAIMENTASK,
				nEffectNum		= 5000,
				szLadderName	= "Bá Chủ Ấn",
				szPlayerContext	= "%d",	
				szPlayerSimpleInfo = "%d",	
				nGCStartLoad	= 1,
				nSubLadderLoad	= 0,	
		},
	};
end

if (not MODULE_GC_SERVER) then
	return;
end

function Ladder:LoadLevelLadder()
	print("Danh sách xếp hạng đầu tiên.......");
	local tbLevelLadderResult = UpdateLevelLadder();
	self:SetLevelShowLadder(tbLevelLadderResult);
	print("Hoàn thành danh sách.......");
end

function Ladder:SetLevelShowLadder(tbLevelLadderResult)
	if (not tbLevelLadderResult) then
		print("Không có trong danh sách.....");
		return;
	end
	local nNowTime	= GetTime();
	local tbToday	= os.date("*t", nNowTime - 3600*24);
	local szDate	= string.format("%d - %d", tbToday.month, tbToday.day);
	local nType 	= self:GetType(0, self.LADDER_CLASS_LADDER, self.LADDER_TYPE_LADDER_LEVEL, 0);
	local szContext		= szDate .. self.tbFacContext[0];
	local szLadderName	= self.tbFacContext[0];
	
	for i=0, 12 do
		DelShowLadder(nType + i);
		AddNewShowLadder(nType + i);
		SetShowLadderName(nType + i, self.tbFacContext[i], string.len(self.tbFacContext[i]) + 1);
	end
	
	self:ProcessLevelShowLadderDetail(tbLevelLadderResult.tbLevelWorldLadder, nType, szContext, szLadderName);
	for i, tbLadder in pairs(tbLevelLadderResult.tbLevelFactLadder) do
		szContext		= szDate .. self.tbFacContext[i];
		szLadderName	= self.tbFacContext[i];
		self:ProcessLevelShowLadderDetail(tbLadder, nType + i, szContext, szLadderName);
	end
end

function Ladder:ProcessLevelShowLadderDetail(tbLevelLadder, nType, szContext, szLadderName)
	local tbShowWorldLadder = {};
	for i, tbInfo in ipairs(tbLevelLadder) do
		local tbPlayerInfo = GetPlayerInfoForLadderGC(tbInfo.szName);
		if (tbPlayerInfo) then
			local tbShowInfo = {};
			tbShowInfo.szName		= tbInfo.szName;
			tbShowInfo.szTxt1		= string.format("Cấp %d", tbInfo.nValue);
			tbShowInfo.szContext	= string.format("Cấp %d", tbInfo.nValue);
			tbShowInfo.dwImgType	= tbPlayerInfo.nSex;
			tbShowInfo.szTxt2		= Player:GetFactionRouteName(tbPlayerInfo.nFaction, tbPlayerInfo.nRoute);
			tbShowInfo.szTxt3		= string.format("Cấp %d", tbPlayerInfo.nLevel);
			local szKinName			= tbPlayerInfo.szKinName
			if (not szKinName or string.len(szKinName) <= 0) then
				szKinName	= "Không gia tộc";
			end
			tbShowInfo.szTxt4 = "Gia tộc: " .. szKinName;
			
			local szTongName			= tbPlayerInfo.szTongName
			if (not szTongName or string.len(szTongName) <= 0) then
				szTongName	= "Không bang hội";
			end
			tbShowInfo.szTxt5 = "Bang hội: " .. szTongName;
			tbShowInfo.szTxt6	= "0";
			tbShowWorldLadder[#tbShowWorldLadder + 1] = tbShowInfo;
		end
	end
	SetShowLadder(nType, szContext, string.len(szContext) + 1, tbShowWorldLadder);
	SetShowLadderName(nType, szLadderName, string.len(szLadderName) + 1);
end

function Ladder:LoadTotalLadder(nType)
	LoadTotalLadder(nType);
end

function Ladder:SaveTotalLadder(nType)
	SaveTotalLadder(nType);
end

function Ladder:UpdateFactionHonorLadder()
	UpdateFactionHonorLadder(); -- 表示是需要保存到数据库中的
end


function Ladder:SetLadder(nType, szContext, nLen, tbLadderList)
	SetLadder(nType, szContext, nLen, tbLadderList);
end

function Ladder:GetType(nLadderType, nClass, nType, nNum3)
	if (nClass == 4 and nType == 3) then -- 因为不能移植联赛排行榜，所以干脆就做特殊处理
		nClass = 3;
	end
	return self:CalculateType(nLadderType, nClass, nType, nNum3);
end

function Ladder:CalculateType(nLadderType, nNum1, nNum2, nNum3)
	nLadderType = KLib.SetByte(nLadderType, 3, nNum1);
	nLadderType = KLib.SetByte(nLadderType, 2, nNum2);
	nLadderType = KLib.SetByte(nLadderType, 1, nNum3);
	return nLadderType;
end

function Ladder:GetClassByType(nLadderType)
	local nClass 		= KLib.GetByte(nLadderType, 3);
	local nType 		= KLib.GetByte(nLadderType, 2);
	local nNum  		= KLib.GetByte(nLadderType, 1);
	local nClassType 	= nLadderType - nClass*2^16 - nType*2^8 - nNum;
	return nClassType, nClass, nType, nNum;
end

function Ladder:WriteDbg(...)
	if (MODULE_GC_SERVER) then
		Dbg:Output("Ladder", unpack(arg));
	end
end

function Ladder:DailySchedule()
	self:LoadLevelLadder();
end

-- 加载门派荣誉排行榜
function Ladder:LoadFacHonor()
	local nType = 0;
	nType = self:GetType(0, self.LADDER_CLASS_WULIN, self.LADDER_TYPE_WULIN_HONOR_FACTION, 0);
	if (0 == LoadHonorLadderData(nType, PlayerHonor.HONOR_CLASS_FACTION, 0)) then
		self:WriteDbg("There is no ladder data, id is ", self.LADDER_CLASS_WULIN, self.LADDER_TYPE_WULIN_HONOR_FACTION, 0);
	end
	if (0 == LoadHonorLadderDataForFaction(nType)) then
		self:WriteDbg("Load faction ladder failed ", self.LADDER_CLASS_WULIN, self.LADDER_TYPE_WULIN_HONOR_FACTION, 0);
	end

end

function Ladder:LoadTotalLadders()
	print("Xếp hạng danh sách");
	local nType			= 0;
	local nMigrateFlag	= 0;
	local nFlag = KGblTask.SCGetDbTaskInt(DBTASD_LADDER_MODIFYOLDLADDER);
	
	-- 0表示还没进行旧数据移植，和更新旧排行榜
	if (2 > nFlag) then
		print("Xếp hạng bắt đầu");
		self:WriteDbg("LoadTotalLadders", "Migrate the Ladder data and the honor ladder");
		KGblTask.SCSetDbTaskInt(DBTASD_LADDER_MODIFYOLDLADDER, 2);
		nMigrateFlag = 1;
	end
	
	self:LoadFacHonor();
	if (1 == nMigrateFlag) then
		PlayerHonor:OnSchemeLoadFactionHonorLadder();
		local nType = self:GetType(0,2,2,0);
		DelShowLadder(nType);
	end

	for nClass, tbInfo in pairs(self.tbLadderConfig) do
		if (tbInfo.nGCStartLoad == 1) then
			self:LoadTotalLadder(tbInfo);
		end
		
		if (tbInfo.nSubLadderLoad == 1) then
			self:LoadSubTotalLadder(tbInfo);
		end
	end
	
	--删除原旧门派榜数据
	if (tonumber(GetLocalDate("%Y%m%d%H")) <= 2009052612) then
		for i=3, 12 do
			local nType = self:GetType(0, self.LADDER_CLASS_LADDER, self.LADDER_TYPE_LADDER_ACTION, i);
			DelShowLadder(nType);
		end
	end
	
	print("Hoàn thành");
	
end

function Ladder:LoadTotalLadder(tbInfo)
	local nType = self:GetType(0, tbInfo.nLadderClass, tbInfo.nLadderType, tbInfo.nLadderSmall);
	if (0 == LoadHonorLadderData(nType, tbInfo.nDataClass, 0, (tbInfo.nNoChangeRank or 0))) then
		self:WriteDbg("There is no ladder, id is ", tbInfo.nLadderClass, tbInfo.nLadderType, tbInfo.nLadderSmall);
	end
end

function Ladder:LoadSubTotalLadder(tbInfo)
	local nType = self:GetType(0, tbInfo.nLadderClass, tbInfo.nLadderType, tbInfo.nLadderSmall);
	if (0 == LoadHonorLadderDataForFaction(nType)) then
		self:WriteDbg("Load faction ladder failed ", tbInfo.nLadderClass, tbInfo.nLadderType, tbInfo.nLadderSmall);
	end
end

function Ladder:RefreshLadderName()
	GlobalExcute{"Ladder:RefreshLadderName"};
end

function Ladder:ClearTotalLadderData(nLadderType,nDataClass, nDataType, bAddNew)
	ClearTotalLadderData(nLadderType,nDataClass, nDataType, bAddNew);
	GlobalExcute({"Ladder:ClearTotalLadderData",nLadderType,nDataClass, nDataType, bAddNew});
end

Ladder:InitLadderConfig();

if (MODULE_GC_SERVER) then
	GCEvent:RegisterGCServerStartFunc(Ladder.LoadTotalLadders, Ladder);
end
