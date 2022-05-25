--bỏ load setting của game thay vào load setting của autofight plugin , bỏ pvp tự set target
Ui.tbLogic.tbAutoFightData = {};
local tbAutoFightData = Ui.tbLogic.tbAutoFightData;
local tbSaveData = Ui.tbLogic.tbSaveData;

tbAutoFightData.DATA_KEY				= "AutoFight";
tbAutoFightData.FACTION_TAG				= "_FACTION_";

function tbAutoFightData:Init()
	self.bAutoFight			= 0;
	self.bPickItem			= 0;
	self.nAcceptTeam		= 1;
	self.nAutoRepair		= 1;
	self.nPickStar			= 2;
	self.nLifeRet			= 60;
	self.nBuffRet			= 70;
	self.nLeftSkillId		= 0;
	self.nRightSkillId		= 0;
	self.n3SkillId		= 0;
	self.n4SkillId		= 0;
	self.n5SkillId		= 0;
	self.n6SkillId		= 0;
	self.nAutoDrink			= 1;
	self.nAutoEnhancePick	= 0;
	self.nAutoFDWX			= 0;
	self.nAutoRead			= 1;
	self.nAutoRead_Move		= 0;
	self.nAutoXLZ			= 0;
	self.nSkill				= 0;
	self.nJoin				= 1;
	self.nDead				= 0;
	self.LoadData 			= {};
	self.tbData 			= {};
	self.nPvpMode 			= 0;
end

function tbAutoFightData:Load()
	self:Init();
	local tbFightSetting = tbSaveData:Load("AutoFight");

	if tbFightSetting.nUnPickCommonItem then
		self.bPickItem = tbFightSetting.nUnPickCommonItem;
	end
	if tbFightSetting.nPickValue then
		self.nPickStar = tbFightSetting.nPickValue;
	end
	if tbFightSetting.nLifeRet then
		self.nLifeRet = tbFightSetting.nLifeRet;
	end
	if tbFightSetting.nBuffRet then
		self.nBuffRet = tbFightSetting.nBuffRet;
	end
	if tbFightSetting.nSkill1 then
		self.nLeftSkillId = tbFightSetting.nSkill1;
	end
	if tbFightSetting.nSkill2 then
		self.nRightSkillId = tbFightSetting.nSkill2;
	end
	if tbFightSetting.nSkill3 then
		self.n3SkillId = tbFightSetting.nSkill3;
	end
	if tbFightSetting.nSkill4 then
		self.n4SkillId = tbFightSetting.nSkill4;
	end
	if tbFightSetting.nSkill5 then
		self.n5SkillId = tbFightSetting.nSkill5;
	end
	if tbFightSetting.nSkill6 then
		self.n6SkillId = tbFightSetting.nSkill6;
	end
	if tbFightSetting.nAcceptTeam then
		self.nAcceptTeam = tbFightSetting.nAcceptTeam;
	end
	if tbFightSetting.nAutoRepair then
		self.nAutoRepair = tbFightSetting.nAutoRepair;
	end
	if tbFightSetting.nAutoDrink then
		self.nAutoDrink = tbFightSetting.nAutoDrink;
	end
	if tbFightSetting.nAutoEnhancePick then
		self.nAutoEnhancePick = tbFightSetting.nAutoEnhancePick;
	end
	if tbFightSetting.nAutoXLZ then
		self.nAutoXLZ = tbFightSetting.nAutoXLZ;
	end
	if tbFightSetting.nSkill then
		self.nSkill = tbFightSetting.nSkill;
	end
	if tbFightSetting.nAutoFDWX then
		self.nAutoFDWX = tbFightSetting.nAutoFDWX;
	end
	if tbFightSetting.nAutoRead then
		self.nAutoRead = tbFightSetting.nAutoRead;
	end
	if tbFightSetting.nAutoRead_Move then
		self.nAutoRead_Move = tbFightSetting.nAutoRead_Move;
	end
	
	tbFightSetting = 
	{
	nUnPickCommonItem 	= self.bPickItem,
	nPickValue 			= self.nPickStar,
	nLifeRet 			= self.nLifeRet,
	nBuffRet 			= self.nBuffRet,
	nSkill1 			= self.nLeftSkillId,
	nSkill2 			= self.nRightSkillId,
	nSkill3 			= self.n3SkillId,
	nSkill4 			= self.n4tSkillId,
	nSkill5 			= self.n5tSkillId,
	nSkill6 			= self.n6SkillId,
	nAutoRepair 		= self.nAutoRepair,
	nAcceptTeam 		= self.nAcceptTeam,
	nAutoDrink 			= self.nAutoDrink,
	nPvpMode 			= self.nPvpMode,
	tbLeftMed 			= self.tbLeftMed,
	tbRightMed			= self.tbRightMed,
	nAutoEnhancePick	= self.nAutoEnhancePick,
	nAutoFDWX			= self.nAutoFDWX,
	nAutoRead			= self.nAutoRead,
	nAutoXLZ			= self.nAutoXLZ,
	nSkill				= self.nSkill,
	nAutoRead_Move		= self.nAutoRead_Move,
	nJoin				= self.nJoin,
	nDead				= self.nDead,
	};
	self.LoadData = tbFightSetting;
	return tbFightSetting;
end

function tbAutoFightData:ShortKey()
	-- self:Load();
	if me.nAutoFightState == 0 then
		self.bAutoFight = 1;
	else
		self.bAutoFight = 0;
	end
	-- me.SetAutoTarget(self.nPvpMode);
	local tbData =Ui(Ui.UI_AUTOFIGHT):Load("AutoFight");
	tbData.nAutoFight = self.bAutoFight;
	return tbData;
end

function tbAutoFightData:Save(tbFightSetting)
	tbSaveData:Save(self.DATA_KEY, tbFightSetting);
end

function tbAutoFightData:OnChangeFactionFinished()
	local nPrevFaction = Faction:GetPrevFaction(me);
	if (nPrevFaction == nil) then
		return;
	end

	local tbFightSettingOld = tbSaveData:Load(self.DATA_KEY);
	tbSaveData:Save(self.DATA_KEY .. self.FACTION_TAG .. tostring(nPrevFaction), tbFightSettingOld);
	local tbFightSettingNew = tbSaveData:Load(self.DATA_KEY .. self.FACTION_TAG .. tostring(me.nFaction));
	tbSaveData:Save(self.DATA_KEY, tbFightSettingNew);
end