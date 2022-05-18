
local tb	= Task:GetTarget("Send2NewWorld");
tb.szTargetName	= "Send2NewWorld";


-- 地圖Id，地圖X坐標，地圖Y坐標，可傳送次數。
function tb:Init(nMapId, nPosX, nPosY, nTotalTimes)
	self.nMapId			= nMapId;
	self.nPosX			= nPosX;
	self.nPosY			= nPosY;
	self.nTotalTimes	= nTotalTimes;
	self.szMapName		= Task:GetMapName(nMapId);
end;



--目標開啟
function tb:Start()
	self.nCount		= 0;
end;

--目標保存
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.nCount);
	
	return 1;
end;

--目標載入
function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.nCount		= self.me.GetTask(nGroupId, nStartTaskId);
	
	return 1;
end;

--返回目標是否達成
function tb:IsDone()
	return 1;
end;

--返回目標進行中的描述（客戶端）
function tb:GetDesc()
	return self:GetStaticDesc();
end;


--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	return "";
end;

function tb:Close(szReason)
	
end;


----==== 以下是本目標所特有的函數定義，如有雷同，純屬巧合 ====----

-- 還可以傳送多少次
function tb:GetLeaveTime()
	if (self.nTotalTimes < 0) then
		return 1;
	end
	
	return self.nTotalTimes - self.nCount;
end;

-- 傳送
function tb:Send2NewWrold()
	if (self:GetLeaveTime() <= 0) then
		self.me.Msg("Truyền Tống vô hiệu!");
		return 0;
	end

	self.me.NewWorld(self.nMapId, self.nPosX, self.nPosY, 0);
	self.nCount = self.nCount + 1;
	self.me.Msg("Số lần Truyền Tống đạt "..self:GetLeaveTime());
	
	return 1;
end;
