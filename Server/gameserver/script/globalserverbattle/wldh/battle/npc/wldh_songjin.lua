-------------------------------------------------------
-- �ļ�������wldh_songjin.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-10-15 09:49:03
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbNpc = Npc:GetClass("wldh_songjin");

function tbNpc:OnDialog()
	Dialog:Say("NPC ch?a m?");
end
