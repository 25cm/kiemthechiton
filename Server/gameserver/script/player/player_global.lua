--Player全局
--GC，GS，Client共用
--sunduoliang

Require("\\script\\player\\define.lua");

function Player:_Init()
	local tbFactions = Player:LoadFactionXmlFile();
	self.tbFactions	= {};
	for nFactionId = self.FACTION_NONE, self.FACTION_NUM do
		self.tbFactions[nFactionId]	= tbFactions[nFactionId];
	end
end

-- 获得门派路线名
--	如果nRouteId为0或省略，则返回门派名，否则返回路线名
function Player:GetFactionRouteName(nFactionId, nRouteId)
	local tbFaction	= self.tbFactions[nFactionId];
	local tbRoute	= tbFaction.tbRoutes[nRouteId or 0];
	return (tbRoute or tbFaction).szName;
end

function Player:LoadFactionXmlFile()
	local tbCamp = {
		["Tân Thủ"] = 0,
		["Chính Phái"] = 1,
		["Tà Phái"] = 2,
		["Trung Lập"] = 3,
	}
	local tbFactionsXml = KFile.LoadXmlFile("\\setting\\faction\\faction.xml").children;
	local tbFactions = {};
	for _, tbFaction in pairs(tbFactionsXml) do
		local nFactionId = tonumber(tbFaction.attrib.id) or 0;
		tbFactions[nFactionId] = {};
		tbFactions[nFactionId].nId = nFactionId;
		
		tbFactions[nFactionId].szName = tbFaction.attrib.name or "";					--门派名
		tbFactions[nFactionId].nSeries = tonumber(tbFaction.attrib.series) or 0; 	--门派五行Id
		tbFactions[nFactionId].szCamp = tbFaction.attrib.camp or "";		 			--门派阵营描述
		tbFactions[nFactionId].nSexLimit = tonumber(tbFaction.attrib.sexlimit) or 0;	--门派性别属性
		tbFactions[nFactionId].nCamp = 0;
		if tbCamp[tbFactions[nFactionId].szCamp] then
			tbFactions[nFactionId].nCamp = tbCamp[tbFactions[nFactionId].szCamp];
		end
		tbFactions[nFactionId].tbRoutes = {};
		tbFactions[nFactionId].tbRoutes.n = 0;
		if tbFaction.children and type(tbFaction.children) == "table" then
			for  _, tbRoute in pairs(tbFaction.children) do
				local nRouteId = tonumber(tbRoute.attrib.id) or 0;
				if nRouteId > 0 then
					tbFactions[nFactionId].tbRoutes.n = tbFactions[nFactionId].tbRoutes.n + 1;
				end
				local tbRouteTmp = {};
				tbFactions[nFactionId].tbRoutes[nRouteId] = tbRouteTmp;
				tbRouteTmp.nId = nRouteId;
				tbRouteTmp.szName = tbRoute.attrib.name or "";					--门派名
				tbRouteTmp.szDesc = tbRoute.attrib.desc or "";					--门派名
				tbRouteTmp.tbSkills = {};
				if tbRoute.children and type(tbRoute.children) == "table" then
					for  _, tbSkill in pairs(tbRoute.children) do
						local nSkillId = tonumber(tbSkill.attrib.id) or 0;
						local szName = tbSkill.attrib.name or "";
						table.insert(tbRouteTmp.tbSkills, {nId = nSkillId, szName = szName});
					end
				end
			end
		end
	end
	return tbFactions;
end

Player:_Init();