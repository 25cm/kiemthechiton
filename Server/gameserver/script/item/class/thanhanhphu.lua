-- GM专用卡
local tbThanHanhPhu	= Item:GetClass("thanhanhphu");
tbThanHanhPhu.MAX_RECENTPLAYER = 15;

function tbThanHanhPhu:OnUse()
local szMsg = "Bay tới cạnh bất kỳ nhân vật nào bạn muốn"; 
local tbOpt = { 
  {"Nhập tên nhân vật", self.AskRoleName, self},
  {"Ta chưa cần"},
 };
  Dialog:Say(szMsg, tbOpt);
end;
function tbThanHanhPhu:AskRoleName()
 Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName, self);
end
function tbThanHanhPhu:OnInputRoleName(szRoleName)
 local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
 if (not nPlayerId) then
  Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"});
  return;
 end
 
 self:ViewPlayer(nPlayerId);
end
function tbThanHanhPhu:ViewPlayer(nPlayerId)
 -- 插入最近玩家列表
 local tbRecentPlayerList = self.tbRecentPlayerList or {};
 self.tbRecentPlayerList  = tbRecentPlayerList;
 for nIndex, nRecentPlayerId in ipairs(tbRecentPlayerList) do
  if (nRecentPlayerId == nPlayerId) then
   table.remove(tbRecentPlayerList, nIndex);
   break;
  end
 end
 if (#tbRecentPlayerList >= self.MAX_RECENTPLAYER) then
  table.remove(tbRecentPlayerList);
 end
 table.insert(tbRecentPlayerList, 1, nPlayerId);
 local szName = KGCPlayer.GetPlayerName(nPlayerId);
 local tbInfo = GetPlayerInfoForLadderGC(szName);
 local tbState = {
  [0]  = "Không online",
  [-1] = "Đang xử lý",
  [-2] = "Auto?",
 };
 local nState = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
 local tbText = {
  {"Tên", szName},
  {"Cấp", tbInfo.nLevel},
  {"Giới tính ", (tbInfo.nSex == 1 and "Nữ") or "Nam"},
  {"Hệ phái ", Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute)},
  {"Tộc ", tbInfo.szKinName},
  {"Bang hội ", tbInfo.szTongName},
  {"Uy danh ", KGCPlayer.GetPlayerPrestige(nPlayerId)},
  {"Trạng thái ", (tbState[nState] or "<color=green>Trên mạng<color>") },
 }
 local szMsg = "";
 for _, tb in ipairs(tbText) do
  szMsg = szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
 end
 local szButtonColor = (nState > 0 and "") or "<color=gray>";
 local tbOpt = {
  {szButtonColor.."Tới chỗ "..szName.."", "GM.tbGMRole:SendMeThere", nPlayerId},
  {"Kết thúc đối thoại"},
 };
 Dialog:Say(szMsg, tbOpt);
end
