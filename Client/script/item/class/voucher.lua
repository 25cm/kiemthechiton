-- 文件名　：voucher.lua
-- 创建者　：furuilei
-- 创建时间：2010-03-22 09:46:26
-- 功能描述：奇珍阁全部商品打折优惠券（注意，是金币区的全部商品）

local tbVoucher = Item:GetClass("voucher");

function tbVoucher:GetTip()
	local szTip = "";
	local pVoucher = KItem.GetObjById(it.dwId);
	if (not pVoucher) then
		return szTip;
	end
	local nMaxPoint = pVoucher.GetExtParam(1);
	szTip = szTip.."<color=0x8080ff>Số điểm còn có thể dùng: ".. (nMaxPoint - it.GetGenInfo(1)) .."<color>";
	return	szTip;
end

function tbVoucher:GetWareInfo()
	return {};
end

function tbVoucher:CalDiscount(tbWareList)
	if not tbWareList then
		return {};
	end
	
	assert(it);
	assert(me);
	
	local tbRet = {};
	local pVoucher = KItem.GetObjById(it.dwId);
	
	local nDiscountRate = pVoucher.GetExtParam(2);	-- 优惠券的折扣，在extparam2里面配置
	local nMaxPoint = pVoucher.GetExtParam(1);		-- 一共多少打折额度，在extparam1里面配置
	local nUsedPoint = pVoucher.GetGenInfo(1);		-- 已经使用了多少打折额度
	local nLeftPoint = nMaxPoint - nUsedPoint;		-- 还剩余多少打折额度
	local bBind = pVoucher.GetExtParam(3);			-- 通过这个优惠券购买的商品是否绑定
	
	-- 打折的折扣不正确
	if (nDiscountRate > 100 or nDiscountRate < 0) then
		return {};
	end
	
	-- 没有剩余使用点数了
	if (nMaxPoint <= 0 or nLeftPoint <= 0) then
		return {};
	end
	
	for _, tbData in pairs(tbWareList) do
		local tbInfo = me.IbShop_GetWareInf(tbData.nWareId);
		
		-- 只有金币区才能使用优惠券(程序中0表示金币，1表示银两，2表示绑金)
		if (tbInfo.nCurrencyType == 0) then
			local nActualDiscountTimes = 0;
			local nEachItemUsePoint = math.ceil(tbInfo.nOrgPrice * (100 - nDiscountRate) / 100);	-- 每个商品使用的优惠点数
			if (nLeftPoint >= nEachItemUsePoint and nEachItemUsePoint > 0) then
				nActualDiscountTimes = math.floor(nLeftPoint / nEachItemUsePoint);					-- 可以对当前商品当中的几个进行打折
				if (nActualDiscountTimes >= tbData.nCount) then
					nActualDiscountTimes = tbData.nCount;
				end
			end
			nLeftPoint = nLeftPoint - (nActualDiscountTimes * nEachItemUsePoint);					-- 还可以剩余多少打折点数
			
			if (nActualDiscountTimes >= 0 and nLeftPoint >= 0) then
				table.insert(tbRet, {tbData.nWareId, nActualDiscountTimes, nDiscountRate, bBind});
			end
		end
	end	
	return tbRet;
end
local tb = {
	vokiem150_child={ --太极剑意，人剑合一第二式
		state_stun_attack={{{1,31},{2,32}},{{1,2*18},{20,2*18}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	thieulamdao150={ --天竺绝刀_20
		appenddamage_p= {{{1,45*FightSkill.tbParam.nS1},{10,47},{20,47*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,132*FightSkill.tbParam.nS1},{10,135},{20,135*FightSkill.tbParam.nS20},{21,135*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,1110*0.9*FightSkill.tbParam.nS1},{10,1110*0.9},{20,1110*0.9*FightSkill.tbParam.nS20},{21,775*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1110*1.1*FightSkill.tbParam.nS1},{10,1110*1.1},{20,1110*1.1*FightSkill.tbParam.nS20},{21,775*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,2*19},{20,3*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	thienvuongthuong150={ --追星逐月
		appenddamage_p= {{{1,42},{2,44}}},
		physicsenhance_p={{{1,120*FightSkill.tbParam.nS1},{10,120},{20,120*FightSkill.tbParam.nS20},{21,120*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,700*0.9*FightSkill.tbParam.nS1},{10,700*0.9},{20,700*0.9*FightSkill.tbParam.nS20},{21,700*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,700*1.1*FightSkill.tbParam.nS1},{10,700*1.1},{20,700*1.1*FightSkill.tbParam.nS20},{21,700*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,3*18},{20,3*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		missile_hitcount={{{1,3},{20,3}}},
		skill_vanishedevent={{{1,1998},{20,1998}}},
		skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	thienvuongthuong150_child={ --追星逐月
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS1},{10,500*0.9},{20,500*0.9*FightSkill.tbParam.nS20},{21,500*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,500*1.1*FightSkill.tbParam.nS1},{10,500*1.1},{20,500*1.1*FightSkill.tbParam.nS20},{21,500*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{10,25},{20,30}},{{1,18},{20,18}}},
		missile_hitcount={{{1,1},{20,1}}},
	},
	ngudocdao150={ --玄阴斩
		appenddamage_p= {{{1,52*FightSkill.tbParam.nS1},{10,52},{20,52*FightSkill.tbParam.nS20},{21,52*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,103},{2,106}}},
		poisondamage_v={{{1,63},{2,66}},{{1,4*18},{20,6*18}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,26},{2,27}},{{1,36},{20,36}}},
		state_weak_attack={{{1,12},{2,14}},{{1,3*18},{20,4*18},{21,4*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		fastwalkrun_p={{{1,-10},{10,-30},{11,-31}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngudocchuong150={ --阴风蚀骨
		appenddamage_p= {{{1,47*FightSkill.tbParam.nS1},{10,50},{20,51*FightSkill.tbParam.nS20},{21,51*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,315*FightSkill.tbParam.nS1},{10,315},{20,315*FightSkill.tbParam.nS20},{21,315*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_weak_attack={{{1,12},{2,13.5}},{{1,36},{10,2*36},{20,2*36},{21,2*36}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,72},{2,72}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_vanishedevent={{{1,1987},{20,1987}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)

function tbVoucher:CanCouponUse(dwId)
	assert(dwId);
	local pItem = KItem.GetObjById(dwId);
	if not pItem then
		return 0, "Vé ưu đãi của ngươi đã hết hạn.";
	end
	
	if me.IsAccountLock() ~= 0 then
		return 0, "Ngươi đang ở trạng thái khóa";
	end
	
	return 1;
end

function tbVoucher:DecreaseCouponTimes(tbDiscountWare)
	if (not tbDiscountWare) then
		return 0;
	end

	assert(it)
	local pVoucher = KItem.GetObjById(it.dwId);
	if (not pVoucher) then
		return 0;
	end

	local nDiscountRate = pVoucher.GetExtParam(2);	-- 优惠券的折扣，在extparam2里面配置
	local nMaxPoint = pVoucher.GetExtParam(1);		-- 一共多少打折额度，在extparam1里面配置
	local nUsedPoint = pVoucher.GetGenInfo(1);		-- 已经使用了多少打折额度
	local nLeftPoint = nMaxPoint - nUsedPoint;		-- 还剩余多少打折额度
	local bBind = pVoucher.GetExtParam(3);			-- 通过这个优惠券购买的商品是否绑定
	local nDecresePoint = 0;						-- 需要扣除的使用点数
	
	if (nLeftPoint <= 0) then
		pVoucher.Delete(me);
	end
		
	for _, tbData in pairs(tbDiscountWare) do
		local tbInfo = me.IbShop_GetWareInf(tbData[1]);
		local nEachItemUsePoint = math.ceil(tbInfo.nOrgPrice * (100 - nDiscountRate) / 100);
		local nDiscountCount = tbData[2];
		nDecresePoint = nDecresePoint + nEachItemUsePoint * nDiscountCount;
	end
	
	if (nDecresePoint > nLeftPoint) then	--要扣除的点数大于剩余点数
		Dbg:WriteLog("coupon", "Error: Điểm khấu trừ vé ưu đãi lớn hơn điểm hiện có!!!");
		return 0;
	end
	
	nUsedPoint = nUsedPoint + nDecresePoint;
	
	if (nUsedPoint >= nMaxPoint) then
		pVoucher.Delete(me);
	else
		pVoucher.SetGenInfo(1, nUsedPoint);
		pVoucher.Sync();
	end
	
	return 1;
end
