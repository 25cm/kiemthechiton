-- 文件名　：huihuangzhiguo_GC.lua
-- 创建者　：zhongchaolong
-- 创建时间：2007-10-11 11:40:08
--GC每5分钟调用一次,在指定时间发送黄金种子确定和种子散播的消息给GS
--只放gamecenter
Require("\\script\\event\\huihuangguo\\huihuangzhiguo_head.lua")
HuiHuangZhiGuo.START_TIME	=	1930;
HuiHuangZhiGuo.END_TIME		=	2000;
local tbConfig				=	{
									{szMapName ="Chiến Trường Cổ",nCount = 50,nMapId = 30,nSeedLevel = 1},
									{szMapName ="Quán Trọ Long Môn",nCount = 50,nMapId = 31,nSeedLevel = 1},
									{szMapName ="Quân Mã Trường",nCount = 50,nMapId = 32,nSeedLevel = 1},
									{szMapName ="Mai Hoa Lĩnh",nCount = 50,nMapId =33,nSeedLevel = 1},
									{szMapName ="Trường Giang Hà Cốc",nCount = 50,nMapId =34,nSeedLevel = 1},
									{szMapName ="Thị trấn Bạch Tộc",nCount = 50,nMapId =35,nSeedLevel = 1},
									{szMapName ="Nhạn Đãng Long Thu",nCount = 50,nMapId =36,nSeedLevel = 1},
									{szMapName ="Bờ Hồ Động Đình",nCount = 50,nMapId =37,nSeedLevel = 1},
								};
function HuiHuangZhiGuo:TaskShedule()
	do return 0; end --内测期间关闭辉煌之果，简单关闭。
	--GC 的调度
	--在19:30到20:01分中间才能触发
	local nNowTime = tonumber(GetLocalDate("%H%M"));
	
	if (nNowTime >= 0 and nNowTime < 5) then --在00:00到00:05之间设置黄金之种的位置
		self:SetGoldenSeedCity_GC();
		return 0;
	end
	if (nNowTime >= self.START_TIME and nNowTime <= self.END_TIME) then--辉煌之种活动产生种子
		self:MakeAllSeed(nNowTime);
		return 0
	end
end


function HuiHuangZhiGuo:MakeCitySeed(nCityIndex,nNowTime)
	--通知GS在某个城市上产生多少个种子
	
	local nGrowPhase				= 0; -- 0 đang sinh trưởng 1 ra trái để hái mặc định 0
	local nWetherMakeGoldFruitTime	= 0; --判断是否是最后一批（最后一批才耍黄金种子），0不是；1是
	
	if(nNowTime >= 1950 and nNowTime < 2000 and KGblTask.SCGetDbTaskInt(DBTASK_HuangJinZhiZhong_MapId) == tbConfig[nCityIndex].nMapId) then 
		nWetherMakeGoldFruitTime = 1;
	end

	if (math.mod(nNowTime, 10) >= 5) then --种子成熟,刷果子
		nGrowPhase = 1
	end
	if (nGrowPhase == 0) then
		_G.GlobalExcute({"KDialog.NewsMsg", 0, Env.NEWSMSG_NORMAL, "<Quả Huy Hoàng> Đã xuất hiện trên các bản đồ ven tân thủ thôn，5 phút sau sẽ kết quả,bạn phải tốc độ để hái."});
	end
	_G.GlobalExcute({"HuiHuangZhiGuo:GreatSeedExecute", tbConfig[nCityIndex]["nMapId"], tbConfig[nCityIndex]["nSeedLevel"], tbConfig[nCityIndex]["nCount"], nGrowPhase, nWetherMakeGoldFruitTime});
end

function HuiHuangZhiGuo:SetGoldenSeedCity_GC()
	--设置黄金之种所在的地图的地图ID
	
	local nGoldCityIndex = MathRandom(1,#tbConfig);
	KGblTask.SCSetDbTaskInt(DBTASK_HuangJinZhiZhong_MapId, tbConfig[nGoldCityIndex]["nMapId"]);--记录黄金种子所在城市的nMapid
end

function HuiHuangZhiGuo:MakeAllSeed(nNowTime)
	local i			= 0;	
	local nMapCount	= #tbConfig;
	for i = 1,nMapCount do --向每个城市发送产生辉煌之种消息
		self:MakeCitySeed(i,nNowTime);
	end;
end

