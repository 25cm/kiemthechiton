
local tbItem = Item:GetClass("insightbook");
tbItem.MAXUSECOUNT = 100;
tbItem.MINUSERLEVEL = 20;
tbItem.FAVOR = 20;
tbItem.DISUSELEVEL = Item.IVER_nInsightbookLevel; --低于书多少级才能使用
function tbItem:OnUse()
	local nTodayUsedCount = me.GetTask(2006, 1);
	if (nTodayUsedCount >= self.MAXUSECOUNT) then
		me.Msg("Bạn đã dùng Tâm Đắc Thư tối đa trong ngày, ngày mai hãy tiếp tục.");
		return 0;
	end
	if (me.nLevel < self.MINUSERLEVEL) then
		me.Msg("Người chơi cấp 20 trở lên mới có thể dùng Tâm Đắc Thư.");
		return 0;
	end
	
	local nCreatLevel = it.GetGenInfo(1);
	local nCanUseLevel = nCreatLevel - self.DISUSELEVEL + 1 ;
	if (me.nLevel >= (nCanUseLevel)) then
		me.Msg(string.format("Cấp của bạn đã vượt quá cấp dùng Tâm Đắc Thư, nội dung trong sách không còn tác dụng với bạn nữa.", nCreatLevel));
		return 0;
	end

	me.SetTask(2006, 1, nTodayUsedCount + 1, 1);

	local nAddExp = self:GetAddExp(it.nParticular);

	local nDelta = nCreatLevel - me.nLevel;
	if (nDelta >= 50) then		-- 心得书等级-角色等级 >=30且<50，则获得2倍经验
		nAddExp = nAddExp * 3;
	elseif (nDelta >= 30) then	-- 心得书等级-角色等级 >=50，则获得3倍经验
		nAddExp = nAddExp * 2;
	end

	local szCreaterName = it.szCustomString;
	local szTeacherName = me.GetTrainingTeacher();
	if (szCreaterName and szTeacherName and szCreaterName == szTeacherName) then
		Relation:AddFriendFavor(me.szName, szTeacherName, self.FAVOR);
		me.Msg("Sách này là do sư phụ của bạn viết, cho nên sau khi dùng thì độ thân mật tăng <color=yellow>" .. self.FAVOR .. " điểm<color>.");
		nAddExp = nAddExp * 2;
	end
	
	me.AddExp(nAddExp);
	me.Msg(string.format("Bạn đã lĩnh hội được quyển sách này, công lực tăng cao! Được (%d) điểm kinh nghiệm!", nAddExp));

	return 1;
end


function tbItem:GetTip()
	local nCreatLevel = it.GetGenInfo(1);
	local nAddExp = self:GetAddExp(it.nParticular);
	local nTodayUsedCount = me.GetTask(2006, 1);
	
	local szTip = "";
	if (me.nLevel < self.MINUSERLEVEL) then
		return "<color=0x8080ff>Phải đạt cấp "..self.MINUSERLEVEL.." trở lên mới có thể dùng Tâm Đắc Thư<color>\n\n";
	end
	local nCanUseLevel = nCreatLevel - self.DISUSELEVEL + 1 ;
	if (nCanUseLevel > 0) then
		szTip = szTip.."<color=0x8080ff>Cấp sử dụng: Cấp  "..nCanUseLevel.." trở xuống<color>\n\n";
	end
	
	szTip = szTip.."<color=0x8080ff>Kinh nghiệm nhận được: "..nAddExp.."<color>\n\n";
	szTip = szTip.."<color=0x8080ff>Hôm nay đã dùng: "..nTodayUsedCount.."/"..self.MAXUSECOUNT.." lần<color>\n\n";
	
	local nLimitLevel	= 0;
	local nTimes		= 1;
	local szMsg			= "";
	nLimitLevel = nCreatLevel - 30;
	if (nLimitLevel >= self.MINUSERLEVEL) then		-- 心得书等级-角色等级 >=30且<50，则获得2倍经验	
		nTimes	= 2;
		szTip	= szTip .. "Người sử dụng không vượt quá cấp <color=yellow>" .. nLimitLevel .. "<color>, có thể nhận được hiệu quả gấp <color=yellow>" .. nTimes .. "<color>\n\n";
	end
	
	nLimitLevel = nCreatLevel - 50;
	if (nLimitLevel > self.MINUSERLEVEL) then	-- 心得书等级-角色等级 >=50，则获得3倍经验
		nTimes	= 3;
		szTip	= szTip .. "Người sử dụng không vượt quá cấp <color=yellow>" .. nLimitLevel .. "<color>, có thể nhận được hiệu quả gấp <color=yellow>" .. nTimes .. "<color>\n\n";		
	end


	szTip = szTip.."<color=orange>"..it.szCustomString.."<color> <color=green>chế tạo<color>";
	return szTip;
end


function tbItem:GetAddExp(nParticular)
	local nAddExp = 0;
	
	if (nParticular == 43) then
		nAddExp = 130 * me.nLevel^2 + 2600 * me.nLevel + 9750;
	elseif(nParticular == 44) then
		nAddExp = 160 * me.nLevel^2 + 3200 * me.nLevel + 12000;
	elseif(nParticular == 45) then
		nAddExp = 200 * me.nLevel^2 + 4000 * me.nLevel + 15000;
	end
	
	return nAddExp;
end
