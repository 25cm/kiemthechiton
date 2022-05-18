-- 文件名　：isbhop_gc.lua
-- 创建者　：zouying
-- 创建时间：2009-9-8 10:02:31
-- 描  述  ：

if (not MODULE_GC_SERVER) then
	return 0;
end

function IbShop:StartEvent()
	self.tbGblBuf = {};
	local tbBuf = GetGblIntBuf(GBLINTBUF_IBSHOP, 0, 1);
	if tbBuf and type(tbBuf)=="table"  then
		self.tbGblBuf = tbBuf;
		--Lib:ShowTB(tbBuf)
	end
end


--GC数据同步给GS
function IbShop:OnRecConnectEvent(nConnectId)
	if self.tbGblBuf then
		for nWaraId, _ in pairs(self.tbGblBuf) do
			GSExcute(nConnectId, {"IbShop:OnRecConnectMsg", nWaraId, 1});
		end
	end
end

function IbShop:SetWareStatus(strParams, bDelOrAdd)
	local strIndex = self:GetParams(strParams)
	if not strIndex then
		return 0;
	end
	if bDelOrAdd == 1 then
		self.tbGblBuf[strIndex] = 1 
	else
		self.tbGblBuf[strIndex] = nil
	end
	-- bDelOrAdd:1是下架，0：是恢复上架
	GlobalExcute({"IbShop:OnRecConnectMsg", strIndex, bDelOrAdd});
	return 1
end

function IbShop:GetWareStatusList()
	local szMsg = ""
	local tbParams = {}
	for strIdx, _ in pairs(self.tbGblBuf) do
		tbParams = {}
		for w in string.gmatch(strIdx, "%d+") do
			table.insert(tbParams, tonumber(w))
		end
		local nG = Lib:LoadBits(tbParams[1], 24, 31)
		local nD = Lib:LoadBits(tbParams[1], 12, 23)
		local nP = Lib:LoadBits(tbParams[1], 0,  11)
		local str = tostring(nG) .. ',' .. tostring(nD) .. ',' .. tostring(nP) ..',' .. tostring(tbParams[2]) .. ',' .. tostring(tbParams[3])
		szMsg = szMsg .. '\n' .. str .. '\t down,'
	end
	return szMsg
end


function IbShop:ServerendEvent()
	SetGblIntBuf(GBLINTBUF_IBSHOP, 0, 1, self.tbGblBuf);
end

-- 合服时候用
function IbShop:MergeCoZoneAndMainZoneBuf(tbSubBuf)
	print("[IbShop MergeCoZoneAndMainZoneBuf] Start!!");
	self:StartEvent();
	if (not self.tbGblBuf) then
		self.tbGblBuf = {};
	end
	
	if (tbSubBuf) then
		for szIndex, value in pairs(tbSubBuf) do
			self.tbGblBuf[szIndex] = value;
		end
	end
	self:ServerendEvent();
end

function IbShop:GetParams(params)
	local tbParams = {}
	print(params)
	for w in string.gmatch(params, "%d+") do
		table.insert(tbParams, tonumber(w))
	
	end
	
	local nG = Lib:SetBits(0, tbParams[1], 24, 31)
	local nD = Lib:SetBits(nG, tbParams[2], 12, 23)
	local nWareId = Lib:SetBits(nD, tbParams[3], 0,  11)
	
	local strIndex = tostring(nWareId) .. ',' .. tbParams[4] .. ',' .. tbParams[5]
	--print(strIndex)
	return strIndex
end


-- 手工修改ib道具，
-- tbWareInfo 商品的具体信息（其中包含的信息参看"\\setting\\ibshop\\warelist.txt"文件）
function IbShop:PreEditIBWare(tbWareInfo)
	if (not tbWareInfo) then
		return;
	end
	
	tbWareInfo.WareId = tbWareInfo.WareId or 0;	-- 商品id
	tbWareInfo.WareName = tbWareInfo.WareName or ""; -- 商品名称
	tbWareInfo.WareType = tbWareInfo.WareType or 0; -- 商品类别（玄晶宝石、坐骑装备等）
	tbWareInfo.nGenre = tbWareInfo.nGenre or 0;	-- GDPL
	tbWareInfo.nDetailType = tbWareInfo.nDetailType or 0;
	tbWareInfo.nParticular = tbWareInfo.nParticular or 0;
	tbWareInfo.nLevel = tbWareInfo.nLevel or 0;
	tbWareInfo.nSeries = tbWareInfo.nSeries or 0; -- 五行
	tbWareInfo.nCurrencyType = tbWareInfo.nCurrencyType or 0; -- 货币类型
	tbWareInfo.nUseType = tbWareInfo.nUseType or 2;	-- 使用类型
	tbWareInfo.nOrgPrice = tbWareInfo.nOrgPrice or 0; -- 原始价格
	tbWareInfo.nWareUseStyle = tbWareInfo.nWareUseStyle or 0; -- 物品使用方式
	tbWareInfo.nDiscount = tbWareInfo.nDiscount or 100; -- 折扣（默认是100%，也就是不打折）
	tbWareInfo.nRecommend = tbWareInfo.nRecommend or 0; -- 是否推荐商品
	tbWareInfo.timeSaleStart = tbWareInfo.timeSaleStart or ""; -- 开始销售时间
	tbWareInfo.timeSaleClose = tbWareInfo.timeSaleClose or ""; -- 结束销售时间
	tbWareInfo.DiscountStart = tbWareInfo.DiscountStart or ""; -- 开始优惠时间
	tbWareInfo.DiscountClose = tbWareInfo.DiscountClose or ""; -- 结束优惠时间
	tbWareInfo.dwTimeout = tbWareInfo.dwTimeout or 0; -- 超时时间（记录的是分钟数）
	tbWareInfo.nTimeFrameStartSale = tbWareInfo.nTimeFrameStartSale or 0; -- 根据时间轴，物品开始销售时间，天
	tbWareInfo.nTimeFrameEndSale = tbWareInfo.nTimeFrameEndSale or 0; -- 根据时间轴，物品结束销售时间，天
	tbWareInfo.Ware_Describe = tbWareInfo.Ware_Describe or ""; -- 商品描述
	tbWareInfo.Consumed = tbWareInfo.Consumed or 0; -- 标记商品的消耗计算方式
	
	return tbWareInfo;
end

-- 在gc关闭的时候，把存在buff当中的在线指令存盘
function IbShop:SaveBuf()
	if (self.tbIbshopCmdBuff) then
		SetGblIntBuf(GBLINTBUF_IBSHOP_CMDBUF, 0, 1, self.tbIbshopCmdBuff);
	end
end

-- gc启动时，从buff当中读取ibshop的在线指令并执行
function IbShop:ExecuteBuf()
	self.tbIbshopCmdBuff = GetGblIntBuf(GBLINTBUF_IBSHOP_CMDBUF, 0, 1);
	if (self.tbIbshopCmdBuff) then
		self:ExecuteIbshopCmdBuf(self.tbIbshopCmdBuff);
	end
end

-- 在加载脚本的时候，把warelist当中的商品信息读取到内存当中
function IbShop:PreLoadWareInfo()
	self.tbPreloadWareInfo = {};
	local tbWare = Lib:LoadTabFile("\\setting\\ibshop\\warelist.txt");
	for _, tbData in pairs(tbWare) do
		local nId = tonumber(tbData["WareId"]);
		self.tbPreloadWareInfo[nId] = tbData;
	end
end

IbShop:PreLoadWareInfo();

--GCEvent:RegisterGCServerStartFunc(IbShop.ExecuteBuf, IbShop);
GCEvent:RegisterGCServerShutDownFunc(IbShop.SaveBuf, IbShop);
GCEvent:RegisterGCServerStartFunc(IbShop.StartEvent, IbShop);
GCEvent:RegisterGCServerShutDownFunc(IbShop.ServerendEvent, IbShop);
