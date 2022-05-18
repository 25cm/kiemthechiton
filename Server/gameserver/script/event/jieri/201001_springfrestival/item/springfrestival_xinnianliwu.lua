
local tbItem 	= Item:GetClass("gift_newyear");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbItem:OnUse()
	
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("Bạn chưa đạt cấp %s, không thể dùng đạo cụ này!", SpringFrestival.nLevel),{"Biết rồi"});
		return;
	end	
	
	if me.nTeamId == 0  then
		Dialog:Say("Đạo cụ chỉ có thể tặng đồng đội, bạn chưa có tổ đội.", {"Biết rồi"});
		return;		
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Tặng đạo cụ, cần chừa 1 ô túi trống, hãy sắp xếp rồi sử dụng.",{"Biết rồi"});
		return;
	end	
	
	local tbOpt = {};
	local tbPlayerList = KTeam.GetTeamMemberList(me.nTeamId)
	for i = 1 , #tbPlayerList do
		local pPlayer = KPlayer.GetPlayerObjById(tbPlayerList[i]);
		if pPlayer and me.nId ~= tbPlayerList[i] then		
			table.insert(tbOpt, {string.format("%s",pPlayer.szName), self.Present, self, it.dwId, tbPlayerList[i]});		
		end
	end
	table.insert(tbOpt, {"Hủy"});
	Dialog:Say("Tặng đồng đội, hãy chọn người muốn tăng.",tbOpt);
end

function tbItem:Present(nItemId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end
	local nMapId, nPosX, nPosY = me.GetWorldPos();	       		     
	local nMapId2, nPosX2, nPosY2	= pPlayer.GetWorldPos();
	local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
	if nMapId2 ~= nMapId or nDisSquare > 400 then
		Dialog:Say("Đồng đội phải ở gần.");
		return 0;				 
	end
	if pPlayer.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("Đối phương chưa đạt cấp %s, không thể tặng!", SpringFrestival.nLevel),{"Biết rồi"});
		return;
	end	
	if me.GetFriendFavorLevel(pPlayer.szName) < 1 then
		Dialog:Say("Độ thân mật của bạn và đối phương chưa đạt cấp 2, tặng như thế có vẻ đường đột.",{"Biết rồi"});			
		return;
	end
	local nCount = pPlayer.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_BAINIANNUMBER)
	if nCount >= SpringFrestival.nBaiNianCount then
		Dialog:Say("Không thể tặng tiếp, đối phương đã nhận 15 phần quà tết!",{"Biết rồi"});			
		return;			
	end
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Tặng đạo cụ, cần chừa 1 ô túi trống, hãy sắp xếp rồi sử dụng.",{"Biết rồi"});
		return;
	end	
	if pPlayer.CountFreeBagCell() < 1 then
		Dialog:Say("Tặng hảo hữu cần 1 ô túi trống, đợi hảo hữu sắp xếp lại rồi tặng!",{"Biết rồi"});
		return;
	end
	
	pItem.Delete(me);	
	pPlayer.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_BAINIANNUMBER, nCount +1);
	
	Dialog:SendBlackBoardMsg(me, string.format("Bạn tặng quà Tết cho %s, đối phương rất vui mừng!",pPlayer.szName));
	Dialog:SendBlackBoardMsg(pPlayer, string.format("Bạn nhận được quà Tết của %s, thật vui quá đi!",me.szName));
	pPlayer.Msg(string.format("Bạn đã nhận được %s món quà",nCount+1));
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData >= SpringFrestival.HuaDengOpenTime and nData <= SpringFrestival.HuaDengCloseTime then	--活动期间
		local nRant = MathRandom(100);
		for i = 1 ,#SpringFrestival.tbBaiAward do
			if nRant > SpringFrestival.tbBaiAward[i][2] and nRant <= SpringFrestival.tbBaiAward[i][3]  then
				local pItemEx = me.AddItem(unpack(SpringFrestival.tbBaiAward[i][1]));
				EventManager:WriteLog(string.format("[Hoạt động Tết-Người chơi chúc tết] Chúc tết hảo hữu nhận được vật phẩm: %s", pItemEx.szName), me);
				me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[Hoạt động Tết-Người chơi chúc tết] Chúc tết hảo hữu nhận được vật phẩm: %s", pItemEx.szName));
			end
		end
	end
	local pItemEx = pPlayer.AddItem(unpack(SpringFrestival.tbBaiNianAward));
	pPlayer.SetItemTimeout(pItemEx, 60*24*30, 0);
	me.AddFriendFavor(pPlayer.szName, 199,0);		--越南加：双方亲密度增加199点
	EventManager:WriteLog(string.format("[Hoạt động Tết-Người chơi chúc tết] Nhận được quà tết của %s [Tặng]", me.szName), pPlayer);
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[Hoạt động Tết-Người chơi chúc tết] Nhận được quà tết của %s [Tặng]", me.szName));
end

function tbItem:InitGenInfo()
	local nSec = Lib:GetDate2Time(SpringFrestival.nOutTime + 10000); --加了一天
	it.SetTimeOut(0, nSec);
	return	{ };
end
