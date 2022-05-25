if not MODULE_GAMECLIENT then
	return
end

Require("\\script\\misc\\autofight_setting.lua");

local self = AutoAi;
self.life_left = 50; --血剩下多少就补血（百分比）
self.nCounter = 0;
self.nLastLife = 0;
self.nLastMana = 0;
if not self.nLastFood then
	self.nLastFood = 0;
end
self.attack_skill = {}; --攻击技能数组(排前的技能优先使用)
self.auto_fight_pos = {[1] = {}, [2] = {}};	--定点（支持两点来回打怪）
self.attack_point = 1;	-- 1一个定点，2为2个定点
self.auto_pos_index = 0; --第几个定点，等于0则不作定点
self.pick_item_value = 0;
self.eat_life_time = 0;
self.eat_mana_time = 0;
self.auto_move_counter = 0;
self.sleep_counter = 0;
self.no_pick_commonitem = 0;
self.no_mana = 0;
self.ncurmana = 1000;
self.TimeLastFire = 0;
self.TimeLastWine = 0;
self.WineUsed = 0; -- 已经喝过的酒
self.bAcceptJoinTeam = 0;
self.bAutoRepair = 0;
self.nPvpMode = 0;
AutoAi.LastRepairTime = 0;
AutoAi.bAutoDrinkWine = 0;
AutoAi.bReleaseUiState = 0;
self.tbAutoAiCfg = {
	nAutoFight = 0,
	nUnPickCommonItem = 0,
	nPickValue = 0,
	nLifeRet = 50,
	nSkill1 = 0,
	nSkill2 = 0,
	nAutoRepair = 0,
	nAcceptTeam = 0,
	nAutoDrink = 0,
	nPvpMode = 0,
};

function AutoAi:UpdateCfg(tbAutoAiCfg)
	AutoAi.ProcessHandCommand("auto_fight", tbAutoAiCfg.nAutoFight);
	self.pick_item_value = tbAutoAiCfg.nPickValue * 2;
	self.life_left = tbAutoAiCfg.nLifeRet;
	self.no_pick_commonitem = tbAutoAiCfg.nUnPickCommonItem;
	self.attack_skill[1] = tbAutoAiCfg.nSkill1;
	self.attack_skill[2] = tbAutoAiCfg.nSkill2;
	self.bAutoRepair = tbAutoAiCfg.nAutoRepair;
	self.bAcceptJoinTeam = tbAutoAiCfg.nAcceptTeam;
	self.bAutoDrinkWine = tbAutoAiCfg.nAutoDrink;
	self.nPvpMode = tbAutoAiCfg.nPvpMode;
end

local tb = {
bkiemcon150={ --Kiếm côn
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bdaocon150={ --Đao côn
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bmanhan150={ --Ma nhẫn
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bchiennhan150={ --Chiến nhẫn
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bvokhi150={ --Khí võ
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	bvokiem150={ --Kiếm võ
		defencedeadlystrikedamagetrim={{{1,37},{2,39}}},
		deadlystrikeenhance_r={{{1,110},{2,120}}},
		ignoreskill={{{1,11},{2,12}},0,{{1,3},{2,3}}},
		allspecialstateresisttime={{{1,100},{10,150},{20,400},{21,400}}},
		seriesenhance={{{1,50},{10,850},{20,2000},{21,2000}}},
		seriesabate={{{1,50},{10,850},{20,2000},{21,2000}}},
		--ignoredefenseenhance_v ={{{1,110},{2,120}}},
		lifemax_p={{{1,12},{2,14}}},
		lifereplenish_p={{{1,11},{2,12}}},
		--fastwalkrun_p={{{1,21},{2,22}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)

function AutoAi:IsAcceptJoinTeam()
	return self.bAcceptJoinTeam;
end

function AutoAi:CalcRang()	--计算两定点距离
	if (self.attack_point == 2) then
		local a = self.auto_fight_pos[1].x;
		local b = self.auto_fight_pos[1].y;
		local c = self.auto_fight_pos[2].x;
		local d = self.auto_fight_pos[2].y;
		if (a and b and c and d)then
			return math.sqrt((a-c) * (a-c) + (b-d) * (b-d)) + self.ACTIVE_RADIUS;
		end	
	end
	return 0;
end

function AutoAi:GotGouhuo()
	AutoAi:Pause();
	self.TimeLastFire = GetTime();
	Timer:Register(Env.GAME_FPS * 8, self.DelayResumeAi, self); -- 防止篝火脚本忘了写AutoAi:Resume()
end

function AutoAi:DrinkWine()
	for i,tbWine in pairs(self.WINES) do
		local tbFind = me.FindItemInBags(unpack(tbWine));
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.TimeLastWine = GetTime();
			return 1;
		end
	end	
end

function AutoAi:AutoRepair()
	if self.bAutoRepair ~= 1 then
		return;
	end
	if AutoAi.LastRepairTime + 60 > GetTime() then		-- 每1分钟检查一次是不是要修
		return 0;
	end
	for i = 0, Item.EQUIPPOS_NUM - 1 do
		local pItem = me.GetItem(Item.ROOM_EQUIP,i,0)
		if pItem and pItem.nCurDur < Item.DUR_MAX / 5 then -- 低于20%耐久就修
			for nLevel, tbJinxi in pairs(self.JINXI) do
				local tbFind = me.FindItemInBags(unpack(tbJinxi));
				for _, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
					self.bReleaseUiState = 1;
   					local nResult = me.RepairEquipment(pItem.nIndex, 3); --3:用物品修理
   				end
			end
		end
	end
	self.LastRepairTime = GetTime();
	Timer:Register(Env.GAME_FPS * 1, self.DelayCloseRepairWnd, self);
end

function AutoAi:DelayCloseRepairWnd()
	if self.bReleaseUiState == 1 then
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);
		self.bReleaseUiState = 0;
	end

	return 0;
end

function AutoAi:DelayResumeAi()
	if self.TimeLastFire + 5 <= GetTime() then
		AutoAi.LockAi(0);
	end
	return 0;
end

function AutoAi:AutoDrinkWine()
	if self.bAutoDrinkWine ~= 1 then
		return;
	end
	local nSkillLevel,nStateType,nEndTime,bIsNoClearOnDeath = me.GetSkillState(self.WINE_SKILL_ID);
	if (nSkillLevel and nSkillLevel > 0 and nEndTime and nEndTime > 0) or
	self.TimeLastWine + self.TIME_WINE_EFFECT > GetTime() then
		return 0;
	else
		local nSkillLevel,nStateType,nEndTime,bIsNoClearOnDeath = me.GetSkillState(self.FIRE_SKILL_ID);
		if nSkillLevel and nSkillLevel > 0 then
			AutoAi:DrinkWine();
		end
	end
end

function AutoAi:Pause()
	AutoAi.LockAi(1);
end

function AutoAi:Resume(nStatus)
	AutoAi.LockAi(0);
	if nStatus == self.RESUME_GOUHUO_FIRED then
		self.TimeLastFire = GetTime();
		AutoAi:AutoDrinkWine();
	end
end

function AutoAi:ChangeSkill()
	for _, nSkillId in ipairs(self.attack_skill) do
		if (me.CanCastSkill(nSkillId) == 1) then
			AutoAi.SetActiveSkill(nSkillId, self.MAX_SKILL_RANGE);
			if (AutoAi.GetSkillCostMana(nSkillId) > self.ncurmana) then
				self.no_mana = 1;
			end
			return;
		end
	end
	if (me.CanCastSkill(me.nLeftSkill) == 1) then
		AutoAi.SetActiveSkill(me.nLeftSkill, self.MAX_SKILL_RANGE);
	end;
end

function AutoAi:InitKeepRange()
	local x,y = me.GetNpc().GetMpsPos();
	self.auto_fight_pos[1].x = x;
	self.auto_fight_pos[1].y = y;
	self.auto_fight_pos[2].x = x;
	self.auto_fight_pos[2].y = y;
	self.keep_range = self:CalcRang();
	self.auto_pos_index = 1;	--只要设定定点，就把这个设为1
end

function AutoAi:AI_InitAttack(nAttack)
	AutoAi.LockAi(0); -- 解锁
	if (nAttack == 1) then
		Log:Ui_SendLog("Tự động đánh quái", 1);
		self:ChangeSkill();
		self:InitKeepRange();
		me.AddSkillEffect(self.HEAD_STATE_SKILLID);
		me.Msg("Mở tự chiến đấu.");
		print("AutoAi- Start Attack");
	else
		me.RemoveSkillEffect(self.HEAD_STATE_SKILLID);
		me.Msg("Đóng tự chiến đấu.");
		print("AutoAi- Stop Attack");
	end	
	AutoAi.ProcessHandCommand("auto_pick", nAttack);
	AutoAi.ProcessHandCommand("auto_drug", nAttack);
end

function AutoAi:AI_Normal(nFightMode, nCurLife, nCurMana, nMaxLife, nMaxMana) --自动打怪时每1/6秒执行
	if nFightMode == 0 then
		me.AutoFight(0);
		return;
	end
	AutoAi:AutoDrinkWine();
	AutoAi:AutoRepair();
	self.ncurmana = nCurMana;
	local nCurTime = GetTime();
	self.nCounter = self.nCounter + 1; --计时器
	if (nCurLife * 100 / nMaxLife < self.LIFE_RETURN) then
		if self.nPvpMode == 0 then
			AutoAi.Flee(); -- 逃跑
			print("AutoAi- Flee...");
		end
	end
	if (nCurLife * 100 / nMaxLife < self.life_left) then 
		if (self.nCounter - self.eat_life_time > self.EAT_SLEEP) then
			if (AutoAi.Eat(1) == 0) then
				AutoAi.ReturnCity();
				print("AutoAi- No Red Drug...");
			else
				AutoAi.Eat(1);
			end
			self.eat_life_time = self.nCounter;
		end
	end
	local bNoMana = nCurMana * 100 / nMaxMana < self.MANA_LEFT;
	if (bNoMana or self.no_mana == 1) then
		if (self.nCounter - self.eat_mana_time > self.EAT_SLEEP) then
			self.no_mana = 0;
			if AutoAi.Eat(2) == 0 then
				print("AutoAi- No Blue Drug...");
				AutoAi.ReturnCity();
			end
			self.eat_mana_time = self.nCounter;
		end
	end
	if (bNoMana or nCurLife * 100 / nMaxLife < self.EAT_FOOD_LIFE) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- 先吃短效食物
			local nLevel, nState, nTime = me.GetSkillState(self.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				self.nLastFood = nCurTime;
				if 0 == AutoAi.Eat(4) then -- 长效食物
					print("AutoAi- No Food...");
				end
			end		
		end
	end
	if (math.mod(self.nCounter, 6) == 0) then
		local nSelfIndex = AutoAi.GetSelfIndex();
		for _, nSkillId in ipairs(self.ASSIST_SKILL_LIST[me.nFaction]) do
			local nLevel, nState, nTime = me.GetSkillState(nSkillId);
			if ((not nTime or nTime < 36) and me.CanCastSkill(nSkillId) == 1) then
				if (AutoAi.GetSkillCostMana(nSkillId) > nCurMana) then
					self.no_mana = 1;
					break;
				end
				AutoAi.DoAttack(nSkillId, nSelfIndex);
				self.sleep_counter = 3;
				print("AutoAi- Use Right Skill", nSkillId);
				break; -- 每次只使用1个，否则会覆盖
			end
		end
		AutoAi:ChangeSkill()
	end
end

function AutoAi:AutoFight() --自动打怪脚本
	if (self.sleep_counter > 0) then
		self.sleep_counter = self.sleep_counter - 1;
		return;
	end
	
	if self.nPvpMode == 1 then
		return;
	end
	
	local nTargetIndex = 0;
	if self.auto_move_counter <= 0 then
		nTargetIndex = AutoAi.AiFindTarget();
		if (nTargetIndex > 0 and self.KEEP_RANGE_MODE == 1 and self.auto_pos_index > 0) then
			local cNpc = KNpc.GetByIndex(nTargetIndex);
			local x,y,world = cNpc.GetMpsPos();
			local dx = x - self.auto_fight_pos[self.auto_pos_index].x;
			local dy = y - self.auto_fight_pos[self.auto_pos_index].y;
			if (dx and dy)then
				if (self.keep_range and self.keep_range > self.ATTACK_RANGE)then
					self.keep_range = self.keep_range - 50;
				else
					self.keep_range = self.ATTACK_RANGE;
				end
				if (dx * dx + dy * dy > self.keep_range * self.keep_range)then
					nTargetIndex = 0;
				end
			end
		end
		if (nTargetIndex <= 0 and self.auto_pos_index > 0)then
			self.auto_move_counter = 0;
		end
	else
		self.auto_move_counter = self.auto_move_counter - 1;
	end	
	if (nTargetIndex > 0) then
		AutoAi.SetTargetIndex(nTargetIndex);
		print("AutoAi- Set Target", nTargetIndex);
		self:ChangeSkill();
	else
		if self.auto_pos_index <= 0 then
			print("AutoAi- Auto Move...");
			AutoAi.AiAutoMove();
		else
			local nx = self.auto_fight_pos[self.auto_pos_index].x;
			local ny = self.auto_fight_pos[self.auto_pos_index].y;
			if (nx == nil or ny == nil) then
				self.auto_pos_index = 0;
				return;
			end
			local x,y,world = me.GetNpc().GetMpsPos();
			local dx = x - nx;
			local dy = y - ny;
			if (self.attack_point == 1) then			
				if (dx * dx + dy * dy > self.ATTACK_RANGE * self.ATTACK_RANGE * 0) then
					AutoAi.AiAutoMoveTo(nx, ny);
					print("AutoAi- Auto Move To", nx, ny);
					return;
				else
					AutoAi.Sit();
				end
			elseif (self.attack_point == 2) then
				if (AutoAi.AiAutoMoveTo(nx, ny) <= 0) then
					self.keep_range = self:CalcRang();
					if (self.auto_pos_index == 1)then
						self.auto_pos_index = 2;
					else
						self.auto_pos_index = 1;
					end
				end
			end
		end
		
	end	
end

function AutoAi:CheckItemPickable()
	if it.nGenre > 16 then
		if self.no_pick_commonitem ~= 1 then
			print("AutoAi- Pick Item", it.szName);
			return 1;
		end
		return 0;
	end
	print("AutoAi- Equip Value", it.nStarLevel);
	if it.nStarLevel >= self.pick_item_value then
		print("AutoAi- Pick Equip", it.szName);
		return 1;
	end
	me.Msg("Tự động bỏ trang bị cấp thấp!");
	return 0;
end

AutoAi.Init();
