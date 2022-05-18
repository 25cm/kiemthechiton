-- 文件名　：define.lua
-- 创建者　：jiazhenwei
-- 创建时间：2009-12-7
-- 描  述  ：


CFuben.TASKID_GROUP		= 2110;	--任务变量组
CFuben.TASKID_DATE		= 1;	--
CFuben.TASKID_NTIMES	 	= 2;	--副本次数（限制2-30）

CFuben.tbMapList = CFuben.tbMapList or {};
CFuben.NTIMES_END = Env.GAME_FPS * 60 * 1;   --副本申请15分钟没有开启的自动注销掉

CFuben.tbMapType = {
					["village"] = "Tân thủ thôn",
					["faction"] = "Môn phái",
					["city"] = "Thành thị",
					["fight"] = "Khu vực"
				};
