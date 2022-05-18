-------------------------------------------------------------------
--File: customercmd_gs.lua
--Author: zouying
--Date: 2009-4-28 10:08
--Describe:  gs处理平台发来的gm指令
-------------------------------------------------------------------
function GmCmd:KickOut(szCallBackFun, nSession, nAsker, szName, nConnectId)
	
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (pPlayer) then
		local bRet = pPlayer.KickOut();
		if (nSession ~= 0) then
			_G.GCExcute({szCallBackFun, nSession, 0, nAsker, bRet, nConnectId});
		end
	end
end

function GmCmd:PlayerFly_GS(nSession, nAsker, szName, nMapId, nX, nY)
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (pPlayer) then
		local bRet = pPlayer.NewWorld(nMapId, nX, nY);
		_G.GCExcute({"GmCmd:ReportCmdResult", nSession, 0, nAsker, bRet});
	end
end

function GmCmd:OnPlayerLogin()
	local nUnBanChatTime = me.GetTask(self.TASK_CUSTOMER_ID, self.SUBTASKID_UNBANCHAT);
	
	if (nUnBanChatTime ~= 0 and nUnBanChatTime <= GetTime()) then
		me.SetForbidChat(0);
		me.Msg("您已经解除禁言了。");
		me.SetTask(self.TASK_CUSTOMER_ID, self.SUBTASKID_UNBANCHAT, 0);
	end
	local nFreeTime = me.GetTask(self.TASK_CUSTOMER_ID, self.SUBTASKID_FREEPRISON);
	
	if (nFreeTime ~= 0 and nFreeTime <= GetTime()) then
		Player:SetFree(me.szName);
		me.Msg("你自由了，释放出大牢了。");
		me.SetTask(self.TASK_CUSTOMER_ID, self.SUBTASKID_FREEPRISON, 0);
	end
end

PlayerEvent:RegisterGlobal("OnLogin", GmCmd.OnPlayerLogin, GmCmd);