
if MODULE_GC_SERVER then
	return
end


function KItem.AddPlayerGeneralEquip(pPlayer, nDetail, nParticular, nLevel, nSeries, nEnhTimes, nLucky, nVersion, uRandSeed, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.EQUIP_GENERAL,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		nEnhTimes or 0,
		nLucky or 0,
		nil,nil,
		nVersion or 0,
		uRandSeed or 0,
		0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerGoldEquip(pPlayer, nDetail, nParticular, nLevel, nSeries, nEnhTimes, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.EQUIP_GOLD,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		nEnhTimes or 0,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerGreenEquip(pPlayer, nDetail, nParticular, nLevel, nSeries, nEnhTimes, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.EQUIP_GREEN,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		nEnhTimes or 0,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerMedicine(pPlayer, nDetail, nParticular, nLevel, nSeries, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.MEDICINE,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		0,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerScriptItem(pPlayer, nDetail, nParticular, nLevel, nSeries, tbGenInfo, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.SCRIPTITEM,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		0,
		0,
		tbGenInfo,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerSkillItem(pPlayer, nDetail, nParticular, nLevel, nSeries, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.SKILLITEM,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		0,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerQuest(pPlayer, nDetail, nParticular, nLevel, nSeries, tbGenInfo, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.TASKQUEST,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		0,
		0,
		tbGenInfo,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerExtBag(pPlayer, nDetail, nParticular, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.EXTBAG,
		nDetail,
		nParticular,
		1,
		0,
		Env.SERIES_NONE,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerStuffItem(pPlayer, nDetail, nParticular, nLevel, nSeries, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.STUFFITEM,
		nDetail,
		nParticular,
		nLevel,
		0,
		nSeries or Env.SERIES_NONE,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.AddPlayerPlanItem(pPlayer, nDetail, nParticular, nLevel, nSeries, nVersion, nWay)

	return	KItem.AddPlayerItem(
		pPlayer,
		Item.PLANITEM,
		nDetail,
		nParticular,
		nLevel,
		0,
		nSeries or Env.SERIES_NONE,
		0,
		nil,nil,
		nVersion or 0,
		0,0,0,1,
		nWay or 100
	);

end

function KItem.GetNeedFreeBag(nGenre, nDetail, nParticular, nLevel, tbItemInfo, nCount)
	if tbItemInfo and (tonumber(tbItemInfo.bTimeOut) or 0) > 0 then
		return nCount or 0;
	end
	nCount 		= tonumber(nCount) or 0;
	nGenre 		= tonumber(nGenre) or 0;
	nDetail 	= tonumber(nDetail) or 0;
	nParticular = tonumber(nParticular) or 0;
	nLevel 		= tonumber(nLevel) or 0;
	if nGenre <= 0 or nDetail <= 0 or nParticular <= 0 or nLevel <= 0 then
		return 0;
	end
	local tbProp = KItem.GetOtherBaseProp(nGenre, nDetail, nParticular, nLevel);
	if not tbProp then
		return 0;
	end
	local nStackMax = tonumber(tbProp.nStackMax) or 1;
	local nNeedFree = math.ceil(nCount/nStackMax);
	return nNeedFree;
end
