-------------------------------------------------------------------
--File: kinevent.lua
--Author: lbh
--Date: 2007-7-9 18:02
--Describe: 游戏流程事件的家族事务（启动，退出， 日常活动等）
-------------------------------------------------------------------
if not Kin then --调试需要
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
end

--启动，家族初始化
function Kin:Init()
	if MODULE_GAMESERVER then
		return self:Init_GS()
	elseif MODULE_GC_SERVER then
		return self:Init_GC()
	end
end

--退出，反初始化
function Kin:UnInit()
	if MODULE_GAMESERVER then
		return self:UnInit_GS()
	elseif MODULE_GC_SERVER then
		return self:UnInit_GC()
	end
end


if MODULE_GC_SERVER then
----------------------------------------------------------------------
function Kin:Init_GC()
	local itor = KKin.GetKinItor()
	if not itor then
		return 0
	end
	local nKinId = itor.GetCurKinId()
end

function Kin:UnInit_GC()

end

-- 家族活动处理

-- 家族活动开始
function Kin:KinEventsStart()
	self.PerKinEvents_cNextKin, self.PerKinEvents_nNextKin = KKin.GetFirstKin()
	if not self.PerKinEvents_cNextKin then
		return 0;
	end	
	
	-- 每隔KIN_EVENT_ELAPES帧检测一次一个家族的活动时间表
	Timer:Register(self.KIN_EVENT_ELAPES, self.EventAction_Timer, self)
end

-- 每隔KIN_EVENT_ELAPES帧响应Timer的家族活动回调函数
function Kin:EventAction_Timer()
	self.PerKinEvents_cNextKin, self.PerKinEvents_nNextKin = KKin.GetNextKin(self.PerKinEvents_nNextKin);
	
	if not self.PerKinEvents_cNextKin then
		self.PerKinEvents_cNextKin, self.PerKinEvents_nNextKin = KKin.GetFirstKin();
	end
	
	Kin:EventAction_BuildFlag(self.PerKinEvents_nNextKin);
	-- 还有的家族活动在此后边添加

	return self.KIN_EVENT_ELAPES;	-- KIN_EVENT_ELAPES帧后再执行
end

-- 家族活动:家族插旗
function Kin:EventAction_BuildFlag(nKinId)
	local cKin = KKin.GetKin(nKinId);
	if not cKin then 
		return 0;
	end
	local nOrderTime = cKin.GetKinBuildFlagOrderTime();
	local nPreDay = cKin.GetTogetherTime();
	local nTime = GetTime();
	local nNowDay = tonumber(os.date("%m%d", nTime));
	local nNowHour = tonumber(os.date("%H", nTime));
	local nNowMin = tonumber(os.date("%M", nTime));
	local nNowTime = nNowHour * 60 + nNowMin;	

	if nOrderTime == 0 then
		return 0;
	end	
	
-- 如果到预定时间的前半个小时,20分钟,10分钟提示
	local tbKinData = Kin:GetKinData(nKinId);
	if not tbKinData.nBuildFlagNotifyStep then
		tbKinData.nBuildFlagNotifyStep = 1;
	end
	local nStep = tbKinData.nBuildFlagNotifyStep;
	if (nStep <= 3 and nPreDay ~= nNowDay) then
		
		local nNoticeTime = nOrderTime - self.tbLeftTime[nStep];
		if (nNoticeTime <= nNowTime and nOrderTime >= nNowTime) then
			GlobalExcute{"Kin:NoticeKinBuildFlag_GS2", nKinId, nOrderTime - nNowTime};
			tbKinData.nBuildFlagNotifyStep = nStep + 1;
		end	
	else
		nStep = 1;	
	end
	
-- 如果到了预定时间
	if nOrderTime <= nNowTime and nPreDay ~= nNowDay then
		print("Kin"..nKinId..",BuildFlag——".."nPreDay"..nPreDay..",nNowDay"..nNowDay);
		cKin.SetTogetherTime(nNowDay);
		GlobalExcute{"Kin:KinBuildFlag_GS2", nKinId};
	end
end



-- 家族活动:家族关卡
--function Kin:EventAction_KinGame(nKinId)
--	print("检测家族关卡时间");
--	local cKin = KKin.GetKin(nKinId);
--	local tbOrderTime = {};
--	tbOrderTime[1] = cKin.GetKinGameOrderTime1();
--	tbOrderTime[2] = cKin.GetKinGameOrderTime2();
--	tbOrderTime[3] = cKin.GetKinGameOrderTime3();
	
--	local nPreTime = cKin.GetKinGameTime();
	
--	for n = 1, #tbTime do
--		if os.date("%w", tbOrderTime[n]) == os.date("%w", GetTime()) then
--			if os.date("%X", tbOrderTime[n]) >= os.date("%X", GetTime()) and 
--			   os.date("%W%w", nPreTime) ~= os.date("%W%w", GetTime()) then
--				cKin:SetKinGameTime(tbOrderTime[n]);
--				GlobalExcute{"KinGame:ApplyKinGame", nKinId, cKin.GetKinGameOrderMapId()};
				--GCExcute{"KinGame:ApplyKinGame_GC", nKinId, nMemberId, him.nMapId, me.nId};
--			end
--		end
--	end
--end

-- 在GC开始时调用的函数RegisterGCServerStartFunc里注册家族活动开始函数
GCEvent:RegisterGCServerStartFunc(Kin.KinEventsStart, Kin);

----------------------------------------------------------------------
end


if MODULE_GAMESERVER then
----------------------------------------------------------------------
function Kin:Init_GS()

end

function Kin:UnInit_GS()
	--同步缓存的总江湖威望价值量
	for nKinId, aKinData in pairs(self.aKinData) do
		if aKinData.nTotalReputeValue > self.CONF_VALUE2REPUTE then
			KKin.ApplyAddKinTask(nKinId, 6, math.floor(aKinData.nTotalReputeValue / self.CONF_VALUE2REPUTE))
		end
	end
end

----------------------------------------------------------------------
end
