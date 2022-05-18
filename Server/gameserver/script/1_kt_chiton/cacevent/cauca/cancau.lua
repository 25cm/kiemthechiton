local tbItem = Item:GetClass("thk_cancau");
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\cauca\\cancau.lua");
local nCheck = 0;
local nTempId = 20216;
if me.CountFreeBagCell() < 5 then
local szAnnouce = "Hành trang của bạn không đủ 5 ô trống.";
me.Msg(szAnnouce);
return 0;
end	
local nCount1 = me.GetItemCountInBags(18,1,2094,1)
if nCount1 < 1 then
Dialog:Say("Thiếu <color=cyan>Mồi Câu<color>")
return
end
local tbAroundNpc = KNpc.GetAroundNpcList(me, 15);
for _, pNpc in ipairs(tbAroundNpc) do
if (pNpc.nTemplateId == nTempId) then
nCheck = 1;
break;
end
end
if (nCheck == 1) then
local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
				 GeneralProcess:StartProcess("<pic=48>Đang Câu", 3 * Env.GAME_FPS, {self.OnDialog4, self}, nil, tbEvent);
else
self:DiChuyenToiBaiCa()
return 0;
end
end
function tbItem:DiChuyenToiBaiCa()
local szMsg = "<color=red>Chú Ý<color>: nơi này không có <color=green>Cá<color>\n"..
"<color=yellow>Sử dụng chức năng dưới đây để tới nơi một cách<color>\n"..
"<color=gold>Nhanh Chóng\n"..
"Chính Xác"
local tbOpt = {
{"Tới <color=gold>Bãi Câu Cá 1<color> [Đạo Hương Thôn]", me.NewWorld, 4, 1637, 3224};
{"Tới <color=gold>Bãi Câu Cá 2<color> [Đạo Hương Thôn]", me.NewWorld, 4, 1647, 3220};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbItem:OnDialog4()
local tbItemInfo = {bForceBind = 1};
local nMapId, nPosX, nPosY = me.GetWorldPos();
local tbItemId1	= {18,1,2094,1,0,0}; -- Mồi Câu
local nCount1 = me.GetItemCountInBags(18,1,2094,1)
if nCount1 < 1 then
Dialog:Say("Thiếu <color=cyan>Mồi Câu<color>")
return
end
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 100);
	-- fill 3 rate	
	local tbRate = {30,50,5,15};
	local tbAward = {1 ,2, 3, 4};

	 
			for i = 1, 4 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- Cá Chép
me.AddStackItem(18,1,2095,1,tbItemInfo,1);
Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Câu được <color=yellow>1 Cá Chép<color>!"));
me.Msg("<pic=125><color=yellow>Mất: <color=green>1 Mồi Câu<color> | Nhận: <color=yellow>1 Cá Chép<color>")
Task:DelItem(me, tbItemId1, 1);
end
if (tbAward[nIndex]==2) then -- Cá Rô
me.AddStackItem(18,1,2096,1,tbItemInfo,1);
Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Câu được <color=green>1 Cá Rô<color>!"));
me.Msg("<pic=125><color=yellow>Mất: <color=green>1 Mồi Câu<color> | Nhận: <color=green>1 Cá Rô<color>")
Task:DelItem(me, tbItemId1, 1);
end
if (tbAward[nIndex]==3) then -- Cá Ba Đuôi
me.AddStackItem(18,1,2099,1,tbItemInfo,1);
Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Câu được <color=red>1 Tôm Hùm<color>!"));
me.Msg("<pic=125><color=yellow>Mất: <color=green>1 Mồi Câu<color> | Nhận: <color=red>Tôm Hùm<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> tại <color=green>".. math.floor(nPosX/8) .."<color>/<color=green>".. math.floor(nPosY/16) .."<color> <color=cyan>"..GetMapNameFormId(nMapId).."<color> câu được <color=red>1 Tôm Hùm<color><color>");	   
Task:DelItem(me, tbItemId1, 1);
end
if (tbAward[nIndex]==4) then -- Cá Trích
me.AddStackItem(18,1,2098,1,tbItemInfo,1);
Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Câu được <color=blue>1 Cá Trích<color>!"));
me.Msg("<color=yellow>Mất: <color=green>1 Mồi Câu<color> | Nhận: <color=blue>1 Cá Trích<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color>  tại <color=green>".. math.floor(nPosX/8) .."<color>/<color=green>".. math.floor(nPosY/16) .."<color> <color=cyan>"..GetMapNameFormId(nMapId).."<color> câu được <color=blue>1 Cá Trích<color><color>");	   
Task:DelItem(me, tbItemId1, 1);
end
	end