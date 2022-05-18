--�����᳡��Ա
--�����
--2008.09.12

local tbNpc = Npc:GetClass("wlls_guanyuan3");

function tbNpc:OnDialog()
	Player.tbOnlineExp:CloseOnlineExp();
	local nReturn, szMsgInFor = self:CreateMsg();
	local szMsg = string.format(szMsgInFor);
	local tbOpt = 
	{
		{"��Ҫ��ѯ�������", Wlls.DialogNpc.QueryMatch, Wlls.DialogNpc},
		{"�����Ի�"},
	};
	if (not GLOBAL_AGENT) then
		if Wlls:OnCheckAwardSingle(me) == 1 then
			szMsg = szMsg .. "\n\nÿ�λ��ʤ�������Ե���������ȡһ����������������ٸ��ֿ����ޣ�ֻ�ܱ������һ�ε�<color=yellow>�������<color>��Ϊ������ʧ�����λ���ͼ�ʱ����ȡ��";
			table.insert(tbOpt, 1, {"<color=yellow>��ȡ�������<color>", Wlls.OnGetAwardSingle, Wlls});
		end	
	end

	if nReturn == 1 then
		table.insert(tbOpt, 1, {"�μӱ���", self.AttendGame, self});
	end

	if (not GLOBAL_AGENT) then
		if Wlls:GetMacthState() == Wlls.DEF_STATE_ADVMATCH then
			table.insert(tbOpt, 2, {"<color=yellow>�ۿ���ǿ��ս��<color>", Wlls.OnLookDialog, Wlls});	
		end
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:AttendGame(nFlag)

	local tbMTCfg = Wlls:GetMacthTypeCfg(Wlls:GetMacthType());
	if (tbMTCfg) then
		local nSType = tbMTCfg.tbMacthCfg.nSeries;
		if (nSType and Wlls.LEAGUE_TYPE_SERIES_RESTRAINT == nSType) then
			local szLName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
			local tbLList	= Wlls:GetLeagueMemberList(szLName);
			local nSer=-1;
			if (tbLList) then
				for nId, szMName in ipairs(tbLList) do
					local nSeries	= League:GetMemberTask(Wlls.LGTYPE, szLName, szMName, Wlls.LGMTASK_SERIES);
					if (nSer == -1) then
						nSer = nSeries;
					else
						if (0 == Wlls:IsSeriesRestraint(nSer, nSeries)) then
							Dialog:Say("���鱨�������в���������У��뵽������Ա�������Ϊ������С�");
							return;
						end;
					end;
				end;
			end;
		end;	
	end	
	
	local nReturn, szMsgInFor = self:CreateMsg();
	if nReturn == 0 then
		Dialog:Say(szMsgInFor);
		return 0;
	end
	if not nFlag then
		for _, tbItem in pairs(Wlls.ForbidItem) do
			if #me.FindItemInBags(unpack(tbItem)) > 0 then
				local szMsg = "�᳡��Ա�������ϴ���<color=red>��ֹʹ�õ�ҩ��<color>������������޷�ʹ�ø���ҩ�䣬��ȷ��Ҫ����������";
				local tbOpt = 
				{
					{"ȷ����������", self.AttendGame, self, 1},
					{"�����Ի�"},
				};
				Dialog:Say(szMsg, tbOpt);
				return 0;	
			end
		end
	end
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	local nPlayerCount = Wlls:GetMacthTypeCfg(Wlls:GetMacthType()).tbMacthCfg.nPlayerCount;	
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ENTER) >= nPlayerCount and (not nFlag or nFlag == 1) then
		local szMsg = string.format("�᳡��Ա����������ֻ����<color=yellow>%s��<color>�μӱ��������ս������<color=yellow>%s��<color>��Ա������׼�������㽫<color=yellow>��Ϊ�油����׼����<color>�����������Ա�뿪׼�������㽫<color=yellow>�Զ�תΪ��ʽ������Ա<color>��", nPlayerCount, nPlayerCount)
		local tbOpt = 
		{
			{"���油��ݽ�������", self.AttendGame, self, 2},
			{"�����Ի�"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	if Wlls:GetMacthLevelCfgType() == Wlls.MAP_LINK_TYPE_SERIES then
		--δ����
		--�ж��Լ����ڵ����кͱ���ʱս�Ӽ�¼�е������Ƿ���������������������
		local nOrgSereis	= League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_SERIES);
		if (me.nSeries <= 0) then
			Dialog:Say("����������Ա���㻹û���κ����У��뾡��������ɣ����������μ�������");
			return 0;
		end
		if (nOrgSereis > 0 and nOrgSereis ~= me.nSeries) then
			local szOrgSereis = string.format(Wlls.SERIES_COLOR[nOrgSereis], Env.SERIES_NAME[nOrgSereis]);
			local szSereis = string.format(Wlls.SERIES_COLOR[me.nSeries], Env.SERIES_NAME[me.nSeries]);
			Dialog:Say(string.format("�᳡��Ա���㱨������<color=yellow>%s<color>ϵ���У�������ֻ����<color=yellow>%s<color>ϵ���вμӱ�����\n", szOrgSereis, szOrgSereis));
			return 0;			
		end
	end	
	
	if Wlls:GetMacthLevelCfgType() == Wlls.MAP_LINK_TYPE_FACTION then
		--δ����
		--�ж��Լ����ڵ����ɺͱ���ʱս�Ӽ�¼�е������Ƿ���������������������
		local nFaction	= League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_FACTION);
		if (nFaction ~= me.nFaction) then
			local szOrgFac	= Player:GetFactionRouteName(nFaction);
			local szNowFac	= Player:GetFactionRouteName(me.nFaction);
			local szMsg = string.format("�᳡��Ա���㱨������<color=yellow>%s<color>��������������ֻ����<color=yellow>%s<color>������ݲμӱ�����\n", szOrgFac, szOrgFac)
			Dialog:Say(szMsg);
			return 0;
		end
	end
	
	local nSeriesType = Wlls:GetMacthTypeCfg(Wlls:GetMacthType()).tbMacthCfg.nSeries;
	if (Wlls.LEAGUE_TYPE_SERIES_RESTRAINT == nSeriesType) then -- ���������
		local nSeries	= League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_SERIES);
		if (nSeries ~= me.nSeries) then
			local szOrg = Env.SERIES_NAME[nSeries];
			local szMsg = string.format("�᳡��Ա���㱨���������������������ʱ��������<color=yellow>%s<color>ϵ��������ֻ����<color=yellow>%s<color>ϵ���вμӱ�����\n", szOrg, szOrg);
			Dialog:Say(szMsg);
			return 0;
		end
	end
	
	local nGameLevel = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL);
	local nCaptain = League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_JOB);
	GCExcute{"Wlls:EnterReadyMap", me.nId, szLeagueName, nGameLevel, me.nMapId, {nFaction = me.nFaction, nSeries= me.nSeries, nCamp=me.GetCamp()}, nCaptain};
end

function tbNpc:CreateMsg()
	local nMacthType = Wlls:GetMacthType();
	local tbMacthCfg = Wlls:GetMacthTypeCfg(nMacthType);	
	if not tbMacthCfg then
		return 0, "�᳡��Ա�������������ܻ�δ������";
	end
	if Wlls:GetMacthState() == Wlls.DEF_STATE_REST then
		return 0, "�᳡��Ա�������Ǳ�����Ъ�ڣ�";
	end
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		return 0, "�᳡��Ա������û��ս�ӣ�";
	end
	
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION) ~= Wlls:GetMacthSession() then
		return 0, "�᳡��Ա������ս�Ӳ��Ǳ�������������ս�ӣ�������Ҫ��";
	end
	
	local nGameLevel = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL);
	local nTime = GetTime();
	--��ǿ��
	if Wlls:GetMacthState() == Wlls.DEF_STATE_ADVMATCH then
		if nGameLevel ~= Wlls.MACTH_ADV then
			return 0, "�᳡��Ա�������Ǹ߼����������ڣ����ս�Ӳ��Ǹ߼�����ս�ӣ�";
		end
		
		if Wlls.AdvMatchState == 0 then
			return 0, "�᳡��Ա�������Ǹ߼����������ڣ���һ����ǿ������<color=yellow>19:00<color>�����������ĵȴ���\n\n<color=yellow>������ڻ᳡�ڰ������鿴����<color>";			
		end
		
		if Wlls:IsAdvMacthLeague(szLeagueName) ~= 1 then
			return 0, "�᳡��Ա�������Ǳ����߼����������ڵ�ս�ӣ��޷��μӱ��������ڵı�����\n\n<color=yellow>������ڻ᳡�ڰ������鿴����<color>";
		end
		
		if Wlls.ReadyTimerId > 0 then
			local nRestTime = math.floor(Timer:GetRestTime(Wlls.ReadyTimerId)/Env.GAME_FPS);
			if nRestTime >= Wlls.MACTH_TIME_READY_LASTENTER/Env.GAME_FPS then
				return 1, string.format("�᳡��Ա���������ڱ����׶Σ��ȴ����ı�����\n\n�������ʼ��ʣ��<color=yellow>%s<color>���뾡�챨��������\n\n<color=yellow>������ڻ᳡�ڰ������鿴����<color>", Lib:TimeFullDesc(nRestTime));
			end
		end
		
		local nHourMin = tonumber(os.date("%H%M", nTime));
		if nHourMin > Wlls.CALEMDAR.tbAdvMatch[#Wlls.CALEMDAR.tbAdvMatch] then
			return 0, "�᳡��Ա���������������Ѿ�����������";
		end
		for nId, nMatchTime in pairs(Wlls.CALEMDAR.tbAdvMatch) do
			if nHourMin < nMatchTime then
				return 0, string.format("�᳡��Ա���³��Ǹ߼�����������\n\n����������<color=yellow>%sǿ��<color>\n\n��������<color=yellow>%s<color>��ʼ��\n\n<color=yellow>������ڻ᳡�ڰ������鿴����<color>", Wlls.MACTH_STATE_ADV_TASK[nId], Wlls.Fun:Number2Time(nMatchTime));				
			end
		end
		return 0, "�᳡��Ա�����Եȣ��������Ͼ�Ҫ��ʼ��\n\n<color=yellow>������ڻ᳡�ڰ������鿴����<color>";
	end
	
	
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL) >= Wlls.MACTH_ATTEND_MAX then
		return 0, string.format("�᳡��Ա������ս���Ѳμ���<color=yellow>%s��<color>����������б�������ȴ����������", Wlls.MACTH_ATTEND_MAX);
	end
	
	if Wlls.ReadyTimerId > 0 then
		local nRestTime = math.floor(Timer:GetRestTime(Wlls.ReadyTimerId)/Env.GAME_FPS);
		if nRestTime >= Wlls.MACTH_TIME_READY_LASTENTER/Env.GAME_FPS then
			return 1, string.format("�᳡��Ա���������ڱ����׶Σ��ȴ����ı�����\n\n�������ʼ��ʣ��<color=yellow>%s<color>���뾡�챨��������", Lib:TimeFullDesc(nRestTime));
		end
	end
	
	local nWeek = tonumber(os.date("%w", nTime));
	local nHourMin = tonumber(os.date("%H%M", nTime));
	local nDay = tonumber(os.date("%d", nTime));
	local tbCalemdar = Wlls.CALEMDAR.tbCommon;
	
	if Wlls.CALEMDAR.tbWeekDay[nWeek] then
		tbCalemdar = Wlls.CALEMDAR.tbWeekend;
	end
	
	local szGameStart = "�᳡��Ա��";
	for nReadyId, tbMission in pairs(Wlls.MissionList[Wlls.MACTH_PRIM]) do
		if tbMission:IsOpen() ~= 0 then
			szGameStart = szGameStart .. "�����Ѿ���ʼ�ˣ�\n\n";
			break;
		end
	end
	
	if Wlls:GetMatchEndForDate(nDay) == 1 and nHourMin > tbCalemdar[#tbCalemdar] then
		return 0, string.format("%s��������ѭ����������ȫ�������꣬�߼�������������ǿ���ڣ�", szGameStart);
	end
	
	if nHourMin > tbCalemdar[#tbCalemdar] then
		return 0, string.format("%s���������������ȫ������������������������", szGameStart);
	end	
	if nHourMin < tbCalemdar[1] then
		return 0, string.format("%s�³�������ʱ��Ϊ<color=yellow>%s<color>��", szGameStart, Wlls.Fun:Number2Time(tbCalemdar[1]));
	end
	for nId, nMatchTime in ipairs(tbCalemdar) do
		if nHourMin > nMatchTime and tbCalemdar[nId+1] and nHourMin <= tbCalemdar[nId+1] then
			return 0, string.format("%s�³�������ʱ��Ϊ<color=yellow>%s<color>��", szGameStart, Wlls.Fun:Number2Time(tbCalemdar[nId+1]));
		end
	end
	return 0, "�᳡��Ա�����Եȣ��������Ͼ�Ҫ��ʼ��";
end

