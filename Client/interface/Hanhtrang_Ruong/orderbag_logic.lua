
function Player:ItemSort_GetContainers(nStartContainerId)
	local tbContainer = {};
	local tbContainerTable = {
		Item.ROOM_EXTBAG1, Item.ROOM_EXTBAG2, Item.ROOM_MAINBAG,false,
		Item.ROOM_REPOSITORY, Item.ROOM_EXTREP1, Item.ROOM_EXTREP2, Item.ROOM_EXTBAG3, ROOM_EXTREP4, ROOM_EXTREP5, false
	};
	local k, v = table.find(tbContainerTable, nStartContainerId);
	print(table.getn(tbContainerTable),k, v);
	while tbContainerTable[k]  do
		local nSize, nColumn = Player:ItemSort_GetContainerSize(tbContainerTable[k]);
		print(nSize, nColumn);
		if nSize then 
			table.insert(tbContainer, { tbContainerTable[k], nSize / nColumn, nColumn });
		end
		k = k + 1;
	end
	return tbContainer;
end

function Player:ItemSort_GetAllCells(nStartContainerId)
	local tbAllCells = {  };
	local tbContainers = Player:ItemSort_GetContainers(nStartContainerId);
	for _k, _v in ipairs(tbContainers) do
		local nContainerId, nColumn, nRow = _v[1], _v[2], _v[3];
		for c = nColumn - 1,0,-1 do
			for r = 0, nRow - 1 do
				--table.insert(tbAllCells, {nContainerId = nContainerId, nRow = r, nColumn = c});
				table.insert(tbAllCells, {nContainerId = nContainerId, nRow = r, nColumn = c});
			end
		end
	end
	return tbAllCells;
end

function Player:ItemSort_GetContainerSize(nContainerId)
	local tbFixedContainerTable = { Item.ROOM_MAINBAG, Item.ROOM_REPOSITORY, Item.ROOM_EXTREP1 }; --, Item.ROOM_EXTREP1, Item.ROOM_EXTREP2, Item.ROOM_EXTREP3, Item.ROOM_EXTREP4, Item.ROOM_EXTREP5 };
	local tbExtBag = {  Item.ROOM_EXTBAG1,  Item.ROOM_EXTBAG2 };
	local tbExtBagType	= { Item.EXTBAG_4CELL,	Item.EXTBAG_6CELL,		Item.EXTBAG_8CELL,		Item.EXTBAG_10CELL, 	Item.EXTBAG_12CELL,	Item.EXTBAG_15CELL,	Item.EXTBAG_18CELL, 	Item.EXTBAG_20CELL,	Item.EXTBAG_24CELL	};
	local tbExtBagSize	= { { 4, 4 },				{ 6, 6 },				{ 8, 4 },				{  10,	5},				{  12, 6},				{ 15, 5},				{ 18, 6},				{ 20, 5},				{ 24, 6}				};
	if table.find(tbFixedContainerTable, nContainerId) then
		return 40, 5;
	elseif table.find(tbExtBag, nContainerId) then
		local nBarId = Item.ROOM_EXTBAGBAR;
		local nPos = nContainerId - Item.ROOM_EXTBAG1;		
		local pBagItemObj = me.GetItem(nBarId, nPos, 0);
		if not pBagItemObj then
			return nil;
		end
		local nType = pBagItemObj.nDetail;
		local k,v = table.find(tbExtBagType, nType);
		return tbExtBagSize[k][1], tbExtBagSize[k][2];
	end
	return nil;
end
