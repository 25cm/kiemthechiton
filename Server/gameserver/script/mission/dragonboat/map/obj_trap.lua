local tbMap 	= Map:GetClass(1535);
local tbTrap 	= tbMap:GetTrapClass("trap_obj");

function tbTrap:OnPlayer()
	local tbMis = Esport.DragonBoat:GetPlayerMission(me);
	if tbMis and tbMis:IsOpen() == 1 then
		local nTime = GetTime();
		if tbMis:GetObjTime() + 5 <= nTime then
			tbMis:SetObjTime(nTime);
			local m,x,y=me.GetWorldPos();
			me.CastSkill(1384, 11, x*32, y*32);	--ѣ��3��
			Dialog:SendBlackBoardMsg(me, "߹���������ײ���˰��ߵĽ�ʯ��");
			me.Msg("<color=blue>����ײ���˰��ߵĽ�ʯ��<color>");
		end
	end
end
