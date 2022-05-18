
local tbYanLianDaShi = Npc:GetClass("yeliandashi");

function tbYanLianDaShi:OnDialog()

	-- 剥离选项：by zhangjinpin@kingsoft
	local tbOpt = {
			{"<color=yellow>Cường hóa Trang Bị<color>", self.CheckPermission, self, {self.SelectMoneyType, self, Item.ENHANCE_MODE_ENHANCE}},
			{"Tách Huyền Tinh", self.CheckPermission, self, {me.OpenEnhance, Item.ENHANCE_MODE_PEEL, Item.BIND_MONEY}},
			{"Ghép Huyền Tinh", self.CheckPermission, self, {self.SelectMoneyType, self, Item.ENHANCE_MODE_COMPOSE}},
			{"Phân Giải Huyền Tinh cấp cao", self.CheckPermission, self, {Dialog.Gift, Dialog, "Item.tbGift"}},
			--{"Tăng cấp Ngũ Hành Ấn", self.CheckPermission, self, {me.OpenEnhance, Item.ENHANCE_MODE_UPGRADE, Item.BIND_MONEY}},
			{"<color=green>Luyện Hóa<color=yellow>", self.CheckPermission, self, {me.OpenEnhance, Item.ENHANCE_MODE_REFINE, Item.BIND_MONEY}},
			{"Muốn tách huyền tinh từ trang bị +12 trở lên", self.CheckPermission, self, {self.ApplyPeelHighEquip, self}};
			{"Ta muốn hủy bỏ tách", self.CheckPermission, self, {self.CancelPeelHighEquip, self}};
			{"Ta chỉ tình cờ đi ngang qua"},
		};


	
	Dialog:Say("Cường hóa làm tăng thuộc tính của trang bị,cũng như giúp kích hoạt những thuộc tính ẩn,cấp cường hóa càng cao thuộc tính trang bị càng cao", tbOpt);
end

function tbYanLianDaShi:SelectMoneyType(nMode)
		local szMsg = "Lựa chọn";
		if nMode == Item.ENHANCE_MODE_ENHANCE then
			szMsg = "Bạn muốn nhận bạc?";
		elseif nMode == Item.ENHANCE_MODE_STRENGTHEN then
			szMsg = "Bạn muốn nhận bạc?";
		else
			szMsg = "Bạn muốn nhận bạc?";
		end
		Dialog:Say(szMsg,
			{
				{"Bạc Khóa", me.OpenEnhance, nMode, Item.BIND_MONEY},
				{"Bạc Thường", me.OpenEnhance, nMode, Item.NORMAL_MONEY},
				{"Ta chỉ ghé ngang qua"},
			});
		return 0;
end

function tbYanLianDaShi:CheckPermission(tbOption)
	if me.IsAccountLock() ~= 0 then
		Dialog:Say("Tài Khoản của bạn đang ở trạng thái khóa bảo vệ,nên không thực hiện thao tác được");
		return;
	end
	Lib:CallBack(tbOption);
end

-- 申请装备剥离
function tbYanLianDaShi:ApplyPeelHighEquip()	
	local szMsg = "Tách trang bị cường hóa cao là việc khó khăn,ta cần chuẩn bị <color=red>(3giờ)<color>，Sau thời gian đó hãy quay lại gặp ta";
	local tbOpt = {
			{"Tôi muốn tách huyền tinh", Item.ApplyPeelHighEquipSure, Item},
			{"Hủy bỏ"}
		};
	Dialog:Say(szMsg, tbOpt);	
end

-- 取消装备剥离
function tbYanLianDaShi:CancelPeelHighEquip()
	local szMsg = "Bạn muốn thực hiện tách huyền tinh?";
	local tbOpt = {
			{"Có", Item.CancelPeelHighEquipSure, Item},
			{"Không"}
		};	
	Dialog:Say(szMsg, tbOpt);	
end
