
local tbItem 	= Item:GetClass("distich");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};
tbItem.IdentifyDuration = Env.GAME_FPS * 10;		--鉴定时间

if MODULE_GAMESERVER then

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.HuaDengOpenTime or nData > SpringFrestival.HuaDengCloseTime then	--活动期间外
		Dialog:Say("Chưa đến thời gian hoạt động, không thể sử dụng vật phẩm này!", {"Biết rồi"});
		return;
	end	
	Dialog:Say("Bạn muốn giám định Liễn xuân này? Giám định cần tinh hoạt mỗi loại 1000 điểm, giám định xong có thể biết nó thuộc bức hoành phi nào bên dưới.",
			{"Xác nhận giám định", self.Identify, self, it.dwId, 0},
			{"Không"}
			);
end

function tbItem:Identify(nItemId, nFlag)
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("Bạn chưa đạt cấp %s, không thể giám định!",SpringFrestival.nLevel), {"Biết rồi"});
		return;
	end
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Cần 1 ô túi trống, hãy sắp xếp lại!",{"Biết rồi"});
		return;
	end
	if me.dwCurGTP < SpringFrestival.nGTPMkPMin_Couplet or me.dwCurMKP < SpringFrestival.nGTPMkPMin_Couplet then
		Dialog:Say(string.format("Tinh hoạt không đủ, cần Tinh hoạt mỗi loại %s điểm.", SpringFrestival.nGTPMkPMin_Couplet), {"Biết rồi"});
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
	local pItem = KItem.GetObjById(nItemId)
	if pItem then		
		me.ChangeCurGatherPoint(-SpringFrestival.nGTPMkPMin_Couplet);	--减1000精力
		me.ChangeCurMakePoint(-SpringFrestival.nGTPMkPMin_Couplet);	--减1000活力
		local tbCouplet = SpringFrestival.tbCouplet_Unidentify;
		me.ConsumeItemInBags2(1, tbCouplet[1], tbCouplet[2], tbCouplet[3], tbCouplet[4], nil, -1);--删掉一个未鉴定的对联
		local  nTimes = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT) or 0;
		me.SetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT,nTimes + 1);
		local pItemEx = me.AddItem(unpack(SpringFrestival.tbCouplet_identify));--鉴定的对联
		if pItemEx then
			local nNumber = MathRandom(#SpringFrestival.tbCoupletList);
			local nPart = MathRandom(2);
			pItemEx.SetGenInfo(1, nNumber);		--甚至那副对联
			pItemEx.SetGenInfo(2, nPart);			--设置是上联还是下联
			pItemEx.Sync();
		end
		me.AddItem(unpack(SpringFrestival.tbXiWang ));--(越南加)鉴定春联获得希望之种	
		EventManager:WriteLog("[Hoạt động Tết-giám định đối liễn] Giám định đối liễn nhận được đối liễn đã giám định", me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[Hoạt động Tết-giám định đối liễn] Giám định đối liễn nhận được đối liễn đã giám định");
	end
end

end

function tbItem:GetTip()
	local nTimes = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT) or 0;
	return string.format("Số Liễn xuân bạn đã giám định: %s", nTimes);
end
