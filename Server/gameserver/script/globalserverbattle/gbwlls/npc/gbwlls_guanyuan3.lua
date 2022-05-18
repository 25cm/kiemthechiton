-- 高级跨服联赛官

local tbNpc = Npc:GetClass("gbwlls_guanyuan3");

function tbNpc:OnDialog()
	local nGameLevel = 2;
	GbWlls.DialogNpc:OnDialog(nGameLevel)	
end
