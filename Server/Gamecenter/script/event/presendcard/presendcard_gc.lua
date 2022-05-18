-- 文件名　：presendcard_gc.lua
-- 创建者　：zounan
-- 创建时间：2010-04-06 17:33:18
-- 描  述  ：
if (not MODULE_GC_SERVER) then
	return 0;
end

Require("\\script\\event\\presendcard\\presendcard_def.lua");

function PresendCard:GetGblBuf()
	local tbBuf = GetGblIntBuf(GBLINTBUF_PRESENDCARD, 0, 1);
	if tbBuf and type(tbBuf)=="table"  then
		self.tbGblBuf = tbBuf;
	end
	if not self.tbGblBuf then
		self.tbGblBuf = {};
	end
	return self.tbGblBuf;	
end

--GC启动时 删除过期BUF
function PresendCard:StartEvent()
  	local nCurSec  = GetTime();
  	local nAddSec  = 3600 * 24 *2; -- 再送两天 	即32天后删
	local tbBuf = self:GetGblBuf();
	local nSec = nil;
	for nType, tbInfo in pairs(tbBuf) do
		if tbInfo[self.INDEX_ENDTIME] and tbInfo[self.INDEX_ENDTIME] ~= 0 then
			nSec = Lib:GetDate2Time(tbInfo[self.INDEX_ENDTIME]);
			if (nSec + self.ITEM_TIMEOUT + nAddSec) < nCurSec then
				tbBuf[nType] = nil;
			end			
		end	
	end
	SetGblIntBuf(GBLINTBUF_PRESENDCARD, 0, 1, tbBuf);	
end

function PresendCard:SaveGblBuf()
	SetGblIntBuf(GBLINTBUF_PRESENDCARD, 0, 1, self.tbGblBuf);	
	GlobalExcute({"PresendCard:ReLoadBuf"});	
end

function PresendCard:LoadGblBufFile(szFilePath)
	if not szFilePath then
		return "【ERROR】: PresendCard:LoadGblBufFile szFilePath is nil";
	end
	
	local tbFile = Lib:LoadTabFile(szFilePath);
	if not tbFile then
		return "【ERROR】: PresendCard:LoadGblBufFile "..szFilePath;
	end
	
	self:GetGblBuf();	
	local nPresentTypeId = 0;
	for nId, tbParam in ipairs(tbFile) do
		local nPresentType = tonumber(tbParam.PartId) + self.VERSION_TYPE;
		if  self.tbGblBuf[nPresentType] then
			return "{error}PresendCard:LoadGblBufFile nPresentType exists nPresentType:"..nPresentType;
		end
		nPresentTypeId = nPresentType;
		self.tbGblBuf[nPresentType] = {};
		local tbBuf = self.tbGblBuf[nPresentType];
		tbBuf[self.INDEX_STARTTIME] = tonumber(tbParam.StartDate) or 0;
		tbBuf[self.INDEX_ENDTIME] 	= tonumber(tbParam.EndDate) or 0;
		tbBuf[self.INDEX_NAME]		= tbParam.Name or "";
		if tonumber(tbParam.LimitUseOption) ~= 0 then
			tbBuf[self.INDEX_TASKGROUP] = 0;
			tbBuf[self.INDEX_TASKID]	= 0;
		else
			tbBuf[self.INDEX_TASKGROUP] = self.VERSION_TSK;
			tbBuf[self.INDEX_TASKID]	= tonumber(tbParam.PartId);
		end
		
		self:SetKeyFlag(tbBuf,tbParam.NewbieCardRule);
		tbBuf[self.INDEX_ITEMTABLE] = self.ITEM_ID;
		tbBuf[self.INDEX_COUNT]		= 1;
		
		tbBuf[self.INDEX_PARAM]	= {};
		for nParam = 1, EventManager.EVENT_PARAM_MAX do
			local szParamName = string.format("ExParam%s", nParam);
			if tbParam[szParamName] and tbParam[szParamName] ~= "" then
				local szParam = EventManager.tbFun:ClearString(tbParam[szParamName]);
				if szParam ~= "" then
					table.insert(tbBuf[self.INDEX_PARAM], szParam);
				end
			end
		end	
		
	end
	self:SaveGblBuf();	
	return string.format("Id is %d",nPresentTypeId);
end

function PresendCard:DeleteOneBuf(nPresentType)
	self:GetGblBuf();
	local tbInfo = self.tbGblBuf[nPresentType];
	if not tbInfo then
		return "PresendCard:DeleteOneBuf error: not tbInfo. nId:"..nPresentType;
	end
	self.tbGblBuf[nPresentType] = nil;
	self:SaveGblBuf();
	return 1;
end

function PresendCard:QueryGlbBuf()	
	local tbInfo = self:GetGblBuf();
	if not tbInfo then
		return "none";
	end
	
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local szMsg = "\n状态\t活动ID\t活动名称\t开始时间\t结束时间\t激活码关键字\t关键字位置\n";
	for nType, tbDataInfo in pairs(tbInfo) do
		local tb = tbDataInfo[self.INDEX_KEYINDEX];		
		local szIndex = "";
		local szState = "";
		for _,nIdx in ipairs(tb) do
			szIndex = szIndex..(string.format("%d",nIdx)).." ";
		end
		
		if nCurDate < tonumber(tbDataInfo[self.INDEX_STARTTIME]) then
			szState = "【未开启】";
		elseif nCurDate <= tonumber(tbDataInfo[self.INDEX_ENDTIME]) then
			szState = "【进行中】";
		else 
			szState = "【已关闭】";
		end
		
		szMsg = szMsg..(string.format("%s\t%d\t%s\t%s\t%s\t%s\t%s\n",
			szState,nType,tbDataInfo[self.INDEX_NAME],
			tbDataInfo[self.INDEX_STARTTIME],
			tbDataInfo[self.INDEX_ENDTIME],
			tbDataInfo[self.INDEX_CDKEYFLAG],
			szIndex
			));
		
	end
	return szMsg;
end


function PresendCard:SetKeyFlag(tbBuf, szStr)
	if not szStr then
		print("{error},GetKEYFLAG szStr is nil");
		return;
	end
	local tbStr = Lib:SplitStr(szStr);
	
	if  ((#tbStr)%2) ~= 0 then
		print("{error},GetKEYFLAG szStr is not even");
		return;
	end	
	local nCount = (#tbStr)/2;
	tbBuf[self.INDEX_CDKEYFLAG] = "";
	tbBuf[self.INDEX_KEYINDEX] = {};
	for i =1, nCount do
		tbBuf[self.INDEX_CDKEYFLAG] = tbBuf[self.INDEX_CDKEYFLAG]..tbStr[i*2 - 1];
		table.insert(tbBuf[self.INDEX_KEYINDEX],tonumber(tbStr[i*2]));
	end		
end

GCEvent:RegisterGCServerStartFunc(PresendCard.StartEvent, PresendCard);