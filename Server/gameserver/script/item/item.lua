-- Item脚本类

Require("\\script\\item\\define.lua");

------------------------------------------------------------------------------------------
-- initialize

-- Item基础模板，详细的在default.lua中定义
if not Item.tbClassBase then
	Item.tbClassBase = {};
end

-- 防止重载脚本的时候模板库丢失
if not Item.tbClass then
	-- Item模板库
	Item.tbClass =
	{
		-- 默认模板，可以提供直接使用
		["default"]	= Item.tbClassBase,
		[""]		= Item.tbClassBase,
	};
end


Item.TASK_OWNER_TONGID = 1; -- General Info里的第一项记录绑定的帮会ID

--货币单位显示
Item.tbTipPriceUnit = 
{
	[1] = "银两",		--银两
	[2] = "",			--福缘
	[3] = "个%s",		-- 金币替代物品（魂石，月影之石，情花等）
	[4] = "军需点",		--积分
	[5] = "",			--贡献度
	[6] = "",			--联赛荣誉点数
	[7] = "绑定银两",			--绑定银两
	[8] = "点机关耐久度",		--机关耐久度货币类型
	[9] = "帮会建设资金",		-- 帮会建设资金
	[10]= "%s",					-- 数值货币
}
------------------------------------------------------------------------------------------
-- interface

-- 系统调用，默认的道具生成信息初始化（服务端&客户端）
function Item:InitGenInfo(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:InitGenInfo();
end

-- 系统调用，检查是否允许使用道具（服务端&客户端）
function Item:CheckUsable(szClassName)
	local nMapId = -1;
	if (MODULE_GAMESERVER) then
		nMapId = me.nMapId;
	else
		nMapId = me.nTemplateMapId;
	end
	
  	local nCanUse, szMsg = self:CheckIsUseAtMap(nMapId, it.dwId);
	if nCanUse ~= 1 then
		me.Msg(szMsg);
		return 0;
	end

	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:CheckUsable();
end

-- 当右键点击任何一个物品时，都会调用这里（仅限服务端）
function Item:OnUse(szClassName, nParam)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:OnUse(nParam);
end

function Item:OnClientUse(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:OnClientUse();
end

-- 当鼠标移动到任何一个物品图标上时，都触发这里获取Tip（客户端）
function Item:GetTip(szClassName, nState, szBindType)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	
	local szTip = "";
	local nTipState = nState;
	local nShopId = me.GetShopId();
	if (nState == Item.TIPS_SHOP) and Shop:GetGoods(nShopId, it.nIndex) then
		nTipState = Item.TIPS_GOODS;
	end
	
	local tbEnhRandMASS, tbEnhEnhMASS, nEnhStarLevel, nEnhNameColor;
	if tbClass.CalcEnhanceAttrib then		-- TODO: zyh: 很龊的方法……暂时先这样做
		tbEnhRandMASS, tbEnhEnhMASS, nEnhStarLevel, nEnhNameColor = tbClass:CalcEnhanceAttrib(nTipState);
		local szTitel = tbClass:GetTitle(nTipState, nEnhNameColor);
		szTip = szTip..tbClass:GetTip(nTipState, tbEnhRandMASS, tbEnhEnhMASS);
		if szTip and szTip ~= "" then
			szTip = "\n\n"..szTip;
		end
		szTip = self:Tip_Prefix(nTipState, 0, szBindType)..szTip..self:Tip_Suffix(nState);
		return szTitel, szTip, it.szViewImage;
	else
		local szTitel = tbClass:GetTitle(nTipState); --物品名称
		local szTip = "";
		szTip = szTip..tbClass:GetTip(nTipState);
		if szTip and szTip ~= "" then
			szTip = "\n\n"..szTip;
		end
		szTip = self:Tip_Prefix(nTipState, 0, szBindType)..szTip..self:Tip_Suffix(nState);
		return szTitel, szTip, it.szViewImage;
	end
end

function Item:GetCompareTip(szClassName, nState, szBindType)
	local szTitle, szTip, szPic = self:GetTip(szClassName, nState, szBindType);
	local szCmpTitle = "";
	local szCmpTip = "";
	local szCmpPic = "";
	if it.IsEquip() == 1 then
		local nEquipPos = it.nEquipPos;
		local pItem = me.GetItem(Item.ROOM_EQUIP, nEquipPos, 0);
		if pItem and pItem.dwId ~= it.dwId then
			szCmpTitle, szCmpTip, szCmpPic = pItem.GetTip(Item.TIPS_NORMAL);
			szCmpTip = szCmpTip.."\n<color=yellow><当前装备><color>";
		end
	end
	return szTitle, szTip, szPic, szCmpTitle, szCmpTip, szCmpPic;
end

-- 判断一个物品是否可以被拣起（服务端）
function Item:IsPickable(szClassName, nObjId)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:IsPickable(nObjId);
end

-- 当一个物品被拣起时会处理这里，同决定是否删除该物品（服务端）
function Item:PickUp(szClassName, nX, nY)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:PickUp(nX, nY);
end

-- 计算道具价值量相关信息，仅在道具生成时执行一次
-- 返回值：价值量，价值量星级，名字颜色，透明图层路径
function Item:CalcValueInfo(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return tbClass:CalcValueInfo();
end

-----------------------------------------------------------------------------------------
-- public

-- 取得特定类名的Item模板
function Item:GetClass(szClassName, bNotCreate)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) and (bNotCreate ~= 1) then		-- 如果没有bNotCreate，当找不到指定模板类时会自动建立新模板类
		tbClass	= Lib:NewClass(self.tbClassBase);	-- 新模板从父模板类派生
		self.tbClass[szClassName] = tbClass;		-- 加入到模板库里面
	end
	return	tbClass;
end

-- 继承特定类名的Item模板
function Item:NewClass(szClassName, szParent)
	if (self.tbClass[szClassName]) then				-- 指定模板类必须还不存在
		print("[ITEM] 类"..tostring(szClassName).."已存在，请检查脚本！");
		return;
	end
	local tbParent = self.tbClass[szParent];
	if (not tbParent) then							-- 父模板类必须已经存在
		print("[ITEM] 父类"..tostring(szParent).."不存在，请检查脚本！");
		return;
	end
	local tbClass = Lib:NewClass(tbParent);			-- 从父模板类派生
	self.tbClass[szClassName] = tbClass;			-- 加入到模板库里面
	return	tbClass;
end

-- 转换装备位置为对应的切换装备位置
function Item:EqPos2EqExPos(nEquipPos)
	if (nEquipPos < 0) or (nEquipPos > self.EQUIPEXPOS_NUM) then
		return	-1;
	end
	return	nEquipPos;
end

-- 转换切换装备位置为对应的装备位置
function Item:EqExPos2EqPos(nEquipExPos)
	if (nEquipExPos < 0) or (nEquipPos > self.EQUIPEXPOS_NUM) then
		return	-1;
	end
	return	nEquipExPos;
end

function Item:IsTry(nEquipPos)
	if (nEquipPos >= Item.EQUIPPOS_HEAD and nEquipPos <= Item.EQUIPPOS_MASK) then
		return 1;
	else
		return 0;
	end
end

-- 把剑侠币数值格式化为字符串（显示“万”、“亿”等字）
function Item:FormatMoney(nMoney)
	local szMoney = "";
	if (not nMoney) or (nMoney < 0) then
		return	"无效";								-- 价钱小于0，出错
	end
	if (nMoney >= 100000000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 100000000)).."亿";
		nMoney = nMoney % 100000000;
	end
	if (nMoney >= 10000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 10000)).."万";
		nMoney = nMoney % 10000;
	end
	if (nMoney > 0) then
		szMoney = szMoney..tostring(nMoney);
	end
	if (szMoney == "") then
		szMoney = "0";
	end
	return	szMoney;
end

function Item:Tip_FixSeries()
	local szTip = "\n推荐"
	if Item.tbSeriesFix[it.nEquipPos] and it.nSeries > 0 then
		return szTip..Item.TIP_SERISE[Item.tbSeriesFix[it.nEquipPos][it.nSeries]].."使用";
	end
	return "";
end

function Item:FindFreeCellInRoom(nRoom, nWidth, nHeight)
	for nY = 0, nHeight - 1 do
		for nX = 0, nWidth - 1 do
			if me.GetItem(nRoom, nX, nY) == nil then
				return nX, nY;
			end
		end
	end
end
function Item:FormatMoney2Style(nMoney)
	
	if (not nMoney) or nMoney < 0 then
		return "无效";
	end
	local k = 0;
  	local nFormatted = nMoney
  	while true do  
  	  nFormatted, k = string.gsub(nFormatted, "^(-?%d+)(%d%d%d)", '%1,%2')
   	 if (k==0) then
    	  break
    	end
  	end
  return nFormatted;
end

function Item:Tip_Prefix(nState, nEnhStarLevel, szBindType)
	local szPreTip = "";
	if it.IsEquip() == 1 then
		szPreTip = szPreTip..self:Tip_StarLevel(nState, nEnhStarLevel);
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);	-- 绑定状态
		szPreTip = szPreTip..self:Tip_Changeable(nState)..self:Tip_CanBreakUp(nState);  -- 可否兑换
		szPreTip = szPreTip..self:Tip_GetRefineLevel();
		szPreTip = szPreTip..self:Tip_FixSeries(nState);
	else
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);
		szPreTip = szPreTip..self:Tip_Changeable(nState);  -- 可否兑换
	end
	return szPreTip;
end

function Item:Tip_GetRefineLevel(nState)
	local szTip = " ";
	if it.nRefineLevel == 0 then
		return szTip.."未炼化";
	elseif it.nRefineLevel > 0 then
		return szTip.."炼化<color=gold>"..it.nRefineLevel.."<color>级"
	else
		return szTip.."不可炼化";
	end
end

function Item:Tip_Changeable(nState)
	local szTip = "\n";
	if (nState == Item.TIPS_PREVIEW) then
		return szTip;
	elseif (nState == Item.TIPS_BINDGOLD_SECTION) then
		return szTip.."不可兑换";
	end
	
	if Item:CalcChange({it}) > 0 then
		return szTip.."可兑换";
	else
		return szTip.."不可兑换";
	end
end

function Item:Tip_Suffix(nState)
	local szTip = "";
	szTip = szTip..self:Tip_Intro();
	szTip = szTip..self:Tip_UseTime();
	szTip = szTip..self:Tip_Help();
	szTip = szTip..self:Tip_ReqLevel();
	szTip = szTip..self:Tip_Price(nState);
	szTip = szTip..self:Tip_Timeout();
	return	szTip;
end

function Item:Tip_StarLevel(nState, nEnhStarLevel)	-- 获得Tip字符串：装备价值量星级
	local tbSetting = Item.tbExternSetting:GetClass("value");
	--if (nState == Item.TIPS_PREVIEW) then
	--	return	"";			-- 属性预览状态时不显示价值量星级
	--end

	local szTip = "\n  ";
	local nStarLevel = it.nStarLevel;
	local szFillStar = "";
	local szEmptyStar = "";
	if tbSetting and tbSetting.m_tbStarLevelInfo and tbSetting.m_tbStarLevelInfo[nStarLevel] then
		szFillStar = string.format("<pic=%s>", tbSetting.m_tbStarLevelInfo[nStarLevel].nFillStar - 1);
		szEmptyStar = string.format("<pic=%s>", tbSetting.m_tbStarLevelInfo[nStarLevel].nEmptyStar - 1);
	else
		szFillStar = "★";
		szEmptyStar = "☆";
	end

	for i = 1, math.floor(nStarLevel / 2) do
		szTip = szTip..szFillStar;
		if i % 3 == 0 then
			szTip = szTip.." ";
		end
	end
	if (it.nStarLevel % 2 ~= 0) then
		szTip = szTip..szEmptyStar;
	end
	return	szTip;

end

function Item:Tip_BindInfo(nState, szBindType)
	local szTip = "";
	if it.IsEquip() == 1 then
		local nPos = KItem.EquipType2EquipPos(it.nDetail)
		szTip = Item.EQUIPPOS_NAME[nPos];
		if nPos == self.EQUIPPOS_WEAPON and self.WEAPON_NAME[it.nEquipCategory] then
			szTip = szTip.."（"..self.WEAPON_NAME[it.nEquipCategory].."） ";
		else
			szTip = szTip.." ";
		end
	end
	local nShopId = me.GetShopId();
	local nGoodsId = Shop:GetGoods(nShopId, it.nIndex);
	local nCurrencyType	= 0;
	if (nGoodsId) then		-- 只有买入时有不同的货币单位
		nCurrencyType	= me.nCurrencyType;
	end
	
	if (szBindType) then
		szTip = szTip..szBindType;
	elseif (nState == Item.TIPS_GOODS and nGoodsId and (KItem.IsGetBindType(nGoodsId) == 1 or nCurrencyType == 7)) then
		szTip	= szTip.."获取绑定";
	else
		local nBindType = it.nBindType;
		if (nState == Item.TIPS_BINDGOLD_SECTION) then
			szTip = szTip.."获取绑定";
	
		elseif (nState ~= Item.TIPS_PREVIEW) and (1 == it.IsBind()) then	-- 属性预览状态时只按照nBindType显示
			szTip = szTip.."已绑定";
		elseif	(Item.BIND_NONE  == nBindType or Item.BIND_NONE_OWN == nBindType) then
			szTip = szTip.."不绑定";
		elseif	(Item.BIND_GET   == nBindType) then
			szTip = szTip.."获取绑定";
		elseif	(Item.BIND_EQUIP == nBindType) then
			szTip = szTip.."装备绑定";
		elseif  (Item.BIND_OWN == nBindType) then
			szTip = szTip.."获取绑定";
		end
	end
	if szTip ~= "" then
		szTip = "\n"..szTip;
	end
	return	szTip;
end

function Item:Tip_CanBreakUp(nState)
	local szTip = "";
	local nGTPCost, tbStuff, tbExp = Item:CalcBreakUpStuff(it);
	if (nGTPCost <= 0) or (#tbStuff <= 0) then
		szTip = szTip.." 不可拆解";
	else
		szTip = szTip.." 可拆解"
	end
	if szTip ~= "" then
		szTip = ""..szTip;
	end
	return	szTip;
end

function Item:Tip_Intro()
	local szIntro = it.szIntro;	
	if szIntro and szIntro ~= "" then
		return "\n\n"..szIntro;
	end
	return "";
end

function Item:Tip_Help()			-- 获得Tip字符串：帮助文字
	if it.szHelp and it.szHelp ~= ""then
		return	"\n\n"..it.szHelp;
	end
	return "";
end

function Item:Tip_UseTime()		-- 获得Tip字符串：使用时间
	local szTip = "";
	local nTime = GetCdTime(it.nCdType) / Env.GAME_FPS;

	if (nTime ~= 0) then

		local nHour = math.floor(nTime / 3600);
		nTime = nTime % 3600;
		local nMin  = math.floor(nTime / 60);
		nTime = nTime % 60;
		local nSec  = math.floor(nTime * 10) / 10;		-- 精确到小数点后一位

		local szTime = "";
		if (nHour ~= 0) then
			szTime = szTime..nHour.."小时";
		end
		if (nMin ~= 0) then
			szTime = szTime..nMin.."分";
		end
		if (nSec ~= 0) then
			szTime = szTime..nSec.."秒";
		end

		szTip = "\n\n"..szTip.."使用时间间隔："..szTime;

	end

	return	szTip;
end

function Item:Tip_ReqLevel()

	if (it.nReqLevel <= 0) then
		return	"";
	end

	local szTip = "";
	local nRed = 0;

	if (me.nLevel < it.nReqLevel) then
		nRed = 1;
	end

	if (nRed == 1) then
		szTip = szTip.."<color=red>";
	end

	szTip = "\n"..szTip.."使用等级需求："..it.nReqLevel.."级";

	if (nRed == 1) then
		szTip = szTip.."<color>";
	end

	return	szTip;

end

--临时增加使用, 2008.11.18后将被删除 dzh
function Item:SendDisableTrade(szMsg)
	--me.Msg("由于披风过于贵重，运送过程需十分小心，因此最近一批披风要等到最近一次维护后才能送到。");
end

function Item:Tip_Price(nState)
	
	local szTip = "";
 	local szUnit = "";
	
	if (nState == Item.TIPS_SHOP) then	-- NPC交易状态显示物品价格
		local nShopId = me.GetShopId();
		local pGoodsId = Shop:GetGoods(nShopId, it.nIndex);
		
		local nCurrencyType	= 1;	-- 卖出永远是剑侠币
		if pGoodsId then		-- 只有买入时有不同的货币单位
			nCurrencyType = me.nCurrencyType;
		end

		szUnit = self.tbTipPriceUnit[nCurrencyType] or "";
		szTip = szTip.."<color=yellow>";

		if pGoodsId then
			local tbGoods = me.GetShopBuyItemInfo(pGoodsId);
			local nPrice = tbGoods.nPrice;
			local nCamp = tbGoods.nReputeCamp;
			local nClass = tbGoods.nReputeClass; 
			local nLevel = tbGoods.nReputeLevel;
			local nRequireHonor = tbGoods.nHonour;
			local nOfficialLevel = tbGoods.nOfficialLevel;
			local nEnergy = tbGoods.nEnergy;

			-- 实物货币单位
			if (nCurrencyType == 3) then
				local nItemCoinIndex = tbGoods.ItemCoinIndex;
				if (szUnit ~= "") then
					szUnit = string.format(szUnit, Shop:GetItemCoinUnit(nItemCoinIndex));
				end
			end
			
			-- 数值货币单位
			if (nCurrencyType == 10) then
				local nValueCoinIndex = tbGoods.ValueCoinIndex;
				if (szUnit ~= "") then
					szUnit = string.format(szUnit, Shop:GetValueCoinUnit(nValueCoinIndex));
				end
			end
			
			szTip = "\n\n"..szTip.."<color=yellow>买入价格："..self:FormatMoney(nPrice)..szUnit.."<color>";
			if nCurrencyType == 9 and nEnergy > 0 then
				szTip = szTip..string.format("\n消耗 %d点帮会行动力", nEnergy);
			end
			-- 声望需求
			local bConditionLevel = false;
			if nLevel > 0 then
				bConditionLevel = true;
				local tbInfo = KPlayer.GetReputeInfo();
				if me.GetReputeLevel(nCamp, nClass) >= nLevel then
					szTip = szTip.."\n\n<color=white>购买条件：";
				else
					szTip = szTip.."\n\n<color=red>购买条件：";
				end
				if tbInfo then
					szTip = szTip..tbInfo[nCamp][nClass].szName.."声望达到"..tbInfo[nCamp][nClass][nLevel].szName.."["..nLevel.."级]";
				else
					szTip = szTip.."声望需求未知";
				end
				szTip = szTip.."<color>";
			end
			
			--增加荣誉支持
			--local nRequireHonor = 0 --debug
			if nRequireHonor > 0 then
				if me.GetHonorLevel() >= nRequireHonor then
					szTip = szTip.."\n<color=white>";
				else
					szTip = szTip.."\n<color=red>";
				end
				if bConditionLevel == false then
					szTip = szTip.."\n购买条件：";
				end
				
				local strcondfmt = "\n以下任意一项满足\n武林荣誉达到%d级\n财富荣誉达到%d级\n领袖荣誉达到%d级";
				local strcond = string.format(strcondfmt, nRequireHonor, nRequireHonor, nRequireHonor); 
				szTip = szTip..strcond;
				
				szTip = szTip.."<color>";
			end
			if nOfficialLevel > 0 then
				local nLevel = me.GetOfficialLevel()
				local szColor = "white";
				if nOfficialLevel > nLevel then
					szColor = "red";
				end
				szTip = szTip..string.format("\n<color=%s>官衔等级到达%d级<color>", szColor, nOfficialLevel);
			end
		else
			local nPrice = me.GetRecycleItemPrice(it)
			if nPrice then
				szTip = "\n"..szTip.."<color=yellow>回购价格："..nPrice..szUnit.."<color>";
			else
				nPrice = GetSalePrice(it);
				if it.IsForbitSell() == 1 then
					szTip = "\n<color=red>不可出售<color>";
				else
          --卖道具需要判断道具的绑定属性
					if 1 == it.IsBind() then
					  szUnit = "绑定银两";
					else
					  szUnit = "银两";
					end
					szTip = "\n"..szTip.."<color=yellow>卖出价格："..self:FormatMoney(nPrice)..szUnit.."<color>";
					if it.nEnhTimes > 0 then -- 强化过的装备不能售店
						szTip = szTip.."<color=red>（不能售店）<color>";
					end
				end
			end
		end
		
	elseif (nState == Item.TIPS_STALL) then			-- 摆摊状态显示摆摊信息

		local nPrice = me.GetStallPrice(it);		-- 先看是不是自己摆摊的东西

		if not nPrice then							-- 如果不是，看看是不是别人摆摊的东西
			local _, _, tbInfo = me.GetOtherStallInfo();
			if tbInfo then
				for i = 1, #tbInfo do
					if (tbInfo[i].uId == it.nIndex) and (tbInfo[i].nPrice >= 0) then
						nPrice = tbInfo[i].nPrice;
						break;
					end
				end
			end
		end

		if nPrice then								-- 如果都不是，就不显示摆摊信息
			szUnit = self.tbTipPriceUnit[1];---摆摊交易都是银两单位
			szTip = "\n"..szTip.."<color=yellow>贩卖单价："..self:FormatMoney2Style(nPrice)..szUnit.."("..self:FormatMoney(nPrice)..szUnit..")<color>";
			local nTotal = nPrice * it.nCount;
			szTip =  szTip .. "\n<color=yellow>贩卖总价："..self:FormatMoney2Style(nTotal)..szUnit.."("..self:FormatMoney(nTotal)..szUnit..")<color>";
		end

	elseif (nState == Item.TIPS_OFFER) then			-- 收购状态显示收购信息

		local nPrice, nCount = me.GetOfferReq(it);	-- 先看是不是自己收购的东西

		if (not nPrice) or (not nCount) then		-- 如果不是，再看是不是别人收购的东西
			local _, _, tbInfo = me.GetOtherOfferInfo();
			if tbInfo then
				for i = 1, #tbInfo do
					if (tbInfo[i].uId == it.nIndex) and (tbInfo[i].nPrice >= 0) then
						nPrice = tbInfo[i].nPrice;
						nCount = tbInfo[i].nNum;
						break;
					end
				end
			end
		end

		if nPrice and nCount then					-- 如果都不是，不显示收购信息
			szUnit = self.tbTipPriceUnit[1];---摆摊交易都是银两单位
			szTip = "\n"..szTip.."<color=yellow>收购数量："..nCount.."个\n收购单价："..self:FormatMoney2Style(nPrice)..szUnit.."("..self:FormatMoney(nPrice)..szUnit..") <color>";
			local nTotal = nPrice * nCount;
			szTip =  szTip .. "\n<color=yellow>收购总价："..self:FormatMoney2Style(nTotal)..szUnit.."("..self:FormatMoney(nTotal)..szUnit..")<color>";
		end

	elseif (nState == Item.TIPS_NOBIND_SECTION or nState == Item.TIPS_BINDGOLD_SECTION) then
		local tbWareInfo = me.GetIbShopItemInfo(it.nIndex);
		if (tbWareInfo and tbWareInfo.nDiscount > 0) then
			local szTemp = "";
			if (tbWareInfo.nDiscountType == 0) then
				szTemp = tbWareInfo.nDiscount.."%";
			else
				if (tbWareInfo.nCurrencyType == 0) then
					szTemp = tbWareInfo.nDiscount .. IVER_g_szCoinName;
				elseif (tbWareInfo.nCurrencyType == 1) then
					szTemp = tbWareInfo.nDiscount .. "银两";
				elseif (tbWareInfo.nCurrencyType == 2) then
					szTemp = tbWareInfo.nDiscount .. "绑定"..IVER_g_szCoinName;
				else
					assert(false);
				end
			end
			if (tbWareInfo.nDiscStart ~= tbWareInfo.nDiscEnd and GetTime() <= tbWareInfo.nDiscEnd) then
				local szStartDate = os.date("%Y年%m月%d日 %H:%M:%S", tbWareInfo.nDiscStart);
				local szEndDate  = os.date("%Y年%m月%d日 %H:%M:%S", tbWareInfo.nDiscEnd);
				szTip = szTip..string.format("\n\n<color=yellow>优惠%s\n优惠开始时间：%s\n优惠结束时间：%s<color>",szTemp,szStartDate,szEndDate);
			end
		end
	end
		
	return	szTip;

end

function Item:Tip_Timeout()			-- 超时时间
	
	local szTip = "";
	local tbAbsTime = me.GetItemAbsTimeout(it);

	if tbAbsTime then
		local strTimeout = string.format("<color=yellow>此物品的使用时间至：%d年%d月%d日%d时%d分。<color>",
			tbAbsTime[1],
			tbAbsTime[2],
			tbAbsTime[3],
			tbAbsTime[4],
			tbAbsTime[5]);
		szTip = "\n\n"..szTip..strTimeout;
	else
		local tbRelTime = me.GetItemRelTimeout(it);
		if tbRelTime then
			local strTimeout = string.format("<color=yellow>此物品剩余的使用时间为：%d天%d时%d分。<color>",
				tbRelTime[1],
				tbRelTime[2],
				tbRelTime[3]);
			szTip = "\n\n"..szTip..strTimeout;
		end
	end

	return	szTip;

end

--地图,物品限制,禁止在当前地图使用
function Item:CheckIsUseAtMap(nMapId, ...)
	local nCheck, szMsg, szMapClass, szItemClass = self:CheckForBidItemAtMap(nMapId, unpack(arg));
	if not nCheck or nCheck == 0 then
		return nCheck, szMsg;
	end
	if nCheck == 2 then
		return 1;
	end
	
	if Map.tbMapItemState[szMapClass].tbForbiddenUse[szItemClass] ~= nil then
		return 0, "该道具禁止在本地图使用";
	end
	
	return 1;
end

--召唤类调用,是否允许自己被别人召唤出地图,[禁止被召唤出去]
--(为了清晰召出和召入分开2个函数，而不选择通过参数来进行判断的做法。)
function Item:IsCallOutAtMap(nMapId, ...)
	local nCheck, szMsg, szMapClass, szItemClass = self:CheckForBidItemAtMap(nMapId, unpack(arg));
	if not nCheck or nCheck == 0 then
		return nCheck, szMsg;
	end
	if nCheck == 2 then
		return 1;
	end
	
	if Map.tbMapItemState[szMapClass].tbForbiddenUse[szItemClass] ~= nil then
		return 0, "该道具禁止在本地图使用";
	end
	return 1;
end

--召唤类调用,是否允许召唤别人进入地图和 是 否允许使用物品传入地图
function Item:IsCallInAtMap(nMapId, ...)
	local nCheck, szMsg, szMapClass, szItemClass = self:CheckForBidItemAtMap(nMapId, unpack(arg));
	if not nCheck or nCheck == 0 then
		return nCheck, szMsg;
	end
	if nCheck == 2 then
		return 1;
	end

	if Map.tbMapItemState[szMapClass].tbForbiddenCallIn[szItemClass] ~= nil then
		return 0, "该道具禁止在本地图使用";
	end
	return 1;
end

Item.ForBidUseAtMap = {
	["mask"]= "MASK";
}

function Item:CheckForBidItemAtMap(nMapId, ...)
	local szItemClass = "";
	if #arg == 4 then
		szItemClass = KItem.GetOtherForbidType(unpack(arg)) or "";
	elseif #arg == 1 then
		if type(arg[1]) == "string" then
			szItemClass = arg[1] or "";
		elseif type(arg[1]) == "number" then
			local pItem = KItem.GetObjById(arg[1]);
			if pItem == nil then
				return 0, "该道具禁止在本地图使用";
			end
			if self.ForBidUseAtMap[pItem.szClass] then
				szItemClass = self.ForBidUseAtMap[pItem.szClass];
			else
				szItemClass = pItem.GetForbidType() or "";
			end
		else
			return 0, "该道具禁止在本地图使用";
		end		
	else
		return 0, "该道具禁止在本地图使用";
	end
	
	if (self:CheckDynamicForbiden(nMapId, szItemClass) == 1) then
		return 0, "该道具禁止在本地图使用";
	end

	local szMapClass = GetMapType(nMapId) or "";

	if Map.tbMapItemState[szMapClass] == nil then
		return 2, "", szMapClass, szItemClass;	
	end
	if Map.tbMapProperItem[szItemClass] then 
		 if Map.tbMapProperItem[szItemClass] ~= szMapClass then
			--该物品为仅允许.
			local szInfo = Map.tbMapItemState[Map.tbMapProperItem[szItemClass]].szInfo;
			local szMsg = "该道具禁止在本地图使用";
			if szInfo ~= "" then
				szMsg = "该道具仅允许在" .. szInfo .."使用";
			end
			return 0, szMsg;
		else
			return 1,"", szMapClass, szItemClass;
		end
	end
	
	if Map.tbMapItemState[szMapClass].tbForbiddenUse["ALL_ITEM"]  then
		return 0, "该道具禁止在本地图使用";
	end
	
	return 1, "", szMapClass, szItemClass;	
end


function Item:IsEquipRoom(nRoom)
	if nRoom == Item.ROOM_EQUIP or nRoom == Item.ROOM_EQUIPEX then
		return 1;
	end
	return 0;
end


-- UNDONE: Fanghao_Wu	临时代码，将药箱内药品数量*1.5，2008-9-1后删除！！！
function Item:OnLoaded(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (szClassName == "xiang" and tbClass) then
		tbClass:OnLoaded();
	end
end

function Item:ChangeEquipToFac(varEquip, nFaction)
	local pEquip
	if type(varEquip) == "userdata" then
		pEquip = varEquip;
	elseif type(varEquip) == "number" then
		pEquip = KItem.GetObjById(varEquip);
	else
		return 0;
	end
	if not pEquip then
		return 0;
	end
	local tbFacEquip = self:CheckCanChangable(pEquip);
	if not tbFacEquip then
		return 0;
	end
	local tbGDPL = tbFacEquip[nFaction];
	if (not tbGDPL) then
		return 0;
	end
	if (pEquip.nGenre == tbGDPL[1] and 
		pEquip.nDetail == tbGDPL[2] and  
		pEquip.nParticular == tbGDPL[3] and  
		pEquip.nLevel == tbGDPL[4]) then
		return 1;
	end
	return pEquip.Regenerate(
		tbGDPL[1],
		tbGDPL[2],
		tbGDPL[3],
		tbGDPL[4],
		pEquip.nSeries,
		pEquip.nEnhTimes,
		pEquip.nLucky,
		pEquip.GetGenInfo(),
		0,
		pEquip.dwRandSeed,
		pEquip.nStrengthen
	);
end

function Item:CheckCanChangable(pEquip)
	local tbSetting = Item:GetExternSetting("change", pEquip.nVersion, 1);
	local szGDPL = string.format("%d,%d,%d,%d", pEquip.nGenre, pEquip.nDetail, pEquip.nParticular, pEquip.nLevel);
	if not tbSetting.tbItemToChangeId or not tbSetting.tbItemToChangeId[szGDPL] then
		return;
	end
	local nId = tbSetting.tbItemToChangeId[szGDPL];
	if (not tbSetting.tbChange or 
		not tbSetting.tbChange[nId])then
		return;
	end
	return tbSetting.tbChange[nId];
end

-- 将道具与帮会绑定
function Item:BindWithTong(pItem, nTongId)
	if pItem then
		pItem.SetGenInfo(Item.TASK_OWNER_TONGID, nTongId);
		pItem.Sync();
		return 1;
	end
end

-- 检查该道具是否可以被某帮会成员使用
function Item:IsBindItemUsable(pItem, nTongId)
	if pItem then
		local nOwnerTongId = KLib.Number2UInt(pItem.GetGenInfo(Item.TASK_OWNER_TONGID, 0));
		if nOwnerTongId == 0 or nOwnerTongId == nTongId then
			return 1;
		end
		local pTong = KTong.GetTong(nOwnerTongId);
		if pTong then
			me.Msg("该道具已经和帮会["..pTong.GetName().."]绑定！");
		else
			me.Msg("该道具已经和其他帮会绑定！");
		end
		return 0;
	end
	return 0;
end


--检测动态注册的地图禁用，0：可用；1：不可用
function Item:CheckDynamicForbiden(nMapId, szClassName)
	local tbDynamicForbiden = Map.tbDynamicForbiden;
	if tbDynamicForbiden == nil or (tbDynamicForbiden[nMapId] == nil) then
		return 0;
	end
	if (tbDynamicForbiden[nMapId][szClassName] == nil) then
		return 0;
	end
	return 1;
end


--计算商品打折信息（对优惠券）
--返回值：打折商品数量，打折率
function Item:CalDiscount(szClassName, tbWareList)
	
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:CalDiscount(tbWareList);
end

--消耗使用次数
function Item:DecreaseCouponTimes(szClassName, tbCouponWare)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:DecreaseCouponTimes(tbCouponWare);
end

function Item:CanCouponUse(szClassName, dwId)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return tbClass:CanCouponUse(dwId);
end

