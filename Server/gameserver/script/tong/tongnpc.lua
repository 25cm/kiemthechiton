-------------------------------------------------------------------
--File: tongnpc.lua
--Author: lbh
--Date: 2007-9-19 23:21
--Describe: 帮会相关npc对话逻辑
-------------------------------------------------------------------
if not Tong then --调试需要
	Tong = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

function Tong:DlgCreateTong(bConfirm, szTong, nCamp)
	if me.IsCaptain() ~= 1 then
		Dialog:Say("Bạn không phải đội Trưởng,hãy nói đội trưởng tới gặp ta")
		return 0
	end	
	local nTeamId = me.nTeamId
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId) 
	if not anPlayerId or not nPlayerNum or nPlayerNum < 1 then 
		Dialog:Say("1 tộc trưởng lập tổ đội rồi đến gặp ta")
		return 0
	end
	if me.dwTongId ~= 0 then
		Dialog:Say("Bạn đã có Bang hội,không thể lập Bang")
		return 0
	end
	local anKinId = {}
	local nSelfKinId, nSelfMemberId = me.GetKinMember()
	local cSelfKin = KKin.GetKin(nSelfKinId)	
	if not cSelfKin or cSelfKin.GetCaptain() ~= nSelfMemberId then		
		me.Msg("Bạn không phải Tộc Trưởng.không thể tham gia tạo Bang")
		return 0
	end
	table.insert(anKinId, nSelfKinId)
	local aLocalPlayer, nLocalPlayerNum = me.GetTeamMemberList()
	--TODO:判断是否在周围
	if nPlayerNum ~= nLocalPlayerNum then
		Dialog:Say("Tất cả Tộc Trưởng phải tập trung tại đây")
		return 0
	end	
	--创建扣取金钱说明
	if bConfirm ~= 1 then
		Dialog:Say("Để lập Bang cần có 100 Vạn Lượng，Trong 2 tuần thử nghiệm, Ngân Quỹ bang hội phải lớn hơn 1000 Vạn lượng，Nếu không thì Bang Hội tự tan rã，<color=yellow>Chi phí lập bang là 100 Vạn Lượng và sẽ không hoàn trả<color> Nhà Ngươi có muốn lập Bang？", 
			{{"Vâng ，Ta Muốn lập Bang", self.DlgCreateTong, self, 1}, {"Để Ta suy nghĩ thêm"}})
			return 0
	end
	if me.nCashMoney < self.CREATE_TONG_MONEY then
		Dialog:Say("Nhà ngươi không mang đủ <color=yellow>"..(self.CREATE_TONG_MONEY / 10000).."Vạn Lượng<color>，Không thể lập Bang")
		return 0
	end	
	for i, cPlayer in ipairs(aLocalPlayer) do
		if cPlayer.nPlayerIndex ~= me.nPlayerIndex then
			if cPlayer.dwTongId ~= 0 then
				Dialog:Say("Một thành viên trong đội của ngươi đã có Bang hội.không thể lập bang")
				return 0
			end
			local nKinId, nMemberId = cPlayer.GetKinMember()
			if Kin:CheckSelfRight(nKinId, nMemberId, 1) ~= 1 then
				me.Msg("Những Tộc trưởng trong nhóm của ngươi không đủ điều kiện.Quay lại gặp ta sau")
				return 0
			end
			table.insert(anKinId, nKinId)
		end
	end
	if not szTong or szTong == "" then
		me.CallClientScript{"Tong:ShowCreateTongDlg"}
		return 0
	end
	local nRet = self:CreateTong_GS1(anKinId, szTong, nCamp, me.nId);
	if nRet ~= 1 then		
		local szMsg = "Thành lập Bang Thất Bại"
		if nRet == -1 then
			szMsg = szMsg.."Chiều dài tên Bang chỉ từ 3-6 kí tự"
		elseif nRet == -2 then
			szMsg = szMsg.."Tên Bang không hợp lệ"
		elseif nRet == -3 then
			szMsg = szMsg.."Tên Bang không hợp lệ,vui lòng nhập tên khác"
		elseif nRet == -4 then
			szMsg = szMsg.."Tên Bang đã tồn tại"
		elseif nRet == -5 then
			szMsg = szMsg.."Nhóm của bạn có thành viên đã có Bang"
		end
		Dialog:Say(szMsg);
		return 0
	end
	return 1
end

function Tong:DlgChangeCamp(nCamp)
	local nTongId = me.dwTongId;
	if nTongId == 0 then
		Dialog:Say("Bạn chưa gia nhập Bang, Không thể thay đổi Phe")
		return 0;
	end
	local nKinId, nMemberId = me.GetKinMember();
	if self:CheckSelfRight(nTongId, nKinId, nMemberId, self.POW_CAMP) ~= 1 then
		Dialog:Say("Bạn Không có quyền Đổi Phe");
		return 0;
	end
	if not nCamp then
		Dialog:Say("Đổi phe bang hội cần :"..(Tong.CHANGE_CAMP / 10000).."vạn ngân quỹ bang.Bạn có muốn thay đổi:",
			{{"Tống", self.DlgChangeCamp, self, 1},
			 {"Kim", self.DlgChangeCamp, self, 2},
			 {"Trung Lập", self.DlgChangeCamp, self, 3},
			 {"Để Ta suy nghĩ thêm"}
			});
	else 
		self:ChangeCamp_GS1(nCamp);		
	end
end

-- 领取分红
function Tong:DlgTakeStock(bConfirm)
	local nTongId = me.dwTongId;
	local pTong = KTong.GetTong(nTongId)
	if not pTong then
		Dialog:Say("Bạn chưa có Bang không thể nhận được lợi tức.")
		return 0
	end
	
	local nTotalFund = pTong.GetBuildFund();
	local nTotalStock = pTong.GetTotalStock();
	local nKinId, nMemberId = me.GetKinMember();
	local pKin = KKin.GetKin(nKinId);
	local pMember = pKin.GetMember(nMemberId);
	local nPersonalStock = pMember.GetPersonalStock();
	local nCurWeek = tonumber(os.date("%Y%W", GetTime()))
	if nTotalFund == 0 or nTotalStock == 0 or nPersonalStock == 0 then
		Dialog:Say("Bạn Không nhận được hàng");
		return 0;
	end
	local nTakePercent = pTong.GetLastTakeStock()
	if nTakePercent <= 0 then
		Dialog:Say("Bang của bạn vào tuần trước đã không xác định tỷ lệ lợi nhuận chia sẻ. Tuần này không cho phép cổ tức.");
		return 0;
	end
	local nWeeks = me.GetTask(self.TONG_TASK_GROUP, self.TONG_TAKE_STOCK_WEEKS);
	if nWeeks == nCurWeek then
		Dialog:Say("Bạn có nhận cổ tức trong tuần này.");
		return 0;
	end
	local szMsg = "";
	local tbOpt = {};
	local nTakeStock = math.floor(nTakePercent * nPersonalStock / 100);
	local nTakeMoney = math.floor(nTakeStock * nTotalFund / nTotalStock);
	local nMoney = math.floor(nPersonalStock * nTotalFund / nTotalStock);
	if pTong.GetBuildFund() < self.MIN_BUILDFUND then
		Dialog:Say("Bang của bạn kinh phí xây dựng là nhỏ hơn"..self.MIN_BUILDFUND..", Không đủ điều kiện cho cổ tức.")
		return 0;
	end
	if not bConfirm then
		szMsg = string.format([[  Thực tế chính của bạn tỷ lệ chia sẻ lợi nhuận trong tuần này được thiết lập <color=green>%d%% <color>. Theo đó, tuần này bạn có thể nhận được cổ tức của các Bang <color=green>%d<color> bị ràng buộc so với .
Bạn có thể chọn để nhận cổ tức, nhận được, tài sản cá nhân của bạn và tỷ lệ vốn chủ sở hữu sẽ được giảm tương ứng.]], 
			nTakePercent, nTakeMoney);
		tbOpt = {
			{"Xác Nhận Lãnh", self.DlgTakeStock, self, 1},
			{"Kết thúc đối thoại。"},
		}
	else
		if bConfirm and bConfirm == 1 then
			if me.GetBindMoney() + nTakeMoney > me.GetMaxCarryMoney() then
				Dialog:Say("Xin lỗi, bạn thực hiện so với đã đạt mức tối đa, kết thúc và sau đó nhận được.");
				return 0;
			end
			me.SetTask(self.TONG_TASK_GROUP, self.TONG_TAKE_STOCK_WEEKS, nCurWeek)
			return GCExcute{"Tong:TakeStock_GC", nTongId, nKinId, nMemberId};
		end
	end
	Dialog:Say(szMsg,tbOpt);
end

function Tong:DlgGreatBonus()	
	local pTong = KTong.GetTong(me.dwTongId);
	if not pTong then
		Dialog:Say("Bạn đã nhận thưởng ưu tú");
		return 0;
	end
	Dialog:Say("Thưởng thành viên ưu tú Bang <color=green>"..pTong.GetWeekGreatBonus().."<color>", 
	{
		{"Nhận Thưởng", Tong.ReceiveGreatBonus, Tong},
		{"Kiểm tra quỹ thưởng", Tong.AdjustGreatBonusPercent, Tong},
		{"Đóng"}		
	})
end
