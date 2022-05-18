-------------------------------------------------------
-- 文件名　：jingjimilintrap.lua
-- 文件描述：荆棘密林TRAP点
-- 创建者　：ZhangDeheng
-- 创建时间：2009-03-16 09:32:51
-------------------------------------------------------


local tbMap	= Map:GetClass(493);
local tbTrap_1 = tbMap:GetTrapClass("trapjingji");

tbTrap_1.szText = "Không cẩn thận bụi gai có thể làm xước da! Ta cảm thấy ngày càng mệt mỏi......";

function tbTrap_1:OnPlayer()
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(me.nMapId);
	if (not tbInstancing) then
		return;
	end;
	
	TaskAct:Talk(self.szText, self.Return, self, me.nId);
end

function tbTrap_1:Return(nId)
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if (not pPlayer) then
		return;
	end;
	
	pPlayer.NewWorld(pPlayer.nMapId, 1586, 3157);
	pPlayer.SetFightState(0);
	return 0;
end;

local tbMap	= Map:GetClass(493);
local tbTrap_2 = tbMap:GetTrapClass("to_ceng1");

tbTrap_2.szDesc		= "to_ceng1";

tbTrap_2.tbSendPos	= {{1720, 3289}, {1841, 3211}};

function tbTrap_2:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nTrap2Pass == 0) then
		me.NewWorld(me.nMapId, self.tbSendPos[1][1],self.tbSendPos[1][2]);
	else
		me.NewWorld(me.nMapId, self.tbSendPos[2	][1],self.tbSendPos[2][2]);
		tbInstancing:OnCoverBegin(me);
		Task.tbArmyCampInstancingManager:ShowTip(me, "Theo chỉ dẫn của Thần Long, phải xác định vị trí của 4 Nguyệt Ảnh Thạch, theo thứ tự <color=red>Phong Lâm Hỏa Sơn<color> để mở ra");
		me.Msg("Theo chỉ dẫn của Thần Long, tìm được 4 cột trụ, theo thứ tự Phong Lâm Hỏa Sơn để mở ra");
	end;	
end;
