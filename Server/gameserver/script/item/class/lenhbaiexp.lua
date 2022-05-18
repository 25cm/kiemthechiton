
local tbLenhBaiNhanKinhNghiem	= Item:GetClass("lenhbaiexp");

function tbLenhBaiNhanKinhNghiem:OnUse()
	local szMsg = "<color=red> Chú ý :<color> <color=yellow>lệnh bài không thể cộng dồn thời gian , không nên ăn nhiều lệnh bài cùng 1 lúc. Rất phí <color>";
	local tbOpt = {

		{"<color=orange>Mở<color>",self.OnDialog_4,self};
		}
	Dialog:Say(szMsg, tbOpt);
	end
	function tbLenhBaiNhanKinhNghiem:OnDialog_4()
local tbItemId = {18,13,20396,1,0,0}
me.AddSkillState(890, 4, 2,2 * 60 * 60 * Env.GAME_FPS, 1, 0, 1);
me.Msg("<color=yellow>Nhận được thời gian x3 kinh nghiệm trong vòng 2 giờ<color>");
	Task:DelItem(me, tbItemId, 1);
	end
