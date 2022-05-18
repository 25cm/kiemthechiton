--����׼������Ա
--�����
--2008.09.12

local tbNpc = Npc:GetClass("wlls_guanyuan4");

function tbNpc:OnDialog()
	local szMsg = "׼������Ա������������ʼ,��ȷ��Ҫ�뿪׼������";
	local tbOpt = 
	{
		{"��Ҫ�뿪", self.LevelGame, self},
		{"�����Ի�"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:LevelGame(nFlag)
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		Dialog:Say("����û��ս�ӣ�");
		return 0;
	end
	
	local nInReadyMap = 0;
	for _,nReadyMapId in pairs(Wlls.MACTH_TO_MAP) do
		if nReadyMapId == me.nMapId then
			nInReadyMap = 1;
			break;
		end
	end
	
	if nInReadyMap == 0 then
		return 0;
	end
	if not nFlag then
		local tbOpt = {
			{"��ȷ��Ҫ�뿪", self.LevelGame, self, 1},
			{"���ٿ��ǿ���"},
		}
		Dialog:Say("׼������Ա���������뿪������<color=red>�޷��μӱ��ֱ���<color>,��ȷ��Ҫ�뿪׼������?", tbOpt);
		return 0;
	end
	--local nEnterReadyId = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ATTEND);
	local nGameLevel = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL);
	Wlls:KickPlayer(me, "���뿪��׼����", nGameLevel);
end
