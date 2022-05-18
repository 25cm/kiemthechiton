

Require("\\script\\pvp\\baihutang_def.lua")

local tbChuangTangzeiBoss = Npc:GetClass("chuangtangzeiboss");
tbChuangTangzeiBoss.nNpcId = 2661;
tbChuangTangzeiBoss.tbPos 	= {nX = 50496, nY = 100672};
tbChuangTangzeiBoss.NLASTMAPID = 232;
tbChuangTangzeiBoss.FILE = "\\setting\\npc\\droprate\\baihutang\\"

local tbChuangTangzeiBossAdv = Npc:GetClass("chuangtangzeiboss_adv");
tbChuangTangzeiBossAdv.nNpcId = 30040;
tbChuangTangzeiBossAdv.tbPos = {nX = 50496, nY = 100672};
tbChuangTangzeiBossAdv.NLASTMAPID = 240;
tbChuangTangzeiBossAdv.FILE = "\\setting\\npc\\droprate\\baihutang\\"

local tbChuangTangzeiBossAdv2 = Npc:GetClass("chuangtangzeiboss_adv2");
tbChuangTangzeiBossAdv2.nNpcId = 3684;
tbChuangTangzeiBossAdv2.tbPos = {nX = 50496, nY = 100672};
tbChuangTangzeiBossAdv2.NLASTMAPID = 828;
tbChuangTangzeiBossAdv2.FILE = "\\setting\\npc\\droprate\\baihutang\\"


local tbChuangTangzei = Npc:GetClass("chuangtangzei");

function tbChuangTangzeiBoss:OnDeath(pNpcKiller)
	local szBoss = "";
	local szNote = "";	
	local nMapId = him.nMapId;
	
	local tbPlayer, nCount = KPlayer.GetMapPlayer(nMapId);
	local pPlayerKiller = pNpcKiller.GetPlayer();
	local nOffer = 0;
	local nPrestige = 0;
	local nFloor  = BaiHuTang:GetFloor(nMapId);
	local nStockBaseCount = 0; -- 股份基数
	local nLevel = 0;	
	local szFile = "";
	if (nFloor == 1) then
			pPlayerKiller.AddExp(10000000)
		pPlayerKiller.AddBindMoney(100000);
		pPlayerKiller.AddBindCoin(10000)
		pPlayerKiller.AddJbCoin(20000);
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 1<color> nhận được: <color=yellow>2 vạn đồng thường<color>");
		-----------------------------------------
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color> nhận được <color=gold>2 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color> nhận được <color=gold>2 Vạn Đồng<color>");

		nStockBaseCount = 30; -- 杀死一层boss加30点股份基数	
		nLevel = 1;
		nOffer = 10;
		nPrestige = 2;	
		szBoss = "Thủ Lĩnh Sấm Đường Tặc";
		szNote = "Lối vào Bạch Hổ Đường 2";
		szFile = self.FILE.."boss_1.txt";
	elseif (nFloor == 2) then
		nStockBaseCount = 60; -- 杀死二层boss加60点股份基数			
		nLevel = 2;
		nOffer = 20;
		nPrestige = 3;
		szBoss = "Thủ Lĩnh Thiết Đồ Tặc";
		szNote	= "Lối vào Bạch Hổ Đường 3";
		szFile = self.FILE.."boss_2.txt";
	elseif (nFloor == 3) then
		nStockBaseCount = 100; -- 杀死三层boss加100点股份基数		
		nLevel = 3;
		nOffer = 30;
		nPrestige = 4;
		szBoss = "Hộ Đồ Sứ";
		szNote	= "Lối ra Bạch Hổ Đường";
		szFile = self.FILE.."boss_3.txt";
	end
	
	local nRate = 1;
	if TimeFrame:GetStateGS("OpenOneAdvBaiHuTang") == 1 then
		nPrestige = math.floor(nPrestige / 2);
		nRate = 0.5
	end

	if (nMapId == 236) then
		local pNpc = KNpc.Add2(2525, 1, -1, nMapId, 1628, 3104);  -- 点起一束光
		pNpc.szName	= szNote;
		BaiHuTang.tbIsOpen[nMapId] = 1;
	end	
	
	if not pPlayerKiller then
		return 0;
	end
	
	local nTeamCount = 0;	
	local nTeamId = pPlayerKiller.nTeamId;
	if (nCount > 0 and pPlayerKiller) then
		local szMsg = "";
		if (nMapId == 236) then --最后一层
			szMsg = "Lối ra Bạch Hổ Đường 2 đã mở!";
		end
		szMsg = "["..pNpcKiller.szName .. "] đã giết chết " ..szBoss .. ", " .. szMsg;
		KDialog.Msg2PlayerList(tbPlayer, szMsg, "Hệ thống nhắc nhở");
		
		pPlayerKiller.SendMsgToFriend("Hảo hữu của bạn [".. pPlayerKiller.szName.."] đã giết chết Bạch Hổ Đường - " ..szBoss..".");
		Player:SendMsgToKinOrTong(pPlayerKiller, " đã giết chết Bạch Hổ Đường - " ..szBoss..".", 0);
		
		if nTeamId == 0 then -- 如果没队
			pPlayerKiller.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
			pPlayerKiller.AddKinReputeEntry(nPrestige, "baihutang");
			Tong:AddStockBaseCount_GS1(pPlayerKiller.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	
		end
		for _, pMapPlayer in ipairs(tbPlayer) do
			if (pMapPlayer.nTeamId ~= 0) then
				local nFavor = 10;
				if (nTeamId == pMapPlayer.nTeamId) then -- 如果是杀死boss的队伍
					nFavor = 15;
					pMapPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
					pMapPlayer.AddKinReputeEntry(nPrestige, "baihutang");
					Tong:AddStockBaseCount_GS1(pMapPlayer.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 加股份
					nTeamCount = nTeamCount + 1; -- 统计在场人数
				end
				BaiHuTang:AddFriendFavor(pMapPlayer, tbPlayer, nFavor);
			end	
			
		end
	end
	if nTeamId ~= 0 and BaiHuTang.HONOR[nLevel] and BaiHuTang.HONOR[nLevel][nTeamCount] then
		local tbMember = KTeam.GetTeamMemberList(nTeamId);
		PlayerHonor:AddPlayerHonorById_GS(tbMember[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, BaiHuTang.HONOR[nLevel][nTeamCount] * nRate);
	end
	
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Bạch Hổ Đường", pNpcKiller.szName .." đã giết chết "..szBoss);	--记录是谁杀死的
	
	--Kin:AddKinKillBaiHuTangCount(pPlayerKiller.nId, 1);
	
	local nIndx = SubWorldID2Idx(nMapId);
	if nIndx < 0 then
		assert(false);
		return;
	end

	if (nMapId == tbChuangTangzeiBoss.NLASTMAPID)then --初级最后一个场
		pPlayerKiller.Msg("Chúc mừng bạn đã chinh phục Bạch Hổ Đường thành công!");
	end

	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local pNpc = KNpc.Add2(30048, 1, 0, nNpcMapId,nNpcPosX,nNpcPosY)
	for i = 1, BaiHuTang.nTimes - 1 do 		
		pPlayerKiller.DropRateItem(szFile,24,pPlayerKiller.nCurLucky, -1, him);
	end	
end

function tbChuangTangzeiBossAdv:OnDeath(pNpcKiller)
	local szBoss ="";
	local szNote	 = "";	
	local pPlayerKiller = pNpcKiller.GetPlayer();
	local nMapId = him.nMapId;
	local tbPlayer, nCount = KPlayer.GetMapPlayer(nMapId);
	local nOffer = 0;
	local nPrestige = 0;
	local nFloor = BaiHuTang:GetFloor(nMapId);
	local nStockBaseCount = 0; -- 股份基数
	local nLevel = 0;	
	local szFile = "";
	if (nFloor == 1) then
		pPlayerKiller.AddExp(10000000)
		pPlayerKiller.AddBindMoney(100000);
		pPlayerKiller.AddBindCoin(10000)
		pPlayerKiller.AddJbCoin(20000);
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 1<color> nhận được: <color=yellow>2 vạn đồng thường<color>");
		-----------------------------------------
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color> nhận được <color=gold>2 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color> nhận được <color=gold>2 Vạn Đồng<color>");

		---------------------------------------------
		nStockBaseCount = 30; -- 杀死一层boss加10点股份基数
		nLevel = 1;
		nOffer = 10;
		nPrestige = 2;
		szBoss = "Thủ Lĩnh Sấm Đường Tặc";
		szNote = "Lối vào Bạch Hổ Đường 2";
		szFile = self.FILE.."boss_4.txt";
	elseif (nFloor == 2) then
		pPlayerKiller.AddJbCoin(40000);
		pPlayerKiller.AddExp(15000000)
		pPlayerKiller.AddBindMoney(200000);
		pPlayerKiller.AddBindCoin(20000)
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 2<color> nhận được: <color=yellow>4 vạn đồng thường<color>");
		----------------------
			GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 2<color> nhận được <color=gold>4 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 2<color> nhận được <color=gold>4 Vạn Đồng<color>");
	-------------------------------------
		nStockBaseCount = 60; -- 杀死二层boss加20点股份基数
		nLevel = 2;
		nOffer = 20;
		nPrestige = 3;
		szBoss = "Thủ Lĩnh Thiết Đồ Tặc";
		szNote	= "Lối vào Bạch Hổ Đường 3";
		szFile = self.FILE.."boss_5.txt";
	elseif (nFloor == 3) then
		pPlayerKiller.AddJbCoin(60000);
		pPlayerKiller.AddExp(2000000)
		pPlayerKiller.AddBindMoney(300000);
		pPlayerKiller.AddBindCoin(30000)			
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 3<color> nhận được: <color=yellow>6 vạn đồng thường<color>");
		----------------------------------------------
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 3<color> nhận được <color=gold>6 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 3<color> nhận được <color=gold>6 Vạn Đồng<color>");
	------------------------------------------------------	
		nStockBaseCount = 100; -- 杀死三层boss加30点股份基数
		nLevel = 3;
		nOffer = 30;
		nPrestige = 4;
		szBoss = "Hộ Đồ Sứ";
		szNote	= "Lối ra Bạch Hổ Đường";
		szFile = self.FILE.."boss_6.txt";
	end

	if (nMapId ~= BaiHuTang.GaoJi) then
		local pNpc	= KNpc.Add2(2525, 1, -1, nMapId, 1628, 3104);  -- 点起一束光
		pNpc.szName	= szNote;
		BaiHuTang.tbIsOpen[nMapId] = 1;
	end

	if not pPlayerKiller then
		return 0;
	end
	
	local nTeamCount = 0;
	local nTeamId = pPlayerKiller.nTeamId;
	if (nCount > 0 and pPlayerKiller) then
		local szMsg = "";
		if (nMapId == tbChuangTangzeiBossAdv.NLASTMAPID) then --最后一层
			szMsg = "Lối ra Bạch Hổ Đường đã mở!";
		else
			szMsg = "Lối vào tầng 1 đã mở!";
		end
		szMsg = "["..pNpcKiller.szName .. "] đã giết chết " ..szBoss ..", " .. szMsg;
		KDialog.Msg2PlayerList(tbPlayer, szMsg, "Hệ thống nhắc nhở");
		
		pPlayerKiller.SendMsgToFriend("Hảo hữu của bạn [".. pPlayerKiller.szName.."] đã giết chết Bạch Hổ Đường - " ..szBoss..".");
		Player:SendMsgToKinOrTong(pPlayerKiller, " đã giết chết Bạch Hổ Đường - " ..szBoss..".", 0);
		if nTeamId == 0 then -- 如果没队
			pPlayerKiller.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
			pPlayerKiller.AddKinReputeEntry(nPrestige, "baihutang");	
			Tong:AddStockBaseCount_GS1(pPlayerKiller.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);
		end
		for _, pMapPlayer in ipairs(tbPlayer) do
			if (pMapPlayer.nTeamId ~= 0) then
				local nFavor = 10;
				if (nTeamId == pMapPlayer.nTeamId) then -- 如果是杀死boss的队伍
					nFavor = 15;
					pMapPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
					pMapPlayer.AddKinReputeEntry(nPrestige, "baihutang");
					Tong:AddStockBaseCount_GS1(pMapPlayer.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 加股份
					nTeamCount = nTeamCount + 1; -- 统计在场人数
				end
				BaiHuTang:AddFriendFavor(pMapPlayer, tbPlayer, nFavor);
			end			
		end
	end
	if nTeamId ~= 0 and BaiHuTang.HONOR[nLevel] and BaiHuTang.HONOR[nLevel][nTeamCount] then
		local tbMember = KTeam.GetTeamMemberList(nTeamId);
		PlayerHonor:AddPlayerHonorById_GS(tbMember[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, BaiHuTang.HONOR[nLevel][nTeamCount]);
	end
	
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Bạch Hổ Đường", pNpcKiller.szName .." đã giết chết "..szBoss);	--记录是谁杀死的
	
	--Kin:AddKinKillBaiHuTangCount(pPlayerKiller.nId, 1);
	
	local nIndx = SubWorldID2Idx(nMapId);
	if nIndx < 0 then
		assert(false);
		return;
	end

	if (pPlayerKiller.nMapId == tbChuangTangzeiBossAdv.NLASTMAPID)then --高级最后一场
		BaiHuTang:BroadcastMsg(6, BaiHuTang.GaoJi);
	end
	
	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
	for i = 1, BaiHuTang.nTimes - 1 do 
		pPlayerKiller.DropRateItem(szFile,24,pPlayerKiller.nCurLucky, -1, him);
	end	
end


function tbChuangTangzeiBossAdv2:OnDeath(pNpcKiller)
	local szBoss ="";
	local szNote	 = "";	
	local pPlayerKiller = pNpcKiller.GetPlayer();
	local nMapId = him.nMapId;
	local tbPlayer, nCount = KPlayer.GetMapPlayer(nMapId);
	local nOffer = 0;
	local nPrestige = 0;
	local nFloor = BaiHuTang:GetFloor(nMapId);
	local nStockBaseCount = 0; -- 股份基数
	local nLevel = 0;	
	local szFile = "";
	if (nFloor == 1) then
		nStockBaseCount = 30; -- 杀死一层boss加10点股份基数
		nLevel = 1;
		nOffer = 10;
		nPrestige = 2;
		szBoss = "Thủ Lĩnh Sấm Đường Tặc";
		szNote = "Lối vào Bạch Hổ Đường 2";
		szFile = self.FILE.."boss_7.txt";
		pPlayerKiller.AddStackItem(18,1,1331,2,nil,1);
		    pPlayerKiller.AddExp(10000000)
		pPlayerKiller.AddBindMoney(100000);
		pPlayerKiller.AddBindCoin(10000)
		pPlayerKiller.AddJbCoin(20000);
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 1<color> nhận được: <color=yellow>2 vạn đồng thường<color>");
		KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color> nhận được nhiều phần thưởng giá trị!");
		
	elseif (nFloor == 2) then
		nStockBaseCount = 60; -- 杀死二层boss加20点股份基数
		nLevel = 2;
		nOffer = 20;
		nPrestige = 3;
		szBoss = "Thủ Lĩnh Thiết Đồ Tặc";
		szNote	= "Lối vào Bạch Hổ Đường 3";
		szFile = self.FILE.."boss_8.txt";
						pPlayerKiller.AddJbCoin(40000);
						pPlayerKiller.AddStackItem(18,1,1331,2,nil,3);
		pPlayerKiller.AddExp(15000000)
		pPlayerKiller.AddBindMoney(200000);
		pPlayerKiller.AddBindCoin(20000)
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 2<color> nhận được: <color=yellow>4 vạn đồng thường<color>");
		KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 2<color> nhận được nhiều phần thưởng giá trị!");
		nStockBaseCount = 60; -- 杀死二层boss加20点股份基数
	elseif (nFloor == 3) then
		nStockBaseCount = 100; -- 杀死三层boss加30点股份基数
		nLevel = 3;
		nOffer = 30;
		nPrestige = 4;
		szBoss = "Hộ Đồ Sứ";
		szNote	= "Lối ra Bạch Hổ Đường";
		szFile = self.FILE.."boss_9.txt";
						pPlayerKiller.AddJbCoin(60000);
		pPlayerKiller.AddExp(2000000)
		pPlayerKiller.AddStackItem(18,1,1331,3,nil,1);
		pPlayerKiller.AddBindMoney(300000);
		pPlayerKiller.AddBindCoin(30000)			
		pPlayerKiller.Msg("Bạn đã tiêu diệt <color=blue>Boss Bạch Hổ Đường Tầng 3<color> nhận được: <color=yellow>6 vạn đồng thường<color>");
		KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..pPlayerKiller.szName.."<color> đã kết liễu <color=red>Thủ Lĩnh Bạch Hổ Đường Tầng 3<color> nhận được nhiều phần thưởng giá trị!");
		nStockBaseCount = 100; -- 杀死三层boss加30点股份基数
	end

	if (nMapId ~= BaiHuTang.Goldlen) then
		local pNpc	= KNpc.Add2(2525, 1, -1, nMapId, 1628, 3104);  -- 点起一束光
		pNpc.szName	= szNote;
		BaiHuTang.tbIsOpen[nMapId] = 1;
	end

	if not pPlayerKiller then
		return 0;
	end
	
	local nTeamCount = 0;
	local nTeamId = pPlayerKiller.nTeamId;
	if (nCount > 0 and pPlayerKiller) then
		local szMsg = "";
		if (nMapId == self.NLASTMAPID) then --最后一层
			szMsg = "lối ra Bạch Hổ Đường đã mở!";
		else
			szMsg = "lối vào tầng tiếp theo đã mở!";
		end
		szMsg = "["..pNpcKiller.szName .. "] đã giết chết " ..szBoss ..", " .. szMsg;
		KDialog.Msg2PlayerList(tbPlayer, szMsg, "Hệ thống nhắc nhở");
		
		pPlayerKiller.SendMsgToFriend("Hảo hữu của bạn [".. pPlayerKiller.szName.."] đã giết chết Bạch Hổ Đường - " ..szBoss..".");
		Player:SendMsgToKinOrTong(pPlayerKiller, " đã giết chết Bạch Hổ Đường - " ..szBoss..".", 0);
		
		if nTeamId == 0 then -- 如果没队
			pPlayerKiller.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
			pPlayerKiller.AddKinReputeEntry(nPrestige, "baihutang");	
			Tong:AddStockBaseCount_GS1(pPlayerKiller.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);
		end
		for _, pMapPlayer in ipairs(tbPlayer) do
			if (pMapPlayer.nTeamId ~= 0) then
				local nFavor = 10;
				if (nTeamId == pMapPlayer.nTeamId) then -- 如果是杀死boss的队伍
					nFavor = 15;
					pMapPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
					pMapPlayer.AddKinReputeEntry(nPrestige, "baihutang");
					Tong:AddStockBaseCount_GS1(pMapPlayer.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 加股份
					nTeamCount = nTeamCount + 1; -- 统计在场人数
				end
				BaiHuTang:AddFriendFavor(pMapPlayer, tbPlayer, nFavor);
			end			
		end
	end
	if nTeamId ~= 0 and BaiHuTang.HONOR[nLevel] and BaiHuTang.HONOR[nLevel][nTeamCount] then
		local tbMember = KTeam.GetTeamMemberList(nTeamId);
		PlayerHonor:AddPlayerHonorById_GS(tbMember[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, BaiHuTang.HONOR[nLevel][nTeamCount]);
	end
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Bạch Hổ Đường", pNpcKiller.szName .." đã giết chết "..szBoss);	--记录是谁杀死的
	
	--Kin:AddKinKillBaiHuTangCount(pPlayerKiller.nId, 1);
	
	local nIndx = SubWorldID2Idx(nMapId);
	if nIndx < 0 then
		assert(false);
		return;
	end

	if (pPlayerKiller.nMapId == self.NLASTMAPID)then --高级最后一场
		BaiHuTang:BroadcastMsg(6, BaiHuTang.Goldlen);
	end
	
	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
	for i = 1, BaiHuTang.nTimes - 1 do 
		pPlayerKiller.DropRateItem(szFile,24,pPlayerKiller.nCurLucky, -1, him);
	end	
	
	if nFloor == 3 then	--向大区gc申请开启传送门
		local nUnionId = pPlayerKiller.dwUnionId;
		local nTongId = pPlayerKiller.dwTongId;
		BaiHuTang.nKillBossCamp = (nUnionId ~= 0 and nUnionId ) or nTongId;	
		local nKillBossCampRiches , nCount = self:GetKillerCampRiches();
		if nKillBossCampRiches >= BaiHuTang.BASIC_TRANS_RICHES_GOLDEN and nCount >= BaiHuTang.BASIC_COUNT_TRANSFER then
			GCExcute{"BaiHuTang:ApplyGB_GCState",BaiHuTang.Goldlen};	--通过本区gc执行向大区gc发送请求
		end	
	end
end

function tbChuangTangzeiBossAdv2:GetKillerCampRiches()	--计算杀死第三层boss后当前地图内该帮会的财富总和
	local tbPlayer,nCount = KPlayer.GetMapPlayer(self.NLASTMAPID);
	local nRiches = 0;
	local nPlayerCount = 0;
	for i,pPlayer in pairs(tbPlayer) do
		table.insert(BaiHuTang.tbPlayerInBossDeathMap,pPlayer.nId);--记录杀死boss时候3层内的玩家
		local nCampId = (pPlayer.dwUnionId ~= 0 and pPlayer.dwUnionId) or pPlayer.dwTongId;
		if nCampId == BaiHuTang.nKillBossCamp then
			local nTemp = GetPlayerHonor(pPlayer.nId,PlayerHonor.HONOR_CLASS_MONEY,0) or 0;
			nRiches = nRiches + nTemp;
			nPlayerCount = nPlayerCount + 1;
		end	
	end
	return nRiches,nPlayerCount;
end

function tbChuangTangzei:OnDeath(pNpcKiller)
	local pPlayer = pNpcKiller.GetPlayer();
	local nMapId = him.nMapId;
	local nFloor = BaiHuTang:GetFloor(nMapId);
	Merchant:TryGiveToken_Baihu(pPlayer, nFloor);
end
