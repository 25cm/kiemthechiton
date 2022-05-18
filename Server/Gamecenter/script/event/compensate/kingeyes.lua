-- 文件名　：kingeyes.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-09-17 14:59:13
-- 描  述  ：

SpecialEvent.CompensateGM = SpecialEvent.CompensateGM or {};
SpecialEvent.CompensateGM.KingEyes = SpecialEvent.CompensateGM.KingEyes or {};
local tbEyes = SpecialEvent.CompensateGM.KingEyes;

tbEyes.ExeFunList = {
	--key = {类型（1执行，2检查）,函数,参数个数,判断类型(1.背包空间, 2.银两, 3.绑定银两)}
	["AddItem"] 		= {1, "AddItem", 		-1, 1},		--物品
	["AddMoney"] 		= {1, "AddMoney", 		-1, 2},		--银两
	["AddBindMoney"] 	= {1, "AddBindMoney", 	-1, 3},		--绑定银两
	["AddBindCoin"] 	= {1, "AddBindCoin", 	-1, 0},		--绑定金币
	["AddTitle"] 		= {1, "AddTitle", 		-1, 0},		--＋称号
	["DelTitle"] 		= {1, "DelTitle", 		-1, 0},		--－称号
	["AddTongMoney"] 	= {1, "AddTongMoney", 	-1, 0},		--帮会资金
	["AddSpeTitle"] 	= {1, "AddSpeTitle", 	-1, 0},		--＋自定义称号
	["DelSpeTitle"]		= {1, "DelSpeTitle", 	-1, 0},		--－自定义称号
	["AddTaskRepute"] 	= {1, "AddTaskRepute", 	-1, 0},		--＋声望
	["DelBaiJuTime"] 	= {1, "DelBaiJuTime", 	-1, 0},		--－白驹时间
	["AddKinRepute"] 	= {1, "AddKinRepute", 	-1, 0},		--江湖威望
	["DelTaskRepute"] 	= {1, "DelTaskRepute",	-1, 0},		--－声望
	["SetLuaScript"]	= {1, "SetLuaScript",	-1, 0},		--指令
	["AddBaseExp"]		= {1, "AddBaseExp",		-1, 0},		--基准经验
	["AddExp"]			= {1, "AddExp",			-1, 0},		--经验
	["AddFactionExSum"]	= {1, "AddFactionExSum",-1, 0},		--辅修机会
	["AddSkillBuff"]	= {1, "AddSkillBuff",	-1, 0},		--技能buff
	["AddBuyHeShiBiSum"]= {1, "AddBuyHeShiBiSum",-1,0},		--购买和氏壁机会
	["AddExOpenFuDai"]	= {1, "AddExOpenFuDai",	-1,	0},		--增加额外开福袋机会
	["AddExOpenQiFu"]	= {1, "AddExOpenQiFu",	-1,	0},		--增加额外祈福机会
	["MinusKinRepute"]	= {1, "MinusKinRepute",	-1,	0},		--减少江湖威望
	["AddGTask"]		= {1, "AddGTask",		-1,	0},		--普通任务变量增加
	["SetGTask"]		= {1, "SetGTask",		-1,	0},		--普通任务变量设置
	["MinusGTask"]		= {1, "MinusGTask",		-1,	0},		--普通任务变量减少
	["AddXiulianTime"]	= {1, "AddXiulianTime",	-1,	0},		--增加修炼珠时间
	["GiveBazhuStatuary"]		= {1, "GiveBazhuStatuary",			-1,	0},	--获得树立霸主之印雕像资格
	["GiveKuaFuLianSaiStatuary"]= {1, "GiveKuaFuLianSaiStatuary",	-1,	0},	--获得树立跨服联赛雕像资格
	["AddHonor"]		= {1, "AddHonor",		-1,	0},		--增加荣誉值
	["ClearMarry"]		= {1, "ClearMarry",		-1,	0},		--清除预定婚礼，并扣除礼包
	["DelItem"]			= {1, "DelItem", 		-1, 0},		--扣除物品，自检查物品是否存在
};
--转换参数函数（做参数检查）
function tbEyes:TransParam(szKey, szParam)
	
	if not szKey or not szParam then
		return "";
	end
	if not self.ExeFunList[szKey] then
		print("【kingeyes】Error,没有这个Key值", szKey, szParam);
		return "";
	end
	szParam = Lib:ClearStrQuote(szParam);
	local szString = "";
	szParam = string.gsub(szParam,[[\\]], "<&xiegan>");
	szParam = string.gsub(szParam,[[\|]], "<&shuxian>");
	local tbParam = Lib:SplitStr(szParam, "|");	
	if self.ExeFunList[szKey][3] >= 0 and #tbParam > self.ExeFunList[szKey][3] then
		print("【kingeyes】Error,参数不对", szKey, szParam);
		return "";
	end
	for i = 1 , #tbParam  do
		local szParam1 = tbParam[i] or "";
		szParam1 = string.gsub(szParam1,"<&xiegan>", [[\]]);
		szParam1 = string.gsub(szParam1,"<&shuxian>", [[|]]);
		szParam1 = string.format([["%s"]],szParam1);
		
		if i ~= #tbParam then	
			szString = szString..szParam1..",";
		else
			szString = szString..szParam1;
		end
	end	
	return szString;
end

--转换成活动系统参数类型
function tbEyes:TransManagerFun(szKey, szParam)
	if not szKey or not szParam then
		return "";
	end
	if not self.ExeFunList[szKey] then
		print("【kingeyes】Error,没有这个Key值", szKey, szParam);
		return "";
	end	
	local szTransParam = self:TransParam(szKey, szParam)
	local szManagerFun = self.ExeFunList[szKey][2] .. ":" .. szTransParam;
	return szManagerFun;
end

function tbEyes:CheckFun(szFun, szParam)
	if EventManager.tbFun.tbLimitParamFun[szFun] and EventManager.tbFun.tbLimitParamFun[szFun] then
		return EventManager:CheckszFun(szFun, szParam);
	end
end

--执行函数
function tbEyes:DoFun(szKey, szParam)
	if not self.ExeFunList[szKey] then
		print("【kingeyes】Error,没有这个Key值", szKey, szParam);
		return 0;
	end
	local nType = self.ExeFunList[szKey][1];
	local szFun	= self.ExeFunList[szKey][2];
	if nType == 1 then			
		local nFlag = EventManager:ExeszFun(szFun, szParam);
		return nFlag;
	end		
	if nType == 2 then
		local nFlag, szMsg = EventManager:CheckszFun(szFun, szParam);
		if nFlag == 1 then
			return 0, szMsg;
		end
		return 1;
	end
	return 0;
end
