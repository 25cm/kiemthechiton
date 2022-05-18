
local tbNpc = Npc:GetClass("qianzhuang");


function tbNpc:OnDialog()
	if me.IsAccountLock() ~= 0 then
		Dialog:Say("Tài khoản của bạn bị khóa, không thể thực hiện thao tác này!");
		return;
	end
	local tbOpt = {
		{"<color=yellow>Mua Phi Phong<color>", self.OnOpenShop, self, me},
		--{"Đổi ngũ hành hồn thạch", Dialog.Gift, Dialog, "Item.ChangeGift"},
		{"Đổi phi phong", self.SaleMantle, self},
		{"Kết thúc đối thoại"},
	};
	if IVER_g_nSdoVersion == 0 then
		table.insert(tbOpt, 1, {"Tiền trang", self.OpenBank, self});
	end
	Dialog:Say(me.szName.."，ngươi muốn mua gì nào ?",tbOpt);
end

function tbNpc:SaleMantle()
	Shop.MantleGift:OnOpen();
end


function tbNpc:OpenBank()
	if (Bank.nBankState == 0) then
		me.Msg("Không thể mở tiền trang.");
		return ;
	end
	me.CallClientScript({"UiManager:OpenWindow", "UI_BANK"});
end

function tbNpc:OnOpenShop(pPlayer)
	local nSeries = pPlayer.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Vui lòng gia nhập môn phái trước khi vào mua đồ");
		return;
	end
	
	if (1 == nSeries) then
		pPlayer.OpenShop(140, 3);
	elseif (2 == nSeries) then
		pPlayer.OpenShop(141, 3);
	elseif (3 == nSeries) then
		pPlayer.OpenShop(142, 3);
	elseif (4 == nSeries) then
		pPlayer.OpenShop(143, 3);
	elseif (5 == nSeries) then
		pPlayer.OpenShop(144, 3);
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Npc qianzhuang", pPlayer.szName, "There is no Series", nSeries);
	end
end
