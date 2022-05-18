local tbTangLaoDai = Npc:GetClass("tanglaodai"); 
function tbTangLaoDai:OnDialog()
local tbOpt =
	{	
   		{"Chưa đến giờ <color=blue>Kết thúc đối thoại<color>"}
	}
     local nCurTime = tonumber(os.date("%H%M", GetTime()));
     if (nCurTime >= 1615 and nCurTime <= 1625) or (nCurTime >= 2015 and nCurTime <= 2025)then
	table.insert(tbOpt, 1, {"<pic=135> <color=gold>Bắt Đàu Chơi<color>", self.EventOanTuTi, self});
end
	Dialog:Say("<color=yellow>Trò Chơi Oẳn Tù Tì<color> diễn ra lúc: <color=green>(16h15 đến 16h25)<color> và <color=green>(20h15 đến 20h25)<color> hàng ngày",tbOpt);

end

function tbTangLaoDai:EventOanTuTi()
local szMsg = "Mời <color=green>"..me.szName.."<color> chọn, nếu chiến thắng sẽ được <color=yellow>Phần Thưởng:<color>"
local tbOpt = {
{"<pic=36> Chọn <color=red>Kéo", self.Chon_Keo, self},
{"<pic=126> Chọn <color=yellow>Búa", self.Chon_Dam, self},
{"<pic=125> Chọn <color=green>Bao", self.Chon_La, self},
};
Dialog:Say(szMsg,tbOpt);
end
function tbTangLaoDai:Chon_La()
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
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Kéo<color>, bạn đã <color=blue>Thua<color>")
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon La
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Búa<color>, bạn đã <color=blue>Thắng<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>"..me.szName.."<color> Oẳn Tù Tì với <color=red>Bé Thả Diều<color> giành chiến thắng nhận <color=gold>100.000 Kinh Nghiệm<color><color>");	   
me.AddExp(100000)
me.AddBindCoin(2000)
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon La
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Bao<color>, bạn đã <color=blue>Hòa<color>")
end
end
function tbTangLaoDai:Chon_Dam()
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
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Kéo<color>, bạn đã <color=blue>Thắng<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>"..me.szName.."<color> Oẳn Tù Tì với <color=red>Bé Thả Diều<color> giành chiến thắng nhận <color=gold>100.000 Kinh Nghiệm<color><color>");	   
me.AddExp(100000)
me.AddBindCoin(2000)
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon Dam
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Búa<color>, bạn đã <color=blue>Hòa<color>")
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon Dam
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Bao<color>, bạn đã <color=blue>Thua<color>")
end
end
function tbTangLaoDai:Chon_Keo()
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
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Kéo<color>, bạn đã <color=blue>Hòa<color>")
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon Keo
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Búa<color>, bạn đã <color=blue>Thua<color>")
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon Keo
me.Msg("<color=green>Bé Thả Diều<color> chọn <color=yellow>Bao<color>, bạn đã <color=blue>Thắng<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>"..me.szName.."<color> Oẳn Tù Tì với <color=red>Bé Thả Diều<color> giành chiến thắng nhận <color=gold>100.000 Kinh Nghiệm<color><color>");	   
me.AddExp(100000)
me.AddBindCoin(2000)
end
end
