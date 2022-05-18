-- �ļ�������jieyinren.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-7
-- ��  ��  ��
local tbNpc = Npc:GetClass("dataosha_city");

function tbNpc:OnDialog()
	local tbOpt = {};
	local szMsg = "Đưa bạn vào một loạt các câu trả lời bí ẩn của Kiếm Thế";	
	tbOpt = {
				{"Nhìn những gì chiến đấu ở đây", self.Apply, self},
				{"Đi theo đội trưỡng", self.OnEnter, self, me.nId},
				--{"Áp dụng cho cuộc phiêu lưu Gia Tộc",self.ApplyKinTong, self, 2, me.nId},
				--{"Vào cuộc phiêu lưu Gia Tộc", self.OnEnterKinTong, self, 2, me.nId},
				--{"Áp dụng cho cuộc phiêu lưu Bang hội",self.ApplyKinTong, self, 3, me.nId},
				--{"Vào cuộc phiêu lưu Bang hội", self.OnEnterKinTong, self, 3, me.nId},
				--{"Mở cuộc hành trình", self.Open, self},
				{"Tôi chỉ đi xem!"},
			};
	Dialog:Say(szMsg, tbOpt);
	return;
end
function tbNpc:Open()
	local szMsg = "";
	local tbOpt ={{"Hủy"},};
	if not CFuben.FubenData[me.nId] then
		szMsg = "Bạn có thể chọn một nơi nào đó để đi";
		Dialog:Say(szMsg, tbOpt);
		return;
	end
	local nTempMapId = CFuben.FubenData[me.nId][1];
	local nDyMapId = CFuben.FubenData[me.nId][2];
	if CFuben.tbMapList[nTempMapId][nDyMapId].IsOpen == 0 then
		CFuben.tbMapList[nTempMapId][nDyMapId].IsOpen = 1;
		CFuben:GameStart(me.nId, CFuben.FubenData[me.nId][2]);
		szMsg = "Mở thành công";
	else
		szMsg = "Đã được mở";		
	end
	Dialog:Say(szMsg, tbOpt);
	return;
end
function tbNpc:OnEnter(nPlayerId)	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then	
		if pPlayer.nTeamId ~= 0 then
			local tbPlayerList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
			if CFuben:IsSatisfy(pPlayer.nId, tbPlayerList[1]) == 0 then
				return;
			end
			CFuben:JoinGame(pPlayer.nId, tbPlayerList[1]);
		else
			pPlayer.Msg("Không có một đội ngũ");
			return;
		end
	end
end

function tbNpc:Apply()	
	local tbOpt = {
					{"Hủy bỏ"},
				};
	local szMsg = "Bí ẩn nơi bạn muốn đi";
	if me.nTeamId ~= 0 then
		for nType, tbFuBen in pairs (CFuben.FUBEN) do
			local nTime = tonumber(KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME));
			local nNowTime = Lib:GetDate2Time(tonumber(GetLocalDate("%Y%m%d"))*10000);
			if tbFuBen.nFlag == 1 and nNowTime - nTime >= tbFuBen.nTime * 24 * 3600 then			
				table.insert(tbOpt,1,{tbFuBen.szName,self.ApplyEx,self, tbFuBen, nType});
			end
		end
	else
		szMsg = "Bạn không phải đội trưỡng k thể dẫn đồng đội bạn đi";
	end	
	Dialog:Say(szMsg, tbOpt);
	return;
end

function tbNpc:ApplyEx(tbFuBen, nType)	
	local tbOpt = {
					{"Hủy bỏ"},
				};
	local szMsg = "Muốn đến nơi đặc biệt đó";	
	local nTime = tonumber(KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME));
	local nNowTime = Lib:GetDate2Time(tonumber(GetLocalDate("%Y%m%d"))*10000);	
	for nId, tbFuBenEx in pairs (tbFuBen) do
		if type(tbFuBenEx) == "table" then
			if nNowTime - nTime >= tbFuBenEx.nTime * 24 * 3600 then
				table.insert(tbOpt,1,{tbFuBenEx.szName,self.Apply_Ex,self, nId, nType});
			end
		end
	end	
	Dialog:Say(szMsg, tbOpt);
	return;
end

function tbNpc:Apply_Ex(nId, nType)
	CFuben:ApplyFuBenEx(nType, nId, me.nId);	--Phó bản ứng dụng
	return;
end

function tbNpc:ApplyKinTong(nFlag, nPlayerId)
	local tbOpt = {
					{"Hủy bỏ"},
				};
	local szMsg = "Bạn có thể chọn một nơi để xem";	
	local nTime = tonumber(KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME));
	local nNowTime = Lib:GetDate2Time(tonumber(GetLocalDate("%Y%m%d"))*10000);	
	for nType, tbFuBen in pairs (CFuben.FUBEN) do
		for nId, tbFuBenEx in pairs (tbFuBen) do
			if type(tbFuBenEx) == "table" then
				if nNowTime - nTime >= tbFuBenEx.nTime * 24 * 3600 and tbFuBenEx.nGroupModel == nFlag then
					table.insert(tbOpt,1,{tbFuBenEx.szName,self.ApplyKinTongEx,self, nType, nId, nFlag, nPlayerId});
				end
			end
		end
	end
	Dialog:Say(szMsg, tbOpt);
	return;
end

function tbNpc:ApplyKinTongEx(nType, nId, nFlag, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then		
		local nKinId, nExcutorId = pPlayer.GetKinMember();
		if nKinId == 0 or nExcutorId == 0 then
			pPlayer.Msg("Bạn không có sự cho phép của Tộc trưỡng");
			return 0;
		end
		local cKin = KKin.GetKin(nKinId)
		if not cKin then 
			return 0
		end
		local cMember = cKin.GetMember(nExcutorId);
		if not cMember then
			return 0;
		end
		if nFlag == 2 then
			local nFigure = cMember.GetFigure();
			if nFigure ~= 1 then
				pPlayer.Msg("Bạn không có Bang Hội");
				return 0;
			end
			print(nType,nId,nPlayerId)
			CFuben:ApplyFuBenEx(nType, nId, nPlayerId);
		else
			local nTongId = pPlayer.dwTongId;
			if pTong == 0 then
				Dialog:Say("Bạn không phải thành viên chính thức");
				return 0;
			end
			local nSelfKinId, nSelfMemberId = pPlayer.GetKinMember();
			if Tong:CheckSelfRight(nTongId, nSelfKinId, nSelfMemberId, 32) ~= 1 then
				pPlayer.Msg("Bạn không phải thành viên chính thức");
				return 0;
			end
			CFuben:ApplyFuBenEx(nType, nId, nPlayerId);
		end
	end
end

function tbNpc:OnEnterKinTong(nFlag, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then		
		if nFlag == 2 then
			local nKinId = pPlayer.dwKinId;
			if nKinId == 0 then
				pPlayer.Msg("Không có Gia tộc");
				return;
			end
			local nFlagEx , nPlayerIdEx =  CFuben:FindFunben(nFlag,nKinId);
			if nFlagEx== 0 then
				pPlayer.Msg("Gia Tộc của bạn đã không áp dụng cho phó bản");
				return;
			else
				if CFuben:IsSatisfy(me.nId, nPlayerIdEx) == 0 then
					return;
				end
				CFuben:JoinGame(me.nId, nPlayerIdEx);
			end
		else
			local nTongId = pPlayer.dwTongId;
			if nTongId == 0 then
				pPlayer.Msg("Bạn không có một Bang hội");
				return;
			end
			local nFlagEx , nPlayerIdEx =  CFuben:FindFunben(nFlag,nTongId);
			if nFlagEx== 0 then
				pPlayer.Msg("Bang hội của bạn đã không áp dụng cho phó bản");
				return;
			else
				if CFuben:IsSatisfy(me.nId, nPlayerIdEx) == 0 then
					return;
				end
				CFuben:JoinGame(me.nId, nPlayerIdEx);
			end
		end
	end
end
