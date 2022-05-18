-- 文件名　：mingyang_unidentify.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-03-31 14:16:02
-- 描  述  ：

local tbItem 	= Item:GetClass("mingyang_unidentify");
SpecialEvent.LaborDay = SpecialEvent.LaborDay or {};
local LaborDay = SpecialEvent.LaborDay or {};
tbItem.IdentifyDuration = Env.GAME_FPS * 10;		--鉴定时间

if MODULE_GAMESERVER then

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < LaborDay.OpenTime or nData > LaborDay.CloseTime then	--活动期间外
		Dialog:Say("Không phải thời gian diễn ra sự kiện, không thể sử dụng lệnh bài.", {"Ta biết"});
		return;
	end	
	Dialog:Say("Giám định vật phẩm cần 20000 điểm tinh hoạt",
			{"Hãy giám định dùm ta", self.Identify, self, it.dwId, 0},
			{"Để ta xem lại"}
			);
end

--鉴定
function tbItem:Identify(nItemId, nFlag)	
	--背包判断
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang của các hạ đã đầy.",{"Ta biết"});
		return;
	end
	--精活判断
	if me.dwCurGTP < LaborDay.nGTPMkPMin_Couplet or me.dwCurMKP < LaborDay.nGTPMkPMin_Couplet then
		Dialog:Say(string.format("Tinh hoạt lực của bạn không đủ %s điểm, không thể giám định.", LaborDay.nGTPMkPMin_Couplet), {"Ta biết"});
		return;
	end
	--执行
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
		
	GeneralProcess:StartProcess("Đang giám định....", self.IdentifyDuration, {self.Identify, self,  nItemId, 1}, nil, tbEvent);
end

--读条成功
function tbItem:SuccessIdentify(nItemId)	
	local pItem = KItem.GetObjById(nItemId)	
	if pItem then
		local nLevel = pItem.nLevel;
		me.ChangeCurGatherPoint(-LaborDay.nGTPMkPMin_Couplet);	--减2w精力
		me.ChangeCurMakePoint(-LaborDay.nGTPMkPMin_Couplet);	--减2w活力
		pItem.Delete(me);--删掉一个未鉴定的		
		local pItemEx = me.AddItem(LaborDay.tbmingyang_identify[1], LaborDay.tbmingyang_identify[2], LaborDay.tbmingyang_identify[3], nLevel);
		if pItemEx then	
			EventManager:WriteLog(string.format("[劳动节 名扬英雄]鉴定牌子获得%s",pItemEx.szName), me);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[劳动节 名扬英雄]鉴定牌子获得%s",pItemEx.szName));
		end
	end
end

end
