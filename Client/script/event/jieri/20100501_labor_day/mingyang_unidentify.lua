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
		Dialog:Say("没有在活动期间，您还不能使用该物品！", {"知道了"});
		return;
	end	
	Dialog:Say("您要鉴定这个牌子么？需要消耗精活各2万点。",
			{"确定鉴定", self.Identify, self, it.dwId, 0},
			{"那算了"}
			);
end

--鉴定
function tbItem:Identify(nItemId, nFlag)	
	--背包判断
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("需要1格背包空间，整理下再来！",{"知道了"});
		return;
	end
	--精活判断
	if me.dwCurGTP < LaborDay.nGTPMkPMin_Couplet or me.dwCurMKP < LaborDay.nGTPMkPMin_Couplet then
		Dialog:Say(string.format("您的精活不足，需要精活各%s点。", LaborDay.nGTPMkPMin_Couplet), {"知道了"});
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
		
	GeneralProcess:StartProcess("鉴定...", self.IdentifyDuration, {self.Identify, self,  nItemId, 1}, nil, tbEvent);
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
