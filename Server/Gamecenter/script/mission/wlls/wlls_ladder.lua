-- 文件名　：wlls_ladder.lua 联赛排行榜文件
-- 创建者　：zhouchenfei
-- 创建时间：2008-10-16 15:07:15

Require("\\script\\ladder\\define.lua")

Wlls.LADDER_CLASS				= Ladder.LADDER_CLASS_WLLS;
Wlls.LADDER_TYPE_CUR_PRIMAY		= Ladder.LADDER_TYPE_WLLS_CUR_PRIMAY	-- 当届联赛初级榜
Wlls.LADDER_TYPE_CUR_ADV 		= Ladder.LADDER_TYPE_WLLS_CUR_ADV 		-- 当届联赛高级榜
Wlls.LADDER_TYPE_HONOR			= Ladder.LADDER_TYPE_WLLS_HONOR			-- 荣誉榜
Wlls.LADDER_TYPE_LAST_PRIMAY	= Ladder.LADDER_TYPE_WLLS_LAST_PRIMAY	-- 上届联赛初级榜
Wlls.LADDER_TYPE_LAST_PRIMAY	= Ladder.LADDER_TYPE_WLLS_LAST_PRIMAY	-- 上届联赛高级榜

Wlls.LADDER_FACTIONNAME = {
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

if (MODULE_GC_SERVER) then
-- 更新联赛荣誉榜
function Wlls:UpdateWllsHonorLadder()
	print("Xếp hạng Liên Đấu bắt đầu");
	local nType = 0;
	local tbLadderCfg = Ladder.tbLadderConfig[PlayerHonor.HONOR_CLASS_WLLS];
	nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
	UpdateTotalLadder(nType, tbLadderCfg.nDataClass, 0);	

	local tbShowLadder	= GetTotalLadderPart(nType, 1, 10);
	local szContext		= string.format("%s danh vọng Liên Đấu (Cập nhật sau khi kết thúc)", self.LADDER_FACTIONNAME[0]);
	local szLadderName	= string.format("%s danh vọng Liên Đấu", self.LADDER_FACTIONNAME[0]);
	PlayerHonor:SetShowLadder(tbShowLadder, nType, szLadderName, szContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);

	UpdateLadderDataForFaction(nType, 1);
	-- 分榜
	for i=1, 12 do
		local tbSubShow = GetTotalLadderPart(nType + i, 1, 10);
		local szSubContext	= string.format("%s danh vọng Liên Đấu (Cập nhật sau khi kết thúc)", self.LADDER_FACTIONNAME[i]);
		local szLadderName	= string.format("%s danh vọng Liên Đấu", self.LADDER_FACTIONNAME[i]);
		PlayerHonor:SetShowLadder(tbSubShow, nType + i, szLadderName, szSubContext, tbLadderCfg.szPlayerContext, tbLadderCfg.szPlayerSimpleInfo);
	end
	
	PlayerHonor:GetHonorStatInfo(PlayerHonor.HONOR_CLASS_WLLS, 100, "wllshonor", "Wlls");
	print("Xếp hạng Liên Đấu kết thúc");
end

function Wlls:GetType(nType, nNum1, nNum2, nNum3)
	nType = KLib.SetByte(nType, 3, nNum1);
	nType = KLib.SetByte(nType, 2, nNum2);
	nType = KLib.SetByte(nType, 1, nNum3);
	return nType;
end

end -- end MODULE_GC_SERVER


if (MODULE_GAMESERVER) then
	
end
