-------------------------------------------------------------------
--File: tuiguangyuan.lua
--Author: kenmaster
--Date: 2008-06-04 03:00
--Describe: 活动推广员npc脚本
-------------------------------------------------------------------
local tbTuiGuangYuan = Npc:GetClass("tuiguangyuan");

--初始对话（对话1）
-- Npc.IVER_nTuiGuanYuan 数值为1，表示只有大陆版才开启这个功能
function tbTuiGuangYuan:OnDialog()
	Dialog:Say("NPC chưa mở");
end