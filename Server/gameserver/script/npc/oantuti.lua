local tbOantuti = Npc:GetClass("oantuti");
tbOantuti.tbItemInfo = {
        bForceBind=1,
};  
function tbOantuti:OnDialog()
DoScript("\\script\\npc\\oantuti.lua");

local szMsg = "<color=yellow>Sự Kiện<color> Oẳn Tù Tì\n"..
"<color=yellow>Bắt đầu<color> 17h00 - 24h00 Hàng Ngày\n"..
"<color=yellow>Dành Cho Người Chơi Cấp<color> Từ 130 - 140"
local nCurTime = tonumber(os.date("%H%M", GetTime()));
if (nCurTime >= 1700 and nCurTime <= 2400) then
self:OnDialog_1()
return
end
Dialog:Say(szMsg)
end
function tbOantuti:OnDialog_1()
if me.nLevel >= 130 and me.nLevel <= 140 then
local szMsg = "<color=yellow>Sự Kiện<color> Oẳn Tù Tì\n"..
"<color=yellow>Bắt đầu<color> 17h00 - 24h00 Hàng Ngày\n"..
"<color=yellow>Dành Cho Người Chơi Cấp<color> Từ 130 - 140"
local tbOpt = {
{"Sự Kiện <color=yellow>Oẳn Tù Tì<color>", self.EventOanTuTi, self},
		};
Dialog:Say(szMsg,tbOpt);
return
end
Dialog:Say("Đẳng Cấp của ngươi là "..me.nLevel.."")
end
function tbOantuti:EventOanTuTi()
local szMsg = "Mời <color=yellow>"..me.szName.."<color> chọn"
local tbOpt = {
{"<color=green>Kéo", self.Chon_Keo, self},
{"<color=green>Đấm", self.Chon_Dam, self},
{"<color=green>Lá", self.Chon_La, self},
};
Dialog:Say(szMsg,tbOpt);
end
function tbOantuti:Chon_La()
local nMapId, nPosX, nPosY = me.GetWorldPos();
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 9);
	

	local tbRate = {3,3,3};
	local tbAward = {1,2,3};
	-- Nguoi choi dang chon La
	-- 1 la Keo
    -- 2 la Dam
	-- 3 la La
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- NPC Chon Keo - Member Chon La
me.Msg("Thua")
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon La
me.Msg("Thắng")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Oẳn Tù Tì với <color=green>Tăng Lão Đại<color> giành chiến thắng nhận <color=green>5tr Kinh Nghiệm<color><color>");	   
me.AddExp(5000000)
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon La
me.Msg("Hòa")
end
end
function tbOantuti:Chon_Dam()
local nMapId, nPosX, nPosY = me.GetWorldPos();
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 9);
	

	local tbRate = {3,3,3};
	local tbAward = {1,2,3};
	-- Nguoi choi dang chon Dam
	-- 1 la Keo
    -- 2 la Dam
	-- 3 la La
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- NPC Chon Keo - Member Chon Dam
me.Msg("Thắng")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Oẳn Tù Tì với <color=green>Tăng Lão Đại<color> giành chiến thắng nhận <color=green>5tr Kinh Nghiệm<color><color>");	   
me.AddExp(5000000)
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon Dam
me.Msg("Hòa")
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon Dam
me.Msg("Thua")
end
end
function tbOantuti:Chon_Keo()
local nMapId, nPosX, nPosY = me.GetWorldPos();
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 9);
	

	local tbRate = {3,3,3};
	local tbAward = {1,2,3};
	-- Nguoi choi dang chon Keo
	-- 1 la Keo
    -- 2 la Dam
	-- 3 la La
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- NPC Chon Keo - Member Chon Keo
me.Msg("Hòa")
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon Keo
me.Msg("Thua")
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon Keo
me.Msg("Thắng")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Oẳn Tù Tì với <color=green>Tăng Lão Đại<color> giành chiến thắng nhận <color=green>5tr Kinh Nghiệm<color><color>");	   
me.AddExp(5000000)
end
end
