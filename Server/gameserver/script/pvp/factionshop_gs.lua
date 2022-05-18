-------------------------------------------------------------------
--File: 	factionshop_gs.lua
--Author: 	sunduoliang
--Date: 	2008-3-14
--Describe:	门派掌门人处购买门派竞技装备
-------------------------------------------------------------------
local tbFactionShop	= {};	-- 	门派战休息时间活动
FactionBattle.tbFactionShop = tbFactionShop;

tbFactionShop.tbFactionShopID =
{
	[1] = 25, -- 少林
	[2] = 26, --天王掌门
	[3] = 27, --唐门掌门
	[4] = 29, --五毒掌门
	[5] = 31, --峨嵋掌门
	[6] = 32, --翠烟掌门
	[7] = 34, --丐帮掌门
	[8] = 33, --天忍掌门
	[9] = 35, --武当掌门
	[10] = 36, --昆仑掌门
	[11] = 28, --明教掌门
	[12] = 30, --大理段氏掌门
}

function tbFactionShop:OpenShop(nFaction)
	me.OpenShop(self.tbFactionShopID[nFaction], 1) --使用声望购买
end
