-------------------------------------------------------------------
--File: 	guessgame_GC.lua
--Author: 	sunduoliang
--Date: 	2008-2-28 17:30:24
--Describe:	猜灯谜，触发
if (not MODULE_GC_SERVER) then
	return 0;
end

function GuessGame:StartGuessGame()
	--之前周1,周3,周5  晚上20:30触发
	-- 现在改成每日中午12:30 -- 13:30
	local nNowWeek = tonumber(GetLocalDate("%w"));
	--if nNowWeek == 1 or nNowWeek == 2 or nNowWeek == 3 or nNowWeek == 4 or nNowWeek == 5 or nNowWeek == 6 or nNowWeek == 7 then
	GlobalExcute({"GuessGame:StartGuessGame"});
	--GlobalExcute({"Dialog:GlobalNewsMsg_GS","Mỗi ngày vào <color=green>buổi trưa: (từ 12h đến 13h) hoặc buổi tối: (từ 20h đến 21h)<color> <color=gold>NPC Đoán Hoa Đăng<color>: <color=red>Nhan Như Ngọc<color> sẽ xuất hiện tại các Tân Thủ Thôn các nhân sĩ hãy tìm gặp để trà lời các câu hỏi để giành các phần thưởng giá trị!"});
    --KDialog.MsgToGlobal("Mỗi ngày vào <color=green>buổi trưa: (từ 12h đến 13h) hoặc buổi tối: (từ 20h đến 21h)<color> <color=gold>NPC Đoán Hoa Đăng<color>: <color=yellow>Nhan Như Ngọc<color> sẽ xuất hiện tại các Tân Thủ Thôn các nhân sĩ hãy tìm gặp để trà lời các câu hỏi để giành các phần thưởng giá trị!");
	end
