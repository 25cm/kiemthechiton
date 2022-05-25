local tbObject	= Ui.tbLogic.tbObject
local tbBase	= tbObject.tbContClass.base

tbBase.FormatItem = function(self,tbItem)
	local tbObj = {}
	local pItem = tbItem.pItem
	if not pItem then
		return
	end
	tbObj.szBgImage = pItem.szIconImage
	tbObj.szCdSpin  = self.CDSPIN_MEDIUM
	tbObj.szCdFlash = self.CDFLASH_MEDIUM
	tbObj.bShowSubScript = 1
	return tbObj
end

tbBase.ItemTimeRemain = function(self, pItem)
	local szItTimeRem = ""
	local tbAbsTime = me.GetItemAbsTimeout(pItem)
	if tbAbsTime then
		local itTime = string.format("%04d%02d%02d%02d%02d%s",tbAbsTime[1],tbAbsTime[2],tbAbsTime[3],tbAbsTime[4],tbAbsTime[5],"00")
		local nSec2 = Lib:GetDate2Time(itTime);
		local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"))
		local nSec1 = Lib:GetDate2Time(nDate)
		nSec1 = nSec2 - nSec1
		if nSec1 > 0 then
			if nSec1 > 86400 then
				nSec2 = math.floor(nSec1 / 86400)
				szItTimeRem = nSec2.."d"
				if nSec2 < 2 then
					nSec1 = nSec1 % 86400
					nSec1 = math.floor(nSec1 / 3600)+nSec2*24
					szItTimeRem = nSec1.."h"
				end
			elseif nSec1 > 3600 then
				nSec2 = math.floor(nSec1 / 3600)
				szItTimeRem = nSec2.."h"
				if nSec2 < 2 then
					nSec1 = nSec1 % 3600
					nSec1 = math.floor(nSec1 / 60)+nSec2*60
					szItTimeRem = nSec1.."'"
				end
			elseif nSec1 > 60 then
				nSec1 = math.floor(nSec1 / 60)
				szItTimeRem = nSec1.."'"
			else
				szItTimeRem = nSec1.."s"
			end
		end
	end
	return szItTimeRem
end

function tbBase:CalculateDay(nLastTime, nNowTime)
	local nLastDay 	= Lib:GetLocalDay(nLastTime)
	local nNowDay	= Lib:GetLocalDay(nNowTime)
	local nDays		= nNowDay - nLastDay
	if (nDays < 0) then
		nDays = 0
	end
	return nDays
end

tbBase.UpdateItem = function(self,tbItem, nX, nY)
	local pItem = tbItem.pItem
	local ns = ""
	if pItem.nCount > 1 then
		ns = tostring(pItem.nCount);
	end
	local szLvl = tostring(pItem.nLevel)
	local szTR = tbBase:ItemTimeRemain(pItem)
	local nGGI1 = pItem.GetGenInfo(1)
	local nGGI2 = pItem.GetGenInfo(2)
	local nGGI3 = pItem.GetGenInfo(3)
	if pItem.szClass == "modaoshi" or pItem.szClass == "hujiapian" or pItem.szClass == "wuxingshi" then
		if ns == "" then
			ns = "1"
		end
		ns = "Lv"..szLvl.."x"..ns
    elseif pItem.szClass =="xiang" then
		if pItem.nParticular >= 56 and pItem.nParticular<=64 then
			ns = "TK"..nGGI1
		elseif pItem.nParticular >=352 and pItem.nParticular<=354 then
			ns = "TDC"..nGGI1
		elseif pItem.nParticular >=273 and pItem.nParticular<=275 then
			ns = "TDLT "
		elseif pItem.nParticular == 37 then
			ns = "HTD"..nGGI1
		elseif pItem.nParticular == 72 then
			ns = "MDT "..szLvl
		elseif pItem.nParticular == 73 then
			ns = "HGP "..szLvl
		elseif pItem.nParticular == 74 then
			ns = "NHT "..szLvl
		elseif pItem.nParticular == 338 then
			ns = "VS"..nGGI1
		end
	elseif pItem.szClass == "kingame_qiandai" then
		ns = tostring(me.GetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID))
	elseif pItem.szClass == "army_food" then
		if pItem.nLevel == 1 then
			ns = math.floor((300000 - nGGI1)/1000)
		elseif pItem.nLevel == 2 then
			ns = math.floor((600000 - nGGI1)/1000)
		end
		ns = ns.."K"
	elseif pItem.szClass == "jinxi" then
		ns = nGGI1
	elseif pItem.szClass == "shengwanglingpai_kin" then
		ns = "GT "
	elseif pItem.szClass == "shengwanglingpai_baihutang" then
		ns = "BHD "
	elseif pItem.szClass == "zhanchanglingpai" then
		ns = "TK "
	elseif pItem.szClass == "mengpaijingjilingpai" then
		ns = "MP "
	elseif pItem.szClass == "xoyolu" then
		ns = XoyoGame.XoyoChallenge:GetGatheredCardNum(me).."c"
	elseif pItem.szClass == "chuansongfu" then
		if pItem.nParticular == 3 then
			ns = "  V "
		elseif pItem.nParticular == 4 then
			ns = "  C "
		elseif pItem.nParticular == 19 then
			ns = "  F "
		elseif pItem.nParticular == 23 or pItem.nParticular == 195 or pItem.nParticular == 234 or pItem.nParticular == 235 then
			ns = szTR
		end
		if nGGI2 > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nGGI2* 1000000 + nGGI3)
			local nSec1 = Lib:GetDate2Time(nDate);
			local nSec2 = Lib:GetDate2Time(nCanDate) + nRelayTime;
			if nSec1 < nSec2 then
				ns = (nSec2 - nSec1).."s"
			end
		end
	elseif pItem.szClass == "xiulianzhu" then
		local nLastTime		= me.GetTask(1023, 1);
		local nNowTime		= GetTime();
		local nDays			= tbBase:CalculateDay(nLastTime, nNowTime);
		local nRemainTime	= nDays * 1.5 + me.GetTask(1023, 2) / 10;
		if (nRemainTime < 0.1) then
			nRemainTime = 0;
		end
		if (nRemainTime > 14) then
			nRemainTime = 14;
		end
		ns = nRemainTime.."h"
		-- local nMiniter = (nRemainTime % 1) * 60;
		-- if nMiniter > 0 then
			-- ns = ns..nMiniter
		-- end
	elseif pItem.szClass == "equip" then
		-- ns = Env.SERIES_NAME[pItem.nSeries] or "?";
		if Item.tbSeriesFix[pItem.nEquipPos] and pItem.nSeries > 0 then 
			ns = Item.tbSeriesFix[pItem.nEquipPos][pItem.nSeries]
			if ns == 1 then
				ns = "Kim"
			elseif ns == 2 then
				ns = "Mộc"
			elseif ns == 3 then
				ns = "Thủy"
			elseif ns == 4 then
				ns = "Hỏa"
			elseif ns == 5 then
				ns = "Thổ"
			end
		end
	else
		if szTR ~= "" then
			ns = szTR
		end
	end
	if ns ~= "" then
		ObjGrid_ChangeSubScript(self.szUiGroup, self.szObjGrid, ns, nX, nY);
	end
	local nColor = (me.CanUseItem(pItem) ~= 1) and 0x60ff0000 or 0
	if me.GetStallPrice(pItem) then
		nColor = 0x30ff8000;
		if (UiManager:GetUiState(UiManager.UIS_BEGIN_STALL) == 1) then
			nColor = 0x60ffff00
		end
	elseif me.GetOfferReq(pItem) then
		nColor = 0x3080c0ff
		if (UiManager:GetUiState(UiManager.UIS_BEGIN_OFFER) == 1) then
			nColor = 0x60ffff00
		end
	end
	if pItem.szClass == "xuanjing"  and pItem.IsBind() == 0 then
		nColor = "Hide"
	end
	if pItem.szClass == "spiritstore" and pItem.nParticular ==205 and pItem.IsBind() == 0 then
		nColor = "Hide"
	end
	if szTR ~= "" then
		nColor = 0x3080c0ff
	end
	ObjGrid_ChangeBgColor(self.szUiGroup, self.szObjGrid, nColor, nX, nY);
	ObjGrid_SetTransparency(self.szUiGroup, self.szObjGrid, pItem.szTransparencyIcon, nX, nY);
	local nCdTime = Lib:FrameNum2Ms(GetCdTime(pItem.nCdType));
	if nCdTime > 0 then
		local nCdPass = Lib:FrameNum2Ms(me.GetCdTimePass(pItem.nCdType));
		ObjGrid_PlayCd(self.szUiGroup, self.szObjGrid, nCdTime, nCdPass, nX, nY);
	end
end
