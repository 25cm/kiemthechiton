-------------------------------------------------------
--tính tài phú món đồ
-------------------------------------------------------
--khai báo table
local tbEquipFwdEnh = {};
local tbEquipBakEnh = {};

function PlayerHonor:CaculateEquipOrgValue(nRoomType,nEquipPos)
	local nOrgValue = 0;
    local nEnhValue = 0;
    local nTotleValue = 0;
    local pEquip = me.GetItem(nRoomType, nEquipPos, 0);
    if pEquip then
		local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
		if (tbSetting) then
			local nTypeRate = ((tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100) or 1;
			local nEnhTimes = pEquip.nEnhTimes;
			repeat
				local nEnhValue = tbSetting.m_tbEnhanceValue[nEnhTimes] or 0;
				nTotleValue = nTotleValue + nEnhValue * nTypeRate;
				nEnhTimes = nEnhTimes - 1;
			until (nEnhTimes <= 0);
			nEnhValue = nTotleValue;
		end
   		nTotleValue = pEquip.nValue;
    end
    nOrgValue = nTotleValue - nEnhValue; 
    return nOrgValue;
end

function PlayerHonor:CaculateEquipEnhValue(nRoomType,nEquipPos,nEnhTimes)
	local nEnhValue = 0;
	local nTotleValue = 0;
	local pEquip = me.GetItem(nRoomType, nEquipPos, 0);
	if pEquip then
		local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
		if (tbSetting) then
			local nTypeRate = ((tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100) or 1;
			if (not nEnhTimes) then
				 nEnhTimes = pEquip.nEnhTimes;
 			end
			repeat
				local nEnhValue = tbSetting.m_tbEnhanceValue[nEnhTimes] or 0;
				nTotleValue = nTotleValue + nEnhValue * nTypeRate;
				nEnhTimes = nEnhTimes - 1;
			until (nEnhTimes <= 0);
			nEnhValue = nTotleValue;
			if nRoomType == Item.ROOM_EQUIP then
				tbEquipFwdEnh[nEquipPos] = nEnhValue;
			elseif nRoomType == Item.ROOM_EQUIPEX then
				tbEquipBakEnh[nEquipPos] = nEnhValue;
		    end
		end
	end
    return nEnhValue; 
end

--计算该装备的价值量
function PlayerHonor:CaculateEquipTotalValue(nRoomType,nEquipPos)
	local nValue = 0;
	local pEquip = me.GetItem(nRoomType, nEquipPos, 0);
   	if pEquip then
		nValue = pEquip.nValue;
    end
	return nValue;
end

--计算该装备的已经强化的次数
function PlayerHonor:GetEquipEnhTimes(nRoomType,nEquipPos)
	local nEnhTimes = 0;
    local pEquip = me.GetItem(nRoomType, nEquipPos, 0);
    if pEquip then 
 	   nEnhTimes = pEquip.nEnhTimes;
    end
    return nEnhTimes;
end

--计算该装备位的价值量	
function PlayerHonor:CaculateEquipPosValue(nEquipPos)
	local nTotleValue = 0;
	if nEquipPos < 0 then 
		return 0;
	end
	if nEquipPos < Item.EQUIPEXPOS_NUM	 then  
		local nEnhValue =( tbEquipFwdEnh[nEquipPos] or self:CaculateEquipEnhValue(Item.ROOM_EQUIP, nEquipPos))
		                +( tbEquipBakEnh[nEquipPos] or self:CaculateEquipEnhValue(Item.ROOM_EQUIPEX, nEquipPos));
		local nValue1	= self:CaculateEquipOrgValue(Item.ROOM_EQUIP, nEquipPos);
		local nValue2	= self:CaculateEquipOrgValue(Item.ROOM_EQUIPEX, nEquipPos);		
	    nTotleValue = math.max(nValue1,nValue2);
		nTotleValue = nTotleValue + nEnhValue;
	elseif nEquipPos < Item.EQUIPPOS_NUM then
		nTotleValue = self:CaculateEquipTotalValue(Item.ROOM_EQUIP, nEquipPos);
	else
		 return 0;
    end	
	return nTotleValue;
end

function PlayerHonor:GetWulinmijiValue()
	local nTotleValue = 0;
	local tbWuLin = Item:GetClass("wulinmiji");
	for i, tbParam in ipairs(tbWuLin.tbBook) do
		if self.tbBookToValue[i] then
			nTotleValue = nTotleValue + self.tbBookToValue[i] * me.GetTask(tbParam[2], tbParam[3]);
		end
	end
	return nTotleValue;
end

function PlayerHonor:GetXisuijingValue()
	local tbXiShui = Item:GetClass("xisuijing");
	local nTotleValue = 0;
	for i, tbParam in ipairs(tbXiShui.tbBook) do
		if self.tbBookToValue[i] then
			nTotleValue = nTotleValue + self.tbBookToValue[i] * me.GetTask(tbParam[2], tbParam[3]);
		end
	end
	return nTotleValue;
end

function PlayerHonor:GetXiaohaoValue()
	local nTotleValue = 0;
	nTotleValue = me.GetTask(self.TSK_GROUP, self.TSK_ID_COSUME_VALUE);
	return nTotleValue;
end

--计算当前财富荣誉	
function PlayerHonor:CaculateTotalWealthValue()
	local nTotalValue = 0;
  	for i = 0 , Item.EQUIPPOS_NUM-1  do
			nTotalValue = nTotalValue + 
			 	self:CaculateEquipPosValue(i);
	end
 	nTotalValue = nTotalValue + self:GetWulinmijiValue();
	nTotalValue = nTotalValue + self:GetXisuijingValue();
	nTotalValue = nTotalValue + self:GetXiaohaoValue();
   	nTotalValue = math.floor(nTotalValue / 10000);
   	return nTotalValue;
end