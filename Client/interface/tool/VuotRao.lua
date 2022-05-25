----------------------------
--HPNS
----------------------------
local VuotRaoHS = Ui.VuotRaoHS or {};
Ui.VuotRaoHS = VuotRaoHS;

function VuotRaoHS:JumpSwitch()
    if (me.GetMapTemplateId()  < 65500) then
        -- me.Msg("<bclr=blue><color=white>Vượt rào Hậu Sơn Phục Ngưu Sơn")
        -- me.Msg("<bclr=blue><color=white>Chức năng này chỉ hoạt động trong Hậu Sơn Phục Ngưu Sơn")
        UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hậu Phục Ngưu Sơn<color>");
        return;
    end
    if (self.JumpTimerId and self.JumpTimerId > 0) then
        -- me.Msg("<bclr=blue><color=white>Ngừng tự động vượt rào ở Hậu Sơn Phục Ngưu")
        UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ngừng tự động vượt rào ở Hậu Sơn Phục Ngưu<color>");
        Timer:Close(self.JumpTimerId);
        self.JumpTimerId = 0;
        return;
    end
    me.Msg("<bclr=red><color=yellow>Bắt đầu vượt rào Hậu Sơn...<color>")
    UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu vượt rào Hậu Sơn...<color>");
    self.JumpTimerId = Timer:Register(Env.GAME_FPS*2, self.Jump, self);
end

function VuotRaoHS:Jump()
    local x,y,world = me.GetNpc().GetMpsPos();
    local mx = math.floor(x/32);
    local my = math.floor(y/32);
    if mx <= 1702 and my >= 3463 then
        if mx == 1700 and my == 3471 then
            if me.GetNpc().IsRideHorse() == 1 then
                Switch([[horse]]);    -- xuống ngựa
            end
            local ScrPosX, ScrPosY = self:GetScreenPos(54691,110736,x,y);
            me.UseSkill(10,ScrPosX,ScrPosY);
        else
            me.StartAutoPath(1700,3471);
        end

    elseif mx >= 1682 and mx <= 1718 and my <= 3467 and my >= 3424 then
        if my <= 3433 then
            local ScrPosX, ScrPosY = self:GetScreenPos(53799,109140,x,y);
            me.UseSkill(10,ScrPosX,ScrPosY);
        else
            AutoAi.AiAutoMoveTo(1685,3428);
        end

    elseif mx >= 1679 and mx <= 1685 and my <= 3418 and my >= 3395 then
        if my <= 3409 then
            local ScrPosX, ScrPosY = self:GetScreenPos(53626,108581,x,y);
            me.UseSkill(10,ScrPosX,ScrPosY);
        else
            AutoAi.AiAutoMoveTo(1680,3405);
        end
    elseif mx >= 1669 and mx <= 1681 and my <= 3403 and my >= 3384 then
        if my <= 3400 then
            local ScrPosX, ScrPosY = self:GetScreenPos(53531,108002,x,y);
            me.UseSkill(10,ScrPosX,ScrPosY);
        else
            AutoAi.AiAutoMoveTo(1675,3393);
        end

    elseif mx >= 1669 and mx <= 1680 and my <= 3384 and my >= 3357 then
        if my <= 3366 then
            local ScrPosX, ScrPosY = self:GetScreenPos(53874,106947,x,y);
            me.UseSkill(10,ScrPosX,ScrPosY);
        else
            AutoAi.AiAutoMoveTo(1678,3360);
        end

    elseif mx >= 1680 and my <= 3351 then
        if me.GetNpc().IsRideHorse() == 0 then
            Switch([[horse]]);    -- lên ngựa
        end
        if mx == 1714 and my == 3274 then
            me.Msg("<bclr=red><color=white>Vuợt rào Hậu Sơn hoàn thành !");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Vượt rào Hậu Sơn hoàn thành !<color>");
            Timer:Close(self.JumpTimerId);
            self.JumpTimerId = 0;
        else
            me.StartAutoPath(1714,3274);
        end
    end
end
--Lấy tọa độ màn hình
function VuotRaoHS:GetScreenPos(x,y,mx,my)
    local ScreenPos = {};
    local nResolution = GetUiMode();
    if nResolution == "a" then
        ScreenPos.x = 400-(mx - x)*1.04;
        ScreenPos.y = 300-(my - y)*0.5;
    elseif nResolution == "b" then
        ScreenPos.x = 512-(mx - x)*1.047;
        ScreenPos.y = 384-(my - y)*0.525;
    elseif nResolution == "c" then
        ScreenPos.x = 640-(mx - x)*1.004;
        ScreenPos.y = 400-(my - y)*0.497;
    end
    return math.floor(ScreenPos.x),math.floor(ScreenPos.y);
end
