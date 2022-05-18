
if (not Item.tbShiTuChuanSongFu) then
	Item.tbShiTuChuanSongFu = {};
end

local tb = Item.tbShiTuChuanSongFu;
tb.ITEM_ID = {18,1,65,1};
tb.tbc2sFun = {};

-- GCѯʸServerָͽǷ
function tb:SelectDstPlayerPos(szDstPlayerName, szAppPlayerName)
	GlobalExcute({"Item.tbShiTuChuanSongFu:SeachPlayer", szDstPlayerName, szAppPlayerName});
end


-- GS Ƿָ
function tb:SeachPlayer(szDstPlayerName, szAppPlayerName)
	-- ҵĻҵ
	local pDstPlayer = GetPlayerObjFormRoleName(szDstPlayerName);
	if (pDstPlayer) then
		local nMapId, nPosX, nPosY = pDstPlayer.GetWorldPos();
		local nCanSendIn  = Item:IsCallOutAtMap(nMapId, unpack(self.ITEM_ID));
		if (nCanSendIn ~= 1) then
			nMapId = -1;
		end	
		GCExcute({"Item.tbShiTuChuanSongFu:FindDstPlayer", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY});		
	end
end


-- GC õָͽϢ֪ͨʦ
function tb:FindDstPlayer(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)
	GlobalExcute({"Item.tbShiTuChuanSongFu:ObtainDstPlayerPos", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY})
end


-- GS ʦ֪ͽλ
function tb:ObtainDstPlayerPos(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)

	local pAppPlayer = GetPlayerObjFormRoleName(szAppPlayerName);
	if (not pAppPlayer) then
		return 0;
	end
	if nMapId == -1 then
		pAppPlayer.Msg("Không thể đến được mục tiêu!");
		return 0;
	end
	local nCanSendOut = Item:IsCallInAtMap(nMapId, unpack(self.ITEM_ID));
	if (nCanSendOut ~= 1) then
		pAppPlayer.Msg("Không được đến khu vực hiện tại!");
		return 0;
	end
	
	-- ֪ͨͽȷ
	GCExcute({"Item.tbShiTuChuanSongFu:Msg2DstPlayer4Confirm_GC", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY});
end


-- GC ֪ͨͽȷ
function tb:Msg2DstPlayer4Confirm_GC(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)
	GlobalExcute({"Item.tbShiTuChuanSongFu:Msg2DstPlayer4Confirm_GS", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY});
end

-- GS ֪ͨͽȷ
function tb:Msg2DstPlayer4Confirm_GS(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)
	local pDstPlayer = GetPlayerObjFormRoleName(szDstPlayerName);
	if (not pDstPlayer) then
		return;
	end
	
	pDstPlayer.CallClientScript({"Item.tbShiTuChuanSongFu:Msg2DstPlayer4Confirm_C", szDstPlayerName, szAppPlayerName});
end

-- C
function tb:Msg2DstPlayer4Confirm_C(szDstPlayerName, szAppPlayerName)
	CoreEventNotify(UiNotify.emCOREEVENT_CONFIRMATION, UiNotify.CONFIRMATION_TEACHER_CONVECTION, szDstPlayerName, szAppPlayerName);
end

-- GSͽȷϺ,bAcceptΪ(0.ܾ1.ͬ)
function tb:DstPlayerAccredit(szDstPlayerName, szAppPlayerName, bAccept)	
	local pStudent = GetPlayerObjFormRoleName(szDstPlayerName);
	if (not pStudent) then
		return;
	end
	if (bAccept ~= 1) then
		Item.tbShiTuChuanSongFu:Msg2Player_GS(szAppPlayerName, "Đồ đệ bạn không cần bạn qua đây! ");
		return;
	end
	
	local nMapId, nPosX, nPosY = pStudent.GetWorldPos();
	local nStudentFightState = pStudent.nFightState;
	local nCanSendIn  = Item:IsCallOutAtMap(nMapId, unpack(Item.tbShiTuChuanSongFu.ITEM_ID));
	if (nCanSendIn ~= 1) then
		nMapId = -1;
	end	
	
	-- ʦ
	GCExcute({"Item.tbShiTuChuanSongFu:AgreeTeacherComeHere_GC", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY,nStudentFightState});		
end
tb.tbc2sFun["DstPlayerAccredit"] = tb.DstPlayerAccredit;


-- GCʦ͵ָͼ
function tb:AgreeTeacherComeHere_GC(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState)
	GlobalExcute({"Item.tbShiTuChuanSongFu:AgreeTeacherComeHere_GS", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState});
end


-- GS յͽȷϴʦԴ
function tb:AgreeTeacherComeHere_GS(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState)
	local pPlayer = GetPlayerObjFormRoleName(szAppPlayerName);
	if (not pPlayer) then
		return;
	end
	local szDestStudent = pPlayer.GetTempTable("Item").szBeComeToSutdentName;
	if (not szDestStudent or szDestStudent ~= szDstPlayerName) then
		self:Msg2Player_GS(szDstPlayerName, "Sư đồ truyền tống đã quá hạn, nếu muốn truyền tống phải đăng ký lại.")
		pPlayer.Msg("Sư đồ truyền tống đã quá hạn, nếu muốn truyền tống phải đăng ký lại.");
		return;
	else
		pPlayer.GetTempTable("Item").szBeComeToSutdentName = nil;
	end
	if nMapId == -1 then
		pPlayer.Msg("Không thể đến được mục tiêu!");
		return 0;
	end
	local nRet, szMsg = Map:CheckTagServerPlayerCount(nMapId)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	local nCanSendOut = Item:IsCallInAtMap(nMapId, unpack(self.ITEM_ID));
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("Không được đến khu vực hiện tại!");
		return 0;
	end
	pPlayer.SetFightState(nStudentFightState);
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end

-- GSϢָ
function tb:Msg2Player_GS(szPlayerName, szMsg)
	GCExcute({"Item.tbShiTuChuanSongFu:Msg2Player_GC", szPlayerName, szMsg});	
end

-- GCϢָ
function tb:Msg2Player_GC(szPlayerName, szMsg)
	GlobalExcute({"Item.tbShiTuChuanSongFu:ReceiveMsg", szPlayerName,szMsg});
end

-- GSյ͸ĳҵϢ
function tb:ReceiveMsg(szPlayerName, szMsg)
	local pPlayer = GetPlayerObjFormRoleName(szPlayerName);
	if (not pPlayer) then
		return;
	end
	
	pPlayer.Msg(szMsg);
end

