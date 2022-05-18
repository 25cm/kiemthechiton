-------------------------------------------------------------------
--File: mappedgmcmd_gc.lua
--Author: zouying
--Date: 2009-07-06 21:08
--Describe: eyes发送过来的key执行gmcmd
-------------------------------------------------------------------

GmCmd.tbCompensateTaskId = {};	--存储已执行过的补偿任务结果，key为taskId,value为执行结果
GmCmd.tbEyesKey2GcFun = {
	["TEST"]					= {},										--测试
	["LoadScript"]				= {},										--指令
	["GetGCPlayerBaseInfo"]		= {},										--获得角色数据
	["GetKinInfo"]				= {},										--获得家族数据
	["GetTongInfo"]				= {},										--获得帮会数据
	["QueryKinTongOfRole"]		= {},										--获得角色家族和帮会
	["QueryServerInfo"]			= {},										--查询服务器信息
--	["CompensateToRole"]		= {"szRoleName", "tbItem", "nTimeLimit",	
--		"nNum", "nBind", "nMoney", "nBindMoney", "nBindCoin", "szDesc", "taskId"},--角色补偿(关闭该功能，使用文件模式)
	["SendMail"]				= {},										--发邮件
	["OpenIBReturn"]			= {"S", "E", "nType"},						--金币消费返还
	["LoadKingEyesEventFile"]	= {},										--加载在线运营活动
	["GetWareSaleStatus"]		= {},										--奇珍阁查看哪些物品被强制下架了
	["CancelWareSaleStatus"]	= {};										--奇珍阁强制下架
	["AddWareSaleStatus"]		= {};										--奇珍阁恢复上架
	["CompensateToRoleFile"]	= {"szPath", "nTaskId"},					--通过文件给角色补偿
	["GetKingEyesEvent"]		= {},										--获得开启的存档活动
	["CloseKingEyesEvent"]		= {"nEventId", "nPartId"},					--关闭某个活动
	["LoadIllegalListFile"]		= {"szPath", "szIndex"},					--通过文件非法物品扣除
	["BatchArrest"]				= {"szDataPath", "bArrest"},				--批量关天牢
	["BatchMail"]				= {"szDataPath", "szTitle", "szContent"},	--批量发邮件
	["GetVipTransData"]			= {};										--获取Vip转服数据
	["SetVipTransData"]			= {};										--设置Vip转服数据
	["LoadQuestFile"]			= {"szPath", "szPlayerListPath"},			--加载调查问卷（通过名单）
	["Openbaihutang"]			= {"S", "E", "nCount"},						--白虎堂双倍
	["Openbattle"]				= {"S", "E", "nCount"},						--战场双倍
	["QueryKinPlayerInfo"]		= {"szName"},								--查询家族成员		
	["QueryMarryInfo"]			= {},										--查询结婚列表
	["QueryWllsLeagueForLName"]	= {"szLeagueName", "nDate"},				--查询联赛战队信息（通过战队名）
	["QueryWllsLeagueForMName"]	= {"szMemberName", "nDate"},				--查询联赛战队信息（通过成员名）
	["QueryIbshopBuffInfo"]		= {},										--查询奇珍阁在线指令的buff
	["SetAllIbWareDiscount"]	= {"nNeedCurrencyType", "nDiscount", "szStartTime", "szEndTime"},--设置所有奇珍阁商品打折
	["SetOneIbWareDisCount"]	= {"nWareId", "nDiscount", "szStartTime", "szEndTime"},			 --设置一个奇珍阁商品打折
	["UpGoods"]					= {"nWareId", "szSellStartDate", "szSellEndTime", "nTimeFrame"},				--对单个商品上架
	["DownGoods"]				= {},										--对单个商品下架
	["ClearIbshopBuff"]			= {},										--清除在线指令的buff
	["QueryCompensateByName"]	= {"szName"},								--查询补偿信息
	["ClearCompensateByName"]	= {"szName", "nLogId"},						--清除补偿
	["SetIbShopGoodsNewUp"]		= {},										--设置商品在新品上架中（维持一个月，未上架物品将直接上架，受时间轴影响商品仍然有效）
	["QueryJBExchangeRate"]		= {},										--查询金币交易所汇率	
	["SetOneIbWarePrice"]		= {"nWareId", "nPrice"},--设置一个奇珍阁商品价格
	["LoadPresendCardFile"]		= {},										--定制礼包执行文件		
	["DelPresendCardBuf"]		= {},										--删除礼包
	["QueryPresendCardBuf"]		= {},										--定制礼包查询
};

function GmCmd:DoMappedExeCmd(szCmdKey, szData)
	if (type(szCmdKey) ~= "string") then
		return 0, "the cmdkey is not string";
	end
	
	local tbParamDef = self.tbEyesKey2GcFun[szCmdKey];
	if (not tbParamDef) then
		print("Wrong Key To Mapped Commod ", szCmdKey);
		return 0, "There is not the function of the key " .. szCmdKey;
	end
	
	local fnCmdFunc		= self[szCmdKey];
	if type(fnCmdFunc) ~= "function" then
		return 0, "it does not find function " .. szCmdKey;
	end
	
	local varData	= szData;
	if (tbParamDef[1]) then	-- 有参数定义
		-- TODO: 这里对平台发来的字符串直接loadstring！！！
		local fnGetTb, szErrorMsg	= loadstring("return "..szData);
		if (not fnGetTb) then
			return 0, szErrorMsg;
		end
		
		varData	= fnGetTb();	
		-- 参数检查
		if (type(varData) ~= "table") then
			return "Param format error! Table expected!";
		end
		for _, szParamDef in ipairs(tbParamDef) do
			if (not varData[szParamDef]) then
				return "Param ["..szParamDef.."] is missing!"
			end
		end
	end
	
	local function fnCall()
		return fnCmdFunc(self, varData);
	end
	
	return self:PCall(fnCall);
end

function GmCmd:TEST(szData)
	print('hello world!!!!')
	return "test OK"
end

function GmCmd:LoadScript(szFile)
	print('LoadScript:', szFile);
	
	local szFileData	= KFile.ReadTxtFile(szFile);
	if (not szFileData) then
		local szMsg	= string.format("cannot read file (%s)!", szFile);
		return 0, szMsg;
	end
	
	return assert(loadstring(szFileData, "@" .. szFile))();
end

-- 【查询玩家基本信息】
function GmCmd:GetGCPlayerBaseInfo(szName)
	local nPlayerId	= KGCPlayer.GetPlayerIdByName(szName);
	if (not nPlayerId) then
		return "nil";
	end
	local tbInfo	= GetPlayerInfoForLadderGC(szName);
	local tbText	= {
		{"Tên người chơi", szName},
		{"Tài khoản", tbInfo.szAccount},
		{"Cấp", tbInfo.nLevel},
		{"Giới tính", (tbInfo.nSex == 1 and "Nữ") or "Nam"},
		{"Phái", Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute)},
		{"Gia tộc", tbInfo.szKinName},
		{"Bang hội", tbInfo.szTongName},
		{"Uy danh giang hồ", KGCPlayer.GetPlayerPrestige(nPlayerId)},
		{"Thời gian rời tộc", os.date("%Y-%m-%d %H:%M:%S", KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_LEAVE_KIN_TIME))},
		{"Online GameserverID", KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER)},
		{"Tài sản", KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_TONGSTOCK)},
		{"Đánh giá xếp hạng", KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_OFFICIAL_LEVEL)},
	}
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n" .. tb[1] .. "\t" .. tostring(tb[2]);
	end
	return szMsg;
end

-- 【查询家族信息】
function GmCmd:GetKinInfo(szName)
	local pKin, nKinId	= KKin.FindKin(szName);
	if (not pKin) then
		return "nil";
	end
	local nAssId = pKin.GetAssistant() or 0;
	local szAssName = "nil";
	if nAssId > 0 then
		szAssName = pKin.GetMemberName(nAssId);
	end
	local tbWeeklyAction = { "Bạch Hổ Đường", "Chiến trường Tống Kim", "Nhiệm vụ truy nã", "Vạn Hoa Cốc", "Phó bản quân doanh", };
	local nRegular, nSigned, nRetire, nCaptain, nAssistant	= pKin.GetMemberCount();
	local pTong = KTong.GetTong(pKin.GetBelongTong());
	local tbText	= {
		{"Tên gia tộc", pKin.GetName()},
		{"Thuộc bang hội", (pTong and pTong.GetName()) or "nil"},
		{"Tộc trưởng", pKin.GetMemberName(pKin.GetCaptain())},
		{"Tộc phó", szAssName},
		{"Thời gian tạo", os.date("%Y-%m-%d %H:%M:%S", pKin.GetCreateTime())},
		{"Thời gian thoát khỏi bang", os.date("%Y-%m-%d %H:%M:%S", pKin.GetApplyQuitTime())},
		{"Số lượng thành viên", nRegular},
		{"Thành viên vô danh", nSigned},
		{"Thành viên danh dự", nRetire},
		{"Mục tiêu tuần gia tộc", tbWeeklyAction[pKin.GetWeeklyTask()]},
		{"Cống hiến gia tộc tuần", pKin.GetWeeklyKinOffer()},
		{"Mục tiêu tuần trước", tbWeeklyAction[pKin.GetLastWeeklyTask()]},
		{"Cống hiến tuần trước", pKin.GetLastWeekKinOffer()},
		{"Điểm hoạt động gia tộc", pKin.GetHundredKinScore()},
		{"ID Gia tộc",	nKinId or 0},
		{"ID Bang hội",	pKin.GetBelongTong() or 0},
	};
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n" .. tb[1] .. "\t" .. tostring(tb[2]);
	end
	return szMsg;
end

-- 【查询帮会信息】
function GmCmd:GetTongInfo(szName)
	local pTong, nTongId	= KTong.FindTong(szName);
	if (not pTong) then
		return "nil";
	end
	local tbKin	= {};
	local pKinIt	= pTong.GetKinItor();
	local nKinId 	= pKinIt.GetCurKinId();
	while nKinId > 0 do
		local pKin 	= KKin.GetKin(nKinId);
		tbKin[#tbKin + 1]	= pKin.GetName();
		nKinId 	= pKinIt.NextKinId();
	end
	local pMasterKin	= KKin.GetKin(pTong.GetMaster());
	local pPresidenKin	= KKin.GetKin(pTong.GetPresidentKin());
	local tbText	= {
		{"Tên bang hội", pTong.GetName()},
		{"Bang chủ", pMasterKin.GetMemberName(pMasterKin.GetCaptain())},
		{"Phó bang chủ", (pPresidenKin and pPresidenKin.GetMemberName(pTong.GetPresidentMember())) or "nil"},
		{"Thời gian tạo", os.date("%Y-%m-%d %H:%M:%S", pTong.GetCreateTime())},
		{"Gia tộc thành viên", table.concat(tbKin, " ")},
		{"Quỹ", pTong.GetMoneyFund()},
		{"Quỹ xây", pTong.GetBuildFund()},
		{"Tỷ lệ lợi nhuận", pTong.GetTakeStock()},
		{"Thành chính", pTong.GetCapital()},
		{"Lương theo chức vụ", pTong.GetDomainAwardAmount()},
		{"ID Gia tộc",	nKinId or 0},
		{"ID Bang hội",	nTongId or 0},		
	_};
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n" .. tb[1] .. "\t" .. tostring(tb[2]);
	end
	return szMsg;
end

--功能：查询角色的家族帮会信息
--参数格式：角色名
--返回值格式：角色名(角色ID),家族信息(家族ID),帮会信息(帮会ID)
function GmCmd:QueryKinTongOfRole(szRoleName)
	local szPlayerName	= szRoleName;
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	local szMsg	= string.format("%s(%s)", szPlayerName, tostring(nPlayerId));
	if (not nPlayerId) then
		return szMsg;
	end
	local nKinId = KGCPlayer.GetKinId(nPlayerId);
	local pKin = KKin.GetKin(nKinId);
	szMsg	= szMsg .. string.format(", %s(%s)", (pKin and pKin.GetName()) or "nil", tostring(nKinId));
	if (not pKin) then
		return szMsg;
	end
	local nTongId	= pKin.GetBelongTong();
	local pTong		= KTong.GetTong(nTongId);
	szMsg	= szMsg .. string.format(", %s(%s)", (pTong and pTong.GetName()) or "nil", tostring(nTongId));
	return szMsg;
end

--功能：查询服务器信息
--参数格式：无参数
--返回值格式：区服ID,角色数量,开服时间,开放150级时间,联赛届数,领土战场次数
function GmCmd:QueryServerInfo()
	local nOpen150	= KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150);
	if (nOpen150 == 0) then
		nOpen150	= TimeFrame:GetTime("OpenLevel150");
	end
	return GetGatewayName() .. "," .. GetMaxPlayerId() .. "," .. os.date("\37Y-\37m-\37d", KGblTask.SCGetDbTaskInt(16)) .. "," .. os.date("\37Y-\37m-\37d", nOpen150) .. "," .. Wlls:GetMacthSession() .. "," .. KGblTask.SCGetDbTaskInt(DBTASK_DOMAIN_BATTLE_NO)
end

--功能：对角色补偿
--参数格式：{ szRoleName=[[]], tbItem={g,d,p,l}, nTimeLimit=n, nBind=n, nNum=n, nMoney=n, nBindMoney=n, nBindCoin=n, szDesc=[==[]==], taskId=n }
--其中，szRoleName为string, tbItem为table, nTimeLimit为-1(不限时)或0(有效期30天), nNum为正整数, nBind为1(绑定)或0(不绑定)
--		nMoney,nBindMoney,nBindCoin均为>=0的整数, szDesc为string, taskId为整数,为eyes生成的补偿任务ID
--返回值格式：
function GmCmd:CompensateToRole(tb)
	local taskId = tb["taskId"];
	local szRoleName = tb.szRoleName;
	local tbValue = tb;
	tbValue.nNeedBag=0; --nNeedBag为0则自动判断背包
	--若以前已执行过则拒绝再次执行，并发送以前执行的结果
	local prevRet = GmCmd.tbCompensateTaskId[taskId];
	if prevRet then
		return "executed before: "..prevRet;
	end
	local ret = GM:AddOnNpc("", "", szRoleName, 0, 0, tbValue);
	if type(ret) == 'number' then
		GmCmd.tbCompensateTaskId[taskId] = ret;
	end
	return ret;
end

-- 强制下架 params=g,d,p,l, CurrencyType
function GmCmd:CancelWareSaleStatus(params)
	if not params then
		return 0
	end
	return IbShop:SetWareStatus(params, 1)
end

-- 恢复上架 params=g,d,p,l
function GmCmd:AddWareSaleStatus(params)
	if not params then
		return 0;
	end
	return IbShop:SetWareStatus(params, 0)
end

-- 查看哪些物品被强制下架了
function GmCmd:GetWareSaleStatus()
	local szMsg = IbShop:GetWareStatusList()
	return szMsg
end

--功能：给角色发邮件
--参数格式：角色名\t邮件标题\t邮件正文内容
--返回值格式：SendMailGC的返回值
function GmCmd:SendMail(params)
	local index = string.find(params, "\t");	
	local nextIndex = string.find(params, "\t", index+1);	
	local roleName = string.sub(params, 1, index-1)
	local title = string.sub(params, index+1, nextIndex-1);
	local content = string.sub(params, nextIndex+1);

	return SendMailGC(roleName, title, content);
end

--功能：开启"消费返还"促销活动
--参数格式：{S={0},E={1},nType={2}}
--S为开始时间，E为结束时间，格式为YYYYmmddHH。nType为1表示本月消费返还20%；为2表示本月前15000消费的金币返还15000金币,后消费的金币返还20%
function GmCmd:OpenIBReturn(tb)
	--检查返还类型
	if tb.nType ~= 1 and tb.nType ~= 2 then
		return "invalid IB Return type: "..tb.nType;
	end
	
	local nEventId = 20;
	EventManager:SetEventPartName(nEventId, 1, "Hoạt động trở lại");
	EventManager:SetPartDate(nEventId, 1, tb.S, tb.E);
	EventManager:SetEventSubKind(nEventId,1, "action_opentask");
	EventManager:SetPartParam(nEventId, 1, 1, string.format("OpenIBReturen:%s", tb.nType));
	EventManager:UpdateEvent(nEventId);
	return 1; 
end

function GmCmd:LoadKingEyesEventFile(params)
	local szPath = params;
	if EventManager.KingEyes:GCReloadEventByFile(szPath) == 0 then
		return "Tập tin load không thành công: "..szPath;
	end
	return 1;
end

function GmCmd:CompensateToRoleFile(tbParam)
	local szPath	= tbParam.szPath;
	local nTaskId	= tonumber(tbParam.nTaskId) or 0;
	
	if nTaskId > 0 then
		--若以前已执行过则拒绝再次执行，并发送以前执行的结果
		local prevRet = GmCmd.tbCompensateTaskId[nTaskId];
		if prevRet then
			return "executed before: "..prevRet;
		end
	end
	local nLogId = SpecialEvent.CompensateGM:LoadFile(szPath,nTaskId);
	if nLogId == 0 then
		return "Tập tin load không thành công: "..szPath;
	end
	
	GmCmd.tbCompensateTaskId[nTaskId] = nLogId;
	
	return nLogId;
end

function GmCmd:LoadIllegalListFile(tbParam)
	local nRet = SpecialEvent.HoleSolution:LoadBlackListToDataBase(tbParam.szPath, tbParam.szIndex);
	return nRet;
end

function GmCmd:GetKingEyesEvent(params)
	return EventManager.KingEyes:GetGblBufCurEffectString();
end

function GmCmd:CloseKingEyesEvent(tb)
	
	local nEId = tonumber(tb.nEventId) or 0;
	local nPId = tonumber(tb.nPartId) or 0;
	if EventManager.KingEyes:CloseEvent(nEId, nPId) == 0 then
		return "Hoạt động không tồn tại"; 
	end
	return 1;
end

function GmCmd:BatchArrest(tbParam)
	return GM.BatchArrest:ReadList(tbParam.szDataPath, tonumber(tbParam.bArrest));
end

function GmCmd:BatchMail(tbParam)
	return Mail.BatchMail:ReadList(tbParam.szDataPath, tbParam.szTitle, tbParam.szContent);
end

-- 获得Vip转服数据
function GmCmd:GetVipTransData(szPlayerName)
	return VipPlayer.VipTransfer:GetApplyOut_GC(szPlayerName);
end

-- 设置Vip转服数据
function GmCmd:SetVipTransData(szData)
	return VipPlayer.VipTransfer:SetApplyIn_GC(szData);
end

function GmCmd:LoadQuestFile(tbParam)
	local szPath = tbParam.szPath;
	local szPlayerListPath = tbParam.szPlayerListPath;
	if EventManager.KingEyes:GCReloadEventByFile(szPath, szPlayerListPath) == 0 then
		return "Tập tin load không thành công: "..szPath;
	end
end
--功能：开启白虎堂boss掉落翻倍
--参数格式：{S={0},E={1},nType={2}}
--S为开始时间，E为结束时间，格式为YYYYmmddHH。nCount为翻的倍数
function GmCmd:Openbaihutang(tbParam)
	local tbEvent = {};
	local nEventId = 20;
	local nPartId = 2
	tbEvent[nEventId] = tbEvent[nEventId] or {};
	tbEvent[nEventId].tbPart = tbEvent[nEventId].tbPart or {};
	tbEvent[nEventId].tbPart[nPartId] = {};
	tbEvent[nEventId].tbPart[nPartId].szName = string.format("Mở Bạch Hổ Đường thả boss %s",tbParam.nCount);
	tbEvent[nEventId].tbPart[nPartId].szSubKind = "default";
	local nStartTime = Lib:GetDate2Time(tbParam.S);
	local nEndTime = Lib:GetDate2Time(tbParam.E);
	tbEvent[nEventId].tbPart[nPartId].nStartDate = tonumber(os.date("%Y%m%d%H%M", nStartTime));
	tbEvent[nEventId].tbPart[nPartId].nEndDate  = tonumber(os.date("%Y%m%d%H%M", nEndTime));
	tbEvent[nEventId].tbPart[nPartId].tbExParam = {string.format("SetBaiHuAwardTimes:%s", tbParam.nCount)};
	EventManager.KingEyes:SaveBuf(tbEvent);
	EventManager.KingEyes:UpdateEvent(tbEvent);
	return 1;
end

--功能：开启宋金奖励翻倍
--参数格式：{S={0},E={1},nType={2}}
--S为开始时间，E为结束时间，格式为YYYYmmddHH。nCount为翻的倍数
function GmCmd:Openbattle(tbParam)
	local tbEvent = {};
	local nEventId = 20;
	local nPartId = 3
	tbEvent[nEventId] = tbEvent[nEventId] or {};
	tbEvent[nEventId].tbPart = tbEvent[nEventId].tbPart or {};
	tbEvent[nEventId].tbPart[nPartId] = {};
	tbEvent[nEventId].tbPart[nPartId].szName = string.format("Mở Tống Kim %s",tbParam.nCount);
	tbEvent[nEventId].tbPart[nPartId].szSubKind = "default";
	local nStartTime = Lib:GetDate2Time(tbParam.S);
	local nEndTime = Lib:GetDate2Time(tbParam.E);
	tbEvent[nEventId].tbPart[nPartId].nStartDate = tonumber(os.date("%Y%m%d%H%M", nStartTime));
	tbEvent[nEventId].tbPart[nPartId].nEndDate  = tonumber(os.date("%Y%m%d%H%M", nEndTime));
	tbEvent[nEventId].tbPart[nPartId].tbExParam = {string.format("SetSongJinAwardTimes:%s", tbParam.nCount)};	
	EventManager.KingEyes:SaveBuf(tbEvent);
	EventManager.KingEyes:UpdateEvent(tbEvent);
	return 1;
end

--功能：开启宋金奖励翻倍
--参数格式：{szName=""}	szName为家族名字
function GmCmd:QueryKinPlayerInfo(tbParam)
	local nKinId = KKin.GetKinNameId(tbParam.szName);
	local cKin = KKin.GetKin(nKinId);
	if (not cKin) then
		return "[error]Gia tộc không tồn tại!";
	end
	local itor = cKin.GetMemberItor();
	local cMember = itor.GetCurMember();
	local szMsg = "\n";
	while cMember do
		local nFig = cMember.GetFigure();		
		local nPlayerId = cMember.GetPlayerId();
		local szName = KGCPlayer.GetPlayerName(nPlayerId);
		szMsg = szMsg .. nFig .. "\t" .. szName .. "\n";		
		cMember = itor.NextMember();
	end
	return szMsg;
end

--功能：查询结婚排期列表
function GmCmd:QueryMarryInfo()
	return Marry:GetMarryInfo();
end

--查询联赛战队信息（通过战队名）
function GmCmd:QueryWllsLeagueForLName(tbParam)
	local szLeagueName = tbParam.szLeagueName;
	local nDate		   = tonumber(tbParam.nDate) or 0;
	if nDate <= 0 then
		nDate = tonumber(GetLocalDate("%Y%m%d"));
	end
	return League:GetFileHistoryInforByLeague(Wlls.LGTYPE, nDate, szLeagueName)
end

--查询联赛战队信息（通过成员名）
function GmCmd:QueryWllsLeagueForMName(tbParam)
	local szMemberName = tbParam.szMemberName;
	local nDate		   = tonumber(tbParam.nDate) or 0;
	if nDate <= 0 then
		nDate = tonumber(GetLocalDate("%Y%m%d"));
	end
	return League:GetFileHistoryInforByMember(Wlls.LGTYPE, nDate, szMemberName)	
end

-- 查询奇珍阁在线指令buff
function GmCmd:QueryIbshopBuffInfo()
	local tbIbShopCmd = IbShop.tbIbshopCmdBuff;
	if (not tbIbShopCmd or Lib:CountTB(tbIbShopCmd) == 0) then
		return "不存在奇珍阁在线指令";
	end
	local strResult = "\n【状态】\t货币类型\t商品id\t折扣\t开始优惠时间\t结束优惠时间\t物品名\n"
	local nCurTime = GetTime();
	local szOutFile = "\\playerladder\\query_ibshop_goods.txt";
	KFile.WriteFile(szOutFile, strResult);
	for _, tbSubCmd in pairs(tbIbShopCmd) do
		local szState = "【上架中】";
		local szTimeSaleStart = tbSubCmd["timeSaleStart"];
		if (szTimeSaleStart) then
			local nTimeSaleStart = Lib:GetDate2Time(IbShop:ParseTime(szTimeSaleStart));
			if (nTimeSaleStart and nCurTime < nTimeSaleStart) then
				szState = "【下架中】";
			end
		end
		local szTimeSaleClose = tbSubCmd["timeSaleClose"];
		if (szTimeSaleClose) then
			local nTimeSaleClose = Lib:GetDate2Time(IbShop:ParseTime(szTimeSaleClose));
			if (nTimeSaleClose and nCurTime > nTimeSaleClose) then
				szState = "【下架中】";
			end
		end
		
		local szCurrencyType = "金币区";
		local nCurrencyType = tbSubCmd["nCurrencyType"];
		if (nCurrencyType and 2 == nCurrencyType) then
			szCurrencyType = "绑金区";
		end
		
		local nWareId = tbSubCmd["WareId"] or 0;
		if (IbShop.tbPreloadWareInfo[nWareId]) then
			local nDiscount = tbSubCmd["nDiscount"] or "未打折";
			local nDiscountStart = tbSubCmd["DiscountStart"] or "不存在";
			local nDiscountClose = tbSubCmd["DiscountClose"] or "不存在";
			local szWareName = IbShop.tbPreloadWareInfo[nWareId]["WareName"] or "未获取到名字";
			local szOut = string.format("%s\t%s\t%s\t%s\t%s\t%s\t%s\n", szState, szCurrencyType,
				nWareId, nDiscount, nDiscountStart, nDiscountClose, szWareName);
			strResult = strResult .. szOut;
			KFile.AppendFile(szOutFile, szOut);	
		end
	end
	
	return strResult;
end

-- 为奇珍阁所有商品打折
-- 参数：货币类型（0金币 2绑金） 折扣（百分比，比如50就代表50%的折扣） 开始和结束销售时间（格式为："2010-1-17 0:00:00"）
function GmCmd:SetAllIbWareDiscount(tbParam)
	local nDiscount = tbParam.nDiscount;
	local nNeedCurrencyType = tbParam.nNeedCurrencyType;
	local szStartTime = tbParam.szStartTime;
	local szEndTime = tbParam.szEndTime;
	if (nDiscount < 1) then
		return "【Error】折扣百分比必须大于0";
	end
	
	local szPath = "\\setting\\ibshop\\";
	if (0 == nNeedCurrencyType) then
		szPath = szPath .. "coinshop.txt";
	elseif (2 == nNeedCurrencyType) then
		szPath=szPath .. "bindcoinshop.txt";
	else
		return "【Error】货币类型不正确";
	end
	
	local tbShop = KLib.LoadTabFile(szPath);
	local tbWareId = {};
	for nId, tbData in ipairs(tbShop) do
		if nId > 1 then
			local nId = tonumber(tbData[1]) or 0;
			tbWareId[nId] = 1;
		end
	end
	
	for _, tbData in pairs(IbShop.tbPreloadWareInfo) do
		local nCurrencyType = tonumber(tbData["nCurrencyType"]);
		if (nCurrencyType == nNeedCurrencyType) then
			local nId = tonumber(tbData["WareId"]);
			local nOrgPrice = tonumber(tbData["nOrgPrice"]) or 1;
			local nValue = nDiscount * nOrgPrice;
			local nCurRate=nDiscount;
			if nValue < 100 then
				nCurRate = math.ceil(100 / nOrgPrice);
			end
			local tbTemp = {};
			if (tbWareId[nId] and nCurRate > 0) then
				tbTemp.WareId = nId;
				tbTemp.nDiscount = nCurRate;
				tbTemp.DiscountStart = szStartTime;
				tbTemp.DiscountClose = szEndTime;
				GM:ModifyIBWare(tbTemp, 0);
			end
		end
	end
	IbShop:SaveBuf();
	return 1;
end

-- 为奇珍阁单个商品打折
-- 参数：商品id 折扣（百分比，比如50就代表50%的折扣） 开始和结束销售时间（格式为："2010-1-17 0:00:00"）
function GmCmd:SetOneIbWareDisCount(tbParam)
	local nWareId = tbParam.nWareId;
	local nDiscount = tbParam.nDiscount;
	local szStartTime = tbParam.szStartTime;
	local szEndTime = tbParam.szEndTime;
	if (nDiscount < 1 or not IbShop.tbPreloadWareInfo[nWareId]) then
		return "【Error】折扣百分比必须大于0并且商品必须存在。";
	end

	local tbData = IbShop.tbPreloadWareInfo[nWareId];
	local nOrgPrice = tonumber(tbData["nOrgPrice"]) or 1;
	local nValue = nDiscount * nOrgPrice;
	local nCurRate=nDiscount;
	if nValue < 100 then
		nCurRate = math.ceil(100 / nOrgPrice);
	end	
	
	if (nCurRate > 0) then
		local tbTemp = {};
		tbTemp.WareId = nWareId;
		tbTemp.nDiscount = nCurRate;
		--tbTemp.timeSaleStart = "2008-8-8 0:00:00";
		--tbTemp.timeSaleClose = "2018-8-8 0:00:00";
		tbTemp.DiscountStart = szStartTime;
		tbTemp.DiscountClose = szEndTime;
		GM:ModifyIBWare(tbTemp);
	end
	return 1;
end

-- 对单个商品上架
function GmCmd:UpGoods(tbParam)
	local nWareId = tonumber(tbParam.nWareId);
	local nTimeFrame = tonumber(tbParam.nTimeFrame) or 0;
	local szSellStartDate  = tbParam.szSellStartDate;
	local szSellEndTime  = tbParam.szSellEndTime;
	if (not IbShop.tbPreloadWareInfo[nWareId]) then
		return "【Error】商品必须存在。";
	end
	local tbTemp = {};
	tbTemp.WareId = nWareId;
	local szStartDate = GetLocalDate("%Y-%m-%d 0:00:00");
	tbTemp.timeSaleStart = szStartDate;
	tbTemp.timeSaleClose = "2018-8-8 0:00:00";
	if szSellStartDate and szSellStartDate ~= "" then
		tbTemp.timeSaleStart = szSellStartDate;
	end
	if szSellEndTime and szSellEndTime ~= "" then
		tbTemp.timeSaleClose = szSellEndTime;
	end	
	if (nTimeFrame > 0) then
		tbTemp.nTimeFrameStartSale = nTimeFrame;
		tbTemp.nTimeFrameEndSale = 100000;
	end
	GM:ModifyIBWare(tbTemp);
	return 1;
end

-- 对单个商品下架
function GmCmd:DownGoods(nWareId)
	nWareId = tonumber(nWareId);
	if (not IbShop.tbPreloadWareInfo[nWareId]) then
		return "【Error】商品必须存在。";
	end
	local tbTemp = {};
	tbTemp.WareId = nWareId;
	tbTemp.timeSaleStart = "2018-8-8 0:00:00";
	tbTemp.timeSaleClose = "2018-8-8 0:00:00";
	GM:ModifyIBWare(tbTemp);
	return 1;
end

--清除在线指令的buff
function GmCmd:ClearIbshopBuff()
	IbShop.tbIbshopCmdBuff = {};
	IbShop:SaveBuf();
	return 1;
end

--查询补偿信息
function GmCmd:QueryCompensateByName(tbParam)
	local szName = tbParam.szName;
	if not szName or szName == "" then
		return "Vui lòng nhập tên người chơi";
	end
	return SpecialEvent.CompensateGM:GmGmdQueryAddOnNpc(szName);
end

--删除补偿信息
function GmCmd:ClearCompensateByName(tbParam)
	local szName = tbParam.szName;
	local nLogId = tonumber(tbParam.nLogId) or 0;
	if not szName or szName == "" then
		return "Vui lòng nhập tên người chơi";
	end
	if nLogId == 0 then
		return SpecialEvent.CompensateGM:GmGmdDelAllAddOnNpc(szName);
	end
	return SpecialEvent.CompensateGM:GmGmdDelSignleAddOnNpc(szName, nLogId);
end

function GmCmd:SetIbShopGoodsNewUp(nWareId)
	nWareId = tonumber(nWareId);
	if (not IbShop.tbPreloadWareInfo[nWareId]) then
		return "【Error】商品必须存在。";
	end
	local tbTemp = {};
	tbTemp.WareId = nWareId;
	local szStartDate = GetLocalDate("%Y-%m-%d 0:00:00");
	tbTemp.timeSaleStart = szStartDate;
	tbTemp.timeSaleClose = "2018-8-8 0:00:00";
	GM:ModifyIBWare(tbTemp);
	return 1;
end

--查询金币交易所汇率
function GmCmd:QueryJBExchangeRate()
	return "Tỷ giá giao dịch đồng: "..KJbExchange.GetPrvAvgPrice();
end

-- 修改制定商品的售价
function GmCmd:SetOneIbWarePrice(tbParam)
	local nWareId = tonumber(tbParam.nWareId);
	if (not IbShop.tbPreloadWareInfo[nWareId]) then
		return "【Error】商品必须存在。";
	end
	local nPrice = tonumber(tbParam.nPrice);
	if (not nPrice or nPrice <= 0) then
		return "【Error】请检查行的售价。";
	end
	local tbTemp = {};
	tbTemp.WareId = nWareId;
	tbTemp.nOrgPrice = nPrice;
	GM:ModifyIBWare(tbTemp);
	return 1;
end



function GmCmd:LoadPresendCardFile(szFile)
	return PresendCard:LoadGblBufFile(szFile);
end

function GmCmd:DelPresendCardBuf(szType)
	local nType = tonumber(szType);
	if not nType then
		return "nType is not number"..szType;
	end
	return PresendCard:DeleteOneBuf(nType);
end

function GmCmd:QueryPresendCardBuf()
	return PresendCard:QueryGlbBuf();
end
