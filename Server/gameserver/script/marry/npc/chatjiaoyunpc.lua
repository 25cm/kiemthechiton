-- 文件名　：chatjiaoyunpc.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-13 10:48:49
-- 功能描述：结婚相关npc（自动发送教育信息的教育npc）

Marry.tbJiaoyuNpc = Marry.tbJiaoyuNpc or {};
local tbNpc = Marry.tbJiaoyuNpc;

--===============================================================

tbNpc.MSG_STAY_TIME = 5;	-- 消息停留时间

-- npc的刷出坐标{[npcid] = {{坐标1}, {坐标2}, ...}
tbNpc.tbNpcPos = {
	[6529] = {{498, 1625, 3246}, {499, 1553, 3108},{500, 1728, 3119}, {575, 1547, 3197},},
	[6530] = {{498, 1730, 3076}, {499, 1603, 3062},{500, 1723, 3187}, {575, 1614, 3224},},
	[6531] = {{498, 1824, 3183}, {499, 1657, 3035},{500, 1675, 3203}, {575, 1534, 3322},},
	[6532] = {{498, 1749, 3315}, {499, 1675, 3182},{500, 1651, 3052}, {575, 1625, 3302},},
	};

-- npc的说话内容{[npcid] = {[1] = "Chào mọi người，", [2] = "Chào mọi người",}, ...}
tbNpc.tbChatMsg = {
	[6529] = {
			[1] = "Mỗi người đều có những lúc khó khăn",
			[2] = "Muốn né tránh nhưng phải đối mặt",
			[3] = "Yêu nhầm người là một điều đáng tiếc ",
			[4] = "Yêu người không thể yêu được cũng là điều đáng tiếc",
			[5] = "Một phút ta có thể gặp gỡ một người",
			[6] = "Một tiếng ta có thể thích một người",
			[7] = "Một giây ta có thể nhớ một người",
			[8] = "Nhưng quên một người,ta cần cả cuộc đời",
			},
	[6530] = {
			[1] = "Ta vốn không biết mình yếu đuối như vậy",
			[2] = "Trong thời khắc này mới biết",
			[3] = "Viễn cảnh hạnh phúc mà bạn ước mơ",
			[4] = "Là giấc mơ tôi không bao giờ đạt được",
			[5] = "Tôi đã quên ngày ấy tháng ấy năm ấy",
			[6] = "Tôi vẽ lên tường một khuôn mặt",
			[7] = "Một gương mặt mỉm cười với tôi,buồn rầu với tôi,hy vọng về tôi",
			[8] = "Khi chúng ta mỉm cười và nói chúng ta chia tay ",
			[9] = "Thực chất chúng ta đã lẳng lặng rời xa rồi",
			},	
	[6531] = {
			[1] = "Gỗ nói với lửa: hãy ôm tôi",
			[2] = "Lửa bao bọc lấy gỗ",
			[3] = "Gỗ mỉm cười và trở thành tàn tro",
			[4] = "Lửa đã khóc",
			[5] = "Nước mắt dập tắt lửa ",
			[6] = "Khi gỗ gặp lửa,đã chủ định sẽ bùng cháy",
			[7] = "Sự cô đơn của con người",
			[8] = "Có những lúc khó dùng từ ngữ diễn tả được",
			[9] = "Thế giới của ta lặng yên",
			[10] = "Ta có sợ cô độc không?",
			[11] = "Ta chỉ vô tình mà cảm thấy cô đơn",
			},
	[6532] = {
			[1] = "Niềm vui của ta đều là chuyện nhỏ",
			[2] = "Bất kể việc gì",
			[3] = "Chỉ cần can tâm tình nguyện",
			[4] = "Là có thể hóa giải thành đơn giản",
			[5] = "Ta nghĩ có một số chuyện có thể quên lãng",
			[6] = "Có một số chuyện có thể nhớ mãi",
			[7] = "Có một số chuyện có thể can tâm tình nguyện",
			[8] = "Có một số chuyện không thể nào khác được",
			[9] = "Ta nghĩ ngươi",
			[10] = "Đây là vấn nạn của ta",
			[11] = "Như vậy,trước sau và mãi mãi",
			},
	};

--===============================================================

function tbNpc:StartChat()
	for nNpcTemplateId, tbPosInfo in pairs(self.tbNpcPos) do
		for _, tbPos in pairs(tbPosInfo) do
			local pNpc = KNpc.Add2(nNpcTemplateId, 1, -1, unpack(tbPos));
			if (pNpc and self.tbChatMsg[nNpcTemplateId]) then
				local tbMsg = self.tbChatMsg[nNpcTemplateId];
				local tbNpcData = pNpc.GetTempTable("Marry") or {};
				tbNpcData.nJiaoyuMsgIndex = 1;
				if (#tbMsg >= 1) then
					Timer:Register(self.MSG_STAY_TIME * Env.GAME_FPS, self.SendMsg, self, pNpc.dwId, tbMsg);
				end
			end
		end
	end
end

function tbNpc:SendMsg(dwId, tbChatMsg)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc) then
		return 0;
	end
	local tbNpcData = pNpc.GetTempTable("Marry") or {};
	local nMsgIndex = tbNpcData.nJiaoyuMsgIndex or 1;
	if (nMsgIndex >= #tbChatMsg) then
		nMsgIndex = 1;
	end
	
	pNpc.SendChat(tbChatMsg[nMsgIndex]);
	
	tbNpcData.nJiaoyuMsgIndex = nMsgIndex + 1;
end

ServerEvent:RegisterServerStartFunc(Marry.tbJiaoyuNpc.StartChat, Marry.tbJiaoyuNpc);
