local tbAutoAimHT	= Map.tbAutoAimHT or {};
Map.tbAutoAimHT	= tbAutoAimHT;
--未完成部分
--1、延迟增加ID标识，避免干扰。
--2、配置更新应该按不同门派进行保存和读取。

--注册时间控件
local tbTimer = Ui.tbLogic.tbTimer;
--注册信息管理控件
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
--与SELECTNPC挂勾
local tbSelectNpc    = Ui(Ui.UI_SELECTNPC);

--[[local tCmd = { "Map.tbAutoAimHT:AutoFollow();", "AutoFollow", "", "Ctrl+X", "Ctrl+X", "AutoFollow苔" };
AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]); ]]

local SELF_EQUIPMENT = 			-- 瑁呭鎺т欢琛?
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


-- 载入时初始化
function tbAutoAimHT:Init()
	self:ModifyUi();
	self.nYaoState 		= 0;	-- 自动吃药状态
	self.nPickState 	= 0;	-- 自动拾取状态
	self.nfireState 	= 0;	-- 自动灭火状态
	self.nFollowTime    	= 0.1;  -- 跟随检测频率
	self.nFollowState 	= 0;
	self.nPID 		= 0;
	self.nPlayerID		= 0;  
	self.nszName		= nil;
	self.nFRange		= 0.6; 	-- 战斗跟随直线距离
	self.nEmFRange		= 0.6; 	-- 峨嵋跟随直线距离
	self.EatFood 		= 80;	-- 血或内低于80%，吃菜
	self.DelayStat 		= 0;	-- 延迟判断参数
	
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
--配置更新
function tbAutoAimHT:UpdateSetting(AimCfg)
	self.bYaoDelay 	= AimCfg.nYaoDelay;
	self.life_left 	= AimCfg.nLifeRet;
	self.mana_left 	= AimCfg.nManaRet;
	self.EMHealDelay = AimCfg.nHealDelay;
	self.bAutoEat = AimCfg.nAutoEat;
end
--功能1：自动吃药----------------------------------------------------------------------------------------
--自动吃药函数
function tbAutoAimHT:FAutoYao()
	local nYaoTimer = 0;
	local TXTINT	= self.bYaoDelay*1000;
	if self.nYaoState == 0 then
		self.nYaoState = 1;
		me.Msg("<color=yellow>D霉ng thu峄慶 t峄? 膽峄檔g<color>");
		me.Msg("<color=yellow>Delay:<color>"..string.format("<color=green>%d<color>",TXTINT).."ms");
		me.Msg("<color=yellow>B啤m m谩u khi sinh l峄眂 < <color>"..string.format("<color=green>%d",self.life_left).."<color>");
		me.Msg("<color=yellow>B啤m mana khi l峄眂 < <color>"..string.format("<color=green>%d",self.mana_left).."<color>");
		nYaoTimer = tbTimer:Register(0.5 * Env.GAME_FPS, self.YaoTimer, self);
	else
		self.nYaoState = 0;
	end
end

--自动吃药
function tbAutoAimHT:YaoTimer()
	if self.nYaoState == 0 then
		me.Msg("<color=red>T岷痶 d霉ng thu峄慶 t峄? 膽峄檔g<color>");
		return 0;
	end
	--吃红
	if (me.nCurLife < tonumber(self.life_left)) and self.DelayStat == 0 then
		local nHONG = Map.AimCommonHT:GetHongYao();
		me.UseItem(nHONG);
		self:MyDelay(self.bYaoDelay);
	end
	--吃蓝
	if (me.nCurMana < tonumber(self.mana_left)) and self.DelayStat == 0 then
		local nLAN = Map.AimCommonHT:GetLanYao();
		me.UseItem(nLAN);
		self:MyDelay(self.bYaoDelay);
	end
end
--功能2：自动拾取------------------------------------------------------------------------------------
tbAutoAimHT.FPickUp = function(self)
	local nPickTime = 0;
	local Space_Time = 0.2;	-- 0.1拾取物品的时间延迟/秒(已经到极限再快会死机的)
	if (self.nPickState == 0 ) then
		self.nPickState =1;
		nPickTime = Timer:Register(Space_Time * Env.GAME_FPS, self.PickTimer, self);
		me.Msg("<color=yellow>B岷璽 nh岷穞 膽峄? nhanh<color>");
	else
		self.nPickState =0;
		Timer:Close(nPickTime);
		nPickTime = 0;
		me.Msg("<color=green>T岷痶 nh岷穞 膽峄? nhanh<color>");
	end
end

tbAutoAimHT.PickTimer = function(self)
	if (self.nPickState ==0 ) then
		return 0;
	end
	AutoAi.PickAroundItem(Space);
end

--功能3：集合召唤------------------------------------------------------------------------------------

---- 监视聊天信息 ----
function tbAutoAimHT:ModifyUi()
	tbAutoAimHT.Say_bak	= tbAutoAimHT.Say_bak or UiCallback.OnMsgArrival
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg)
		tbAutoAimHT.Say_bak(UiCallback, nChannelID, szSendName, szMsg);
		-- 延迟调用OnSay（不延迟关不掉窗口）
		local function fnOnSay()
			tbAutoAimHT:OnSay(nChannelID, szSendName, szMsg);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

----召唤1：发起集合召唤----
function tbAutoAimHT:Select()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Tri峄噓 t岷璸::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Tri峄噓 t岷璸::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..") C岷 anh em gi煤p 膽峄? !");
	local tbMsg = {};
	tbMsg.szMsg = string.format("Ch峄峮 k锚nh Chat 膽峄? g峄峣 tri峄噓 t岷璸!");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "H峄", "G峄峣"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--频道
			SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end

----召唤2：发动采集魔晶石----
function tbAutoAimHT:CalltoDan()
	SendChannelMsg("Team","M猫");
end

----召唤3：发动[启动/停止]灭火----
function tbAutoAimHT:CalltoFire()
	if self.nfireState == 0 then
		self.nfireState = 1
		SendChannelMsg("Team","B岷痶 膽岷 ch谩y");
	else
		self.nfireState = 0
		SendChannelMsg("Team","Ng峄玭g chi岷縩 膽岷");
	end
end

---- 客户端收到消息时 ----
function tbAutoAimHT:OnSay(nChannelID, szSendName, szMsg)
	local stype
	if nChannelID==3 then
		stype="膼峄搉g 膼峄檌"
	end      
	---- 聊天信息分拆 ----
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
	----采集魔晶石信息----
	if string.find(szMsg,"M猫") and stype=="膼峄搉g 膼峄檌" then
		me.Msg("Spar b岷痶 膽岷 thu th岷璸 ph茅p thu岷璽")
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4223) then
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
	end
	----启动灭火信息----
	if  string.find(szMsg,"B岷痶 膽岷 ch谩y ch峄痑 ch谩y") and szSendName==me.szName  then
		self.TimeridFire = Ui.tbLogic.tbTimer:Register(20, tbAutoAimHT.Fire, self)
		me.Msg("<color=yellow>B岷痶 膽岷 ch谩y ch峄痑 ch谩y<color>")
	end
	----停止灭火信息----
	if  string.find(szMsg,"Ch谩y h岷縯") and szSendName==me.szName  then
		Ui.tbLogic.tbTimer:Close(self.TimeridFire);
		--Ui.tbLogic.tbTimer:Close(Map.TimeridFire);
		me.Msg("<color=red>Ch谩y h岷縯<color>")
	end
end

------子功能2-3：灭火----
function tbAutoAimHT:Fire()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--进度条，什么也不做
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

--功能3：自动跟随------------------------------------------------------------------------------------
--传递面版参数
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

--自动跟随
function tbAutoAimHT:AutoFollow()
	--确定跟随距离
	if (me.nFaction == 5 and me.CanCastSkill(98) == 1) then
		self.nRange = self.nEmFRange;  -- 如果是峨嵋,则使用nEmFollowRange这个距离
	else
		self.nRange = self.nFRange; 
	end

	if self.nFollowState == 0 then
		self.nFollowState = 1;
		--第一步：跟随对象确定
		if self.nPID == 0 then --面版中没有选择对象则按下面顺序选择对象：
			local playerInfo = tbSelectNpc.pPlayerInfo;
			--优先1：鼠标选择的NPC
			if playerInfo then
				self.nPlayerID = tbSelectNpc.pPlayerInfo.dwId;
				self.nszName = tbSelectNpc.pPlayerInfo.szName;
				self.nPType = 2;
			--优先2：选择队伍的队长
			else
				local nAllotModel, tbMemberList = me.GetTeamInfo();
				if nAllotModel and tbMemberList then
    					local tLeader = tbMemberList[1];
					if tLeader.szName == me.szName then
						Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Kh么ng c贸 m峄 ti锚u ch铆nh x谩c<color>");
						me.Msg("<color=Yellow>B岷 l脿 膽峄檌 tr瓢峄焠g, kh么ng th峄? theo b岷 膽瓢峄<color=Yellow>");
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
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Kh么ng c贸 m峄 ti锚u ch铆nh x谩c<color>");
			me.Msg("<color=Yellow>Kh么ng c贸 m峄 ti锚u ch铆nh x谩c<color=Yellow>");
			self.nFollowState = 0;
			return;
		end
		--启动跟随
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Theo sau: <color> ["..self.nszName.."<color>]");
		me.Msg("<color=green>B岷痶 膽岷 theo sau:<color> [<color=Yellow>"..self.nszName.."<color>]");
		nFTimer1 = Timer:Register(self.nFollowTime * Env.GAME_FPS, self.OnFollow1, self);
	else
		self.nFollowState = 0;
		Timer:Close(nFTimer1);
		me.Msg("<color=green>Ng峄玭g theo sau - H峄? t峄憂g<color>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=yellow>Ng峄玭g theo sau - H峄? t峄憂g<color>");
		self.nPID = 0;
		self.nPosX = 0;
		self.nPosY = 0;
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
	end
end
--战斗跟随
function tbAutoAimHT:OnFollow1()
	-- 检查吃食物self.EatFood=80% 	
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
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- 先吃短效食物
			local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				if 0 == AutoAi.Eat(4) then -- 长效食物
					print("AutoAi- No Food...");
				end
			end
		end
	end
	--进度条，什么也不做
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	--强制中断
	if self.nFollowState == 0 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		return 0;
	end
	--获取自己地图坐标
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nMMap = nMyMap
	self.nMyPosX = nMyX / 8;
	self.nMyPosY = nMyY / 16;
	--获取对象地图
	local tbMember = me.GetTeamMemberInfo();
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].szName == self.nszName then
			self.nPMap = tbMember[i].nMapId;
		end
	end
	--修正副本地图ID
	if self.nMMap == 344 then --修正万花
		self.nPMap = 344;
	elseif self.nMMap == 273 then --修正家族关卡[神秘宝库]
		self.nPMap = 273;
	elseif self.nMMap == 287 then --修正千琼
		self.nPMap = 287;
	elseif self.nMMap == 254 then --修正陶朱公疑冢
		self.nPMap = 254;
	elseif self.nMMap == 272 then --修正大漠古城
		self.nPMap = 272;
	elseif self.nMMap == 557 then --修正伏牛山后山(副本)
		self.nPMap = 557;
	elseif self.nMMap == 560 then --修正百蛮山
		self.nPMap = 560;
	elseif self.nMMap == 493 then --修正海陵王墓
		self.nPMap = 493;
	end
	--判断跑图或跟随战斗and self.nPMap == self.nMMap
	if self.nPType == 2 then
		self:FLFight();
	elseif self.nPMap == self.nMMap then
		self:FLFight();
	else
		--逐图修复传送问题
		if self.nPMap == 90 then -- 修复[浣花溪]
			self.PlayX = "1900";
			self.PlayY = "3900";
		elseif self.nPMap == 97 and self.nMMap ~=90 then -- 修复[响水洞]
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

-- 异图跑图
function tbAutoAimHT:GotoPmap(PlayX,PlayY)
	--进度条，什么也不做
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local sznMap = GetMapNameFormId(self.nPMap)
	me.Msg("B岷 膽峄?: <color=Blue>["..sznMap.."]<color> Theo sau: <color=Yellow>"..self.nszName.."<color>")
	local nPlayPosInfo ={}
	nPlayPosInfo.szType = "pos"
	nPlayPosInfo.szLink = sznMap..","..self.nPMap..","..PlayX..","..PlayY;
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,nPlayPosInfo);
	me.Msg(nPlayPosInfo.szLink)
end
-- 同图跟随战斗
function tbAutoAimHT:FLFight()
	local bChecked = me.GetNpc().IsRideHorse();
	--获取对象坐标
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
	--计算直线距离
	if (self.nTrainDcChua == 0) then
	local TargetDis = math.sqrt((self.nMyPosX-self.nPosX)^2 + (self.nMyPosY-self.nPosY)^2);
		--判断距离并确定战斗或加血me.Msg("D:"..self.EMHealDelay.."Eat:"..self.bAutoEat)	
		if (TargetDis < self.nRange) then
			if (self.OldPosX ~= self.nPosX) or (self.OldPosY ~= self.nPosY) then
				self.OldTime = GetTime();
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime1 < GetTime()) and (self.nOnOffTrainAfk == 1) then
				SendChannelMsg("Team","Kh峄焛 膽峄檔g l岷 auto train!!");				
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
					me.Msg("Nguy hi峄僲 S峄ヽ b岷璽 l岷?!!!");
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				else
					local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
					if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	-- k峄? n膬ng ph岷 xu峄憂g ng峄盿锛? xu峄憂g ng峄盿 l岷璸 t峄ヽ
						Switch("horse");	-- xu峄憂g ng峄盿 
					end
					if (me.nAutoFightState ~= 1) then					
						AutoAi.ProcessHandCommand("auto_fight", 1);
					end
				end
			end
			end
		else			
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then  -- 如果是峨嵋直接跟随
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

-- 关闭自动战斗
function tbAutoAimHT:StopFight()
	if (self.nMMap < 298 or self.nMMap > 332) or self.nPType == 2 then --如果用鼠标选择对象，忽视地图。
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
		me.AutoPath(self.nPosX*8, self.nPosY*16);
	else -- 逍遥谷地图(ID:298-332)
	--逍遥谷等待杀怪结束才跟随[测试]
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 10);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nKind == 0) then  --周围还有怪
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("T峄峚 膽峄?: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("T峄峚 膽峄?: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			end
		end
	end
end
-- 检测附近是否有反弹怪
function tbAutoAimHT:IsDangerous()
	local isDangerous = 0;
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 40);
	for _, pNpc in ipairs(tbAroundNpc) do		
		local id = pNpc.nTemplateId;
		if (id == 3146 or id == 3149 or id == 3152 or id == 3157 or id == 3177 or id == 3193 or id == 3277 ) then
			-- 慕容家虎:3146;姑苏大鳄鱼:3149;慕容家豹:3152;弹性机璜:3157;慕容氏鬼魂:3177;强力机璜:3193;木桩反弹:3277
			isDangerous = 1;
			break;
		end
	end
	return isDangerous;
end
-- 通用5: 延迟
function tbAutoAimHT:MyDelay(DelayTime)
	self.nTest = 0;
	self.nDtime = DelayTime;
	self.DelayStat = 1;
	local DelayStart = tbTimer:Register(0.2 * Env.GAME_FPS, self.DelayClock, self);
end
-- 通用5: 延迟[时钟]
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