local uiTeamPortrait = Ui(Ui.UI_TEAMPORTRAIT);
uiTeamPortrait.MENU_ITEM = { " Mật ", " Xem ",  " Giao dịch ", " Theo sau ", " Rời đội ", " Thêm bạn ", " Chuyển quyền ", " Trục xuất ", " Đi tới " };

local bShowLevel = 1
local nTimerId

local bak = uiTeamPortrait.HideTalk;

uiTeamPortrait.GetFactionShortName = function(self,nFact)
	local sRet
	if nFact == 1 then
		sRet = "TL"
	elseif nFact == 2 then
		sRet = "TV"
	elseif nFact == 3 then
		sRet = "ĐM"
	elseif nFact == 4 then
		sRet = "NĐ"
	elseif nFact == 5 then
		sRet = "NM"
	elseif nFact == 6 then
		sRet = "TY"
	elseif nFact == 7 then
		sRet = "CB"
	elseif nFact == 8 then
		sRet = "TN"
	elseif nFact == 9 then
		sRet = "VĐ"
	elseif nFact == 10 then
		sRet = "CL"
	elseif nFact == 11 then
		sRet = "MG"
	elseif nFact == 12 then
		sRet = "ĐT"
	else
		sRet = "xx"
	end
	return sRet
end

uiTeamPortrait.GetMapShortName = function(self,szMap)
	szMap = string.gsub(szMap, "Bàn Long Cốc Chiến", "BLCC");
	szMap = string.gsub(szMap, "Cửu Khúc Chiến", "CKC");
	szMap = string.gsub(szMap, "Phượng Tường", "PT");
	szMap = string.gsub(szMap, "Tiêu Dao Cốc", "TDC");
	szMap = string.gsub(szMap, "Phục Ngưu Sơn Quân Doanh", "PNS QD");
	szMap = string.gsub(szMap, "Báo Danh Chiến Trường", "BD CT");
	szMap = string.gsub(szMap, "Bạch Hổ Đường", "BHĐ");
	szMap = string.gsub(szMap, "Đấu trường môn phái", "ĐTMP");
	szMap = string.gsub(szMap, "Hải Lăng Vương Mộ", "HLVM");
	szMap = string.gsub(szMap, "Bách Man Sơn", "BMS");
	szMap = string.gsub(szMap, "Hậu Sơn Phục Ngưu", "HSPN");
	return szMap;
end

uiTeamPortrait.GetMemberBaseData = function(self)
	local tbMember = me.GetTeamMemberInfo()
	local nMemberCount = #tbMember;
	for i = 1, #self.PORTRAIT_WND do
		if tbMember[i] and tbMember[i].szName and tbMember[i].nPlayerID then
			self.m_tbPlayerId[i] = tbMember[i].nPlayerID;
			if tbMember[i].nPortrait then
				local szSpr = GetPortraitSpr(tbMember[i].nPortrait, tbMember[i].nSex, 1);
				Img_SetImage(self.UIGROUP, self.PORTRAIT_WND[i][2], 1, szSpr);
			end
			Prg_SetPos(self.UIGROUP, self.PORTRAIT_WND[i][3], tbMember[i].nCurLife / 100 * 1000);
			Prg_SetPos(self.UIGROUP, self.PORTRAIT_WND[i][4], tbMember[i].nCurMana / 100 * 1000);
			local szFaction = self:GetFactionShortName(tbMember[i].nFaction)
			local szName = ""
			if tbMember[i].nMapId > 10000 then
				szName = self:GetMapShortName(GetMapNameFormId(me.nTemplateMapId))
			else
				szName = self:GetMapShortName(GetMapNameFormId(tbMember[i].nMapId))
			end
			if (not szName) or (szName == "") then
				szName = tbMember[i].nMapId
			end
			Wnd_SetTip(self.UIGROUP, self.PORTRAIT_WND[i][2], string.format("%s %d tại %s", szFaction, tbMember[i].nLevel, szName));
			if tbMember[i].nOnline == 0 then
				Txt_SetTxtColor(self.UIGROUP, self.PORTRAIT_WND[i][5], 0xc0c0c0);
				Img_SetFrame(self.UIGROUP, self.PORTRAIT_WND[i][2], 1);
			else
				Txt_SetTxtColor(self.UIGROUP, self.PORTRAIT_WND[i][5], 0x80d0a0);
				Img_SetFrame(self.UIGROUP, self.PORTRAIT_WND[i][2], 0);
			end
			local szBuf
			if self.bShowLevel and self.bShowLevel == 0 then
				szBuf = string.format("%s",tbMember[i].szName);
			else
				szBuf = string.format("%s\n<bclr=blue><color=white>\n%s %d - %s",tbMember[i].szName, szFaction, tbMember[i].nLevel, szName);
			end
			if tbMember[i].nLeader == 1 then
				szBuf = "<bclr=red><color=orange>"..szBuf;
			end
			Txt_SetTxt(self.UIGROUP, self.PORTRAIT_WND[i][5], szBuf)
			if self.FACTION_FLAG[tbMember[i].nFaction] then
				Img_SetImage(self.UIGROUP, self.PORTRAIT_WND[i][6], 1, self.FACTION_FLAG[tbMember[i].nFaction]);
			else
				Img_SetImage(self.UIGROUP, self.PORTRAIT_WND[i][6], 1, "");
			end
			Wnd_Show(self.UIGROUP, self.PORTRAIT_WND[i][1]);
		else
			Txt_SetTxt(self.UIGROUP, self.PORTRAIT_WND[i][5], "");
			Wnd_Hide(self.UIGROUP, self.PORTRAIT_WND[i][1]);
		end
	end
	local tbZhenFa = me.GetZhenFaInfo();
	if (not tbZhenFa) then
		return;
	end;
	Wnd_SetPos(self.UIGROUP, self.ZHENFA_WND[1], 2, (nMemberCount + 1) * 34);
	Img_SetImage(self.UIGROUP, self.ZHENFA_WND[1], 1, self.ZHENGFA_SPR[tbZhenFa.nLevel + 1]);
	Wnd_Show(self.UIGROUP, self.ZHENFA_WND[1]);
end

uiTeamPortrait.OnPopUpMenu = function(self, szWnd, nParam)
	local nPlayer = nil;
	for i = 1, #self.PORTRAIT_WND do
		for j = 1, #self.PORTRAIT_WND[i] do
			if szWnd == self.PORTRAIT_WND[i][j] then
				nPlayer = i;
				break;
			end
		end
	end
	if (nPlayer) then
		local tbMember = me.GetTeamMemberInfo();
		if tbMember[nPlayer].nOnline ~= 0 then
			local tbRelationList, _ = me.Relation_GetRelationList();
			local tbFrined = tbRelationList[Player.emKPLAYERRELATION_TYPE_BIDFRIEND];
			local bFriend, bTeamLeader = 0, 0;
			if tbFrined then
				for szPlayer, _ in pairs(tbFrined) do
					if (tbMember[nPlayer].szName == szPlayer) then
						bFriend = 1;
					end
				end
			end

			local tbTmpFrined = tbRelationList[Player.emKPLAYERRELATION_TYPE_TMPFRIEND];
			if tbTmpFrined then
				for szPlayer, _ in pairs(tbTmpFrined) do
					if (tbMember[nPlayer].szName == szPlayer) then
						bFriend = 1;
					end
				end
			end
			if (self:IsTeamLeader() == 1)  then
					bTeamLeader = 1;
			end
			self.tbMenuFun[9] = tbMember[nPlayer];
			if (bFriend == 0) and (bTeamLeader == 0) then
				self.tbMenuFun[6] = {self.CmdAddFriend}
				self.tbMenuFun[7] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 7, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[6], 6,
					self.MENU_ITEM[9], 7
				);
			end
			if (bFriend == 0) and (bTeamLeader == 1) then
				self.tbMenuFun[6] = {self.CmdAddFriend}
				self.tbMenuFun[7] = {self.CmdChangeLeader}
				self.tbMenuFun[8] = {self.CmdKickOut}
				self.tbMenuFun[10] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 9, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[6], 6,
					self.MENU_ITEM[7], 7,
					self.MENU_ITEM[8], 8,
					self.MENU_ITEM[9], 9
				);
			end
			if (bFriend == 1) and (bTeamLeader == 0) then
				self.tbMenuFun[6] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 6, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[9], 6
				);
			end
			if (bFriend == 1) and (bTeamLeader == 1) then
				self.tbMenuFun[6] = {self.CmdChangeLeader}
				self.tbMenuFun[7] = {self.CmdKickOut}
				self.tbMenuFun[8] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 8, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[7], 6,
					self.MENU_ITEM[8], 7,
					self.MENU_ITEM[9], 8
				);
			end
		end
	end
end

function uiTeamPortrait:OnMenuItemSelected(szWnd, nItemId, nListIndex)
	if nItemId and nItemId <= #self.MENU_ITEM then
		if self.tbMenuFun[nItemId] then
			if nItemId<9 then
				self.tbMenuFun[nItemId][1](self, self.tbMenuFun[9]);
			else
				self.Runto(self, self.tbMenuFun[9])
			end
		end
	end
end

uiTeamPortrait.Runto=function(self,mPlayer)
	if UiManager:WindowVisible(Ui.UI_FIGHTSKILL) == 1 then
		return 0
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	me.Msg("<color=yellow>Bắt đầu đi tới...")
	if me.nMapId == mPlayer.nMapId then
		for i, tbNpcInfo in ipairs(SyncNpcInfo() or {}) do
			if tbNpcInfo.szName == mPlayer.szName then
				me.StartAutoPath(tbNpcInfo.nX/2, tbNpcInfo.nY)
				break
			end
		end
	else
		Map.tbSuperMapLink:StartGoto({szType = "pos",szLink = "AT,"..mPlayer.nMapId..",100,100"});
	end
end

uiTeamPortrait.HideTalk=function(self)
	self:GetMemberBaseData();
	bak(self);
end

uiTeamPortrait.MinProtraitWindow=function(self)
	if self.m_bHidePortrait == 1 then
		Wnd_Show(self.UIGROUP, self.PORTRAIT_WINDOW);
		self.m_bHidePortrait = 0;
		if self.bShowLevel then
			if self.bShowLevel == 1 then
				self.bShowLevel = 0
			else
				self.bShowLevel = 1
			end
			self.GetMemberBaseData(self)
		else
			self.bShowLevel = 1
		end
		if self.bShowLevel and self.bShowLevel == 1 then
			self.nTimerId = Ui.tbLogic.tbTimer:Register(30, self.GetMemberBaseData, self);
		end
	else
		Wnd_Hide(self.UIGROUP, self.PORTRAIT_WINDOW);
		self.m_bHidePortrait = 1;
		Ui.tbLogic.tbTimer:Close(self.nTimerId);
	end
end

function uiTeamPortrait:Reload()
	AutoAi:DoScript("\\interface\\btssl_teamportrait\\script\\window\\teamportrait.lua");
	me.Msg("<color=green>Team Portrait Reloaded!! " .. GetLocalDate("%Y%m%d %H:%M:%S"));
end
