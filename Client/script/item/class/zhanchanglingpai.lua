local tbItem = Item:GetClass("zhanchanglingpai")

function tbItem:OnUse()
	local pPlayer		= me;
--	local nLimit 		= 4000;
	local nShengWang	= 40;
	local nLevel 		= it.nLevel;
	local szSeries		= Env.SERIES_NAME[pPlayer.nSeries];
	
	if (nLevel == 2) then	-- 凤翔战场声望为100
		nShengWang = 100;
	end

	local nValue		= pPlayer.GetWeekRepute(2,nLevel);
--	if (nLimit <= nValue) then
--		pPlayer.Msg("您本周获得的战场声望已达上限，不能使用战场令牌！");
--		return;
--	end	
	-- zhengyuhua:庆公测活动临时内容
	local nBufLevel = me.GetSkillState(881)
	if nBufLevel > 0 then
		nShengWang = nShengWang * 1.5
	end
	
	local nFlag = Player:AddRepute(pPlayer, 2, nLevel, nShengWang);
	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		local szName = Battle.NAME_GAMELEVEL[nLevel];
		pPlayer.Msg("Danh vọng " .. szName .. " đạt đến (" .. szSeries .. ") cấp cao nhất, không thể sử dụng tiếp");
		return;
	end
	
	return 1; 
end
local tb = {
	bchuyminh150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		ignoredefenseenhance_v ={{{1,110},{2,120}}},
		--lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bkiemnga150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		--lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bchuongnga150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		--lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bkiemthuy150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		--lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bdaothuy150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bkiemdoan150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bchidoan150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)