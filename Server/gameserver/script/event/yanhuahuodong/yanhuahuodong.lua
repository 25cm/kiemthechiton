--
-- 烟花活动脚本
-- zhengyuhua

SpecialEvent.tbYanHua = {}
local tbYanHua = SpecialEvent.tbYanHua;

tbYanHua.BEGIN_TIME		= 20210712	-- 开始日期
tbYanHua.END_TIME		= 20221212	-- 结束日期
tbYanHua.TASK_GROUP		= 2038
tbYanHua.TASK_DATE_ID	= 9
tbYanHua.YANHUA_ITEM	= {18,1,180,1};

function tbYanHua:CheckEventTime()
	local nCurDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nCurDate >= self.BEGIN_TIME and nCurDate < self.END_TIME then
		return 1;
	end
	return 0;
end

function tbYanHua:DialogLogic()
	local nCurDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nCurDate < self.BEGIN_TIME then
		Dialog:Say("Bộ sưu tập pháo hoa cho sự kiện sẽ chính thức khởi động vào ngày 27/7！");
		return 0;
	elseif nCurDate > self.END_TIME then
		Dialog:Say("Bộ sưu tập pháo hoa cho sự kiện đã kết thúc！");
		return 0;
	end
	local nDate = me.GetTask(self.TASK_GROUP, self.TASK_DATE_ID);
	local szInfo;
	local nKinId, nMemberId = me.GetKinMember();
	local nRet = Kin:HaveFigure(nKinId, nMemberId, 3)
	if nDate == nCurDate or nRet ~= 1 then
		szInfo = "  Từ ngày 27 tháng 7 đến ngày 17 tháng 8 lúc 0:00, người chơi có thể nhận được một quả pháo hoa từ tôi mỗi ngày. Tuy nhiên, chỉ những thành viên chính thức của đại gia đình <color=red> <color> mới có thể nhận được pháo hoa và trong thời gian diễn ra sự kiện, <color = red> chỉ có thể nhận <color> một lần mỗi ngày"
	end
	if me.CountFreeBagCell() <= 0 then
		szInfo = "Hành Trang không đủ chỗ trống"
	end
	
	if not szInfo then
		local pItem = me.AddItem(unpack(self.YANHUA_ITEM));
		if pItem then
			me.SetItemTimeout(pItem, os.date("%Y/%m/%d/00/00/00", GetTime() + 3600 * 24));	-- 当天有效
			me.SetTask(self.TASK_GROUP, self.TASK_DATE_ID, nCurDate);
		end
		return 1;
	end
	Dialog:Say(szInfo);
end

