-- 衙役

local tbNpc = Npc:GetClass("yayi");

tbNpc.nLinanYayiId		= 29;		-- 临安府衙役的地图ID
tbNpc.nBianjingYayiId 	= 23;		-- 汴京府衙役的地图ID
tbNpc.nYayiX_Linan		= 1688;		-- 临安府衙役的X坐标
tbNpc.nYayiY_Linan		= 3771;		-- 临安府衙役的Y坐标
tbNpc.nYayiX_Bianjing	= 1639;		-- 汴京府衙役的X坐标
tbNpc.nYayiY_Bianjing	= 3094;		-- 汴京府衙役的Y坐标

tbNpc.nLinanDalaoId		= 223;		-- 临安府大牢的地图ID
tbNpc.nBianjingDalaoId	= 222;		-- 汴京府大牢的地图ID
tbNpc.nDalaoX			= 1651;		-- 大牢的X坐标
tbNpc.nDalaoY			= 3260;		-- 大牢的Y坐标

function tbNpc:OnDialog()
		Dialog:Say("NPC chưa mở");
end