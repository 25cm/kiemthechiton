-- �ļ�������snowman.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2009-11-26 11:36:28
-- ��  ��  ��
local tbNpc = Npc:GetClass("snowman");

SpecialEvent.Xmas2008 = SpecialEvent.Xmas2008 or {};
SpecialEvent.Xmas2008.XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman or {};
local XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman;

function tbNpc:OnDialog()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));	
	local nTime = tonumber(GetLocalDate("%H%M"));	

	if nDate <= XmasSnowman.EVENT_END or nDate >= XmasSnowman.MAXMAN_END then
		return;
	end
	local tbOpt = {{"��ȡ����", self.OnAward, self}, {"�����Ի���"}};	  
	local szMsg = "��ڼ䣬ÿ���������������";
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnAward()
	
	if me.nLevel < 60 then
		Dialog:Say("��ĵȼ�������60���Ժ������ɡ�");
		return;
	end	
	
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	local nAward = me.GetTask(XmasSnowman.TSKG_GROUP, XmasSnowman.TSK_AWARD_FUDAI);
    if (nDate == math.floor(nAward /10)) and ((nAward %10) == 1) then
		Dialog:Say("������Ѿ����һ���ˣ������ٴ���ȡ��");
		return;
	end
	

	
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("���İ����ռ䲻�㡣");
		return;
	end	
	me.SetTask(XmasSnowman.TSKG_GROUP, XmasSnowman.TSK_AWARD_FUDAI, (nDate * 10 + 1));
	for i = 1 , 2 do
		local pItem = me.AddItem(unpack(XmasSnowman.FUDAI_ID));
		if pItem then
			pItem.Bind(1);
		end	
	end	
end


