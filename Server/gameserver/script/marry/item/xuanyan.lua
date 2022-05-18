-------------------------------------------------------
-- 文件名　：xuanyan.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-01-21 10:16:33
-- 文件描述：
-------------------------------------------------------

local tbItem = Item:GetClass("marry_xuanyan");

tbItem.CD_TIME = 300;
tbItem.SYS_TEXT = 
{
	[1] = "Chúng ta đang ở xa cách nhau, anh sẽ không bao giờ quên được em và anh rất nhớ em.",
	[2] = "Anh cứ nhắm mắt lại là lại nhớ về em. Em yêu của anh.",
	[3] = "Không thể là bạn bè sau khi chia tay, vì hai bên bị tổn thương. Không thể làm kẻ thù, bởi vì yêu thương nhau, vì vậy chúng tôi trở thành những người xa lạ quen thuộc nhất.",
	[4] = "Em là linh hồn của anh, anh sẽ nguyện trao cả trái tim anh cho em.",
	[5] = "Tình yêu, Anh sẽ  yêu em mãi mãi,làm cho em luôn luôn vui tươi và hạnh phúc!",
	[6] = "Anh sẽ ở bên cạnh em,Em là duy nhất của anh trong hiện tại,tương lai và mãi mãi.",
	[7] = "Anh muốn cả thế giới này biết Anh yêu em. Anh sẵn sàng hy sinh vì em, bảo vệ em mãi mãi. Anh muốn em sẽ là người phụ nữ hạnh phúc nhất!",
};

function tbItem:CanUse()
	
	local tbMemberList, nMemberCount = me.GetTeamMemberList();
	local szErrMsg = "";
	if not tbMemberList or nMemberCount ~= 2 then
		szErrMsg = "Một nam, một nữ tổ đội nhau mới có thể sử dụng đạo cụ này.";
		return 0, szErrMsg;
	end
	
	local pTeamMate = nil;
	for _, pMember in pairs(tbMemberList) do
		if pMember.szName ~= me.szName then
			pTeamMate = pMember;
		end
	end
	
	if not pTeamMate then
		return 0, szErrMsg;
	end
	
	if me.nSex == pTeamMate.nSex then
		szErrMsg = "Giới tính không đúng.";
		return 0, szErrMsg;
	end
		
	local nNearby = 0;
	local tbPlayerList = KPlayer.GetAroundPlayerList(me.nId, 50);
	if tbPlayerList then
		for _, pPlayer in ipairs(tbPlayerList) do
			if pPlayer.szName == pTeamMate.szName then
				nNearby = 1;
			end
		end
	end
	
	if nNearby ~= 1 then
		szErrMsg = "Bạn đang ở quá xa, gần một chút nữa hơn";
		return 0, szErrMsg;
	end
	
	return 1;
end

function tbItem:OnUse()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local bCanUse, szErrMsg = self:CanUse();
	if bCanUse ~= 1 then
		if ("" ~= szErrMsg) then
			me.Msg(szErrMsg);
		end
		return 0;
	end
	
	local tbOpt = {};
	local szMsg = "Hãy cho cả thế giới biết bạn định nói gì với người ấy :";
	local dwItemId = it.dwId;
	for nIndex, szText in ipairs(self.SYS_TEXT) do
		table.insert(tbOpt, {szText, self.SendMsg, self, nIndex, dwItemId});
	end
	
	table.insert(tbOpt, {"Tôi sẽ cố gắng suy nghĩ"});
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:SendMsg(nIndex, dwItemId)
	local pItem = KItem.GetObjById(dwItemId);
	if (not pItem) then
		return 0;
	end
	
	local tbMemberList, nMemberCount = me.GetTeamMemberList();
	if not tbMemberList or nMemberCount ~= 2 then
		return 0;
	end
	
	local pTeamMate = nil;
	for _, pMember in pairs(tbMemberList) do
		if pMember.szName ~= me.szName then
			pTeamMate = pMember;
		end
	end
	
	if not pTeamMate then
		return 0;
	end
	
	local szMsg = string.format("<color=green>[%s]<color> nói với <color=green>[%s]<color> : <color=gold>%s<color>", me.szName, pTeamMate.szName, self.SYS_TEXT[nIndex]);
	self:BroadcastMsg(szMsg, me, pTeamMate);
	pItem.Delete(me);
	me.SetTask(Marry.TASK_GROUP_ID, Marry.TASK_TIME_XUANYAN, GetTime());
end

function tbItem:BroadcastMsg(szMsg, pAppPlayer, pDstPlayer)
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT, szMsg, 20);
	pAppPlayer.Msg(szMsg);
	pDstPlayer.Msg(szMsg);
end
