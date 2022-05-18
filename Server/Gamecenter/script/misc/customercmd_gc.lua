-------------------------------------------------------------------
--File: customercmd_gc.lua
--Author: zouying
--Date: 2009-4-22 21:08
--Describe: 客服平台发送过来脚本处理
-------------------------------------------------------------------

GmCmd.tbgmc2gcFun = { };


function GmCmd:InitParam(nSession, nAsk)
	if (nSession ~= 0) then
		self.nSession = nSession;
		self.nAsker    = nAsk;
	else
		self.nSession = 0;
		self.nAsker  = 0;
	end
	self.nAction   = 0;
end

function GmCmd:PCall(fnCall, szMsg)
	if (not fnCall) then
		print(szMsg);
		return 0, szMsg;
	end
	
	local function fnShowStack(s)
		local szMsg	= debug.traceback(s,2);
		print(szMsg);
		return szMsg;
	end
	
	local tbRet	= {xpcall(fnCall, fnShowStack)};
	local nMax	= table.maxn(tbRet);
	local szRet;
	if (nMax >= 2) then
		szRet	= tostring(tbRet[2]);
		for i = 3, nMax do
			szRet	= szRet .. "\t" .. tostring(tbRet[i]);
		end
	end
	
	return (tbRet[1] and 1) or 0, szRet;
end

function GmCmd:DoAdvCmd(szCmd, nAction)
	-- nAction暂时未用，详情见C代码注释
	return self:PCall(loadstring(szCmd));
end

function GmCmd:DoExecuteCmd(szCmdKey, nSession, nAsker, szName,  szData)
	if (type(szCmdKey) ~= "string") then
		return 0;
	end
	
	local fun = self.tbgmc2gcFun[szCmdKey];
	if (not fun) then
		print("Wrong GM Commod ", szCmdKey);
		return 0;
	end
	if type(fun) ~= "function" then
		return 0;
	end
	self:InitParam(nSession, nAsker);
	local bRet, szResult = fun(GmCmd, szName,  szData);
	
	if (bRet) then
		self:ReportCmdResult(self.nSession, 0, self.nAsker, bRet, szResult);
	end
	return 1;
end

function GmCmd:ReportCmdResult(nSession, nAction, nAsker, bRet, szResult)
	_G.ReportGmCmdResult(nSession, nAction, nAsker, bRet, szResult or "");
end

function GmCmd:PrivateChatToPlayer(szName, szData)
	self.nAction = 0;
	local nFirst, nEnd = string.find(szData, "-");
	if (not nFirst or not nEnd) then
		return 0;
	end
	local szMsg = string.sub(szData, nEnd + 1);
	if (not szMsg or szMsg == "") then
		return 0;
	end
	_G.ChatToPlayer(szName, szMsg, "Hệ thống dịch vụ khách hàng");
	return 1;
end
GmCmd.tbgmc2gcFun["CHATTOROLE"] = GmCmd.PrivateChatToPlayer;

function GmCmd:KickOutRole(szName, szData)
	_G.GlobalGCExcute(-1, {"GmCmd:_GB_KickOut",  self.nSession, self.nAsker, szName});
	DelApplyGBExchangeRecord(szName);
	_G.GlobalExcute({"GmCmd:KickOut", "GmCmd:ReportCmdResult", self.nSession, self.nAsker, szName});
end
GmCmd.tbgmc2gcFun["KICKROEL"] = GmCmd.KickOutRole;

function GmCmd:_GB_KickOut(nSession, nAsker, szName)
	return _G.GlobalExcute{"GmCmd:KickOut", "GmCmd:_GB_KickOutCallBack", nSession, nAsker, szName, _G.GCEvent.nGBGCExcuteFromId}
end

function GmCmd:_GB_KickOutCallBack(nSession, nUnKnow, nAsker, bRet, nConnectId)
	return _G.GlobalGCExcute(nConnectId, {"GmCmd:ReportCmdResult", nSession, nUnKnow, nAsker, bRet});
end

function GmCmd:TrapRole(szName, szData)
	local strStart = GetLocalDate("%Y%m%d%H%M");
	local szScript = "Player:Arrest(\""..szName .."\")";
	local nTime = 0;
	for w in string.gmatch(szData, "%d+") do
		nTime = tonumber(w) * 60;
	end
	
	if (nTime and nTime > 0) then
		szScript = szScript .. ";me.SetTask("..self.TASK_CUSTOMER_ID..","..self.SUBTASKID_FREEPRISON..",GetTime()+"..nTime..")";
	end
	local szRet = GM:AddOnLine(GetGatewayName(), "", szName, strStart, 0, szScript);
	local nResult = 0;
	if (type(szRet) == "number" and szRet ~= 0) then
		nResult = 1;
	else
		nResult = 0;
	end
	return nResult;
end
GmCmd.tbgmc2gcFun["TRAPROLE"] = GmCmd.TrapRole;

function GmCmd:UnTrapRole(szName)
	local strStart = GetLocalDate("%Y%m%d%H%M");
	local szScript = "Player:SetFree(\""..szName .."\")";
	local szRet = GM:AddOnLine(GetGatewayName(), "", szName, strStart, 0, szScript);
	local nResult = 0;
	if (type(szRet) == "number" and szRet ~= 0) then
		nResult = 1;
	end
	return nResult;
end
GmCmd.tbgmc2gcFun["UNTRAPROLE"] = GmCmd.UnTrapRole;


function GmCmd:PlayerFly(szName, szData)
	local tbMapInfo = {};
	local nIndex = 1;
	if not szData then
		for w in string.gmatch(szData, "%d+") do
			tbMapInfo[nIndex] = tonumber(w);
			nIndex = nIndex + 1;
		end
		if (nIndex ~= 3)then
			return 0;
		end
	else
		tbMapInfo[1] = 1
		tbMapInfo[2] = 1389
		tbMapInfo[3] = 3102
	end
	local strStart = os.date("%Y%m%d%H%M");
	local szScript = "me.NewWorld("..tbMapInfo[1]  .. ',' .. tbMapInfo[2] .. ',' .. tbMapInfo[3]..")";
	local szRet = GM:AddOnLine(GetGatewayName(), "", szName, strStart, 0, szScript);
	local nResult = 0;
	if (type(szRet) == "number" and szRet ~= 0) then
		nResult = 1;
	end
	return nResult;
end

GmCmd.tbgmc2gcFun["PLAYERFLY"] = GmCmd.PlayerFly;


function GmCmd:SendMailToPlayer(szName, szData)
	
	local nFirst, nEnd = string.find(szData, "CAPTION:");
	local nFirst2, nEnd2 = string.find(szData, " CONTENT:");
	if (not nFirst or not nEnd or not nFirst2 or nFirst2 <= nEnd) then
		return 0;
	end
	local szCaption = string.sub(szData, nEnd + 1, nFirst2);
	if (not szCaption) then
		return 0;
	end
	szCaption = (szCaption == ""  and "Hệ thống dịch vụ khách hàng"  or szCaption);
	local szContent = string.sub(szData, nEnd2 + 1);
	return _G.SendMailGC(szName, szCaption, szContent);
end
GmCmd.tbgmc2gcFun["SENDMAIL"] = GmCmd.SendMailToPlayer;

function GmCmd:ZoneMessage(szName, szData)
	if (not szData) then
		return 0;
	end	
	local nStart, nEnd = string.find(szData, "T_DATA-");
	local szContent = szData.sub(nEnd + 3);
	GlobalExcute({"KDialog.Msg2SubWorld", szContent});
	return 1;
end
GmCmd.tbgmc2gcFun["ZONEMSG"] = GmCmd.ZoneMessage;

function GmCmd:ZoneAnnounce(szName, szData)
	if (not szName or not szData) then
		return 0;
	end
	local nStart, nEnd = string.find(szData, "T_DATA-");
	local szContent = szData.sub(nEnd + 3);
	szContent = szName .. ":" ..szContent;
	_G.GlobalExcute({"KDialog.NewsMsg", 0, 0, szContent});
	return 1;
end
GmCmd.tbgmc2gcFun["ZONEANN"] = GmCmd.ZoneAnnounce;

-- 禁言
function GmCmd:FobirtRoleChat(szName, szData)
	local nResult = 0;
	local strStart = GetLocalDate("%Y%m%d%H%M");
	local szScript = "me.SetForbidChat(1)";
	local nTime = 0;
	for w in string.gmatch(szData, "%d+") do
		nTime = tonumber(w) * 60;
	end
	if (nTime and nTime > 0) then
		szScript = szScript .. ";me.SetTask("..self.TASK_CUSTOMER_ID..","..self.SUBTASKID_UNBANCHAT..",  GetTime() + "..nTime.. ")";
	end
	local szRet = GM:AddOnLine(GetGatewayName(), "", szName, strStart, 0, szScript);
	if (type(szRet) == "number" and szRet ~= 0) then
		nResult = 1;
	else
		nResult = 0;
	end
	return nResult;
end
GmCmd.tbgmc2gcFun["BANCHAT"] = GmCmd.FobirtRoleChat;

-- 解除禁言
function GmCmd:UnFobirtRoleChat(szName)
	local strStart = GetLocalDate("%Y%m%d%H%M");
	local szScript = "me.SetForbidChat(0)";
	local szRet = GM:AddOnLine(GetGatewayName(), "", szName, strStart, 0, szScript);
	local nResult = 0;
	if (type(szRet) == "number" and szRet ~= 0) then
		nResult = 1;
	end
	return nResult;
end
GmCmd.tbgmc2gcFun["UNBANCHAT"] = GmCmd.UnFobirtRoleChat;
