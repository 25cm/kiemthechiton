-- 白虎堂报名NPC
local tbNpc = Npc:GetClass("baihutangbaoming");
tbNpc.tbRVPos	= {};
tbNpc.MAX_NUMBER = 100;
tbNpc.HIGHLEVEL  = 90;
tbNpc.tbTimeKey = {};

function tbNpc:Init()
	self.tbTimeKey[7]  = 8;		self.tbTimeKey[18] = 21;
	self.tbTimeKey[19] = 21;	self.tbTimeKey[20] = 21;
end

function tbNpc:OnDialog(szParam)
	local tbOpt = {};	
	local szMsg = "";
	local nTime = self:GetTime();
	
		local nMinute = 30 - tonumber(GetLocalDate("%M"));
		if (nMinute > 0) then
			szMsg = string.format("Hoạt động <color=yellow>Bạch Hổ Đường<color> đã bắt đầu. Đợi <color=green>%d phút<color> sau hãy quay lại", nMinute);
			tbOpt = {"Kết thúc đối thoại"};
	else
		
		local tbMap = self:GetMapList();
		if (not tbMap)then
			return;
		end
		
		local tbMapInfo = {};
		if (szParam == "dong") then
			tbMapInfo.nMapId = tbMap[1][1];
			tbMapInfo.szName =  "Đông Bạch Hổ Đường";
		elseif (szParam == "nan") then
			tbMapInfo.nMapId = tbMap[1][2];
			tbMapInfo.szName =  "Nam Bạch Hổ Đường";
		elseif (szParam == "xi") then
			tbMapInfo.nMapId = tbMap[1][4];
			tbMapInfo.szName =  "Tây Bạch Hổ Đường";
		elseif (szParam == "bei") then	
			tbMapInfo.nMapId = tbMap[1][4];
			tbMapInfo.szName =  "Bắc Bạch Hổ Đường";
		end
		local nRet = MathRandom(#BaiHuTang.tbPKPos);
		tbMapInfo.tbSect = BaiHuTang.tbPKPos[nRet];
	local nNowHour = tonumber(GetLocalDate("%H"));
	if (nNowHour >= 1 and nNowHour <= 7) or (nNowHour >= 18 and nNowHour <= 20) then
	szMsg = string.format("Hoạt động <color=yellow>Bạch Hổ Đường<color> chỉ mở từ <color=green>(8h đến 18h)<color> và <color=green>(22h đến 24h)<color> hàng ngày. Quay lại sau nhé");
	tbOpt = {"Kết thúc đối thoại"};
	else
	szMsg = "<color=yellow>Bạch Hổ Đường<color> chỉ mở từ <color=green>(8h đến 18h)<color> và <color=green>(22h đến 24h)<color> hàng ngày.<enter><enter>+ Đến giờ chỉ định nhấn vào <color=red>Triệu Hồi Boss Bạch Hổ Đường<color> để gọi boss xuất hiện.<enter>+ <color=green>Thủ Lĩnh BHĐ tầng 1<color> xuất hiện khi thời gian còn: <color=gold>25phút<color>.<enter>+ <color=green>Thủ Lĩnh BHĐ tầng 2<color> xuất hiện khi thời gian còn: <color=gold>18phút<color>.<enter>+ <color=green>Thủ Lĩnh BHĐ tầng 3<color> xuất hiện khi thời gian còn: <color=gold>10phút<color>.<enter><enter>Mỗi ngày có thể tham gia <color=red>Bạch Hổ Đường<color> tối đa: <color=yellow>2 lần<color>.";
	
	tbOpt[1] = {"<color=green>Ta muốn tham gia<color>", self.JoinAction, self, tbMapInfo};
	tbOpt[2] = {"Kết thúc đối thoại"};
	end	
	end
	Dialog:Say(szMsg, tbOpt);
end


--获取当前的小时数
function tbNpc:GetTime()
	local nNowHour = tonumber(GetLocalDate("%H"));
	local nNowMinute = tonumber(GetLocalDate("%M"));
	
	local nHour = nNowHour;
	
	if (nNowHour == 7) then
		nHour = 8;
	elseif (nNowHour == 18 or nNowHour == 19 or nNowHour == 20) then
		nHour = 21;
	elseif (nNowHour == 6) then
		if (nNowMinute >= 30) then
			nHour = 8;
		end
	elseif (nNowHour == 17) then
		if (nNowMinute >= 30) then
			nHour = 21;
		end
	else
		if (nNowMinute >= 30) then
			nHour = nHour + 0;
		else
		    nHour = nHour + 0;
		end
	end
	if (nHour == 24) then
		nHour = 0;
	end
	return nHour;
end
--参加PK
function tbNpc:JoinAction(tbMapInfo)
	if (BaiHuTang.nActionState == BaiHuTang.FIGHTSTATE) then
		me.Msg("Hoạt động Bạch Hổ Đường đã bắt đầu, không thể báo danh được nữa.");
		return;
	end
	
	--死亡就不给进 zounan
	local nDead = me.IsDead() or 1;
	if nDead == 1 then
		return;
	end
	
	local nTimes = me.GetTask(BaiHuTang.TSKG_PVP_ACT, BaiHuTang.TSK_BaiHuTang_PKTIMES) or 0;
	local szNowDate =  GetLocalDate("%y%m%d");
	local nDate = math.floor(nTimes / 10);
	local nPKTimes = nTimes % 10;
	local nNowDate = tonumber(szNowDate);
	if (nDate == nNowDate) then
		if (nPKTimes >= BaiHuTang.MAX_ONDDAY_PKTIMES) then
			local nTime = tonumber(GetLocalDate("%H%M"));
			-- 当天23：30分钟前已经参加过了三次
			if (nTime < 2330) then
				me.Msg(string.format("Hoạt động này một ngày chỉ được tham gia <color=green>2 lần<color>, mai hãy đến."));
				return;
			else
				me.SetTask(BaiHuTang.TSKG_PVP_ACT, BaiHuTang.TSK_BaiHuTang_PKTIMES, 0);
			end
		end
	else
		me.SetTask(BaiHuTang.TSKG_PVP_ACT, BaiHuTang.TSK_BaiHuTang_PKTIMES, 0);
	end
	local nTotal  = BaiHuTang.tbNumber[tbMapInfo.nMapId];
	if (nTotal and nTotal >= tbNpc.MAX_NUMBER) then
		me.Msg("Số lượng người vào đã đầy");
		return;
	end
	self:OnTrans(tbMapInfo);	
end
--传送玩家到指定地图
function tbNpc:OnTrans(tbMapInfo)
	local tbSect	= tbMapInfo.tbSect;
	me.Msg("Ngồi yên tới "..tbMapInfo.szName);
	local nMapId = tbMapInfo.nMapId
	local nTotal = BaiHuTang.tbNumber[nMapId] or 0;
	BaiHuTang.tbNumber[nMapId] = nTotal + 1;
	if(1 == BaiHuTang:JoinGame(me.nMapId, me)) then
		me.NewWorld(nMapId, tbSect.nX / 32, tbSect.nY / 32);
	else
	me.Msg("Bạch Hổ Đường chưa mở");
	end
end

function tbNpc:GetMapList()
	local tbMap = {};
	if (me.nMapId == 821) then
		tbMap = BaiHuTang.tbBatte[BaiHuTang.Goldlen].MapId;
	elseif (me.nLevel >= 90) then
		tbMap = BaiHuTang.tbBatte[BaiHuTang.GaoJi].MapId;
	elseif (me.nMapId == 225) then
		tbMap = BaiHuTang.tbBatte[BaiHuTang.ChuJi].MapId;
	end	
	return tbMap;
end
tbNpc:Init();
