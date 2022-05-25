
Require("\\script\\misc\\globaltaskdef.lua");

GblTask.tbSwitchs	= {
	{"UI_PAYONLINE", 1},
	{"UI_HELPSPRITE_ZHIDAO", 1},
	{"UI_DAILY", 1},
	{"PAYONLINE_REFRESH_MONEY", 1},
	{"UI_HELPSPRITE_DOMAIN", 0},
};

assert(#GblTask.tbSwitchs <= 32, "Hiện có thể lập 32 mục");

function GblTask:GetUiFunSwitch(szSwitch)
	local nData  = KGblTask.SCGetDbTaskInt(DBTASD_UI_FUN_SWITCH);
	local nIndex = self:GetBitIndex(szSwitch);
	local nBit   = KLib.GetBit(nData, nIndex);
	local nOpen  = self:Bit2Open(nIndex, nBit);
	return nOpen;
end

function GblTask:SetUiFunSwitch(szSwitch, nOpen)
	local nData  = KGblTask.SCGetDbTaskInt(DBTASD_UI_FUN_SWITCH);
	local nIndex = self:GetBitIndex(szSwitch);
	local nBit   = self:Open2Bit(nIndex, nOpen);
	nData = KLib.SetBit(nData, nIndex, nBit);
	KGblTask.SCSetDbTaskInt(DBTASD_UI_FUN_SWITCH, nData);
end

function GblTask:Bit2Open(nIndex, nBit)
	assert(nBit == 0 or nBit == 1);
	local nDefault = self.tbSwitchs[nIndex][2];
	assert(nDefault == 0 or nDefault == 1);
	if(nBit == 0) then
		return nDefault;
	else
		return 1 - nDefault;	-- 1变0、0变1
	end
end

function GblTask:Open2Bit(nIndex, nOpen)
	local nDefault = self.tbSwitchs[nIndex][2];
	assert(nDefault == 0 or nDefault == 1);
	if(nDefault == nOpen) then
		return 0;
	else
		return 1;
	end
end

function GblTask:GetBitIndex(szSwitch)
	for i, v in ipairs(self.tbSwitchs) do
		if (v[1] == szSwitch) then
			return i;
		end
	end
	assert(false, "Không tìm thấy tên chức năng tương ứng");
end

function GblTask:CleanUiSwitch()
	KGblTask.SCSetDbTaskInt(DBTASD_UI_FUN_SWITCH, 0);
end


GblTask.tbSyncClientTaskData	= {};

function GblTask:s2c_SetTask(key, value)
	GblTask.tbSyncClientTaskData[key]	= value;
end
function GblTask:s2c_AllTask(tbTaskData)
	GblTask.tbSyncClientTaskData	= tbTaskData;
end

function GblTask:OnStart()
	for _, nKey in ipairs(self.tbSyncReg) do
		local nValue	= KGblTask.SCGetDbTaskInt(nKey);
		local szValue	= KGblTask.SCGetDbTaskStr(nKey);
		if (nValue and nValue ~= 0) then
			self.tbSyncClientTaskData[nKey]	= nValue;
		elseif (szValue and szValue ~= "") then
			self.tbSyncClientTaskData[nKey]	= szValue;
		end
	end
end

function GblTask:OnLogin()
	me.CallClientScript({"GblTask:s2c_AllTask", self.tbSyncClientTaskData});
end

function GblTask:OnSetTask(nKey, varValue)
	if (self.tbSyncClientTaskData[nKey]	~= varValue) then
		self.tbSyncClientTaskData[nKey]	= varValue;
		KPlayer.CallAllClientScript({"GblTask:s2c_SetTask", nKey, varValue});
	end
end

if (MODULE_GAMESERVER) then
	KGblTask.RegistSyncClientTask(GblTask.tbSyncReg);
	
	ServerEvent:RegisterServerStartFunc(GblTask.OnStart, GblTask);
	
	PlayerEvent:RegisterGlobal("OnLogin", GblTask.OnLogin, GblTask)
end
