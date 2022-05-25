Ui.UI_UNREAL         ="UI_UNREAL";
local uiUnreal	= Ui.tbWnd[Ui.UI_UNREAL] or {};
uiUnreal.UIGROUP	= Ui.UI_UNREAL;
Ui.tbWnd[Ui.UI_UNREAL] = uiUnreal

local tbSaveData 	= Ui.tbLogic.tbSaveData;
local tbUnreal 	= Ui.tbLogic.tbUnreal;
uiUnreal.DATA_KEY	= "Unreal";

Ui:RegisterNewUiWindow("UI_UNREAL", "unreal", {"a", 520, 220}, {"b", 520, 220}, {"c", 520, 220});


local BUTTON_CLOSE ="BtnClose"
local BUTTON_LONG ="BtnLong"
local BUTTON_FENG="BtnFeng"
local BUTTON_QING="BtnQing"
local BUTTON_ACT="BtnAct"
local BUTTON_CAN="BtnCan"
local EDIT_CONTENT 	= "EdtContent";
local BUTTON_ABE="Btnabe"

local self = uiUnreal
local nUnrealTimerId = 0
local nUrTime = 10
self.nULong=0
self.nUFeng=0
self.nUQing=0
self.nUnRealState=0
self.nUnRealCode=410
uiUnreal.OnButtonClick=function(self,szWnd, nParam)
        if szWnd == BUTTON_CLOSE then
		UiManager:CloseWindow(self.UIGROUP); 
	elseif (szWnd == BUTTON_LONG) then
                self.nULong=nParam
		if nParam==1 then
                   me.AddSkillEffect(408)
                else
                   me.RemoveSkillEffect(408)
		end
	elseif (szWnd == BUTTON_FENG) then
                self.nUFeng=nParam
		if nParam==1 then
                   me.AddSkillEffect(407)
                else
                   me.RemoveSkillEffect(407)
		end
	elseif (szWnd == BUTTON_QING) then
                self.nUQing=nParam
		if nParam==1 then
                   me.AddSkillEffect(406)
                else
                   me.RemoveSkillEffect(406)
		end
        elseif (szWnd == BUTTON_ABE) then
                self.nUnRealState=nParam
		if nParam==1 then
		  me.Msg("<color=0,255,255>L岷穚 l岷<color>");
                  if self.nULong == 1 then
                     self.nUnRealCode = 408;
                  elseif self.nUFeng == 1 then
                     self.nUnRealCode = 407;
                  elseif self.nUQing == 1 then
                     self.nUnRealCode = 406;
                  else
                     self.nUnRealCode = Edt_GetInt(self.UIGROUP, EDIT_CONTENT)
                  end
	          nUnrealTimerId = Ui.tbLogic.tbTimer:Register(nUrTime * Env.GAME_FPS, self.unrealact, self);
	        else
		  me.Msg("<color=0,255,255>Ng峄玭g l岷穚 l岷<color>");
	          Ui.tbLogic.tbTimer:Close(nUnrealTimerId);
                  me.RemoveSkillEffect(self.nUnRealCode)
                  nUnrealTimerId = 0;
                  self.nULong = 0;
                  self.nUFeng = 0;
                  self.nUQing = 0;
	          self:UpdateWnd();
		end
        elseif (szWnd == BUTTON_ACT) then
                  local nTimes = Edt_GetInt(self.UIGROUP, EDIT_CONTENT);
		    if nTimes >= 1 and  nTimes <= 410 then
                    self.nUnRealCode=nTimes
                   me.AddSkillEffect(self.nUnRealCode)
                   end
        elseif (szWnd == BUTTON_CAN) then
               local nTimes = Edt_GetInt(self.UIGROUP, EDIT_CONTENT);
		    if nTimes >= 1 and  nTimes <= 410 then
                    self.nUnRealCode=nTimes
                   me.RemoveSkillEffect(self.nUnRealCode)
                   end
        end

end

function uiUnreal:OnEditChange(szWnd, nParam)
	if (szWnd == EDIT_CONTENT) then
		local nTimes = Edt_GetInt(self.UIGROUP, EDIT_CONTENT);
		if nTimes > 410 then
			Edt_SetInt(self.UIGROUP, EDIT_CONTENT, 410);
		end
	end
end

function uiUnreal:unrealact()
        if self.nUnRealCode then
          me.AddSkillEffect(self.nUnRealCode);
        end
end
-------------------------------------------
--保存配置到本地
function uiUnreal:SaveData()
	self.tbUnrealSetting = { nULong = self.nULong, nUFeng=self.nUFeng, nUQing= self.nUQing,nUnRealState=self.nUnRealState, } 
	tbSaveData:Save(self.DATA_KEY, self.tbUnrealSetting);
end
--读取本地配置
function uiUnreal:LoadSetting()
	--读取配置
	local tbUnrealSetting = tbSaveData:Load(self.DATA_KEY);
	if tbUnrealSetting.nULong then
		self.nULong = tbUnrealSetting.nULong;
	end
	if tbUnrealSetting.nUFeng then
		self.nUFeng = tbUnrealSetting.nUFeng;
	end
	if tbUnrealSetting.nUQing then
		self.nUQing = tbUnrealSetting.nUQing;
	end
	if tbUnrealSetting.nUnRealState then
		self.nUnRealState = tbUnrealSetting.nUnRealState;
	end

	tbUnrealSetting = { nULong = self.nULong, nUFeng=self.nUFeng, nUQing= self.nUQing,nUnRealState=self.nUnRealState, } 
	--print("-------------------------")
       --  Lib:ShowTB(tbUnrealSetting);	
	if self.tbUnrealSetting then
		self.nULong = tbUnrealSetting.nULong;
		self.nUFeng = tbUnrealSetting.nUFeng;
		self.nUQing = tbUnrealSetting.nUQing;
		self.nUnRealState = tbUnrealSetting.nUnRealState;
	end
end
--窗口打开
function uiUnreal:OnOpen()
	self:LoadSetting();
	self:UpdateWnd();
        Edt_SetInt(self.UIGROUP, EDIT_CONTENT, self.nUnRealCode);
end

function uiUnreal:UpdateWnd()
	Btn_Check(self.UIGROUP, BUTTON_LONG, self.nULong);
	Btn_Check(self.UIGROUP, BUTTON_FENG, self.nUFeng);
	Btn_Check(self.UIGROUP, BUTTON_QING, self.nUQing);
	Btn_Check(self.UIGROUP, BUTTON_ABE, self.nUnRealState);
end


-- 注册快捷键
local tCmd={ "UiManager:SwitchWindow(Ui.UI_UNREAL)", "UNREAL", "", "Ctrl+T", "Ctrl+T", "自我陶醉变装盒"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	-----快捷键Ctrl+T
