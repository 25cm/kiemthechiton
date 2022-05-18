
local tbPrisonMap	= Map:GetClass(253);

local tbExit		= tbPrisonMap:GetTrapClass("leave_prison");
local tbInsideRoom	= tbPrisonMap:GetTrapClass("inside_room");

function tbExit:OnPlayer()
	local nTreasureId			= TreasureMap:GetMyInstancingTreasureId(me);
		if not nTreasureId or nTreasureId <= 0 then
			me.Msg("Đọc thời gian đăng nhập thất bại, xin kiểm tra lại từ đầu!");
			return;
		end;
	local tbInfo				= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId, nMapX, nMapY	= tbInfo.MapId, tbInfo.MapX, tbInfo.MapY;
	
	me.NewWorld(nMapId, nMapX, nMapY);
end;

function tbInsideRoom:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	
	if (not tbInstancing.nBoss) or (tbInstancing.nBoss~=1) then
		me.NewWorld(nMapId, 1606, 3222);
		return;
	end;
	
end;
