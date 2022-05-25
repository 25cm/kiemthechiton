-- 文件名　：dingding.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-06-05 10:25:46
-- 描  述  ：

local tbNpc = Npc:GetClass("girl_dingding");
tbNpc.SZ_UPLOAD_PHOTO_URL = "http://hd05.www.xoyo.com/beauty_preliminary/login.shtml"


function tbNpc:OnDialog()
	
	if SpecialEvent.Girl_Vote:IsOpen() ~= 1 then
		Dialog:Say("你好，我是丁丁姑娘！！");
		return 0;
	end
	
	if SpecialEvent.Girl_Vote:CheckState(1, 8) ~= 1 then
		Dialog:Say("你好，我是丁丁姑娘！！");
		return 0;			
	end
	
	local szMsg = [[想知道剑侠世界都有哪些美女吗？<color=yellow>“武林第一美女”<color>评选拉开帷幕，谁能最终挺进决赛，荣登第一宝座？最精彩的赛事，最浪漫的评选方式，《剑侠世界》武林第一美女海选6月18日正式开始报名，所有女玩家都有参加机会，<color=yellow>拉风光环、面具、称号以及玄晶，汽车<color>等独一无二的超级大奖在向你招手，快来参加吧！游戏报名后可以去官网上传资料和照片，大家都可以去官网寻找自己喜欢的绝色美女哦。]];
	local tbOpt = {
			{"我是来给美女投票的", self.State1VoteTickets, self},
			{"查询排行及票数信息", self.Query, self},
			{"领取美女评选奖励", self.GetAward, self},
			{"了解详细信息", self.GetDetailInfo, self},
			{"随便看看（离开）"},
		};
	if SpecialEvent.Girl_Vote:CheckState(1, 3) == 1 then
		table.insert(tbOpt, 1, {"我是美女我要参加", self.State1SignUp, self});
	end
	
	if SpecialEvent.Girl_Vote:CheckState(1, 6) == 1 then
--		table.insert(tbOpt, 1, {"我是来上传照片的", self.UploadPhoto, self});
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetAward()
	local szMsg = [[
初赛颁奖时间：07-28维护 至 08-04
初赛颁奖对象：
  前20名未进入决赛的美女玩家
  票数达到499张的美女玩家
  前20名的所有美女玩家的第一粉丝们
  票数达到499张的美女第一粉丝们
	
决赛颁奖时间：07-28维护 至 08-11
初赛颁奖对象：
  所有入围决赛的美女玩家
  决赛全区全服前十名美女玩家
  决赛全区全服第一美女玩家
	]];
	local tbOpt = {
		{"领取初赛奖励", self.GetAward1, self},
		{"领取初赛粉丝奖励", self.GetAwardEx1, self},
		{"领取决赛奖励", self.GetAward2, self},
		{"领取决赛粉丝奖励", self.GetAwardEx2, self},
		{"我只是来看看"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetAwardEx1()
	if tonumber(GetLocalDate("%Y%m%d%H")) < (SpecialEvent.Girl_Vote.STATE_AWARD[1] * 100 + 10) then
		Dialog:Say("美女评选初赛粉丝奖励还未开始领取");
		return 0;
	end
	if tonumber(GetLocalDate("%Y%m%d")) >= SpecialEvent.Girl_Vote.STATE_AWARD[2] then
		Dialog:Say("美女评选初赛粉丝奖励领取已经结束");
		return 0;
	end	
	--if not SpecialEvent.Girl_Vote.tbGirlKinTong then
	--	Dialog:Say("美女评选初赛领奖还未开始，请耐心等待。");
	--	return 0;		
	--end	
	if me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_StateEx1) > 0 then
		Dialog:Say("你已经领取过奖励了，不能太贪心哦。");
		return 0;
	end	
	Dialog:AskString("哪位美女的粉丝", 16, self.GetAwardEx1_1, self);		
end

function tbNpc:GetAwardEx1_1(szName)
	if me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_StateEx1) > 0 then
		Dialog:Say("你已经领取过奖励了，不能太贪心哦。");
		return 0;
	end		
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf();
	if not tbBuf[szName] then
		Dialog:Say(string.format("美女评选中找不到美女%s的资料，如果你是某个美女的第一粉丝，请输入你该美女名字领取第一粉丝称号奖励。", szName));
		return 0;
	end
	local szFanName = tbBuf[szName][1];
	if szFanName ~= me.szName then
		Dialog:Say(string.format("你不是美女%s的第一粉丝哦，该美女的第一粉丝是%s", szName, szFanName));
		return 0;	
	end
	if SpecialEvent.Girl_Vote:GetAward(me, 3, "您成功领取了美女评选初赛第一粉丝奖励")== 1 then
		me.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_StateEx1, 1);
	end
end

function tbNpc:GetAward1()
	if tonumber(GetLocalDate("%Y%m%d%H")) < (SpecialEvent.Girl_Vote.STATE_AWARD[1] * 100 + 10) then
		Dialog:Say("美女评选初赛奖励还未开始领取");
		return 0;
	end
	if tonumber(GetLocalDate("%Y%m%d")) >= SpecialEvent.Girl_Vote.STATE_AWARD[2] then
		Dialog:Say("美女评选初赛奖励领取已经结束");
		return 0;
	end
	--if not SpecialEvent.Girl_Vote.tbGirlKinTong then
	--	Dialog:Say("美女评选初赛领奖还未开始，请耐心等待。");
	--	return 0;		
	--end
	if me.nSex ~= Env.SEX_FEMALE then
		Dialog:Say("你没有报名参加美女评选活动。");
		return 1;
	end
	
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf();	
	if not tbBuf[me.szName] then
		Dialog:Say("你没有报名参加美女评选活动。");
		return 0;
	end
	
	if me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_State1) > 0 then
		Dialog:Say("你已经领取过奖励了，不能太贪心哦。");
		return 0;
	end

	local nHonor		= PlayerHonor:GetPlayerHonorByName(me.szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0);
	local nType 		= Ladder:GetType(0, Ladder.LADDER_CLASS_LADDER, Ladder.LADDER_TYPE_LADDER_ACTION, Ladder.LADDER_TYPE_LADDER_ACTION_PRETTYGIRL);
	local tbLadderPart 	= GetTotalLadderPart(nType, 1, SpecialEvent.Girl_Vote.DEF_AWARD_ALL_RANK);
	local tbPassGirl 	= {};
	local tbNoPassGirl	= {};
	
	for nRank, tbPlayer in ipairs(tbLadderPart) do
		local szName = tbPlayer.szPlayerName;
		if tbBuf[szName] then
			if tonumber(tbBuf[szName][4]) == 2 then
				tbPassGirl[szName] = nRank;
			else
				tbNoPassGirl[szName] = nRank;
			end
		end
	end
	if tbPassGirl[me.szName] then
		Dialog:Say("恭喜您进入了决赛，请参加决赛比赛，等待决赛结束后再领取您的奖励。");
		return 0;
	end
	
	if tbNoPassGirl[me.szName] then
		if SpecialEvent.Girl_Vote:GetAward(me, 1, "您成功领取了美女评选初赛奖励") == 1 then
			me.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_State1, 1);
		end
		return 0;
	end
	
	if nHonor >= SpecialEvent.Girl_Vote.DEF_AWARD_TICKETS then
		if SpecialEvent.Girl_Vote:GetAward(me, 1, "您成功领取了美女评选初赛奖励") == 1 then
			me.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_State1, 1);
		end
		return 0;
	end
	
	Dialog:Say("很遗憾，按你的排名和票数，你没有任何奖励可以领取。");
	return 0;
end

function tbNpc:GetAward2()
	if tonumber(GetLocalDate("%Y%m%d%H")) < (SpecialEvent.Girl_Vote.STATE_AWARD[3] * 100 + 10) then
		Dialog:Say("美女评选决赛奖励还未开始领取");
		return 0;
	end
	if tonumber(GetLocalDate("%Y%m%d")) >= SpecialEvent.Girl_Vote.STATE_AWARD[4] then
		Dialog:Say("美女评选决赛奖励领取已经结束");
		return 0;
	end
	
	if me.nSex ~= Env.SEX_FEMALE then
		Dialog:Say("这是全区全服前十名美女的奖励，没有你的份哦。");
		return 1;
	end
	
	if not SpecialEvent.Girl_Vote.tbFinishWinList then
		Dialog:Say("美女评选决赛奖励还未开始领取");
		return 0;		
	end
	local szGateWay = string.sub(GetGatewayName(), 5, 6);
	if not SpecialEvent.Girl_Vote.tbFinishWinList[szGateWay] then
		Dialog:Say("对不起，你不是全区全服前十名的美女。");
		return 0;
	end
	if not SpecialEvent.Girl_Vote.tbFinishWinList[szGateWay][me.szName] then
		Dialog:Say("对不起，你不是全区全服前十名的美女。");
		return 0;
	end
	if me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_State2) > 0 then
		Dialog:Say("你已经领取过奖励了，不能太贪心哦。");
		return 0;
	end
	local tbInfo = SpecialEvent.Girl_Vote.tbFinishWinList[szGateWay][me.szName];
	local nType = 2;
	if tbInfo.nRank > 1 and tbInfo.nRank <= 10 then
		nType = 4;
	end 
	if tbInfo.nRank == 1 then
		nType = 5;
	end
	if SpecialEvent.Girl_Vote:GetAward(me, nType, string.format("<color=red>恭喜您，您是剑侠世界全区全服第%s名美女！<color>\n您成功领取了美女评选决赛奖励", tbInfo.nRank)) == 1 then
		me.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_State2, 1);
	end
	return 0;
end

function tbNpc:GetAwardEx2()
	if tonumber(GetLocalDate("%Y%m%d%H")) < (SpecialEvent.Girl_Vote.STATE_AWARD[3] * 100 + 10) then
		Dialog:Say("美女评选决赛奖励还未开始领取");
		return 0;
	end
	if tonumber(GetLocalDate("%Y%m%d")) >= SpecialEvent.Girl_Vote.STATE_AWARD[4] then
		Dialog:Say("美女评选决赛奖励领取已经结束");
		return 0;
	end

	
	if me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_StateEx2) > 0 then
		Dialog:Say("你已经领取过奖励了，不能太贪心哦。");
		return 0;
	end
	
	if not SpecialEvent.Girl_Vote.tbFinishWinList then
		Dialog:Say("美女评选决赛粉丝奖励还未开始领取");
		return 0;		
	end	
	local szGateWay = string.sub(GetGatewayName(), 5, 6);
	
	local nHaveFans = 0;
	local szGirlName = "";
	local nRank = 0;
	for szWay, tbWay in pairs(SpecialEvent.Girl_Vote.tbFinishWinList) do
		for szName, tbInfo in pairs(tbWay) do
			if me.szName == tbInfo.szFansName and szGateWay == tbInfo.szFansGateWay then
				nHaveFans = 1;
				szGirlName = szName;
				nRank = tbInfo.nRank;
				break;
			end
		end
	end
	if nHaveFans == 0 then
		Dialog:Say("对不起，你不是全区全服前十名美女的粉丝。");
		return 0;
	end
	
	if SpecialEvent.Girl_Vote:GetAward(me, 6, string.format("你是全区全服<color=yellow>第%s名美女%s<color>的第一粉丝；您成功领取了美女评选决赛粉丝奖励", nRank, szGirlName)) == 1 then
		me.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_StateEx2, 1);
	end
	return 0;	
end


function tbNpc:UploadPhoto()
	if me.nSex ~= Env.SEX_FEMALE then
		Dialog:Say("只有女玩家才可以上传照片，你这小子是不是有病啊？");
		return 1;
	end
	
	if SpecialEvent.Girl_Vote:CheckState(1, 6) ~= 1 then
		Dialog:Say("美女评选6月18日至7月20日进行，现在不在活动期间，不能上传照片。");
		return 0;
	end	
	
	local nAssignTime = me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Vote_Girl);
	if nAssignTime <= 0 then
		Dialog:Say("你还没报名，先报名，等2小时再来找我吧，我会把你传送到对应官方网页。");
		return 2;
	end
	
	if GetTime() - nAssignTime <= 2*3600 then
		Dialog:Say("不要急呀，你的报名信息还在传送中，报名2小时后才可以上传照片呀！");
		return 3;
	end
	
	me.CallClientScript({"OpenWebSite", tbNpc.SZ_UPLOAD_PHOTO_URL});
	return 0;
end

function tbNpc:GetDetailInfo()
	local sz = [[
	    UiManager:OpenWindow(Ui.UI_HELPSPRITE);
	    local uiHelpSprite = Ui(Ui.UI_HELPSPRITE);
	    uiHelpSprite:OnButtonClick("BtnHelpPage", 1);
	    for key, tbNews in pairs(uiHelpSprite.tbNewsInfo) do
	        if (tbNews.szName == "武林第一美女海选开幕！") then
	            uiHelpSprite:Link_news_OnClick("", key);
	        end
	    end
	]]
	
	me.CallClientScript({"GM:DoCommand",sz});
end

function tbNpc:Query()
	if SpecialEvent.Girl_Vote:CheckState(5, 7) == 1 then
		self:Query2();
		return 0;
	end
	if SpecialEvent.Girl_Vote:CheckState(7, 8) == 1 then
		Dialog:Say("美女评选已经完全结束了。");
		return 0;
	end	
	local szMsg = "查询美女评选初赛信息";
	local tbOpt = {
			{"查询自己信息", self.QueryMyName, self},
			{"通过名字查询", self.QueryIntPutName, self},
			{"查看排行榜", self.OpenRankList, self},
			{"结束对话"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OpenRankList()
	local sz = [[
		UiManager:OpenWindow(Ui.UI_LADDER);
		local uiLadder = Ui(Ui.UI_LADDER);
		uiLadder:OnButtonClick("BtnPage2");
		uiLadder:OnButtonClick("BtnGenre2");
		uiLadder:OnButtonClick("BtnSubject5");
	]]
	
	me.CallClientScript({"GM:DoCommand",sz});
end

function tbNpc:QueryMyName()
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf();	
	if not tbBuf[me.szName] then
		Dialog:Say("你不是参赛选手！");
		return 0;
	end
	self:QueryByName(me.szName);
end

function tbNpc:QueryIntPutName()
	Dialog:AskString("请输入美女名字", 16, self.QueryByName, self);	
end

function tbNpc:QueryByName(szName)
	
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf();
	if not tbBuf[szName] then
		Dialog:Say("没有该美女玩家！");
		return 0;
	end
	local nFansTickets 	= tbBuf[szName][2];
	local szFansName 	= tbBuf[szName][1];
	local nFanSex 		= tbBuf[szName][3];
	local nRank 		= GetPlayerHonorRankByName(szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0);	
	local nHonor		= PlayerHonor:GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0);
	
	local szMyTickets 	= "";
	if szName ~= me.szName then
		local nUseTask		= SpecialEvent.Girl_Vote:GetTaskGirlVoteId(szName);
		local nMyTickets	= me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, (nUseTask+4));
		szMyTickets = string.format("我的投票数：<color=white>%s<color>", nMyTickets);
	end
	local szRank = nRank;
	if nRank == 0 then
		szRank = "无";
	end
	
	local szFanSex = "男";
	if nFanSex == 1 then
		szFanSex = "女";
	end
	
	if szFansName == "" then
		szFansName = "无";
		nFansTickets = 0;
		szFanSex = "无";
	end

	local szMsg = string.format([[
		<color=green>------美女玩家投票明细------
		
		美女玩家：<color=white>%s<color>
		总 排 名：<color=white>%s<color>
		总 票 数：<color=white>%s<color>
		
		第一粉丝：<color=white>%s<color>
		第一粉丝票数：<color=white>%s<color>
		第一粉丝性别：<color=white>%s<color>
		
		%s
		<color>
	]], szName, szRank, nHonor, szFansName, nFansTickets, szFanSex, szMyTickets);
	Dialog:Say(szMsg, {{"返回上层", self.Query, self},{"结束对话"}});
end

--美女初选报名
function tbNpc:State1SignUp(nSure)
	
	if SpecialEvent.Girl_Vote:CheckState(1, 3) ~= 1 then
		Dialog:Say("美女评选报名阶段为6月18日至6月30日，现在不在报名期间，不能进行报名。");
		return 0;
	end
	
	if me.nSex ~= 1 then
		Dialog:Say("只有女玩家才可以参加选美，你这小子是不是有病啊？");
		return 0;
	end	
	if SpecialEvent.Girl_Vote:IsHaveGirl(me.szName) == 1 then
		Dialog:Say("你已经报过名了啊，可不要来欺骗本姑娘。");
		return 0;
	end
	
	if not nSure then
		local szMsg = "您确定报名参加《剑侠世界》武林第一美女海选比赛吗？";
		local tbOpt = {
			{"确定", self.State1SignUp, self, 1},
			{"我想想看"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	
	GCExcute({"SpecialEvent.Girl_Vote:SignUpBuf", me.szName});
	me.AddTitle(6,6,1,8);
	me.SetCurTitle(6,6,1,8);
	me.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Vote_Girl, GetTime());
	Dialog:Say("你成功报名了美女评选活动。");
	local szMsg = [[报名参加了<color=yellow>“武林第一美女海选”<color>活动，炫目光环面具甚至汽车大奖等着她，大家快去给她捧场啊！]]
	Player:SendMsgToKinOrTong(me, szMsg, 1);
	szMsg = string.format("<color=yellow>%s<color>", me.szName) ..szMsg;
	me.SendMsgToFriend(szMsg);
	KDialog.NewsMsg(0,Env.NEWSMSG_NORMAL, szMsg);		
	return 0;
end

function tbNpc:State1VoteTickets()
	if SpecialEvent.Girl_Vote:CheckState(5, 6) == 1 then
		self:State2VoteTickets();
		return 0;
	end
	
	if SpecialEvent.Girl_Vote:CheckState(2, 4) ~= 1 then
		Dialog:Say("6月23日至6月30日是初选投票，7月9日至7月21日0点是决赛投票，现在不在投票期间。");
		return 0;
	end
	Dialog:AskString("请输入美女名", 16, SpecialEvent.Girl_Vote.State1VoteTickets1, SpecialEvent.Girl_Vote);	
end

function tbNpc:State2VoteTickets(szNextKey)
	local szMsg = "请选择你想投票的美女所在的大区";
	local tbOpt = {
		{"<color=yellow>我们服的十大美女<color>", self.State2VoteTicketsSelectServer, self, GetGatewayName()},
	};
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	if tbBuf.tGList then
		for szZoneName in pairs(tbBuf.tGList) do
			if #tbOpt >= 6 then
				table.insert(tbOpt, {"下一页", self.State2VoteTickets, self, szZoneName});				
				break;
			end
			if not szNextKey then
				table.insert(tbOpt, {szZoneName, self.State2VoteTicketsSelectZone, self, szZoneName});				
			end
			if szNextKey and szNextKey == szZoneName then
				table.insert(tbOpt, {szZoneName, self.State2VoteTicketsSelectZone, self, szZoneName});
				szNextKey = nil;
			end
		end
	end
	table.insert(tbOpt, {"我只是随便看看"});
	Dialog:Say(szMsg, tbOpt);
	return 0;	
end

function tbNpc:State2VoteTicketsSelectZone(szZoneName, szNextKey)
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	if not tbBuf.tGList[szZoneName] then
		return 0;
	end
	local szMsg = "请选择你想投票的美女所在区服";
	local tbOpt = {};
	for szServerName, szGateWay in pairs(tbBuf.tGList[szZoneName]) do
		if #tbOpt >= 6 then
			table.insert(tbOpt, {"下一页", self.State2VoteTicketsSelectZone, self, szZoneName, szServerName});				
			break;
		end
		if not szNextKey then
			table.insert(tbOpt, {szServerName, self.State2VoteTicketsSelectServer, self, szGateWay});					
		end
		if szNextKey and szNextKey == szServerName then
			table.insert(tbOpt, {szServerName, self.State2VoteTicketsSelectServer, self, szGateWay});					
			szNextKey = nil;
		end
	end
	table.insert(tbOpt, {"返回上层", self.State2VoteTickets, self});
	table.insert(tbOpt, {"我只是随便看看"});
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:State2VoteTicketsSelectServer(szGateWay, szNextKey)
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	if not tbBuf.tPList or not tbBuf.tPList[szGateWay] then
		return 0;
	end
	local szZoneName = tbBuf.tZList[szGateWay][1];
	local szMsg = "请选择你想投票的美女";
	local tbOpt = {};
	for szRoleName in pairs(tbBuf.tPList[szGateWay]) do
		if #tbOpt >= 6 then
			table.insert(tbOpt, {"下一页", self.State2VoteTicketsSelectServer, self, szGateWay, szRoleName});				
			break;			
		end
		if not szNextKey then
			table.insert(tbOpt, {szRoleName, SpecialEvent.Girl_Vote.State2VoteTickets1, SpecialEvent.Girl_Vote, szGateWay, szRoleName, 0});		
		end
		if szNextKey and szRoleName == szNextKey then
			table.insert(tbOpt, {szRoleName, SpecialEvent.Girl_Vote.State2VoteTickets1, SpecialEvent.Girl_Vote, szGateWay, szRoleName, 0});		
			szNextKey = nil;
		end
	end
	table.insert(tbOpt, {"返回上层", self.State2VoteTicketsSelectZone, self, szZoneName});
	table.insert(tbOpt, {"我只是随便看看"});
	Dialog:Say(szMsg, tbOpt);	
end

function tbNpc:Query2()
	local szMsg = "查询美女评选决赛信息";
	local tbOpt = {
			{"查询自己信息", self.State2QueryMyName, self},
			{"查询本区服美女信息", self.State2QueryMyServer, self, GetGatewayName()},
			{"查询各区服美女信息", self.State2QueryByZone, self},
			{"结束对话"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:State2QueryMyName()
	local szGateWay = GetGatewayName();
	if SpecialEvent.Girl_Vote:IsHaveGirl2(szGateWay, me.szName) ~= 1 then
		Dialog:Say("对不起，你不是入围决赛的美女玩家。");
		return 0;
	end
	self:State2QueryByName(szGateWay, me.szName)
end

function tbNpc:State2QueryByZone()
	local szMsg ="请选择你想投票的美女所在的大区";
	local tbOpt = {};
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	if tbBuf.tGList then
		for szZoneName in pairs(tbBuf.tGList) do
			table.insert(tbOpt, {szZoneName, self.State2QueryByServer, self, szZoneName});
		end
	end
	table.insert(tbOpt, {"我只是随便看看"});
	Dialog:Say(szMsg, tbOpt);
	return 0;		
end

function tbNpc:State2QueryByServer(szZoneName, szNextKey)
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	if not tbBuf.tGList[szZoneName] then
		return 0;
	end
	local szMsg = "请选择你想查询的美女所在的服务器。";
	local tbOpt = {};
	for szServerName, szGateWay in pairs(tbBuf.tGList[szZoneName]) do
		if #tbOpt >= 6 then
			table.insert(tbOpt, {"下一页", self.State2QueryByServer, self, szZoneName, szServerName});				
			break;			
		end
		if not szNextKey then
			table.insert(tbOpt, {szServerName, self.State2QueryMyServer, self, szGateWay});	
		end
		if szNextKey and szNextKey == szServerName then
			table.insert(tbOpt, {szServerName, self.State2QueryMyServer, self, szGateWay});	
			szNextKey = nil;
		end		
			
	end
	table.insert(tbOpt, {"返回上层", self.State2QueryByZone, self});
	table.insert(tbOpt, {"我只是随便看看"});
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:State2QueryMyServer(szGateWay, szNextKey)
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	if not tbBuf.tPList or not tbBuf.tPList[szGateWay] then
		return 0;
	end
	local szMsg = "请选择你想查看的美女。";
	local szZoneName = tbBuf.tZList[szGateWay][1];
	local tbOpt = {};
	for szRoleName in pairs(tbBuf.tPList[szGateWay]) do
		if #tbOpt >= 6 then
			table.insert(tbOpt, {"下一页", self.State2QueryMyServer, self, szGateWay, szRoleName});				
			break;			
		end
		if not szNextKey then
			table.insert(tbOpt, {szRoleName, self.State2QueryByName, self, szGateWay, szRoleName});		
		end
		if szNextKey and szNextKey == szRoleName then
			table.insert(tbOpt, {szRoleName, self.State2QueryByName, self, szGateWay, szRoleName});		
			szNextKey = nil;
		end
	end
	table.insert(tbOpt, {"返回上层", self.State2QueryByServer, self, szZoneName});
	table.insert(tbOpt, {"我只是随便看看"});
	Dialog:Say(szMsg, tbOpt);		
end

function tbNpc:State2QueryByName(szGateWay, szName)
	if SpecialEvent.Girl_Vote:IsHaveGirl2(szGateWay, szName) ~= 1 then
		Dialog:Say("没有该美女玩家！");
		return 0;
	end
	
	local tbBuf = SpecialEvent.Girl_Vote:GetGblBuf2();
	local tbRole= tbBuf.tPList[szGateWay][szName];
	local nTickets = tbRole[2];
	local szDescGate  = tbBuf.tZList[szGateWay][1];
	local szDescServer= tbBuf.tZList[szGateWay][2];
	local szFans="";
	for i=1, 5 do
		local szFansName = "<color=gray>无粉丝<color>"
		if tbRole[3] and tbRole[3][i] and tbRole[3][i][1] then
		 szFansName = tbRole[3][i][1]
		end
		local nFansTickets = 0;
		if tbRole[3] and tbRole[3][i] and tbRole[3][i][2] then
		 nFansTickets = tbRole[3][i][2]
		end		
		szFans = szFans .. string.format("本服第%s粉丝：<color=white>%s<color> 票数：<color=white>%s<color>\n", i, szFansName, nFansTickets);
	end
	
	local szMyTickets 	= "";
	if szGateWay ~= GetGatewayName() or szName ~= me.szName then
		local nUseTask		= SpecialEvent.Girl_Vote:GetTaskGirlVoteId2(szGateWay, szName);
		local nMyTickets	= me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, (nUseTask+4));
		szMyTickets = string.format("我的投票数：<color=white>%s<color>", nMyTickets);
	end

	local szMsg = string.format([[
		<color=green>------美女玩家投票明细------
		
美女玩家：<color=white>%s<color>
大    区：<color=white>%s<color>
服 务 器：<color=white>%s<color>
		
总 排 名：<color=white>请查看剑侠日报或官方网站<color>
总 票 数：<color=white>请查看剑侠日报或官方网站<color>
本服票数：<color=white>%s<color>
		
%s
		
%s
<color>
	]], szName, szDescGate, szDescServer, nTickets, szFans, szMyTickets);
	Dialog:Say(szMsg, {{"返回上层", self.Query, self},{"结束对话"}});
end
