
--	门派接引人	
local tbMenPaiJieYinRen = Npc:GetClass("menpaijieyinren");
local tbNpcTemplate2Faction = 
{
	[3507] = 1, [3501] = 2, [3513] = 3, [3519] = 4, [3525] = 5, [3531] = 6,
	[3537] = 7, [3543] = 8, [3549] = 9, [3555] = 10, [3474] = 11, [3480] = 12,
}
function tbMenPaiJieYinRen:OnDialog()
	Npc.tbMenPaiNpc:DialogJieYinRen(tbNpcTemplate2Faction[him.nTemplateId])
end
