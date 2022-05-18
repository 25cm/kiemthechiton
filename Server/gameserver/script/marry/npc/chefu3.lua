-- 文件名　：chefu2.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-13 11:37:53
-- 功能描述：结婚相关npc（提供对话选项的教育npc）

local tbNpc = Npc:GetClass("chefu3");

function tbNpc:OnDialog()
	local szMsg = "Rượu đã uống đủ, đàn hát đã xong giờ đã đến lúc trở về.";
	local tbOpt = {
		{"Đưa ta quay lại Giang Tân Thôn", self.Transfer, self},		
		{"Ta muốn ở lại thêm chút"}
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:Transfer()
	Marry.tbMissionList[me.nMapId]:KickPlayer(me, 1);
	me.SetLogoutRV(0);
end