local RELATIONTYPE_TRAINING 	= 5		-- 当前师徒关系
local RELATIONTYPE_TRAINED		= 6		-- 出师师徒关系
local RELATIONTYPE_INTRODUCE	= 8		-- 介绍人关系
local RELATIONTYPE_BUDDY		= 9		-- 指定密友关系
local COST_DELTEACHER			= 10000	-- 解除和师父关系的费用
local COST_DELSTUDENT			= 10000	-- 解除和弟子关系的费用

local tbNpc	= Npc:GetClass("renji");

-- 对话
function tbNpc:OnDialog()
Dialog:Say("NPC chưa mở");
end
