--武林联赛
--孙多良
--2008.10.13
local Fun = {};
Wlls.Fun = Fun;

Fun.tbParamFun = 
{
	["exp"] 	= "ExeExp",			--经验,单位万
	expbase 	= "ExeExpbase",		--基准经验
	repute 		= "ExeRepute",		--声望
	item 		= "ExeItem", 		--物品
	title 		= "ExeTitle", 		--称号
	binditem 	= "ExeBindItem", 	--绑定物品
	prestige	= "ExePrestige",	--江湖威望
	stock		= "ExeStock"		--股份
}
function Fun:GetNeedFree(tbParam)
	local nNeedFree = 0;
	for szFun, tbFun in pairs(tbParam) do
		for _, value in pairs(tbFun) do
			if szFun == "item" or szFun == "binditem" then
				nNeedFree = nNeedFree + 1;
			end
		end
	end
	return nNeedFree;
end

function Fun:DoExcute(pPlayer, tbParam)
	for szFun, tbFun in pairs(tbParam) do
		for _, value in pairs(tbFun) do
			if self.tbParamFun[szFun] and self[self.tbParamFun[szFun]] then
				self[self.tbParamFun[szFun]](self, pPlayer, value);
			end
		end
	end
end

--时间显示转换
function Fun:Number2Time(nTime)
	local nMin = math.mod(nTime, 100);
	local nHour = math.floor(nTime/ 100);
	local szMin = nMin;
	if nMin < 10 then
		szMin = "0" .. nMin;
	end
	local szTime = nHour .. ":" .. szMin;
	return szTime
end 

function Fun:ExeExp(pPlayer, value)
	pPlayer.AddExp(tonumber(value*10000));
end

function Fun:ExeExpbase(pPlayer, value)
	pPlayer.AddExp(pPlayer.GetBaseAwardExp() * value);
end

function Fun:ExeRepute(pPlayer, value)
	--增加声望
	pPlayer.AddRepute(7, 1, value);
end

function Fun:ExeItem(pPlayer, value)
	--获得物品
	if pPlayer.CountFreeBagCell() < 1 then
		pPlayer.Msg(string.format("由于您的背包空间已满，无法获得<color=yellow>%s<color>", KItem.GetNameById(unpack(value))));
		return 0;
	end	
	pPlayer.AddItem(unpack(value))
end

function Fun:ExeTitle(pPlayer, value)
	--获得称号.
	pPlayer.AddTitle(unpack(value));
	pPlayer.SetCurTitle(unpack(value));
end

function Fun:ExeBindItem(pPlayer, value)
	--获得物品
	if pPlayer.CountFreeBagCell() < 1 then
		pPlayer.Msg(string.format("由于您的背包空间已满，无法获得<color=yellow>%s<color>", KItem.GetNameById(unpack(value))));
		return 0;
	end
	local pItem = pPlayer.AddItem(unpack(value));
	if pItem then
		pItem.Bind(1);
	end
end

--增加江湖威望
function Fun:ExePrestige(pPlayer, value)
	pPlayer.AddKinReputeEntry(value, "wlls");
end

--增加建设资金和个人、族长、帮主股份
function Fun:ExeStock(pPlayer, value)
	Tong:AddStockBaseCount_GS1(pPlayer.nId, value, 0.75, 0.15, 0.05, 0, 0.05);
end
