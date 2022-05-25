
function ServerEvent:LoadServerList()
	local tbLoadIntTab = {
		["GlobalWldh"] = 1,
		};
	self.tbServerListCfg = {
		tbNameList={};
		tbGateList={};
		tbGateCount={};
		tbIndex={};
		};
	local tbNameList = self.tbServerListCfg.tbNameList;
	local tbGateList = self.tbServerListCfg.tbGateList; 
	local tbGateCount = self.tbServerListCfg.tbGateCount;
	local tbIndex	= self.tbServerListCfg.tbIndex;
	
	local tbServerNameLists = {}; 
	local tbFile = Lib:LoadTabFile("\\setting\\serverlistcfg.txt")
	for _, tbTemp in ipairs(tbFile) do
		tbNameList[tbTemp.ZoneName] = tbNameList[tbTemp.ZoneName] or {};
		tbNameList[tbTemp.ZoneName][tbTemp.ServerName] = tbNameList[tbTemp.ZoneName][tbTemp.ServerName] or tbTemp.GatewayId;
		tbGateCount[tbTemp.ZoneName] = tbGateCount[tbTemp.ZoneName] or 0;
		
		tbServerNameLists[tbTemp.GatewayId] = tbServerNameLists[tbTemp.GatewayId] or {};
		if tonumber(tbTemp.MainServer) == 1 then
			table.insert(tbServerNameLists[tbTemp.GatewayId], 1, tbTemp.ServerName);
		else
			table.insert(tbServerNameLists[tbTemp.GatewayId], tbTemp.ServerName);
		end
		
		if tonumber(tbTemp.MainServer) == 1 then
			if tbGateList[tbTemp.GatewayId] then
				print("stack traceback", "setting\\servernamecfg.txt Error", "Have More 2 ServerMain", tbTemp.GatewayId);				
			end
			tbGateList[tbTemp.GatewayId] = tbGateList[tbTemp.GatewayId] or {};
			tbGateList[tbTemp.GatewayId].ZoneId = tbTemp.ZoneId;
			tbGateList[tbTemp.GatewayId].ZoneName = tbTemp.ZoneName;			
			tbGateList[tbTemp.GatewayId].ServerName = tbTemp.ServerName;
			tbGateList[tbTemp.GatewayId].tbAllServerName = tbServerNameLists[tbTemp.GatewayId];
			
			for szCom in pairs(tbLoadIntTab) do
				tbGateList[tbTemp.GatewayId][szCom] = tonumber(tbTemp[szCom]) or 0;
			end
			tbGateCount[tbTemp.ZoneName] = tbGateCount[tbTemp.ZoneName] + 1;
		end
	end
	
	for szZone, tbServer in pairs(tbNameList) do
		local nTransferId = 0;
		local tbTempGateList = {};
		for szServer, szGateWay in pairs(tbServer) do
			if not tbGateList[szGateWay] then
				print("stack traceback", "setting\\servernamecfg.txt Error", "Not ServerMain", szGateWay);
			end
			if tbGateList[szGateWay] and not tbTempGateList[szGateWay] then
				tbTempGateList[szGateWay] = 1;
				nTransferId = nTransferId + 1;
				tbGateList[szGateWay].nTransferId = nTransferId;
				tbIndex[szZone] = tbIndex[szZone] or {};
				tbIndex[szZone][nTransferId] = szGateWay;
				if nTransferId > 14 then
					print("stack traceback", "setting\\servernamecfg.txt Error", "Not GlobalMapId", nTransferId);
				end
			end
		end
	end
	return 1;
end

function ServerEvent:GetServerNameList()
	return self.tbServerListCfg.tbNameList;
end

function ServerEvent:GetServerGateList()
	return self.tbServerListCfg.tbGateList;
end

function ServerEvent:GetServerInforByGateway(szGateway)
	return self.tbServerListCfg.tbGateList[szGateway];
end

function ServerEvent:GetServerNameByGateway(szGateway)
	local tbInfo = self.tbServerListCfg.tbGateList[szGateway];
	if not tbInfo then
		return "Chưa biết";
	end
	return tbInfo.ServerName;
end

function ServerEvent:GetMyServerInforByGateway()
	local szGateway = GetGatewayName();
	return ServerEvent:GetServerInforByGateway(szGateway);
end

function ServerEvent:GetMyZoneServerCount()
	local szGateway = GetGatewayName();
	local tbGate = self.tbServerListCfg.tbGateList[szGateway];
	return self.tbServerListCfg.tbGateCount[tbGate.ZoneName] or 0;
end

function ServerEvent:GetZoneServerCount(szGateway)
	local tbGate = self.tbServerListCfg.tbGateList[szGateway];
	if not tbGate or not tbGate.ZoneName then
		return 0;
	end
	return self.tbServerListCfg.tbGateCount[tbGate.ZoneName] or 0;
end


function ServerEvent:GetMyServerListIndex()
	local tbGate = self:GetMyServerInforByGateway();
	return self.tbServerListCfg.tbIndex[tbGate.ZoneName];
end

ServerEvent:LoadServerList();
