-- 文件名　：vippartner.lua
-- 创建者　：zounan
-- 创建时间：2010-01-13 10:23:55
-- 描  述  ：

local tbItem = Item:GetClass("gamefriend2");
tbItem.nPotenId = 241;
tbItem.nNpcTempId   = 6803;

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Tính năng đồng hành chưa mở, không thể sử dụng.");
		return 0;
	end
	
	--先检测100级 再查看是否开服150
	if me.nLevel < 100 then
		me.Msg("Cấp của bạn không đủ 100 hãy đạt đủ cấp rồi thử lại.");
		return;
	end		
	
	if TimeFrame:GetStateGS("OpenLevel150") ~= 1 then
		me.Msg("Chưa mở cấp 150");
		return;
	end
	
	if me.nFaction == 0 then
		me.Msg("Bạn chưa gia nhập môn phái không thể có đồng hành.");
		return;
	end	
	
	if me.nPartnerCount >= me.nPartnerLimit then
		me.Msg("Số lượng đồng hành đã đủ.");	    	
		return 0;
	end		
	
	local szInfo = "Lựa chọn loại đồng hành bạn muốn:";
	local	tbOpt = {
			{"Thân pháp 50%，Ngoại công 50%", 		 self.SelectSeries, self, self.nNpcTempId, it.dwId, 1},
			{"Ngoại công 50%，Nội công 50%",			 self.SelectSeries, self, self.nNpcTempId, it.dwId, 2},
			{"Sức mạnh 30%，Thân pháp 30%，Ngoại công 40%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 3},
			{"Sức mạnh 30%，Thân pháp 20%，Ngoại công 50%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 4},
			{"Sức mạnh 40%，Thân pháp 20%，Ngoại công 40%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 5},
			{"Sức mạnh 40%，Thân pháp 30%，Ngoại công 30%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 6},
			{"Sức mạnh 40%，Thân pháp 10%，Ngoại công 50%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 7},
			{"Sức mạnh 40%，Thân pháp 10%，Ngoại công 10%，Nội công 40%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 8},
			{"Sức mạnh 50%，Thân pháp 20%，Ngoại công 30%", self.SelectSeries, self, self.nNpcTempId, it.dwId, 9},
			{"Kết thúc"},
		};
	Dialog:Say(szInfo,tbOpt);	
	return 0;
end
local tb = {
	conlonkiem150={ --????_20
		appenddamage_p= {{{1,45},{20,45},{21,45*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,1400},{2,1550}},
			[3]={{1,1600},{2,1800}}
		},
		state_stun_attack={{{1,15},{10,30},{20,40},{21,41}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}}, -- Ngu Hành Tuong Kh?c
		steallifeenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		skill_cost_v={{{1,50},{20,150},{21,150}}},
		missile_hitcount={{{1,5},{10,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	conlonkiem150_child={ --?????
		appenddamage_p= {{{1,90},{20,90},{21,90*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,800*0.8},{10,1115*0.9},{20,1465*0.9},{21,1465*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,800*1.2},{10,1115*1.1},{20,1465*1.1},{21,1465*FightSkill.tbParam.nSadd*1.1}}
		},
		state_stun_attack={{{1,15},{10,30},{20,40}},{{1,18},{20,18}}},
		missile_hitcount={{{1,2},{10,2}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_range={4,0,4},
	},
	vokhi150={ --????
		appenddamage_p= {{{1,22},{2,24}}},
		lightingdamage_v={
			[1]={{1,1174*0.9*FightSkill.tbParam.nS1},{10,1174*0.9},{20,1200*0.9*FightSkill.tbParam.nS20},{21,1200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1174*1.1*FightSkill.tbParam.nS1},{10,1174*1.1},{20,1200*1.1*FightSkill.tbParam.nS20},{21,1200*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_stun_attack={{{1,31},{2,32}},{{1,2*18},{20,2*18}}},
		state_stun_attacktime={{{1,110},{2,120}}},
		steallifeenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		stealmanaenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	vokiem150={ --????
		appenddamage_p= {{{1,51*FightSkill.tbParam.nS1},{10,52},{20,53*FightSkill.tbParam.nS20},{21,53*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,85*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,440*0.9*FightSkill.tbParam.nS1},{10,440*0.9},{20,440*0.9*FightSkill.tbParam.nS20},{21,440*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,440*1.1*FightSkill.tbParam.nS1},{10,440*1.1},{20,440*1.1*FightSkill.tbParam.nS20},{21,440*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,11},{2,12}},{{1,2*18},{20,2*18}}},
		steallifeenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		stealmanaenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		state_stun_attack={{{1,21},{2,22}},{{1,2*18},{20,2*18}}},
		state_stun_attacktime={{{1,110},{2,120}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)

function tbItem:SelectSeries(nNpcTempId, nItemId, nPotenTemplId)
	local szInfo = "Lựa chọn các giá trị: \n  Bạn có thể lựa chọn bạn đồng hành theo <color=yellow>Ngũ hành<color>";
	local	tbOpt = {
			{"Kim", self.Select, self, nNpcTempId, nItemId, 1, nPotenTemplId},
			{"Mộc", self.Select, self, nNpcTempId, nItemId, 2, nPotenTemplId},
			{"Thủy", self.Select, self, nNpcTempId, nItemId, 3, nPotenTemplId},
			{"Hỏa", self.Select, self, nNpcTempId, nItemId, 4, nPotenTemplId},
			{"Thổ", self.Select, self, nNpcTempId, nItemId, 5, nPotenTemplId},			
			{"Kết thúc"},
		};
	Dialog:Say(szInfo,tbOpt);
	return 0;
end

function tbItem:Select(nNpcTempId, nItemId, nSeries, nPotenTemplId)	
	local pItem =  KItem.GetObjById(nItemId);
	if pItem then
		local nRes = Partner:AddPartner(me.nId, nNpcTempId, nSeries, nPotenTemplId);
		if nRes ~= 0 then			
			pItem.Delete(me);
			EventManager:WriteLog(string.format("[Sử dụng đạo cụ đồng hành] truy cập ID là：%s bạn đồng hành", nPotenTemplId), me);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[Sử dụng đạo cụ đồng hành] truy cập ID là：%s bạn đồng hành", nPotenTemplId ));
		end
	end
end
