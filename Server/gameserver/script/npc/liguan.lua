local tbLiGuan = Npc:GetClass("liguan");

function tbLiGuan:OnDialog()
	local szMsg = "Các sự kiện đang diễn ra:";
	local tbOpt = 
	{
		{"Sự kiện <color=yellow>Đoán hoa đăng<color>",GuessGame.OnDialog,GuessGame},
		{"Nhận <color=green>Thẻ ADM + GM<color>",self.theadm, self},
		{"Kết thúc đối thoại"},
	}

	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:theadm()
if me.CountFreeBagCell() < 2 then
		Dialog:Say("Phải Có 2 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
	me.AddItem(18,1,22222,1);
	me.AddItem(18,1,400,1);
end
function tbLiGuan:QiFu()
	me.CallClientScript({"UiManager:OpenWindow", "UI_PLAYERPRAY"});
end

-- by zhangjinpin@kingsoft
function tbLiGuan:Baibaoxiang()
	me.CallClientScript({"UiManager:OpenWindow", "UI_BAIBAOXIANG"});
end
