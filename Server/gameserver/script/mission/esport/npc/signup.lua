--����npc
--sunduoliang
--2008.12.29

local tbNpc = Npc:GetClass("esport_yanruoxue");

tbNpc.tbFollowInsertItem 	= {18, 1, 477, 1};
tbNpc.tbTypeName = {"Tr�� ch?i n��m b��ng tuy?t", "?ua thuy?n r?ng", "Ng??i b?o v? linh h?n c?a t? ti��n"}


tbNpc.tbChangeItemList = {
	[1] = {
		szContext = "?�� b��ng 1 th��ng ?? ??i l?y m?t ??i g?ng tay ?m ��p",
		tbGiftParam = {
			tbAward = { {nGenre=18, nDetail=1, nParticular=477, nLevel=1,nCount=1,},},
			tbMareial = { { nGenre = 18, nDetail = 1, nParticular = 476,nLevel = 1, nCount = 1,},},
		},
	},
	[2] = {
		szContext = "5 th��ng ?�� b��ng ?? ??i l?y m?t ??i g?ng tay ?m �� Yuxue",
		tbGiftParam = {
			tbAward = { {nGenre=18, nDetail=1, nParticular=478, nLevel=1,nCount=1,},},
			tbMareial = { { nGenre = 18, nDetail = 1, nParticular = 476,nLevel = 1, nCount = 5,},},
		},
	},
};
function tbNpc:OnDialog()
	local szMsg = string.format("Th? thao gia ?��nh v�� c��c ho?t ??ng h��ng ng��y");

	local tbOpt = {
		{"Th? thao gia ?��nh", self.OnDialogEx, self},
		{"<color=yellow>Ching Ming-B?o v? linh h?n c?a t? ti��n<color>", TowerDefence.tbNpc.OnDialog, TowerDefence.tbNpc},
		{"K?t th��c"},
	};	
	Dialog:Say(szMsg, tbOpt);	
end

function tbNpc:OnDialogEx()
	local nState = EPlatForm:GetMacthState();
	local nFlag = 0;
	local tbOpt = {{"T?i s? xem qua m?t ch��t"},};
	if (nState == EPlatForm.DEF_STATE_REST) then
		nFlag =1;
		tbOpt = {
			{"Nh?n ph?n th??ng s? ki?n cu?i c��ng", EPlatForm.GetPlayerAward_Final, EPlatForm},
			{"Nh?n ph?n th??ng cho gia ?��nh", EPlatForm.GetKinAward, EPlatForm},
			{"K?t th��c"},	
		};
	end
	if nFlag == 1 then
		Dialog:Say("���������ģ����������ң�СŮ�Ӹм���������ϧ���ڲ��Ǳ����ļ��ڣ������ʱ�������ɣ�", tbOpt);
		return 0;
	end
	
	if EPlatForm:IsSignUpByAward(me) > 0 then
		Dialog:Say("���ϴα����Ľ�����û���أ��Ͽ���ɡ��콱��", 
			{
				{"�ã��찡", EPlatForm.GetPlayerAward_Single, EPlatForm},
				{"���ڿ��ǿ���"},
			}
		);
		return 0;
	end
	
	if (nState == EPlatForm.DEF_STATE_CLOSE) then
		Dialog:Say("���徺��ƽ̨��δ���������Щ�������ɣ�");
		return 0;
	end
	
	EPlatForm:UpdateEventCount(me);
	local nCount = EPlatForm:GetEventCount(me);
	local nTotalCount = EPlatForm:GetPlayerTotalCount(me);
	local szStateName = EPlatForm.DEF_STATE_MSG[nState];
	local nTypeEx = EPlatForm:GetMacthType(EPlatForm:GetMacthSession());
	local szMsg = string.format("�ٺ٣����µļ��徺�����<color=yellow>%s<color>��Ŀǰ�����Ѿ�����<color=yellow>%s<color>������μӱ�����\n\n", self.tbTypeName[nTypeEx], szStateName);
	if (nState == EPlatForm.DEF_STATE_MATCH_1 or nState == EPlatForm.DEF_STATE_MATCH_2) then
		szMsg = string.format("%s<color=yellow>�����ʣ�������%s��\n", szMsg, nCount);
		if (nState == EPlatForm.DEF_STATE_MATCH_1) then
			szMsg = string.format("%s���׶��Ѿ��μӵ��ܳ�����%d��", szMsg, nTotalCount);
		end
	end
	local tbOpt = {
		{"�μӼ��徺��", EPlatForm.tbNpc.OnDialog, EPlatForm.tbNpc},
		{"��Ҫ��ѯ�������", EPlatForm.tbNpc.QueryMatch, EPlatForm.tbNpc},
		{"��ȡ���ջ����", EPlatForm.GetPlayerAward_Final, EPlatForm},
		{"��ȡ���影��", EPlatForm.GetKinAward, EPlatForm},
		{"��Ӱ֮ʯ�̵�", self.ChangeItem, self},
		{"�˽���徺���", self.OnAboutEx, self, nTypeEx},
		{"��㿴��"},
	};
	if nTypeEx == 2 then
		table.insert(tbOpt, 6,{"���۸���", Npc:GetClass("dragonboat_signup").ProductBoat,	Npc:GetClass("dragonboat_signup")});
	end
	if nTypeEx == 3 then
		table.insert(tbOpt, 6, {"����ӻ�������", TowerDefence.Npc_ProductTD, TowerDefence});
	end
	Dialog:Say(szMsg, tbOpt);
end

-- ������Ʒ
function tbNpc:ChangeItem(nLevel)
	
	me.OpenShop(166,3);
	do return end;
	
	if (EPlatForm:GetMacthType(EPlatForm:GetMacthSession()) ~= 1) then
		Dialog:Say("���û�п��ţ����ܶһ����ߡ�");
		return;
	end
	
	if (not nLevel) then
		Dialog:Say("1����Ӱ֮ʯ��ȡһ˫ůů�����ף�5����Ӱ֮ʯ��ȡһ˫ůů�����ס���ѩ����Ӱ֮ʯ����ȥ�ӻ�������Ӱԭʯ��������ܼӹ������õ�����Ҫ�һ����ֵ��ߣ�",
			{
				{"ůů������", self.ChangeItem, self, 1},
				{"ůů�����ס���ѩ", self.ChangeItem, self, 2},
				{"��������"},	
			}
		);
		return 0;
	end
	local tbParam = self.tbChangeItemList[nLevel];
	
	if (not tbParam or not tbParam.tbGiftParam) then
		return 0;
	end
	
	Dialog:OpenGift(tbParam.szContext, tbParam.tbGiftParam);
end

function tbNpc:GetAward()
	if EPlatForm:IsSignUpByAward(me) <= 0 then
		Dialog:Say("��Ҫ��ѩ����������Ҫ�Ļ���Ҫ�����μӴ�ѩ��Ŷ��", {{"�һ�ȥ�μӵ�", self.OnDialog, self}});		
		return 0;
	end

	if (0 == EPlatForm:GetPlayerAward(me)) then
		return 0;
	end
	Dialog:Say("�����������������ܽ�����ѩ�������ѩ�ÿ��ģ��ǵ�������Ŷ��", {{"лл��ѩ���", self.OnDialog, self}});
	return 0;
end

function tbNpc:OnOpenRank()
	local nTotal = EPlatForm:GetPlayerTotalMatch(me);
	local nWin 	 = EPlatForm:GetPlayerWinMatch(me);
	local nTie 	 = EPlatForm:GetPlayerLoseMatch(me);
	local nLost  = nTotal - nWin - nTie;
	local szRate  = "��ʤ��";
	if nTotal > 0 then
		szRate = string.format("%.2f", (nWin/nTotal)*100) .. "��";
	end
	local szMsg = string.format([[��ѩ���԰�����������а����ڽ�������ġ��������а��µġ�����С��в�ѯ��������Ϣ����Ҫ�Ұ�������а���
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

tbNpc.tbAbout = {
[1] = [[
    �������������׶Σ�
    ����ѡ�����׶Σ����˻�ս��ÿ���µ�7��~20�ţ�����14�죬�����ʱ��Ϊÿ���10�㡪��23�㣬ÿ15���ӿ���һ����10��Ϊ��һ����22��45Ϊÿ�����һ��������ʱ��5���ӡ�
    ����Ԥѡ���׶Σ�ս�Ӷ�ս�����ܻ�������ǰ120�ļ��������ս�ӽ��������ÿ���µ�21��~26�ţ�����6�졣�����ʱ��ÿ�칲2�֣����缰���ϸ�һ�֣�ÿ���15�㡪��17�㣬21��30����23��00��
    ��������׶Σ�����ս�Ӿ�����8ǿս�����ʸ���롣ÿ���µ�27�ţ�Ϊ��1�죬21��30~~23��00Ϊ����ʱ�䡣
]],

[2] = [[
    ����ѡ�����׶�����Ե����������ﱨ�������������׶εı�������Ҫս�Ӳſ��Բμӱ���������Ҫ��ļ����Ա��ͬŬ���������С�û�м����ǲ��ܲμ�ս�����ġ�
]],
[3] = [[
    ���ǵ��˱������ᷢ�ִ�ұ������һȺС���������һ���С���ѩ�򡱵ļ��ܣ������乥�����㲻һ����С���Ϳ��Ի�û��֡��㻹�ᷢ�����������һЩ��ֵ�ѩ�ˣ����ʲô�ģ��Ҽ�����Ϳ��Ի������ǿ�����ܣ����ж��ֿ��Ի�ø�����֡����а������ؾ����±�����Ҫע�ⰲȫ��ɽ���и����ޣ��������˿��ǲ����ˣ��������Ƣ���ܴ�ġ�
]],
[4] = [[
    1.��Ȼ�㱨���˵�����������������ܻ��ֿգ�û��ϵ������׼�����ٱ����ɡ�
    
    2.���������󣬴�����Զ�һ���ģ��ͽ�ɫ�ļ��ܵȶ�û���κι�ϵ��Ŷ��
    
    3.���������ϰ����Զ�ܱ��������ѩ�򣬵����ϰ������������±��������С�ġ�
]],
};

function tbNpc:OnAboutEx(nFlag)
	local szMsg = "���徺����������µļ��֣�����Ҫ�˽��Ǹ��أ�"
	local tbOpt = {
		{"�˽��ѩ�̻", self.OnAbout, self},
		{"�˽��������", Npc:GetClass("dragonboat_signup").OnAbout, Npc:GetClass("dragonboat_signup")},
		{"�˽��ػ�����֮�����", TowerDefence.OnAbout, TowerDefence},
		{"��㿴��"},
	};
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnAbout(nSel)
	if nSel then
		Dialog:Say(self.tbAbout[nSel], {{"�����ϲ�", self.OnDialog, self}});
		return 0;
	end
	local szMsg = "�����˽��ѩ�̻���ķ�����Ϣ�أ�"; 
	local tbOpt = {
		{"�ʱ�����"	, self.OnAbout, self, 1},
		{"�μ���ʽ"		, self.OnAbout, self, 2},
		{"ѩ����δ�"	, self.OnAbout, self, 3},
		{"ע������"		, self.OnAbout, self, 4},
		{"��֪����"		, self.OnDialog, self},
	};
	Dialog:Say(szMsg, tbOpt);
end
------------------------