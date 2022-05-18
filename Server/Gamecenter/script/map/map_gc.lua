-- 文件名　：map_gc.lua
-- 创建者　：furuilei
-- 创建时间：2009-02-13 17:48:40

if MODULE_GC_SERVER then
	
Map.tbGCDynamicForbiden = { };
local tbGCDynamicForbiden = Map.tbGCDynamicForbiden;

function Map:LogMapPlayerCount()
	GlobalExcute{"Map:LogMapPlayerCount_GS"};
end

--动态注册地图禁用，成功返回1
function Map:GCRegisterForbiden(nMapId, szItemClass)
	if (tbGCDynamicForbiden[nMapId] == nil) then
		tbGCDynamicForbiden[nMapId] = { };
	end
	tbGCDynamicForbiden[nMapId][szItemClass] = 1;
	GlobalExcute({"Map:OnRegisterForbiden", nMapId, szItemClass});
	return 1;
end

--动态反注册地图禁用，成功返回1
function Map:GCUnregisterForbiden(nMapId, szItemClass)
	if (tbGCDynamicForbiden[nMapId] == nil) then
		return 0;
	end
	if (tbGCDynamicForbiden[nMapId][szItemClass] == nil) then
		return 0;
	end
	tbGCDynamicForbiden[nMapId][szItemClass] = nil;
	GlobalExcute({"Map:OnUnregisterForbiden", nMapId, szItemClass});
	return 1;
end

function Map:GCUpdateForbidenInfo()
	GlobalExcute({"Map:OnUpdateForbidenInfo", tbGCDynamicForbiden});
end




 

end
