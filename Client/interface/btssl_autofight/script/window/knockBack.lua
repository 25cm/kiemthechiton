-----------------------------------------------------------
-- 作    者 ：  小虾米
-- 修改时间 ：	2009-07-29
-- 功能描述 ：	自动战斗开启时遇屠杀自动开模式攻击(也可用于联赛等PK场所)
-----------------------------------------------------------

local nKnockBackState   = 0;
local nKnockBackTimerId = 0;
local nMonitorTimerId = 0;
local TimeLastPKModel   = 0;
local nTargetIndex      = 0;
local nSwitchKnockBack  = 0;   -- 自动反击模式开启状态，默认为开启
local INTERVAl_CHECK	  = 1;   -- 检测频率: 1秒/次
local ACTIVE_RADIUS     = 1200; -- 活动范围
local tbSelectNpc       = Ui(Ui.UI_SELECTNPC);

local tCmd	= [=[
		AutoAi:SwitchKnockBack();
	]=];
UiShortcutAlias:AddAlias("GM_C3", tCmd);	   -- 热键：Alt+3

-- 功能：开启/关闭自动反击模式
function AutoAi:SwitchKnockBack(nSwitch)
	if nSwitch then
		nSwitchKnockBack = nSwitch;
	elseif (nSwitchKnockBack == 1) then
		nSwitchKnockBack = 0;
	else
		nSwitchKnockBack = 1;
	end
	if (nSwitchKnockBack == 1) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Kích hoạt tự phản kháng [Alt+3]<color>");
		nMonitorTimerId = Ui.tbLogic.tbTimer:Register(INTERVAl_CHECK * Env.GAME_FPS, self.MonitoringMap, self);
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự phản kháng[Alt+3]<color>");
		nKnockBackState = 1;
		AutoAi:StopKnockBack();
		Ui.tbLogic.tbTimer:Close(nMonitorTimerId);
		nMonitorTimerId = 0;
	end
end

-- 功能：开始自动反击
function AutoAi:StartKnockBack()
	if (nSwitchKnockBack == 0) then
		return;
	end
	if nKnockBackState == 0 then
		me.Msg("<bclr=red><color=yellow>Tự phản kháng");
		nKnockBackState = 1;
		nKnockBackTimerId = Ui.tbLogic.tbTimer:Register(INTERVAl_CHECK * Env.GAME_FPS, self.KnockBack, self);
	end
end

-- 功能：停止自动反击
function AutoAi:StopKnockBack()
	if (nKnockBackState == 1) then
		me.Msg("<bclr=blue><color=White>Ngừng phản kháng");
		if (nKnockBackTimerId > 0) then
			Ui.tbLogic.tbTimer:Close(nKnockBackTimerId);
		end
		nTargetIndex = 0;
		TimeLastPKModel = 0;
		nKnockBackState = 0;
		nKnockBackTimerId = 0;
		AutoAi.SetTargetIndex(0);
	end
end

function AutoAi:KnockBack()
	if (me.nFightState == 0 or me.nAutoFightState ~= 1) then
		return;  -- 非战斗地图直接返回
	end
	local nDistance = AutoAi:GetCurrentDistance();
	if (nDistance > ACTIVE_RADIUS) then
		AutoAi.SetTargetIndex(0); -- 超出活动范围则返回
		return;
	end
	local pPlayerInfo = tbSelectNpc.pPlayerInfo;
	if (pPlayerInfo and pPlayerInfo.nKind >= 0 and pPlayerInfo.nKind <= 3) then
		local nCanAttack = AutoAi.AiTargetCanAttack(pPlayerInfo.nIndex);
		if (nCanAttack == 1) then
			nTargetIndex = pPlayerInfo.nIndex;  -- 优先攻击鼠标选中的目标
		end
	end
	if (nTargetIndex > 0 and AutoAi.AiTargetCanAttack(nTargetIndex) == 1) then
		AutoAi.SetTargetIndex(nTargetIndex);
		return;
	end
	local nMapId = me.GetMapTemplateId();
	local szMapName, szMapPath = GetMapPath(nMapId);
	local tbNpc = SyncNpcInfo();
	local nButcher = 0;
	if tbNpc then
		for _, tbNpcInfo in ipairs(tbNpc) do
			if tbNpcInfo.szName then
					end
			if tbNpcInfo.nType == 7 then
				-- Type=3 蓝色(不可攻击) Type=5 绿色(队友) Type=6 橙色(可攻击) Type=7 红色(屠杀)
				if (me.nPkModel == Player.emKPK_STATE_PRACTISE) then
					me.Msg("<color=green>Tự động phản kháng, chuyển sang chế độ <color=blue>Gia Tộc-Bang Hội");
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Cảnh báo: Nguy hiểm !<color>")
					me.nPkModel = Player.emKPK_STATE_TONG -- Pk bang
					TimeLastPKModel = GetTime();
				end
				nButcher = 1;
				break;
			end
		end
	end
	nTargetIndex = 0;
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 400);
	for _, pNpc in ipairs(tbAroundNpc) do
		local nCanAttack = AutoAi.AiTargetCanAttack(pNpc.nIndex);
		if (nCanAttack == 1 and pNpc.nKind == 1) then
			me.Msg("<color=pink>Có thể tấn công: <color=yellow>"..pNpc.szName);
			nTargetIndex = pNpc.nIndex;
			break;
		end
	end
	if (nTargetIndex > 0 and AutoAi.AiTargetCanAttack(nTargetIndex) == 1) then
		AutoAi.SetTargetIndex(nTargetIndex);
	else
		nTargetIndex = 0;
	end
	if (string.find(szMapName,"白虎堂") or string.find(szMapName,"之战") or string.find(szMapName,"赛场")) then
		return; -- 秦始皇陵四 秦始皇陵五 九曲之战 五丈原之战 蟠龙谷之战 门派竞技场 联赛比赛场
	end
	if (TimeLastPKModel == 0) then
		TimeLastPKModel = GetTime();
	end
	local nNowTime = GetTime();
	if (nButcher == 0 and me.nPkModel ~= Player.emKPK_STATE_PRACTISE and TimeLastPKModel + 180 < nNowTime) then
		me.nPkModel = Player.emKPK_STATE_PRACTISE; -- 3分钟后切换到练功模式
		TimeLastPKModel = 0;
	end
end

-- 功能：监视当前地图 --by 蓬莱岛主
function AutoAi:MonitoringMap()
	local nMapId = me.GetMapTemplateId();
	if (nMapId <1437 and nMapId >1424) or (nMapId <1497 and nMapId >1460) or (nMapId <1532 and nMapId >1507)  then
		me.Msg("<color=gold>Vào khu liên đấu, tự mở chiến đấu！<color>");
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

-- 功能：监视自动战斗开启状态
function AutoAi:fnOnSwitchFightState()
	if (me.nAutoFightState == 1) then
		Ui.tbLogic.tbTimer:Close(nMonitorTimerId);
		nMonitorTimerId = 0;
		AutoAi:StartKnockBack();
	else
		AutoAi:StopKnockBack();
		local nMapId = me.GetMapTemplateId(); ----by 蓬莱岛主
		if (nMapId <1437 and nMapId >1424) or (nMapId <1497 and nMapId >1460) or (nMapId <1532 and nMapId >1507)   then
			return;
		else
			if (nMonitorTimerId == 0 and nSwitchKnockBack == 1) then
				nMonitorTimerId = Ui.tbLogic.tbTimer:Register(INTERVAl_CHECK * Env.GAME_FPS, self.MonitoringMap, self);
			end
		end
	end
end

-- 功能：获取当前位置距离挂机点距离
function AutoAi:GetCurrentDistance()
	local x,y,world = me.GetNpc().GetMpsPos();
	local nx = AutoAi.auto_fight_pos[AutoAi.auto_pos_index].x;
	local ny = AutoAi.auto_fight_pos[AutoAi.auto_pos_index].y;
	local dx = x - nx;
	local dy = y - ny;
	local nDistance = math.sqrt(dx^2 + dy^2);
	return nDistance;
end

UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_DOING, AutoAi.fnOnSwitchFightState,AutoAi);
