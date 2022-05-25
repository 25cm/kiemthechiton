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
			Dialog:Say("���Ѿ����������ժ�������ˡ�");
		else
			local nDelta = SpecialEvent.ZhiShu2009.BIG_TREE_LIFE - (GetTime() - him.GetTempTable("Npc").tbPlantTree09.nBirthday);
			local szMsg = string.format("��������ȥ������Ѿ������ˣ������˹�ʵ���ƺ�����ժȡ�ˣ������������ٹ�%sҲ��Ҫ��ȥ�ˡ�", Lib:TimeDesc(nDelta));
			local tbOpt = {
				{"ժȡ��ʵ", self.GatherSeed, self, me, him.dwId},
				{"�ٵȵȿ�"}
			};
			Dialog:Say(szMsg, tbOpt);
		end
	end
end

function tbTree:GatherSeed(pPlayer, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		Dialog:Say("�ܿ�ϧ��������Ѿ������ˡ�");
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
	Dialog:OpenGift("����뱥�������֡�", nil, {self.CallBack, self});
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
	[1] = "��ڼ䣬60�����ϵ���ҿɵõ�һ����ˮ������������ˮʱʹ�á��˺��ɽ�ˮ10�Σ���������ʱ��ľ����װ��ˮ��",
	[2] = "�������º�����Ҫ���϶��佽ˮ����1���ӻ�û��ˮ�����־ͻ���������Ҫ������һ����ÿ�ν�ˮ�󣬹�1������ſ����ٴν�ˮ������2����û��ˮ����Ҳ�����������ע�⡣�ڽ�ˮ5�κ�ֲ���ɹ�����ῴ�����ô�һ��������2���Ӻ��ܴ�����ժȡ�����������֡�����������1Сʱ�����ʧ��",
	[3] = "��ľ�ɳ������У������Ķ��Ѷ��ܻ�þ��齱������Ա����Խ�ྭ��Խ�ߡ��ڶ���ľ��ˮʱҲ�п��ܻ�������������󽫡����������֡��������ִ工ľС���ϰ�ľ�����Ի�÷������",
	}
	
function tbIntro:OnDialog(nIdx)
	if nIdx then
		local tbOpt = {{"�������ˡ�", self.OnDialog, self}};	
		Dialog:Say(self.tbIntroMsg[nIdx], tbOpt);
		return;
	end
	
	local szMsg = "ֲ���ڻ��ʼ�ˣ���Ҫ�˽�ʲô�أ�";
	local tbOpt = {
		{"������ȡ��ˮ��", self.OnDialog, self, 1},
        {"������������",self.OnDialog, self, 2},
        {"��ʲô����",self.OnDialog, self, 3},
        {"���˽���"}
		};
		
	Dialog:Say(szMsg, tbOpt);
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_zhishujie\\tree_npc.lua")