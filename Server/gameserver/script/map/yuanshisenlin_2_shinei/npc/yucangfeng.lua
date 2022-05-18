--Require("\\script\\npc\\faction\\menpaizhangmenren.lua");

--local tbGaiBangMenPaiZhangMenRen = Npc:NewClass("gaibangzhangmenren", "menpaizhangmenren");

local tbJie = Npc:GetClass("yucangfeng");

function tbJie:OnDialog()
	-- 这里可以加入一些通用的Npc对话事件
	local tbOpt	= {};
	-- local task_value = me.GetTask(1022,76)
	
	-- if task_value == 1 then
		tbOpt[#tbOpt+1] = {"Trong Tây Rừng Nguyên Sinh", self.Send2NewWorld};
		tbOpt[#tbOpt+1]	= {"Ta chưa muốn đi", self.OriginalDialog};
		tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
		Dialog:Say(string.format("%s：Bạn đã đến :，"..me.szName, him.szName), tbOpt);
		return;
	-- end;
end


function tbJie:Send2NewWorld()
	me.NewWorld(205,1722,3311);
	me.SetFightState(1);
end

-- 原有Npc对话，不会进行对话拦截
function tbJie:OriginalDialog()
	self:OnDialog();
end;
