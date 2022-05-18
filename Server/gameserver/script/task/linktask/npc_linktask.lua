
-- ====================== 文件信息 ======================

-- 劍俠世界門派任務鏈 NPC 處理文件
-- Edited by peres
-- 2007/03/16 PM 03:25

-- 在人群裡，一對對年輕的情侶，彼此緊緊地糾纏在一起，旁若無人地接吻。
-- 愛情如此美麗，似乎可以擁抱取暖到天明。
-- 我們原可以就這樣過下去，閉起眼睛，抱住對方，不鬆手亦不需要分辨。

-- ======================================================

Require("\\script\\task\\linktask\\linktask_head.lua");

local tbNpc = Npc:GetClass("seasonnpc");

function tbNpc:OnDialog()
	local nOpen = LinkTask:GetTask(LinkTask.TSK_TASKOPEN);
	local nTaskType		= LinkTask:GetTask(LinkTask.TSK_TASKTYPE);

	local nContain = LinkTask:GetTask(LinkTask.TSK_CONTAIN);
	local nPauseTime = LinkTask:GetTask(LinkTask.TSK_CANCELTIME);
	
	-- 判斷是否超過了容忍次數，被禁止做任務中
	if nContain >= LinkTask.CONTAIN_LIMIT then
		if me.nOnlineTime - nPauseTime >= LinkTask.PAUSE_TIME then
			LinkTask:SetTask(LinkTask.TSK_CONTAIN, 0);
		else
			Dialog:Say("Bạn thiếu nhẫn nại vậy sao? Hãy nghỉ ngơi lát rồi quay lại!");
			return;
		end;
	end;	
		
	-- 因為某種原因未能領取到獎勵
	if LinkTask:GetAwardState()==1 then
		Dialog:Say("Chúc mừng bạn đã hoàn thành nhiệm vụ, nhận thưởng ngay chứ?",{
				   {"<color=yellow>Mau đưa ta<color>", tbNpc.PayAward, tbNpc},
				   {"Không nhận", tbNpc.LeaveNpc, tbNpc},
			});		
		return;
	end;	
	
	-- 如果從來沒有開始過，則開始
	if nOpen==0 then
		if me.nLevel >=20 then
			Dialog:Say("Tại hạ Bao Vạn Đồng có chuyện thỉnh cầu, không biết đại hiệp có thể nghe ta nói không ?", {
					  {"Được chứ", tbNpc.OpeningTalk, tbNpc},
					  {"Thôi đi", tbNpc.OnExit, tbNpc},
					});
			return;
		else
			Dialog:Say("Đạt cấp <color=yellow>>20<color> hãy đến tìm ta, có chuyện ta muốn nhờ đại hiệp giúp.");
			return;
		end;
	end;
	
	local nTaskType	= LinkTask:GetTask(LinkTask.TSK_TASKTYPE);
	local tbTask 	= Task:GetPlayerTask(me).tbTasks[nTaskType];
	
	LinkTask:CheckPerDayTask();
	
	-- 如果玩家身上沒任何任務鏈的任務，則直接提示下一個
	-- 如果存在未完成的任務，則顯示當前任務的對話
	if tbTask == nil then
		self:NextDialog();
	else
		local nSubTaskId	= LinkTask:GetTask(LinkTask.TSK_TASKID);
		self:ShowTaskInfo(nSubTaskId);
	end;
end;


function tbNpc:OpeningTalk()
	
	if me.nLevel < 20 then
		Dialog:Say("Ờ……Ta thấy võ nghệ của ngươi còn chưa vững, tạm thời khó có thể đảm đương nhiệm vụ, đạt cấp <color=red>20<color> hãy quay lại tìm ta!");
		return;
	end;
	
	local szTalk	= [[<color=red><npc=3573><color>: Gần đây, tướng sĩ Nghĩa quân thắng lớn ở bến đò Hoài Hà, nhưng số lương thảo vất vả giành được chỉ đủ dùng 10 ngày. Thủ lĩnh Bạch Thu Lâm vì chuyện này mà ngày không ăn, đêm không ngủ, ngày ngày hối thúc ta giải quyết.<end>
						<color=red><npc=3573><color>: Bây giờ trong tay có tiền, nhưng thiên hạ chiến tranh liên miên, lương thực thiếu thốn, vật tư khan hiếm. Người Kim cấm mọi giao dịch biên giới, triều đình lại bóc lột dân chúng nghèo khổ, muốn lo đủ lương thảo còn khó hơn lên trời.<end>
						<color=red><npc=3573><color>: Nhưng cho dù làm thang leo lên trời thì ta cũng phải làm thôi. Lão Bao ta từ nhỏ đã mất song thân, chính Nghĩa quân nuôi lớn ta. Những người liều sống liều chết trên chiến trường cũng chỉ mong có cơm ăn, họ đều là huynh đệ sư muội của ta, ta thật không nhẫn tâm.<end>
						<color=red><npc=3573><color>: Nếu ta làm vậy, họ phải mặc áo vải đi liều mạng với quân địch mặc toàn áo giáp, phải cưỡi con ngựa gầy còm đối chọi với thiết kỵ quân Kim. Đó là tự tìm cái chết.<end>
						<color=red><npc=3573><color>: May là mấy ngày trước, cháu ngoại của Trâu Đức Khoái gợi ý cho ta 1 biện pháp hay: nhờ thiên hạ hào kiệt giúp Nghĩa quân xoay sở vật tư. Chúng ta lại giúp các cao thủ này luyện võ học thượng thừa hơn, đem bạc giành được từ chỗ người Kim đổi lấy những thứ cần thiết từ dân chúng. Nghĩ cũng phải, người trong thiên hạ nhiều như vậy, mọi người coi như đều được thứ mình cần. Không biết ngươi có đồng ý giúp ta không?
					]];
						
	TaskAct:Talk(szTalk, Npc:GetClass("seasonnpc").OpenTask, Npc:GetClass("seasonnpc"));
	
end;

function tbNpc:OpenTask()
	LinkTask:Open();
	local nMainTaskId, nSubTaskId = LinkTask:StartTask();  -- 開始任務
	if (not nMainTaskId) then
		return;
	end
	self:ShowTaskInfo(nSubTaskId);
end;

-- 問玩家是否進行下一步的對話框，如果是隊長，則詢問是否與隊友共享任務
function tbNpc:NextDialog()
	local nTaskNum = LinkTask:GetTaskNum()
	local nTaskNum_PerDay = LinkTask:GetTaskNum_PerDay();
	
	local szMainText	= "Hôm nay ngươi liên tục hoàn thành <color=green>"..nTaskNum_PerDay.."<color> lần, tiếp tục không? \n\nLiên tiếp hoàn thành 10 nhiệm vụ sẽ nhận được phần thưởng bất ngờ"
	
--	if me.IsCaptain() ~= 1 then
		Dialog:Say(szMainText, {
				  {"<color=yellow>Ta đang rảnh đây<color>", tbNpc.NextTask, tbNpc},
				  {"Để ta suy nghĩ đã", tbNpc.LeaveNpc, tbNpc},
			});
--	else
--		Dialog:Say(szMainText, {
--				  {"我想與隊友一起進行下一次任務", tbNpc.TeamNextTask, tbNpc},
--				  {"我想自己進行任務", tbNpc.NextTask, tbNpc},
--				  {"我再考慮考慮", tbNpc.LeaveNpc, tbNpc},
--			});		
--	end;
	
end;

-- 進行下一個任務的選擇，如果 nIsTeam 為 1 ，則將該任務與隊友共享
function tbNpc:NextTask(nIsTeam)
	local nMainTaskId, nSubTaskId = LinkTask:StartTask();  -- 開始任務，並把任務強制設置玩家接受
	if (not nMainTaskId) then
		return;
	end
	
	if nMainTaskId <= 0 or nSubTaskId <= 0 then
		Dialog:Say("Hôm nay bạn hoàn thành <color=green>50 Nhiệm Vụ<color=green> . <color=yellow>Ngày mai trở lại<color>.");		
		return;
	end;
	
	self:ShowTaskInfo(nSubTaskId);
	
	if nIsTeam then
		local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
		
		local pOldMe = me;
		local nOldIndex	= me.nPlayerIndex;
		
		if (not tbTeamMembers) then
			return;
		end
				
		local szCaptainName = me.szName;
		local nCaptainLevel	= me.nLevel;	-- 隊長的等級
		
		for i=1, nMemberCount do
			if (nOldIndex ~= tbTeamMembers[i].nPlayerIndex) then
				
				me = tbTeamMembers[i];
				
				local nOpen = me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKOPEN);
				local nContain = me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_CONTAIN);
				local nAwardState = me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_AWARDSAVE);
				local nTotalNum	= me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TOTALNUM_PERDAY); -- 每天固定次數的限制
				local nLevelAbs	= math.abs(me.nLevel - nCaptainLevel);	-- 等級相差的絕對值
				
				-- 滿足的條件：已經開始做野叟任務，沒被禁止，沒有處於領獎狀態，沒超過上限
				if nOpen == 1 and nContain < 3 and nAwardState ~= 1 and nTotalNum < LinkTask.PERDAY_NUM_MAX and nLevelAbs <= 10 then
					
					local nTaskType	= me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKTYPE);
					local tbTask 	= Task:GetPlayerTask(me).tbTasks[nTaskType];
					
					-- 當前處於未接任務的狀態
					if tbTask == nil then
						LinkTask:Team_ShowTaskInfo(me, szCaptainName, nMainTaskId, nSubTaskId);
					end;
				end;
			end;
		end;
		
		me = pOldMe;
	end; 
end;


-- 選擇與隊友共享任務
function tbNpc:TeamNextTask()
	
	local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
	local tbPlayerName	 = {};

	if (not tbTeamMembers) then
		Dialog:Say("Bạn không nằm trong tổ đội!");
		return;
	end
	
	local pOldMe = me;
	local nOldIndex	= me.nPlayerIndex
	local nCaptainLevel	= me.nLevel;	-- 隊長的等級
	
	for i=1, nMemberCount do
		if (nOldIndex ~= tbTeamMembers[i].nPlayerIndex) then
			
			me = tbTeamMembers[i];
			
			local nOpen = me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKOPEN);
			local nContain = me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_CONTAIN);
			local nAwardState = me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_AWARDSAVE);
	
			local nTotalNum	= me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TOTALNUM_PERDAY); -- 每天固定次數的限制
			local nLevelAbs	= math.abs(me.nLevel - nCaptainLevel);	-- 等級相差的絕對值
			
--			print ("LinkTask: "..me.szName.." Start check: ", nOpen, nContain, nAwardState);
						
			-- 滿足的條件：已經開始做野叟任務，沒被禁止，沒有處於領獎狀態，沒超過上限
			if nOpen == 1 and nContain < 3 and nAwardState ~= 1 and nTotalNum < LinkTask.PERDAY_NUM_MAX and nLevelAbs <= 10 then
				
				local nTaskType	= me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKTYPE);
				local tbTask 	= Task:GetPlayerTask(me).tbTasks[nTaskType];
				
				-- 當前處於未接任務的狀態
				if tbTask == nil then
--					print ("LinkTask: "..me.szName.." Pass!");
					table.insert(tbPlayerName, {tbTeamMembers[i].nPlayerIndex, tbTeamMembers[i].szName});
				end;
			end;
		end;
	end;
	
	me = pOldMe;
	
	if #tbPlayerName <= 0 then
		Dialog:Say("Hiện không có đồng đội nào phù hợp điều kiện để chia sẻ nhiệm vụ với bạn, điều kiện như sau: <color=yellow>\n\n    Đồng đội phải ở gần bạn\n    Cấp của đồng đội >20 và đã mở Nhiệm vụ nghĩa quân\n    Đồng đội đã hoàn thành 1 đợt nhiệm vụ và chưa nhận nhiệm vụ mới\n    Cấp giữa đội trưởng và đội viên hơn kém nhau <10<color>\n<color=yellow>\n");
		return;
	end;
	
	local szMembersName	= "\n";
	
	for i=1, #tbPlayerName do
		szMembersName = szMembersName.."<color=yellow>"..tbPlayerName[i][2].."<color>\n";
	end;
	
	Dialog:Say("Đồng đội phù hợp điều kiện chia sẻ nhiệm vụ với bạn gồm có:\n"..szMembersName.."\nBạn muốn cùng đồng đội chia sẻ nhiệm vụ tiếp theo?", 
			{
				{"Phải", tbNpc.NextTask, tbNpc, 1},
				{"Không", tbNpc.LeaveNpc, tbNpc},
			}
		);
end;


function tbNpc:ShowTaskInfo(nSubTaskId)
	
	local nTaskNum 			= LinkTask:GetTaskNum();		-- 總的任務數
	local nTaskNum_PerDay	= LinkTask:GetTaskNum_PerDay();	-- 每天完成的任務數
	
	local nTaskType		= LinkTask:GetTask(LinkTask.TSK_TASKTYPE);
	local szTaskName	= Task.tbSubDatas[nSubTaskId].szName;
	local szDesc 		= LinkTask:GetTaskText(nTaskType, nSubTaskId);
	
	if szDesc=="" then
		szDesc = "<Không có mô tả nhiệm vụ>";
	end;
	
	local szTalk	 = "Hôm nay ngươi liên tục hoàn thành <color=green>"..nTaskNum_PerDay.."<color> nhiệm vụ.<enter><enter>"..
			   			"Tên nhiệm vụ: "..szTaskName.."<enter><enter>"..
			   			"Mô tả nhiệm vụ: "..szDesc.."<enter><enter>"..
			   			"Khi điểm danh vọng nghĩa quân của ngươi đạt mức nhất định, có thể mua trang bị từ Quan Quân Nhu của nghĩa quân.";
	
	local tbSelect = {};
	table.insert(tbSelect, {"Ta biết rồi", tbNpc.LeaveNpc, tbNpc});	
	table.insert(tbSelect, {"<color=yellow>Ta đã hoàn thành nhiệm vụ<color>", tbNpc.CheckTask, tbNpc});	
	
	if nTaskType == 20000 then
		table.insert(tbSelect, {"<color=green>Hãy đưa ta đến nơi cần chiến đấu nào<color>", tbNpc.SendWorld, tbNpc, nTaskType, nSubTaskId});
	end;
	
	table.insert(tbSelect, {"Ta muốn hủy nhiệm vụ", tbNpc.CancelTask, tbNpc});
	
	Dialog:Say(szTalk, tbSelect);
end;


function tbNpc:SendWorld(nTaskType, nSubTaskId)
	local nMapId = Task.tbSubDatas[nSubTaskId].tbSteps[1].tbTargets[1].nMapId;
	local szMapName	= Task:GetMapName(nMapId);
	
	if not LinkTask.tbMapPos[nMapId] then
		Dialog:Say("Bây giờ ta chưa thể đưa ngươi đến "..szMapName.."Hay là ngươi tự đi đi!");
		return;
	end;
	
	local nMapX, nMapY = LinkTask.tbMapPos[nMapId][2], LinkTask.tbMapPos[nMapId][3];
	
	Dialog:Say("Bây giờ ngươi muốn đến <color=yellow>"..szMapName.."<color>? Huynh đệ nghĩa quân phân bố khắp nơi, Lão Bao ta có thể sắp xếp xe ngựa đưa ngươi đí!",
			{
				{"Phải", tbNpc.SendWorldNow, tbNpc, nMapId, nMapX, nMapY},
				{"Không"},
			}
		);
end;


function tbNpc:SendWorldNow(nMapId, nMapX, nMapY)
	
	me.NewWorld(nMapId, nMapX, nMapY);
	me.SetFightState(1);
	
end;


-- 檢測任務是否完成
function tbNpc:CheckTask()
	
	LinkTask:_Debug("Start check task.");
	
	if LinkTask:CheckHaveItemTarget() == 1 then
		LinkTask:_Debug("Have find item target, show gift dialog.");
		LinkTask:ShowGiftDialog();
		return;
	end;
	
	if LinkTask:CheckTaskFinish() == 1 then
		LinkTask:OnAward();		
		return;
	else
		Dialog:Say("Chưa hoàn thành nhiệm vụ, lại dám đến lừa ta!");
		return;
	end;
	
end;

-- 給玩家發獎勵
function tbNpc:PayAward()
	
	if LinkTask:GetAwardState()==2 then
		Dialog:Say("Ngươi đã nhận thưởng 1 lần rồi à?");
		return;
	end;
	LinkTask:OnAward();
end;

-- 取消任務
function tbNpc:CancelTask()
	local nCancel = LinkTask:GetTask(LinkTask.TSK_CANCELNUM);
	local szTalk = "";
	if nCancel<1 then
		szTalk = "Hiện tại ngươi không còn cơ hội hủy, muốn hủy nhiệm vụ này?";
	else
		szTalk = "Hiện tại bạn có <color=yellow>"..nCancel.."<color> lần cơ hội hủy bỏ, muốn hủy bỏ nhiệm vụ này?";
	end;
	Dialog:Say(szTalk,{
			{"Đúng vậy", tbNpc.DoCancel, tbNpc},
			{"Để ta suy nghĩ lại", tbNpc.LeaveNpc, tbNpc},
		});
end;


-- 取消確認
function tbNpc:DoCancel()
	local nResult = LinkTask:Cancel();
	
	if nResult==1 then
		Dialog:Say("Bạn thiếu nhẫn nại vậy sao? Hãy nghỉ ngơi lát rồi quay lại!");
		return;
	end;
	
	Dialog:Say("Ngươi đã hủy bỏ nhiệm vụ lần này!");
	
--	self:NextTask();
end;


function tbNpc:SendMessageToTeam()
	
end;

function tbNpc:OnExit()
	return;
end;

function tbNpc:LeaveNpc()
	return;
end;
