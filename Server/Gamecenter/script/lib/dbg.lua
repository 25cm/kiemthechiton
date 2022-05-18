-- 文件名　：dbg.lua
-- 创建者　：FanZai
-- 创建时间：2007-10-08 22:08:17
-- 文件说明：统一的调试模块，代替print、debug.traceback等

Dbg.tbDbgMode	= {	-- 所有需要调试的模块。类型：0、不调试；1、简单调试；2、全面调试
	["Timer"]		= 0,
	["PlayerTimer"]	= 0,
	["Mission"]		= 0,
	["Battle"]		= 0,
	["ClientEvent"]	= 0,
	["JbExchange"]  = 1,
};

-- 调试等级
Dbg.LOG_INFO		= 1;
Dbg.LOG_ATTENTION	= 2;
Dbg.LOG_WARNING		= 4;
Dbg.LOG_ERROR		= 8;


function Dbg:OnFunDeprecate(szNewFun)
	local szMsg	= string.format("deprecate function!!! please use '%s' instead.", szNewFun);
	print(debug.traceback(szMsg, 2));
end

-- 输出调试信息
function Dbg:Output(szMode, ...)
	local nType	= self.tbDbgMode[szMode];
	if (not nType or nType == 0) then
		return;
	end
	
	if (nType >= 1) then
		print("-DbgOut["..szMode.."]:", unpack(arg));
	end
	if (nType >= 2) then
		self:WriteLogEx(self.LOG_INFO, szMode, unpack(arg));
	end
end

-- 输出带堆栈的调试信息
function Dbg:PrintEvent(szMode, ...)
	local nType	= self.tbDbgMode[szMode];
	if (not nType or nType == 0) then
		return;
	end
	
	if (nType == 1) then
		print("-DbgEvent["..szMode.."]:", unpack(arg));
	elseif (nType >= 2) then
		print("-DbgEvent["..szMode.."]:", unpack(arg));
		local szTrace	= debug.traceback("DbgInfo", 3);
		print(szTrace);
		self:WriteLogEx(self.LOG_INFO, szMode, unpack(arg), Lib:ReplaceStr(szTrace, "\n", "\t"));
	end
end

-- 写入日志文件，默认ATTENTION级别
function Dbg:WriteLog(szMode, ...)
	self:WriteLogEx(self.LOG_ATTENTION, szMode, unpack(arg));
end

-- 写入日志文件，含等级信息
function Dbg:WriteLogEx(nLevel, szMode, ...)
	local nType	= self.tbDbgMode[szMode];
	if (nType and nType > 0) then
		print("-DbgLog["..szMode.."]:", unpack(arg));
	end

	local szMsg	= "["..szMode.."]\t"..table.concat(arg, "\t");
	if (WriteLog) then
		WriteLog(nLevel, szMsg);
	else
		print("[LOG]", nLevel, szMsg)
	end
end

