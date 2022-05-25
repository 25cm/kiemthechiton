local uiWorldMap_Sub	= Ui(Ui.UI_WORLDMAP_SUB);
local tbMapBar			= Ui.tbLogic.tbMapBar;
local tbMap				= Ui.tbLogic.tbMap;
local tbTimer 			= Ui.tbLogic.tbTimer;

uiWorldMap_Sub.IMAGE_SUBMAP                = "ImgSubMap";
uiWorldMap_Sub.IMAGE_MARK                = "ImgMark";
uiWorldMap_Sub.COMBOBOX_WORLDMAP        = "ComboxSub";
uiWorldMap_Sub.IMAGE_FRAME                = "ImgSubFrame";
uiWorldMap_Sub.BTN_CLOSE                = "BtnClose";
uiWorldMap_Sub.TXT_AREA                    = "TxtArea";
uiWorldMap_Sub.BTN_WORLDMAP_GlOBAL       = "BtnWorldMap_Global";
uiWorldMap_Sub.BTN_WORLDMAP_AREA           = "BtnWorldMap_Area";
uiWorldMap_Sub.BTN_DOMAIN                = "BtnWorldMap_Domain";

uiWorldMap_Sub.IMAGE_SUBMAP_WIDTH       = 789;
uiWorldMap_Sub.IMAGE_SUBMAP_HEIGHT      = 534;
uiWorldMap_Sub.IMAGE_MARK_HALF_WIDTH    = 18;
uiWorldMap_Sub.IMAGE_MARK_HALF_HEIGHT    = 34;
uiWorldMap_Sub.POINTSPRPATH                = "\\image\\ui\\001a\\minimap\\"
uiWorldMap_Sub.FLAGSPRPATH                = "\\image\\ui\\001a\\minimap\\mark_flag.spr"
uiWorldMap_Sub.WORLDMAPSETPATH            = "worldmap\\player.txt"
uiWorldMap_Sub.NOAREAMAPSETPATH            = "worldmap\\no_area_map.txt"
uiWorldMap_Sub.AREAMAPSETPATH            = "worldmap\\npcsetting\\";
uiWorldMap_Sub.RESETTIME                = 18 * 4;        -- TODO: 地图拖动复原的时间间隔
uiWorldMap_Sub.TEAMMATETIME                = 18 / 2;        -- 地图上人物刷新时间
uiWorldMap_Sub.NPCCOLORPATH                = "worldmap\\npc_color.txt";

uiWorldMap_Sub.TXT_CURPOS                = "TxtCurPos";
uiWorldMap_Sub.BTN_AUTOPATH                = "BtnAutoPath";
uiWorldMap_Sub.Edt_PosX                    = "EdtPosX";
uiWorldMap_Sub.Edt_PosY                    = "EdtPosY";
uiWorldMap_Sub.Edt_MapName                = "EdtMapName";
uiWorldMap_Sub.Btn_Search                = "BtnSearch";

function uiWorldMap_Sub:ReadNpcInfo(szMapName)
    local szFile = GetActualPath(szMapName);
    local pTabFile = KIo.OpenTabFile(szFile);
    if (not pTabFile) then
        Ui:Output("[ERR] uiWorldMap_Sub NPC配置路径不正确: "..szFile);
        return 0;
    end
    local nHeight = pTabFile.GetHeight();
    for i = 2, nHeight do
        local nId             = pTabFile.GetInt(i, 1);
        local szImagePos     = pTabFile.GetStr(i, 2);
        local szName        = pTabFile.GetStr(i, 3);
        local nFont         = pTabFile.GetInt(i, 4);
        local szColor        = pTabFile.GetStr(i, 5);
        local szSprPath        = pTabFile.GetStr(i, 6);
        local szTextPos        = pTabFile.GetStr(i, 7);
        local _, _, nImgPosX, nImgPosY = string.find(szImagePos, "(%d+),(%d+)")
        local _, _, nTextPosX, nTextPosY = string.find(szTextPos, "(%d+),(%d+)")
        nImgPosX = tonumber(nImgPosX) or 0;
        nImgPosY = tonumber(nImgPosY) or 0;
        nTextPosX = tonumber(nTextPosX) or 0;
        nTextPosY = tonumber(nTextPosY) or 0;
        table.insert(self.tbNpcInfo, { nImgPosX, nImgPosY, szName, nFont, szColor, szSprPath, nTextPosX, nTextPosY });
         end
    KIo.CloseTabFile(pTabFile); 
    return 1;
end



function uiWorldMap_Sub:OnOpen(nMapId)
	self.tbTreaMapInfo		= {};
	self.tbTreaCanvasId		= {};
	self.tbWantedInfo			= {};
	self.tbWantedCanvas	  = {};
	self.CurShowMapId = nMapId;
	self.nMapControlId = tbMap:CreateMapControl(self.CurShowMapId, self.UIGROUP, self.IMAGE_FRAME, self.IMAGE_SUBMAP, self.IMAGE_MARK);
	if self.nMapControlId and (self.nMapControlId ~= 0)then
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		if (not MODULE_GAMESERVER) then
			nCurMapId = me.nTemplateMapId;
		end
		if (nMapId == nCurMapId) then
			self.bCurMap = 1;
			Wnd_Show(self.UIGROUP, self.IMAGE_MARK);
			tbMap:InitControl(self.nMapControlId, 1);
			tbMap:ChangePos(self.nMapControlId, nWorldPosX, nWorldPosY);
		else
			tbMap:InitControl(self.nMapControlId, 0);
			Wnd_Hide(self.UIGROUP, self.IMAGE_MARK);
		end
	end

	local szMapName, szMapPath = GetMapPath(nMapId);
	local bReadSuccess = self:ReadNpcInfo(self.AREAMAPSETPATH..nMapId..".txt"); -- TODO: 取得地图所对应的配置文件
	self.nFlagWidth, self.nFlagHeight = Canvas_GetImageSize(self.UIGROUP, self.IMAGE_SUBMAP, self.FLAGSPRPATH);

if bReadSuccess then
	for i = 1, #self.tbNpcInfo do
		local szSprPath = self.POINTSPRPATH..self.tbNpcInfo[i][6];
		local nImageWidth, nImageHeight = Canvas_GetImageSize(self.UIGROUP, self.IMAGE_SUBMAP, szSprPath);
		self.tbCanvasId[i] = {};
	if self.tbNpcInfo[i][1] > 0 and self.tbNpcInfo[i][2] > 0 then
		local nImagePosX = self.tbNpcInfo[i][1] - nImageWidth / 2;
		local nImagePosY = self.tbNpcInfo[i][2] - nImageHeight / 2;
		local nImageId = Canvas_CreateImage(self.UIGROUP, self.IMAGE_SUBMAP, nImagePosX, nImagePosY, szSprPath, 1);
		self.tbCanvasId[i][1] = nImageId;
	end	
		local nFontSize = self.tbNpcInfo[i][4];
		local szText = self.tbNpcInfo[i][3];
	if self.tbNpcInfo[i][7] > 0 and self.tbNpcInfo[i][8] > 0 then
		local nTextPosX = self.tbNpcInfo[i][7] - (nFontSize * #szText) / 4;	-- TODO: 把中心X坐标转换成左上角绘制X坐标
		local nTextPosY = self.tbNpcInfo[i][8] - nFontSize / 2;				-- TODO: 把中心Y坐标转换成左上角绘制Y坐标
		local nTextId = Canvas_CreateText(self.UIGROUP, self.IMAGE_SUBMAP, nFontSize, szText, self.tbNpcInfo[i][5], nTextPosX, nTextPosY);
		self.tbCanvasId[i][2] = nTextId;
	end
	end
end

	local bReadTreaPos	= self:ReadTreaMapInfo();
	if bReadTreaPos then
		if self.tbTreaMapInfo[nMapId] then
			for i = 1, #self.tbTreaMapInfo[nMapId] do
				local szText 				= self.tbTreaMapInfo[nMapId][i][3];
				local nMapPosX 				= self.tbTreaMapInfo[nMapId][i][1];
				local nMapPosY 				= self.tbTreaMapInfo[nMapId][i][2];
				local nTextPosX, nTextPosY	= tbMap:WorldPosToImgPos(self.nMapControlId, nMapPosX, nMapPosY);
				local nImageId = Canvas_CreateImage(self.UIGROUP, self.IMAGE_SUBMAP, nTextPosX, nTextPosY, self.POINTSPRPATH.."yellowpoint.spr", 1);
				local absTxtPosX = nTextPosX - ((12 / 2) * (string.len(szText) / 2));
				local absTxtPosY = nTextPosY + (12 / 2) + 5;
				local nTextId = Canvas_CreateText(self.UIGROUP, self.IMAGE_SUBMAP, 12, szText, "green", absTxtPosX, absTxtPosY);
				if not self.tbTreaCanvasId[nMapId] then
					self.tbTreaCanvasId[nMapId] = {};
				end;
				table.insert(self.tbTreaCanvasId[nMapId],	{nImageId, nTextId});
			end;
		end;
	end

	local bReadWantedPos = self:ReadWantedInfo();
	if bReadWantedPos then
		if self.tbWantedInfo[nMapId] then
			for i = 1, #self.tbWantedInfo[nMapId] do
				local szText 				= self.tbWantedInfo[nMapId][i][3];
				local nMapPosX 				= self.tbWantedInfo[nMapId][i][1];
				local nMapPosY 				= self.tbWantedInfo[nMapId][i][2];
				local nTextPosX, nTextPosY	= tbMap:WorldPosToImgPos(self.nMapControlId, nMapPosX, nMapPosY);
				local nImageId = Canvas_CreateImage(self.UIGROUP, self.IMAGE_SUBMAP, nTextPosX, nTextPosY, self.POINTSPRPATH.."yellowpoint.spr", 1);
				local absTxtPosX = nTextPosX - ((12 / 2) * (string.len(szText) / 2));
				local absTxtPosY = nTextPosY + (12 / 2) + 5;
				local nTextId = Canvas_CreateText(self.UIGROUP, self.IMAGE_SUBMAP, 12, szText, self.tbWantedInfo[nMapId][i][4], absTxtPosX, absTxtPosY);
				if not self.tbWantedCanvas[nMapId] then
					self.tbWantedCanvas[nMapId] = {};
				end;
				table.insert(self.tbWantedCanvas[nMapId],	{nImageId, nTextId});
			end;
		end;
	end


	self:ReadWorldMap(self.WORLDMAPSETPATH);
	self:ReadNpcColor(self.NPCCOLORPATH);

	self:ReadNoAreaMapId(self.NOAREAMAPSETPATH);
	Wnd_SetEnable(self.UIGROUP, self.BTN_WORLDMAP_AREA, 1);
	Wnd_SetEnable(self.UIGROUP, self.BTN_WORLDMAP_GlOBAL, 1);

	if self.tbNoAreaMapId then
		for i = 1, #self.tbNoAreaMapId do
			if nMapId == self.tbNoAreaMapId[i] then
				Wnd_SetEnable(self.UIGROUP, self.BTN_WORLDMAP_AREA, 0);
				Wnd_SetEnable(self.UIGROUP, self.BTN_WORLDMAP_GlOBAL, 0);
				break;
			end
		end
	end
	local szMapName, szCountry = self:GetMapNameByMapId(nMapId);
	Txt_SetTxt(self.UIGROUP, self.TXT_AREA, szMapName);
	tbMapBar:SetCurText(szCountry);
	tbMapBar:FillComboBox(self.UIGROUP, self.COMBOBOX_WORLDMAP);

	local nDestX, nDestY = me.GetCurAutoPath();
	if (nDestX) then
		self:DrawFlag(nDestX, nDestY);
	end

	if self.bCurMap == 1 then
		self.nTeamTimerId = tbTimer:Register(self.TEAMMATETIME, self.OnTimerTeam, self);
	end
	self:Sync_Position();
end

function uiWorldMap_Sub:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_SYNC_POSITION,		self.Sync_Position },
		{ UiNotify.emCOREEVENT_SYNC_CURRENTMAP,		self.Change_Map },
		{ UiNotify.emCOREEVENT_STOP_AUTOPATH,		self.ClearFlagAndLine },
		{ UiNotify.emCOREEVENT_START_AUTOPATH,		self.StartAutoPath },
	};
	return tbRegEvent;
end


uiWorldMap_Sub.ReadTreaMapInfo = function(self)
	local pTabFile = KIo.OpenTabFile("\\setting\\task\\treasuremap\\treasuremap_pos.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 2, nHeight do
		local nTreaMapId 	= pTabFile.GetInt(i, 4);
		local nTreaPosX 	= pTabFile.GetInt(i, 5);
		local nTreaPosY		= pTabFile.GetInt(i, 6);
		local szTextPos		= pTabFile.GetStr(i, 7);
		if not self.tbTreaMapInfo[nTreaMapId] then
			self.tbTreaMapInfo[nTreaMapId] = {};
		end;
		table.insert(self.tbTreaMapInfo[nTreaMapId], {nTreaPosX, nTreaPosY, szTextPos});
	end
	KIo.CloseTabFile(pTabFile);
	return 1;
end

uiWorldMap_Sub.ReadWantedInfo = function(self)
	local pTabFile = KIo.OpenTabFile("\\interface\\setting\\map\\worldmap.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local nTreaMapId 	= pTabFile.GetInt(i, 4);
		local nTreaPosX 	= pTabFile.GetInt(i, 5);
		local nTreaPosY		= pTabFile.GetInt(i, 6);
		local szTextPos		= pTabFile.GetStr(i, 2);
		local szColor	    = pTabFile.GetStr(i, 11);
		if not self.tbWantedInfo[nTreaMapId] then
			self.tbWantedInfo[nTreaMapId] = {};
		end;
		table.insert(self.tbWantedInfo[nTreaMapId], {nTreaPosX, nTreaPosY, szTextPos,szColor});
	end
	KIo.CloseTabFile(pTabFile);
	return 1;
end

local _Fn_BackUp = uiWorldMap_Sub.OnClose;

uiWorldMap_Sub.OnClose = function(self)
	_Fn_BackUp(self);
	for i, tbTreaCon in pairs(self.tbTreaCanvasId) do
		for j=1, #tbTreaCon do
			Canvas_DestroyImage(self.UIGROUP, self.IMAGE_SUBMAP, tbTreaCon[j][1]);
			Canvas_DestroyText(self.UIGROUP, self.IMAGE_SUBMAP, tbTreaCon[j][2]);
		end;
	end
	
	for i, tbTreaCon2 in pairs(self.tbWantedCanvas) do
		for j=1, #tbTreaCon2 do
			Canvas_DestroyImage(self.UIGROUP, self.IMAGE_SUBMAP, tbTreaCon2[j][1]);
			Canvas_DestroyText(self.UIGROUP, self.IMAGE_SUBMAP, tbTreaCon2[j][2]);
		end;
	end
end;

uiWorldMap_Sub.ShowPlayerInfo=function(self)
    if self.bDisable == 1 then
        return
    end
    local tbNpc, tbFriend;
    local nFontId = 12;
    tbNpc = SyncNpcInfo();
    local tbAroundNpc    = KNpc.GetAroundNpcList(me, 1000);
        for i, pNpc in ipairs(tbAroundNpc) do
            local nTemplateId1=pNpc.nTemplateId;
            if (nTemplateId1==2703) then
                AutoAi.SetTargetIndex(pNpc.nIndex);
                break;
            end
            if nTemplateId1==3303 then
            if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS)==1 then return end
                AutoAi.SetTargetIndex(pNpc.nIndex);
            end
            if nTemplateId1==2701 then
                AutoAi.SetTargetIndex(pNpc.nIndex);
                break;
            end
            if nTemplateId1==2680 then
            if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS)==1 then return end
                AutoAi.SetTargetIndex(pNpc.nIndex)
            end
            if nTemplateId1==2700 then
                if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
                else
                    AutoAi.SetTargetIndex(pNpc.nIndex);
                end
                break;
            end
        end
    if tbNpc then
        for i, tbNpcInfo in ipairs(tbNpc) do
            if tbNpcInfo then
                local nPosX, nPosY = tbMap:WorldPosToImgPos(self.nMapControlId, tbNpcInfo.nX / 2, tbNpcInfo.nY);
                if tbNpcInfo.szName then -- 队友
                    local absTxtPosX = nPosX - ((nFontId / 2) * (string.len(tbNpcInfo.szName) / 2)) / 2;
                    local absTxtPosY = nPosY + (nFontId / 2);
                    local nTextId = Canvas_CreateText(self.UIGROUP, self.IMAGE_SUBMAP, nFontId, tbNpcInfo.szName, self.tbNpcColor[0], absTxtPosX, absTxtPosY);
                    local nPointId = Canvas_CreatePoint(self.UIGROUP, self.IMAGE_SUBMAP, self.tbNpcColor[0], nPosX, nPosY);
                    self.tbTeamMatePoint[#self.tbTeamMatePoint + 1] = { nPointId, nTextId };
                else
                        local nPointId = Canvas_CreatePoint(self.UIGROUP, self.IMAGE_SUBMAP, self.tbNpcColor[tbNpcInfo.nType], nPosX, nPosY);
                        self.tbPlayerPoint[#self.tbPlayerPoint + 1] = nPointId;
                end
            end
        end
    end
end
