--Pháo Hoa Tết 2013
--08-01-2013
--Hồ Duy Quốc Bảo

local tbItem = Item:GetClass("xinnianyanhua");

tbItem.nSkillBuffId 	= 1331;	--skill phao hoa
tbItem.nLastTime 		= 3 * 60 * Env.GAME_FPS	--thoi gian cho phep dot lan 2
tbItem.nDelay = 0.5 * Env.GAME_FPS;	--thoi gian chay cay %

function tbItem:OnUse()
	--if nCurTime < 2000 or nCurTime >= 2400 then
	--	Dialog:Say("Thời gian hoạt động đốt pháo hoa năm mới bắt đầu từ 20h00 đến 22h00.");
	--	return 0;
	--end
	
	if me.nFightState ~= 0 then
		me.Msg("Chỉ sử dụng trong thôn trấn hoặc thành thị");
		return 0;
	end	
	if me.CountFreeBagCell() < 4 then
		me.Msg( "Hành trang của bạn không đủ 4 ô trống.")
		return 0;
	end	
	local tbEvent = 
{
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
}
	GeneralProcess:StartProcess("<color=yellow>Đang Châm Ngòi<color>", self.nDelay, {self.OnUseSure, self, it.dwId}, nil, tbEvent);

end

function tbItem:OnUseSure(nItemId)
	
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0
	end
	
	if me.nFightState == 1 then
		Dialog:Say("Không đốt pháo trong trạng thái phi chiến đấu");
		return 0;
	end
	--if me.GetSkillState(self.nSkillBuffId) > 0 then
	--	Dialog:Say("ngươi đang châm ngòi 1 pháo hoa, đợi 3 phút sau hãy tiếp tục.");		
	--	return 0;
	--end
	
	if me.DelItem(pItem) == 1 then
		me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
		me.CastSkill(391, 1, -1, me.GetNpc().nIndex);
		me.CastSkill(1523, 1, -1, me.GetNpc().nIndex);
		me.CastSkill(1957, 1, -1, me.GetNpc().nIndex);
		
me.AddExp(20000000)

		--me.Msg("Đốt pháo hoa thành công, đến gần lễ quan mới có hiệu lực.");
	end
	me.CastSkill(self.nSkillBuffId, 1, -1, me.GetNpc().nIndex);
end
