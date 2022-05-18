local tbItem = Item:GetClass("thk_hopdungca");
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\cauca\\hopdungca.lua");
me.Msg("test")
end