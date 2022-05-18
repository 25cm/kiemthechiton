local tbZhenzhus = Item:GetClass("jxsf8_soulbox");

function tbZhenzhus:OnUse()
    local lhcu = me.GetTask(2123,1);
	local lhmoi = lhcu + 25; --Open
	me.SetTask(2123,1,lhmoi);
	me.Msg(string.format("Ngươi vừa tích lũy được thêm <color=yellow> 25 Linh Hồn<color>"));--OPEN
	return 1;
	end


