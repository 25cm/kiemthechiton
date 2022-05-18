
--	√≈≈…’∆√≈»À;	
local tbMenPaiZhangMenRen = Npc:GetClass("menpaizhangmenren");
local tbNpcTemplate2Faction = 
{
	[3512] = 1, [3506] = 2, [3518] = 3, [3524] = 4, [3530] = 5, [3536] = 6,
	[3542] = 7, [3548] = 8, [3554] = 9, [3560] = 10, [3479] = 11, [3500] = 12,
}

function tbMenPaiZhangMenRen:OnDialog()
	Npc.tbMenPaiNpc:DialogMaster(tbNpcTemplate2Faction[him.nTemplateId])
end
