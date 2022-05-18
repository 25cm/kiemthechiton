
-- 百年天牢的第一个 BOSS，杀死他可以获得进入密室的钥匙

local tbNpc_1	= Npc:GetClass("bainiantianlao_boss1");

function tbNpc_1:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nBoss				= 1;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
	    pPlayer.AddStackItem(18,1,5001,51,tbItemInfo,10);
		pPlayer.AddStackItem(18,1,5002,52,tbItemInfo,10);
			--KNpc.Add2(2597, 1, -1, nMapId, 1653, 3223);
			pPlayer.Msg("Ban da tieu tiet Boss nhan duoc: <color=yellow>10 Ruong MG + 10 Ruong VP<color>");
		pPlayer.DropRateItem(TreasureMap.szBossDropPath_1, 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end
end;



local tbNpc_2	= Npc:GetClass("bainiantianlao_boss2");

function tbNpc_2:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
		KNpc.Add2(2597, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		    pPlayer.AddStackItem(18,1,5001,51,tbItemInfo,15);
		pPlayer.AddStackItem(18,1,5002,52,tbItemInfo,15);
		pPlayer.AddStackItem(18,1,1331,2,nil,2);
			--KNpc.Add2(2597, 1, -1, nMapId, 1653, 3223);
				pPlayer.AddJbCoin(100000);--5v ??ng khóa
				pPlayer.AddExp(10000000);
		pPlayer.AddBindMoney(300000);
		pPlayer.AddBindCoin(50000);--5v ??ng khóa
		pPlayer.Msg("Ban da tieu tiet <color=green>Boss cuoi<color> nhan duoc: <color=yellow>10 van dong thuong<color>");
	-----------------------------------
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Ng??i choi <color=green>"..pPlayer.szName.."<color> tieu diet Boss Tang Ban Do <color=red>Bach Nien Thien Lao<color> nhan duoc <color=yellow>10 Van Dong<color>"});
		KDialog.MsgToGlobal("Ng??i choi <color=green>"..pPlayer.szName.."<color> tieu diet Boss Tang Ban Do <color=gold>Bach Nien Thien Lao<color> nhan duoc <color=yellow>10 Van Dong<color>");
------------------------------------------------------------
		pPlayer.DropRateItem(TreasureMap.szBossDropPath_1, 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
				
		-- 添加亲密度
		local tbTeamList = pPlayer.GetTeamMemberList();
		TreasureMap:AddFriendFavor(tbTeamList, pPlayer.nMapId, 50);
		
		-- 成就：完成初级副本百年天牢
		TreasureMap:GetAchievement(tbTeamList, Achievement.FUBEN_BAINIANTIANLAO, pPlayer.nMapId);
	end
	
	--掉落篝火
end;
