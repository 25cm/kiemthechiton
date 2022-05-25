Ui.UI_TOOL				= "UI_TOOL";
local uiTool			= Ui.tbWnd[Ui.UI_TOOL] or {};
uiTool.UIGROUP			= Ui.UI_TOOL;
Ui.tbWnd[Ui.UI_TOOL]	= uiTool
Map.tbTool		= uiTool;
-----------------------------------------------------------------------
local BTNRungGai							= "BtnRungGai"
local BTNCallQuangAnhThach					= "BtnCallQuangAnhThach"
local BTNCallAutoPuFire						= "BtnCallAutoPuFire"

local BTNVuotRao							= "BtnVuotRao"
local BTNThaoDuoc							= "BtnThaoDuoc"
local BTNGoPhong							= "BtnGoPhong"
local BTNCauCa								= "BtnCauCa"
local BTNDaoCu								= "BtnDaoCu"
local BTNNKT								= "BtnNKT"
local BTNDBC								= "BtnDBC"

local BTNGhepHT								= "BtnGhepHT"
local BTNStartBao							= "BtnStartBao"
local BTNStopBao							= "BtnStopBao"
local BTNTrain								= "BtnTrain"
local BTNBvd								= "BtnBvd"
local self									= uiTool 
local tbTimer = Ui.tbLogic.tbTimer;
Ui:RegisterNewUiWindow("UI_TOOL", "tool", {"a", 730, 0}, {"b", 954, 100}, {"c", 1210, 100});

function uiTool:OnButtonClick(szWnd)
--------------------------------------
	if (szWnd == BTNRungGai) then
		Ui.RungGaiHL:RRungGai();
	elseif (szWnd == BTNCallQuangAnhThach) then
		Map.tbSuperCall:QuangAnhThach();
	elseif (szWnd == BTNCallAutoPuFire) then
		Map.tbSuperCall:AutoPuFire();
--------------------------------------
	elseif (szWnd == BTNVuotRao) then
		Ui.VuotRaoHS:JumpSwitch();
	elseif (szWnd == BTNThaoDuoc) then
		Map.tbAutoEgg2:AutoPick();	
	elseif (szWnd == BTNGoPhong) then 
		Map.tbAutoEgg1:AutoPick();
	elseif (szWnd == BTNCauCa) then
		uiTool:FishHook();	
	elseif (szWnd == BTNDaoCu) then
		uiTool.DaoJu();
	elseif (szWnd == BTNNKT) then
		uiTool.NKT();
	elseif (szWnd == BTNDBC) then
		uiTool.DBC();		
	elseif (szWnd == BTNNKT) then
		uiTool.NKT();
	elseif (szWnd == BTNDBC) then
		uiTool.DBC();
--------------------------------------
	elseif szWnd == BTNGhepHT then		    
		UiManager:hexuan();
	elseif szWnd == BTNStartBao then	
		UiManager:StartBao();
	elseif szWnd == BTNStopBao then	
		UiManager:StopBao();
	elseif szWnd == BTNTrain then
		UiManager:StartGua();	
	elseif szWnd == BTNBvd then	
		UiManager:SwitchWindow(Ui.UI_SPRBAO_SETTING);

	end
end

uiTool.DaoJu=function(self)
	if me.GetMapTemplateId() > 65500 then
		local nCount=me.GetItemCountInBags(20,1,603,1)
		SendChannelMsg("Team", string.format("Công cụ %d", nCount));
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hậu Phục Ngưu Sơn<color>");
	end
end

uiTool.NKT=function(self)
	if me.GetMapTemplateId() > 65500 then
		local nCount=me.GetItemCountInBags(20,1,623,1)
		SendChannelMsg("Team", string.format("Nhiếp Không Thảo %d", nCount));
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Bách Man Sơn<color>");
	end
end

uiTool.DBC=function(self)
	if me.GetMapTemplateId() > 65500 then
		local nCount=me.GetItemCountInBags(20,1,626,1)
		SendChannelMsg("Team", string.format("Đuôi Bọ Cạp %d", nCount));
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Bách Man Sơn<color>");
		end
end

uiTool.FishHook_Two=function(self)
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	if nWorldPosX==13216/8 and nWorldPosY==62048/16 then
		me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH)
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 then 
			local tbFind = me.FindItemInBags(20,1,253,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		end
		if me.GetItemCountInBags(20,1,617,1)>=10 then
			me.Msg("Cá")
			Ui.tbLogic.tbTimer:Close(self.FishHookId)
		end
	else
		me.AutoPath(13216/8,62048/16)
		me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH)
	end
end
uiTool.FishHook=function(self)
	Ui.tbLogic.tbTimer:Close(self.FishHookId)
	if me.GetMapTemplateId() > 65500 then
		me.Msg("<color=yellow>Bắt đầu tự động Câu cá<color>")
		if me.GetItemCountInBags(20,1,253,1)>=1 or me.GetItemCountInBags(20,1,254,1)>=1 then
			self.FishHookId=tbTimer:Register(Env.GAME_FPS, self.FishHook_Two, self);
		end
	else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hậu Phục Ngưu Sơn<color>");
	end
end
