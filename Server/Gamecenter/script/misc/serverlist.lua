-- 文件名　：serverlist.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-12-03 11:38:13
-- 描  述  ：加载服务器表

function ServerEvent:LoadServerList()
	--区服表读取列
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
	
	--检查并服后是否没有主服的区服
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

--获得区服名称表
--返回表格式:
--tb = { 
--	["青龙区"] = {
--		["永乐镇"] = "gate0103",
--		...
--	},
--	...
--}
function ServerEvent:GetServerNameList()
	return self.tbServerListCfg.tbNameList;
end

function ServerEvent:GetServerGateList()
	return self.tbServerListCfg.tbGateList;
end

--获得区服信息表
--返回表格式:
--tb = { 
--	ZoneName="青龙区",
--	ServerName="永乐镇",
--	tbServerName={"永乐镇"}, --合区表，第一个为主服
--	GlobalWldh=1,
--  nTransferId=1,
--}
function ServerEvent:GetServerInforByGateway(szGateway)
	return self.tbServerListCfg.tbGateList[szGateway];
end

--获得自己所在区服信息表
function ServerEvent:GetMyServerInforByGateway()
	local szGateway = GetGatewayName();
	return ServerEvent:GetServerInforByGateway(szGateway);
end

--获得自己所在大区的区服数量
function ServerEvent:GetMyZoneServerCount()
	local szGateway = GetGatewayName();
	local tbGate = self.tbServerListCfg.tbGateList[szGateway];
	return self.tbServerListCfg.tbGateCount[tbGate.ZoneName] or 0;
end

--获得自己所在大区的区服数量
function ServerEvent:GetZoneServerCount(szGateway)
	local tbGate = self.tbServerListCfg.tbGateList[szGateway];
	return self.tbServerListCfg.tbGateCount[tbGate.ZoneName] or 0;
end


--获得自己所在大区的所有区服nTransferId索引表
function ServerEvent:GetMyServerListIndex()
	local tbGate = self:GetMyServerInforByGateway();
	return self.tbServerListCfg.tbIndex[tbGate.ZoneName];
end

ServerEvent:LoadServerList();
