--����npc
--sunduoliang
--2008.12.29
TowerDefence.tbNpc = TowerDefence.tbNpc or {};
local tbNpc = TowerDefence.tbNpc;

function tbNpc:OnDialog()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate < TowerDefence.SNOWFIGHT_STATE[1] then
		Dialog:Say("���û�п�ʼ��", {{"֪����"}});
		return 0;
	end	
	if TowerDefence:IsSignUpByAward(me) == 1 then
		Dialog:Say("���ϴ�Ӯ�ˣ���������Ҫ�͸��㡣", {{"��ȡ����", self.GetAward, self}});
		return 0;
	end
	
	local nCountSum, nCount, nCountEx = TowerDefence:IsSignUpByTask(me);
	local szMsg = string.format("һ���ɽ��˲��ݵĻ�е���޾���������Χ��֮�ƽӽ������ͼ��������֮������������������в����֮�꣬��Ҫ���뿹����������\n\n<color=yellow>�����ʣ�������%s��<color>\n<color=yellow>��ʣ����������%s��<color>", nCount, nCountEx);
	local tbOpt = {
		{"�������뿹��������", TowerDefence.OnDialog_SignUp, TowerDefence},
		{"��ȡ����", self.GetAward, self},
		{"��ȡ���ջ����", self.GetFinishAward, self},
		--{"��ȡ�����������", self.GetExCount, self},
		{"���а��ѯ", self.OnOpenRank, self},
		{"�˽��ػ�����֮��", self.OnAbout, self},
		--{"�˽�����", self.OnAboutNewYears, self},
		{"��㿴��"},
	};	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetFinishAward()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	local nCurDateEx = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate <= TowerDefence.SNOWFIGHT_STATE[2] *10000 + 0400 then				--9��3�����а�ˢ��֮�󣬲��ܿ�ʼ�콱
		Dialog:Say("���û�н��������ǵȻ������������ȡ�ɣ�");
		return 0;
	end
	if nCurDateEx >= TowerDefence.SNOWFIGHT_STATE[2] + 7 then
		Dialog:Say("���Ч�Ѿ����ˣ���������ȡ�����ˣ�");
		return 0;
	end
	if me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_AWARD_FINISH) > 0 then
		Dialog:Say("������ȡ�������ˣ�����̫̰��Ŷ��");
		return 0;
	end
	local nCountSum = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_TOTAL);
	local nRank		= GetPlayerHonorRankByName(me.szName, PlayerHonor.HONOR_CLASS_DRAGONBOAT, 0);	

	local nRankType = 0;
	local szRank = string.format("����Ϊ<color=yellow>��%s��<color>", nRank);
	if nRank <= 0 then
		szRank = "������";
	end
	if nRank > 0 then
		for nType, tbType in ipairs(TowerDefence.AWARD_FINISH) do
			if nRank <= tbType[1] then
				nRankType = nType;
				break;
			end
		end
	end	
	if nRankType == 0 then
		Dialog:Say("�㲻�����������");
		return 0;
	end
	local tbAward = TowerDefence.AWARD_FINISH[nRankType][2];
	if nRankType > 1 then	
		if me.CountFreeBagCell() < 1 then
			Dialog:Say("��ı����ռ䲻�㣬��Ҫ1�񱳰��ռ�");
			return 0;
		end
		local szAwardName = "";
		local pItem = me.AddItem(unpack(tbAward));
		if pItem then
			me.SetItemTimeout(pItem, 30*24*60, 0);
			pItem.Sync();
			szAwardName = pItem.szName;
			me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_AWARD_FINISH, 1);
		end		
		Dialog:Say(string.format("��μ��ػ�����֮�꣬%s�����ɹ��μ�%s���������1��%s��", szRank, nCountSum, szAwardName));
		EventManager:WriteLog("[�����ڻ]�������������1��"..szAwardName, me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�����ڻ]�������������1��"..szAwardName);
	else
		if me.CountFreeBagCell() < 2 then
			Dialog:Say("��ı����ռ䲻�㣬��Ҫ2�񱳰��ռ�");
			return 0;
		end
		me.AddStackItem(tbAward[1], tbAward[2], tbAward[3], tbAward[4], nil, 10000);
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_AWARD_FINISH, 1);
		Dialog:Say(string.format("��μ��ػ�����֮�꣬%s�����ɹ��μ�%s���������10000�������űҡ�", szRank, nCountSum));
		EventManager:WriteLog("[�����ڻ]�������������10000�������ű�", me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�����ڻ]�������������10000�������ű�");
	end
end


function tbNpc:GetAward()
	if TowerDefence:IsSignUpByAward(me) <= 0 then
		Dialog:Say("��Ҫ��������Ҫ�Ļ���Ҫ���������ػ�����֮�������Ŷ��", {{"�һ�ȥ�μӵ�"}});		
		return 0;
	end
	if TowerDefence:IsSignUpByAward(me) >= 5 then
		Dialog:Say("�ϴε����ﲻ���Ѿ�������ô�����ң����˵Ķ�����û�������Ŷ��", {{"�����������ˣ��Բ���"}});
		return 0;
	end
	if me.CountFreeBagCell() < 1 then
		me.Msg("�������ռ䲻�㣬������1�񱳰��ռ䡣");
		return 0;
	end
	
	local pItem = me.AddItem(unpack(TowerDefence.WINNER_BOX[me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_AWARD)]));
	if pItem then
		pItem.Bind(1);
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_AWARD, 5);
		TowerDefence:WriteLog("�õ���Ʒ"..pItem.szName, me.nId);
		EventManager:WriteLog("[�����ڻ]���"..pItem.szName, me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�����ڻ]���"..pItem.szName);
	end
	Dialog:Say("�����������������Ϊ������������Ľ�����", {{"лл", self.OnDialog, self}});
	return 0;
end

function tbNpc:OnOpenRank()
	local nTotal = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_TOTAL);
	local nWin 	 = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_WIN);
	local nTie 	 = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_TIE);
	local nLost  = nTotal - nWin - nTie;
	local szRate  = "��ʤ��";
	if nTotal > 0 then
		szRate = string.format("%.2f", (nWin/nTotal)*100) .. "��";
	end
	local szMsg = string.format([[���԰�����������а����ڽ�������ġ��������а��µġ�����С��в�ѯ��������Ϣ����Ҫ�Ұ�������а���
	<color=green>
	---������Ϣ---
	
	�ܳ�����%s
	ʤ������%s
	ƽ������%s
	��������%s
	ʤ��ֵ��%s
	<color>
	]], nTotal, nWin, nTie, nLost, szRate);
	local tbOpt = {
		{"���Ҵ����а��", self.OnOpenRankList, self},
		{"���Լ�ȥ����"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnOpenRankList()
	me.CallClientScript({"UiManager:OpenWindow", "UI_LADDER"});
end

function tbNpc:GetExCount()
	Dialog:OpenGift("������������ÿ�����������3�����һ�������", {"TowerDefence:CheckGiftSwith"}, {self.OnOpenGiftOk, self});
end

function tbNpc:OnOpenGiftOk(tbItemObj)
	local nSum = 0;
	local szItemParam = string.format("%s,%s,%s,%s",unpack(TowerDefence.SNOWFIGHT_ITEM_EXCOUNT));
	for _, tbItem in pairs(tbItemObj) do
		local szPutParam = string.format("%s,%s,%s,%s",tbItem[1].nGenre,tbItem[1].nDetail,tbItem[1].nParticular,tbItem[1].nLevel);
		if szPutParam ~= szItemParam then
			me.Msg("��ֻ��Ҫ����������벻Ҫ����������Ʒ��");
			return 0;
		end
		nSum = nSum + 1;
	end
	local nCurDay = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDay = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_DAY);
	if nTaskDay < nCurDay then
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_DAY, nCurDay);
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT, 0);
	end 
	
	local nTaskCount = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT);
	if nTaskCount >= 3 then
		me.Msg("ÿ��ֻ��ʹ��<color=yellow>3���������<color>��ȡ3�ζ�����ᣬ����컻ȡ�Ļ���<color=yellow>�Ѵ�3��<color>��")
		return 0;
	end
	if nTaskCount + nSum > 3 then
		me.Msg(string.format("ÿ��ֻ��ʹ��<color=yellow>3���������<color>��ȡ3�ζ�����ᣬ�㻹<color=yellow>ʣ��%s��<color>��ȡ�Ķ������,ֻ�����<color=yellow>%s��������<color>��", (3 - nTaskCount), (3 - nTaskCount)));
		return 0;
	end
	
	local nDelCount = 0;
	for _, tbItem in pairs(tbItemObj) do
		if me.DelItem(tbItem[1]) ~= 1 then
			Dbg:WriteLog("TowerDefence", me.szName.."ѩ�̸���������", "ɾ��ʧ��")
		else
			nDelCount = nDelCount + 1;
		end
	end
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT, nTaskCount + nDelCount);
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_EXCOUNT, me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_EXCOUNT) + nDelCount);
	me.Msg(string.format("�������<color=yellow>%s��<color>��������ʸ�", nDelCount));
end


tbNpc.tbAboutNewYears = {
[1] = [[
    ��ڼ䣬ÿ������10�㵽��ҹ1�㣬50�����ϼ������ɵ���� ���Ե������ִ������ѩ������������½��д�ѩ�̵Ļ��
ÿ��ÿ�����ֻ��2�λ��ᣬ���ۼ�14�Σ�������˵������ѩ�ǳ�ϲ�����������������ܻ�ø��˵�������ͻ�������ȥ��ص㡣
    �������棬���������󣬲μ������ſ����л����ú��������
    �����ȥѯ�ʸ����ִ������ѩ����򿪰������ң�F12���鿴��
]],

[2] = [[
    ��ڼ䣬ÿ������8�㵽9�㣬ÿ6���ӣ���ٻ�ȥ�������ɰ��꣬3���Ӻ��뿪�����Ե�ϵͳ��ʾ����ʱҪ����ǰ���� 
    ��ٻ����㡰�����̻��������������������࣬��زμ�Ϊ�ǡ������̻���Ҫ�ڸ���������ִ���ٸ����ġ��̻�ȼ�Ŵ���ʹ�ò���Ч���� 
    �����ȥ����������ִ�ѯ����ٻ�򿪰������ң�F12���鿴��
]],
[3] = [[
    ���������ǻ�ڼ��ÿ��С������ÿ�춼����ȥ���ִ�����մ���ȡ���ڳɹ���ɺ��ܻ�þ��飬���ص��ߵȽ�����һ����Ҫ���Ŷ��
    ]],
[4] = [[
    ���á�����������Ұ���ճ����ޣ����С��Ϲ����������壬���ܶ��������Ч�˺���ʹ�á����䱬�񡱣����ڶ�ʱ�������令������������ǿ��������Ҫ�ͼ������һ��ȥ�շ�������Ч������С�ģ���
    ��ڼ�ÿ����Ҷ�����Ѵ�����̫ү���õ����ߡ����䱬�񡱣���Ҫ���ȡ�Ļ���Ҫ���μ������ˡ�
    �����ȥ���ִ�ѯ������̫ү��򿪰������ң�F12���鿴��
]],
};

function tbNpc:OnAboutNewYears(nSel)
	if nSel then
		Dialog:Say(self.tbAboutNewYears[nSel], {{"�����ϲ�", self.OnAboutNewYears, self}});
		return 0;
	end
	local szMsg = "�������֮�࣬��֪��Ҫ�˽���һ����"; 
	local tbOpt = {
		{"��ѩ��", 		self.OnAboutNewYears, self, 1},
		{"��ٰ��꣬�̻�����", self.OnAboutNewYears, self, 2},
		{"��������", 	self.OnAboutNewYears, self, 3},
		{"��������", 	self.OnAboutNewYears, self, 4},
		{"��֪����"},
	};
	Dialog:Say(szMsg, tbOpt);
end


tbNpc.tbAbout = {
[1] = [[
  <color=yellow>  2010��3��30�ո��º󡪡�4��10��<color>
ÿ��<color=yellow>10��-23�㣬��Сʱһ��<color>�����б���ʱ��<color=yellow>4<color>���Ӱ룻

�磺10������ʼ������10��05������һ����10��25������
22��30���һ�α�����22��35�������һ����23����������
 
]],

[2] = [[
	1���ȼ��ﵽ<color=yellow>60������������<color>����Ҿ��ɲμӣ�
	2��ÿ����<color=yellow>2<color>�βμӻ��ᣬÿ�ܿ��ۻ�<color=yellow>14<color>�Σ�
	ֻҪ�������������������Ϳ��Ե��˻������ӱ����μ��ˣ�

]],
[3] = [[
<color=green>���淨��顿<color>
	������Ϯ�����������޲ߣ�ֻ�н���ֲ���ǵ������������������ǣ�
	<color=yellow>���������໥��������취�ں��ʵĵص���ֲ���ʵ�ֲ����÷������£���ֹ����ͨ��<color>����������֮�꣡
<color=green>����ϸ�淨��<color>
	  1�����ǵ��˱������ᷢ�ִ�ұ����һ��������̬���ڵ��Ͽ��Լ�<color=yellow>��ѣ�Ρ�<color>�ȼ��ܣ�<color=yellow>ֻ����Щ���ܿ����赲��Ϯ�ĵ���<color>��
	  2��ͨ�����<color=yellow>�Զ�����<color>�ɻ�þ��ã�ƾ���ڳ����ڵ�<color=yellow>�嶾��������<color>������ֲ�
	  3�����ض�����<color=yellow>��ֲ<color>ֲ�<color=yellow>ÿ��ֻ����ֲһ��<color>��ֲ�����������
	  4������һ����һ������ʱ������<color=yellow>BOSS<color>���֣�����һ��Ҫ��֯�����<color=yellow>ֲ��ս�ӵ�����<color>����ֲ��ﵽ��һ���ȼ���Ѫ��ʱ���Զ�<color=yellow>����ֲ��<color>��

]],
[4] = [[
    1.��Ȼ�㱨���˵�����������������ܻ��ֿգ�û��ϵ������׼�����ٱ����ɡ�
    
    2.���������󣬴�����Զ�һ���ģ��ͽ�ɫ�ļ��ܵȶ�û���κι�ϵ��Ŷ��
    
    3.ȥ�̵깺��Ģ������������ɱ��������ļ��ܶ����Ƕ�����Ч��Ŷ��
]],
[5] = [[
<color=green>��ʤ���ж���<color>
	1��ͨ��<color=yellow>�������<color>���Ʒ֣����Ƕ��˱������ᰴ�ն�������ĵ������Ʒ֡�
	2���ܵ÷ָߵ�һ����ʤ��
<color=green>���������<color>
	1������������һ�����ʵ���<color=yellow>����<color>��BOSS�����ܻ����߼�������
	2��ʤ�����ڸ������ִ�����ѩ����ȡ���������ܻῪ��<color=yellow>�߼�����<color>��
	3���μӻ���ɻ��һ���������㣬�����ڻȫ�������󣬿���<color=yellow>ͨ���ۻ��������������˵Ľ���<color>��

]]
};

function tbNpc:OnAbout(nSel)
	if nSel then
		Dialog:Say(self.tbAbout[nSel], {{"�����ϲ�", self.OnDialog, self}});
		return 0;
	end
	local szMsg = "����ʱ����׷ף�\n·���������ϻꡣ\n���������»��\nֲ���ս���Ծ���\n�����˽��ػ�����֮������Щ��Ϣ�أ�"; 
	local tbOpt = {
		{"�ʱ�����"	, self.OnAbout, self, 1},
		{"�μ�����"		, self.OnAbout, self, 2},
		{"������ǰ�������Ĺ���"	, self.OnAbout, self, 3},
		{"ʤ���뽱��", self.OnAbout,self, 5},
		{"ע������"		, self.OnAbout, self, 4},
		{"��֪����"		, self.OnDialog, self},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnAboutYanHua()
	local szMsg = [[
	  ��ڼ䣬ÿ������8�㵽9�㣬ÿ6���ӣ���ٻ�ȥ�������ɰ��꣬3���Ӻ��뿪�����Ե�ϵͳ��ʾҪ����ǰ����
    ��ٻ����㡰�����̻��������������������࣬��زμ�Ϊ�ǡ������̻���Ҫ�ڸ���������ִ���ٸ����ġ��̻�ȼ�Ŵ���ʹ�ò���Ч���� 
    �����ȥ����������ִ�ѯ����ٻ�򿪰������ң�F12���鿴��
]];
	Dialog:Say(szMsg);
end

function tbNpc:OnAboutNianShou()
	local szMsg = [[
	���á���������Ұ���ճ����������������ɣ��������ܶ�������κ����ˣ������С��Ϲ����������壬����ȼ�Ҹ���ġ����䱬�񡱣����ʹ���ڶ�ʱ���ڻ����������ѣ����������¾ۼ������Ŀ�϶�Ϳɶ���������������
����ǿ��������Ҫ�ͼ������һ��ȥ�շ�������Ч������С�ģ���
]];
	Dialog:Say(szMsg);
end


------------------------