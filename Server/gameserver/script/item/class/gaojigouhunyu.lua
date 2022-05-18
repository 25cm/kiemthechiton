--ٟܶٴܪԱ
--sunduoliang
--2008.10.30

local tbItem = Item:GetClass("gaojigouhunyu");
tbItem.tbBoss = 
{
--ֈܶ
['boss'] = {
--bossĻԆìIdìϥѐ
--{"[120] Tần Thủy Hoàng-Tử Vi", 2426 , 0,120},

{"[95] <color=gold>Nhu Tiểu Thúy (Kim)<color>", 2934 , 1,95},
{"[95] <color=green>Trương Thiện Đức (Mộc)<color>",2935, 2,95},
{"[95] <color=blue>Cổ Dật Sơn (Thủy)<color>",2936, 3,95},
{"[95] <color=red>Ô Thanh Sơn (Hỏa)<color>",2937, 4,95},
{"[95] <color=wheat>Trần Vô Mệnh (Thổ)<color>",2938, 5,95},

--{"[75] <color=gold>Thần Thương Phương Vãn (Kim)<color>",2407, 1,75},
--{"[75] <color=green>Triệu Ứng Tiên (Mộc)<color>",2408, 2,75},
--{"[75] <color=blue>Hương Ngọc Tiên (Thủy)<color>",2409, 3,75},
--{"[75] <color=red>Man Tăng Bất Giới Hòa Thượng (Hỏa)<color>",2410, 4,75},
--{"[75] <color=wheat>Nam Quách Nho (Thổ)<color>",2411, 5,75},

--{"[55] <color=gold>Thác Bạc Sơn Xuyên (Kim)<color>",2405, 1,55},
--{"[55] <color=green>Vân Tuyết Sơn (Mộc)<color>", 2401 , 2,55},
--{"[55] <color=blue>Dương Liễu (Thủy)<color>", 2406 , 3,55},
--{"[55] <color=red>Vạn Lão Điên (Hỏa)<color>",2403, 4,55},
--{"[55] <color=wheat>Cao Sĩ Hiền (Thổ)<color>",2404, 5,55},
--{"[55] <color=wheat>Hình Bộ Đầu (Thổ)<color>",2402, 5,55},
}
}

local tbEvent = 
{
Player.ProcessBreakEvent.emEVENT_MOVE,
Player.ProcessBreakEvent.emEVENT_ATTACK,
Player.ProcessBreakEvent.emEVENT_SITE,
Player.ProcessBreakEvent.emEVENT_USEITEM,
Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
Player.ProcessBreakEvent.emEVENT_DROPITEM,
Player.ProcessBreakEvent.emEVENT_SENDMAIL,
Player.ProcessBreakEvent.emEVENT_TRADE,
Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
Player.ProcessBreakEvent.emEVENT_LOGOUT,
Player.ProcessBreakEvent.emEVENT_DEATH,
Player.ProcessBreakEvent.emEVENT_ATTACKED,
}

function tbItem:OnUse()
--local nLevel = 1;
local tbOpt = {};
for nId, tbBoss in ipairs(self.tbBoss['boss']) do
table.insert(tbOpt, {tbBoss[1], self.CallBoss, self, it.dwId, nId, tbBoss[4]});
end
table.insert(tbOpt, {"Để ta nghĩ lại"});
Dialog:Say("Hãy chọn Boss muốn gọi", tbOpt);
end

function tbItem:CallBoss(nItemId, nId, nLevel, nSure)
local pItem = KItem.GetObjById(nItemId);
if not pItem then
return
end
--if me.nFightState == 0 then
--Dialog:Say("Chỉ có thể sử dụng Câu Hồn Ngọc tại Bí động của Gia Tộc");
--return 0;
--end
if not nSure then
local szMsg = string.format("Ngươi có chắc muốn triệu hồi <color=yellow> %s <color>?", self.tbBoss['boss'][nId][1]);
local tbOpt = {
{"Vâng, triệu hồi ngay!", self.CallProcess, self, nItemId, nId, nLevel},
{"Để suy nghĩ lại"},
}
Dialog:Say(szMsg, tbOpt);
return 0;
end
if me.DelItem(pItem) ~= 1 then
return;
end
local nMapId, nPosX, nPosY = me.GetWorldPos();
local pNpc = KNpc.Add2(self.tbBoss['boss'][nId][2], nLevel, self.tbBoss['boss'][nId][3], nMapId, nPosX, nPosY, 0, 1);
if pNpc then
me.Msg(string.format("Triệu hồi thành công %s", self.tbBoss['boss'][nId][1]));
end
end

function tbItem:CallProcess(nItemId, nId, nLevel)
GeneralProcess:StartProcess("Đang triệu hồi...", 5 * Env.GAME_FPS, {self.CallBoss, self, nItemId, nId, nLevel, 1}, nil, tbEvent);
end

