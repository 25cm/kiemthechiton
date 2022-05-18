if not MODULE_GAMESERVER then
	return;
end
function CapNhatTaiPhu:CapNhat_GS()
		local nMapIndex = SubWorldID2Idx(1);
	if nMapIndex < 0 then
		return;
	end
	 GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"}); --võ lâm
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"}); --tài phú
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"});  --thủ lĩnh
    GCExcute({"PlayerHonor:UpdateSpringHonorLadder"}); 
	GCExcute({"PlayerHonor:UpdateLevelHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateXoyoLadder"});  --tiêu dao
    GCExcute({"PlayerHonor:OnSchemeLoadFactionHonorLadder"});  --môn phái
    GCExcute({"PlayerHonor:OnSchemeUpdateSongJinBattleHonorLadder"});  --
    GCExcute({"PlayerHonor:OnSchemeUpdateDragonBoatHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdateWeiwangHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdatePrettygirlHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdateKaimenTaskHonorLadder"}); 
    KGblTask.SCSetDbTaskInt(86, GetTime()); 
    GlobalExcute({"PlayerHonor:OnLadderSorted"});     
    print("Xếp hạng lại danh vọng."); 
	GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Hệ thống Danh Vọng đã cập nhật, có thể xem chi tiết bằng phím Ctrl + C."});

end