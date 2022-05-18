local tbNpc1 = Npc:GetClass("junyingchuansong");
function tbNpc1:OnDialog()
	local szMainMsg = "Ta có thể đưa ngươi đến Phục Ngưu Sơn Quân Doanh";
	local tbOpt = {
		{"<color=yellow>[Thanh Long]<color>", self.ChoseCamp, self, me.nId, 556,1631,3142},
		{"[Chu Tước]", self.ChoseCamp, self, me.nId, 558,1631,3142},
		{"[Huyền Vũ]", self.ChoseCamp, self, me.nId, 559,1631,3142},
	}
	Lib:SmashTable(tbOpt);
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	
	Dialog:Say(szMainMsg, tbOpt);
end


function tbNpc1:ChoseCamp(nPlayerId, nMapId, nPosX, nPosY)
	local pPlayer  = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	if (pPlayer.nLevel < 60) then
		Task.tbArmyCampInstancingManager:Warring(pPlayer, "Cấp <60, không thể vào Quân doanh.");
		return;
	end
	
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
	pPlayer.SetFightState(0);
end


local tbNpc2 = Npc:GetClass("instcingoutsender");
function tbNpc2:OnDialog()
	local pPlayer = me;
	local nMapId = pPlayer.GetTask(2043, 2);
	if (nMapId ~= 556 and nMapId ~= 558 and nMapId ~= 559) then
		return;
	end
	
	local szMainMsg = "Ta có thể đưa ngươi đến Phục Ngưu Sơn Quân Doanh";
	local tbOpt = {
		{"<color=yellow>Trở lại Quân doanh<color>", self.EnterRegisterCamp, self, me.nId, nMapId, 1631, 3142},		
		{"Kết thúc đối thoại"}
	}
	
	Dialog:Say(szMainMsg, tbOpt);
end


function tbNpc2:EnterRegisterCamp(nPlayerId, nMapId, nPosX, nPosY)
	local pPlayer  = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
	pPlayer.SetFightState(0);
end

local tbRegister = Npc:GetClass("fbchuansong");

function tbRegister:OnDialog()
	local szMainMsg = "Tôi có thể đưa bạn đến chỗ Phó bản, mời chọn Phó bản muốn đến";
	local tbOpt = {};
		
	local tbInstancingMgr = Task.tbArmyCampInstancingManager;
	for i = 1, #tbInstancingMgr.tbSettings do
		local tbInstacing = tbInstancingMgr:GetInstancingSetting(i);
		tbOpt[#tbOpt + 1] = {tbInstacing.szName, self.ChoseInstcing, self, i, me.nId};
	end

	
	tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
	Dialog:Say(szMainMsg, tbOpt);
end


function tbRegister:ChoseInstcing(nInstancingTemplateId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local tbInstancingMgr = Task.tbArmyCampInstancingManager;
	
	local tbInstancingSetting = tbInstancingMgr:GetInstancingSetting(nInstancingTemplateId);
	
	local tbOpt = 
	{
		{"<color=yellow>Ta muốn báo danh<color>", tbInstancingMgr.AskRegisterInstancing, tbInstancingMgr, nInstancingTemplateId, pPlayer.nId},
		{"Vào Phó bản", tbInstancingMgr.AskEnterInstancing, tbInstancingMgr, nInstancingTemplateId, pPlayer.nId},
		{"Kết thúc đối thoại"}
	}
	
	Dialog:Say(tbInstancingSetting.szEnterMsg, tbOpt);
end
