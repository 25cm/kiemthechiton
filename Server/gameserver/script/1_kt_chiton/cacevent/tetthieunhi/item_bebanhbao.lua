local tbItem = Item:GetClass("item_bebanhbao1");
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\item_bebanhbao.lua") -- Reload Siro Ngũ Sắc
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
}
	
	GeneralProcess:StartProcess("Đang Gọi", 5, {self.OnUseSure, self, it.dwId}, nil, tbEvent);
end

function tbItem:OnUseSure(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0
	end
	if me.DelItem(pItem) == 1 then
	local nMapId, nPosX, nPosY = me.GetWorldPos();
local pNpc = KNpc.Add2(9651, 1, 0, nMapId, nPosX, nPosY)
pNpc.SetTitle("<color=gold>"..pNpc.szName.."<color> của ");
pNpc.szName =	""..me.szName.."";

me.Msg("<color=yellow>Đã gọi <color=gold>Bé Bánh Bao<color> tại <color=Turquoise>"..GetMapNameFormId(nMapId).."<color> tọa độ <color=Turquoise>"..math.floor(nPosX/8).."/"..math.floor(nPosY/16).."<color>")
	end
end