-----------------------------------------------------
--文件名		：	baomingdianjunxuguan.lua
--创建者		：	zhouchenfei
--创建时间		：	2007-10-23
--功能描述		：	报名点军需官
------------------------------------------------------

local tbBaoJunXu	= Npc:GetClass("baomingdianjunxuguan");
tbBaoJunXu.TBFACTIONEQUIP = 
{
	{--初级战场，扬州战场
		[1] = 49, -- 少林
		[2] = 50, --天王掌门
		[3] = 51, --唐门掌门
		[4] = 53, --五毒掌门
		[5] = 55, --峨嵋掌门
		[6] = 56, --翠烟掌门
		[7] = 58, --丐帮掌门
		[8] = 57, --天忍掌门
		[9] = 59, --武当掌门
		[10] = 60, --昆仑掌门
		[11] = 52, --明教掌门
		[12] = 54, --大理段氏掌门
	},
	{--中级战场，凤翔战场
		[1] = 61, -- 少林
		[2] = 62, --天王掌门
		[3] = 63, --唐门掌门
		[4] = 65, --五毒掌门
		[5] = 67, --峨嵋掌门
		[6] = 68, --翠烟掌门
		[7] = 70, --丐帮掌门
		[8] = 69, --天忍掌门
		[9] = 71, --武当掌门
		[10] = 72, --昆仑掌门
		[11] = 64, --明教掌门
		[12] = 66, --大理段氏掌门
	},
};

-- NPC对话
function tbBaoJunXu:OnDialog(szCamp)
	if (Battle.LEVEL_LIMIT[1] > me.nLevel) then
		return;
	end
	local pPlayer		= me;
	self.nCampId		= Battle.tbNPCNAMETOID[szCamp];
	self.tbDialog		= Battle.tbCampDialog[self.nCampId];

	if (0 == self:CheckSameCamp()) then
		Dialog:Say(self.tbDialog[7]);
		return;
	end
	
	--根据地图获得军需官属于战场级别
	local nNowBattleLevel = 0;
	for nBattleLevel, tbMapSeq in ipairs(Battle.MAPID_LEVEL_CAMP) do
		for nBtSeq, tbMap in ipairs(tbMapSeq) do
			for nMapNum, nMapId in pairs(tbMap) do
				if nMapId == pPlayer.nMapId then
					nNowBattleLevel = nBattleLevel;
					break;
				end
			end
			if nNowBattleLevel ~= 0 then
				break;
			end
		end
		if nNowBattleLevel ~= 0 then
			break;
		end
	end
	
	
	
--	local nBouns		= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	local szExMsg		= "Ngoài ra, bạn có thể mua các đạo cụ chiến trường và thiết bị chiến trường đặc biệt từ tôi."; -- ，用战场điểm换取经验。你目前的战场điểm为：<color=green>%d<color>。";
	local szMsg			= self.tbDialog[6] .. szExMsg;
	local tbOpt			= {
	--	{"我要购买战场道具", self.OnBuyDaoJu, self},
		{"<color=gold>[Bạc Khóa]<color>Ta muốn mua thuốc", self.OnBuyYaoByBind, self},
		{"Ta muốn mua thuốc", self.OnBuyYao, self},
		{"<color=gold>[Bạc Khóa]<color>Ta muốn mua thực phẩm", self.OnBuyCaiByBind, self},
		{"Ta muốn mua thực phẩm", self.OnBuyCai, self},
	--	{"我要购买战场特殊装备(暂时不能用)", self.OnBuyZhuangBei, self},
	--	{"我要用战场điểm换取经验", self.OnExchange, self},
		{"Ta muốn nhận quân nhu", self.OnGetJunXuMed, self},
	--	{"我要查看功勋排行榜", self.OnSearchGongRank, self},
		{"Kết thúc đối thoại"},
	};
	
	if nNowBattleLevel == 1 then
		local tbOpenShop = {"Ta muốn mua trang bị chiến trường Dương Châu", self.OnBuyBattleEquip, self, nNowBattleLevel};
		table.insert(tbOpt,3,tbOpenShop);
	elseif nNowBattleLevel == 2 then
		local tbOpenShop = {"Ta muốn mua trang bị chiến trường Phượng Tường", self.OnBuyBattleEquip, self, nNowBattleLevel};
		table.insert(tbOpt,3,tbOpenShop);		
	end	
	
	Dialog:Say(szMsg, tbOpt);
end

function tbBaoJunXu:OnGetJunXuMed()
	local nJunXuDian	= me.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_JUNXU);
	if (0 >= nJunXuDian) then
		Dialog:Say("Hôm nay bạn đã nhận được tất cả bom, đạn, hãy tiêu diệt kẻ thù càng sớm càng tốt!");
		return;
	end
	
	local nBTLevel		= Battle:GetJoinLevel(me);
	local szMsg			= string.format("Hôm nay, bạn cũng có thể nhận được tổng số% d rương thuốc quân dụng từ tôi. Bạn có thể chọn bất kỳ loại tủ thuốc nào, và các loại thuốc chỉ có thể được sử dụng trong chiến trường. Bạn có chắc chắn muốn nhận nó ngay bây giờ không?", nJunXuDian);
	local tbOpt			= {
			{"Hồi Huyết Đơn", self.OnChooseMed, self, Battle.tbBattleItem_Medicine[nBTLevel][1], nJunXuDian },
			{"Hội Nội Đơn", self.OnChooseMed, self, Battle.tbBattleItem_Medicine[nBTLevel][2], nJunXuDian },
			{"Càn Khôn Tạo Hóa Hoàn", self.OnChooseMed, self, Battle.tbBattleItem_Medicine[nBTLevel][3], nJunXuDian },
			{"Ta sẽ nhận sau"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbBaoJunXu:OnSearchGongRank()
	local pPlayer = me;
	local tbPlayerInfo 	= Battle:GetPlayerRankInfo(pPlayer);
	local szMsg			= "";
	if (not tbPlayerInfo) then
		szMsg 	= "Bây giờ bạn không có trên bảng xếp hạng!";
	else
		szMsg	= string.format("%s，Điểm Tống Kim：<color=yellow>%d<color>，Bảng Xếp Hạng：<color=green>%d<color>", pPlayer.szName, tbPlayerInfo.nGongXun, tbPlayerInfo.nRank);	
	end
	Dialog:Say(szMsg);
end

function tbBaoJunXu:OnChooseMed(nItemNumber, nJunXuDian)
	local pPlayer = me;
	local nJunXuDian	= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_JUNXU);
	if (0 >= nJunXuDian) then
		return;
	end
	local pItem = pPlayer.AddItemEx(18, 1, nItemNumber, 1, {bTimeOut = 1});
	if not pItem then
		return;
	end
	pItem.SetGenInfo(1, pItem.GetExtParam(6));
	pPlayer.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/%S", GetTime() + Battle.BTPLJUNXUTIMEOUT));
	pItem.Sync();
	nJunXuDian = nJunXuDian - 1;
	pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_JUNXU, nJunXuDian);
end

-- 检查是否同一阵营
function tbBaoJunXu:CheckSameCamp()
	local pPlayer = me;
	local nMyCamp = pPlayer.GetTask(Battle.TSKGID, Battle.TASKID_BTCAMP);
	if ((0 == nMyCamp) or (nMyCamp == self.nCampId)) then
		return 1;
	end

	local tbMapInfo 	= Battle:GetMapInfo(him.nMapId);
	local nMyBattleKey	= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_KEY);
	if ((tbMapInfo.tbMission) and (tbMapInfo.tbMission.nBattleKey == nMyBattleKey)) then
		return 0;
	end
	return 1;
end

-- 获取战场信息
function tbBaoJunXu:GetBattleState()
	local tbMapInfo 	= Battle:GetMapInfo(him.nMapId);
	if (tbMapInfo.tbMission) then
		local nState = tbMapInfo.tbMission.nState;
		return nState;
	end
	return 0;
end

-- 买卖
function tbBaoJunXu:OnBuyZhuangBei()
--	me.OpenShop(23,4);
end

function tbBaoJunXu:OnBuyBattleEquip(nBattleLevel)
	local nFaction = me.nFaction;
	if nFaction <= 0 or me.GetCamp() == 0 then
		Dialog:Say("Người chơi chưa gia nhập môn phái không thể mua thiết bị chiến trường Tống Kim");
		return 0;
	end	
	me.OpenShop(self.TBFACTIONEQUIP[nBattleLevel][nFaction], 1, 100, me.nSeries)
	
end

function tbBaoJunXu:OnBuyDaoJu()
--	me.OpenShop(14,1);
	me.OpenShop(23,4);
end

function tbBaoJunXu:OnBuyYaoByBind()
	me.OpenShop(14,7);
end

function tbBaoJunXu:OnBuyYao()
	me.OpenShop(14,1);
end

-- 买菜
function tbBaoJunXu:OnBuyCai()
	me.OpenShop(21,1);
end

function tbBaoJunXu:OnBuyCaiByBind()
	me.OpenShop(21,7);
end

-- điểm换经验
function tbBaoJunXu:OnExchange()
	local nBattleState	= self:GetBattleState();	
	if ( 2 == nBattleState ) then
		Dialog:Say("Trận chiến hiện tại đang diễn ra, bạn nên đợi đến khi trận chiến kết thúc rồi mới có thể đổi lấy kinh nghiệm.！");
		return;
	end	
	
	local nMyRemainBouns	= me.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	if (0 >= nMyRemainBouns ) then
		Dialog:Say("Điểm của bạn <color=green>0<color>!");
		return 0;
	end
	
	local szMsg		= "Ngươi muốn đổi bao nhiêu？";
	local tbOpt		= 	{
							{"500điểm", self.OnChangeBouns, self, 500},
							{"1000điểm", self.OnChangeBouns, self, 1000},
							{"2000điểm", self.OnChangeBouns, self, 2000},
							{"5000điểm", self.OnChangeBouns, self, 5000},
							{"10000điểm", self.OnChangeBouns, self, 10000},
							{"Tất cả", self.OnChangeBouns, self, nMyRemainBouns},
							{"Kết thúc đối thoại"},
						};
	Dialog:Say(szMsg, tbOpt);
	-- điểm减少后还得更新数据
end

-- điểm换经验
function tbBaoJunXu:OnChangeBouns(nChangeBouns)
	if (0 == self:CheckBouns(nChangeBouns)) then
		return;
	end
	local nLevel	= me.nLevel;
	local nExp		= Battle:BounsChangeExp(nLevel, nChangeBouns);
	Battle:DbgWrite(Dbg.LOG_INFO, "tbBaoJunXu:OnChangeBouns", me.szName, nLevel, nChangeBouns, nExp);
	local szMsg		= string.format("Bạn hiện đang sử dụng <color = red>% d <color> point cho trải nghiệm <color = green>% d <color>, bạn có chắc không?", nChangeBouns, nExp);
	local tbOpt		= 	{
							{"OK", self.OnChangeBounsSuc, self, nChangeBouns, nExp},
							{"Để xem lại."},
						};
	Dialog:Say(szMsg, tbOpt);
end

-- 成功换取经验
function tbBaoJunXu:OnChangeBounsSuc(nChangeBouns, nExp)
	local pPlayer = me;
	if (0 == self:CheckBouns(nChangeBouns)) then
		return;
	end

	local nMyRemainBouns	= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	local nMyUserBouns		= Battle:GetMyUseBouns();
	Battle:AddUseBouns(me, nChangeBouns, nMyUserBouns);
	pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS, nMyRemainBouns - nChangeBouns);
	pPlayer.AddExp(nExp);
end

function tbBaoJunXu:CheckBouns(nChangeBouns)
	local nMyRemainBouns	= me.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	local nMyUserBouns		= Battle:GetMyUseBouns();
	if (nMyRemainBouns < nChangeBouns) then
		Dialog:Say(string.format("Điểm hiện tại của bạn chỉ có <color = red>% d <color>, và không thể đổi lấy <color = yellow>% d <color>điểm！", nMyRemainBouns, nChangeBouns));
		return 0;
	end

	if ((nMyUserBouns + nChangeBouns) > Battle.BATTLES_POINT2EXP_MAXEXP) then
		Dialog:Say(string.format("Điểm chiến trường được sử dụng để đổi điểm kinh nghiệm mỗi tuần tối đa là <color = red>% d <color>. Bạn đã vượt quá giới hạn trên và không thể đổi được.！", Battle.BATTLES_POINT2EXP_MAXEXP));
		return 0;
	end
	
	return 1;
end

