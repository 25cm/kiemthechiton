--������npc
--�����
--2008.12.25

--����
function TowerDefence:OnDialog_SignUp(nSure)
	
	if self:CheckState() == 0 then
		Dialog:Say("����Ϣһ�°ɣ��ػ�����֮���Ѿ������ˡ�")
		return 0;
	end
	
	
	if self.nReadyTimerId <= 0 or Timer:GetRestTime(self.nReadyTimerId) <= TowerDefence.DEF_READY_TIME_ENTER  then
		Dialog:Say("����ʱ��Ϊ<color=yellow>����10�㡪14�㣬����17�㡪��ҹ23��<color>��ÿ���Сʱ����һ�Σ�����Ͱ�㿪ʼ����������ʱ��4����30�롣\n\n<color=red>���ڲ��ڱ����׶�<color>");
		return 0;
	end
	
	if me.nTeamId <= 0 then
		if nSure == 1 then
			self:OnDialogApplySignUp();
			return 0;
		end		
		if me.nLevel < self.DEF_PLAYER_LEVEL or me.nFaction <= 0 then
			Dialog:Say("�����Ϊ����Ŷ��60�������������Ժ���һ������ȥŶ��");
			return 0;
		end
		if self:IsSignUpByAward(me) == 1 then
			Dialog:Say("���ϴα����Ľ�����û���أ���׼��Ҫ�ҵ�����Ŷ���һ�����������ȥ�ġ�");
			return 0;
		end		
		if self:IsSignUpByTask(me) == 0 then
			Dialog:Say("������Ѿ�ȥ����ô����ˣ���ȥ��Ϣ�����������ɡ�");
			return 0;
		end
		
		if me.GetEquip(Item.EQUIPPOS_MASK) then
			Dialog:Say("���������߲μӣ�������ժ���������Ұɡ�");
			return 0;
		end	
		local tbOpt = {
			{"��Ҫ����", self.OnDialog_SignUp, self, 1},
			{"���ٿ��ǿ���"},
			};
		Dialog:Say("�������������������������", tbOpt);
		return 0;
	end
	

	if me.IsCaptain() == 0 then
		Dialog:Say("�㲻�Ƕӳ�Ŷ��ȥ�����Ƕӳ��������ɡ�");
		return 0;
	end
	local tbPlayerList = KTeam.GetTeamMemberList(me.nTeamId);
	
	if nSure == 1 then
		self:OnDialogApplySignUp(tbPlayerList);
		return 0;
	end
	
	local tbOpt = {
		{"����Ҫǰ��", self.OnDialog_SignUp, self, 1},
		{"�����ٿ��ǿ���"},
		};
	Dialog:Say(string.format("���Ƕ�������������������������𣿶�����<color=yellow>%s��<color>����ȷ����Ա�����", #tbPlayerList), tbOpt);
	return 0;
end

function TowerDefence:OnDialogApplySignUp(tbPlayerList)	
	if not tbPlayerList then
		GCExcute{"TowerDefence:ApplySignUp",{me.nId}};
		return 0;
	end
	if Lib:CountTB(tbPlayerList) > self.DEF_PLAYER_TEAM then
		Dialog:Say("���Ƕ�����̫���ˣ�ֻ�����ĸ���ǰȥ�ġ�");
		return 0;
	end
	local nMapId, nPosX, nPosY	= me.GetWorldPos();
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if not pPlayer then
			Dialog:Say("���Ƕ�������û���������ǻ����ܳ������ȵ����ɡ�");
			return 0;
		end		
		if pPlayer.nLevel < self.DEF_PLAYER_LEVEL or pPlayer.nFaction <= 0 then
			Dialog:Say(string.format("�����Ǹ�<color=yellow>%s<color>̫��С�˰ɣ�������������Σ���ˣ�60�������������Ժ������ɡ�", pPlayer.szName));
			return 0;
		end
		if self:IsSignUpByAward(pPlayer) == 1 then
			Dialog:Say(string.format("<color=yellow>%s<color>�ϴα����Ľ�����û���أ���׼��Ҫ�ҵ�����Ŷ���һ�������������ȥ��ġ�", pPlayer.szName));
			return 0;
		end				
		
		if self:IsSignUpByTask(pPlayer) == 0 then
			Dialog:Say(string.format("����<color=yellow>%s<color>�����ȥ�ö���ˣ����������ɡ�", pPlayer.szName));
			return 0;
		end
		if pPlayer.GetEquip(Item.EQUIPPOS_MASK) then
			Dialog:Say(string.format("%s���������߲μӣ�������ժ���������Ұɡ�", pPlayer.szName));
			return 0;
		end
		local nMapId2, nPosX2, nPosY2	= pPlayer.GetWorldPos();
		local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
		if nMapId2 ~= nMapId or nDisSquare > 400 then
			Dialog:Say("�������ж��ѱ������⸽����");
			return 0;
		end
		if not pPlayer or pPlayer.nMapId ~= nMapId then
			Dialog:Say("�������ж��ѱ������⸽����");
			return 0;
		end
	end
	GCExcute{"TowerDefence:ApplySignUp", tbPlayerList};
	return 0;
end

function TowerDefence:IsSignUpByTask(pPlayer)
	TowerDefence:TaskDayEvent();
	local nCount = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT);
	local nExCount = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_EXCOUNT)
	if nCount <= 0 and nExCount <= 0 then
		return 0, 0 ,0;
	end
	return nCount + nExCount, nCount, nExCount;
end

function TowerDefence:IsSignUpByAward(pPlayer)
	return pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_AWARD);
end

function TowerDefence:Npc_ProductTD()
	local tbITem = Item:GetClass("td_fuzou");
	local szMsg = "�������ֻ��Ҫ��������Ǯ�Ϳ��Զ�����ӻ������и��죬�Ӷ�ʹ����������������������ȡ�ñ�����ʤ����";
	local tbOpt = {
		{"�˽�����ӻ�������", TowerDefence.OnAbout, TowerDefence},
		{"��������ӻ�������", tbITem.OpenProduct, tbITem, 1},
		{"��㿴��"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function TowerDefence:OnAbout()
	local szMSg = "�������������԰�ػ�����֮�꣬��Ҫ�˽���Щ�����أ�";
	local tbOpt = {};
	for i, tbMsg in pairs(self.tbAbout) do
		table.insert(tbOpt, {tbMsg[1], self.AboutInfo, self, i});
	end
	table.insert(tbOpt, {"��������"});
	Dialog:Say(szMSg, tbOpt);
end

function TowerDefence:AboutInfo(nSel)
	local szMSg = self.tbAbout[nSel][2];
	Dialog:Say(szMSg,{{"��֪����", self.OnAbout, self}});
end

TowerDefence.tbAbout = {
{"��ν����������֮�ꡱ", [[
    ÿ��һ������ʱ�ڣ������ն����ټ�������½�ʿ�ڷ�ţɽ��ɽ��������֮�꣬��������������Ǳ���������ġ�������²�����Ҽ�԰���ļᶨ��־������Ŷ����������߽����ż��׿���ĵֿ���
    ʱ��������ͻȻ�յ�����̫ү�����ܱ���һ���ɽ��˲��ݵĽ�ʬ�ͻ�е���޾���������Χ��֮�ƽӽ������ͼ��������֮������������������в����֮�ꡣԤ�ƴ������޽�����������ʱ����������ý��㣬ɽ��������
    �������Ӵ�������ͷ���ӵķ�������ͨ��������Щ�����ǹ�����Ч��ֻ�������嶾�����Ƶ�ֲ����ܵ��������Խ�ʬ������ɴ����ͻ����Χ�������չ������������н�ʿ������Ͷ�빤�����ں�ɽ�����������£������������֡�
]]
},
{"�����ʱ��",string.format([[
    �������������׶Σ�
    ����ѡ�����׶Σ����˻�ս��ÿ���µ�7��~20�ţ�����14�죬�����ʱ��Ϊÿ�������10�㡪14�㣬����17�㡪��ҹ23�㣬ÿ15���ӿ���һ����10��Ϊ��һ����22��45Ϊÿ�����һ��������ʱ��5���ӡ�
    ����Ԥѡ���׶Σ�ս�Ӷ�ս�����ܻ�������ǰ120�ļ��������ս�ӽ��������ÿ���µ�21��~26�ţ�����6�졣�����ʱ��ÿ�칲2�֣����缰���ϸ�һ�֣�ÿ���15�㡪��17�㣬21��30����23��00��
	��������׶Σ�����ս�Ӿ�����8ǿս�����ʸ���롣ÿ���µ�27�ţ�Ϊ��1�죬21��30~~23��00Ϊ����ʱ�䡣]])
},
{"��βμӱ���",[[
    �������60�����ϵ���ҿ���ȥ�����ִ�������ѩ�����μӣ�ÿ�����ÿ����2�λ��ᡣ�μӱ����������Լ���ר������ӻ���������ӻ������Բ�ȡһ����ʽ��ã�ͬʱ���ܽ��ж�����죬ʹ����и�������������]]
},
{"��λ��ר������ӻ���",[[
    ����ӻ����Ļ�ȡ��ʽ��ȥ�ӻ��깺����Ӱԭʯ�������������������Ӱ֮ʯ����ȥ����ѩ����ȡ��1����Ӱ֮ʯ��ȡ����ӻ���5����Ӱ֮ʯ�ɻ�ȡ����ӻ�����ˡ�
    ]]
},
{"�˽�����ӻ�������",[[
    ����ӻ������칲��������ܿɹ�ѡ��
    <color=yellow>�ɹ�ѡ��ļ��ܸ��죺<color>
    ����ӻ��������Ա����еĹ������һ���˺�ͬʱ��������Ч����
    ����ӻ����ˣ��Ա����еĹ������һ���˺�ͬʱ��������Ч����
    ����ӻ��������Ա����еĹ������һ���˺�ͬʱ�����ٻ�Ч����
    ����ӻ����ң��Ա����еĹ������һ���˺�ͬʱ��������Ч����
    ����ӻ����Σ��Ա����еĹ������һ���˺�ͬʱ����ѣ��Ч����
    <color=yellow>ע�⣺<color>����ӻ�������ӻ�����˵������������ͨ������ӻ�ֻ�ܸ���һ�ֹ������ܣ�������ӻ�����˿���ͬʱѡ��������ּ��ܡ�]]
},
{"���������",[[
    �������ʼ������������£�Ȼ����ͨ�������ƶ���ÿһ�ߵĹ�����������ͬ�ģ��ߵ���������ϣ�Ȼ������ͣ���󣬻��߳��յ㣬������ʧ��
    �ؿ�������30�����ʼˢ�֣�����ÿһ����ˢһ�Σ�һ��ˢ12�Σ����о�Ӣ��������ǻ��ͷŷ�Χ�����������˺�ֲ��ġ����ͨ����ֲ�������������һ������ܿ�����ˣ��Ǿ�����ˢ��һ����
    �ڱ��������У�����ֲ����Ҫ�þ����ڵ�ͼ�е��嶾�������˴�������ÿһ�����ڱ������������Ҷ����þ��á���õľ��û��ڿͻ��˽�����ʵʱ��ʾ���Է������֪���Լ�Ŀǰ�ľ�������]]
},
{"ʤ��������",[[
    ����������һ��û��֣���������ձ����������õĻ�����������ȡ������]]
},
}
