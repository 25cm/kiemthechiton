--ʥ�����ˣ����У�
--�����
--2008.12.16
if  MODULE_GC_SERVER then
	return;
end
local tbNpc = Npc:GetClass("xmas_laoren");
tbNpc.TSK_GROUP = 2027;
tbNpc.TSK_ID = 97;
tbNpc.DEF_ITEM = {18,1,269,1};	--����Id
tbNpc.SNOW_ITEM = {18,1,213,1}; -- ѩ��Id

function tbNpc:OnDialog()
	local nCheck = SpecialEvent.Xmas2008:Check();
	if nCheck == -1 then
		Dialog:Say("ʥ�����ˣ����û��ʼ���һ�Ҫ׼��һ��ʱ����������ء�")
		return 0;		
	end
	if nCheck == 0 then
		Dialog:Say("ʥ�����ˣ����ﶼ�����ˣ���Ϣһ����뿪��")
		return 0;
	end
	local szMsg = "ʥ�����ˣ����������ʥ������Ŷ��";
	local tbOpt = {
		{"��ȡʥ������", self.GetSocks, self},
		{"��ѩ���һ�ʥ������",self.ChargeSocks, self},
		{"�˽�ʥ���",self.About, self},
		{"����㿴��"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetSocks(nSure)
	if not nSure then
		local tbOpt = 
		{
			{"��Ҫʥ������", self.GetSocks, self, 1},
			{"����㿴��"},
		}
		Dialog:Say("�ڻ�ڼ䣬��λÿ���������������ȡһֻ���ӣ������кܶ�����Ŷ���Ǻǣ�", tbOpt);
		return 0;
	end
	
	if me.nLevel < 60 then
		Dialog:Say("��Ľ�����������������60�������ɡ�");
		return 0;
	end
	
	local nCurDate = tonumber(GetLocalDate("%y%m%d"));
	if me.GetTask(self.TSK_GROUP, self.TSK_ID) >= nCurDate then
		Dialog:Say("�������Ѿ�����������Ŷ�����ﲻ�࣬Ҫ�������������", {{"Ŷ��������"}});
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		local szAnnouce = "���ı����ռ䲻�㣬������1��ռ����ԡ�";
		Dialog:Say(szAnnouce);
		return 0;
	end
	
	local pItem = me.AddItem(unpack(self.DEF_ITEM));
	if pItem then
		pItem.Bind(1);
		me.SetTask(self.TSK_GROUP, self.TSK_ID, nCurDate);
	end
	
	Dialog:Say("��������������úò�ҪŪ����Ŷ���������ǵ�����������", {{"ллʥ������"}});
end


function tbNpc:ChargeSocks()
	if me.nLevel < 60 then
		Dialog:Say("��Ľ�����������������60�������ɡ�");
		return 0;
	end

	local szContent = "�����ѩ����ÿ<color=yellow>5��ѩ��<color>��ȡһ��<color=yellow>ʥ������<color>��";
	Dialog:OpenGift(szContent, nil, {self.OnOpenGiftOk, self});
end

function tbNpc:OnOpenGiftOk(tbItemObj)
	local tbItemCount = {};
	local szName = string.format("%s,%s,%s,%s",self.SNOW_ITEM[1], self.SNOW_ITEM[2], self.SNOW_ITEM[3], self.SNOW_ITEM[4]);
	for _, tbItem in pairs(tbItemObj) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel);
		if not  tbItemCount [szKey] then
			tbItemCount[szKey] = 0;
		end
		tbItemCount[szKey] = tbItemCount[szKey] + pItem.nCount;
	end
	local nSockCount = math.floor(tbItemCount[szName]/5);
	if nSockCount == 0 then
		me.Msg("û���㹻��ѩ��");
		return 0;
	end

	if me.CountFreeBagCell() < nSockCount then
		me.Msg("���ı����ռ䲻�㣬�������㹻�Ŀռ����ԡ�");		
		return 0;
	end
	
	-- ��鱳��
	me.ConsumeItemInBags2(nSockCount * 5, self.SNOW_ITEM[1], self.SNOW_ITEM[2], self.SNOW_ITEM[3], self.SNOW_ITEM[4], nil, -1);
	me.AddStackItem(self.DEF_ITEM[1],self.DEF_ITEM[2],self.DEF_ITEM[3],self.DEF_ITEM[4],nil,nSockCount);
end

tbNpc.tbAbout = 
{
[1] = [[
  ��ڼ䣬60�����ϵĽ�ɫÿ�춼���Ե�<color=yellow>ʥ������<color>��������ȡһ��<color=yellow>ʥ������<color>��������������]],

[2] = [[
  ��ڼ䣬����ң�ȣ��ν�ս�����׻��ã����ɾ������أ� �㶼�п�������<color=yellow>ʥ������<color>���������һ��װ�������<color=yellow>ʥ������<color>Ŷ��]],

[3] = [[
  ��ڼ䣬����ң�ȣ��ν�ս�����׻��ã����ɾ������� ���㶼�п����������������<color=yellow>ʥ����<color>������������ܻ��<color=yellow>Сѩ��<color>����<color=yellow>ʥ������<color>��]],

[4] = [[
  ��ڼ䣬�������5��<color=yellow>ѩ��<color>������һ�һֻ<color=yellow>ʥ������<color>��ѩ�������ʹ�������������
  ѩ����εõ���������Դ�<color=yellow>ѩ��<color>�ɼ���<color=yellow>ʥ����<color>��ժȡ ���ټӹ��õ���<color=yellow>Сѩ��<color>����������������<color=yellow>ѩ��<color>�����ɡ�
	]],

[5] = [[
  ��<color=yellow>ʥ������<color>������Ի�ý���������һ�����ʻ��һ��<color=yellow>ʥ�����<color>Ŷ,����ÿ�������ֻ��ʹ��<color=yellow>100ֻ����<color>��]],

[6] = [[
  ���Լ���õ�<color=yellow>ʥ�����<color>ֻ�����ˣ������أ������ʹ�ñ��������<color=yellow>ʥ�����<color>������ý���������������������������������~~~
  ��˵������ÿ�����������<color=yellow>10��<color>��У������ô���أ�ת�ͱ����������ô���أ���˵<color=yellow>�����<color>������]],
}

function tbNpc:About()
	local szMsg = "ʥ�����࣬��Ҫ�˽��ĸ��أ�";
	local tbOpt = {
		{"ʥ�����˵�ÿ������", self.OnAbout, self, 1},
		{"����ʥ������", self.OnAbout, self, 2},
		{"ż��ʥ����", self.OnAbout, self, 3},
		{"ѩ����ʥ������", self.OnAbout, self, 4},
		{"ʥ�����ӵĽ���", self.OnAbout, self, 5},
		{"ʥ����е���;", self.OnAbout, self, 6},
		{"��������"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnAbout(nNo)
	local szMsg = self.tbAbout[nNo];
	local tbOpt = {
		{"�����ϲ�", self.About, self},
		{"�����Ի�"},
	}
	Dialog:Say(szMsg, tbOpt);
end
