
-- 玩家可接20個任務
Task.TASK_GROUP_MIN				= 1001;
Task.TASK_GROUP_MAX				= 1020;

-- 玩家進入劍俠世界的第一個任務
Task.nFirstTaskId 				= 157;
Task.nFirstTaskValueGroup 		= 1021;
Task.nFirstTaskValueId 			= 6;


-- 任務共享的近距離定義
Task.nNearDistance				= 50;

-- 任務技能
Task.nAcceptTaskSkillId			= 305;	-- 接到任務的技能Id
Task.nFinishTaskSkillId 		= 306;	-- 完成任務的技能Id
Task.nFinishStepSkillId			= 328;	-- 完成步驟的技能Id

-- 任務類型
Task.emType_Main				= 1;		-- 主線任務
Task.emType_Branch	 			= 2;		-- 支線任務
Task.emType_World				= 3;		-- 世界任務
Task.emType_Random				= 4;		-- 隨機任務
Task.emType_Camp				= 5;		-- 軍營任務

Task.emSAVEID_TASKID			= 1;
Task.emSAVEID_REFID				= 2;
Task.emSAVEID_CURSTEP			= 3;
Task.emSAVEID_ACCEPTDATA		= 4;


--任務系統_新任務_頭頂		301
--任務系統_交任務_頭頂		302
--任務系統_新任務_小地圖	303
--任務系統_交任務_小地圖	304
-- 任務檢測類型
-- {頭頂，小地圖}
Task.CheckTaskFlagSkillSet = 
{
	MainCanVisible				= {301, 303},	-- 主線可見任務
	MainCanAccept				= {301, 303},	-- 主線可接任務
	MainCanNotReply				= {302, 304},	-- 主線不可交	
	MainCanReply				= {302, 304},	-- 主線可交				
						
	BranchCanVisible			= {334, 336},	-- 支線可見任務
	BranchCanAccept				= {334, 336},	-- 支線可接任務
	BranchCanNotReply			= {335, 337},	-- 支線不可交	
	BranchCanReply				= {335, 337},	-- 支線可交
	
	WorldCanVisible				= {334, 336},	-- 世界可見任務
	WorldCanAccept				= {334, 336},	-- 世界可接任務
	WorldCanNotReply			= {335, 337},	-- 世界不可交
	WorldCanReply				= {335, 337},	-- 世界可交
	
	RandomCanVisible			= {334, 336},	-- 隨機可見任務
	RandomCanAccept				= {334, 336},	-- 隨機可接任務
	RandomCanNotReply			= {335, 337},	-- 隨機不可交
	RandomCanReply				= {335, 337},	-- 隨機可交
	
	RepeatCanVisible			= {396, 398},	-- 可重復任務可見
	RepeatCanAccept				= {396, 398},	-- 可重復任務可接
	RepeatCanNotReply			= {397, 399},	-- 可重復任務不可交
	RepeatCanReply				= {397, 399},	-- 可重復任務可交
};

Task.nRepeatTaskAcceptMaxTime 	= 32;			-- 每天可接重復任務的最大次數
