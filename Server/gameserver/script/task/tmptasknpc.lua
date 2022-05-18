
Task.DestroyItem = Task.DestroyItem or {};
Task.DestroyItem.tbGiveForm = Gift:New();

local tbDestroyForm = Task.DestroyItem.tbGiveForm;

tbDestroyForm._szTitle = "Tiêu Hủy Đạo cụ";


-- 彈給與界面
function tbDestroyForm:OnOK()
	local nDel = 0;
	local nNDel = 0;
	local pFind = self:First();
	while pFind do
		if (pFind.szClass == "taskitem") then
			me.DelItem(pFind, Player.emKLOSEITEM_TYPE_DESTROY);
			nDel = 1;
		else
			nNDel = 1;
		end
		pFind = self:Next();
	end
	
	if (nDel == 1 and nNDel == 1) then
		me.Msg("Vật phẩm không thuộc nhiệm vụ không thể huỷ bỏ!");
	elseif (nDel == 0 and nNDel == 1) then
		me.Msg("Chỉ có thể huỷ vật phẩm nhiệm vụ!");
	end 
end;


function Task:_OnLoginTempLogic()
	local pPlayer = me;
	if (self:HaveDoneSubTask(pPlayer, tonumber("A0", 16), tonumber("13C", 16)) == 1 or
		self:HaveDoneSubTask(pPlayer, tonumber("9E", 16), tonumber("13A", 16)) == 1 or 
		Task:HaveDoneSubTask(pPlayer, tonumber("9F", 16), tonumber("13B", 16)) == 1) then
			pPlayer.SetTask(1021, 8, 1, 1);
		end
		
	if (Task:HaveDoneSubTask(pPlayer, tonumber("1", 16), tonumber("1", 16)) == 1 or
		Task:HaveDoneSubTask(pPlayer, tonumber("6", 16), tonumber("34", 16)) == 1 or 
		Task:HaveDoneSubTask(pPlayer, tonumber("A", 16), tonumber("4B", 16)) == 1) then
			pPlayer.SetTask(1022, 108, 1, 1)
		end
		
end

PlayerEvent:RegisterGlobal("OnLogin", Task._OnLoginTempLogic, Task);
