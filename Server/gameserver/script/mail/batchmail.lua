-- 批量发邮件

local BatchMail	= Mail.BatchMail or {};
Mail.BatchMail	= BatchMail;

BatchMail.TIME_TIMEOUT	= 3600*24*7;	-- 对账号发邮件，7天不上线则过期

-- 读取列表文件
function BatchMail:ReadList(szDataPath, szTitle, szContent)
	local nMyTypeId		= Env:GetZoneType(GetGatewayName());
	local tbData		= Lib:LoadTabFile(szDataPath);
	local tbNameList	= {};
	local tbAccountList	= {};
	local nAccountCount	= 0;
	for _, tbRow in ipairs(tbData) do
		local szRoleName	= tbRow.RoleName;
		if (szRoleName and szRoleName ~= "") then	-- by Name
			local nPlayerId	= KGCPlayer.GetPlayerIdByName(szRoleName);
			if (nPlayerId and nMyTypeId == Env:GetZoneType(tbRow.GatewayID)) then
				tbNameList[#tbNameList+1]	= szRoleName;
			end
		else										-- by Account
			tbAccountList[tbRow.Account]	= 1;
			nAccountCount	= nAccountCount + 1;
		end
	end
	
	if (nAccountCount > 0) then
		self.tbProcessList	= {
			tbAccountList	= tbAccountList,
			szTitle			= szTitle,
			szContent		= szContent,
			nStartTime		= GetTime(),
		};
		
		if (MODULE_GC_SERVER) then
			self:SaveData();
			GlobalExcute({"Mail.BatchMail:ReadList", "\\..\\gamecenter"..szDataPath, szTitle, szContent});
		end
	end
	
	if (MODULE_GC_SERVER and #tbNameList > 0) then
		Mail.tbParticularMail:SendMail(tbNameList, {szTitle=szTitle, szContent=szContent});
	end
	
	if (MODULE_GAMESERVER) then
		for _, pPlayer in pairs(KPlayer.GetAllPlayer()) do
			self:ProcessPlayer(pPlayer);
		end
	end
	
	return #tbNameList .. " + " .. nAccountCount;
end

-- 检查过期（只能在GS未连接时使用）
function BatchMail:CheckOverdue()
	if (self.tbProcessList.nStartTime and GetTime() > self.tbProcessList.nStartTime + self.TIME_TIMEOUT) then
		self:ScriptLogF("ProcessList Overdue!");
		self.tbProcessList	= {};
		self:SaveData();
	end
end

-- 存档
function BatchMail:SaveData()
	local tbAccount		= {};
	local tbProcessList	= self.tbProcessList;
	local tbSaveData	= {tbAccount, tbProcessList.szTitle, tbProcessList.szContent, tbProcessList.nStartTime};
	for szAccount in pairs(tbProcessList.tbAccountList or {}) do
		tbAccount[#tbAccount + 1]	= szAccount;
	end
	SetGblIntBuf(GBLINTBUF_MAIL_LIST, 0, 1, tbSaveData);
end

-- 读档
function BatchMail:LoadData()
	local tbSaveData	= GetGblIntBuf(GBLINTBUF_MAIL_LIST, 0, 1);
	if (type(tbSaveData) ~= "table") then
		tbSaveData	= {};
	end
	
	local tbAccountList	= {};
	
	for _, szAccount in ipairs(tbSaveData[1] or {}) do
		tbAccountList[szAccount]	= 1;
	end
	
	self.tbProcessList	= {
		tbAccountList	= tbAccountList;
		szTitle			= tbSaveData[2];
		szContent		= tbSaveData[3];
		nStartTime		= tbSaveData[4];
	};
end

-- 服务器启动
function BatchMail:OnServerStart()
	self:LoadData();
	if (MODULE_GC_SERVER) then
		self:CheckOverdue();
	end
end

-- 玩家登入
function BatchMail:OnLogin()
	self:ProcessPlayer(me);
end

-- GC发送邮件
function BatchMail:GCProcess(szAccount, szName)
	Mail.tbParticularMail:SendMail({szName}, self.tbProcessList);
	self:ScriptLogF("[%s](%s)ProcessList OK!", szAccount, szName);
end

-- 检查玩家是否有操作需要处理，并执行
function BatchMail:ProcessPlayer(pPlayer)
	if (not self.tbProcessList.tbAccountList[pPlayer.szAccount]) then
		return 0;
	end
	
	if (pPlayer.nLastSaveTime > self.tbProcessList.nStartTime) then
		return 0;
	end
	
	GCExcute({"Mail.BatchMail:GCProcess", pPlayer.szAccount, pPlayer.szName});
	
	return 1;
end

-- 调试输出
function BatchMail:DebugShow()
	local tbProcessList	= self.tbProcessList;
	local nCount	= 0;
	print("[BatchMail]", os.date("%Y-%m-%d %H:%M:%S", tbProcessList.nStartTime or 0), tbProcessList.szTitle, tbProcessList.szContent);
	for szAccount in pairs(self.tbProcessList.tbAccountList or {}) do
		nCount	= nCount + 1;
		print("[BatchMail]", szAccount);
	end
	print("[BatchMailCount]", nCount);
	if (MODULE_GC_SERVER) then
		GlobalExcute({"Mail.BatchMail:DebugShow", szName});
	end
end

-- 写脚本日志
function BatchMail:ScriptLogF(...)
	local szMsg	= string.format(unpack(arg));
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Mail", "BatchMail", szMsg);
end

-- 各种回调注册
if (not BatchMail.bReged) then
	-- Server Start
	local function fnServerStart()
		BatchMail:OnServerStart();
	end
	-- Player Login
	local function fnOnLogin()
		BatchMail:OnLogin();
	end

	if (MODULE_GAMESERVER) then
		PlayerEvent:RegisterOnLoginEvent(fnOnLogin);
		ServerEvent:RegisterServerStartFunc(fnServerStart);
	end
	
	if (MODULE_GC_SERVER) then
		GCEvent:RegisterGCServerStartFunc(fnServerStart);
	end
	
	BatchMail.bReged	= 1;
end

--?gc Mail.BatchMail:DebugShow()
--?gc print("Send:", Mail.BatchMail:ReadList("\\playerlist.txt", "标题", "内容"))
