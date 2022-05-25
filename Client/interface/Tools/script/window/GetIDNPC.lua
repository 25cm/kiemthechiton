local self = tbGetIdNpc;

local tbGetIdNpc    = Map.tbGetIdNpc or {};
Map.tbGetIdNpc        = tbGetIdNpc;
local CountThat = 0;

local tCmd={ "Map.tbGetIdNpc:GetIdNpcSwitch()", "GetIdNpcSwitch", "", "Alt+Shift+1", "Alt+Shift+1", "GetIdNpcSwitch" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--£ºAlt+Shift+1

function tbGetIdNpc:GetIdNpcSwitch()
    local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
    me.Msg(nMyMapId..","..nMyPosX..","..nMyPosY.."<color=lightblue>  "..(nMyPosX*32)..","..(nMyPosY*32));
    for i=1, 7000 do
        CountThat = CountThat +1;
        local nId = self:GetAroundNpcId(CountThat);
        if nId then
            local nCurMapId  = me.GetWorldPos();
            local szInfoFile = Map.tbSuperMapLink.tbAllMapInfo[nCurMapId].szInfoFile;
            local tbFileData = Lib:LoadTabFile("\\setting\\map\\map_info\\" .. szInfoFile .. "\\info.txt");
            for nRowNum, tbRow in ipairs(tbFileData or {}) do
                if (tbRow.NpcTemplateId == ""..CountThat.."") then
                    local bSuccess = me.Msg("<color=white>"..tbRow.NpcName.."<color=yellow>  "..CountThat);
                    break;
                end
            end
        end
    end
    CountThat = 0;
end

function tbGetIdNpc:GetAroundNpcId(nTempId)
    local tbAroundNpc    = KNpc.GetAroundNpcList(me, 10);
    for _, pNpc in ipairs(tbAroundNpc) do
        if (pNpc.nTemplateId == nTempId) then
            return pNpc.nIndex
        end
    end
    return
end
