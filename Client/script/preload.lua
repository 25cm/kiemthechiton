
print("Begin load script files...");

function _DbgOut()
end

local tbData		= KLib.LoadTabFile("\\setting\\scripttable.txt");
local tbModuleBase	= { szModuleName = "__ModuleBase" };
local tbMoudleMT	= { __index	= tbModuleBase };
local tbModelSet	= {};
for nRow = 2, #tbData do
	local szModule	= tbData[nRow][1];
	tbModelSet[szModule]	= 1;
	_G[szModule]	= setmetatable({ szModuleName = szModule }, tbMoudleMT);
end
Env.tbModelSet		= tbModelSet;


function tbModuleBase:DbgOut(...)
	Dbg:Output(self.szModuleName, unpack(arg));
end
function tbModuleBase:WriteLog(nLevel, ...)
	Dbg:WriteLogEx(nLevel, self.szModuleName, unpack(arg));
end
function tbModuleBase:GetPlayerTempTable(pPlayer)
	return pPlayer.GetTempTable(self.szModuleName)
end


local function ClearStrQuote(szParam)
	if szParam == nil then
		szParam = "";
	end
	if string.len(szParam) > 1 then
		local nSit = string.find(szParam, "\"");
		if nSit and nSit == 1 then
			local szFlag = string.sub(szParam, 2, string.len(szParam));
			local szLast = string.sub(szParam, string.len(szParam), string.len(szParam));
			szParam = szFlag;
			if szLast == "\"" then
				szParam = string.sub(szParam, 1, string.len(szParam)-1);
			end
		end
	end
	szParam = string.gsub(szParam, "\"","\\\"");
	return szParam;
end


local tbFileData		= KLib.LoadTabFile("\\setting\\scriptvalue\\filelist.txt");
for nFileRow = 2, #tbFileData do
	local szTableName	= tbFileData[nFileRow][1];
	local tbTable		= _G[szTableName];
	if (not tbTable) then
		tbTable			= {};
		_G[szTableName]	= tbTable;
	end
	local szFilePath	= tbFileData[nFileRow][2];
	local tbValueData	= KLib.LoadTabFile(szFilePath);
	if (not tbValueData) then
		print(string.format("ScriptValue file \"%s\" not found!!!"));
		tbValueData		= {};
	end
	for nValueRow = 2, #tbValueData do
		local szName	= ClearStrQuote(tbValueData[nValueRow][1]);
		local szValue	= ClearStrQuote(tbValueData[nValueRow][2]);
		szValue = tonumber(szValue) or loadstring("return \"".. szValue.."\"")();
		tbTable[szName]	= szValue;
	end
end


if (not GetLocalDate) then	-- 临时解决GC没有对应函数
	GetLocalDate	= os.date;
end

dofile		= nil;
loadfile	= nil;
io			= nil;
math.random	= nil;
math.randomseed	= nil;
local old_time = os.time;
local old_date = os.date;

function os.time(arg)
	if arg then
		return old_time(arg);
	else
		print(debug.traceback("Tham số os.time không thể để trống, phải lấy thời gian local mới có thể sử dụng GetTime()"));
		return GetTime();
	end
end

function os.date(format, time)
	if not time then
		print(debug.traceback("Tham số thứ 2 os.date không thể để trống, có thể dùng GetTime() nhận thời gian local để làm tham số thứ 2 hoặc dùng GetLocalDate()"));
	end
	
	if not format then
		format = "%Y\\%m\\%d  %H:%M:%S";
	end
	
	if not time then
		time = GetTime();
	end
	
	return old_date(format, time);
end

local tbMetaTable	= {
	__newindex	= function (tb, key, value)
		if (key == "it" or key == "him" or key == "me") then
			rawset(_G, key, value);
		else
			error("Attempt create global value :"..tostring(key), 2);
		end;
	end,
};
setmetatable(_G, tbMetaTable);


Require("\\script\\lib\\lib.lua");
Require("\\script\\lib\\dbg.lua");
Require("\\script\\lib\\calc.lua");
Require("\\script\\common\\env.lua");
Require("\\script\\lib\\vfactory.lua");

