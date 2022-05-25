local uiHelpSprite = Ui(Ui.UI_HELPSPRITE);

local nBindMoneyLogin                  =0
local nBindCionLogin                   =0
local nActiveMoneyLogin                =0


uiHelpSprite.Get_Msg=function(self)
	local szListText = "";
	local tbYesOrNo =
		{
			[0] = "Chưa hoàn thành",
			[1] = "Hoàn thành",
		}

	--��̯ʱ��

	--if (me.nLevel <= 100) then
		--local  nTotalTime	= me.GetTask(Stall.TASK_GROUP_ID, Stall.TASK_TOTAL_TIME);
		--local  nHour		= Lib:TransferSecond2NormalTime(nTotalTime/1*60) 
		--local  nMinute		= Lib:TransferSecond2NormalTime(nTotalTime/60*60) 
		--szListText = szListText .. string.format("<goto=20><bclr=blue>Stall cho thời gian còn lại<color><goto=250><bclr=blue>%dGiờ%dPhút%dgiây<color>", nMinute, nHour, nTotalTime) .. "<linegap=10>\n";
	--end

	szListText	= szListText .. "<bgclr=250,250,120,80><bclr=red>Hoạt động <bclr><bgclr>\r";
	local nNowWeek	= tonumber(GetLocalDate("%w"));
	local nTime = tonumber(GetLocalDate("%H%M"));
	if (me.nLevel >= 30) then
	    if (nNowWeek == 1 or nNowWeek == 3 or nNowWeek == 4) then
		    --if nTime<1230 then
			if nTime<2030 then
				szListText = szListText .. string.format("<goto=20>Bắt đầu hoạt động đoán Hoa Đăng còn:<goto=250><color=yellow>%d<color>Giờ<color=yellow>%d<color>phút",(2030-nTime)/100,math.mod(math.mod(2030-nTime+60,100),60)) .. "<linegap=10>\n";
				--elseif (nTime >=1230 and nTime < 1330) then
				elseif (nTime >=2030 and nTime < 2130) then
				szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Đoán Hoa Đăng đang diễn ra, hãy tham gia<color><bclr>") .. "<linegap=10>\n";
				elseif nTime >2130 then
				szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Đoán Hoa Đăng đã kết thúc<color><bclr>") .. "<linegap=10>\n";
			end
		end
	end

	if (nNowWeek == 2 or nNowWeek == 5) then
		if nTime<1930 then
			--szListText = szListText .. string.format("<goto=20>Sự kiện thể thao từ lần lượt các-về thời gian có Menpai<goto=250><color=yellow>%d<color>Giờ<color=yellow>%d<color>phút",(1930-nTime)/100,math.mod(math.mod(1930-nTime+60,100),60)) .. "<linegap=10>\n";
			szListText = szListText .. string.format("<goto=20>Bắt đầu báo danh thi đấu Môn phái còn:<goto=250><color=yellow>%d<color>Giờ<color=yellow>%d<color>phút",(1930-nTime)/100,math.mod(math.mod(1930-nTime+60,100),60)) .. "<linegap=10>\n";
		elseif (nTime >=8000 and nTime < 2130) then
			--szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Đàn ông Pai lưỡng các hoạt động đang được tiến hành trong nóng<color><bclr>") .. "<linegap=10>\n";
			szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Hoạt động thi đáu Môn phái đang diễn ra<color><bclr>") .. "<linegap=10>\n";
		elseif nTime >2130 then
			szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Hoạt động thi đáu Môn phái kết thúc<color><bclr>") .. "<linegap=10>\n";
		end
	end

	if me.nLevel>=90 then
		--local nWaitTime	= Task.tbArmyCampInstancingManager:GetRegisterWaitTime(me);
		if nTime %100<10 then
			szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Thời gian báo danh phó bản còn:<color><bclr><goto=250><color=red>%d<color>phút",10-math.mod(nTime,100)) .. "<linegap=10>\n";
		else
			szListText = szListText .. string.format("<goto=20>Bắt đầu báo danh Phó bản còn: <goto=250><color=yellow>%d<color>phút",60-math.mod(nTime,100)) .. "<linegap=10>\n";
		end
	end
	local nNextBattle	= 0;
	local tbBattleTime	= {
			{0050, 0100, 0200},
			{1050, 1100, 1200},
			{1250, 1300, 1400},
			{1450, 1500, 1600},
			{1650, 1700, 1800},
			{1850, 1900, 2000},
			{2050, 2100, 2200},
			{2250, 2300, 2400},
		};
	for _, tbTime in ipairs(tbBattleTime) do
		if(nTime < tbTime[1])then
			nNextBattle	= tbTime[1];
			--szNextBattle	= string.format("%d:%d", nNextBattle/100, math.mod(nNextBattle,100));
			szListText = szListText .. string.format("<goto=20>Bắt đầu báo danh chiến trường còn: <goto=250><color=yellow>%d<color>Giờ<color=yellow>%d<color>phút",(tbTime[1]-nTime)/100,math.mod(math.mod(tbTime[1]-nTime+60,100),60)) .. "<linegap=10>\n";
			break;
		elseif (nTime >= tbTime[1]) and nTime<(tbTime[1]+50) then
			szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Thời gian báo danh chiến trường còn: <color><bclr><goto=250><color=red>%d<color>phút",60-math.mod(nTime,100)) .. "<linegap=10>\n";
			break;
		end
	end

	local nNextBattle	= 0;
	local tbBattleTime	= {
			{0830,0900,1000},
			{0930,1000,1100},
			{1030,1100,1200},
			{1130,1200,1300},
			{1230,1300,1400},
			{1330,1400,1500},
			{1430,1500,1600},
			{1530,1600,1700},
			{1630,1700,1800},
			{1730,1800,1900},
			{2130,2200,2300},
			{2230,2300,0000},
			{2330,0000,0100},
			{0030,0100,0200},
			{0130,0200,0300},
			{0230,0300,0400},
			{0330,0400,0500},
			{0430,0500,0600},
			{0530,0600,0700},
			{0630,0700,0800},
		};
	for _, tbTime in ipairs(tbBattleTime) do
		if	(nTime < tbTime[1]) then
			nNextBattle	= tbTime[1];
			--szNextBattle	= string.format("%d:%d", nNextBattle/100, math.mod(nNextBattle,100));
			szListText = szListText .. string.format("<goto=20>Bắt đầu báo danh Bạch Hổ Đường còn:<goto=250><color=yellow>%d<color>Giờ<color=yellow>%d<color>phút",(tbTime[1]-nTime)/100,math.mod(math.mod(tbTime[1]-nTime+60,100),60)) .. "<linegap=10>\n";
			break;
		elseif 	(nTime >= tbTime[1]) and nTime<(tbTime[1]+70) then
			szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Thời gian báo danh Bạch Hổ Đường còn:<color><bclr><goto=250><color=red>%d<color>phút",60-math.mod(nTime,100)) .. "<linegap=10>\n";
			break;
		end
	end
	local nRestTime=0;
	--if nTime >= 0800 and nTime < 2300 then
		nRestTime = 30 - (nTime % 100) % 30;
	--end
	if (nTime >= 1130 and nTime < 2300) or (nTime>0000 and nTime<0200) then
	--if (nTime >= 0800 and nTime < 2300) or (nTime>0000 and nTime<0200) then    --test
		--szListText = szListText .. string.format("<goto=20>Thời gian báo danh Tiêu Dao Cốc còn1:<goto=250><color=red>%d<color>phút",nRestTime) .. "<linegap=10>\n";
		szListText = szListText .. string.format("<goto=20><bclr=red><color=yellow>Thời gian báo danh Tiêu Dao Cốc còn:<color><bclr><goto=250><color=red>%d<color>phút",nRestTime) .. "<linegap=10>\n";
	end
	if nTime > 0130 and nTime < 1130 then
		--szListText = szListText .. string.format("<goto=20>Thời gian báo danh Tiêu Dao Cốc còn2:<goto=250><color=yellow>%d<color>giờ<color=yellow>%d<color>phút",(1130-nTime)/100,math.mod(math.mod(1130-nTime+60,100),60)) .. "<linegap=10>\n";
		szListText = szListText .. string.format("<goto=20>Bắt đầu báo danh Tiêu Dao Cốc còn:<goto=250><color=yellow>%d<color>giờ<color=yellow>%d<color>phút",(1130-nTime)/100,math.mod(math.mod(1130-nTime+60,100),60)) .. "<linegap=10>\n";
	end

	szListText	= szListText .. "<bgclr=250,250,120,80><bclr=red>Việc trong Tuần<bclr><bgclr>\r";

	local nLastXchgWeek	= me.GetTask(2080, 1);
	local nThisWeek		= Lib:GetLocalWeek(GetTime()) + 1

	--���ܽ��� ��˰ ˰��
	if (me.nLevel >= 25) then
		local nRemain = 0;
		local nTaxCount = 0;
		local nAmount = me.GetTask(TradeTax.TAX_TASK_GROUP, TradeTax.TAX_AMOUNT_TASK_ID);	-- ���ܽ��׶�
		if nAmount > TradeTax.TAX_REGION[1][1] then
			nTaxCount = me.GetTask(TradeTax.TAX_TASK_GROUP, TradeTax.TAX_ACCOUNT_TASK_ID)
		else
			nRemain = TradeTax.TAX_REGION[1][1] - nAmount;	--ʣ����˰��
	end
		local nTaxRate = 0;
		for i = 1, #TradeTax.TAX_REGION do
			if nAmount >= TradeTax.TAX_REGION[i][1] then
				if TradeTax.TAX_REGION[i + 1] then
					nTaxRate = TradeTax.TAX_REGION[i + 1][2];
				else
					nTaxRate = TradeTax.TAX_REGION_MAXNUMBER; 
				end
			end
		end
		szListText = szListText .."<goto=20>Doanh thu ".. string.format("Tuần <color=red>%.1fv<color>, miễn thuế còn <color=red>%.1fv<color>, Nộp thuế <color=red>%.1fv<color>, Tỷ lệ hơn<color=red> %.1f<color>", nAmount/10000, nRemain/10000, nTaxCount/10000, nTaxRate*100).."<linegap=10>\n";
	end
	if nLastXchgWeek == nThisWeek then
		szListText = szListText .. string.format("<goto=20><color=White>Tuần này đã đổi Bạc khóa thành Bạc chưa:<color><goto=250><color=yellow> Rồi<color>") .. "<linegap=10>\n";
	else
		szListText = szListText .. string.format("<goto=20><color=White>Tuần này đã đổi Bạc khóa thành Bạc chưa:<color><goto=250><color=red> Chưa<color>") .. "<linegap=10>\n";
	end

	if (me.nLevel >= 60) then
		local nWeiwang = me.GetTask(2027, 55);
		local nCurWeek = tonumber(GetLocalDate("%Y%W"));
		if nCurWeek > me.GetTask(2027, 54) then
			nWeiwang = 0;
			end
			szListText = szListText .. "<goto=20>Tuần này nhận lương ở chỗ Lễ Quan:<goto=250><color="
	if nWeek == nLastWeek then
		szListText = szListText .. "yellow>Rồi"
	else 
		szListText = szListText .. "red>Chưa"
	end
	szListText = szListText .. "<color><goto=295><link=npcpos:,"..me.nMapId..",2601,Phúc lợi người nhận><linegap=10>\n"
		local nJunXuCount	= Battle:GetRemainJunXu();
			  szListText = szListText .. string.format("<goto=20>Quân nhu Tống Kim miễn phí trong tuần:<goto=250><color=yellow>%d rương<color>", nJunXuCount) .. "<linegap=10>\n";	
	end
	 if me.nLevel >= 80 then	
      
        local nTime = tonumber(os.date("%Y%m%d"));
	      local nLastTime = me.GetTask(2050, 53);
	      if nTime == nLastTime then
          szListText = szListText .. string.format("<goto=20>Hôm nay đã nhận thuốc Tiêu Dao Cốc chưa:<goto=250><color=yellow>Rồi<color>") .. "<linegap=10>\n";
        else
          szListText = szListText .. string.format("<goto=20>Hôm nay đã nhận thuốc Tiêu Dao Cốc chưa:<goto=250><color=yellow>Chưa<color>") .. "<linegap=10>\n";
        end
      
      end 
	local nTradeMoney = me.GetTask(2022,3);
		szListText = szListText .. string.format("<goto=20><color=White>Số tiền tích lũy giao dịch trong tuần:<color><goto=250><color=yellow>%d lượng<color>", nTradeMoney) .. "<linegap=10>\n";

	if (me.nLevel >= 60) then
		local nShanghui = me.GetTask(2036, 1);
		if	nShanghui==0 then
			szListText = szListText .. string.format("<goto=20><color=White>Nhiệm vụ Thương hội tuần này:<color><goto=250><color=red>%s<color>", tbYesOrNo[nShanghui]) .. "<linegap=10>\n";
		else
			szListText = szListText .. string.format("<goto=20><color=White>Nhiệm vụ Thương hội tuần này:<color><goto=250><color=yellow>Hoàn thành<color>", tbYesOrNo[nShanghui]) .. "<linegap=10>\n";
		end
	end

		local nOpenTreaBoxTimes = 30 - me.GetTask(2015, 40);
			szListText	= szListText .. "<goto=20><color=White>Rương Tàng bảo đồ còn được mở trong tuần: <color><goto=250>" .. string.format("<color=yellow>%d <color>", nOpenTreaBoxTimes) .. "<linegap=10>\n";

			if (me.nLevel >= 80) then
				local nTimes = XoyoGame:GetPlayerTimes(me);
				szListText	= szListText .. "<goto=20><bclr=blue>Số lần vào Tiêu Dao Cốc trong tuần còn: <bclr><goto=250>" .. string.format("<color=yellow>%d/14<color>", nTimes) .. "<goto=295><link=npcpos:,23,3237,Triệu Khản><linegap=10>\n";
			end

	if (me.nLevel >= 50 and me.nLevel < 80) then
		local nTaoNum = uiHelpSprite.MAX_FB_Enter_NUM - me.GetTask(2066,254);
		szListText	= szListText .. "<goto=20>Tạo Zhugong tuần, và cung cấp truy cập đến số lượng ngôi mộ nghi ngờ<goto=250>" .. string.format("<color=yellow>%d<color>", nTaoNum) .. "<linegap=10>\n";
	end

	if (me.nLevel >= 50 and me.nLevel < 80) then
		local nDamoguchengNum = uiHelpSprite.MAX_FB_Enter_NUM - me.GetTask(2066,272);
		szListText	= szListText .. "<goto=20>Số lần này tuần, và cung cấp truy cập đến các thành phố sa mạc<goto=250>" .. string.format("<color=yellow>%d<color>", nDamoguchengNum) .. "<linegap=10>\n";
	end

			if (me.nLevel >= 80) then
				local nQianqionggongNum = uiHelpSprite.MAX_FB_Enter_NUM - me.GetTask(2066,287);
				szListText	= szListText .. "<goto=20>Số lần vào Thiên Quỳnh Cung trong tuần còn: <goto=250>" .. string.format("<color=yellow>%d<color>", nQianqionggongNum) .. "<linegap=10>\n";
			end

			if (me.nLevel >= 80) then
				local nWanhuaguNum = uiHelpSprite.MAX_FB_Enter_NUM - me.GetTask(2066,344);
				szListText	= szListText .. "<goto=20>Số lần vào Vạn Hoa Cốc trong tuần còn: <goto=250>" .. string.format("<color=yellow>%d<color>", nWanhuaguNum) .. "<linegap=10>\n";
			end


	if (me.nLevel >= 90) then
		local nGutTaskTimes = Task.tbArmyCampInstancingManager:GetGutTaskTimesThisWeek(1, me.nId);
		szListText = szListText .. string.format("<goto=20>Nhiệm vụ chính tuyến phó bản trong tuần: <goto=250><color=yellow>%d/4<color>",nGutTaskTimes) .. "<linegap=10>\n";
	end

	if (me.nLevel >= 90) then
		local nDailyTask  = Task.tbArmyCampInstancingManager:GetDailyTaskTimesThisWeek(1, me.nId);
		szListText = szListText .. string.format("<goto=20>Nhiệm vụ thường ngày phó bản trong tuần: <goto=250><color=yellow>%d/28<color>",nDailyTask) .. "<linegap=10>\n";
	end
	szListText	= szListText .. "<bgclr=250,250,120,80><bclr=red>Võ Lâm liên đấu<bclr><bgclr>\r";
	local nSession	= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION);
	local nTotle= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE);
	local nWin	= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN);
	local nTie	= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE);
	local szSession = "<goto=250>Chưa tham đấu"
	if nSession > 0 and Wlls.SEASON_TB[nSession] then
		szSession = string.format("%s %s", Lib:Transfer4LenDigit2CnNum(nSession), Wlls.SEASON_TB[nSession][4]);
	szListText	= szListText .. string.format("<goto=20><color=White>Tham gia võ lâm liên đấu:<color><goto=250><color=yellow>%s<color><linegap=10>\n", szSession);
	else
	szListText	= szListText .. string.format("<goto=20><color=White>Tham gia võ lâm liên đấu:<color><goto=250><color=red>%s<color><linegap=10>\n", szSession);
	end
	szListText	= szListText .. string.format("<goto=20><color=White>Tổng số trận:<color><goto=250><color=yellow>%s/48<color><linegap=10>\n", nTotle);

	szListText	= szListText .. string.format("<goto=20><color=White>Số trận thắng:<color><goto=250><color=yellow>%s<color><linegap=10>\n", nWin);

	szListText	= szListText .. string.format("<goto=20><color=White>Số trận hòa:<color><goto=250><color=yellow>%s<color><linegap=10>\n", nTie);

	szListText	= szListText .. string.format("<goto=20><color=White>Số trận thua:<color><goto=250><color=yellow>%s<color><linegap=10>\n", (nTotle-nWin-nTie));
	szListText	= szListText .. "<bgclr=250,250,120,80><bclr=red>Thông tin nhân vật<bclr><bgclr>\r";

	local nSmallXisui	= me.GetTask(2040, 6);
	local nMidXisui		= me.GetTask(2040, 9);
	local nSmallWulin	= me.GetTask(2040, 5);
	local nMidWulin		= me.GetTask(2040, 8);
	local nBigWulin		= me.GetTask(2040, 10);
	local nBigXisui		= me.GetTask(2040, 11);
	local nBig2Xisui	= me.GetTask(2040, 20);
	local nBig2Wulin	= me.GetTask(2040, 21);
	szListText = szListText .. string.format("<goto=20><color=White>Tẩy Tủy Kinh (sơ):<color> <goto=250><color=yellow>%d/5<color>", nSmallXisui) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20><color=White>Tẩy Tủy Kinh (trung):<color> <goto=250><color=yellow>%d/5<color>", nMidXisui) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20><color=White>Võ Lâm Mật Tịch (sơ):<color> <goto=250><color=yellow>%d/5<color>", nSmallWulin) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20><color=White>Võ Lâm Mật Tịch (trung):<color> <goto=250><color=yellow>%d/5<color>", nMidWulin) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20>Bánh ít bát bảo: <goto=250><color=yellow>%d/2<color>", nBigXisui) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20>Bánh ít thập cẩm: <goto=250><color=yellow>%d/2<color>", nBigWulin) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20>Thái Vân Truy Nguyệt: <goto=250><color=yellow>%d/2<color>", nBig2Xisui) .. "<linegap=10>\n";
	szListText = szListText .. string.format("<goto=20>Thượng Hải Nguyệt Minh: <goto=250><color=yellow>%d/2<color>", nBig2Wulin) .. "<linegap=10>\n";
	szListText	= szListText .. "<bgclr=250,250,120,80><bclr=red>Ủy thác trong ngày<bclr><bgclr>\r";
	if (me.nLevel >= 20) then
		local nOfflineTime = Player.tbOffline:GetTodayRestOfflineTime() / 3600;
		szListText	= szListText .. "<goto=20>Thời gian rời mạng hôm nay còn:<goto=250>" .. string.format("<color=yellow>%.1fGiờ<color>", nOfflineTime) .. "<linegap=10>\n";

		for key, tbBaiju in ipairs(Player.tbOffline.BAIJU_DEFINE) do
			if (tbBaiju.nShowFlag == 1) then
				local nRestTime = me.GetTask(5, tbBaiju.nTaskId);
				szListText	= szListText .. "<goto=20><color=yellow>" .. tbBaiju.szName .. "<color> ủy thác còn lại<goto=250>" .. Player.tbOffline:GetDTimeDesc(nRestTime) .. "<linegap=10>\n";
			end
		end
	end

	self:SetContentText(szListText);
	--return szListText;
end

uiHelpSprite.OnOpen=function (self)
	if (GblTask:GetUiFunSwitch("UI_HELPSPRITE_ZHIDAO") == 0) then
		Wnd_Hide(self.UIGROUP, self.PAGE_BUTTON_KEY_STR..7);	-- �ݲ����Ŵ˹���
	end
	self.tbFirstPageFold[1]		= 0; -- ������Ϣ�Ƿ�չ���ı��0=δչ��
	self.tbFirstPageFold[2]		= 0; -- ����������ˢ����Ϣ0=δչ��
	self.tbFirstPageFold[3]		= 1; -- btssl��Ϣ1=��չ��
	self.tbSearchResultBuf = {};
	self:WriteStatLog();
	Ui(Ui.UI_PLAYERSTATE):OnHelpOpen();
	self.nCurPageIndex = 1;
	self:UpdatePage(1);
	self:SetStaticTxt();
	--self:SetContentText(self.STR_DEFAULT_TEXT);
	self:Get_Msg();
end

uiHelpSprite.ChatCommand=function (self)
	local pTabFile = KIo.OpenTabFile("\\interface\\btssl_helpsprite\\chatcommand.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
		local szText	=[[
		�������ʹ�÷���]];
		szText	=szText..string.format("\nTrong cửa sổ trò chuyện đầu vào, theo lệnh định dạng:\nĐịnh dạngVai trò của lệnh + + không gian tên của các định dạng khác ② lệnh \ n chat lệnh sẽ xuất hiện của hai hiệu ứng sau đây. Như vậy là:\n\nNhập sau khi xuất hiện cửa sổ chat<color=red>/smile ���<color>Đạo diễn lúc mọi người đến với giggle ... Hehe ...:<color=green>%sNhập sau khi xuất hiện cửa sổ chat<color>\n��<color=red>/smile<color>Hehe để giggle với nhau.:<color=green>%s�Ǻǵ�ɵЦ������<color><color=pink>\n����Ч����\"****\"�����Է�,\"####\"Riêng thay mặt, và một số kết quả được bỏ qua từ riêng của mình<color>\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n����<goto=80>����\n",me.szName,me.szName);
	for i = 1, nHeight do
		local szTextCmd	= pTabFile.GetStr(i,1);
		local szCmdName	= pTabFile.GetStr(i,2);
		local szCmd1	= pTabFile.GetStr(i,3);
		local szCmd2	= pTabFile.GetStr(i,4);
		szText	=szText.."~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"..string.format("<color=orange>%s<color><goto=80><color=pink>%s\n<color>",szTextCmd,szCmdName);
		szText	=szText.."��Ч:"..szCmd1.."\n".."��Ч:"..szCmd2.."\n";
	end
	KIo.CloseTabFile(pTabFile);	-- �ͷŶ���
	--return szText;
	self:SetContentText(szText);
end


uiHelpSprite.Link_command_OnClick=function(self,szWnd, szGroupId)
	self:ChatCommand();
end

uiHelpSprite.Link_GetMsg_OnClick=function(self,szWnd, szGroupId)
	self:Get_Msg();
end


uiHelpSprite.OnUpdatePage_Page1=function(self)
	local tbNeedInfo	= {};
	for key, nId in pairs(self.DNEWSID) do
		self.tbNewsInfo[-nId] = nil;
	end
	for nNewsId, tbNInfo in pairs(self.tbNewsInfo) do
		tbNeedInfo[#tbNeedInfo+1]	= self:GetNewsInfo(nNewsId);
	end
	if (Task.tbHelp.tbNewsList) then
		for key, tbDMews in pairs(Task.tbHelp.tbNewsList) do
			local nTime = GetTime();
			if (tbDMews.nEndTime > nTime and tbDMews.nEndTime > 0 and nTime >= tbDMews.nAddTime) then
				tbNeedInfo[#tbNeedInfo+1]	= {
					szName	= tbDMews.szTitle,
					nWeight	= 50000 - key,
					nId		= -1 * key,
					nKey		= key,
					bReaded	= Task.tbHelp:GetDNewsReaded(key),
				};
				self.tbNewsInfo[-1 * key]	= {
					szName		= tbDMews.szTitle,
					nLifeTime	= 0,
					varWeight	= 100,
					varContent	= tbDMews.szMsg,
				};
			end
		end
	end


	table.sort(tbNeedInfo, function(tb1, tb2) return tb1.nWeight > tb2.nWeight end);

	local szListText = string.format("<bgclr=250,250,120,80><goto=10><a=firstfold:%d><div=230,20,0,0,0>         Tin mới nhất</div><a><bgclr><linegap=10>\n", 1);
	if (self.tbFirstPageFold[1] == 1) then
		for _, tb in ipairs(tbNeedInfo) do
			if (tb.bReaded ~= 1) then
				--szListText	= szListText .. "<pic=\\image\\effect\\other\\new.spr><linegap=-16>\n<linegap=10>";
				szListText	= szListText .. "<pic=\\image\\effect\\other\\new"..UiManager.IVER_szVnSpr.."><linegap=-16>\n<linegap=10>";
			else
				szListText	= szListText .. "   ";
			end
			szListText	= szListText .. string.format("<goto=60><a=news:%d>%s<a>\n<linegap=10>", tb.nId, tb.szName);
		end

	end

	szListText	 = szListText ..  string.format("<bgclr=250,250,120,80><goto=10><a=firstfold:%d><div=230,20,0,0,0>         Thông Tin Tác Giả</div><a><bgclr><linegap=10>\n", 2);
	if (self.tbFirstPageFold[2] == 1) then
		szListText =szListText..string.format("<color=yellow>    Plugin HOAHONGNET<color>\n<linegap=10>");
		szListText =szListText..string.format("<color=yellow>    Trang Chủ: http://hoahongnet.info<color>\n<linegap=10>");
		szListText =szListText..string.format("<color=yellow>    Phát Hành: CNTT487 & HOAHONGNET<color>\n<linegap=10>");

	end
	szListText	= szListText .. string.format("<bgclr=250,250,120,80><goto=10><a=firstfold:%d><div=230,20,0,0,0>         Việc trong ngày</div><a><bgclr><linegap=10>\n", 3);
	if (self.tbFirstPageFold[3] == 1) then
		local nJDay = me.GetTask(2024,1);
		local nJNum = me.GetTask(2024,2);
		local nHDay = me.GetTask(2024,3);
		local nHNum = me.GetTask(2024,4);
		local nJHCurDate = tonumber(os.date("%Y%m%d",GetTime()));
		if nJDay ~= nJHCurDate then
			nJNum = 0;
		end
		if nHDay ~= nJHCurDate then
			nHNum = 0;
		end

		if (nJNum >= 5) then
			szListText	= szListText .. "<goto=20><color=green>Hôm nay, hoàn thành tinh lực ưu đãi<color><goto=200>" .. string.format("<color=green><color>") .. "<linegap=10>\n";
		else
			szListText	= szListText .. "<goto=20><color=red>Tinh lực ưu đãi<color><goto=200>" .. string.format("<color=red>%d/5<color>", nJNum) .. "<linegap=10>\n";
		end
		if (nHNum >= 5) then
			szListText	= szListText .. "<goto=20><color=green>Hôm nay, hoàn thành hoạt lực ưu đãi<bclr><goto=200>" .. string.format("<color=green><color>") .. "<linegap=10>\n";
		else
			szListText	= szListText .. "<goto=20><color=red>Hoạt lực ưu đãi:<color><goto=200>" .. string.format("<color=red>%d/5<color>", nHNum) .. "<linegap=10>\n";
		end
		if (me.nLevel >= 50) then
		local nInDirFlag = me.GetTask(Task.tbPlayerPray.TSKGROUP, Task.tbPlayerPray.TSK_INDIRAWARDFLAG);
		local nPrayTimes = Task.tbPlayerPray:GetPrayCount(me);
		if (nInDirFlag == 1) then
			szListText	= szListText .. "<goto=20><color=pink>Chúc phúc: <color><goto=150><a=openpray:>Chưa nhận thưởng<a><linegap=10>\n";
		else
			if nPrayTimes > 0 then
				szListText	= szListText .. "<goto=20><color=red>Chúc phúc: <color><goto=200>" .. string.format("<color=yellow><a=openpray:>%d cơ hội<color><a>", nPrayTimes) .. "<linegap=10>\n";
			else
				szListText	= szListText .. "<goto=20><color=green>Chúc phúc: <color><goto=200><color=green>Rồi<color><linegap=10>\n";
			end
		end
	end

		local nFuCount, nFuLimit	= self:GetFuDaiCountAndLimit(); -- أռʹԃʏО
		if (nFuCount >= 11) then
			szListText	= szListText .. "<goto=20><color=pink>Số túi phúc mở trong ngày: <color><goto=200>" .. string.format("<color=pink>%d/%d<color>", nFuCount, nFuLimit) .. "<linegap=10>\n";
		end
		if (nFuCount == 10) then
			szListText	= szListText .. "<goto=20><color=green>Số túi phúc mở trong ngày: <color><goto=200>" .. string.format("<color=green>%d/%d<color>", nFuCount, nFuLimit) .. "<linegap=10>\n";
		end
		if (nFuCount <= 9) then
			szListText	= szListText .. "<goto=20><color=red>Số túi phúc mở trong ngày: <color><goto=200>" .. string.format("<color=red>%d/%d<color>", nFuCount, nFuLimit) .. "<linegap=10>\n";
		end

		if (me.nLevel >= 20) then
			local nBaoCount = self:GetBaoCount();
			if (nBaoCount >= 11) then
				szListText	= szListText .. "<goto=20><color=Pink>Bao Vạn Đồng: <color><goto=200>" .. string.format("<color=pink>%d/10<color>", nBaoCount) .. "<linegap=10>\n";
			end
			if (nBaoCount == 10) then
				szListText	= szListText .. "<goto=20><color=green>Bao Vạn Đồng: <color><goto=200>" .. string.format("<color=green>%d/10<color>", nBaoCount) .. "<linegap=10>\n";
			end
			if (nBaoCount <= 9) then
				szListText	= szListText .. "<goto=20><color=red>Bao Vạn Đồng: <color><goto=200>" .. string.format("<color=red>%d/10<color>", nBaoCount) .. "<linegap=10>\n";
			end
		end

		if (me.nLevel >= 50) then
			local nBaiCount = self:GetBaihutangCount();
			if (nBaiCount >= 1) then
				szListText	= szListText .. "<goto=20><color=green>Bạch Hổ Đường: <color><goto=200>" .. string.format("<color=green>%d/1<color>", nBaiCount) .. "<linegap=10>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Bạch Hổ Đường: <color><goto=200>" .. string.format("<color=red>%d/1<color>", nBaiCount) .. "<linegap=10>\n";
			end
		end

		if (me.nLevel >= 90) then
			--local nJYTS	= me.GetTask(1022, 187);
			local nFLS	= me.GetTask(1022, 200);
			local nBMS	= me.GetTask(1022, 201);
			local nHWM	= me.GetTask(1022, 202);
			szListText = szListText .. string.format("<goto=20><color=red>[HậuSơn/BáchManSơn/HảiLăng] <color><goto=200><color=yellow>%d/%d/%d<color>",nFLS,nBMS,nHWM) .. "<linegap=10>\n";			
		end

		local nDayEnterFB = Task.tbArmyCampInstancingManager:EnterInstancingThisDay(1,me.nId);
		if (nDayEnterFB>= 4) then
			szListText = szListText .. "<goto=20><color=red>Số lần vào phó bản: <color><goto=200>" .. string.format("<color=gray>4/4<color>") .. "<linegap=10>\n";
		else
			szListText = szListText .. "<goto=20><color=red>Số lần vào phó bản: <color><goto=200>" .. string.format("<color=red>%d/4<color>", nDayEnterFB) .. "<linegap=10>\n";
		end
		if (me.nLevel >= 30) then
			local nGetAward,nAllCount = GuessGame:GetAnswerCount(me);
			if (nAllCount >= 30) then
				szListText	= szListText .. "<goto=20><color=green>Câu trả lời Hoa Đăng: <color><goto=200>" .. string.format("<color=green>%d/30<color>",nAllCount) .. "<linegap=10>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Câu trả lời Hoa Đăng: <color><goto=200>" .. string.format("<color=yellow>%d/30<color>",nAllCount) .. "<linegap=10>\n";
			end
		end
		if (me.nLevel >= 90) then
			local nBingShuCount = Task.tbArmyCampInstancingManager:GetBingShuReadTimesThisDay(me.nId);
			if (nBingShuCount >= 1) then
				szListText	= szListText .. "<goto=20><color=green>Tôn Tử Binh Pháp: <color><goto=200>" .. string.format("<color=green>Rồi<color>") .. "<linegap=10>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Tôn Tử Binh Pháp: <color><goto=200>" .. string.format("<color=red>Chưa<color>") .. "<linegap=10>\n";
			end
		end

		if (me.nLevel >= 90) then
			local nJiGuanShuCount = Task.tbArmyCampInstancingManager:JiGuanShuReadedTimesThisDay(me.nId);
			if (nJiGuanShuCount >= 1) then
				szListText	= szListText .. "<goto=20><color=green>Cơ Quan Thuật: <color><goto=200>" .. string.format("<color=green>Rồi<color>") .. "<linegap=10>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Cơ Quan Thuật: <color><goto=200>" .. string.format("<color=red>Chưa<color>") .. "<linegap=10>\n";
			end
		end
		if (me.nLevel >= 80) then
			local nXYTimes = me.GetTask(XoyoGame.TASK_GROUP, XoyoGame.REPUTE_TIMES);
			local nXYDate = me.GetTask(XoyoGame.TASK_GROUP, XoyoGame.CUR_REPUTE_DATE);
			local nXYCurDate = tonumber(os.date("%Y%m%d",GetTime()));
			if nXYDate ~= nXYCurDate then
				nXYTimes = 0;
			end
                        if (nXYTimes == XoyoGame.MAX_REPUTE_TIMES) then
				szListText	= szListText .. "<goto=20><color=green>Nguyên liệu đã đổi ở Tiêu Dao Cốc:<color><goto=200>" .. string.format("<color=green>ӑΪԉ<color>") .. "<linegap=10>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Nguyên liệu đã đổi ở Tiêu Dao Cốc:<color><goto=200>" .. string.format("<color=red>%d/%d<color>", nXYTimes, XoyoGame.MAX_REPUTE_TIMES) .. "<linegap=10>\n";
			end
		end
		if (me.nLevel >= 50) then
			local nTaskNum = me.GetTask(2040,2);
			if (nTaskNum == 0) then
			szListText	= szListText .. "<goto=20><color=green>Số nhiệm vụ truy nã trong ngày:<color><goto=200>" .. string.format("<color=yellow>%d<color>", nTaskNum) .. "<linegap=10>\n";
			else
			szListText	= szListText .. "<goto=20><color=red>Số nhiệm vụ truy nã trong ngày:<color><goto=200>" .. string.format("<color=yellow>%d<color>", nTaskNum) .. "<linegap=10>\n";
			end
		end
	end

	szListText	= szListText .. "<goto=20><color=green>Đồng Khóa:<color><goto=200>" .. string.format("<color=green>%d<color>",me.nBindCoin-nBindCionLogin) .. "<linegap=10>\n";
	szListText	= szListText .. "<goto=20><color=green>Bạc khóa:<color><goto=200>" .. string.format("<color=green>%d<color>",me.GetBindMoney()-nBindMoneyLogin) .. "<linegap=10>\n";
	szListText	= szListText .. "<goto=20><color=green>Bạc:<color><goto=200>" .. string.format("<color=green>%d<color>",me.nCashMoney-nActiveMoneyLogin) .. "<linegap=10>\n";
	szListText	= szListText .. "<color=yellow><a=qingling:>(Xoá thống kê tiền)<a><color>\r";
	self:SetListText(szListText);

end

uiHelpSprite._Int=function(self)
	uiHelpSprite.EnterGame_bak	= uiHelpSprite.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiHelpSprite.EnterGame_bak(Ui);
		uiHelpSprite:LoginAccord();
	end
end

uiHelpSprite:_Int();

uiHelpSprite.LoginAccord=function(self)
	nBindMoneyLogin                     = me.GetBindMoney();
	nBindCionLogin                      = me.nBindCoin;
	nActiveMoneyLogin                   = me.nCashMoney;
end

function uiHelpSprite:Link_qingling_OnClick(szWnd, szGroupId)
	nBindMoneyLogin                     = me.GetBindMoney();
	nBindCionLogin                      = me.nBindCoin;
	nActiveMoneyLogin                   = me.nCashMoney;
	uiHelpSprite:OnUpdatePage_Page1();
end
