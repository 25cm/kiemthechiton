--武林联赛
--孙多良
--2008.09.12

local tbNpc = {};
Wlls.DialogNpc = tbNpc;

function tbNpc:OnDialog(nGameLevel, nFlag)
	local nCheck, nRank = Wlls:OnCheckAward(me, nGameLevel);
	if nCheck == 1 and not nFlag then
		local tbSel = {
			{"Nhận thưởng", Wlls.OnGetAward, Wlls, nGameLevel},
			{"等会再领取奖励",self.OnDialog, self, nGameLevel, 1},
			{"Kết thúc đối thoại"},
		}
		Dialog:Say(string.format("Quan liên đấu: Chiến của bạn đã xếp thứ <color=yellow>%s<color>, sau khi nhận phần thưởng nhóm sẽ giải tán. Bạn có muốn nhận thưởng không?", nRank), tbSel);
		return 0;		
	end
	local nMacthType = Wlls:GetMacthType();
	local tbMacthCfg = Wlls:GetMacthTypeCfg(nMacthType);
	local szGameLevelName = Wlls.MACTH_LEVEL_NAME[nGameLevel];
	local szDesc = (tbMacthCfg and tbMacthCfg.szDesc) or "";
	local szMsg = string.format("<color=red>Võ Lâm Liên Đấu<color> chưa mở!", szGameLevelName, szDesc, Wlls.DEF_STATE_MSG[Wlls:GetMacthState()]);
	local tbOpt = 
	{
		{"Mua trang bị <color=yellow>Danh Vọng Liên Đấu<color>", self.BuyEquire, self},
		{"Kêt thúc"},
	};
	if Wlls:GetMacthState() == Wlls.DEF_STATE_REST then
		table.insert(tbOpt, 5, {string.format("Nhận thưởng Võ Lâm Liên Đấu %s", szGameLevelName), Wlls.OnGetAward, Wlls, nGameLevel});
	end
	
	if Wlls:GetMacthState() == Wlls.DEF_STATE_ADVMATCH then
		table.insert(tbOpt, 2, {"<color=yellow>观看八强赛战况<color>", Wlls.OnLookDialog, Wlls});	
	end
	
	Dialog:Say(szMsg, tbOpt);
end
function tbNpc:BuyEquire()
	me.OpenShop(134, 1) --使用声望购买
end