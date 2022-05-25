if (not Item.tbTianYanFu) then
	Item.tbTianYanFu = {};
end

local tb = Item.tbTianYanFu;

tb.tbItemList = {
	[206] = 10
}

function tb:SelectEnemyPos(nEnemyId, nPlayerId, nItemId)
	GlobalExcute({"Item.tbTianYanFu:SeachPlayer", nEnemyId, nPlayerId, nItemId});
end


function tb:SeachPlayer(nEnemyId, nPlayerId, nItemId)
	local pMember = KPlayer.GetPlayerObjById(nEnemyId)
	if (pMember) then
		local nMapId, nPosX, nPosY 	= pMember.GetWorldPos();
		local nMapIndex 			= SubWorldID2Idx(nMapId);
		local nMapTemplateId		= SubWorldIdx2MapCopy(nMapIndex);
		local nFightState 			= pMember.nFightState;
		GCExcute({"Item.tbTianYanFu:FindMember", pMember.szName, nPlayerId, nItemId, nMapTemplateId, nPosX, nPosY, nFightState});		
	end
end


function tb:FindMember(szEnemyName, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	GlobalExcute({"Item.tbTianYanFu:ObtainMemberPos", szEnemyName, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState})
end
local tb = {
	thuyyenkiem150ctcon={ --风雪冰天，冰心仙子第二式
		appenddamage_p= {{{1,35*FightSkill.tbParam.nS1},{10,35},{20,35*FightSkill.tbParam.nS20},{21,35*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,225*0.9*FightSkill.tbParam.nS1},{10,225*0.9},{20,225*0.9*FightSkill.tbParam.nS20},{21,225*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,225*1.1*FightSkill.tbParam.nS1},{10,225*1.1},{20,225*1.1*FightSkill.tbParam.nS20},{21,225*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,22},{10,40},{20,61}},{{1,27},{20,54},{20,54}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	thuyyendao150={ --冰踪无影
		appenddamage_p= {{{1,26},{2,27}}},
		physicsenhance_p={{{1,81*FightSkill.tbParam.nS1},{10,81},{20,81*FightSkill.tbParam.nS20},{21,81*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,271*0.9*FightSkill.tbParam.nS1},{10,271*0.9},{20,271*0.9*FightSkill.tbParam.nS20},{21,271*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,271*1.1*FightSkill.tbParam.nS1},{10,271*1.1},{20,271*1.1*FightSkill.tbParam.nS20},{21,271*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,16},{2,17}},{{1,18},{20,18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		skill_collideevent={{{1,1967},{20,1967}}},
		deadlystrikedamageenhance_p={{{1,1*0.5},{2,1}}},
		skill_showevent={{{1,4},{20,4}}},
		missile_range={1,0,1},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	thuyyendao150ctcon={ --冰心雪莲，冰踪无影第二式
		state_slowall_attack={{{1,10},{10,25},{20,35}},{{1,27},{20,45},{21,45}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	caibangr150={ --飞龙在天
		appenddamage_p= {{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,15*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,450*0.9*FightSkill.tbParam.nS1},{10,450*0.9},{20,450*0.9*FightSkill.tbParam.nS20},{21,450*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,450*1.1*FightSkill.tbParam.nS1},{10,450*1.1},{20,450*1.1*FightSkill.tbParam.nS20},{21,450*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,6},{2,7},{3,8}},{{1,2*18},{20,4*18},{21,4*18}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,18*2},{2,18*2}}},
		state_burn_attacktime={{{1,110},{2,120}}},
		skill_missilenum_v={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,1971},{20,1971}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	caibangr150ctcon={ --龙战于野，飞龙在天第二式
		appenddamage_p= {{{1,110*FightSkill.tbParam.nS1},{10,110},{20,110*FightSkill.tbParam.nS20},{21,110*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,2800*0.8*FightSkill.tbParam.nS1},{10,2800*0.8},{20,2800*0.8*FightSkill.tbParam.nS20},{21,2600*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2800*1.2*FightSkill.tbParam.nS1},{10,2800*1.2},{20,2800*1.2*FightSkill.tbParam.nS20},{21,2600*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,90},{2,90}}},
		missile_range={5,0,5},
	},
	bdaothieu150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		ignoredefenseenhance_v ={{{1,110},{2,120}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bconthieu150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		ignoredefenseenhance_v ={{{1,110},{2,120}}},
		fastwalkrun_p={{{1,31},{2,32}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bthuongthien150={ --????_20
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		ignoredefenseenhance_v ={{{1,110},{2,120}}},
		fastwalkrun_p={{{1,31},{2,32}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)


function tb:ObtainMemberPos(szEnemyName, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if not pPlayer then
		return 0;
	end
	
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		pPlayer.Msg("Không tìm được vật phẩm, không thể thao tác. Hãy liên hệ GM.")
		return 0;
	end
	local nNTime = GetTime();
	local nYearDate = tonumber(os.date("%Y%m%d",nNTime));
	local nTimeDate = tonumber(os.date("%H%M%S",nNTime));
	pItem.SetGenInfo(2,nYearDate);
	pItem.SetGenInfo(3,nTimeDate);	
	if nFightState == 0 or Item:IsCallInAtMap(nMapId, 18,1,85,1) == 0 then
		Setting:SetGlobalObj(pPlayer, him, pItem);
		Dialog:Say(string.format("Kẻ thù <color=red>%s<color> hiện không ở bên ngoài, hãy thử lại sau.", szEnemyName));
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	local nUseCount = pItem.GetGenInfo(1,0);
	if self.tbItemList[pItem.nParticular] - nUseCount == 1 then
		if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			pPlayer.Msg("Xóa vật phẩm thất bại!");
			return 0;
		end
	else
		pItem.SetGenInfo(1,nUseCount + 1);
		pItem.Sync();
	end
	Setting:SetGlobalObj(pPlayer, him, pItem);
	Dialog:Say(string.format("Vị trí hiện tại của kẻ thù <color=red>%s<color> là:\n\nBản đồ: <color=yellow>%s<color>\nTọa độ: <color=yellow>%s/%s<color>", szEnemyName, GetMapNameFormId(nMapId), math.floor(nPosX/8), math.floor(nPosY/16)))
	Setting:RestoreGlobalObj();
end

