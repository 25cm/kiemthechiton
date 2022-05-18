
local YanHua = Item:GetClass("qingzhuyanhua");

YanHua.ADD_EXP_RATIO		= 1;
YanHua.SKILL_ID				= 307;
YanHua.ADD_EXP_RATIO		= 15	-- 15分钟基准经验


function YanHua:OnUse()
	local nKinId, nMemberId = me.GetKinMember()
	local pKin = KKin.GetKin(nKinId);
	if not pKin then
		me.Msg("Bạn không có gia tộc, không thể sử dụng vật phẩm!")
		return 0;
	end
	local pMeNpc 		= me.GetNpc()
	local tbNpc 		= KNpc.GetAroundNpcList(me, 90);
	local nTemplateId 	= Npc:GetClass("jiazulingpainpc").NPC_MODE_ID;
	local nDouble		= 1;
	if tbNpc then
		for i in pairs(tbNpc) do
			if tbNpc[i].nTemplateId == nTemplateId then
				local tbTemp = tbNpc[i].GetTempTable("Kin");
				if tbTemp and tbTemp.nKinId  == nKinId then
					nDouble = 2;
				end
			end
		end
	end
	local nBaseExp = me.GetBaseAwardExp() * self.ADD_EXP_RATIO * nDouble;
	me.AddExp(nBaseExp);
	me.CastSkill(self.SKILL_ID, 10, -1, pMeNpc.nIndex);
	if nDouble == 2 then
		me.Msg(string.format("Sử dụng Pháo hoa chào mừng hoạt động Thịnh Hạ gia tộc, nhận được %d kinh nghiệm (2 lần)", nBaseExp));
	else
		me.Msg(string.format("Bạn sử dụng Pháo hoa chào mừng hoạt động Thịnh Hạ, nhận được %d kinh nghiệm (1 lần)", nBaseExp))
	end
	
	return 1;
end
