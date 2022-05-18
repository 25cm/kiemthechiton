-- 狱卒

local tbNpc = Npc:GetClass("yuzu");

tbNpc.tbTaskIdReduceOnePkSec	= {2000, 2};		-- 洗一点Pk的剩余时间的任务变量的Id
tbNpc.tbPrisonMapId				= {222,223};		-- 大牢的MapId
tbNpc.tbLingpai 				= {					-- 刑部令牌
	["nGenre"] 					= 18,
	["nDetailType"]				= 1,
	["nParticularType"] 		= 17,
	["nLevel"]					= 1,
};

local tbMap = {};

-- 定义玩家进入事件
function tbMap:OnEnter(szParam)
	if (me.nPKValue <= 0) then	-- 如果PK值等于0则不做处理
		return;
	end
	
	--local tbNpc 	= Npc:GetClass("yuzu");
	local nRestSec	= me.GetTask(tbNpc.tbTaskIdReduceOnePkSec[1], tbNpc.tbTaskIdReduceOnePkSec[2]);
	if (nRestSec <= 0) then		-- 从大牢传进来	
		local nReduceOnePkHour, nSumTimer	= tbNpc:OnePkTime(me.nPKValue);
		nRestSec = 3600 * nReduceOnePkHour;
	end
	assert(nRestSec > 0);
	
	-- 开启计时器
	local tbTmp	= me.GetTempTable("Npc");
	tbTmp.nNpcYuzuTimerId = Timer:Register(nRestSec * Env.GAME_FPS, tbNpc.OnTimer, tbNpc, me.nId);
end

-- 定义玩家离开事件
function tbMap:OnLeave(szParam)
	local tbTmp = me.GetTempTable("Npc");
	if (tbTmp.nNpcYuzuTimerId) then
		local nRestSec	= Timer:GetRestTime(tbTmp.nNpcYuzuTimerId) / Env.GAME_FPS;
		if (nRestSec <= 0) then	-- 特殊处理正好等于0的情况
			nRestSec = 1;
		end
		me.SetTask(tbNpc.tbTaskIdReduceOnePkSec[1], tbNpc.tbTaskIdReduceOnePkSec[2], nRestSec);
		Timer:Close(tbTmp.nNpcYuzuTimerId);

		tbTmp.nNpcYuzuTimerId = nil;
	end
end

-- 复制函数
for i, nMapId in pairs(tbNpc.tbPrisonMapId) do
	local tbPrisonMap = Map:GetClass(nMapId);
	for szMsg in pairs(tbMap) do
		tbPrisonMap[szMsg] = tbMap[szMsg];
	end
	tbPrisonMap.i = i;
end

function tbNpc:OnDialog()
	if (me.nPKValue > 0) then
		Dialog:Say("Cai ngục: Phạm nhân nghiệp chướng chưa sạch, không được tự ý rời khỏi!",
				{
					{"Thăm dò thời cơ trước mắt", self.ZishouAskTime, self},
					{"Đưa Lệnh Bài Hình Bộ, rời Đại Lao", self.ShowLingpai, self, me},
					{"Lập tức trở về"}
				});
	else
		Dialog:Say("Cai ngục: Nhà ngươi! Mau thu xếp hành lý, ngươi có thể xuất ngục rồi!\n\nNgười chơi: Đa tạ đại ca, tôi đi đây!",
				{
					{"Đồng ý", self.LeavePrison, self, me},
					{"Kết thúc đối thoại"}
				});
				
		me.Msg("Sau khi hối lỗi, cuối cùng nhà ngươi cũng được phóng thích.");
	end
end


-- 自首的玩家向狱卒询问时间
function tbNpc:ZishouAskTime()
	local tbTmp					= me.GetTempTable("Npc");
	local nRestReduceOnePkSec	= Timer:GetRestTime(tbTmp.nNpcYuzuTimerId) / Env.GAME_FPS;
	local nHour, nMin, nSec		= Lib:TransferSecond2NormalTime(nRestReduceOnePkSec);
	
	Dialog:Say("Người chơi: Đại ca, cho tôi hỏi thăm đã mấy giờ rồi?\n\nCai ngục: Ngươi muốn giảm 1 PK, thời gian còn "..nHour.."Giờ"..nMin.." phút"..nSec.."giây, mau đi rồi quay lại!");
	me.Msg("Để giảm 1 PK cần "..nHour.."Giờ"..nMin.." phút"..nSec.." giây!");
end

-- 坐牢的玩家出示令牌
function tbNpc:ShowLingpai(pPlayer)
	-- 没有令牌
	if (pPlayer.GetItemCountInBags(self.tbLingpai.nGenre, self.tbLingpai.nDetailType, self.tbLingpai.nParticularType, self.tbLingpai.nLevel) <= 0) then
		Dialog:Say("Cai ngục: Ngươi không hề có Lệnh Bài Hình Bộ, dám đùa với đại lão gia đây sao, còn không mau cút đi!");
		return;
	end

	Dialog:Say("Cai ngục: Quả nhiên là Lệnh Bài Hình Bộ, trước đây nếu có gì đắc tội, xin đại hiệp lượng thứ! Bây giờ ngài muốn rời Đại Lao sao?",
			{
				{"Rời Đại Lao", self.LeavePrisonByLingpai, self, pPlayer},
				{"Để ta suy nghĩ thêm"}
			});
end

function tbNpc:LeavePrisonByLingpai(pPlayer)
	if (pPlayer.ConsumeItemInBags(1, self.tbLingpai.nGenre, self.tbLingpai.nDetailType, self.tbLingpai.nParticularType, self.tbLingpai.nLevel) ~= 0) then								-- 删除一块令牌失败，记录错误，处理并停止逻辑
		pPlayer.Msg("Xóa Lệnh Bài Hình Bộ thất bại!");
		return;
	end	
	pPlayer.Msg(pPlayer.szName.."Dùng Lệnh Bài Hình Bộ để rời Đại Lao!");
	self:LeavePrison(pPlayer);
end

function tbNpc:LeavePrison(pPlayer)
	local tbNpcYayi = Npc:GetClass("yayi");
	tbNpcYayi:TransferPos(pPlayer.GetMapId(), pPlayer);
end

-- Pk值到达某一点时,每降低一点所需要的时间
function tbNpc:OnePkTime(nPkValue)
	if (nPkValue == 0) then
		return 0, 0;
	end
	local tbReducePkTime =		-- 分成几段来消Pk值, 得到Pk值中每降低1点所需要的时间(小时)
	{
		{ 7, 2 },				-- Pk值大于7的时候,每降低1点需要2小时
		{ 4, 1 },				-- Pk值大于4, 并且小于等于7的时候,每降低1点需要1小时
		{ 0, 0.5 },				-- Pk值大于0, 并且小于等于4的时候,每降低1点需要0.5小时
	};
	local nReduceOnePkHour	= 0;
	local nSumHourTime		= 0;
	
	for i = 1, #tbReducePkTime do
		if (nPkValue > tbReducePkTime[i][1]) then
			nSumHourTime = nSumHourTime + (nPkValue - tbReducePkTime[i][1]) * tbReducePkTime[i][2];	
			nPkValue = tbReducePkTime[i][1];
			if (nReduceOnePkHour == 0) then
				nReduceOnePkHour = tbReducePkTime[i][2];
			end
		end
	end

	return nReduceOnePkHour, nSumHourTime;
end

function tbNpc:OnTimer(nPlayerId)				-- 时间到会调用此函数
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	pPlayer.AddPkValue(-1);
	if (pPlayer.nPKValue <= 0) then			-- 返回0，表示要关闭此Timer
		local tbTmp = me.GetTempTable("Npc");
		tbTmp.nNpcYuzuTimerId = nil;
		return 0;
	end	
	return  math.floor(3600 * self:OnePkTime(pPlayer.nPKValue) * Env.GAME_FPS);
end
