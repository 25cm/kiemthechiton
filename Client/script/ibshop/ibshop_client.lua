
IbShop.bShowInfo = 1;

if (not MODULE_GAMECLIENT) then
	return;
end


IbShop.tbWareList = {};


function IbShop:Init()
	self.tbWareList = {};
end

function IbShop:UnInit()
	self.tbWareList = {};
end

function IbShop:AddWare(nWareZone, nWareType, tbWareList)
	if (nWareZone < self.GOLD_SECTION or nWareZone > self.BINDGOLD_SECTION or
		nWareType <= 0 or not tbWareList or #tbWareList == 0) then
		return;
	end
	
	if not self.tbWareList[nWareZone] then
		self.tbWareList[nWareZone] = {};
	end
	if not self.tbWareList[nWareZone][nWareType] then
		self.tbWareList[nWareZone][nWareType] = {};
	end	
	for _, nWareId in pairs(tbWareList) do
		local bExist = 0;
		for _, nExistWareId in pairs(self.tbWareList[nWareZone][nWareType]) do
			if (nWareId == nExistWareId) then
				bExist = 1;
				break;
			end	
		end
		if (0 == bExist) then
			local nIndex = Lib:CountTB(self.tbWareList[nWareZone][nWareType]) + 1;
			self.tbWareList[nWareZone][nWareType][nIndex] = nWareId;
		end
	end
end

function IbShop:GetWareList(nWareZone, nWareType, nFirstIndex, nCount)
	if (nWareZone < self.GOLD_SECTION or nWareZone > self.BINDGOLD_SECTION or
		nWareType <= 0 or nFirstIndex < 0 or nCount <= 0) then
		return;
	end
	if (not self.tbWareList[nWareZone] or not self.tbWareList[nWareZone][nWareType]) then
		return;
	end
	local nMaxIndex = Lib:CountTB(self.tbWareList[nWareZone][nWareType]);
	if (nMaxIndex < nFirstIndex) then
		return;
	end
	
	local tbResult = {};
	local nIndex = nFirstIndex + 1;
	for i = 1, nCount do
		if (self.tbWareList[nWareZone][nWareType][nIndex]) then
			tbResult[i] = self.tbWareList[nWareZone][nWareType][nIndex];
			nIndex = nIndex + 1;
		else
			break;
		end
	end
	
	return tbResult;
end
