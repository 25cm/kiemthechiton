local tbSuGiaEvent = Npc:GetClass("sugiaevent");
function tbSuGiaEvent:OnDialog()
	local tbNpc = Npc:GetClass("skGiangsinh");
	tbNpc:OnDialog_1();
end
