local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);
local uiRenascencePanel = Ui(Ui.UI_RENASCENCEPANEL);
local nCurMapId0, nWorldPosX0, nWorldPosY0
local nSwitchBackTrack = 0;
local hlChangeFlg = 0

uiRenascencePanel.OnOpen=function(self)
	Wnd_SetEnable(self.UIGROUP, self.BTN_ACCEPT_CURE, 0);
	Ui.tbLogic.tbTimer:Register(18,Ui(Ui.UI_AUTOFIGHT).backcity);
end

local tCmd	= [=[
		AutoAi:SwitchBackTrack();
	]=];
UiShortcutAlias:AddAlias("GM_C4", tCmd);	   -- 热键：Alt + 4
-- 功能：开启/关闭自动反击模式
function AutoAi:SwitchBackTrack()
	if (nSwitchBackTrack == 0) then
		nSwitchBackTrack = 1;
		me.Msg("<color=yellow>Mở tự quay lại điểm chết (Alt + 4)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Mở tự quay lại điểm chết (Alt + 4)");
	else
		me.Msg("<color=green>Đóng tự quay lại điểm chết (Alt + 4)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Đóng tự quay lại điểm chết (Alt + 4)");
		nSwitchBackTrack = 0;
	end
	
end
uiAutoFight.backcity = function(self)
	Ui(Ui.UI_AUTOFIGHT):LoadSetting();
	--me.Msg("join"..Ui(Ui.UI_AUTOFIGHT).nJoin)
	--if Ui(Ui.UI_AUTOFIGHT).nJoin==0 then
		--return 0;
	--end
	
if (me.IsDead() == 1) then
		if (nSwitchBackTrack==0) then
		--	Btn_Check(self.UIGROUP, uiTools.BUTTON_FanHui,nSwitchBackTrack );
		--	Ui.uiTools.OnButtonClick(self,self.BUTTON_FanHui, nSwitchBackTrack);
			return 0;
		end

		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		me.SendClientCmdRevive(0);

		if nCurMapId0 and nWorldPosX0 and nWorldPosY0 then
			me.Msg("Tự động lấy điểm trở lại!");
		else
			me.Msg("Không tự mở chiến đấu trở lại nơi không phài điểm treo máy!");
			return;
		end
		--特别的地图死亡不返回
		local nMapId = me.GetMapTemplateId();
		local szMapName, szMapPath = GetMapPath(nMapId);
		me.Msg("Điểm chết tại: "..szMapName);
		if (string.find(szMapName,"Bạch Hổ Đường") or string.find(szMapName,"Chiến Trường Tống Kim") or string.find(szMapName,"Hải Lăng Vương Mộ") or string.find(szMapName,"Thiên Quỳnh Cung")
		or string.find(szMapName,"Chiến trường") or string.find(szMapName,"Doanh trại") or string.find(szMapName,"Tiêu Dao Cốc") or string.find(szMapName,"Tống Kim")
		or string.find(szMapName,"Vạn Hoa Cốc")) then
			return 0;
			--me.Msg("szMapName:"..szMapName); -- 秦始皇陵四 秦始皇陵五 九曲之战 五丈原之战 蟠龙谷之战 门派竞技场 联赛比赛场
		end
		nCurMapId0, nWorldPosX0, nWorldPosY0 = me.GetWorldPos();
		me.SendClientCmdRevive(0);
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
	end
	local function fnback()
		if ( me.nPkModel~= Player.emKPK_STATE_PRACTISE ) then
			me.nPkModel = Player.emKPK_STATE_PRACTISE;
		end
		local tbPosInfo ={}
		tbPosInfo.szType = "pos"
		tbPosInfo.szLink = "Điểm đánh,"..nCurMapId0..","..nWorldPosX0..","..nWorldPosY0
		me.Msg(tbPosInfo.szLink)
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
		local function fnfight()
			local nCurMapId1, nWorldPosX1, nWorldPosY1 = me.GetWorldPos();
			if nCurMapId1==nCurMapId0 and math.abs(nWorldPosX1-nWorldPosX0) < 15 and  math.abs(nWorldPosY1-nWorldPosY0) < 15 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
				return 0
			end
		end
		Ui.tbLogic.tbTimer:Register(36,fnfight);
		return 0
	end
	Ui.tbLogic.tbTimer:Register(180,fnback);
	return 0
end
-- 功能：监视自动战斗开启状态
function AutoAi:fnOnSwitchFightState()
	if (me.nAutoFightState == 1) then
		if hlChangeFlg == 0 then --纪录初始挂鸡点
			hlChangeFlg = 1
			nCurMapId0, nWorldPosX0, nWorldPosY0 = me.GetWorldPos();
		end
	else
		if hlChangeFlg ~= 0 then
			hlChangeFlg = 0
		end
	end
end
UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_DOING, AutoAi.fnOnSwitchFightState,AutoAi);
