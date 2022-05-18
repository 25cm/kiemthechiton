
local tbItem 	= Item:GetClass("gift_wish");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};
tbItem.nTransferTime =  Env.GAME_FPS * 2;		--传送时间

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.VowTreeOpenTime or nData > SpringFrestival.VowTreeCloseTime then	--活动期间外
		Dialog:Say("Chưa đến thời gian hoạt động, không thể sử dụng vật phẩm này!", {"Biết rồi"});
		return;
	end
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("Bạn chưa đạt cấp %s, không thể dùng đạo cụ này!", SpringFrestival.nLevel),{"Biết rồi"});
		return;
	end	
	Dialog:Say("Đem Hạt giống hy vọng đến Vĩnh Lạc Trấn cầu nguyện dưới cây cầu nguyện, bạn muốn cầu nguyện không?",
			{"Xem số điều ước trên cây cầu nguyện", self.View, self},
			{"Truyền tống đến Cây cầu nguyện", self.Transfer, self, 0},
			{"Ta suy nghĩ lại"}
			);
end

function tbItem:View()
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_SPRINGFRESTIVAL_VOWNUM);
	Dialog:Say(string.format("Số điều ước trên Cây cầu nguyện: <color=yellow>%s<color>", nCount),{"Biết rồi"});
end

function tbItem:Transfer(nFlag)
	local nPlayerMapId, nPosX, nPosY = me.GetWorldPos();	
	local szMapType = GetMapType(nPlayerMapId);
	if not SpringFrestival.tbTransferCondition[szMapType] then
		me.Msg("Tại đây không thể sử dụng vật phẩm truyền tống này!")
		return;
	end
	
	if nFlag == 1 then
		self:TransferEx();
		return;
	end
	
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
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
		
	GeneralProcess:StartProcess("Truyền tống", self.nTransferTime, {self.Transfer, self, 1}, nil, tbEvent);
end

function tbItem:TransferEx()
	me.NewWorld(unpack(SpringFrestival.tbVowTreePosition));
end

function tbItem:InitGenInfo()
	local nSec = Lib:GetDate2Time(SpringFrestival.nOutTime)
	it.SetTimeOut(0, nSec);
	return	{ };
end
