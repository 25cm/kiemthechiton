
if MODULE_GC_SERVER then
	return;
end

Require("\\script\\faction\\customfaction\\factiontoken\\factiontoken_def.lua");

Item.tbFactionToken = Item.tbFactionToken or {};
local tbFactionToken = Item.tbFactionToken;

function tbFactionToken:LoadMagicAttribSettingFile()
	local szFile = "\\setting\\faction\\customfaction\\factiontoken\\magicsetting.txt";
	local tbFile = Lib:LoadTabFile(szFile);
	if not tbFile then
		print("Đọc bản thiết lập thuộc tính Tín Vật Tông Môn thất bại");
		return 0;
	end
	
	local tbAttribSetting 		 = {}; -- [nId]		  			 			= {...};
	local tbFeatureSetting 		 = {}; -- [nPhyType][nSeries] 	 			= {id1, id2, id3};
	local tbActiveSetting 		 = {}; -- [nIndex]     						= nId;
	local tbSpeSetting 			 = {}; -- [nIndex]	  			 			= nId;
	local tbMagicType2MagicClass = {}; -- [nMagicType] 			 			= nMagicClass
	local tbMagicTypeAttrib      = {}; -- [nMagicType][nPhyType][nSeries]   = nId
	local tbNewAttrib			 = {}; -- [nId] 							= 1;
	local tbNewAttribIndex		 = {}; -- [nId]								= nIndex;
	for _, tbRow in ipairs(tbFile) do
		local nId 				= tonumber(tbRow["Id"]);
		local szMagicName		= tbRow["MagicName"];
		local szDesc 			= tbRow["Desc"];
		local szName			= tbRow["Name"];
		local nPhyType 			= tonumber(tbRow["PhyType"]);
		local nSeries 			= tonumber(tbRow["Series"]);
		local nMagicClass 		= tonumber(tbRow["MagicClass"]);
		local nMagicType 		= tonumber(tbRow["MagicType"]);
		local szIcon 			= tbRow["Icon"];
		local nNeedPlayerLevel 	= tonumber(tbRow["NeedPlayerLevel"]);
		local nNeedTokenLevel	= tonumber(tbRow["NeedTokenLevel"]);
		local nNeedItem 		= tonumber(tbRow["NeedItem"]);
		local nNewAttrib		= tonumber(tbRow["NewAttrib"] or 0);
		local nNewAttribIndex	= tonumber(tbRow["NewAttribIndex"] or 0);
		
		tbAttribSetting[nId] = 
		{
			szMagicName = szMagicName, nPhyType = nPhyType, nSeries = nSeries, nMagicClass = nMagicClass, 
			nMagicType = nMagicType , nNeedPlayerLevel = nNeedPlayerLevel, nNeedTokenLevel = nNeedTokenLevel, nNeedItem = nNeedItem, szName = szName
		};
	
		if MODULE_GAMECLIENT then
			tbAttribSetting[nId].szDesc = szDesc;
			tbAttribSetting[nId].szIcon = szIcon;
		end
		
		if nMagicClass > 0 and nMagicClass <= 2 then
			tbFeatureSetting[nPhyType] = tbFeatureSetting[nPhyType] or {};
			tbFeatureSetting[nPhyType][nSeries] = tbFeatureSetting[nPhyType][nSeries] or {};
			table.insert(tbFeatureSetting[nPhyType][nSeries], nId);
			
			tbMagicTypeAttrib[nMagicType] = tbMagicTypeAttrib[nMagicType] or {};
			tbMagicTypeAttrib[nMagicType][nPhyType] = tbMagicTypeAttrib[nMagicType][nPhyType] or {};
			tbMagicTypeAttrib[nMagicType][nPhyType][nSeries] = nId;
		elseif nMagicClass == 3 then
			table.insert(tbActiveSetting, nId);
		end
		
		tbMagicType2MagicClass[nMagicType] = nMagicClass;
		
		if nNewAttrib and nNewAttrib == 1 then
			tbNewAttrib[nId] = 1;
		end
		
		if nNewAttribIndex and nNewAttribIndex >= 0 then
			tbNewAttribIndex[nId] = nNewAttribIndex;
		end
	end
	
	
	local tbAttribTable = {};
	for nPhyType = 1, 2 do
		tbAttribTable[nPhyType] = tbAttribTable[nPhyType] or {};
		for nSeries = 1, Env.SERIES_NUM do
			local tbAtrrib = {};
			if tbFeatureSetting[nPhyType] and tbFeatureSetting[nPhyType][nSeries] then
				tbAtrrib = tbFeatureSetting[nPhyType][nSeries];
			end
			
			tbAtrrib = Lib:MergeTable(tbAtrrib, tbFeatureSetting[0][nSeries] or {});
			tbAtrrib = Lib:MergeTable(tbAtrrib, tbFeatureSetting[0][-1] or {});
			
			tbAttribTable[nPhyType][nSeries] = tbAttribTable[nPhyType][nSeries] or {};
			tbAttribTable[nPhyType][nSeries] = tbAtrrib;
		end
	end
	
	self.tbAttribSetting 		= tbAttribSetting;
	self.tbActiveSetting 		= tbActiveSetting;
	self.tbSpeSetting    		= tbSpeSetting;
	self.tbAttribTable 			= tbAttribTable;
	self.tbMagicType2MagicClass = tbMagicType2MagicClass;
	self.tbMagicTypeAttrib		= tbMagicTypeAttrib;
	self.tbNewAttrib			= tbNewAttrib;
	self.tbNewAttribIndex		= tbNewAttribIndex;
end

function tbFactionToken:LoadOpenHoleSettingFile()
	local szFile = "\\setting\\faction\\customfaction\\factiontoken\\openholeneed.txt";
	local tbFile = Lib:LoadTabFile(szFile);
	if not tbFile then
		print("Đọc bản thiết lập mở Tín Vật Tông Môn thất bại");
		return 0;
	end
	
	local tbOpenHoleSetting = {};
	for _, tbRow in pairs(tbFile) do
		local nLevel 			= tonumber(tbRow["Level"]);
		local nNeedPlayerLevel  = tonumber(tbRow["NeedPlayerLevel"]);
		local nNeedHouseLevel   = tonumber(tbRow["NeedHouseLevel"]);
		local nNeedItem 		= tonumber(tbRow["NeedItem"]);
		tbOpenHoleSetting[nLevel] = {nNeedPlayerLevel = nNeedPlayerLevel, nNeedHouseLevel = nNeedHouseLevel, nNeedItem = nNeedItem};
	end
	
	self.tbOpenHoleSetting = tbOpenHoleSetting;
end 

function tbFactionToken:LoadRaiseAttribSettingFile()
	local szFile = "\\setting\\faction\\customfaction\\factiontoken\\raiseattribneed.txt";
	local tbFile = Lib:LoadTabFile(szFile);
	if not tbFile then
		print("Đọc bản thiết lập thuộc tính thăng cấp Tín Vật Tông Môn thất bại");
		return 0;
	end
	
	local tbRaiseAttribSetting = {};
	for _, tbRow in pairs(tbFile) do
		local nLevel 			= tonumber(tbRow["Level"]);
		local nNeedPlayerLevel  = tonumber(tbRow["NeedPlayerLevel"]);
		local nNeedSumLevel     = tonumber(tbRow["NeedSumLevel"]);
		local nNeedItem 		= tonumber(tbRow["NeedItem"]);
		local nNeedTime			= tonumber(tbRow["NeedTime"]);
		local nNeedFactionMoney	= tonumber(tbRow["NeedFactionMoney"]);
		local nNeedFactionContribute	= tonumber(tbRow["NeedFactionContribute"]);
		
		local nNeedItemNew 			= tonumber(tbRow["NeedItemNew"]);
		local nNeedTimeNew			= tonumber(tbRow["NeedTimeNew"]);
		local nNeedFactionMoneyNew	= tonumber(tbRow["NeedFactionMoneyNew"]);
		local nNeedFactionContributeNew	= tonumber(tbRow["NeedFactionContributeNew"]);
		tbRaiseAttribSetting[nLevel] = {nNeedPlayerLevel = nNeedPlayerLevel, nNeedSumLevel = nNeedSumLevel, nNeedItem = nNeedItem, 
			nNeedTime = nNeedTime, nNeedItemNew = nNeedItemNew, nNeedTimeNew = nNeedTimeNew, 
			nNeedFactionMoney = nNeedFactionMoney, nNeedFactionMoneyNew = nNeedFactionMoneyNew,
			nNeedFactionContribute = nNeedFactionContribute, nNeedFactionContributeNew = nNeedFactionContributeNew};
	end
	
	self.tbRaiseAttribSetting = tbRaiseAttribSetting;
end 

tbFactionToken:LoadMagicAttribSettingFile();
tbFactionToken:LoadOpenHoleSettingFile();
tbFactionToken:LoadRaiseAttribSettingFile();

tbFactionToken.RAISE_PRICE = 
{
	500, 1000, 2000, 4000, 8000, 10000, 10000, 20000,
	20000, 40000,80000, 80000, 160000, 320000, 640000
};

tbFactionToken.SPEEDUP_PRICE = 
{
	500, 500, 1000, 1000, 2000, 2000, 4000, 4000, 8000, 10000
};
