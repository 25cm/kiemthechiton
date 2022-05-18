-- 服务端事件

function ServerEvent:OnStart()
	-- 设定服务器默认回城点
	local tbNpcWupinbaoguanren	= Npc:GetClass("wupinbaoguanren");
	for _, tbPos in ipairs(tbNpcWupinbaoguanren.tbBornPos) do
		if (SetDefaultRevivePos(tbPos[1], tbPos[2], tbPos[3]) == 1) then
			break;
		end
	end
	Task.TbTaskGouHuo:Init(); 			--任务篝火npc加载
	TimeFrame:Init()					--时间轴初始化
	Player:SetMaxLevelGS(); 			--等级最大值设置
	EventManager.EventManager:Init();	--活动系统初始化;
	SpecialEvent.RecommendServer:OnDayClose()	--推荐服务器启动当天24：00关闭。
	Player.tbOffline:OnUpdateLevelInfo();
	if GLOBAL_AGENT then			-- 全局服务器没有等级限制
		KPlayer.SetMaxLevel(139);
	end
	
	-- 设定检查几率
	KPlayer.SetGameCodeCheckRate(10000, 10, 10)
	
	
	-- 执行服务器启动函数
	if self.tbStartFun then
		for i, tbStart in ipairs(self.tbStartFun) do
			tbStart.fun(unpack(tbStart.tbParam));
		end
	end
	
	--所有事件启好后给GC的通知
	GCExcute({"GCEvent:OnRecConnectGsStartEvent", GetServerId()});
	print("--- Kiem tra file hoan tat - Co the khoi dong game ---");
end

-- 注册服务器启动执行函数
function ServerEvent:RegisterServerStartFunc(fnStartFun, ...)
	if not self.tbStartFun then
		self.tbStartFun = {}
	end
	table.insert(self.tbStartFun, {fun=fnStartFun, tbParam=arg});
end

function ServerEvent:CdkeyVerifyResult(nResult)
end

--nPresentType类型，
--nResult:1代表成功，2代表失败，3代表帐号不存在，1009代表传入的参数非法或为空，1500代表礼品序列号不存在，1501礼品已被使用,1502礼品已过期
function ServerEvent:PresentKeyVerifyResult(nPresentType, nResult)
	print("Đang xác nhận.........", nPresentType, nResult);
	PresendCard:VerifyResult(nPresentType, nResult);
end

function ServerEvent:QueryNameResult(szRoleName, nResult)
end

function ServerEvent:ChangeNameResult(szRoleName, nResult)
end

function ServerEvent:ChangeTongNameResult(szOldTong, szNewTong, nResult)
end

function ServerEvent:OnClientCall(tbCall)
	self:DbgOut("OnClientCall", unpack(tbCall));
	if type(tbCall[1]) ~= "string" then
		return
	end
	--第一个参数必须是c2s表里的一个函数名字
	local fun = rawget(c2s, tbCall[1])
	if not fun then
		print("Error On c2s Called, Invalid Command: "..tbCall[1])
		return
	end
	fun(c2s, unpack(tbCall, 2))
end

function ServerEvent:OnGlobalExcute(tbCall)
	self:DbgOut("OnGlobalExcute", unpack(tbCall));
	Lib:CallBack(tbCall);
end
