-------------------------------------------------------
-- 文件名　：viptransfer_def.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-11-19 11:17:44
-- 文件描述：
-------------------------------------------------------

Require("\\script\\misc\\serverlist.lua");

local tbVipTransfer = VipPlayer.VipTransfer or {};
VipPlayer.VipTransfer = tbVipTransfer;

tbVipTransfer.TASK_GROUP_ID 		= 2108;		-- 任务变量组
tbVipTransfer.TASK_QUALIFICATION	= 1;		-- 有申请转服资格
tbVipTransfer.TASK_TRANS_APPLY		= 2;		-- 申请过转服
tbVipTransfer.TASK_TRANS_GETAWARD	= 3;		-- 领取过转服奖励

-- 保留声望
tbVipTransfer.TASK_REPUTE = 
{
	[1] = 12, 	-- 腰带声望
	[2] = 13, 	-- 逍遥声望
	[3] = 14, 	-- 祈福声望
	[4] = 4, 	-- 联赛声望
	[5] = 5, 	-- 领土声望
	[6] = 6, 	-- 秦陵声望
	[7] = 7, 	-- 武器声望
	[8] = 8, 	-- 民族声望
	[9] = 9,	-- 武林大会声望
};

-- 绑银和银两
tbVipTransfer.TASK_BIND_MONEY		= 10;
tbVipTransfer.TASK_MONEY			= 11;

-- tbApplyOut[szPlayerName] = 
-- {szNewAccount = "", nNewGateId = 0, nBindValue = 0, nNoBindValue = 0, tbRepute = {}}

-- tbApplyIn[szAccount] = 
-- {nNewGateId, nBindCoin = 0, nBindMoney = 0, nMoney = 0, tbRepute = {}};
tbVipTransfer.tbGlobalBuffer = 
{
	tbApplyOut = {},	-- 申请转出的
	tbApplyIn = {},		-- 申请转入的
};		

-- 保留的声望类型 {nCamp, nClass}
tbVipTransfer.tbRepute =
{
	[1] = {5, 2},	-- 腰带声望
	[2] = {5, 3},	-- 逍遥声望
	[3] = {5, 4},	-- 祈福声望
	[4] = {7, 1},	-- 联赛声望
	[5] = {8, 1},	-- 领土声望
	[6] = {9, 1},	-- 秦陵声望
	[7] = {9, 2}, 	-- 武器声望
	[8] = {10, 1},	-- 民族声望
	[9] = {11, 1},	-- 武林大会声望
};

-- 声望名字索引
tbVipTransfer.tbReputeName = 
{
	[1] = {"2008盛夏活动声望", 70},
	[2] = {"逍遥谷声望", 70},
	[3] = {"祈福声望", 80},
	[4] = {"武林联赛声望", 140},
	[5] = {"领土争夺声望", 80},
	[6] = {"秦始皇陵·官府声望", 150},
	[7] = {"秦始皇陵·发丘门声望", 160},
	[8] = {"民族大团圆声望", 130},
	[9] = {"武林大会声望", 900},
};

-- 提升等级对时间轴
tbVipTransfer.tbTimeLevel = 
{
	[1] = {466, 125},
	[2] = {436, 124},
	[3] = {406, 123},
	[4] = {376, 122},
	[5] = {346, 121},
	[6] = {316, 120},
	[7] = {276, 118},
	[8] = {236, 115},
	[9] = {196, 112},
	[10] = {166, 109},
	[11] = {136, 106},
	[12] = {116, 103},
};

-- 计算的玄晶类型
tbVipTransfer.tbXuanjing =
{
	{18, 1, 1, 9},
	{18, 1, 1, 10},
	{18, 1, 1, 11},
	{18, 1, 1, 12},
	{18, 1, 114, 9},
	{18, 1, 114, 10},
	{18, 1, 114, 11},
	{18, 1, 114, 12},
};

-- 返回声望类型索引
function tbVipTransfer:GetReputeIndex(nCamp, nClass)
	for nIndex, tbInfo in pairs(self.tbRepute) do
		if tbInfo[1] == nCamp and tbInfo[2] == nClass then
			return nIndex;
		end
	end
	return 0;
end

-- 检测玄晶
function tbVipTransfer:CheckXuanjing(pItem)
	for _, tbItemId in pairs(self.tbXuanjing) do
		if pItem.nGenre == tbItemId[1] and pItem.nDetail == tbItemId[2] and pItem.nParticular == tbItemId[3] and pItem.nLevel == tbItemId[4] then
			return 1;
		end
	end
	return 0;
end

-- 检测内部账号
function tbVipTransfer:CheckSepcailAccount(pPlayer)
	if jbreturn:IsPermitIp(pPlayer) ~= 1 then
		return 0;
	end
	if jbreturn:GetMonLimit(pPlayer) <= 0 then
		return 0;
	end
	return 1;
end

-- 区服列表
local tbServerName = {}
local tbGlobalServer = ServerEvent:GetServerGateList();
for szGateId, tbGate in pairs(tbGlobalServer or {}) do
	local nGate = tonumber(string.sub(szGateId, 5, 8));
	local nIndex = math.floor(nGate / 100);
	if not tbServerName[nIndex] then
		tbServerName[nIndex] = {[0] = tbGate.ZoneName};
	end
	tbServerName[nIndex][nGate] = tbGate.ServerName;
end
tbVipTransfer.tbServerName = tbServerName;

---- 区服列表
--tbVipTransfer.tbServerName =
--{
--	-- 青龙区
--	[1] =
--	{
--	 	[0] = "青龙区",
--		[101] = "云中镇",
--		[102] = "龙门镇",
--		[103] = "永乐镇",
--		[104] = "稻香村",
--		[105] = "江津村",
--		[107] = "龙泉村",
--		[108] = "巴陵县",
--		[110] = "九老峰",
--		[112] = "青螺岛",
--		[113] = "燕子坞",
--		[114] = "浣花溪",
--		[116] = "响水洞",
--		[118] = "风陵渡",
--	},
--	-- 白虎区
--	[2] =
--	{
--		[0] = "白虎区",
--		[201] = "长江河谷",
--		[202] = "雁荡龙湫",
--		[203] = "洞庭湖畔",
--		[207] = "茶马古道",
--		[209] = "龙虎幻境",
--		[210] = "湖畔竹林",
--		[213] = "暮雪山庄",
--		[215] = "怡情山庄",
--	},
--	-- 朱雀区
--	[3] =
--	{
--		[0] = "朱雀区",
--		[301] = "剑门关",
--		[302] = "武夷山",
--		[304] = "锁云渊",
--		[307] = "岳阳楼",
--		[308] = "采石矶",
--		[312] = "梁山泊",
--		[316] = "寒波谷",
--		[321] = "雁鸣湖",
--	},
--	-- 玄武区
--	[4] =
--	{
--		[0] = "玄武区",
--		[403] = "二龙山",
--		[404] = "罗霄山",
--		[405] = "凌绝峰",
--		[408] = "快活林",
--		[409] = "藏云轩",
--		[410] = "摘星坪",
--		[414] = "飞龙堡",
--		[416] = "轩辕谷",
--		[420] = "忘情溪",
--		[421] = "昆仑关",
--		[426] = "西江月",
--	},
--	-- 紫薇区
--	[5] =
--	{
--		[0] = "紫薇区",
--		[501] = "逍遥客栈",
--		[504] = "春梅雅筑",
--		[509] = "华山绝顶",
--		[511] = "天涯海角",
--		[512] = "苏堤春晓",
--		[516] = "碧海潮生",
--		[517] = "金玉满堂",
--		[518] = "飞龙在天",
--	},
--	-- 北斗区
--	[6] =
--	{
--		[0] = "北斗区",
--		[602] = "栖霞宫",
--		[603] = "日月潭",
--		[605] = "雁门关",
--		[606] = "莫高窟",
--		[611] = "清心潭",
--		[616] = "翠竹溪",
--		[618] = "凤凰山",
--		[620] = "鸣沙山",
--	},
--	-- 金麟区
--	[7] =
--	{
--		[0] = "金麟区",
--		[701] = "蝶恋花",
--		[703] = "浪淘沙",
--		[706] = "清平乐",
--		[707] = "水龙吟",
--		[708] = "青玉案",
--		[709] = "秦楼月",
--		[710] = "桂花明",
--		[711] = "木兰辞",
--		[712] = "侠客行",
--		[713] = "紫云回",
--		[714] = "秋塞吟",
--		[715] = "塞上曲",
--	},
--	-- 吉祥区
--	[8] =
--	{
--		[0] = "吉祥区",
--		[1001] = "沁园春",
--		[1002] = "葬花吟",
--		[1003] = "满庭芳",
--		[1004] = "醉红妆",
--		[1006] = "潇湘曲",
--		[1007] = "绮罗香",
--		[1008] = "踏青游",
--		[1009] = "东风寒",
--		[1010] = "望仙楼",
--	},
--	-- 如意区
--	[9] =
--	{
--		[0] = "如意区",
--		[1102] = "西山晴雪",
--		[1103] = "情义江湖",
--		[1004] = "金戈铁马",
--		[1005] = "天地无极",
--		[1006] = "降龙伏虎",
--	},
--};
