

if (not Item.tbZhaoHuanLingPai) then
	Item.tbZhaoHuanLingPai = {};
end

local tb = Item.tbZhaoHuanLingPai;
tb.nTime = 10;
tb.TEMPLET_ITEM_ID = {18,1,87,1}; --召唤模版类物品.取召唤类同一类型的其中一种做为模版
function tb:SelectPlayer(nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState)
	GlobalExcute({"Item.tbZhaoHuanLingPai:SeachPlayer_GS1", nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState});
end

function tb:SeachPlayer_GS1(nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState)
	if tonumber(nKind) == 1 then
		self:KinCallMember(nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState);
	elseif tonumber(nKind) == 2 then
		self:TongCallMember(nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState);
	end
end
function tb:KinCallMember(nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState)
	local cKin = KKin.GetKin(nKinTongId);
	if not cKin then
		return 0;
	end
	
	local nCanSendIn = Item:IsCallInAtMap(nMapId, unpack(self.TEMPLET_ITEM_ID));
	if (nCanSendIn ~= 1) then
		return 0;
	end	
	
	local itor = cKin.GetMemberItor();
	local cMember = itor.GetCurMember();
	while cMember do
		local nMemberPlayerId = cMember.GetPlayerId()
		local nOnline = KGCPlayer.OptGetTask(nMemberPlayerId, KGCPlayer.TSK_ONLINESERVER);
		if nOnline and nOnline > 0 then
			if nMemberPlayerId ~= nPlayerId then
				local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
				if (pPlayer) then
					local nCanSendOut = Item:IsCallOutAtMap(pPlayer.nMapId, unpack(self.TEMPLET_ITEM_ID));
					if (nCanSendOut == 1) then
						self:SeachPlayer(nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState);
					end
				end
			end
		end
		cMember = itor.NextMember()
	end	
end

function tb:TongCallMember(nKind, nMapId, nPosX, nPosY, nPlayerId, nKinTongId, szName, nFightState)
	local nTongId = nKinTongId;
	if nTongId == nil or nTongId <= 0 then
		return 0;
	end
	
	local nCanSendIn =  Item:IsCallInAtMap(nMapId, unpack(self.TEMPLET_ITEM_ID));
	if (nCanSendIn ~= 1) then
		return 0;
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 0;
	end	
	local cKinItor = cTong.GetKinItor()
	local nKinId = cKinItor.GetCurKinId()
	while nKinId ~= 0 do
		local cKin = KKin.GetKin(nKinId);
		if not cKin then
			return 0;
		end
		local itor = cKin.GetMemberItor();
		local cMember = itor.GetCurMember();
		while cMember do
			local nMemberPlayerId = cMember.GetPlayerId()
			local nOnline = KGCPlayer.OptGetTask(nMemberPlayerId, KGCPlayer.TSK_ONLINESERVER);
			if nOnline and nOnline > 0 then
				if nMemberPlayerId ~= nPlayerId then
					local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
					if (pPlayer) then
						local nSelfKinId, nSelfMemberId = pPlayer.GetKinMember();
						if Tong:HaveFigure(nTongId, nSelfKinId, nSelfMemberId, 0) == 1 then							
							local nCanSendOut = Item:IsCallOutAtMap(pPlayer.nMapId, unpack(self.TEMPLET_ITEM_ID));
							if (nCanSendOut == 1) then
								self:SeachPlayer(nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState);
							end
						end	
					end
				end
			end
			cMember = itor.NextMember()
		end
	  nKinId = cKinItor.NextKinId()
	end
end

local tb	= {
	skill150dmtt={ --????
		appenddamage_p= {{{1,76*FightSkill.tbParam.nS1},{10,76},{20,76*FightSkill.tbParam.nS20},{21,76*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,6*18},{20,6*18}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,21},{20,40}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,12},{10,30},{20,50}},{{1,36},{20,54},{21,54}}},
		state_weak_attacktime={{{1,110},{10,200}}},
		missile_hitcount={{{1,5},{2,5}}},
		skill_flyevent={{{1,1960},{20,1960}},{{1,10},{2,10}}},
		skill_showevent={{{1,2},{20,2}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	skill150dmtt_child={ --????,???????
		appenddamage_p= {{{1,76*FightSkill.tbParam.nS1},{10,76},{20,76*FightSkill.tbParam.nS20},{21,76*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,6*18},{20,6*18}}},
		seriesdamage_r={{{1,100},{20,1500},{21,1550}}},
		state_hurt_attack={{{1,15},{20,30}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,30}},{{1,36},{20,54},{21,54}}},
	},
	-- Chua sua
	minhgiaokiem150={ --圣火燎原
		appenddamage_p= {{{1,70},{2,73}}},
		poisondamage_v={{{1,100*FightSkill.tbParam.nS1},{10,250},{20,450},{21,470}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}}, -- Ngũ Hành Tương Khắc
		skill_cost_v={{{1,150},{20,300},{21,315}}},
		state_weak_attack={{{1,32},{2,34}},{{1,72},{2,72}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,18*2},{2,18*2}}},
		state_weak_attacktime={{{1,100},{2,110}}},
		--skill_mintimepercast_v={{{1,3.5*18},{2,3.5*18}}}, -- Gian cach
		missile_range={4,0,4},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngamychuong150={ --????
		appenddamage_p= {{{1,73},{2,76}}},
		colddamage_v={
			[1]={{1,3536*0.9*FightSkill.tbParam.nS1},{10,3536*0.9},{20,3536*0.9*FightSkill.tbParam.nS20},{21,3536*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,3536*1.1*FightSkill.tbParam.nS1},{10,3536*1.1},{20,3536*1.1*FightSkill.tbParam.nS20},{21,3536*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,32},{2,34}},{{1,18},{20,3*18}}},
		state_slowall_attacktime={{{1,110},{2,120}}},
		skill_startevent={{{1,1963},{20,1963}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,5},{10,6},{20,7},{21,7}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngamychuongctcon={ --????,???????
		appenddamage_p= {{{1,6*FightSkill.tbParam.nS1},{10,6},{20,6*FightSkill.tbParam.nS20},{21,6*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,200*0.9*FightSkill.tbParam.nS1},{10,200*0.9},{20,200*0.9*FightSkill.tbParam.nS20},{21,200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,200*1.1*FightSkill.tbParam.nS1},{10,200*1.1},{20,200*1.1*FightSkill.tbParam.nS20},{21,200*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,5},{10,10},{20,15}},{{1,27},{20,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,36},{20,36}}},
		missile_hitcount={{{1,6},{20,6}}},
		missile_range={1,0,1},
	},
	thieulambong_150={
		appenddamage_p= {{{1,73},{10,100},{20,130},{21,133}}},
		physicsenhance_p={{{1,178*FightSkill.tbParam.nS1},{10,178},{20,178*FightSkill.tbParam.nS20},{21,178*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, -- Vật công %
		physicsdamage_v={
			[1]={{1,430},{10,700},{20,1030},{21,1060}},
			[3]={{1,430*1.1*FightSkill.tbParam.nSadd},{10,844},{20,1145*1.1*FightSkill.tbParam.nSadd},{21,1145*1.1*FightSkill.tbParam.nSadd1}},
			},
		state_hurt_attack={{{1,41},{10,51},{20,61}},{{1,2*18},{20,4*18}}},
		state_hurt_attacktime={{{1,110},{10,200},{20,300},{21,310}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)

function tb:SeachPlayer(nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
	if (pPlayer) then
		local nCanSendOut = Item:IsCallOutAtMap(pPlayer.nMapId, unpack(self.TEMPLET_ITEM_ID));
		local nCanSendIn  = Item:IsCallInAtMap(nMapId, unpack(self.TEMPLET_ITEM_ID));
		if (nCanSendOut ~= 1) then
			pPlayer.Msg("Không được đến khu vực hiện tại!");
			return;
		end
		if (nCanSendIn ~= 1) then
			pPlayer.Msg("Không thể đến được mục tiêu!");
			return;
		end	
		
		GCExcute({"Item.tbZhaoHuanLingPai:Msg2Player4Confirm_GC", nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState});		
	end
end


function tb:Msg2Player4Confirm_GC(nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState)
	GlobalExcute({"Item.tbZhaoHuanLingPai:Msg2Player4Confirm_GS", nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState});
end

function tb:Msg2Player4Confirm_GS(nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
	if (not pPlayer) then
		return;
	end
	pPlayer.GetTempTable("Item").nZhaoHuanPlayerId = nMemberPlayerId;
	pPlayer.GetTempTable("Item").tbZhaoHuanLingPai = {nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState};
	Setting:SetGlobalObj(pPlayer);
	Player:RegisterTimer(Env.GAME_FPS * 70, self.InvalidRequest, self, nMemberPlayerId);
	
	Setting:RestoreGlobalObj();
	pPlayer.CallClientScript({"Item.tbZhaoHuanLingPai:Msg2Player4Confirm_C", nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState});
end

function tb:Msg2Player4Confirm_C(nKind, nMapId, nPosX, nPosY, nMemberPlayerId, szName, nFightState)
	CoreEventNotify(
		UiNotify.emCOREEVENT_CONFIRMATION,
		UiNotify.CONFIRMATION_KIN_CONVECTION,
		szName,
		nKind,
		nMapId,
		nPosX,
		nPosY,
		nMemberPlayerId,
		nFightState
	);
end

function tb:PlayerAccredit(nMapId, nPosX, nPosY, nMemberPlayerId, nFightState, bAccept)
	if (bAccept ~= 2) then
		return 0;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
	if (not pPlayer) then
		return;
	end
	if pPlayer.GetTempTable("Item").nZhaoHuanPlayerId ~= nMemberPlayerId then
		pPlayer.Msg("Thao tác quá giờ rồi.");
		return 0;
	end
	
	local nTempKind = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[1];
	local nTempMapId = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[2];
	local nTempPosX = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[3];
	local nTempPosY = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[4];
	local nTempMemberPlayerId = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[5];
	local szTempName = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[6];
	local nTempFightState = pPlayer.GetTempTable("Item").tbZhaoHuanLingPai[7];	
	

	
	local nCanSendOut = Item:IsCallOutAtMap(pPlayer.nMapId, unpack(self.TEMPLET_ITEM_ID));
	local nCanSendIn  = Item:IsCallInAtMap(nTempMapId, unpack(self.TEMPLET_ITEM_ID));
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("Không được đến khu vực hiện tại!");
		return;
	end
	if (nCanSendIn ~= 1) then
		pPlayer.Msg("Không thể đến được mục tiêu!");
		return;
	end	
	local tbEvent	= {						-- 会中断延时的事件
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	};
	if (0 == pPlayer.nFightState) then				-- 玩家在非战斗状态下传送无延时正常传送
		self:SendAllMemberSuccess(nTempMapId, nTempPosX, nTempPosY, nTempMemberPlayerId, nTempFightState)
		return 0;
	end
	GeneralProcess:StartProcess("Đang gửi yêu cầu triệu hồi...", self.nTime * Env.GAME_FPS, {self.SendAllMemberSuccess, self, nTempMapId, nTempPosX, nTempPosY, nTempMemberPlayerId, nTempFightState}, nil, tbEvent);	-- 在战斗状态下需要nTime秒的延时
end

function tb:SendAllMemberSuccess(nMapId, nPosX, nPosY, nMemberPlayerId, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
	if (not pPlayer) then
		return 0;
	end
	local nCanSendOut = Item:IsCallOutAtMap(pPlayer.nMapId, unpack(self.TEMPLET_ITEM_ID));
	local nCanSendIn  = Item:IsCallInAtMap(nMapId, unpack(self.TEMPLET_ITEM_ID));
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("Không được đến khu vực hiện tại!");
		return;
	end
	if (nCanSendIn ~= 1) then
		pPlayer.Msg("Không thể đến được mục tiêu!");
		return;
	end
	local nRet, szMsg = Map:CheckTagServerPlayerCount(nMapId)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	pPlayer.SetFightState(nFightState);
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end

function tb:InvalidRequest(nMemberPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nMemberPlayerId);
	if (not pPlayer) then
		return 0;
	end
	pPlayer.GetTempTable("Item").nZhaoHuanPlayerId = nil;
	pPlayer.GetTempTable("Item").tbZhaoHuanLingPai = nil;
	return 0;
end

