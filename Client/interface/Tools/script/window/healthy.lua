local tbHealthy = Ui.tbLogic.tbHealthy or {};
Ui.tbLogic.tbHealthy = tbHealthy;

tbHealthy.TIME_NOTIFY	= 3600 * Env.GAME_FPS;  ---3600

function tbHealthy:Init()
	if (self.nTimerRegId) then
		return;
	end
	self.nTimerRegId = 0;
end

function tbHealthy:OnTimer()
	Ui(Ui.UI_TASKTIPS):Begin("<color=Yellow>..xin hãy tạm rời máy nghỉ 1 lúc...<color>");
end

function tbHealthy:OnEnterGame()
	assert(self.nTimerRegId == 0);
	self.nTimerRegId = Timer:Register(self.TIME_NOTIFY, self.OnTimer, self);
end

function tbHealthy:OnLeaveGame()
	if (self.nTimerRegId ~= 0) then
		Timer:Close(self.nTimerRegId);
		self.nTimerRegId	= 0;
	end
end
