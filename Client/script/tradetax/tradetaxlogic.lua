
function TradeTax:CalcTradeTax(pPlayer, nCurMount, nMoney, bSendMsg)
	if nMoney <= 0 then
		return 0;
	end
	
	self:CheckTaxReagion();	
	local nTempMoney = nMoney;
	local nBegin = 0;
	local nTax = 0;
	for i = 1, #self.TAX_REGION do
		if self.TAX_REGION[i][1] <= nCurMount then
			nBegin = i;				-- 寻找起始税区
		end
	end
	nBegin = nBegin + 1;
	local nRemain = nMoney;
	if self.TAX_REGION[nBegin] then
		nRemain = self.TAX_REGION[nBegin][1] - nCurMount; -- 该税区剩余额
	end
	local szMsg = "";
	if nBegin == 1 then		-- 免税区输出信息特殊，所以特殊处理
		if nRemain >= nMoney then
			szMsg = string.format("Lần này đã thu nhập được %s lượng miễn thuế, tiền miễn thuế của bạn còn %s lượng", nTempMoney, nRemain - nTempMoney);
			nTempMoney = 0;
			nRemain = 0;
		else
			szMsg = string.format("Lần này đã thu nhập được %s lượng miễn thuế, tiền miễn thuế của bạn còn %s lượng", nRemain, 0);
			nTempMoney = nTempMoney - nRemain;
			nRemain = self.TAX_REGION[2][1] - self.TAX_REGION[1][1];
		end
		nBegin = 2;
		if (bSendMsg == 1) then
			pPlayer.Msg(szMsg);
		end
	end
	for i = nBegin, #self.TAX_REGION do
		if nTempMoney > 0 then
			if nRemain >= nTempMoney then
				nTax = nTax + nTempMoney * self.TAX_REGION[i][2];
				nTempMoney = 0;
				nRemain = 0;
			else
				nTax = nTax + nRemain * self.TAX_REGION[i][2];
				nTempMoney = nTempMoney - nRemain;
				if self.TAX_REGION[i + 1] and nTempMoney > 0 then
					nRemain = self.TAX_REGION[i + 1][1] - self.TAX_REGION[i][1];	-- 下一税区剩余额等与下一税区的值宽
				else
					nRemain = nTempMoney;
				end
			end
		end
	end
	if nRemain > 0 then
		nTax = nTax + self.TAX_REGION_MAXNUMBER * nRemain;
	end
	nTax = math.floor(nTax);
	return nTax;
end

if MODULE_GC_SERVER or MODULE_GAMESERVER then
	
function TradeTax:CheckTaxReagion()
	if (self.TAX_CHANGED == 1) then
		return;
	end
	self:AmendmentTaxRegion();
end

function TradeTax:AmendmentTaxRegion()
	local nYear = tonumber(os.date("%Y", GetTime()));
	if (nYear <= 2008) then
		return;
	end
	local nRate = KJbExchange.GetPrvWeekAvgPrice();
	if (nRate < 100) then
		nRate = 100;
	elseif (nRate > 200) then -- 最大上限
		nRate = 200;
	end
	for i = 1, 5 do
		self.TAX_REGION[i][1] = math.ceil(self.ORIG_TAX_REGION[i][1] * nRate / 100);
	end
	self.TAX_CHANGED = 1;
end

end
