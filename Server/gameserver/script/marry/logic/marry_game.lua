-------------------------------------------------------
-- 文件名　：marry_game.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-21 16:39:35
-- 文件描述：结婚小游戏
-------------------------------------------------------

Require("\\script\\marry\\logic\\marry_def.lua");

if (not MODULE_GAMESERVER) then
	return 0;
end

local tbMiniGame = Marry.MiniGame or {};
Marry.MiniGame = tbMiniGame;

--==================================================================

tbMiniGame.FULINMEN_TEMPLATE_ID = 6615;

-- npc福临门的坐标，对应的是4个不同等级的地图
tbMiniGame.TB_POS_FULINMEN = {
	[1] = {1740, 3175},
	[2] = {1588, 3188},
	[3] = {1671, 3106},
	[4] = {1560, 3253},
	};
	
tbMiniGame.STEP_GAME_DABAOZHU	= 1;	-- 游戏，大爆竹
tbMiniGame.STEP_GAME_TONGXINSHU	= 2;	-- 游戏，采摘同心果
tbMiniGame.STEP_GAME_CAIBAOTU	= 3;	-- 游戏，幸运财宝兔

tbMiniGame.TB_GAME_NAME = {
	[tbMiniGame.STEP_GAME_DABAOZHU] = "Đốt Pháo",
	[tbMiniGame.STEP_GAME_TONGXINSHU] = "Hái quả Đồng Tâm",
	[tbMiniGame.STEP_GAME_CAIBAOTU] = "Trò Chơi Bảo Thố",
	};

tbMiniGame.CAIBAOTU_ITEM_GDPL = {18, 1, 608, 1};			-- 财宝兔道具gdpl
tbMiniGame.BAOXIANG_GDPL_SMALL = {18, 1, 610, 1};	-- 财宝兔兑换成的小宝箱gdpl
tbMiniGame.BAOXIANG_GDPL_BIG = {18, 1, 609, 1};		-- 财宝兔兑换成的大宝箱gdpl
tbMiniGame.TB_BOXINFO = {
	{nCount = 10, szName = "Rương Thần Tài (lớn)", tbGDPL = {18, 1, 609, 1}},
	{nCount = 1, szName = "Rương Thần Tài (nhỏ)", tbGDPL = {18, 1, 610, 1}},
	};

--==================================================================

-- 召唤出小游戏的管理者npc（福临门）
function tbMiniGame:CallMiniGameNpc(nMapId)
	local nWeddingMapLevel = Marry:GetWeddingMapLevel(nMapId);
	local tbPos = self.TB_POS_FULINMEN[nWeddingMapLevel];
	if (not tbPos) then
		return 0;
	end
	KNpc.Add2(self.FULINMEN_TEMPLATE_ID , 120, -1, nMapId, unpack(tbPos));
end

function tbMiniGame:CheckPlayer()
	local szErrMsg = "";
	local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId);
	if (2 ~= #tbCoupleName) then
		return 0, szErrMsg;
	end
	
	if (me.szName ~= tbCoupleName[1] and me.szName ~= tbCoupleName[2]) then
		szErrMsg = "Mời hai vị hiệp lữ bắt đầu trò chơi";
		return 0, szErrMsg;
	end
	return 1;
end

function tbMiniGame:OnDialog(nNpcId)
	local szMsg = "Ở đây chân náo nhiệt quá ! Ta cũng thấy hứng khởi ! \n ta có chuẩn bị một trò chơi nhỏ để chúc mừng, hãy chọn trò chơi muốn tham gia ?";
	local tbOpt = {
		{"<color=yellow>Đốt pháo<color>", self.DabaozhuDlg, self},
		{"<color=yellow>Hái quả Đồng Tâm<color>", self.TongxinguoDlg, self},
		{"<color=yellow>Trò chơi Bảo Thố<color>", self.CaibaoTuDlg, self},
		{"Đổi Rương Thần Tài", self.Change2BoxDlg, self},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 获取当前进行到了第几个游戏
function tbMiniGame:GetCurStep(nMapId)
	return Marry:GetMiniGameStep(nMapId) or 0;
end

-- 设置当前进行到了第几个游戏
function tbMiniGame:SetCurStep(nMapId, nNewStep)
	return Marry:SetMiniGameStep(nMapId, nNewStep);
end

-- 进入下一个游戏环节
function tbMiniGame:NextStep(nMapId)
	local nCurStep = math.floor(self:GetCurStep(nMapId));
	self:SetCurStep(nMapId, nCurStep + 1);
end

-- 把当前的游戏环节设置为正在进行当中，在结束之前不能开始下一环节
function tbMiniGame:SetCurStepPlaying(nMapId)
	-- 加上0.5表示这个环节已经开始，但是还没有结束
	local nCurStep = math.floor(self:GetCurStep(nMapId)) + 0.5;
	self:SetCurStep(nMapId, nCurStep);
end

function tbMiniGame:CheckStep(nStep)
	local nCurStep = self:GetCurStep(me.nMapId);
	
	-- 当前已经有环节正在进行，不能开启下一个游戏
	if (math.mod(nCurStep, 1) ~= 0) then
		nCurStep = math.ceil(nCurStep);
		local szCurGame = self.TB_GAME_NAME[nCurStep];
		if (szCurGame) then
			Dialog:Say(string.format("Trò chơi nhỏ: <color=yellow>%s<color> đang được tiến hành. Sau khi kết thúc sẽ đến trò tiếp theo",
				szCurGame));
		end
		return 0;
	end
	
	-- 小游戏开启顺序不正确
	nCurStep = math.floor(nCurStep);
	if (nStep > self.STEP_GAME_CAIBAOTU) then
		Dialog:Say("Trò chơi đã kết thúc, chuẩn bị qua trò mới nào.");
		return 0;
	elseif (nStep < nCurStep + 1) then
		Dialog:Say("Chú ý: Trò chơi này đã kết thúc.");
		return 0;
	elseif (nStep > nCurStep + 1) then
		Dialog:Say("Chú ý: Trò chơi cần mở theo trình tự.");
		return 0;
	end
	return 1;
end

function tbMiniGame:DabaozhuDlg()
	local szMsg = "Tổ Chức/; Trò Chơi: <color=yellow> Mời mọi người tập trung tại đây <color> nhị vị hiệp lữ mở ra trò chơi hậu, ta hai bên trái phải gặp phải một người pháo, một phút đồng hồ hậu tuôn ra thứ tốt, <color=green> pháo người chung quanh càng nhiều, thưởng cho càng cao! <color>\n ngươi xác định yếu bắt đầu cái này trò chơi mạ?";
	local tbOpt = {
		{"Đúng vậy, bắt đầu trò chơi", self.DaBaozhu, self},
		{"Chờ chút, để mọi người tập trung đã"},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 开心大爆竹
function tbMiniGame:DaBaozhu()
	local bCanOpenGame, szErrMsg = self:CheckPlayer();
	if (0 == bCanOpenGame) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	if (self:CheckStep(self.STEP_GAME_DABAOZHU) ~= 1) then
		return 0;
	end
	
	self:SetCurStepPlaying(me.nMapId);
	local tbNpc = Npc:GetClass("marry_dabaozhu");
	tbNpc:OpenBaozhu(me.nMapId);
end

function tbMiniGame:TongxinguoDlg()
	local szMsg = "Tổ Chức Trò Chơi: <color=yellow>Mời hiệp lữ chuẩn bị.<color> nhị vị hiệp lữ mở ra trò chơi hậu, ta hai bên trái phải gặp phải một thân cây, <color=green> nhị vị hiệp lữ song song ngắt lấy, khả thu được đồng tâm quả! <color> ngươi xác định yếu bắt đầu cái này trò chơi mạ?";
	local tbOpt = {
		{"Đúng vậy, bắt đầu trò chơi", self.Tongxinguo, self},
		{"Chờ chút, để mọi người tập trung đã"},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 采摘同心果
function tbMiniGame:Tongxinguo()
	local bCanOpenGame, szErrMsg = self:CheckPlayer();
	if (0 == bCanOpenGame) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	if (self:CheckStep(self.STEP_GAME_TONGXINSHU) ~= 1) then
		return 0;
	end
	
	self:SetCurStepPlaying(me.nMapId);
	local tbNpc = Npc:GetClass("marry_tongxinshu");
	tbNpc:GameStart(me.nMapId);
end

function tbMiniGame:CaibaoTuDlg()
	local szMsg = "Tổ Chức Trò Chơi: <color=yellow> thỉnh sớm thông tri đại gia chuẩn bị sẵn sàng! <color> nhị vị hiệp lữ mở ra trò chơi hậu, điển lễ nơi sân lý hội tùy cơ xuất hiện tài bảo thỏ, bắt được thỏ khả thu được tiễn túi. <color=green> tiễn túi khả dĩ tại ta ở đây đổi trong bảo khố tương. <color> ";
	local tbOpt = {
		{"Đúng vậy, bắt đầu trò chơi", self.CaibaoTu, self},
		{"Chờ chút, để mọi người tập trung đã"},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 幸运财宝兔
function tbMiniGame:CaibaoTu()
	local bCanOpenGame, szErrMsg = self:CheckPlayer();
	if (0 == bCanOpenGame) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	if (self:CheckStep(self.STEP_GAME_CAIBAOTU) ~= 1) then
		return 0;
	end
	
	self:SetCurStepPlaying(me.nMapId);
	local tbNpc = Npc:GetClass("marry_caibaotu");
	tbNpc:StartGame(me.nMapId);
end

function tbMiniGame:Change2BoxDlg()
	local szMsg = "Ngươi khả dĩ tham gia may mắn tài bảo thỏ hoạt động, nắm thỏ, xong tiễn túi. Dùng tiễn túi tới nơi này đổi trong bảo khố tương. Từng tiểu trong bảo khố tương cần 1 một tiễn túi, từng đại bảo tương cần 10 một tiễn túi. Ngươi xác định yếu đổi mạ?";
	local tbOpt = {
		{"Rương Thần Tài (lớn)", self.Change2Box, self, self.TB_BOXINFO[1]},
		{"Rương Thần Tài (nhỏ)", self.Change2Box, self, self.TB_BOXINFO[2]},
		{"Để ta đi bắt thêm"},
		};
	Dialog:Say(szMsg, tbOpt);
end

-- 用财宝兔兑换箱子（可以用10个兑换成一个大的，或者用1个兑换成小的）
function tbMiniGame:Change2Box(tbBoxInfo)
	local nOwnCount = me.GetItemCountInBags(unpack(self.CAIBAOTU_ITEM_GDPL));
	if (0 == nOwnCount) then
		Dialog:Say("Trên người ngươi không có túi tiền, không thể đổi. Tham gia trò chơi điển lễ <color=yellow>May mắn tài bảo thố<color> nhận được túi tiền.");
		return 0;
	end
	
	local szName = KItem.GetNameById(unpack(self.CAIBAOTU_ITEM_GDPL));
	if (nOwnCount < tbBoxInfo.nCount) then
		local szErrMsg = string.format("<color=yellow>%s<color> của ngươi không đủ. Đổi %s cần <color=yellow>%s<color> túi tiền.",
										szName, tbBoxInfo.szName, tbBoxInfo.nCount);
		Dialog:Say(szErrMsg);
		return 0;
	end
	
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hành trang của ngươi không đủ chỗ, hãy dọn dẹp và thử lại.");
		return 0;
	end
	
	local bRet = me.ConsumeItemInBags2(tbBoxInfo.nCount, unpack(self.CAIBAOTU_ITEM_GDPL));
	if (bRet ~= 0) then
		return 0;
	end
	
	me.AddItem(unpack(tbBoxInfo.tbGDPL));
end
