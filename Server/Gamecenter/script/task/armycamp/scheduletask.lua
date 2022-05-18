if not MODULE_GC_SERVER then
	return;
end

function Task:ArmyCamp_ScheduleTask()
	GlobalExcute({"Task.tbArmyCampInstancingManager:Annouce"});
end

local tbArmy = {};
function tbArmy:RegisterScheduleTask()
	local nTaskId = KScheduleTask.AddTask("Phó bản quân doanh", "Task", "ArmyCamp_ScheduleTask");
	assert(nTaskId > 0);
	for i=0, 23 do
		local nTime = i * 100;
		KScheduleTask.RegisterTimeTask(nTaskId, nTime, (i+1));
	end
end

tbArmy:RegisterScheduleTask();
