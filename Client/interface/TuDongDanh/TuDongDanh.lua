local preEnv = _G
AutoAi.ASSIST_SKILL_LIST = {
	[preEnv.Player.FACTION_NONE]		= {};		-- 无门派
	[preEnv.Player.FACTION_SHAOLIN]		= {26};		-- 少林
	[preEnv.Player.FACTION_TIANWANG]	= {46,55};	-- 天王
	[preEnv.Player.FACTION_TANGMEN]		= {};		-- 唐门
	[preEnv.Player.FACTION_WUDU]		= {};		-- 五毒
	[preEnv.Player.FACTION_EMEI]		= {835,1249};		-- 峨嵋
	[preEnv.Player.FACTION_CUIYAN]		= {115,122};	-- 翠烟
	[preEnv.Player.FACTION_GAIBANG]		= {132,489};	-- 丐帮
	[preEnv.Player.FACTION_TIANREN]		= {};		-- 天忍
	[preEnv.Player.FACTION_WUDANG]		= {161,783};	-- 武当,497纯阳无极太费蓝,有没有必要呢?
	[preEnv.Player.FACTION_KUNLUN]		= {177,180,191,697};	-- 昆仑
	[preEnv.Player.FACTION_MINGJIAO]	= {};	-- 明教
	[preEnv.Player.FACTION_DUANSHI]		= {230};	-- 大理
};
local tbSkill = {
205,
211,
208,
31, --Su Tu Hong
41, -- Doan Hon Thich 
148,
847,
199,
492,

--115, -- Tuyet Anh
--122, -- Ngu Tuyet An
--132, --Hoat Bat Luu Thu
153,

--199, -- Khon Ho Van Tieu
216, --Nhat Duong Chi 
219, -- Lang Ba Vi Bo
--230, -- Thien Nam bo Phap
1246, --Xuyen Van Tien
266, --doan can nhan
285, --No Moc
491, -- Ac Cau Lan Lo
494,
--
--699, -- Tuy Tien Thac Cot
190,
192,
--
770, -- Thau Thien Hoan Nhat
821, -- Tuy Bat Tien Con
--
831, -- Chu Cap Thanh Minh
269, --On Co Chi Khi
82, --Van co thuc tam
--
839, -- Thap Dien Mai Phuc
861, -- Thanh Hoa Lenh Phap
865, -- Kinh Thien Nhat Kiem
867, -- Ngoc Tuyen Tay Tran
1209, -- Vu Da Le Hoa
1212, --Thau Long Chuyen Phuong
1241, --Dai Thua Nhu Lai Chu
--1249, -- Van tuong than cong
1258,
1252, -- Da Lai Tay Phong
1258, -- Luong Nghi Kiem Phap
1260, --Ngu Phong Thuat
1261, --Hon Phach Phi Duong
--1376, --Truy Hon Dan
--1377, --Chieu Hon Khuc
1216,--Vo Dang kiem
}
function AutoAi:UpdateCfg(tbAutoAiCfg)
	AutoAi.ProcessHandCommand("auto_fight", tbAutoAiCfg.nAutoFight);
	if tbAutoAiCfg.nAutoFight == 1 then
		local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1)
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
			Switch("horse")
		end
	end
	self.pick_item_value = tbAutoAiCfg.nPickValue * 2;
	self.life_left = tbAutoAiCfg.nLifeRet;
	self.no_pick_commonitem = tbAutoAiCfg.nUnPickCommonItem;
	self.attack_skill = {};
	self.attack_skill[1] = tbAutoAiCfg.nSkill1;
	self.attack_skill[2] = tbAutoAiCfg.nSkill2;
	--for i = 1,table.getn(tbBuaChu) do
	--	table.insert(self.attack_skill,tbBuaChu[i])
	--end
	for i = 1,table.getn(tbSkill) do
		table.insert(self.attack_skill,tbSkill[i])
	end
	self.bAutoRepair = tbAutoAiCfg.nAutoRepair;
	self.bAcceptJoinTeam = tbAutoAiCfg.nAcceptTeam;
	self.bAutoDrinkWine = tbAutoAiCfg.nAutoDrink;
	self.nPvpMode = tbAutoAiCfg.nPvpMode;
end
local tbNpcDanhBuaChu = {
	
}
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
		--self:ChangeSkill();
		if me.nFaction == 11 and me.nRouteId == 2 then
			self.attack_skill[1] = 210;--Càn Khôn Đại Na Di 6x
			self.attack_skill[2] = 770;--Thâu Thiên Hoán Nhật 7x
			self.attack_skill[3] = 211;--Thánh Hỏa Liêu Nguyên 9x
			self.attack_skill[4] = 208;--Vạn Vật Câu Phần 5x
			self.attack_skill[5] = 205;--Thánh Hỏa Phần Tâm 1x
		elseif me.nFaction == 10 and me.nRouteId == 2 then
			self.attack_skill[1] = 192; --Lôi Động Cửu Thiên 9x
			self.attack_skill[2] = 699; --Túy Tiên Thác Cốt 6x
			self.attack_skill[3] = 1260; --Ngự Phong Thuật
			self.attack_skill[4] = 190; --Thiên Tế Tấn Lôi 5x
			self.attack_skill[5] = 188; --Cuồng Lôi Chấn Địa 1x
		elseif me.nFaction == 8 and me.nRouteId == 2 then
			self.attack_skill[1] = 155; --Nhiếp Hồn Loạn Tâm 7x
			self.attack_skill[2] = 494; --Hỏa Liên Phần Hoa 6x
			self.attack_skill[3] = 151; --Đạn Chỉ Liệt Diệm 1x
			self.attack_skill[4] = 153; --Thôi Sơn Điền Hải 5x
			self.attack_skill[5] = 156; --Thiên Ngoại Lưu Tinh 9x
		end
		--me.Msg(tostring("Faction="..me.nFaction));
		--me.Msg(tostring("nRouteId="..me.nRouteId));
		for _, nSkillId in ipairs(self.attack_skill) do
			--me.Msg(tostring("nSkillId="..nSkillId));
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


