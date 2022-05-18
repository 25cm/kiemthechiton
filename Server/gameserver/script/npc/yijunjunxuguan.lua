-------------------------------------------------------------------
--File: 	yijunjunxuguan.lua
--Author: 	sunduoliang
--Date: 	2008-3-14
--Describe:	义军军需官
-------------------------------------------------------------------



local tbjunxuguan = Npc:GetClass("yijunjunxuguan");

tbjunxuguan.tbShopID =
{
	[1] = 37, -- 少林
	[2] = 38, --天王掌门
	[3] = 39, --唐门掌门
	[4] = 41, --五毒掌门
	[5] = 43, --峨嵋掌门
	[6] = 44, --翠烟掌门
	[7] = 46, --丐帮掌门
	[8] = 45, --天忍掌门
	[9] = 47, --武当掌门
	[10] = 48, --昆仑掌门
	[11] = 40, --明教掌门
	[12] = 42, --大理段氏掌门
}

function tbjunxuguan:OnDialog()
	local tbOpt = 
	{
		{"Shop <color=yellow>Nghĩa Quân<color>", self.OpenShop, self},
		{"Vào <color=green>Bí cảnh<color>", Task.FourfoldMap.OnDialog, Task.FourfoldMap},
		{"Kiểm tra bí cảnh", Task.FourfoldMap.OnAbout, Task.FourfoldMap},
		{"Kết thúc đối thoại"},
	}
	if IVER_g_nSdoVersion == 0 then
		--table.insert(tbOpt, 4, {"Thông Tin"});
	end
	Dialog:Say("Khi các hạ hoàn thành các nhiệm vụ được giao có thể mua đạo cụ",tbOpt);
end

function tbjunxuguan:OpenShop()
		local nFaction = me.nFaction;
		if nFaction <= 0 or me.GetCamp() == 0 then
			Dialog:Say("Chưa gia nhập môn phái không thể mua.");
			return 0;
		end
		me.OpenShop(self.tbShopID[nFaction], 1, 100, me.nSeries) --使用声望购买
end
