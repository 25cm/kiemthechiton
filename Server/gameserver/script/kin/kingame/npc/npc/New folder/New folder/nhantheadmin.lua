local tbnhantheadmin = Npc:GetClass("nhantheadmin");

function tbnhantheadmin:OnDialog()
	local szMsg = "Xin chào, ta có thể giúp được gì?";
	local tbOpt = {
	        {"Đối thoại", self.nhando, self},
			{"Kết thúc đối thoại"},
			};
Dialog:Say(szMsg, tbOpt);
end

function tbnhantheadmin:nhando()
me.AddItem(18,1,1194,9);
end;