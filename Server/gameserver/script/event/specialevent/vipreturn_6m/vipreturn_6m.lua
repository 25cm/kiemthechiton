-- 文件名　：vipreturn_6m.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-07-02 10:24:20
-- 描  述  ：

SpecialEvent.VipReturn_6M = SpecialEvent.VipReturn_6M or {};
local tbVip = SpecialEvent.VipReturn_6M;

tbVip.nCreateDate = 20091215;
tbVip.nStart 	= 20100201;
tbVip.nEnd 		= 20100303;
tbVip.nTsk_Group= 2083;
tbVip.nTsk_Id1	= 7;	--激活变量
tbVip.nTsk_Id2	= 8;	--领取称号光环
tbVip.nTsk_Id3	= 9;	--领取面具
tbVip.nTsk_Id4	= 10;	--领取同伴
tbVip.nTsk_batch= 11;   --批次
tbVip.tbLevel = 
{
	[1] = "银卡",
	[2] = "金卡",
	[3] = "钻石卡",
}

--称号
tbVip.tbHalo = 
{
	[1] = {6,7,1,8},
	[2] = {6,7,2,9},
	[3] = {6,7,3,10},
}

tbVip.tbMask =
{
	[1] = {1,13,33,1},
	[2] = {1,13,34,1},
}

tbVip.tbPartner = {18,1,547,3};

tbVip.nBatchNum = 1;		--当前批次
tbVip.nLevelLimit = 69;


function tbVip:GetTypeLevel()
	return self.tbVip[string.upper(me.szAccount)] or 0;
end

function tbVip:Check()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate < self.nStart or nCurDate >= self.nEnd then
		return 0;
	end
	if not self.tbVip then
		return 0;
	end
	local nLevel = self:GetTypeLevel();
	if nLevel == 0 then
		return 0;
	end

	if tonumber(me.GetRoleCreateDate()) >= self.nCreateDate and VipPlayer.VipTransfer:CheckQualification(me) == 0 then
		return 0;
	end

	return 1;
end

function tbVip:OnDialog()	
	--清批次
	if me.GetTask(self.nTsk_Group, self.nTsk_batch) ~= self.nBatchNum then
		me.SetTask(self.nTsk_Group, self.nTsk_batch,self.nBatchNum);
		me.SetTask(self.nTsk_Group, self.nTsk_Id1,0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id2,0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id3,0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id4,0);
	end
	
	local nLevel = self:GetTypeLevel();
	if nLevel == 0 then
		return 0;
	end	
	local szMsg = "您好，在2009年度充值达到4500元以上的玩家可以领取特殊称号与光环，达到10000元以上有可爱的面具奖励，达到30000元以上更有特殊同伴奖励，赶快激活领奖吧！";
	local tbOpt = {};
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) == 0 then	
		table.insert(tbOpt,	{"<color=yellow>激活领奖资格<color>", self.Activation, self});
	else
		table.insert(tbOpt,	{"<color=gray>激活领奖资格<color>", self.Activation, self});
	end
		
	if me.GetTask(self.nTsk_Group, self.nTsk_Id2) == 0 then	
		table.insert(tbOpt,	{"<color=yellow>领取VIP称号及光环<color>", self.GetAward1, self, nLevel});
	else
		table.insert(tbOpt,	{"<color=gray>领取VIP称号及光环<color>", self.GetAward1, self, nLevel});
	end
	
	if nLevel > 1 then
		if me.GetTask(self.nTsk_Group, self.nTsk_Id3) == 0 then
			table.insert(tbOpt,{"<color=yellow>领取新年面具<color>", self.GetAwardMask,self});
		else
			table.insert(tbOpt,{"<color=gray>领取新年面具<color>", self.GetAwardMask,self});
		end
	end
	
	if nLevel > 2 then
		if me.GetTask(self.nTsk_Group, self.nTsk_Id4) == 0 then
			table.insert(tbOpt,{"<color=yellow>领取特殊同伴<color>", self.GetAwardPartner,self});
		else
			table.insert(tbOpt,{"<color=gray>领取特殊同伴<color>", self.GetAwardPartner,self});
		end
	end	
	table.insert(tbOpt,{"随便看看（离开）"});	

	Dialog:Say(szMsg, tbOpt);
end

function tbVip:Activation()
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) > 0 then
		Dialog:Say("您的角色已经激活了，请领取VIP奖励吧。");
		return 0;
	end
	
	local nExtBit = me.GetActiveValue(2);
	if nExtBit ~= 0 then	
		Dialog:Say("您的帐号下其他角色已经激活了领取VIP返还奖励。");
		return 0;
	end
	
	if me.nLevel < self.nLevelLimit then
		Dialog:Say(string.format("您的等级未到%s级，不能激活领奖资格！",self.nLevelLimit));
		return 0;
	end	
	
	if tonumber(me.GetRoleCreateDate()) >= self.nCreateDate and VipPlayer.VipTransfer:CheckQualification(me) == 0 then
		Dialog:Say("只有角色建立时间在2009年12月15日之前的才可以激活领奖。");		
		return 0;
	end
	

	local szMsg = "您确定激活当前角色领奖资格么？激活后账号下其他角色就不能激活了。";
	local tbOpt = {
		{"确定激活", self.ActivationEx, self},
		{"我再考虑考虑"},
	};
	Dialog:Say(szMsg, tbOpt);
end


function tbVip:ActivationEx()	
	Dialog:SendBlackBoardMsg(me, "恭喜您成功激活当前角色的领奖资格！");
	me.Msg("恭喜您成功激活当前角色的领奖资格！");
	me.SetActiveValue(2,1);
	me.SetTask(self.nTsk_Group, self.nTsk_Id1, 1);
	EventManager:WriteLog(string.format("SetActiveValue%s,%s", 2,1), me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[VIP返还]成功激活领取角色"));	
	local tbOpt ={
		{"返回上一层", self.OnDialog,self},
		{"确定"},
	};
	Dialog:Say("你的角色已成功激活了。",tbOpt);
end

function tbVip:GetAward1(nLevel)
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) ~= 1 then
		Dialog:Say("当前角色未激活领奖资格，不能领奖！");
		return 0;
	end
	if me.GetTask(self.nTsk_Group, self.nTsk_Id2) > 0 then
		Dialog:Say("您已经领取过该项奖励了，不能再领奖！");
		return 0;		
	end
--	me.AddTitle(6,7,nType,0);
--	me.SetCurTitle(6,7,nType,0);

	me.AddTitle(unpack(self.tbHalo[nLevel]));
	me.SetCurTitle(unpack(self.tbHalo[nLevel]));	
		
	me.SetTask(self.nTsk_Group, self.nTsk_Id2, 1);
	Dbg:WriteLog("Vip返还", me.szName.."领取称号等级："..tostring(nLevel));
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[VIP返还]领取称号等级：%s", nLevel));
--	Dialog:Say("成功领取了称号和光环。")
	Dialog:SendBlackBoardMsg(me, "恭喜您成功领取了称号及光环奖励！");
	me.Msg("恭喜您成功领取了称号及光环奖励！");
end

function tbVip:GetAwardMask()
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) ~= 1 then
		Dialog:Say("当前角色未激活领奖资格，不能领奖！");
		return 0;
	end
	
	if me.GetTask(self.nTsk_Group, self.nTsk_Id3) > 0 then
		Dialog:Say("您已经领取过该项奖励了，不能再领奖！");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("领奖需要1格背包空间，去整理下再来吧！");
		return 0;
	end	
	
	local tbOpt = 
	{
		{"男性外观", self.OnGetMask, self, 1},
		{"女性外观", self.OnGetMask, self, 2},
		{"再想想（离开）"},
	};
	
	Dialog:Say("本面具有男女两种外观，您想要哪种？", tbOpt);
end

function tbVip:OnGetMask(nType)	
	local pItem = me.AddItem(unpack(self.tbMask[nType]));
	if pItem then
		pItem.Bind(1);
		me.SetItemTimeout(pItem, 30*24*60*3, 0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id3, 1);
		Dbg:WriteLog("Vip返还", me.szName.."领取新年面具");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[VIP返还]领取新年面具");			
		Dialog:SendBlackBoardMsg(me, "恭喜您获得了新年面具奖励！");
		me.Msg("恭喜您获得了新年面具奖励！");
	end
end



function tbVip:GetAwardPartner()
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) ~= 1 then
		Dialog:Say("当前角色未激活领奖资格，不能领奖！");
		return 0;
	end
	
	if me.GetTask(self.nTsk_Group, self.nTsk_Id4) > 0 then
		Dialog:Say("您已经领取过该项奖励了，不能再领奖！");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("领奖需要1格背包空间，去整理下再来吧！");
		return 0;
	end	
	
	local pItem = me.AddItem(unpack(self.tbPartner));
	if pItem then
		pItem.Bind(1);
		me.SetItemTimeout(pItem, 30*24*60*4, 0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id4, 1);
		Dbg:WriteLog("Vip返还", me.szName.."特殊同伴叶静");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[VIP返还]特殊同伴叶静");			
		Dialog:SendBlackBoardMsg(me, "恭喜您获得了特殊同伴奖励！");
		me.Msg("恭喜您获得了特殊同伴奖励！");
	end
end


function tbVip:LoadFile()
	self.tbVip = {};
	self.tbJsPlayer = {};
	local tbFile = Lib:LoadTabFile("\\setting\\event\\vipplayerlist\\jsplayerlist.txt");
	if tbFile then
		for _, tbRole in pairs(tbFile) do
			local szAccount = string.upper(tbRole.ACCOUNT);
			local nMoney 	= tonumber(tbRole.MONEY) or 0;
			nMoney = nMoney * 5;
			if nMoney >= 4500 then
				if  nMoney < 10000 then
					self.tbVip[szAccount] = 1;	
				elseif nMoney <= 30000 then
					self.tbVip[szAccount] = 2;
				else
					self.tbVip[szAccount] = 3;
				end
			end
		end
	end
	
	tbFile = Lib:LoadTabFile("\\setting\\event\\vipplayerlist\\vipplayerlist.txt");
	if not tbFile then
		return 0;
	end
	for _, tbRole in pairs(tbFile) do
		local szAccount = string.upper(tbRole.ACCOUNT);
		local nType 	= tonumber(tbRole.Level) or 0;
		if not self.tbVip[szAccount] and nType ~= 0 then 
			self.tbVip[szAccount] = nType;
		end
	end
end

tbVip:LoadFile();
