
-- ====================== 文件信息 ======================

-- 劍俠世界門派任務鏈對話文件
-- Edited by peres
-- 2007/12/18 PM 03:05

-- 她是透徹的。
-- 隻是一個容易感覺孤獨的人，會想用某些幻覺來麻醉自己。
-- 一個手裡緊抓著空洞的女子，最後總是會讓自己失望。

-- ======================================================

LinkTask.Text	= {	
};

LinkTask.Text[10000]	= {};
LinkTask.Text[20000]	= {};
LinkTask.Text[30000]	= {};

LinkTask.Text[10000]	= {
	[1]	= "Gần đây cao thủ Cái Bang Ảnh Xã tử thương nặng nề ở Kim quốc. Bạch thủ lĩnh và Bang chủ Cái Bang Thạch Hiên Viên vốn có thâm giao, nàng tập trung một nhóm cao thủ, chuẩn bị đến Trung Nguyên giải cứu những cao thủ Ảnh Xã còn lại. Hiện tại vẫn còn thiếu <Item>, ngươi có thể tìm giúp?",
	[2]	= "Bạch thủ lĩnh cho rằng, bọn Thát Đát có ý đồ tiêu diệt Tây Hạ và Kim quốc, như vậy Đại Tống ta sẽ lâm nguy. Hiện nay ta biết rất ít về bọn Thát Đát, vì vậy ngươi hãy đi tìm <Item>, nghe nói chúng được làm bởi thợ của bộ lạc Mông Cổ.",
	[3]	= "Hôm qua nhận được tin, toán quân yểm trợ của Nhậm Tiếu Thiên đã tập kích Từ Châu. Nơi đó đất đai màu mỡ, là nơi binh gia tranh giành. Nếu họ trụ được đến cuối thu thì không lo thiếu lương thảo cho năm tới, nhưng Nhậm Tiếu Thiên còn thiếu <Item>, ngươi có thể tìm giúp?",
};

LinkTask.Text[20000]	= {
	[1] = "Ngươi đến <MapName> tiêu diệt <NpcDesc> cho ta.",
};

LinkTask.Text[30000]	= {
	[1]	= "Gần đây cao thủ Cái Bang Ảnh Xã tử thương nặng nề ở Kim quốc. Bạch thủ lĩnh và Bang chủ Cái Bang Thạch Hiên Viên vốn có thâm giao, nàng tập trung một nhóm cao thủ, chuẩn bị đến Trung Nguyên giải cứu những cao thủ Ảnh Xã còn lại. Hiện tại vẫn còn thiếu <Item>, ngươi có thể tìm giúp?",
	[2]	= "Bạch thủ lĩnh cho rằng, bọn Thát Đát có ý đồ tiêu diệt Tây Hạ và Kim quốc, như vậy Đại Tống ta sẽ lâm nguy. Hiện nay ta biết rất ít về bọn Thát Đát, vì vậy ngươi hãy đi tìm <Item>, nghe nói chúng được làm bởi thợ của bộ lạc Mông Cổ.",
	[3]	= "Hôm qua nhận được tin, toán quân yểm trợ của Nhậm Tiếu Thiên đã tập kích Từ Châu. Nơi đó đất đai màu mỡ, là nơi binh gia tranh giành. Nếu họ trụ được đến cuối thu thì không lo thiếu lương thảo cho năm tới, nhưng Nhậm Tiếu Thiên còn thiếu <Item>, ngươi có thể tìm giúp?",
};

-- 在選擇任務時就調用
-- 根據傳進來的任務類型和任務參數來獲取一段任務的描述，並且記錄到任務變量中
function LinkTask:SetTaskText(pPlayer, nType)
	if not LinkTask.Text[nType] then
		self:_Debug("Get Task Text, Error Type: "..nType);
		return;
	end;
	local nRandom	= MathRandom(1, #LinkTask.Text[nType]);
	pPlayer.SetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKTEXT, nRandom);
	return nRandom;
end;

-- 根據任務類型和任務Id來獲取一段文字
function LinkTask:GetTaskText(nType, nSubTaskId)
	local szMainText	= "";
	local nTextId		= self:GetTask(self.TSK_TASKTEXT);

	if nTextId <= 0 then
		self:_Debug("Error: Get Empty Text Id!");
		return;
	end;

	self:_Debug("Start get task text.");	
	local szOrgText		= LinkTask.Text[nType][nTextId];
	
	local tbTaget		= Task.tbSubDatas[nSubTaskId].tbSteps[1].tbTargets[1];
	local szTargetName	= tbTaget.szTargetName; -- 得到這個目標的名字
	
	self:_Debug("Get task taget: "..szTargetName);
	if szTargetName == "SearchItemWithDesc" then
		
		local szItemName	= tbTaget.szItemName;
		local nItemNum		= tbTaget.nNeedCount;
		szMainText			= string.gsub(szOrgText, "<Item>", "<color=green>"..nItemNum.." "..szItemName.."<color>");
		szMainText			= szMainText.."\n<color=yellow>Loại vật phẩm này có thể tạo ra bởi Kỹ năng sống.<color>";

	elseif szTargetName == "SearchItemBySuffix" then

		local szItemName	= tbTaget.szItemName;
		local szSuffix		= tbTaget.szSuffix;
		
		local nItemNum		= tbTaget.nNeedCount;
		szMainText			= string.gsub(szOrgText, "<Item>", "<color=green>"..nItemNum.." "..szItemName.."﹒"..szSuffix.."<color>");
		szMainText			= szMainText.."\n<color=yellow>Loại vật phẩm này có thể tạo ra bởi Kỹ năng sống.<color>";
		
	elseif szTargetName == "KillNpc" then
		
		local szNpcName		= KNpc.GetNameByTemplateId(tbTaget.nNpcTempId);
		local szMapName		= Task:GetMapName(tbTaget.nMapId);
		local nCount		= tbTaget.nNeedCount;
		local szNpcDesc		= nCount..", "..szNpcName;
		
		szMainText			= string.gsub(szOrgText, "<MapName>", "<color=green>"..szMapName.."<color>");
		szMainText			= string.gsub(szMainText, "<NpcDesc>", "<color=green>"..szNpcDesc.."<color>");
	end;
	
	return szMainText;
end;
