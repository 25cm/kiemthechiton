-- 文件名　：xuanzhan.lua
-- 创建者　：xiewen
-- 创建时间：2008-10-31 00:07:10

local tbNpc = Npc:GetClass("xuanzhan");

function tbNpc:OnDialog()
	--if KGblTask.SCGetDbTaskInt(DBTASK_DOMAIN_BATTLE_NO) == 0 then
	--	Dialog:Say("Đẳng cấp trên 89 và đã gia nhập bang hội mới có thể tham gia tranh đoạt lãnh thổ.");
	--	return 0
	--end
	local tbOpt =
	 {
		--{"Lãnh thổ chiến quan quân nhu", Domain.DlgJunXu, Domain},
		{"<color=green>Nhận thưởng chinh chiến<color>", Domain.AwardDialog, Domain},
		--{"Cửa hàng bang hội", self.OpenTongShop, self},
		{"Thiết lập thành  chính", Domain.SelectCapital_Intro, Domain},
		{"<color=gold>Shop danh vọng Tranh Đoạt Lãnh Thổ<color>", self.OpenReputeShop, self},
		{"Kết thúc cuộc đối thoại"},
	}
	if Domain:GetBattleState() == Domain.PRE_BATTLE_STATE then
		tbOpt = Lib:MergeTable({{"<color=yellow>Tuyên chiến<color>", Domain.DeclareWar_Intro, Domain}}, tbOpt);
	end
	
	--if  me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,7) == 0 or me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,8) == 0
      --or me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,9) == 0 or me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,10) == 0
      --or me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,11) == 0 or me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,12) == 0 
    --then
     -- tbOpt = Lib:MergeTable({{"<color=yellow>Từ điển lãnh thổ tranh đoạt chiến<color>", self.AwardQuestion, self}}, tbOpt);
	--end
	
	local szSay = [[
    Tranh Đoạt Lãnh Thổ diễn ra hàng ngày. Thời gian: <color=yellow>Tuyên chiến: từ 21h00 đến 21h30. Diễn ra: từ 21h30 đến 21h55<color>, các bang hội có thể tấn công các lãnh thổ，đánh chiếm được lãnh thổ có thể nhận được Quan Ấn, Đồng, Rương TĐLT,、Nguyên Liệu TĐLT、và nhiều phần thưởng có giá trị khác.
]]
	Dialog:Say(szSay,tbOpt);
end

function tbNpc:OpenTongShop()
	me.OpenShop(145, 9);
end

function tbNpc:OpenReputeShop()
	me.OpenShop(147, 1);
end

function tbNpc:AwardQuestion()
  if me.nLevel <80 then
		local tbOpt =
	  {
		  {"Trở lại", self.OnDialog, self},
		  {"Kết thúc cuộc đối thoại"},		
	  }
		
		Dialog:Say("Bạn chưa đạt đẳng cấp 80, không thể tham gia hỏi đáp có thưởng.",tbOpt);
      
  else
   
	  local tbOpt =
	  {
	 	  {"Trở lại", self.OnDialog, self},
		  {"Kết thúc cuộc đối thoại"},		
	  }
	    if me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,12) == 0 then
	       tbOpt = Lib:MergeTable({{"Hỏi đáp<color=green> thời gian tranh đoạt<color>", HelpQuestion.StartGame, HelpQuestion, me, 12}}, tbOpt);
	    end    
	    if me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,11) == 0 then
	       tbOpt = Lib:MergeTable({{"Hỏi đáp<color=green> thiết lập<color>", HelpQuestion.StartGame, HelpQuestion, me,11}}, tbOpt);	       
		  end
	    if me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,10) == 0 then
	       tbOpt = Lib:MergeTable({{"Hỏi đáp<color=green> NPC tranh đoạt<color>", HelpQuestion.StartGame, HelpQuestion, me,10}}, tbOpt);	       
	  	end
	    if me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,9) == 0 then
	       tbOpt = Lib:MergeTable({{"Hỏi đáp<color=green> giao diện<color>", HelpQuestion.StartGame, HelpQuestion, me,9}}, tbOpt);
	    end    
	    if me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,8) == 0 then
	       tbOpt = Lib:MergeTable({{"Hỏi đáp<color=green> quy định<color>", HelpQuestion.StartGame, HelpQuestion, me,8}}, tbOpt);
	    end
	    if me.GetTaskBit(HelpQuestion.TASK_GROUP_ID,7) == 0 then
	       tbOpt = Lib:MergeTable({{"Hỏi đáp<color=green> quy trình<color>", HelpQuestion.StartGame, HelpQuestion, me, 7}}, tbOpt);
	    end    
	local szSay = string.format([[    vị hiệp sỹ giang hồ này，ngươi đã nắm rõ về quy tắc và quy trình liên quan đến trận chiến lãnh thổ chưa？
    tại đây ta có nhiều câu hỏi，nếu ngươi trả lời đúng hết，ta sẽ có thưởng phong phú cho ngươi%s。câu hỏi có chút khó，khuyên ngươi nên đọc rõ câu hỏiF12để có hỗ trợ chi tiết， đọc hết nội dung liên quan đến trận chiến lãnh thổ hãy đến trả lời。
    ngươi đã chuẩn bị để trả lời câu hỏi của ta chưa？
]], IVER_g_szCoinName);
	Dialog:Say(szSay,tbOpt);

   end
end
