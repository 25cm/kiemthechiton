local tbAutoAimHT	= Map.tbAutoAimHT or {};
Map.tbAutoAimHT	= tbAutoAimHT;
--Œ¥ÕÍ≥…≤ø∑÷
--1°¢—”≥Ÿ‘ˆº”ID±Í ∂£¨±‹√‚∏…»≈°£
--2°¢≈‰÷√∏¸–¬”¶∏√∞¥≤ªÕ¨√≈≈…Ω¯––±£¥Ê∫Õ∂¡»°°£

--◊¢≤· ±º‰øÿº˛
local tbTimer = Ui.tbLogic.tbTimer;
--◊¢≤·–≈œ¢π‹¿Ìøÿº˛
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
--”ÎSELECTNPCπ“π¥
local tbSelectNpc    = Ui(Ui.UI_SELECTNPC);

--[[local tCmd = { "Map.tbAutoAimHT:AutoFollow();", "AutoFollow", "", "Ctrl+X", "Ctrl+X", "AutoFollowÃ¶" };
AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]); ]]

local SELF_EQUIPMENT = 			-- Ë£ÖÂ§áÊéß‰ª∂Ë°®
{
	{ Item.EQUIPPOS_HEAD,		"ObjHead",		"ImgHead"		},
	{ Item.EQUIPPOS_BODY,		"ObjBody",		"ImgBody"		},
	{ Item.EQUIPPOS_BELT,		"ObjBelt",		"ImgBelt"		},
	{ Item.EQUIPPOS_WEAPON,		"ObjWeapon",	"ImgWeapon"		},
	{ Item.EQUIPPOS_FOOT,		"ObjFoot",		"ImgFoot"		},
	{ Item.EQUIPPOS_CUFF,		"ObjCuff",		"ImgCuff"		},
	{ Item.EQUIPPOS_AMULET,		"ObjAmulet",	"ImgAmulet"		},
	{ Item.EQUIPPOS_RING,		"ObjRing",		"ImgRing"		},
	{ Item.EQUIPPOS_NECKLACE,	"ObjNecklace",	"ImgNecklace"	},
	{ Item.EQUIPPOS_PENDANT,	"ObjPendant",	"ImgPendant"	},
	{ Item.EQUIPPOS_HORSE,		"ObjHorse",		"ImgHorse"		},
	{ Item.EQUIPPOS_MASK,		"ObjMask",		"ImgMask"		},
	{ Item.EQUIPPOS_BOOK,		"ObjBook",		"ImgBook"		},
	{ Item.EQUIPPOS_ZHEN,		"ObjZhen",		"ImgZhen"		},
	{ Item.EQUIPPOS_SIGNET, 	"ObjSignet", 	"ImgSignet"		},
	{ Item.EQUIPPOS_MANTLE,		"ObjMantle",	"ImgMantle"		},
	{ Item.EQUIPPOS_CHOP,		"ObjChop", 		"ImgChop"		},
};


-- ‘ÿ»Î ±≥ı ºªØ
function tbAutoAimHT:Init()
	self:ModifyUi();
	self.nYaoState 		= 0;	-- ◊‘∂Ø≥‘“©◊¥Ã¨
	self.nPickState 	= 0;	-- ◊‘∂Ø ∞»°◊¥Ã¨
	self.nfireState 	= 0;	-- ◊‘∂Ø√ª◊¥Ã¨
	self.nFollowTime    	= 0.1;  -- ∏˙ÀÊºÏ≤‚∆µ¬ 
	self.nFollowState 	= 0;
	self.nPID 		= 0;
	self.nPlayerID		= 0;  
	self.nszName		= nil;
	self.nFRange		= 0.6; 	-- ’Ω∂∑∏˙ÀÊ÷±œﬂæ‡¿Î
	self.nEmFRange		= 0.6; 	-- ∂Î·“∏˙ÀÊ÷±œﬂæ‡¿Î
	self.EatFood 		= 80;	-- —™ªÚƒ⁄µÕ”⁄80%£¨≥‘≤À
	self.DelayStat 		= 0;	-- —”≥Ÿ≈–∂œ≤Œ ˝
	
	self.nAttackMonsterState = 0;
	self.nRepairItemState = 0;
	self.nRideRange = 1.7;
	
	self.TimeStartFollow = 0;
	self.MaxTimeRepairItem = 3600; --1800
	self.LastRepairTime = 0;
	self.nVuaSua = 0;
	self.nOnOffTrainAfk = 1;
	self.MapidTrain = 132;
	self.PosXTrain = 1682;
	self.PosYTrain = 3481;
	
	self.OldPosX = 0;
	self.OldPosY = 0;
	self.OldTime = 0;
	self.MaxOldTime1 = 300;
	self.MaxOldTime = 900; --thoi gian max afk
	self.nTrainDcChua = 0;
	self.nBatAutoFight = 0;
end
--≈‰÷√∏¸–¬
function tbAutoAimHT:UpdateSetting(AimCfg)
	self.bYaoDelay 	= AimCfg.nYaoDelay;
	self.life_left 	= AimCfg.nLifeRet;
	self.mana_left 	= AimCfg.nManaRet;
	self.EMHealDelay = AimCfg.nHealDelay;
	self.bAutoEat = AimCfg.nAutoEat;
end
--π¶ƒ‹1£∫◊‘∂Ø≥‘“©----------------------------------------------------------------------------------------
--◊‘∂Ø≥‘“©∫Ø ˝
function tbAutoAimHT:FAutoYao()
	local nYaoTimer = 0;
	local TXTINT	= self.bYaoDelay*1000;
	if self.nYaoState == 0 then
		self.nYaoState = 1;
		me.Msg("<color=yellow>D√πng thu·ªëc t·ª± ƒë·ªông<color>");
		me.Msg("<color=yellow>Delay:<color>"..string.format("<color=green>%d<color>",TXTINT).."ms");
		me.Msg("<color=yellow>B∆°m m√°u khi sinh l·ª±c < <color>"..string.format("<color=green>%d",self.life_left).."<color>");
		me.Msg("<color=yellow>B∆°m mana khi l·ª±c < <color>"..string.format("<color=green>%d",self.mana_left).."<color>");
		nYaoTimer = tbTimer:Register(0.5 * Env.GAME_FPS, self.YaoTimer, self);
	else
		self.nYaoState = 0;
	end
end

--◊‘∂Ø≥‘“©
function tbAutoAimHT:YaoTimer()
	if self.nYaoState == 0 then
		me.Msg("<color=red>T·∫Øt d√πng thu·ªëc t·ª± ƒë·ªông<color>");
		return 0;
	end
	--≥‘∫Ï
	if (me.nCurLife < tonumber(self.life_left)) and self.DelayStat == 0 then
		local nHONG = Map.AimCommonHT:GetHongYao();
		me.UseItem(nHONG);
		self:MyDelay(self.bYaoDelay);
	end
	--≥‘¿∂
	if (me.nCurMana < tonumber(self.mana_left)) and self.DelayStat == 0 then
		local nLAN = Map.AimCommonHT:GetLanYao();
		me.UseItem(nLAN);
		self:MyDelay(self.bYaoDelay);
	end
end
--π¶ƒ‹2£∫◊‘∂Ø ∞»°------------------------------------------------------------------------------------
tbAutoAimHT.FPickUp = function(self)
	local nPickTime = 0;
	local Space_Time = 0.2;	-- 0.1 ∞»°ŒÔ∆∑µƒ ±º‰—”≥Ÿ/√Î(“—æ≠µΩº´œﬁ‘ŸøÏª·À¿ª˙µƒ)
	if (self.nPickState == 0 ) then
		self.nPickState =1;
		nPickTime = Timer:Register(Space_Time * Env.GAME_FPS, self.PickTimer, self);
		me.Msg("<color=yellow>B·∫≠t nh·∫∑t ƒë·ªì nhanh<color>");
	else
		self.nPickState =0;
		Timer:Close(nPickTime);
		nPickTime = 0;
		me.Msg("<color=green>T·∫Øt nh·∫∑t ƒë·ªì nhanh<color>");
	end
end

tbAutoAimHT.PickTimer = function(self)
	if (self.nPickState ==0 ) then
		return 0;
	end
	AutoAi.PickAroundItem(Space);
end

--π¶ƒ‹3£∫ºØ∫œ’ŸªΩ------------------------------------------------------------------------------------

---- º‡ ”¡ƒÃÏ–≈œ¢ ----
function tbAutoAimHT:ModifyUi()
	tbAutoAimHT.Say_bak	= tbAutoAimHT.Say_bak or UiCallback.OnMsgArrival
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg)
		tbAutoAimHT.Say_bak(UiCallback, nChannelID, szSendName, szMsg);
		-- —”≥Ÿµ˜”√OnSay£®≤ª—”≥Ÿπÿ≤ªµÙ¥∞ø⁄£©
		local function fnOnSay()
			tbAutoAimHT:OnSay(nChannelID, szSendName, szMsg);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

----’ŸªΩ1£∫∑¢∆ºØ∫œ’ŸªΩ----
function tbAutoAimHT:Select()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Tri·ªáu t·∫≠p::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Tri·ªáu t·∫≠p::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..") C·∫ßn anh em gi√∫p ƒë·ªü !");
	local tbMsg = {};
	tbMsg.szMsg = string.format("Ch·ªçn k√™nh Chat ƒë·ªÉ g·ªçi tri·ªáu t·∫≠p!");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "H·ªßy", "G·ªçi"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--∆µµ¿
			SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end

----’ŸªΩ2£∫∑¢∂Ø≤…ºØƒßæß Ø----
function tbAutoAimHT:CalltoDan()
	SendChannelMsg("Team","M√®");
end

----’ŸªΩ3£∫∑¢∂Ø[∆Ù∂Ø/Õ£÷π]√ª----
function tbAutoAimHT:CalltoFire()
	if self.nfireState == 0 then
		self.nfireState = 1
		SendChannelMsg("Team","B·∫Øt ƒë·∫ßu ch√°y");
	else
		self.nfireState = 0
		SendChannelMsg("Team","Ng·ª´ng chi·∫øn ƒë·∫•u");
	end
end

---- øÕªß∂À ’µΩœ˚œ¢ ± ----
function tbAutoAimHT:OnSay(nChannelID, szSendName, szMsg)
	local stype
	if nChannelID==3 then
		stype="ƒê·ªìng ƒê·ªôi"
	end      
	---- ¡ƒÃÏ–≈œ¢∑÷≤ ----
	function tbAutoAimHT:Split(szFullString, szSeparator)
		local nFindStartIndex = 1
		local nSplitIndex = 1
		local nSplitArray = {}
		while true do
		   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		   if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
	 	  end
	  	 nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   	nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	  	 nSplitIndex = nSplitIndex + 1
		end
		return nSplitArray
	end
	----≤…ºØƒßæß Ø–≈œ¢----
	if string.find(szMsg,"M√®") and stype=="ƒê·ªìng ƒê·ªôi" then
		me.Msg("Spar b·∫Øt ƒë·∫ßu thu th·∫≠p ph√©p thu·∫≠t")
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4223) then
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
	end
	----∆Ù∂Ø√ª–≈œ¢----
	if  string.find(szMsg,"B·∫Øt ƒë·∫ßu ch√°y ch·ªØa ch√°y") and szSendName==me.szName  then
		self.TimeridFire = Ui.tbLogic.tbTimer:Register(20, tbAutoAimHT.Fire, self)
		me.Msg("<color=yellow>B·∫Øt ƒë·∫ßu ch√°y ch·ªØa ch√°y<color>")
	end
	----Õ£÷π√ª–≈œ¢----
	if  string.find(szMsg,"Ch√°y h·∫øt") and szSendName==me.szName  then
		Ui.tbLogic.tbTimer:Close(self.TimeridFire);
		--Ui.tbLogic.tbTimer:Close(Map.TimeridFire);
		me.Msg("<color=red>Ch√°y h·∫øt<color>")
	end
end

------◊”π¶ƒ‹2-3£∫√ª----
function tbAutoAimHT:Fire()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--Ω¯∂»Ãı£¨ ≤√¥“≤≤ª◊ˆ
		return
	end
	if self.nfireState == 0 then
		me.Msg("Fire break.... ...");
		return 0
	end

	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();

	--if nCurMapId ~= 493 then
	--	return 0
	--end

	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);

	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == 4235) then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		end
	end
end

--π¶ƒ‹3£∫◊‘∂Ø∏˙ÀÊ------------------------------------------------------------------------------------
--¥´µ›√Ê∞Ê≤Œ ˝
function tbAutoAimHT:FollowData(szName,nItemData)
	self.nTrainDcChua = 0;
	self.nBatAutoFight = 0;
	if (nItemData >0) then
		self.nPID = 1;
		self.nPlayerID = nItemData;
		local tbSplit	= Lib:SplitStr(szName, " ");
		self.nszName = tbSplit[1];
		self.nPType = 1;
	else
		self.nPID = 0;
	end
	self:AutoFollow()
end

--◊‘∂Ø∏˙ÀÊ
function tbAutoAimHT:AutoFollow()
	--»∑∂®∏˙ÀÊæ‡¿Î
	if (me.nFaction == 5 and me.CanCastSkill(98) == 1) then
		self.nRange = self.nEmFRange;  -- »Áπ˚ «∂Î·“,‘Ú π”√nEmFollowRange’‚∏ˆæ‡¿Î
	else
		self.nRange = self.nFRange; 
	end

	if self.nFollowState == 0 then
		self.nFollowState = 1;
		--µ⁄“ª≤Ω£∫∏˙ÀÊ∂‘œÛ»∑∂®
		if self.nPID == 0 then --√Ê∞Ê÷–√ª”–—°‘Ò∂‘œÛ‘Ú∞¥œ¬√ÊÀ≥–Ú—°‘Ò∂‘œÛ£∫
			local playerInfo = tbSelectNpc.pPlayerInfo;
			--”≈œ»1£∫ Û±Í—°‘ÒµƒNPC
			if playerInfo then
				self.nPlayerID = tbSelectNpc.pPlayerInfo.dwId;
				self.nszName = tbSelectNpc.pPlayerInfo.szName;
				self.nPType = 2;
			--”≈œ»2£∫—°‘Ò∂”ŒÈµƒ∂”≥§
			else
				local nAllotModel, tbMemberList = me.GetTeamInfo();
				if nAllotModel and tbMemberList then
    					local tLeader = tbMemberList[1];
					if tLeader.szName == me.szName then
						Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Kh√¥ng c√≥ m·ª•c ti√™u ch√≠nh x√°c<color>");
						me.Msg("<color=Yellow>B·∫°n l√† ƒë·ªôi tr∆∞·ªüng, kh√¥ng th·ªÉ theo b·∫°n ƒë∆∞·ª£c<color=Yellow>");
						return;
					else
						self.nPlayerID = tLeader.nPlayerID;
						self.nszName = tLeader.szName;
						self.nPType = 3;
					end
				end
			end
		end
		if (self.nPlayerID == 0) then
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Kh√¥ng c√≥ m·ª•c ti√™u ch√≠nh x√°c<color>");
			me.Msg("<color=Yellow>Kh√¥ng c√≥ m·ª•c ti√™u ch√≠nh x√°c<color=Yellow>");
			self.nFollowState = 0;
			return;
		end
		--∆Ù∂Ø∏˙ÀÊ
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Theo sau: <color> ["..self.nszName.."<color>]");
		me.Msg("<color=green>B·∫Øt ƒë·∫ßu theo sau:<color> [<color=Yellow>"..self.nszName.."<color>]");
		nFTimer1 = Timer:Register(self.nFollowTime * Env.GAME_FPS, self.OnFollow1, self);
	else
		self.nFollowState = 0;
		Timer:Close(nFTimer1);
		me.Msg("<color=green>Ng·ª´ng theo sau - H·ªô t·ªëng<color>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=yellow>Ng·ª´ng theo sau - H·ªô t·ªëng<color>");
		self.nPID = 0;
		self.nPosX = 0;
		self.nPosY = 0;
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
	end
end
--’Ω∂∑∏˙ÀÊ
function tbAutoAimHT:OnFollow1()
	-- ºÏ≤È≥‘ ≥ŒÔself.EatFood=80% 	
	if (me.IsDead() == 1) then	
		me.SendClientCmdRevive(0);		
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);			
		end		
		--self.nTrainDcChua = 0
		self.nBatAutoFight = 0;
		--return
	end
	if self.nTrainDcChua == 0 then
	--me.Msg("Time = "..GetTime());
	if (GetTime() - self.TimeStartFollow > 1) and (self.nVuaSua == 1) then
		--UiManager:SwitchWindow(Ui.UI_PLAYERPANEL);
		UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);	
		self.nVuaSua = 0;
	end
	if (GetTime() - self.TimeStartFollow > self.MaxTimeRepairItem) and ( self.nRepairItemState == 1 ) then
		self:RepairItemAll();
		self:RepairItemAll();
		if (UiManager:WindowVisible(Ui.UI_PLAYERPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		end
		self.TimeStartFollow = GetTime();
		self.nVuaSua		 = 1;		
	end
	if self.bAutoEat == 1 and ((me.nCurLife*100/me.nMaxLife < self.EatFood) or (me.nCurMana*100/me.nMaxMana < self.EatFood)) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- œ»≥‘∂Ã–ß ≥ŒÔ
			local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				if 0 == AutoAi.Eat(4) then -- ≥§–ß ≥ŒÔ
					print("AutoAi- No Food...");
				end
			end
		end
	end
	--Ω¯∂»Ãı£¨ ≤√¥“≤≤ª◊ˆ
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	--«ø÷∆÷–∂œ
	if self.nFollowState == 0 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		return 0;
	end
	--ªÒ»°◊‘º∫µÿÕº◊¯±Í
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nMMap = nMyMap
	self.nMyPosX = nMyX / 8;
	self.nMyPosY = nMyY / 16;
	--ªÒ»°∂‘œÛµÿÕº
	local tbMember = me.GetTeamMemberInfo();
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].szName == self.nszName then
			self.nPMap = tbMember[i].nMapId;
		end
	end
	--–ﬁ’˝∏±±æµÿÕºID
	if self.nMMap == 344 then --–ﬁ’˝ÕÚª®
		self.nPMap = 344;
	elseif self.nMMap == 273 then --–ﬁ’˝º“◊Âπÿø®[…Ò√ÿ±¶ø‚]
		self.nPMap = 273;
	elseif self.nMMap == 287 then --–ﬁ’˝«ß«Ì
		self.nPMap = 287;
	elseif self.nMMap == 254 then --–ﬁ’˝Ã’÷Ïπ´“…⁄£
		self.nPMap = 254;
	elseif self.nMMap == 272 then --–ﬁ’˝¥ÛƒÆπ≈≥«
		self.nPMap = 272;
	elseif self.nMMap == 557 then --–ﬁ’˝∑¸≈£…Ω∫Û…Ω(∏±±æ)
		self.nPMap = 557;
	elseif self.nMMap == 560 then --–ﬁ’˝∞Ÿ¬˘…Ω
		self.nPMap = 560;
	elseif self.nMMap == 493 then --–ﬁ’˝∫£¡ÍÕıƒπ
		self.nPMap = 493;
	end
	--≈–∂œ≈‹ÕºªÚ∏˙ÀÊ’Ω∂∑and self.nPMap == self.nMMap
	if self.nPType == 2 then
		self:FLFight();
	elseif self.nPMap == self.nMMap then
		self:FLFight();
	else
		--÷Õº–ﬁ∏¥¥´ÀÕŒ Ã‚
		if self.nPMap == 90 then -- –ﬁ∏¥[‰Ωª®œ™]
			self.PlayX = "1900";
			self.PlayY = "3900";
		elseif self.nPMap == 97 and self.nMMap ~=90 then -- –ﬁ∏¥[œÏÀÆ∂¥]
			self.PlayX = "1920";
			self.PlayY = "3620";
		else
			self.PlayX = "1500";
			self.PlayY = "3000";
		end
		self:GotoPmap(self.PlayX,self.PlayY);
	end
	else
		if self.nFollowState == 0 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			return 0;
		end
		self:FLFight();
	end
end

-- “ÏÕº≈‹Õº
function tbAutoAimHT:GotoPmap(PlayX,PlayY)
	--Ω¯∂»Ãı£¨ ≤√¥“≤≤ª◊ˆ
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local sznMap = GetMapNameFormId(self.nPMap)
	me.Msg("B·∫£n ƒë·ªì: <color=Blue>["..sznMap.."]<color> Theo sau: <color=Yellow>"..self.nszName.."<color>")
	local nPlayPosInfo ={}
	nPlayPosInfo.szType = "pos"
	nPlayPosInfo.szLink = sznMap..","..self.nPMap..","..PlayX..","..PlayY;
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,nPlayPosInfo);
	me.Msg(nPlayPosInfo.szLink)
end
-- Õ¨Õº∏˙ÀÊ’Ω∂∑
function tbAutoAimHT:FLFight()
	local bChecked = me.GetNpc().IsRideHorse();
	--ªÒ»°∂‘œÛ◊¯±Í
	if self.nTrainDcChua == 0 then
	if self.nPType == 2 then
		me.Msg("<color=green>Theo sau:<color>[<color=Gold>"..self.nszName.."<color>]")
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Theo sau: <color> ["..self.nszName.."<color>]");
		me.Msg(self.nFollowState)
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.szName == self.nszName) then
				local _, nNpcX, nNpcY	= pNpc.GetWorldPos();
				self.nPosX = nNpcX/8;
				self.nPosY = nNpcY/16;
			end
		end
	else
		local tbNpc = SyncNpcInfo();	
		if tbNpc then
			for _, tbNpcInfo in ipairs(tbNpc) do
				if tbNpcInfo.szName == self.nszName then
					self.nPosX = tbNpcInfo.nX/16;
					self.nPosY = tbNpcInfo.nY/16;
				end
			end
		end
	end
	else
		--me.Msg("di train rieng thoi");
		local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
		if (nMapId == self.MapidTrain) and (nCurWorldPosX == self.PosXTrain) and (nCurWorldPosY == self.PosYTrain) then
			
				if (me.nAutoFightState ~= 1) then
					AutoAi.ProcessHandCommand("auto_fight", 1);					
				end	
				self.nBatAutoFight = 1;
		elseif (self.nBatAutoFight == 0) then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 then
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = ","..self.MapidTrain..","..self.PosXTrain..","..self.PosYTrain
			Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);			
		end
		end
	end
	--º∆À„÷±œﬂæ‡¿Î
	if (self.nTrainDcChua == 0) then
	local TargetDis = math.sqrt((self.nMyPosX-self.nPosX)^2 + (self.nMyPosY-self.nPosY)^2);
		--≈–∂œæ‡¿Î≤¢»∑∂®’Ω∂∑ªÚº”—™me.Msg("D:"..self.EMHealDelay.."Eat:"..self.bAutoEat)	
		if (TargetDis < self.nRange) then
			if (self.OldPosX ~= self.nPosX) or (self.OldPosY ~= self.nPosY) then
				self.OldTime = GetTime();
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime1 < GetTime()) and (self.nOnOffTrainAfk == 1) then
				SendChannelMsg("Team","Kh·ªüi ƒë·ªông l·∫°i auto train!!");				
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime < GetTime()) and (self.nOnOffTrainAfk == 1) then
				--me.Msg("tran gan = 1");
				self.nTrainDcChua = 1;
			else
			self.OldPosX = self.nPosX;
			self.OldPosY = self.nPosY;
			--me.Msg(self.OldPosX.."="..self.nPosX);
			--me.Msg(self.OldPosY.."="..self.nPosY);
			--me.Msg(self.OldTime.."="..GetTime());
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then
				--me.Msg("buff thoi");
				if self.DelayStat == 0 then
					me.UseSkill(98,GetCursorPos());
					self:MyDelay(self.EMHealDelay);
				else
					return;
				end
			else
				if (self:IsDangerous() == 1) then
					me.Msg("Nguy hi·ªÉm S·ª©c b·∫≠t l·∫°!!!");
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				else
					local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
					if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	-- k·ªπ nƒÉng ph·∫£i xu·ªëng ng·ª±aÔºå xu·ªëng ng·ª±a l·∫≠p t·ª©c
						Switch("horse");	-- xu·ªëng ng·ª±a 
					end
					if (me.nAutoFightState ~= 1) then					
						AutoAi.ProcessHandCommand("auto_fight", 1);
					end
				end
			end
			end
		else			
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then  -- »Áπ˚ «∂Î·“÷±Ω”∏˙ÀÊ
				if (me.nAutoFightState == 1) then
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				end
				if (TargetDis > self.nRideRange and bChecked ~= 1) then					
					Switch([[horse]])					
				end
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				--me.Msg("khoang cach ="..TargetDis);
				if (TargetDis > self.nRideRange and bChecked ~= 1) then					
					Switch([[horse]])					
				end
				self:StopFight();
			end
		end
	end
end

-- πÿ±’◊‘∂Ø’Ω∂∑
function tbAutoAimHT:StopFight()
	if (self.nMMap < 298 or self.nMMap > 332) or self.nPType == 2 then --»Áπ˚”√ Û±Í—°‘Ò∂‘œÛ£¨∫ˆ ”µÿÕº°£
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
		me.AutoPath(self.nPosX*8, self.nPosY*16);
	else -- Â–“£π»µÿÕº(ID:298-332)
	--Â–“£π»µ»¥˝…±π÷Ω· ¯≤≈∏˙ÀÊ[≤‚ ‘]
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 10);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nKind == 0) then  --÷‹Œßªπ”–π÷
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("T·ªça ƒë·ªô: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("T·ªça ƒë·ªô: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			end
		end
	end
end
-- ºÏ≤‚∏ΩΩ¸ «∑Ò”–∑¥µØπ÷
function tbAutoAimHT:IsDangerous()
	local isDangerous = 0;
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 40);
	for _, pNpc in ipairs(tbAroundNpc) do		
		local id = pNpc.nTemplateId;
		if (id == 3146 or id == 3149 or id == 3152 or id == 3157 or id == 3177 or id == 3193 or id == 3277 ) then
			-- ƒΩ»›º“ª¢:3146;π√À’¥Ûˆ˘”„:3149;ƒΩ»›º“±™:3152;µØ–‘ª˙Ë´:3157;ƒΩ»› œπÌªÍ:3177;«ø¡¶ª˙Ë´:3193;ƒæ◊Æ∑¥µØ:3277
			isDangerous = 1;
			break;
		end
	end
	return isDangerous;
end
-- Õ®”√5: —”≥Ÿ
function tbAutoAimHT:MyDelay(DelayTime)
	self.nTest = 0;
	self.nDtime = DelayTime;
	self.DelayStat = 1;
	local DelayStart = tbTimer:Register(0.2 * Env.GAME_FPS, self.DelayClock, self);
end
-- Õ®”√5: —”≥Ÿ[ ±÷”]
function tbAutoAimHT:DelayClock()
	local nDelay = self.nDtime*5;
	self.nTest = self.nTest + 1;
	if self.nTest >= nDelay+5 then
		self.DelayStat = 0;
		return 0;
	end
end

function tbAutoAimHT:RepairItemAll()
	self.tbEquipCont = {};
	for _, tb in ipairs(SELF_EQUIPMENT) do
		local nPos = tb[1];
		self.tbEquipCont[nPos] = Ui.tbLogic.tbObject:RegisterContainer(
			"UI",
			tb[2],
			1,
			1,
			{ nOffsetX = nPos },
			"equiproom"
		);
	end
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,1);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,2);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,3);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,4);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,5);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);
	return 1;
end


tbAutoAimHT:Init();
--LoadUiGroup(Ui.UI_PLAYERPANEL, "playerpanel.ini");