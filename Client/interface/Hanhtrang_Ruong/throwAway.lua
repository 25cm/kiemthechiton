local nEquipThrow1;
local nTimerId      = 0;
local nState        = 0; 
local nTime         = 1/18;   -- 检测频率
local tbEquip       = Item:GetClass("equip");
local STEALMANA     = "stealmana_p";            -- 吸内
local STEALLIFE     = "steallife_p";            -- 吸血
local IGNOREDEFENSE = "ignoredefenseenhance_v"; -- 忽略对手闪避值
local RATINGENHANCE = "attackratingenhance_v";  -- 攻击命中值点数
local ADDDEFENSE    = "adddefense_v";           -- 闪避值
local STRIKEENHANCE = "deadlystrikeenhance_r";  -- 攻击会心一击值
-- 需要的明属性
local tbMagic       = {
	{szMagic=STEALLIFE,nValue=1},      -- 吸血>=1
	{szMagic=IGNOREDEFENSE,nValue=10}, -- 忽略对手闪避值>=10
};  
-- 需要的暗属性
local tbDarkMagic   = {
	{szMagic=ADDDEFENSE,nValue=12},    -- 闪避值>=12
	{szMagic=STRIKEENHANCE,nValue=18}, -- 攻击会心一击值>=18
};  
local nNeededLevel  = 9; -- 可拆解出的材料级别小于9就扔掉
local nAutoClose    = 1; -- 丢弃完毕后是否自动关闭插件功能 1:是 0:否

local szCmd	= [=[
		AutoAi:SwitchAutoThrowAway(0,0,1);
	]=];
UiShortcutAlias:AddAlias("GM_", szCmd);	-- 热键：

-- 功能：开始或关闭自动扔玄
function AutoAi:SwitchAutoThrowAway(nLv2, nLv4, nEquip)
	if nState == 0 then 
		nState = 1;
		if nTimerId == 0 then
			nTimerId = Ui.tbLogic.tbTimer:Register(nTime * Env.GAME_FPS, self.AutoThrowAway, self, nLv2, nLv4, nEquip);
		end
	else
		AutoAi:CloseAutoThrowAway();
	end
end

-- 功能：自动扔玄或垃圾
function AutoAi:AutoThrowAway(nLv2, nLv4, nEquip)	
	-- 丢弃不绑的1、2玄
	if nLv2 == 1 then
		local tbItem = me.FindItemInBags(18,1,1,1)[1] or me.FindItemInBags(18,1,1,2)[1]; -- 不绑的1、2玄,5玄不让扔--!
		if tbItem and tbItem.pItem.IsBind() == 0 then
			me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
		elseif (nAutoClose == 1) then
			AutoAi:CloseAutoThrowAway();
		end
	end
	
	-- 丢弃不绑的3、4玄
	if nLv4 == 1 then
		local tbItem = me.FindItemInBags(18,1,1,3)[1] or me.FindItemInBags(18,1,1,4)[1];
		if tbItem and tbItem.pItem.IsBind() == 0 then
			me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
		elseif (nAutoClose == 1) then
			AutoAi:CloseAutoThrowAway();
		end
	end
	
	-- 丢弃垃圾装备
	if nEquip == 1 then
		local tbFind = me.FindClassItemInBags("equip");
		local nSize = Lib:CountTB(tbFind); -- 背包内装备数量
		if (nSize == 0) and (nAutoClose == 1) then
			print("Không có thiết bị có thể được loại bỏ rác!");
			AutoAi:CloseAutoThrowAway();
		else
			for index, tbItem in ipairs(tbFind) do
				if tbItem and tbItem.pItem.IsBind() >= 0 then
					local pItem = tbItem.pItem;	
					local	nPrice = GetSalePrice(pItem);	-- it:pItem
					local nMaxLevel = AutoAi:GetMaxBreakUpStuff(pItem);
					local nNeededMagic = AutoAi:GetNeededMagicStatus(pItem);
					local nNeededDarkMagic = AutoAi:GetNeededDarkMagicStatus(pItem);
					if nPrice == 0 and nNeededMagic == 0 and nNeededDarkMagic == 0 and nMaxLevel < nNeededLevel then
						me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY); -- 可拆解出的材料级别小于9就扔掉
					end
				end
				if (index == nSize) and (nAutoClose == 1) then
					print("Loại bỏ hoàn tất!");
					AutoAi:CloseAutoThrowAway();
				end
			end
		end
	end
end

-- 功能：关闭自动扔玄或垃圾
function AutoAi:CloseAutoThrowAway()
	nState = 0;
	if nTimerId > 0 then
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end

function AutoAi:AutoThrowAway2()	
AutoAi:GetEquipThrow()
	local tbItem = nEquipThrow1[1];
	me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
--	return 0 ;
end

function AutoAi:GetEquipThrow()
	local tbFind=me.FindClassItemInBags("equip")
	local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);
	uiAutoFight:LoadSetting();
	local nPickStarn = uiAutoFight.nPickStar;
	local nSize = Lib:CountTB(tbFind);
	nEquipThrow1={};
	if (nSize == 0) and (nAutoClose == 1) then
			print("Không có thiết bị có thể được loại bỏ rác!");
			AutoAi:CloseAutoThrowAway();
	else --if tbFind then
			for index, tbItem in ipairs(tbFind) do
				local pItem = me.GetItem(tbItem.nRoom, tbItem.nX, tbItem.nY);
				if pItem.nStarLevel<=nPickStarn*2 and 1 ~= pItem.IsBind() then
					table.insert(nEquipThrow1, tbItem);
				end
			end
			if (index == nSize) and (nAutoClose == 1) then
					print("Loại bỏ hoàn tất!");
					AutoAi:CloseAutoThrowAway();
			end
	end
end
-- 功能：获取可拆解出材料的最高级别
function AutoAi:GetMaxBreakUpStuff(pEquip)
	local nGTPCost, tbStuff, tbExp = Item:CalcBreakUpStuff(pEquip);	
	local nMaxLevel = 0;
	if (nGTPCost > 0) and (#tbStuff > 0) then
		for _, tbInfo in ipairs(tbStuff) do
			local nLevel = tbInfo.nLevel;
			if nLevel > nMaxLevel then
				nMaxLevel = nLevel;
			end
		end
	end
	return nMaxLevel;
end

-- 功能：是否有需要的明属性
function AutoAi:GetNeededMagicStatus(pItem)
	local tbMASS = pItem.GetRandMASS();			-- 获得道具随机魔法属性
	local nPos1, nPos2 = KItem.GetEquipActive(KItem.EquipType2EquipPos(pItem.nDetail));
	if (nPos1 and nPos2) then
		for i = 1, #tbMASS / 2 do			-- 明属性处理
			local tbMA = tbMASS[i];			
			local tbValue = tbMA.tbValue;
			for i = 1, #tbMagic do
				local szMagic = tbMagic[i].szMagic;
				local nValue = tbMagic[i].nValue;
				if (tbMA.szName == szMagic and tbValue[1] >= nValue) then
					return 1;
				end
			end
		end
	end
	return 0;
end

-- 功能：是否有需要的暗属性
function AutoAi:GetNeededDarkMagicStatus(pItem)
	local tbMASS = pItem.GetRandMASS();			-- 获得道具随机魔法属性
	local nPos1, nPos2 = KItem.GetEquipActive(KItem.EquipType2EquipPos(pItem.nDetail));
	if (nPos1 and nPos2) then
		for i = #tbMASS / 2 + 1, #tbMASS do			-- 暗属性处理
			local tbMA = tbMASS[i];
			local tbValue = tbMA.tbValue;
			for i = 1, #tbDarkMagic do
				local szMagic = tbDarkMagic[i].szMagic;
				local nValue = tbDarkMagic[i].nValue;
				if (tbMA.szName == szMagic and tbValue[1] >= nValue) then
					return 1;
				end
			end
		end
	end
	return 0;
end