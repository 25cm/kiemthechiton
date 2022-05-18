--江湖威望令牌--孙多良--2008.10.30
local tbItem = Item:GetClass("tienthaolo1h");
tbItem.TASKGROUP            = 3020;-- 人物任务变量的groupID
tbItem.TASKLASTTIME_ID        = 1;            -- 人物任务变量的最后时间保存的ID
tbItem.TASKREMAINTIME_ID    = 2;            -- 人物任务变量的剩余累积时间ID 单位：小时乘10
tbItem.SKILL_ID_EXP            = 332;            -- 332，经验加倍技能ID
tbItem.SKILL_ID_EXP_LEVEL    = 10;            -- Cấp độ của skill.Cấp 10 sẽ là + thêm 100% kinh nghiệm.Cấp 20 là cộng 200%(tương đương x3)

tbItem.tbEffect = {   
 [1] = 1;--(Thời gian hiệu nghiệm của thẻ.Đơn vị tính bằng Giờ)
}

function tbItem:OnUse()
    self:Update();
        local nRemainTime = self:GetRemainTime();
        local nExpSkillLevel, nExpStateType, nExpEndTime, bExpIsNoClearOnDeath            = me.GetSkillState(self.SKILL_ID_EXP);
        local nNewExpTime        = 0;
         if (not nExpEndTime) then 
           nExpEndTime = 0;
        end
        nRemainTime = nRemainTime - self.tbEffect[it.nLevel];
        nNewExpTime            = self.tbEffect[it.nLevel] * 18 * 3600 + nExpEndTime;
        me.AddSkillState(self.SKILL_ID_EXP, self.SKILL_ID_EXP_LEVEL, 1, nNewExpTime, 1);
       	   me.Msg(string.format("Bạn nhận được <color=yellow>%s giờ <color> nhân đôi kinh nghiệm.",self.tbEffect[it.nLevel]))    
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=green>Tiên Thảo Lộ (1 giờ)<color> nhận được <color=cyan>1 Giờ x2 Kinh Nghiệm<color><color>");	   

		   return 1;
end
function tbItem:Update()
    local nLastTime        = me.GetTask(self.TASKGROUP, self.TASKLASTTIME_ID);
    local nNowTime        = GetTime(); 
   local nDays            = self:CalculateDay(nLastTime, nNowTime); 
   local nRemainTime    = nDays * 1.5 + self:GetRemainTime();
    if (nRemainTime < 0.1) then        nRemainTime = 0;
    end
        if (nLastTime <= 0) then
        nRemainTime = 1.5;
    end
        me.SetTask(self.TASKGROUP, self.TASKLASTTIME_ID, nNowTime);    me.SetTask(self.TASKGROUP, self.TASKREMAINTIME_ID, nRemainTime * 10); -- 存的是小时的十倍
end
-- 计算离上次更新时间过了多少天
function tbItem:CalculateDay(nLastTime, nNowTime)
    local nLastDay     = Lib:GetLocalDay(nLastTime);
    local nNowDay    = Lib:GetLocalDay(nNowTime); 
   local nDays        = nNowDay - nLastDay;    if (nDays < 0) then
        nDays = 0; 
   end
    return nDays;
end
function tbItem:GetRemainTime() 
   return me.GetTask(self.TASKGROUP, self.TASKREMAINTIME_ID) / 10;
end  