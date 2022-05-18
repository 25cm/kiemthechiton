
-- 

local XoyoNpc_Death = Npc:GetClass("xoyonpc_death")

function XoyoNpc_Death:OnDeath(pKiller)
	XoyoGame:NpcUnLock(him);
	XoyoGame.XoyoChallenge:KillNpcForCard(pKiller.GetPlayer(), him);
end

--?pl DoScript("\\script\\mission\\xoyogame\\npc\\xoyonpc_death.lua")

