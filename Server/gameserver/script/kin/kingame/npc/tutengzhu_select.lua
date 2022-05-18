local tbNpc = Npc:GetClass("tulengzhu_select")

function tbNpc:OnDialog()
	self:EnterRoom(him.dwId, 0);
end

local tbInfo =
{
	[26] = "Thây ma đang nắm giữ thuốc giải bên trong...";
	[27] = "Dùng thuốc có thể chữa lành, nhưng ngươi phải vượt qua được chính mình.";
}

function tbNpc:EnterRoom(nNpcId, nSure)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0
	end	
	local tbTmp = pNpc.GetTempTable("KinGame");
	local pRoom = tbTmp.tbLockTable.tbRoom;
	local nRoomId = pRoom.nRoomId;
	
	if nRoomId == 26 or nRoomId == 27 then
		Dialog:Say(tbInfo[nRoomId])
		return 0;
	end
	
	local pGame =  KinGame:GetGameObjByMapId(pNpc.nMapId) --ö
	local pRoom24 = pGame.tbRoom[26];	--Ϣ
	if pRoom24:IsLock() == 1 then
		--ѿֱ
		return 0;
	end
	local nCountMax = pGame:GetPlayerCount(0);
	local nCanPass = math.ceil(nCountMax / 3);
	local szMsg = "";
	local nCount = 0;
	if nRoomId == 4 then
		nCount = pGame:GetLeftPlayerCount();
	elseif nRoomId == 5 then
		nCount = pGame:GetMidPlayerCount();
	elseif nRoomId == 6 then
		nCount = pGame:GetRightPlayerCount();
	end
	if nCanPass - nCount <= 0 then
		szMsg = "Xem xung quanh, tìm thấy hòn đá đã bị chặn tất cả các ánh sáng phía trước, không biết làm thế nào.";
		Dialog:Say(szMsg)
	else
		szMsg = string.format("Chữ khắc trên đá: cần <color=red>%s xu<color> để đi vào.", nCanPass - nCount);
		Dialog:Say(szMsg)
	end
end
