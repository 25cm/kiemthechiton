-------------------------------------------------------------------
--File: auction_common.lua
--Author: Brianyao
--Date: 2008-10-07 10:39
--Describe: 拍卖行定义
-------------------------------------------------------------------


Auction.tbc2sFun   = {};
Auction.SEPARATEDTIME = 30;
Auction.nAuctionState = 1;
Auction.STARTFORBITMAPID = 29;

Auction.Exception = {341, 342};
Auction.ExceptionTemplateMapID = {}

function Auction:Init()
	for i, v in pairs(self.Exception) do
		self.ExceptionTemplateMapID[v] = 1;
	end
end

function Auction:GetAuctionValidTimeByOper( nValidTimeOper )

   if  nValidTimeOper == 0 then
       return 86400        -- 一天
   elseif nValidTimeOper == 1 then
       return 172800       -- 两天
   elseif nValidTimeOper == 2 then
       return 259200       -- 三天
   else
       return 86400        -- 一天为默认
   end
   
end

function Auction:GetAvailableSeries( nPart,nPlayerSeries )

     if nPlayerSeries == 0 then 
        return 0
     else
        if (Item.tbSeriesFix[nPart] == nil) then
           return -1
        end
     
        if nPlayerSeries == Item.tbSeriesFix[nPart][1] then
           return 1
        elseif nPlayerSeries == Item.tbSeriesFix[nPart][2] then
           return 2
        elseif nPlayerSeries == Item.tbSeriesFix[nPart][3] then
           return 3
        elseif nPlayerSeries == Item.tbSeriesFix[nPart][4] then
           return 4
        elseif nPlayerSeries == Item.tbSeriesFix[nPart][5] then
           return 5
        end
        
        return 0
     end
end

function Auction:CalcAuctionTax(nValidTimeOper,nOneTimeBuyPrice,nExpreedPrice) --CuculateTax When Sell Things
   
   if  nValidTimeOper == 0 then
       return 500        -- 一天
   elseif nValidTimeOper == 1 then
       return 1000       -- 两天
   elseif nValidTimeOper == 2 then
       return 1500       -- 三天
   else
       return 500        -- 一天为默认
   end
   
end

function Auction:NameFilter(szName, szFomatStr, nOffSet)
	local nIndex = 1;
	local nStart = 0;
	local tbResult = {};
	while 1 do
		local nStart, _ = string.find(szName, szFomatStr, nIndex);
		if (not nStart) then
			local szTemp = string.sub(szName, nIndex);
			table.insert(tbResult, szTemp);
			break;
		end
		local szTemp = string.sub(szName, nIndex, nStart - 1);
		table.insert(tbResult, szTemp);
		nIndex = nStart + nOffSet;
	end
	return tbResult;
end

function Auction:ParseName(szGoodsName)
	-- 需要忽略掉的字符以及该字符占的位数（如：一个中文"（"占两位）
	local tbPassType = {{"%d", 1}, {"%（", 2}, {"%）", 2}};
	
	local szMsg = szGoodsName;
	for i, v in ipairs(tbPassType) do
		local tbResult = self:NameFilter(szMsg, v[1], v[2]);
		szMsg = table.concat(tbResult);
	end
	return szMsg;
end

if MODULE_GAMESERVER then
function Auction:SetAuctionState(nState)
	self.nAuctionState = nState;
end

function Auction:ForbitManger(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	
	if (GLOBAL_AGENT) then
		return 0;
	end;
	
	if (pPlayer.nMapId <= self.STARTFORBITMAPID) then
		return 1;
	end
	local nMapIndex = SubWorldID2Idx(pPlayer.nMapId);
	local nMapTemplateId = SubWorldIdx2MapCopy(nMapIndex);
	if (self.ExceptionTemplateMapID[nMapTemplateId] and 1 == self.ExceptionTemplateMapID[nMapTemplateId]) then
		return 1;
	end
	return 0;
end

--....IsOpen
function Auction:IsOpen(pPlayer)
	if pPlayer == nil then
		return 0;
	end
	local szErrorMsg = "";
	if (0 == self:ForbitManger(pPlayer)) then
		szErrorMsg = "Khu vực này không cho phép bán đấu giá!";
	elseif pPlayer.IsAccountLock() ~= 0 then
		szErrorMsg = "Tài khoản đang khóa, không thực hiện thao tác này được!";
	elseif (self.nAuctionState == 0) then
		szErrorMsg = "Hiện đang là thời gian nghỉ bán đấu giá, lần sau hãy đến nhé!";
	end
	if (szErrorMsg ~= "") then 
		pPlayer.CallClientScript({"Ui:ServerCall", "UI_INFOBOARD", "OnOpen" , szErrorMsg});	
		return 0;
	end
	return 1;
end

function Auction:OpenAuction()
	
	if self:IsOpen(me) ~= 1 then
		return 0;
	end
		
	if (me.nFightState == 1) then
		me.CallClientScript({"Ui:ServerCall", "UI_INFOBOARD", "OnOpen" , "Hiện bạn không được bán đấu giá."});
		return 0;
	end

	return me.CallClientScript({"UiManager:OpenWindow", "UI_AUCTIONROOM"});
end
Auction.tbc2sFun ["ApplyOpenAuction"] = Auction.OpenAuction;

function Auction:CanSendAdv(szName)
	local nNow = GetTime();
	local tbAuctionTemp = me.GetTempTable("Auction");
	local nPrvSendTime = tbAuctionTemp.nPrvSendTime or 0.
	if (0 == nPrvSendTime or nNow - nPrvSendTime >= self.SEPARATEDTIME ) then
		tbAuctionTemp.nPrvSendTime = nNow;
		return 1;
	end
	return 0;	
end

function Auction:SendAdvs(szAucKey)
	if (self:CanSendAdv(me.szName) ~= 1) then
		me.Msg("Quảng cáo của bạn phát đi nhiều lần rồi, hãy uống tách trà nghỉ ngơi đi!");
		return ;
	end	
	if (not szAucKey) then
		me.Msg("Quảng cáo phát đi có lỗi, sau khi xác nhận, hãy phát lại!");
		return;
	end
	if (1 ~= ChatChannel:CheckPermission(me, ChatChannel.CHANNEL_WORLD)) then
		return 0;
	end
	
	local nRet = me.SendAucItemAdvsInfo(szAucKey);
	
	if (not nRet or nRet ~= 0) then
		me.Msg("Thông tin quảng cáo phát đi có lỗi, sau khi xác nhận hãy phát lại.");
		 return ;		
	end
end
Auction.tbc2sFun ["ApplySendAdvs"] = Auction.SendAdvs;

function Auction:IsNamePass(pPlayer, szGoodsName)
	if (not pPlayer or not szGoodsName) then
		return 0;
	end
	if ("" == szGoodsName) then
		return 1;
	end
	
	local szTemp = self:ParseName(szGoodsName);
	if (KUnify.IsNameWordPass(szTemp) ~= 1) then
		pPlayer.Msg("Chỉ có thể nhập số và các ký tự [ ] ()!");
		return 0;
	end

	return 1;
end

end

if MODULE_GC_SERVER then
	
function Auction:IsCloseCmd(nState)
	_G.GlobalExcute({"Auction:SetAuctionState", nState});
	return ;
end

end

Auction:Init();
