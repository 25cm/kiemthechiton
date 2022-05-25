local tbConfirm = Ui.tbLogic.tbConfirm

local OnTeamReceiveInvite_Bak		= tbConfirm.OnTeamReceiveInvite
local OnTeamApplyAdd_Bak			= tbConfirm.OnTeamApplyAdd
local OnTradeReceiveRequest_Bak		= tbConfirm.OnTradeReceiveRequest
local OnRelationTmpFriend_Bak		= tbConfirm.OnRelationTmpFriend
local OnPkExerciseInvite_Bak		= tbConfirm.OnPkExerciseInvite

local CFStart = 0

function tbConfirm:Status()
	return CFStart
end

tbConfirm.Switch = function(self)
	if CFStart == 0 then 
		CFStart = 1
		me.Msg("<color=yellow>Bật<color> chặn lời mời.")
	else
		CFStart = 0
		me.Msg("<color=yellow>Tắt<color> chặn lời mời.")
	end
end

tbConfirm.OnTeamReceiveInvite = function(self, szKey, szPlayer, nPlayerId)
	local bInComp = AutoAi:InPC(szPlayer)
	if (CFStart == 1) and (bInComp ~= 1) then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> xin nhập đội đã bị hệ thống tự động từ chối!!!<color>");
	else
		if (AutoAi:RelationLevel(szPlayer) > 5) or (bInComp == 1) or
			((Ui(Ui.UI_AUTOFIGHT).nJoin == 1) and (me.nAutoFightState == 1)) then
			me.TeamReplyInvite(1, nPlayerId, szPlayer)
		else
			OnTeamReceiveInvite_Bak(self, szKey, szPlayer, nPlayerId)
		end
	end
end

tbConfirm.OnTeamApplyAdd = function(self, szKey, szPlayer, nPlayerId)
	local bInComp = AutoAi:InPC(szPlayer)
	if (CFStart == 1) and (bInComp ~= 1) then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> mời tham gia tổ đội đã bị hệ thống tự động từ chối!<color>");
	else
		if (AutoAi:RelationLevel(szPlayer) > 5) or (bInComp == 1) or
			((Ui(Ui.UI_AUTOFIGHT).nAcceptTeam == 1) and (me.nAutoFightState == 1)) then
			me.TeamReplyApply(1, nPlayerId, szPlayer)
		else
			OnTeamApplyAdd_Bak(self, szKey, szPlayer, nPlayerId)
		end
	end
end

tbConfirm.OnTradeReceiveRequest = function(self, szKey, szPlayer)
	local bInComp = AutoAi:InPC(szPlayer)
	if (CFStart == 1) and (bInComp ~= 1) then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> giao dịch với Bạn đã bị hệ thống tự động từ chối!<color>");
	elseif bInComp == 1 then
		me.TradeResponse(szPlayer, 1)
	else
		OnTradeReceiveRequest_Bak(self, szKey, szPlayer)
	end
end

tbConfirm.OnRelationTmpFriend = function(szKey, szPlayer)
	if (CFStart == 1) and (AutoAi:InPC(szPlayer) ~= 1) then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> muốn kết bạn đã bị hệ thống tự động từ chối!<color>");
	else
		OnRelationTmpFriend_Bak(szKey, szPlayer)
	end
end

tbConfirm.OnPkExerciseInvite = function(self,szKey, szPlayer, nPlayerId)
	if (CFStart == 1) and (AutoAi:InPC(szPlayer) ~= 1) then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> muốn tỷ thí đã bị hệ thống tự động từ chối!<color>");
	else
		OnPkExerciseInvite_Bak(self,szKey, szPlayer, nPlayerId)
	end
end


