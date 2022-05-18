-- 对C导出的Npc对象进行封装
if MODULE_GC_SERVER then
	return
end
local self;		-- 提供以下函数用的UpValue

-------------------------------------------------------------------------------
-- for both server & client
function _KLuaNpc.GetTempTable(szModelName)
	if (not szModelName) then
		print("Khi nhận biến tạm từ người chơi cần điền tên module");
		assert(false);
	end
	
	if (not Env.tbModelSet[szModelName]) then
		print("Không có tên module này, xem scripttable.txt", szModelName)
		assert(false);
	end
	
	local tbTemp = self.GetNpcTempTable();
	if (not tbTemp[szModelName]) then
		tbTemp[szModelName] = {};
	end
	
	return tbTemp[szModelName];
end

_KLuaNpc._Delete = _KLuaNpc.Delete;

function _KLuaNpc.Delete()
	if (Task.tbToBeDelNpc[self.dwId]== 1) then
		print("TaskNpcDeleteError", self.dwId, debug.traceback());
--	elseif (Task.tbToBeDelNpc[self.dwId]== 0) then
--		print("TaskDeleteNpc", self.dwId, debug.traceback());
	end
	
	self._Delete();
end
