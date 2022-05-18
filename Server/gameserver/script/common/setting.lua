-- 杂项数值设定

-- Theo c?p ?? c?a ng??i ch?i, tính giá tr? kinh nghi?m
-- Ch?c n?ng này t? ??ng ???c g?i khi GameServer kh?i ??ng và ???c s? d?ng ?? thi?t l?p b?ng giá tr? tr?i nghi?m treo máy
function Setting:GetHangExpValue(nLevel)	
	local nExp = 0;
	-- 一小时挂机经验：e={3.5w+math.floor[(lv-50)/5]*0.5w}*1.2
	if (nLevel == 50) then 	-- 50
		nExp = 700; -- 每分钟获得的经验值
	elseif (nLevel < 100) then 	-- 51~99
		nExp = 700 + math.floor((nLevel - 50)/5)*100; -- 每分钟获得的经验值
	else -- 100级及100级以上
		nExp = 1700; -- 每分钟获得的经验值[700 + math.floor((100 - 50)/5)*100]
	end
	
	return nExp * 10;	-- 10分钟获得的经验值
end;

Setting.tbGolbalObjStack = {};
function Setting:SetGlobalObj(pPlayer, pNpc, pItem)
	self.tbGolbalObjStack[#self.tbGolbalObjStack + 1] = {pPlayer = me, pNpc = him, pItem = it};

	me = pPlayer or me;

	him = pNpc or him;

	it = pItem or it;
end

function Setting:RestoreGlobalObj()
	local tb = self.tbGolbalObjStack[#self.tbGolbalObjStack];
	if (not tb) then
		assert(false);
	end	
	me = tb.pPlayer or me;
	him = tb.pNpc or him;
	it = tb.pItem or it;
	self.tbGolbalObjStack[#self.tbGolbalObjStack] = nil;
end
