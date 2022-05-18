-- 09ֲ���� ��

local tbTree = Npc:GetClass("tree_arbor_day_09");

function tbTree:OnDialog()
	if me.nId ~= SpecialEvent.ZhiShu2009:GetOwnerId(him) then
		return;
	end
	
	if SpecialEvent.ZhiShu2009:IsBigTree(him) == 0 then
		local nRes, szMsg = SpecialEvent.ZhiShu2009:CanIrrigate(me, him);
		
		if nRes == 1 then
			SpecialEvent.ZhiShu2009:IrrigateBegin(me, him);
		elseif szMsg then
			Dialog:Say(szMsg);
		end
	else
		if SpecialEvent.ZhiShu2009:HasSeed(him) == 0 then
			Dialog:Say("Bạn đã múc chào từ nồi rồi");
		else
			local nDelta = SpecialEvent.ZhiShu2009.BIG_TREE_LIFE - (GetTime() - him.GetTempTable("Npc").tbPlantTree09.nBirthday);
			local szMsg = string.format("Dường như %s giây nữa nó sẽ khê.", Lib:TimeDesc(nDelta));
			local tbOpt = {
				{"Múc Cháo", self.GatherSeed, self, me, him.dwId},
				{"Đợi một lúc"}
			};
			Dialog:Say(szMsg, tbOpt);
		end
	end
end

function tbTree:GatherSeed(pPlayer, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		Dialog:Say("Thật không may, nồi cháo của bạn đã bị khê.");
		return;
	end
	
	local res, szMsg = SpecialEvent.ZhiShu2009:CanGatherSeed(pPlayer, pNpc) 
	if res == 1 then
		local szMsg = SpecialEvent.ZhiShu2009:GatherSeed(pPlayer, pNpc);
		Dialog:Say(szMsg);
	elseif szMsg then
		Dialog:Say(szMsg);
	end
end

local tbGetSeed = EventManager:GetClass("event_arbor_day_09_get_seed");
function tbGetSeed:OnDialog()
	local nRes, szMsg = SpecialEvent.ZhiShu2009:CanGiveSeed(me);
	if nRes == 1 then
		SpecialEvent.ZhiShu2009:GiveSeed(me);
		SpecialEvent.ZhiShu2009:FillJug(me, 1);
	elseif szMsg then
		Dialog:Say(szMsg);
	end
end

local tbFillJug = EventManager:GetClass("event_arbor_day_09_fill_jug");
function tbFillJug:OnDialog()
	local nRes, szMsg = SpecialEvent.ZhiShu2009:FillJug(me);
	if nRes == 0 and szMsg then
		Dialog:Say(szMsg);
	end
end

local tbHandupSeed = EventManager:GetClass("event_arbor_day_09_handup_seed");
function tbHandupSeed:OnDialog()
	Dialog:OpenGift("Vui lòng đặt Bát Cháo vào.", nil, {self.CallBack, self});
end

function tbHandupSeed:CallBack(tbItem)
	local nRes, szMsg = SpecialEvent.ZhiShu2009:HandupSeed(me, tbItem);
	if nRes == 1 then
		return;
	elseif szMsg then
		Dialog:Say(szMsg);
	end
end

local tbIntro = EventManager:GetClass("event_arbor_day_09_intro");
tbIntro.tbIntroMsg = {
	[1] = "Để tham hoạt động này, Người chơi đẳng cấp 120 có thể nhận <color=yellow>Túi Củi<color> khi nấu cháo. Mỗi <color=yellow>Túi Củi<color> có thể dùng được 10 lần. Bạn có thể đến gặp <color=yellow>Mộc Lương<color> - Chủ tiệm Gỗ để lấy thêm Củi.",
	[2] = "Bạn cần phải cho củi vào ngay lập tức, nếu không cho củi vào, nồi cháo sẽ không chín được, bạn cần phải nấu lại. Sau mỗi lần nhóm củi, hơn 1 phút trước khi nhóm củi lại, hơn hai phút không nhóm củi cho bếp nồi cháo bị khê, hãy chắc chắn phải chú ý đến. Trong nhóm củi 5 lần, nấu cháo, bạn sẽ thấy Bếp Lửa ngày càng cháy to hơn cho tới khi cháo chín, 2 phút từ đầu để loại bỏ các đầy đủ. Nồi Cháo tồn tại sau 01 giờ.",
	[3] = "Khi nấu cháo, bạn và tổ đội đứng gần đều nhận được kinh nghiệm. Khi nấu cháo thành công, sẽ nhận được một Bát Cháo. Đến Mộc Lương đưa cho a ta, a ta sẽ giúp bạn chuyển đến cho người nghèo",
	}
	
function tbIntro:OnDialog(nIdx)
	if nIdx then
		local tbOpt = {{"Ta hiểu rồi", self.OnDialog, self}};	
		Dialog:Say(self.tbIntroMsg[nIdx], tbOpt);
		return;
	end
	
	local szMsg = "Hoạt động <color=yellow>Đầm Ấm Tình Thương<color>: Bạn muốn biết những gì?";
	local tbOpt = {
		{"Nhóm Củi", self.OnDialog, self, 1},
        {"Quá trình Nấu Cháo",self.OnDialog, self, 2},
        {"Phần thưởng",self.OnDialog, self, 3},
        {"Ta hiểu rồi"}
		};
		
	Dialog:Say(szMsg, tbOpt);
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_zhishujie\\tree_npc.lua")