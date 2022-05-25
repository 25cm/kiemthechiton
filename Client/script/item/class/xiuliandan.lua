
local tbItem = Item:GetClass("xiuliandan");
tbItem.TaskGourp = 2024;
tbItem.TaskId_Day = 18;
tbItem.TaskId_Count = 19;
tbItem.Use_Max = EventManager.IVER_nXiulindanMaxUse;
 
function tbItem:OnUse()
	local nDate = tonumber(GetLocalDate("%y%m%d"));
	if me.GetTask(self.TaskGourp, self.TaskId_Day) < nDate then
		me.SetTask(self.TaskGourp, self.TaskId_Day, nDate);
		me.SetTask(self.TaskGourp, self.TaskId_Count, 0);
	end 
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count)
	if nCount >= 1000 then
		Dialog:Say(string.format("Mỗi ngày chỉ được dùng 1000 Tu Luyện Đơn."));
		return 0;
	end
	
	local tbXiuLianZhu = Item:GetClass("xiulianzhu");
	if tbXiuLianZhu:GetReTime() > 12 then
		Dialog:Say("Thời gian tu luyện của bạn còn hơn 12 giờ, không thể sử dụng Tu Luyện Đơn.")
		return 0;
	end
	tbXiuLianZhu:AddRemainTime(120);	
	me.Msg(string.format("Thời gian tu luyện của bạn đã tăng <color=green>2 giờ<color>, hôm nay bạn đã dùng <color=yellow>%s <color> Tu Luyện Đơn.",nCount + 1));
	me.SetTask(self.TaskGourp, self.TaskId_Count, nCount + 1);
	return 1;
end
local tb = {
	ngudocchuong150_child={ --天罡毒手，阴风蚀骨第二式
		appenddamage_p= {{{1,37*FightSkill.tbParam.nS1},{10,40},{20,41*FightSkill.tbParam.nS20},{21,41*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,200*FightSkill.tbParam.nS1},{10,200},{20,200*FightSkill.tbParam.nS20},{21,315*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,50},{20,1000},{21,1050}}},
		state_weak_attack={{{1,12},{2,13.5}},{{1,36},{10,2*36},{20,2*36},{21,2*36}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={11,0,11},
	},
	duongmonbay150={ --小李飞刀_20
		appenddamage_p= {{{1,52},{2,54}}},
		skill_cost_v={{{1,5},{20,20},{21,20}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{23,54}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		poisondamage_v={{{1,43},{2,46}},{{1,6*18},{20,2*18}}},
		--state_drag_attack={{{1,50},{20,95},{21,95}},{{1,25},{10,25},{11,25}},{{1,16},{2,16}}},
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		skill_attackradius={520},
		missile_range={1,0,1},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	duongmonbay150_child={ --幻影追魂枪_10
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		fastwalkrun_p={{{1,-10},{10,-30},{11,-31}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
	},
	ngamykiem150={ --剑影佛光_10
		appenddamage_p= {{{1,140*0.7},{10,140},{11,140*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,740},{2,780}},
			[3]={{1,1040*0.7*1.1},{10,1040*1.1},{11,1040*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,32},{2,34}},{{1,2*18},{10,3*18},{11,3*18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,18*2},{2,18*2}}},
		missile_hitcount={{{1,7},{10,7},{11,7}}},
		skill_cost_v={{{1,100},{10,200},{11,200}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngamykiem150_child={ --剑影佛光_10
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		state_slowall_attack={{{1,35},{10,65},{11,66}},{{1,45},{10,45},{11,45}}},
		lifemax_p={{{1,30},{20,100},{21,105}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,2*18},{20,5*18}}}
	},
	doanthikiem150={ --飞龙在天
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
		appenddamage_p= {{{1,30},{2,33}}},
		colddamage_v={
			[1]={{1,925*0.9*FightSkill.tbParam.nS1},{10,925*0.9},{20,925*0.9*FightSkill.tbParam.nS20},{21,925*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,925*1.1*FightSkill.tbParam.nS1},{10,925*1.1},{20,925*1.1*FightSkill.tbParam.nS20},{21,925*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}}, -- Ngũ Hành Tương Khắc
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,1},{2,2},{3,3}},{{1,2*18},{20,2*18},{21,2*18}}},
		state_slowall_attack={{{1,11},{2,12}},{{1,2*18},{10,3*18},{11,3*18}}},
		state_stun_attack={{{1,1},{2,2}},{{1,1*18},{10,2*18},{11,2*18}}},
		state_weak_attack={{{1,1},{2,2}},{{1,18},{20,18},{21,18}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,2*18},{20,2*18},{21,2*18}}},
		skill_missilenum_v={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,1969},{20,1969}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
	},
}
FightSkill:AddMagicData(tb)

function tbItem:GetTip(nState)
	return string.format("Có thể <color=gold>tăng 2 giờ<color> Tu Luyện Châu, mỗi ngày uống tối đa <color=gold>50 lọ<color>. <enter><color=gold>Tổng thời gian tu luyện không quá 14 giờ.<color>");
end
