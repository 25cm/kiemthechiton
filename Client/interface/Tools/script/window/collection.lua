local tbAutoEgg	   = Map.tbAutoEgg or {};
Map.tbAutoEgg		   = tbAutoEgg;
local tbSelectNpc  = Ui(Ui.UI_SELECTNPC);

local eggStart     = 0;
local nPickState   = 0;
local nPickTimerId = 0;
local nPickTime    = 0.3;
tbAutoEgg.PeepChatMsg =function(self)
	tbAutoEgg.OnMsgArrival_bak	= tbAutoEgg.OnMsgArrival_bak or UiCallback.OnMsgArrival;
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg)
		tbAutoEgg:SeeChatMsg(szMsg);
		tbAutoEgg.OnMsgArrival_bak(UiCallback, nChannelID, szSendName, szMsg);
	end
end

function tbAutoEgg:OnPickTimer()
	if (nPickState == 0) then
		return 0
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	if Map.firedown == 1 then
		return 0
	end
	--------------range = 100
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do		
		if (pNpc.nTemplateId == 2701) then  	-- Cờ Tầm Bảo
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 3622) then  -- Rương Niên thú
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 2960) then  -- Rương tiền đồng	(Ải Gia Tộc)
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1649) then  -- Gỗ thông Vũ Lăng Sơn
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1668) then  -- Gỗ
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1068) then  -- Tiêu thạch(Tiêu Thạch Cốc)
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1667) then  -- Tiêu thạch
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4113) then  -- Bảo rương
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4668) then  -- Cũi khô TDC
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;	
		elseif (pNpc.nTemplateId == 3303) then  -- Bảo rương lv5
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 3261) then  -- Bảo rương lv4
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4277) then  -- Cửa mật đạo
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4023) then  -- Cây phong HPNS
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4175) then  -- Bảo rương
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4280) then  -- Bảo rương
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 3691) then  -- Thất Tịch Thủy Ngưu
			AutoAi.SetTargetIndex(pNpc.nIndex);
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			me.AnswerQestion(1)
			me.AnswerQestion(0)
			break;
		elseif (pNpc.nTemplateId == 4013) then  -- Dây thừng HPNS
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4014) then  -- Tấm gỗ HPNS
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1576) then  -- Tuyết Sơn Chi Linh
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1651) then  -- Chuột Núi
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 3707) then  -- Thiềm Cung Thỏ Ngọc
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1523) then  -- Liên căn thảo
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1524) then  -- Ôn nhuận thảo
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1525) then  -- Quả Sồi
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1227) then  -- Lam Diệp Thảo(hổ khâu kiếm tri)
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 845) then  -- Cây Khỏe(Cư Diên Trạch)
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1240) then  -- Lá Khoai (Hướng Thủy Động)
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 2958) then  -- Bí Dược (Ải Gia Tộc)
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4224) then  --Du long doan so 4224
			AutoAi.SetTargetIndex(pNpc.nIndex);
			me.AnswerQestion(1)
			me.AnswerQestion(0)
			break;	
		elseif (pNpc.nTemplateId == 4226) then  --Sau khi đoán số 1-cửa truyền tống
			AutoAi.SetTargetIndex(pNpc.nIndex);
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			break;
		elseif (pNpc.nTemplateId == 4227) then  --Sau khi đoán số 2-cửa truyền tống
			AutoAi.SetTargetIndex(pNpc.nIndex);
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			break;		
		end
	end
	------------------range = 15
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 15);
	for _, pNpc in ipairs(tbAroundNpc) do		
		if (pNpc.nTemplateId == 2700) then  	-- Bảo rương môn phái
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 2680) then  -- Rương Tàng bảo đồ
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1629) then  -- Tử Mẫu Đơn:1629
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;	
		elseif (pNpc.nTemplateId == 1630) then  -- Sen Mẫu Đơn:1630
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1631) then  -- Bách Hương Quả:1631
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1632) then  -- Huyết Phong Đằng:1632
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1633) then  -- Hắc Tinh Thạch:1633
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1634) then  --Lục Thủy Tinh:1634
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 1635) then  -- Thất Thái Thạch:1635
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		elseif (pNpc.nTemplateId == 4281) then  -- Rương gần Du Long
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;	
		elseif (pNpc.nTemplateId == 1563) then  -- Bất diệt hỏa
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;			
		end
	end
	
end

function tbAutoEgg:AutoPick()
	if nPickState == 0 then 
		nPickState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật chức năng nhặt vật phẩm Nhiệm vụ [Alt+4]");
		nPickTimerId = Timer:Register(Env.GAME_FPS * nPickTime, self.OnPickTimer, self);
	else
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chức năng nhặt vật phẩm Nhiệm vụ [Alt+4]");
		Timer:Close(nPickTimerId);
	end
end

function tbAutoEgg:AutoPickStart()
	if self.nPickState == 0 then
		tbAutoEgg:AutoPick();
	end
end

function tbAutoEgg:AutoPickStop()
	if self.nPickState == 1 then
		tbAutoEgg:AutoPick();
	end
end

tbAutoEgg:Init();