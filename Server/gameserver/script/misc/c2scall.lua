-------------------------------------------------------------------
--File: c2scall.lua
--Author: lbh
--Date: 2007-7-31 10:05
--Describe: 客户端调用服务端脚本接口
-------------------------------------------------------------------
if not MODULE_GAMESERVER then
	--最好不要在客户端暴露此文件
	--error("Only For Gameserver")
	return
end

--召唤令牌回调
function c2s:ZhaoHuanLingPaiCmd(nMapId, nPosX, nPosY, nMemberPlayerId, nFightState, bAccept)
	--print("ZhaoHuanLingPaiCmd", nMapId, nPosX, nPosY, nMemberPlayerId, nFightState, bAccept)	
	Item.tbZhaoHuanLingPai:PlayerAccredit(nMapId, nPosX, nPosY, nMemberPlayerId, nFightState, bAccept);
end

function c2s:HelpManCmd(szName)
	--print("HelpMan", szName, "点开次数");
end

function c2s:NewPlayerUiCmd(...)
	local fun = Log.Ui_LogSetValue
	if not fun then
		print("c2s NewPlayerUi Command Error Called: Ui_LogSetValue")
		return
	end
	fun(Log, unpack(arg))
end

function c2s:PartnerCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return
	end
	local fun = Partner.c2sFun[szFun]
	if not fun then
		print("c2s Partner Command Error Called: "..szFun)
		return
	end
	fun(Partner, unpack(arg))
end

function c2s:KinCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return
	end
	local fun = Kin.c2sFun[szFun]
	if not fun then
		print("c2s Kin Command Error Called: "..szFun)
		return
	end
	fun(Kin, unpack(arg))
end

function c2s:TongCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return
	end
	local fun = Tong.c2sFun[szFun]
	if not fun then
		print("c2s Tong Command Error Called: "..szFun)
		return
	end
	fun(Tong, unpack(arg))
end

function c2s:DlgCmd(szFun, varValue)
	if type(szFun) ~= "string" then
		return
	end
	if (szFun == "InputNum") then
		local nNum	= tonumber(varValue);
		if not nNum then
			return
		end
		nNum	= math.floor(nNum);
		if (nNum < 0 or nNum > 20*10000*10000) then	-- 暂不允许负数和20亿以上
			ServerEvent:WriteLog(Dbg.LOG_ERROR, "DlgCmd-InputNum Error!", me.szName, me.szAccount, nNum);
			return;
		end
		Dialog:OnOk("tbNumberCallBack", nNum);
	elseif (szFun == "InputTxt") then
		Dialog:OnOk("tbStringCallBack", tostring(varValue));
	end
end

function c2s:MailCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return;
	end
	local fun = Mail.tbc2sFun[szFun];	
	if not fun then
		print("c2s Mail Command Error Called: "..szFun);
		return;
	end
	fun(Mail, unpack(arg));
end

function c2s:HlpQue(nGroupId)
	if (type(nGroupId) ~= "number") then
		return;
	end
	HelpQuestion:StartGame(me, nGroupId)
end

function c2s:OfflineBuy(nType, nCount)
	if (not nType or not nCount or 0 == Lib:IsInteger(nType) or 0 == Lib:IsInteger(nCount)) then
		return;
	end
	nType	= math.floor(nType);
	nCount	= math.floor(nCount);
	-- assert(nType >= 1 and nType <= Item.IVER_nOpenBaiJuWanLevel); --改成return zounan
	if nType < 1 or nType > Item.IVER_nOpenBaiJuWanLevel then
		Player:ProcessIllegalProtocol("c2s:OfflineBuy","nType",nType);	
		return;
	end
	--assert(nCount > 0 and nCount < 10000); --改成return zounan
	if nCount <= 0 or nCount >= 10000 then
		Player:ProcessIllegalProtocol("c2s:OfflineBuy","nCount",nCount);	
		return;
	end
	Player.tbOffline:OnBuy(nType, nCount);
end

function c2s:JingHuoBuy(nType, nCount)
	--if (not nType or not nCount or 0 == Lib:IsInteger(nType) or 0 == Lib:IsInteger(nCount)) then	购买精活的数目已经限定了 故不需要nCount
	if (not nType or 0 == Lib:IsInteger(nType)) then
		return;
	end	
	nType	= math.floor(nType);
	-- nCount	= math.floor(nCount);  -- nCount没有用到
	--assert(nType >= 1 and nType <= 2); --改成return zounan
	if(nType < 1 or nType > 2) then	
		Player:ProcessIllegalProtocol("c2s:JingHuoBuy","nType",nType);		
		return;
	end
	
--	assert(nCount > 0 and nCount < 10000);
	Player.tbBuyJingHuo:BuyItem(nType);
end

function c2s:ApplyBuyJiuZhuan()
	Player:ApplyBuyAndUseJiuZhuan();
end
	
function c2s:JbExchangeCmd(szFun, ...)
	if (type(szFun) ~= "string") then
		return;
	end
	local fun = JbExchange.tbc2sFun[szFun];
	if not fun then
		print("c2s JbExchange Error Called:".. szFun);
		return;
	end
	fun(JbExchange, unpack(arg));
end

function c2s:LadderApplyCmd(nValue1, nValue2)
	if type(nValue1) ~= "number" or type(nValue2) ~= "number" then
		return;
	end
	Ladder:OnApplyLadder(nValue1, nValue2);
end

function c2s:LadderListApplyCmd(nValue1, nValue2)
	if (type(nValue1) ~= "number" or type(nValue2) ~= "number") then
		return;
	end
	Ladder:OnApplyList(nValue1, nValue2);
end

function c2s:LadderSearchListApplyCmd(nValue, szValue)
	if (type(nValue) ~= "number" or type(szValue) ~= "string") then
		return;
	end
	Ladder:OnApplySearchResult(nValue, szValue, 1);
end

function c2s:LadderApplyAdvSearchCmd(nValue1, nValue2, nValue3, szValue)
	if (type(nValue1) ~= "number" or type(nValue2) ~= "number" or type(nValue3) ~= "number" or type(szValue) ~= "string") then
		return;
	end
	Ladder:OnApplyAdvSearch(nValue1, nValue2, nValue3, szValue);	
end

function c2s:ApplyUpdateOnlineState(nValue)
	if (type(nValue) ~= "number") then
		return;
	end
	Player.tbOnlineExp:OnApplyUpdateState((nValue == 1 and 1) or 0);
end

function c2s:ApplyEscLooker()
	Looker:Leave(me);
end

function c2s:PlayerPrayCmd()
	Task.tbPlayerPray:OnApplyGetResult();
end

function c2s:ApplyGetPrayAward()
	Task.tbPlayerPray:OnApplyGetAward();
end

-- 百宝箱
function c2s:ApplyBaibaoxiangGetResult(nCoin)
	Baibaoxiang:OnPlayerGetResult(nCoin);
end

function c2s:ApplyBaibaoxiangGetAward(nType)
	Baibaoxiang:OnPlayerGetAward(nType);
end
-- end

-- 游龙秘宝
function c2s:ApplyYoulongmibaoGetAward(nType)
	Youlongmibao:OnPlayerGetAward(nType);
end

function c2s:ApplyYoulongmibaoContinue()
	Youlongmibao:OnPlayerContinue();
end

function c2s:ApplyYoulongmibaoRestart()
	Youlongmibao:OnPlayerRestart();
end

function c2s:ApplyYoulongmibaoLeaveHere()
	Youlongmibao:OnPlayerLeave();
end

function c2s:ApplyYoulongmibaoShowAward()
	Youlongmibao:OnPlayerShowAward();
end
-- end

function c2s:AccountCmd(nId, ...)
	Account:ProcessClientCmd(nId, arg);
end

function c2s:ProCmd(szFun,...)
	if type(szFun) ~= "string" then
		return
	end
	local fun = PProfile.c2sFun[szFun]
	if not fun then
		print("c2s PlayerProfile Command Error Called: "..szFun)
		return
	end
	fun(PProfile, unpack(arg))
end

function c2s:DomainCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return
	end
	local fun = Domain.c2sFun[szFun]
	if not fun then
		print("c2s Domain Command Error Called: "..szFun)
		return
	end
	fun(Domain, unpack(arg))
end

function c2s:HonorDataApplyCmd()
	PlayerHonor:SendHonorData();
end

function c2s:ApplyAccountInfo()
	me.ApplyAccountInfo();
end

function c2s:BankCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return;
	end
	local fun = Bank.tbc2sFun[szFun];
	if not fun then
		print("c2s Bank Error Called:".. szFun);
		return;
	end
	
	if (Bank.nBankState == 0) then
		me.Msg("钱庄暂时没有开放。");
		return ;
	end
	
	fun(Bank, unpack(arg));
end

function c2s:ClientProInfo(szFun, ...)
	if (type(szFun) ~= "string") then
		return 0;
	end
	local fun = Player.tbAntiBot.tbCProInfo.tbc2sFun[szFun];
	if (not fun) then
		return 0;
	end
	fun(Player.tbAntiBot.tbCProInfo, unpack(arg));
	return 1;
end

function c2s:RecvCData(szFun, ...)
	if (type(szFun) ~= "string") then
		return 0;
	end
	local szName, nFileIndex, nEndFlag, szMsg = unpack(arg);
	if (type(szName) ~= "string" or type(nFileIndex) ~= "number" or type(nEndFlag) ~= "number" or type(szMsg) ~= "string") then
		return 0;
	end
	local fun = Player.tbAntiBot.tbCProInfo.tbc2sFun[szFun];
	if (not fun) then
		return 0;
	end
	fun(Player.tbAntiBot.tbCProInfo, unpack(arg));
end

function c2s:AuctionCmd(szFun, ...)
	if (type(szFun) ~= "string") then
		return 0;
	end	
	local fun = Auction.tbc2sFun[szFun];
	if (not fun )then
		return 0;
	end
	fun(Auction, unpack(arg));
end

function c2s:RelationCmd(szFun, ...)
	if type(szFun) ~= "string" then
		return;
	end
	local fun = Relation.tbc2sFun[szFun];
	if not fun then
		print("c2s Relation Error Called:".. szFun);
		return;
	end
	
	fun(Relation, unpack(arg));
end

function c2s:PlatformDataApplyCmd()
	EPlatForm:ApplyKinEventPlatformData();
end

function c2s:AchievementCmd(szFun, ...)
	if (type(szFun) ~= "string") then
		return;
	end
	local fun = Achievement.tbc2sFun[szFun];
	if (not fun) then
		print("c2s Achievement Error Called:".. szFun);
		return;
	end
	
	fun(Achievement, unpack(arg));
end

-- 师徒传送
function c2s:ShiTuChaunSongCmd(szFun, ...)
	if (type(szFun) ~= "string") then
		return;
	end
	local fun = Item.tbShiTuChuanSongFu.tbc2sFun[szFun];
	if (not fun) then
		print("c2s ShiTuChaunSong Error Called:".. szFun);
		return;
	end
	
	fun(Item.tbShiTuChuanSongFu, unpack(arg));
end

-- 调查问卷
function c2s:Questionnaires(nStaus)
	SpecialEvent.Questionnaires:OnAnswer(tonumber(nStaus));
end

-- 夫妻传送
function c2s:tbFuQiChuanSongCmd(szFun, ...)
	if (type(szFun) ~= "string") then
		return;
	end
	local fun = Item.tbFuQiChuanSongFu.tbc2sFun[szFun];
	if (not fun) then
		print("c2s FuQiChaunSong Error Called:".. szFun);
		return;
	end
	
	fun(Item.tbFuQiChuanSongFu, unpack(arg));
end

-- 使用无限传送符
function c2s:UseUnlimitedTrans(nMapId)
	Item:GetClass("chuansongfu"):OnClientCall(math.floor(nMapId));
end

function c2s:RecordPluginUseState(szName, nPluginNum)
	if (not szName or nPluginNum >= 1) then
		local szLog = string.format("玩家\t%s\t使用了插件，插件数量\t%s", szName, nPluginNum);
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Player", "plugin_log", szLog);
	end
end

-- 在线充值页面申请区服名
function c2s:ApplyOpenOnlinePay()
	local szZoneName = GetZoneName();
	me.CallClientScript({"Ui:ServerCall", "UI_PAYONLINE", "OnRecvZoneOpen", szZoneName});	
end
