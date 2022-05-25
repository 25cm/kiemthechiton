local tbAutoEgg2	   = Map.tbAutoEgg2 or {};
Map.tbAutoEgg2		   = tbAutoEgg2;
local tbSelectNpc  = Ui(Ui.UI_SELECTNPC);

local eggStart     = 0;
local nPickState   = 0;
local nPickTimerId = 0;
local nPickTime    = 0.3; 
tbAutoEgg2.PeepChatMsg =function(self)
	tbAutoEgg2.OnMsgArrival_bak	= tbAutoEgg2.OnMsgArrival_bak or UiCallback.OnMsgArrival;
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg)
		tbAutoEgg2:SeeChatMsg(szMsg);
		tbAutoEgg2.OnMsgArrival_bak(UiCallback, nChannelID, szSendName, szMsg);
	end
end


function tbAutoEgg2:OnPickTimer()
	if (nPickState == 0) then
		return 0
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	if Map.firedown == 1 then
		return 0
	end
----------------
if me.GetMapTemplateId() < 65500 then
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hậu Phục Ngưu Sơn<color>");
		me.Msg("<color=yellow>Chức năng này chỉ hoạt động trong Hậu Sơn Phó Bản<color>")
		nPickState = 0;
		return
	end
-------------------
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do		
		if (pNpc.nTemplateId == 4235) then  -- Minh Hỏa:4235 
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1652) then  -- Thảo mộc:1652
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		end
	end
	if me.GetItemCountInBags(20,1,615,1)>=5 then
		SendChannelMsg("Team", "Tôi đã thu thập đủ Thảo Dược")
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Đã thu thập đủ Thảo Dược");
		Timer:Close(nPickTimerId);
	end
end

function tbAutoEgg2:AutoPick()
	if nPickState == 0 then 
		nPickState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Mở chức năng thu thập Thảo dược");
		nPickTimerId = Timer:Register(Env.GAME_FPS * nPickTime, self.OnPickTimer, self);
	else
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chức năng thu thập Thảo dược");
		Timer:Close(nPickTimerId);
	end
end

tbAutoEgg2:Init();