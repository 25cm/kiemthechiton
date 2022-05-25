function table.find(tbSrc, varValue)
	for k,v in ipairs(tbSrc) do
		if v == varValue then
			return k, v;
		end
	end
	return nil;
end

-----------------比较两个道具----------------------------
function Player:ItemSort_Compare(pItem1, pItem2, tbSortRule)
	if not pItem1 and pItem2 then return -1; end;
	if pItem1 and not pItem2 then return 1; end;
	if not pItem1 and not pItem2 then return 0; end;
	local nRetVal = nil;
	for i, v in ipairs(tbSortRule) do
		local pFun = tbSortRule[i];
		nRetVal = pFun(self,pItem1,pItem2);
		if (nRetVal ~= 0) then break; end;
	end
	return nRetVal;	
end

function Player:ItemSort_CompareValue(var1, var2)
	if var1 < var2 then
		return 1;
	elseif var1 == var2 then
		return 0;
	else
		return -1;
	end
end

function Player:ItemSort_CompareGenre(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.nGenre, pItem2.nGenre);
end

function Player:ItemSort_CompareLevel(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.nLevel, pItem2.nLevel);
end

function Player:ItemSort_CompareName(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.szName, pItem2.szName);
end

function Player:ItemSort_CompareClass(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.szClass, pItem2.szClass);
end
--比较两个物品对象是否是同一个物品，即Id相等
function Player:ItemSort_CompareItemId(pItem1, pItem2)
	if not (pItem1 or pItem2) then -- 都是nil
		return true;
	elseif  not (pItem1 and pItem2) then -- 有一个是nil
		return false;
	elseif pItem1.dwId == pItem2.dwId then
		return true;
	end
end

--比较两个物品名字是否相等
function Player:ItemSort_CompareItemName(pItem1, pItem2)
	if not (pItem1 or pItem2) then -- 都是nil
		return true;
	elseif  not (pItem1 and pItem2) then -- 有一个是nil
		return false;
	elseif pItem1.szName == pItem2.szName then
		return true;
	end;
end

