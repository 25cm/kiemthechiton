local cddm	= UiManager
local scidd=nil
local nFindNPC = 0;

cddm.cddmm=function()
	if nFindNPC==0 then
		nFindNPC = 1;
		--me.Msg("<color=yellow>Bắt đầu tự tìm Nhan Như Ngọc, hảy nhấn [Ctrl+M] để bật chức năng tự trả lời<color>")
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bắt đầu tự tìm Nhan Như Ngọc [Alt+8]<color>");
		scidd = Ui.tbLogic.tbTimer:Register(15, cddm.schsdm, self)
	else
		nFindNPC = 0;
		Ui.tbLogic.tbTimer:Close(scidd);
		--me.Msg("<color=green>Tắt tự tìm Nhan Như Ngọc<color>")
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự tìm Nhan Như Ngọc [Alt+8]<color>");
	end
end

cddm.schsdm = function(self)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		
		return
	elseif UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		
		return
	end
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
	 for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId==3633 or pNpc.nTemplateId==2703) then
			local _,nX, nY	= pNpc.GetWorldPos();
			local nMapId, nPosX, nPosY	= me.GetWorldPos();
			if nPosX-nX>4 or nX-nPosX>4 or nPosY-nY>4 or nY-nPosY>4 then
				me.StartAutoPath(nX, nY);
				return
			end
			AutoAi.SetTargetIndex(pNpc.nIndex);
			return
		 end
	 end

end

local szCmd = [=[
UiManager.cddmm();
]=];
UiShortcutAlias:AddAlias("GM_C8", szCmd); 

