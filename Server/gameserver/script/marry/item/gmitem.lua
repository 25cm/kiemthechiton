-- 文件名　：gmitem.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-29 11:16:29
-- 功能描述：结婚系统道具（gm到场道具）

local tbItem = Item:GetClass("marry_gmitem");

--===================================================

-- 结婚面具gdpl（用的是司仪面具）
tbItem.MASK_GDPL = {1, 13, 41, 1};

-- gm可以选择的祝福
tbItem.TB_ZHUFU = {
	[1] = "Tinh yêu ",
	[2] = "Một nhóm thành viên",
	[3] = "Hi, Vợ chồng hạnh phúc",
	[4] = "Tiếng chuông kêu vang, trái tim đến với trái tim",
	[5] = "Buổi lễ vui mừng nhộn nhịp",
	[6] = "Vợ chồng sống trăm năm hạnh phúc",
	[7] = "Qua suốt thế kỷ ",
	[8] = "Bài hát ý nghĩa của trời và đất",
	};

-- 撒钱技能的特效及范围
tbItem.SKILL_INFO = {nSkillId = 1559, nRange = 50, nAddMoney = 100};

--===================================================


function tbItem:OnUse()
	local szMsg = "GM dùng đạo cụ để thực hiện một số hoạt động";
	local tbOpt = {};
	table.insert(tbOpt, {"Buổi lễ thành hôn", self.SendZhufuDlg, self});
	table.insert(tbOpt, {"Hoa tình yêu", self.GetQingHuaDlg, self});
	table.insert(tbOpt, {"Rắc tiền cho các khách mời", self.ThrowMoney, self});
	
	if (self:CheckGotMask(it.dwId) ~= 1) then
		table.insert(tbOpt, 1, {"Đối với lễ mặt nạ", self.GetWeddingMask, self, it.dwId});
	end
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	
	Dialog:Say(szMsg, tbOpt);
end

--========================================================================

-- 检查是否已经领取过结婚面具
function tbItem:CheckGotMask(dwItemId)
	local bHasGotMask = 0;
	local pItem = KItem.GetObjById(dwItemId);
	if (pItem) then
		local tbItemDate = pItem.GetTempTable("Marry");
		if (tbItemDate and tbItemDate.bHasGotMask and tbItemDate.bHasGotMask == 1) then
			bHasGotMask = 1;
		end
	end
	return bHasGotMask;
end

-- 获取结婚面具
function tbItem:GetWeddingMask(dwItemId)
	local pItem = KItem.GetObjById(dwItemId);
	if (not pItem) then
		return 0;
	end
	
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hãy làm sạch 1 không gian");
		return 0;
	end
	
	me.AddItem(unpack(self.MASK_GDPL));
	local tbItemDate = pItem.GetTempTable("Marry");
	tbItemDate.bHasGotMask = 1;
	return 1;
end

--========================================================================
-- 送出祝福
function tbItem:SendZhufuDlg()
	local szMsg = "Bạn có thể chọn từ an lành";
	local tbOpt = {};
	for nIndex, szZhufuMsg in ipairs(self.TB_ZHUFU) do
		table.insert(tbOpt, {szZhufuMsg, self.SendZhufu, self, nIndex});
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:SendZhufu(nIndex)
	local szZhufuMsg = self.TB_ZHUFU[nIndex];
	if (not szZhufuMsg) then
		return 0;
	end
	
	szZhufuMsg = string.format("<color=orange>[GM：%s]<color> Chúc phúc cho 2 bạn", me.szName, szZhufuMsg);
	
	local tbPlayerList = Marry:GetAllPlayers(me.nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		Dialog:SendInfoBoardMsg(pPlayer, szZhufuMsg);
	end
end

--========================================================================
-- 获得情花
function tbItem:GetQingHuaDlg()
	Dialog:AskNumber("Xin vui lòng nhập số hoa tình yêu:", 10000, self.GetQingHua, self);
end

function tbItem:GetQingHua(nNum)
	if (not nNum or nNum <= 0) then
		Dialog:Say("Số lượng bạn nhập vào không đúng xin vui lòng nhập lại");
		return 0;
	end
	
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hãy làm sạch một không gian rồi hãy trở lại");
		return 0;
	end
	
	me.AddStackItem(Marry.ITEM_QINGHUA_ID[1], Marry.ITEM_QINGHUA_ID[2], Marry.ITEM_QINGHUA_ID[3],
		Marry.ITEM_QINGHUA_ID[4], {bForceBind = 1}, nNum);
	
	Dbg:WriteLog("Marry", "Hôn nhân hệ thống", me.szName, me.szAccount, string.format("GM loại bỏ các bông hoa tình yêu không hợp lệ", nNum));
end

--========================================================================
-- 撒钱
function tbItem:ThrowMoney()
	me.CastSkill(self.SKILL_INFO.nSkillId, 1, -1, me.GetNpc().nIndex);
	local tbPlayerList = KPlayer.GetAroundPlayerList(me.nId, self.SKILL_INFO.nRange);
	local nSum = 0;
	for _, pPlayer in pairs(tbPlayerList) do
		if (pPlayer) then
			pPlayer.AddBindMoney(self.SKILL_INFO.nAddMoney, Player.emKBINDMONEY_ADD_MARRY);
			nSum = nSum + self.SKILL_INFO.nAddMoney;
		end
	end
	Dbg:WriteLog("Marry", "Hôn nhân hệ thống", me.szName, me.szAccount, string.format("GM đã đưa ra một tiệc bạc, mỗi % phát sinh s, phát hành tổng cộng % s", self.SKILL_INFO.nAddMoney, nSum));
end
