
local tbItem 	= Item:GetClass("picture_newyear");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};
tbItem.IdentifyDuration = Env.GAME_FPS * 10;		--鉴定年画的读条时间

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.VowTreeOpenTime or nData > SpringFrestival.VowTreeCloseTime then	--活动期间外
		Dialog:Say("Chưa đến thời gian hoạt động, không thể sử dụng vật phẩm này!", {"Biết rồi"});
		return;
	end
	Dialog:Say("Bạn muốn giám định Tranh Tết này? Giám định xong bạn sẽ biết là tranh con giáp nào, cần tinh hoạt mỗi loại 500 điểm.",
			{"Xác nhận giám định", self.Identify, self, it.dwId, 0},
			{"Không"}
			);
end

function tbItem:Identify(nItemId, nFlag)
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("Bạn chưa đạt cấp %s, không thể giám định!",SpringFrestival.nLevel), {"Biết rồi"});
		return;
	end
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("Cần 2 ô túi trống, hãy sắp xếp lại!",{"Biết rồi"});
		return;
	end
	if me.dwCurGTP < SpringFrestival.nGTPMkPMin_NianHua or me.dwCurMKP < SpringFrestival.nGTPMkPMin_NianHua then
		Dialog:Say(string.format("Tinh hoạt không đủ, cần Tinh hoạt mỗi loại %s điểm.", SpringFrestival.nGTPMkPMin_NianHua), {"Biết rồi"});
		return;
	end
	if nFlag == 1 then
		self:SuccessIdentify(nItemId);
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
		
	GeneralProcess:StartProcess("Giám định...", self.IdentifyDuration, {self.Identify, self,  nItemId, 1}, nil, tbEvent);
end

function tbItem:SuccessIdentify(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end
	local nNumber = MathRandom(12);
	local tbNianHua = SpringFrestival.tbNianHua_identify;
	local pItemEx = me.AddItem(tbNianHua[1], tbNianHua[2], tbNianHua[3], nNumber);
	if pItemEx then
		me.SetItemTimeout(pItemEx, 60*24*3, 0);	
		me.ChangeCurGatherPoint(-SpringFrestival.nGTPMkPMin_NianHua); 		--减500精力
		me.ChangeCurMakePoint(-SpringFrestival.nGTPMkPMin_NianHua);		--减500活力		
		local tbCouplet = SpringFrestival.tbNianHua_Unidentify;
		me.ConsumeItemInBags2(1, tbCouplet[1], tbCouplet[2], tbCouplet[3], tbCouplet[4], nil, -1);--删掉一个未鉴定的春联
	
		EventManager:WriteLog("[Hoạt động Tết-Giám định Tranh Tết] Giám định Tranh Tết nhận được Tranh Tết đã giám định", me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[Hoạt động Tết-Giám định Tranh Tết] Giám định Tranh Tết nhận được Tranh Tết đã giám định");
		
		me.AddItem(unpack(SpringFrestival.tbXiWang ));--(越南加)鉴定春联获得希望之种
		EventManager:WriteLog("[Hoạt động Tết-Giám định Tranh Tết] Nhận được Hạt hy vọng", me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[Hoạt động Tết-Giám định Tranh Tết] Nhận được Hạt hy vọng");
	end
end
