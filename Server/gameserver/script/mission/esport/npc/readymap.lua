--准备场npc
--孙多良
--2008.12.29

local tbNpc = Npc:GetClass("esport_yanruoxue2");

function tbNpc:OnDialog()
	local szMsg = "Các tr?n ?ánh bóng tuy?t r?t thú v?. Ruoxue ph?i ch?i v?i m?i ng??i trong m?t th?i gian dài m?i ngày. Trò ch?i s?p b?t ??u, b?n ?? s?n sàng ch?a? \n";
	local tbOpt = {
		{"T?i ?ang v?i vàng r?i ?i và kh?ng th? ch?i", self.OnLeave, self},
		{"K?t thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnLeave()
	local nMapId, nPosX, nPosY = EPlatForm:GetLeaveMapPos();
	local tbMCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType());
	if (not tbMCfg) then
		Dialog:Say("活动异常，请迅速离开准备场");
		me.NewWorld(nMapId, nPosX, nPosY);
		return 0;
	end

	local nNpcMapId = him.nMapId;
	local nReadyId = 0;
	for nId, nReadyMapId in pairs(tbMCfg.tbReadyMap) do
		if (nNpcMapId == nReadyMapId) then
			nReadyId = nId;
			break;
		end
	end
	
	if (nReadyId <= 0) then
		Dialog:Say("活动异常，请迅速离开准备场");
		me.NewWorld(nMapId, nPosX, nPosY);
		return 0;
	end
	
	if EPlatForm.ReadyTimerId > 0 then
		if Timer:GetRestTime(EPlatForm.ReadyTimerId) < EPlatForm.DEF_READY_TIME_ENTER then
			Dialog:Say("雪仗马上就要开始了，你现在最好还是不要离开。");
			return 0;
		end
	end
	if EPlatForm.ReadyTimerId <= 0 then
		Dialog:Say("你在准备场出现异常，请下线重登。")
		return 0;
	end
	me.TeamApplyLeave();			--离开队伍
	me.NewWorld(nMapId, nPosX, nPosY);
end

