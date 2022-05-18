-------------------------------------------------------
-- 文件名　：wldh_songjin.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-10-15 09:49:03
-- 文件描述：
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbNpc = Npc:GetClass("wldh_songjin");

function tbNpc:OnDialog()
	Dialog:Say("NPC ch?a m?");
end
