Require("\\script\\fightskill\\define.lua");

if (not FightSkill.tbClassBase) then
	FightSkill.tbClassBase	= {};
	FightSkill.tbClass	= {
		[""] 	= FightSkill.tbClassBase,
		default	= FightSkill.tbClassBase,
	};
end	

FightSkill.tbParam =
{
	nS1  = 0.7,		--90级技能1级数值同10级技能的比值
	nS20 = 1.1,		--90级技能20级数值同10级技能的比值
	nSadd = 1.05,	--攻速系技能+1的威力提升
	nSadd1 = 1.09,	--格斗系技能+1的威力提升
	nS180S1  = 1.1,		--90级技能1级数值同10级技能的比值
	nS180S20 = 1.5,		--90级技能20级数值同10级技能的比值
	nS180Sadd = 1.45,	--攻速系技能+1的威力提升
	nS180Sadd1 = 1.45,
	nTAdd = 1.1, 	--同伴技能+1数值提升
	nS100Min  = 1,		--100级技能1级数值提升DPS比例
	nS100Max  = 10,		--100级技能10级数值提升DPS比例
	tbMidBookSkillExp = {{		--中级秘籍升级经验
		{ 1,  14175},
		{ 7,  70875},
		{ 8, 343224},
		{ 9, 756000},
	}},
	
	tbHighBookSkillExp = {{		--高级秘籍升级经验_约2.7本秘籍升到10级技能
		{ 1,  3*2*4725},
		{ 2,  5*2*4725},
		{ 3,  7*2*4725},
		{ 4,  9*2*4725},
		{ 5, 11*2*4725},
		{ 6, 13*2*4725},
		{ 7, 15*2*4725},
		{ 8, 17*4*4725},
		{ 9, 19*8*4725},
	}},
	
	nTitleLevel = 2, --领土头衔划分等级
	nTitleGrowValue = 30, --领土头衔抵御攻击几率成长值
	nTitleLevelPower = 1, --头衔等级乘方参数
	nTitleLevelAdjust = 8,	--头衔等级修正系数
	
	nTongBan = 70,--同伴技能3级时的能力相对于6级时的比例

}

function FightSkill:SkillExpFunc(nExp0, nA, nLevel, nTimes, nRange)
	return math.floor(nExp0 * (nA ^ (nLevel - 1)) * nTimes * nRange / 2);
end

function FightSkill:GetClass(szClassName, bNotCreate)
	local tbSkill	= self.tbClass[szClassName];
	if (not tbSkill and bNotCreate ~= 1) then
		tbSkill	= Lib:NewClass(self.tbClassBase);
		self.tbClass[szClassName] = tbSkill;
	end
	return tbSkill;
end

function FightSkill:GetLevelData(szSkillName, nLevel)
	assert(szSkillName and nLevel);
	local tbSkill = assert(self.tbClass[szSkillName], "[ERROR]Skill{"..tostring(szSkillName).."} not found!");
	local tbRet	= {};
	if (#tbSkill.tbMagics ~= 0) then
		for _, tbMagic in ipairs(tbSkill.tbMagics) do
			local tbData = { szName = tbMagic.szMagicName };
			if (type(tbMagic.tbValue) == "function") then
				tbData.szData = tbMagic.tbValue(nLevel);
			else
				local tbProp = {};
				for i = 1, self.MAGIC_VALUE_NUM do
					tbProp[i] = Lib.Calc:Link(nLevel, tbMagic.tbValue[i]);
				end
				tbData.szData = table.concat(tbProp, ",");
			end;
			tbRet[#tbRet + 1] = tbData;
		end
	else
		for szMagicName, tbMagicProp in pairs(tbSkill.tbMagics) do
			local tbData = { szName = szMagicName };
			if (type(tbMagicProp) == "function") then
				tbData.szData = tbMagicProp(nLevel);
			else
				local tbProp = {};
				for i = 1, self.MAGIC_VALUE_NUM do
					tbProp[i] = Lib.Calc:Link(nLevel, tbMagicProp[i]);
				end
				tbData.szData = table.concat(tbProp, ",");
			end;
			tbRet[#tbRet + 1] = tbData;
		end
	end
	
	return tbRet;
end

function FightSkill:OnLevelUp(szSkillName)
	local tbSkill = assert(self.tbClass[szSkillName]);
	return tbSkill:OnLevelUp();
end

function FightSkill:GetFormatValue(szFormat, nLevel)
	local fnData	= loadstring("return "..szFormat);
	if (not fnData) then
		error("loadstring failed!");
	end
	local tbPoint	= {fnData()};
	if (#tbPoint <= 1) then	-- 只填一个数字的情况
		local varValue	= tbPoint[1];
		if (type(varValue) == "string") then	-- 策划文档不小心出了引号
			return self:GetFormatValue(varValue, nLevel);
		elseif (type(varValue) == "number") then
			return varValue;
		else
			error("format error!");
		end
	end
	return Lib.Calc:Link(nLevel, tbPoint);
end

function FightSkill:GetPointValue(tbPoint, nLevel)
	if (#tbPoint <= 1) then	-- 只填一个数字的情况
		local varValue	= tbPoint[1];
		if (type(varValue) == "string") then	-- 策划文档不小心出了引号
			return self:GetFormatValue(varValue, nLevel);
		elseif (type(varValue) == "number") then
			return varValue;
		else
			error("format error!");
		end
	end
	return Lib.Calc:Link(nLevel, tbPoint);
end

function FightSkill:GetDesc(nSkillId, nSkillLevel, nAddPoint, nNeedNextLevel, pNpc, bNoNeedLevel)
	local tbThisInfo, tbNextInfo;
	if (nSkillLevel > 0) then
		tbThisInfo	= KFightSkill.GetSkillInfo(unpack({nSkillId, nSkillLevel, pNpc}));	-- unpack({...}) 当pNpc为空时减少一个参数
		tbThisInfo.nAddPoint= nAddPoint;
	else
		nSkillLevel	= 0;	-- 传进来的-1表示不能学习
	end
	
	if (nNeedNextLevel == 1) then
		tbNextInfo	= KFightSkill.GetSkillInfo(unpack({nSkillId, nSkillLevel + 1, pNpc}));
	end;
	
	local tbInfo = tbThisInfo or tbNextInfo;
	if (not tbInfo) then
		return "";
	end

	local szClassName = tbInfo.szClassName;
	local tbSkill = assert(self.tbClass[szClassName], "Skill{"..szClassName.."} not found!");
	local szTitleThis;
	local szMsgThis = "";
	if (tbThisInfo) then
		if bNoNeedLevel then
			szTitleThis, szMsgThis = tbSkill:GetDesc(tbThisInfo, nNeedNextLevel, 1 ,bNoNeedLevel);	
		else
			szTitleThis, szMsgThis = tbSkill:GetDesc(tbThisInfo);	
		end
	end
	
	

	if (tbThisInfo) then
			local nMaxSkillLevel = KFightSkill.GetSkillMaxLevel(tbThisInfo.nId);
			if ((nMaxSkillLevel <= tbThisInfo.nLevel) and nMaxSkillLevel ~= 0) then
				tbNextInfo = nil;
			end
	end
		
	local szTitleNext;
	local szMsgNext = "";
	if (tbNextInfo) then
		local bShowTitle = (not tbThisInfo);
		szTitleNext, szMsgNext = tbSkill:GetDesc(tbNextInfo, 1, bShowTitle);
	end
	
	local szExtraDescThis = "";
	local szExtraDescNext = "";

	if (tbSkill.GetExtraDesc) then
		szExtraDescThis = tbSkill:GetExtraDesc(tbThisInfo);
		szExtraDescNext = tbSkill:GetExtraDesc(tbNextInfo);
	end
	
	if (szExtraDescThis ~= "") then
		szMsgThis = szMsgThis..szExtraDescThis.."\n";	
	end
	if (szExtraDescNext ~= "") then
		szMsgNext = szMsgNext..szExtraDescNext.."\n";
	end
	
	local szTitle = szTitleThis or szTitleNext;
	if (szMsgThis ~= "") then
		szMsgThis = "\n"..szMsgThis;
	end
	if (szMsgNext ~= "") then
		szMsgNext = "\n"..szMsgNext;
	end
	
	return szTitle, szMsgThis..szMsgNext;
end

function FightSkill:GetStateTip(nStateId, nSkillId, nSkillLevel, szMsg, bBuff, nStateType, nLeftTime, nTotalTime)
	return self.tbState:GetTip(nStateId, nSkillId, nSkillLevel, szMsg, bBuff, nStateType, nLeftTime, nTotalTime);
end

function FightSkill:AddMagicData(tbMagicDatas)
	
	for szSkillName, tbMagics in pairs(tbMagicDatas) do
		self:GetClass(szSkillName).tbMagics	= tbMagics;
	end
end

function FightSkill:OnLogIn_Anger(bExchangeServer)
	if (bExchangeServer == 1) then
		return;
	end
	local nTskGroup = 2014;
	local nTskId	= 1;
	me.SetTask(nTskGroup, nTskId, 0);
end

function FightSkill:Frame2Sec(value)
	return math.floor(value / Env.GAME_FPS * 10) / 10;
end

function FightSkill:Frame2Times(value)
	return math.floor(value *2 / Env.GAME_FPS ) + 1;
end

function FightSkill:GetConflictingSkillList(nSkillId)
	return FightSkill.tbStateReplaceRegular:GetConflictingSkillList(nSkillId);
end

function FightSkill:GetStateGroupReplaceType(nSkillId)
	return FightSkill.tbStateReplaceRegular:GetStateGroupReplaceType(nSkillId);
end

function FightSkill:ReloadFile()
	SendChannelMsg("GM", "?pl KFightSkill.ReloadFile(me)");
	KFightSkill.ReloadFile(me);
end

function FightSkill:ClearCDTime()
	SendChannelMsg("GM", "?pl KFightSkill.ClearCDTime(me)");
	KFightSkill.ClearCDTime(me);
end

function FightSkill:CheckCanAddSkillPoint(pNpc, nSkillId)
	if (not pNpc) then
		return 0;
	end;
	
	local pPlayer 	= nil;
	
	if MODULE_GAMESERVER then
		pPlayer 	= pNpc.GetPlayer();
	else
		pPlayer 	= me; 
	end;
	
	if (not pPlayer) then
		return 0;
	end;
	
	if (pPlayer.nFaction < 1) then
		return 1;
	end;
	
	if (nSkillId == Player.tbFactions[pPlayer.nFaction].tbRoutes[1].tbSkills[11].nId or 
		nSkillId == Player.tbFactions[pPlayer.nFaction].tbRoutes[2].tbSkills[11].nId) then
		
		local nTaskGroup 	= 1022;
		local nTaskId		= 215;
		local nValue 		= pPlayer.GetTask(nTaskGroup, nTaskId);
	
		if (KLib.GetBit(nValue, pPlayer.nFaction) ~= 1) then
			return 0;
		end;	
	end;
	return 1;
end;
	
function FightSkill:GetSkillItemTip(nSkillId, nLevel)
	local szTip = "";
	local tbInfo = KFightSkill.GetSkillInfo(nSkillId, nLevel);
	local tbMsg = {};
	local tbDefault = FightSkill:GetClass("default");
	tbDefault:GetDescAboutLevel(tbMsg, tbInfo);
	szTip = szTip .. table.concat(tbMsg, "\n").."\n";
	szTip = string.gsub(szTip, "<color=white>Thời gian duy trì: <color><color=gold>%d*.*%d* giây<color>\n", "");
	
    return Lib:StrTrim(szTip, "\n");
end;
function FightSkill:DamageAccount(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	pPlayer.CallClientScript({"Ui:ServerCall", "UI_DAMAGETEST", "OpenWindow"});	
end;


function FightSkill:StartDamageAccount(nPlayerId)
	if MODULE_GAMECLIENT then
		return;
	end;
	
	self.tbDamageAccountPlayer = self.tbDamageAccountPlayer or {};
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	print("start")
	pPlayer.StartDamageCounter();
	self.tbDamageAccountPlayer[nPlayerId] = 1;
	
	if (not self.nDATimer) then 
		self.nDATimer	= Timer:Register(Env.GAME_FPS * 5, self.DABreathe, self);
	end;
end;

function FightSkill:DABreathe()
	if MODULE_GAMECLIENT then
		return;
	end;
	
	local nLength = 0; 
	for nId, _ in pairs(self.tbDamageAccountPlayer) do
		nLength = nLength + 1;
	end;
	
	if (nLength == 0) then
		Timer:Close(self.nDATimer);
		self.nDATimer = nil;
		return;
	end;

	for nId, _ in pairs(self.tbDamageAccountPlayer) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if (not pPlayer) then
			self.tbDamageAccountPlayer[nId] = nil;
			return;
		end;
	
		local nDamage = pPlayer.GetDamageCounter();
		print("RefreshMsg", nDamage);
		pPlayer.CallClientScript({"Ui:ServerCall", "UI_DAMAGETEST", "RefreshMsg", nDamage, 0});
	end;
end;

function FightSkill:EndDamageAccount(nPlayerId)
	if MODULE_GAMECLIENT then
		return;
	end;
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		self.tbDamageAccountPlayer[nPlayerId] = nil;
		return;
	end;
	self.tbDamageAccountPlayer[nPlayerId] = nil;
	pPlayer.StopDamageCounter();
	
	local nLength = 0; 
	for nId, _ in pairs(self.tbDamageAccountPlayer) do
		nLength = nLength + 1;
	end;
	
	if nLength == 0 then
		if (self.nDATimer) then
			print("Close");
			Timer:Close(self.nDATimer);
			self.nDATimer = nil;
		end;
	end;
end;


PlayerEvent:RegisterGlobal("OnLogin", FightSkill.OnLogIn_Anger, FightSkill);
