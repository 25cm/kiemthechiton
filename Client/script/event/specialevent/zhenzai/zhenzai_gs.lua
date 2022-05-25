	-- 文件名　：zhenzai_gs.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-04-15 17:01:37
-- 描  述  ：赈灾gs

if  not MODULE_GAMESERVER then
	return;
end
Require("\\script\\event\\specialevent\\ZhenZai\\ZhenZai_def.lua");
SpecialEvent.ZhenZai = SpecialEvent.ZhenZai or {};
local ZhenZai = SpecialEvent.ZhenZai or {};

--永乐镇增加许愿树
function ZhenZai:AddVowTree()
	if SubWorldID2Idx(ZhenZai.tbVowTreePosition[1]) >= 0 then	
		 if ZhenZai.nVowTreenId == 0 then			--没有加载过许愿树，add许愿树
	 		local pNpc = KNpc.Add2(ZhenZai.nVowTreeTemplId, 100, -1, ZhenZai.tbVowTreePosition[1], ZhenZai.tbVowTreePosition[2], ZhenZai.tbVowTreePosition[3]);
	 		if pNpc then
		 		ZhenZai.nVowTreenId = pNpc.dwId;
		 		pNpc.SetTitle("<color=green>风调雨顺国泰民安<color>");
		 	end
		end
		Dialog:GlobalNewsMsg_GS("许愿佛已经安放，大家带着<color=yellow>希望之水<color>快去为灾区送上自己的一份心意吧！");
	end
end

--删除许愿树
function ZhenZai.DeleteVowTree()
	if SubWorldID2Idx(ZhenZai.tbVowTreePosition[1]) >= 0 then
		if ZhenZai.nVowTreenId and ZhenZai.nVowTreenId ~= 0 then	--加载过许愿树
			local pNpc = KNpc.GetById(ZhenZai.nVowTreenId);
			if pNpc then
				pNpc.Delete();
				ZhenZai.nVowTreenId = 0;
			end			
		end
	end
end

--活动期间内服务器维护或者宕机启动，重新加载npc
function ZhenZai:ServerStartFunc()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData >= self.VowTreeOpenTime and nData <= self.VowTreeCloseTime then	--活动期间内启动服务器
		ZhenZai:AddVowTree();
	end
end

ServerEvent:RegisterServerStartFunc(ZhenZai.ServerStartFunc, ZhenZai);
