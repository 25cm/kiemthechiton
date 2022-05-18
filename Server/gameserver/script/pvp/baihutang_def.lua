
BaiHuTang.TSKG_PVP_ACT	  = 2009;
BaiHuTang.TSK_BaiHuTang_PKTIMES = 1;
BaiHuTang.MAX_ONDDAY_PKTIMES = EventManager.IVER_nBaiHuTangCount; 
BaiHuTang.SIX_NUMBERS = 1000000;

BaiHuTang.TIMELEFT		  = Env.GAME_FPS * 60 * 30;

BaiHuTang.nTimes	= 1;		--平台开启奖励倍数

BaiHuTang.RESTSTATE	   = 0; -- 0 无活动状态
BaiHuTang.APPLYSTATE   = 1;	-- 1 报名状态
BaiHuTang.FIGHTSTATE   = 2;	-- 2 PK状态	
BaiHuTang.nActionState = 0;

BaiHuTang.nTaskId	= 0;

BaiHuTang.ChuJi = 225;
BaiHuTang.ChuJi2 = 274;
BaiHuTang.ChuJi3 = 333;
BaiHuTang.GaoJi = 233;
BaiHuTang.Goldlen = 821;
BaiHuTang.tbMapList = {225, 274, 233, 821};

BaiHuTang.tbIsOpen	  = {};
BaiHuTang.nRegisterId = nil;
BaiHuTang.nRegisterIdLeft = nil;
BaiHuTang.nBossNo	  = nil;
BaiHuTang.tbDaDianPos = {}; 
BaiHuTang.tbPKPos	  = {};
BaiHuTang.tbMapKey 	  = {};
BaiHuTang.tbTrapList  = {};
BaiHuTang.tbSysMsg    = {};
BaiHuTang.tbAnimalPos = {};
BaiHuTang.tbNumber	  = {};
BaiHuTang.tbMapId = {};
BaiHuTang.tbBatte = {};
BaiHuTang.tbNpcLevel = {45, 55, 65, 110, 115, 120, 110, 115, 120};
BaiHuTang.tbBossShowMsg = {3, 4, 5};
BaiHuTang.TSKGID	  = 2009;
BaiHuTang.TASK_USED_NUM = 3;
BaiHuTang.TASK_WEEK_ID	= 4;

BaiHuTang.TSK_LIMITWEIWANG	= 2;
BaiHuTang.LIMITWEIWANG		= 30;

BaiHuTang.BAIHUTANG_REPUTE_CAMP	= 5;
BaiHuTang.BAIHUTANG_REPUTE_CALSS= 1;

BaiHuTang.nStateJour = 0;
BaiHuTang.END = 7;

BaiHuTang.tbGetAwardCount = {};

-- 队长的领袖荣誉
BaiHuTang.HONOR ={{[3] = 6,  [4] = 9,  [5] = 12,  [6] = 15},	-- 第一关
		 		  {[3] = 6,  [4] = 9,  [5] = 12,  [6] = 15},	-- 第二关
		 		  {[3] = 12, [4] = 18, [5] = 24,  [6] = 30},	-- 第三关
				 };
				 
BaiHuTang.STATE_TRANS	=
{							--时间有延迟
--	 状态 					定时时间			时间到回调函数(函数返回0表示不在继续定时，结束活动)
	{1, 	Env.GAME_FPS * 60 * 10, 		"ShowGongGao"		},		--  显示公告
	{2,		Env.GAME_FPS * 60 * 10,			"ShowGongGao"		},		--  显示公告
	{3,		Env.GAME_FPS * 60 * 5,			"ShowGongGao"		}, 		--  显示公告
	--{4,		Env.GAME_FPS * 60 * 10,			"CallBoss"			}, 		-- Call 第一层BOSS
	--{5,		Env.GAME_FPS * 60 * 7,			"CallBoss"			}, 		-- Call 第二层BOSS
	--{6,		Env.GAME_FPS * 60 * 8,			"CallBoss"			}, 		-- Call 第三层BOSS
	{BaiHuTang.END}
};

BaiHuTang.szApplyMsg = "Hoạt động <color=green>Bạch Hổ Đường<color> bắt đầu báo danh, các đại hiệp có thể đăng ký tham gia";

function BaiHuTang:OnPlayerTrap(nMapId)
	if (self.tbIsOpen[nMapId] ~= 1) then
		return;
	end
	
	-- 添加福袋
	if me.CountFreeBagCell() >= 0 then
	local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,10);
	me.AddStackItem(18,1,3019,1,nil,10);
	me.AddStackItem(18,1,3039,1,nil,2);
	me.AddExp(3000000)
	me.AddBindMoney(200000);
	me.AddJbCoin(5000);  -- 1v dong thuong
	me.AddBindCoin(20000);--5v ??ng khóa
	me.Msg("<color=green>Hành trang trống >=5 để nhận phần thưởng<color> <color=yellow>5000 đồng thường<color>");
	end
	
	--闯关成功，添加10点声望
	self:AddRepute(me, 10);
	local nPrestige = 1;
	if BaiHuTang:GetLevelByMapId(nMapId) == 1 and TimeFrame:GetStateGS("OpenOneAdvBaiHuTang") == 1 then
		nPrestige = math.floor(nPrestige / 2);
	end
	me.AddKinReputeEntry(nPrestige, "baihutang")		-- 江湖威望
	me.AddOfferEntry(10, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 每通过一层增加10点贡献度
	
	-- 增加帮会建设资金和相应个人、族长、帮主的股份	
	local nStockBaseCount = 10; -- 股份基数
	Tong:AddStockBaseCount_GS1(me.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);
	local nLevel = BaiHuTang:GetLevelByMapId(nMapId);
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("BaiHuTang", me, nLevel, BaiHuTang:GetFloor(nMapId)) 
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	local nToMapId = self.tbMapKey[nMapId];
	-- 踢出mission
	if (nToMapId == 225 or nToMapId == 233 or nToMapId == 274 or nToMapId ==821) then
		 BaiHuTang:KickOutMission(me, nToMapId);
	end	
	if (nToMapId) then
		local tbSect = self.tbPKPos[MathRandom(#self.tbPKPos)];
		me.NewWorld(nToMapId, tbSect.nX / 32, tbSect.nY / 32);
	end
end

function BaiHuTang:SetTrapList()
	self.tbMapKey[226] = 230; self.tbMapKey[228] = 230;
	self.tbMapKey[234] = 238; self.tbMapKey[236] = 238;
	self.tbMapKey[227] = 231; self.tbMapKey[229] = 231;
	self.tbMapKey[235] = 239; self.tbMapKey[237] = 239;
	self.tbMapKey[230] = 232; self.tbMapKey[231] = 232;
	self.tbMapKey[238] = 240; self.tbMapKey[239] = 240;	
	self.tbMapKey[232] = 225; self.tbMapKey[240] = 233;
	-- 初级第二场
	self.tbMapKey[275] = 279; self.tbMapKey[277] = 279;
	self.tbMapKey[276] = 280; self.tbMapKey[278] = 280;
	self.tbMapKey[279] = 281; self.tbMapKey[280] = 281;
	self.tbMapKey[281] = 274;
	
	-- 初级第三场
	self.tbMapKey[334] = 338; self.tbMapKey[336] = 338;
	self.tbMapKey[335] = 339; self.tbMapKey[337] = 339;
	self.tbMapKey[338] = 340; self.tbMapKey[339] = 340;
	self.tbMapKey[340] = 333;
	
	--黄金白虎堂
	self.tbMapKey[822] = 826; self.tbMapKey[823] = 826;
	self.tbMapKey[824] = 827; self.tbMapKey[825] = 827;
	self.tbMapKey[826] = 828; self.tbMapKey[827] = 828;
	self.tbMapKey[828] = 821;
	
	local tbTestTrap = {};
	local tbTest = {};
	local tbMapIdList = {226,227,228,229,230,231,232,235,234,236,237,238,239,240,
						275, 276, 277, 278, 279, 280, 281, 
						334, 335, 336, 337, 338, 339, 340,
						822, 823, 824, 825, 826, 827, 828,
						};
	for _, nIndex in ipairs(tbMapIdList) do
		tbTest = Map:GetClass(nIndex);
		tbTestTrap = tbTest:GetTrapClass("to_exit");
		if (tbTestTrap) then
				tbTestTrap.OnPlayer = function (self)
				BaiHuTang:OnPlayerTrap(nIndex);
			end
		end
		if (tbTestTrap) then
			table.insert(self.tbTrapList, tbTestTrap);
		end
	end
end

local tbChuJiMap = Map:GetClass(BaiHuTang.ChuJi); 	-- 初级（1）
local tbChuJiMap2 = Map:GetClass(BaiHuTang.ChuJi2); 	-- 初级（2）
local tbChuJiMap3 = Map:GetClass(BaiHuTang.ChuJi3); 	-- 初级（3）

--进入大殿就为战斗状态
function tbChuJiMap:OnEnter(szParam)
	me.SetFightState(1);		--设置战斗状态
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
end
--离开时设回非战斗状态
function tbChuJiMap:OnLeave(szParam)
	me.SetFightState(0);		--设置战斗状态
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
end
--进入大殿就为战斗状态
function tbChuJiMap2:OnEnter(szParam)
	me.SetFightState(1);		--设置战斗状态
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
end
--离开时设回非战斗状态
function tbChuJiMap2:OnLeave(szParam)
	me.SetFightState(0);		--设置战斗状态
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
end

--进入大殿就为战斗状态
function tbChuJiMap3:OnEnter(szParam)
	me.SetFightState(1);		--设置战斗状态
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
end
--离开时设回非战斗状态
function tbChuJiMap3:OnLeave(szParam)
	me.SetFightState(0);		--设置战斗状态
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
end

local tbGaoJi = Map:GetClass(BaiHuTang.GaoJi);
--进入大殿就为战斗状态
function tbGaoJi:OnEnter(szParam)
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.SetFightState(1);		--设置战斗状态
end

--离开时设回非战斗状态
function tbGaoJi:OnLeave(szParam)
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.SetFightState(0);		--设置战斗状态
end

local tbGoldlen = Map:GetClass(BaiHuTang.Goldlen);
--进入大殿就为战斗状态
function tbGoldlen:OnEnter(szParam)
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.SetFightState(1);		--设置战斗状态
end

--离开时设回非战斗状态
function tbGoldlen:OnLeave(szParam)
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.SetFightState(0);		--设置战斗状态
end

local tbSecondChuYang	= Map:GetClass(230);	--初级二层阳 (1)
local tbSecondChuYin	= Map:GetClass(231);	--初级二层阴 (1)
local tbSecondChuYang2	= Map:GetClass(279);	--初级二层阳 (2)
local tbSecondChuYin2	= Map:GetClass(280);	--初级二层阴 (2)
local tbSecondChuYin3	= Map:GetClass(338);	--初级二层阴 (3)
local tbSecondChuYang3  = Map:GetClass(339);	--初级二层阴 (3)

function tbSecondChuYin:OnEnter(szParam)
end

function tbSecondChuYang:OnEnter(szParam)
end

function tbSecondChuYang2:OnEnter(szParam)
end

function tbSecondChuYin2:OnEnter(szParam)
end

local tbSecondGaoYang	= Map:GetClass(238);	--高级二层阳
local tbSecondGaoYin	= Map:GetClass(239);	--高级二层阴

function tbSecondGaoYin:OnEnter(szParam)
end

function tbSecondGaoYang:OnEnter(szParam)
end


local tbLastMapGao	= Map:GetClass(240);
function tbLastMapGao:OnEnter(szParam)
end
function tbLastMapGao:OnLeave(szParam)
	BaiHuTang:OnKickPlayer(me, 233);
end

local tbLastMapChu	= Map:GetClass(232);
function tbLastMapChu:OnEnter(szParam)
end
function tbLastMapChu:OnLeave(szParam)
	BaiHuTang:OnKickPlayer(me, 225);
end

--黄金白虎堂
local tbSecondGoldenYang	= Map:GetClass(826);	--高级二层阳
local tbSecondGoldenYin	= Map:GetClass(827);	--高级二层阴
function tbSecondGoldenYang:OnEnter(szParam)
end

function tbSecondGoldenYin:OnEnter(szParam)
end

local tbLastMapGolden	= Map:GetClass(828);	--高级二层阴

function tbLastMapGolden:OnEnter(szParam)
end
function tbLastMapGolden:OnLeave(szParam)
	BaiHuTang:OnKickPlayer(me, 821);
end



function BaiHuTang:init()
	local tbNumColSet = {["TRAPX"]=1, ["TRAPY"]=1};
	local tbData = {};
	tbData = Lib:LoadTabFile("\\setting\\pvp\\map\\chuanrudian_dadian.txt", tbNumColSet);
	for _, tbRow in ipairs(tbData) do
		local tbPos = {
				nX = tbRow.TRAPX;
				nY = tbRow.TRAPY;
			}
		table.insert(BaiHuTang.tbDaDianPos, tbPos);
	end	
	tbData = Lib:LoadTabFile("\\setting\\pvp\\map\\xiaoguai.txt", tbNumColSet);
	for _, tbRow in ipairs(tbData) do
		local tbPos = {
			nX	= tbRow.TRAPX;
			nY	= tbRow.TRAPY
			};
		table.insert(BaiHuTang.tbAnimalPos, tbPos);
	end
	tbData = Lib:LoadTabFile("\\setting\\pvp\\map\\chuanrudian_pk.txt", tbNumColSet);
	for _, tbRow in ipairs(tbData) do
		local tbPos = {
			nX = tbRow.TRAPX;
			nY = tbRow.TRAPY;
			}
		table.insert(BaiHuTang.tbPKPos, tbPos);
	end
	BaiHuTang.tbBatte[self.ChuJi] = {MapId = {
												{   226, 227, 228, 229, 
												 	275, 276, 277, 278, 
												 	334, 335, 336, 337};   --第一层地图
												{	230, 231, 
													279, 280,
													338, 339 }; 		  --第二层地图
												{232, 281, 340};		  --第三层地图
										 	 };
									tbNpcTemp  = {2660, 2681, 2685}; 				--小怪模板Id
									tbBossTemp = {2661, 2682, 2686}					--Boss模板Id
									};
										  
	BaiHuTang.tbBatte[self.GaoJi] = {MapId = {
												{234, 235, 236, 237};
												{238, 239};
												{240};
	    									 };
									  tbNpcTemp	 = {2662, 2683, 2687};
									  tbBossTemp = {2663, 2684, 2688};
									 };
	BaiHuTang.tbBatte[self.Goldlen] = {MapId = {
												{822, 823, 824, 825};
												{826, 827};
												{828};
	    									 };
									  tbNpcTemp	 = {3683, 3685, 3687};
									  tbBossTemp = {3684, 3686, 3688};
									 };
	BaiHuTang:SetTrapList();
	
	self.tbSysMsg[1] = "<color=yellow>Hoạt động Bạch Hổ Đường chính thức bắt đầu.<color> <color=green>Bạch Hổ Đường xuất hiện Sấm Đường Tặc!<color>";
	self.tbSysMsg[2] = "<color=yellow>Thời gian đăng ký Bạch Hổ Đường đã kết thúc.<color> <color=green>Hoạt động chính thức bắt đầu!<color>";
	self.tbSysMsg[3] = "<color=green>Thủ Lĩnh Sấm Đường Tặc<color> xuất hiện tại <color=yellow>Tầng 1 Bạch Hổ Đương!<color>";
	self.tbSysMsg[4] = "<color=green>Thủ Lĩnh Thiết Đồ Tặc<color> xuất hiện tại <color=yellow>Tầng 2 Bạch Hổ Đường!<color>";
	self.tbSysMsg[5] = "<color=green>Hộ Đồ Sứ<color> xuất hiện tại <color=yellow>Tầng 3 Bạch Hổ Đường!<color>";
	self.tbSysMsg[6] = "<color=yellow>Xin chúc mừng bạn đã vượt qua Bạch Hổ Đường thành công!<color>";
	self.tbSysMsg[7] = "<color=yellow>Hết thời gian.<color> <color=green>Bạn bị trục xuất khỏi Bạch Hổ Đường!<color>";
	self.nActionState = self.RESTSTATE; --刚开始将活动设置为 维护状态
end

BaiHuTang:init();
