-------------------------------------------------------------------
--File: tuiguangyuan.lua
--Author: kenmaster
--Date: 2008-06-04 03:00
--Describe: 活动推广员npc脚本
-------------------------------------------------------------------
local tbTuiGuangYuan = Npc:GetClass("shengxia_tuiguangyuan");

function tbTuiGuangYuan:OnDialog()
Dialog:Say("NPC này chưa mở",tbOpt);
end

