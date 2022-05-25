--[[
??DoScript("E:\\剑侠世界\\interface\\道具排序\\orderbag.lua");
??DoScript("E:\\剑侠世界\\interface\\道具排序\\orderbag_compare.lua");
??DoScript("E:\\剑侠世界\\interface\\道具排序\\orderbag_logic.lua");
??Player:ItemSort_SortBag();
??Player:ItemSort_End();
??Player:ItemSort_SortRepository();

??Player:ItemSort_Begin(2);
??Player:ItemSort_EndItemSort()

??Player:ItemDiejia_Begin(2);
??Player:ItemDiejia_EndItemDiejia();
--]]

--DoScript("E:\\orderbag_compare.lua");
--DoScript("E:\\orderbag_logic.lua");
local bIsSorting = false;
local nSortContainerId;
local nTimerId;
local tbCells;
--开始整理背包
function Player:ItemSort_SortBag()
	print("new sort");
	Player:ItemSort_Begin(Item.ROOM_EXTBAG1);
        end

function Player:ItemSort_SortRepository()
	local tbRepository = Ui(Ui.UI_REPOSITORY);
	print("new sort repository");
	local PAGE2ROOM =
	{
		Item.ROOM_REPOSITORY,
		Item.ROOM_EXTREP1,
		Item.ROOM_EXTREP2,
		Item.ROOM_EXTREP3,
		Item.ROOM_EXTREP4,
		Item.ROOM_EXTREP5,
	};
	print("tbRepository.nCurPage:", tbRepository.nCurPage);
	print("PAGE2ROOM[tbRepository.nCurPage]", PAGE2ROOM[tbRepository.nCurPage]);
	Player:ItemSort_Begin(PAGE2ROOM[tbRepository.nCurPage]);
end

--开始排序
function Player:ItemSort_Begin(nStartContainerId)
	if not bIsSorting then
		bIsSorting = true;
	else
		print("is sorting now!");
		return;
	end
	print("begin sort", nContainerId);
	nSortContainerId = nStartContainerId;
	self.tbSortRule = {self.ItemSort_CompareGenre,self.ItemSort_CompareClass,self.ItemSort_CompareLevel,self.ItemSort_CompareName};
	nTimerId = Timer:Register(1, self.ItemSort_OnSort, self);
end

--排序工作结束
function Player:ItemSort_End()
	Timer:Close(nTimerId);
	nTimerId = nil;
	bIsSorting = false;
	print("end sort bag");
end

function Player:ItemSort_OnSort()
	tbCells = Player:ItemSort_GetAllCells(nSortContainerId);
	print("Player:ItemSort_GetAllCells:", #tbCells, nSortContainerId);
	print("Enter call back");
	if (tbCells[1].nContainerId == Item.ROOM_REPOSITORY) and 
		(UiManager.tbUiState[UiManager.UIS_OPEN_REPOSITORY] == 0 ) then
		Player:ItemSort_End();	
	end
	
	for i = 1, table.getn(tbCells) do
		local pItem1 = me.GetItem(tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn);
		local tbItemMVI = {pItemMVI = pItem1, nNum = i};
		for j = i + 1, table.getn(tbCells) do
			local pItem2 = me.GetItem(tbCells[j].nContainerId, tbCells[j].nRow, tbCells[j].nColumn);
		
			--可以叠加的条件
			if (pItem1 and pItem2) then
				local _, _nTimeOut1 = pItem1.GetTimeOut();
				local _, _nTimeOut2 = pItem2.GetTimeOut();
				if (pItem1.IsStackable() == 1 and _nTimeOut1 == 0) and (pItem2.IsStackable() == 1 and _nTimeOut2 == 0) then
					if (Player:ItemSort_CompareItemName(pItem1,pItem2)) and (pItem1.nCount ~= pItem1.nMaxCount) then
						if (pItem1.IsBind() == pItem2.IsBind()) then
							me.SwitchItem(tbCells[j].nContainerId, tbCells[j].nRow, tbCells[j].nColumn,
								tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn);
							return;
						end
					end
				end
			end
			
			--记录当前item后面优先级最大的item及其所在位置			
			if (Player:ItemSort_Compare(tbItemMVI.pItemMVI, pItem2, self.tbSortRule) == -1)	then
				tbItemMVI.pItemMVI = pItem2;
				tbItemMVI.nNum = j;
			end
		end
		
		--如果当前item的优先级不是最大，与最大优先级交换
		if (tbItemMVI.nNum ~= i) then
			me.SwitchItem(tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn,
				tbCells[tbItemMVI.nNum].nContainerId, tbCells[tbItemMVI.nNum].nRow, tbCells[tbItemMVI.nNum].nColumn);
			return;
		end;
	end
	
	Player:ItemSort_End();
end
