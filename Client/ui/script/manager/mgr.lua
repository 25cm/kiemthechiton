
local tbMgr = UiManager;

tbMgr.WND_MAIN						= "Main";

tbMgr.VK_SHIFT						= 16;
tbMgr.VK_CONTROL					= 17;

tbMgr.UIS_TRADE_PLAYER				= 1;		-- （与Player）交易
tbMgr.UIS_TRADE_NPC					= 2;		-- （与npc）交易
tbMgr.UIS_TRADE_SELL				= 3;		-- （与npc）交易	卖
tbMgr.UIS_TRADE_BUY					= 4;		-- （与npc）交易	买
tbMgr.UIS_TRADE_REPAIR				= 5;		-- （与npc）交易	修理
tbMgr.UIS_TRADE_REPAIR_EX			= 6;		-- （与npc）交易	特修
tbMgr.UIS_STALL_BUY					= 7;		-- 摆摊:(买方)处于买东西状态
tbMgr.UIS_STALL_SETPRICE			= 8;		-- 对自己的物品进行标价
tbMgr.UIS_OFFER_SELL	  			= 9;		-- 摆摊:(卖方)处于卖东西状态
tbMgr.UIS_OFFER_SETPRICE			= 10;		-- 对自己的物品进行标价
tbMgr.UIS_ACTION_VIEWITEM   		= 11;
tbMgr.UIS_ACTION_FOLLOW     		= 12;
tbMgr.UIS_ACTION_MAKEFRIEND 		= 13;
tbMgr.UIS_ACTION_TRADE      		= 14;
tbMgr.UIS_ITEM_REPAIR       		= 15;       -- 使用物品修理
tbMgr.UIS_ACTION_GIFT       		= 16;		-- 打开给与界面
tbMgr.UIS_BEGIN_STALL				= 17;		-- 开始叫卖
tbMgr.UIS_BEGIN_OFFER				= 18;		-- 开始收购
tbMgr.UIS_OPEN_REPOSITORY			= 19;		-- 打开储物箱
tbMgr.UIS_ITEM_SPLIT				= 20;		-- 道具拆分
tbMgr.UIS_MAIL_NEW					= 21;		-- 新建信件
tbMgr.UIS_EQUIP_BREAKUP				= 22;		-- 装备拆解
tbMgr.UIS_EQUIP_ENHANCE				= 23;		-- 装备强化
tbMgr.UIS_EQUIP_PEEL				= 24;		-- 玄晶剥离
tbMgr.UIS_EQUIP_COMPOSE				= 25;		-- 玄晶合成
tbMgr.UIS_EQUIP_UPGRADE				= 26;		-- 印鉴升级
tbMgr.UIS_EQUIP_REFINE				= 27;		-- 装备炼化
tbMgr.UIS_EQUIP_STRENGTHEN			= 28;		-- 装备改造
tbMgr.UIS_IBSHOP_CART				= 29;		-- 奇珍阁购物车
tbMgr.UIS_ZHENYUAN_XIULIAN			= 30;		-- 真元修炼
tbMgr.UIS_ZHENYUAN_REFINE			= 31;		-- 真元炼化
tbMgr.UIS_EQUIP_TRANSFER			= 32;		-- 强化转移
tbMgr.UIS_EQUIP_RECAST				= 33;		-- 装备重铸
tbMgr.UIS_CAPTURE_SCREEN			= 34;		-- 等待开始截图状态
tbMgr.UIS_CAPTURE_SCREEN_SELECTING	= 35;		-- 截图已开始，等待选择区域状态
tbMgr.UIS_CAPTURE_SCREEN_DONE		= 36;		-- 截图已完成，区域已选定
tbMgr.UIS_SWITCH_EQUIP_SERIES		= 37;		-- 转装备五行UI状态
tbMgr.UIS_HOLE_MAKEHOLE				= 38;		-- 装备打孔
tbMgr.UIS_HOLE_MAKEHOLEEX			= 39;		-- 高级装备打孔
tbMgr.UIS_HOLE_ENCHASE				= 40;		-- 镶嵌宝石
tbMgr.UIS_STONE_EXCHAGNE			= 41;		-- 宝石兑换界面状态
tbMgr.UIS_STONE_UPGRADE				= 42;		-- 宝石升级鼠标状态
tbMgr.UIS_STONE_BREAK_UP			= 43;		-- 宝石拆解
tbMgr.UIS_WEAPON_PEEL				= 44;		--青铜武器剥离
tbMgr.UIS_STALL_SALE				= 45;		-- 摆摊贩卖价格设置
tbMgr.UIS_OFFER_BUY					= 46;		-- 摆摊收购价格设置
tbMgr.UIS_RESTART_DOWNLOADER		= 47;		-- 重启downloader界面状态

tbMgr.tbMouseText	= {
	[tbMgr.UIS_CAPTURE_SCREEN]			    = "<color=170,230,130><color=yellow>Nhấp chuột phải<color> bắt đầu chụp hình";
	[tbMgr.UIS_CAPTURE_SCREEN_SELECTING]    = "<color=170,230,130><color=yellow>Nhấn giữ chuột trái rồi rê chuột<color> để chọn khu vực";
	[tbMgr.UIS_CAPTURE_SCREEN_DONE]		    = "<color=170,230,130><color=yellow>Nhấp đôi chuột trái<color> để hoàn thành<enter><color=yellow>Nhấp chuột phải<color> để chọn lại";
};

tbMgr.emACTION_CHAT				    = 0;
tbMgr.emACTION_MAKEFRIEND			= 1;
tbMgr.emACTION_TRADE				= 2;
tbMgr.emACTION_JOINTEAM			    = 3;
tbMgr.emACTION_INVITETEAM			= 4;
tbMgr.emACTION_FOLLOW				= 5;
tbMgr.emACTION_VIEWITEM			    = 6;
tbMgr.emACTION_TONG				    = 7;
tbMgr.emACTION_APPLY_TONG			= 8;
tbMgr.emACTION_BLACKLIST			= 9;
tbMgr.emACTION_REVENGE				= 10;
tbMgr.emACTION_GIVE_MONEY			= 11;
tbMgr.emACTION_FILTER_WORLD_CHANNEL = 12;
tbMgr.emACTION_LEAVETEAM			= 13;
tbMgr.emACTION_KICKOUT				= 14;
tbMgr.emACTION_ORIENTATION			= 15;
tbMgr.emACTION_INVITEEXERCISE		= 16;
tbMgr.emACTION_VIEWSKILL			= 21;


tbMgr.tbPreFix = {"jxsj", "js", "kinsoft", "jw", "xoyo", "www"};

tbMgr.tbAccurateDomainName = {"tm", "mm", "jp", "tr", "bb", "is","cy", "sb", "pk"};

tbMgr.tbDomainName = {"org","edu","sex","com","net","vn","cn","au","fr","kr","my","us","ca","af",
	"al","as","ad","ao","ai","aq","ag","ar","am","aw","at","az","bs","bh","bd","by","be","bz","bj",
	"bm","bt","bo","ba","bw","bv","br","io","bn","bg","govbf","bi","kh","cm","cv","ky","cf","td","cl","cx",
	"cc","co","cd","ck","cr","hr","cu","cz","dk","dj","dm","do","tp","ec","eg","sv","gq","er","ee",
	"et","fk","fo","fj","fi","tf","ga","gm","ge","de","gh","gi","gr","gl","gd","gp","gu","gt","gn","gy",
	"ht","hm","hn","hk","hu","in","id","ir","iq","ie","il","it","ci","jm","jo","kz","coke","ki","kw",
	"kg","la","lv","lb","ls","lr","ly","li","lt","lu","mo","mk","mg","mw","mv","ml","mt","mq","mr","mu","yt",
	"mx","fm","md","mc","mn","ms","ma","comz","na","nr","np","nl","an","nc","conz","ni","ne","ng","nu",
	"nf","mp","no","om","pw","pa","pg","py","pe","ph","pn","pl","pf","pt","pr","pa","re","ro","ru","rw",
	"sg","sh","kn","lc","st","vc","sm","sa","sn","sc","sl","sg","sk","si","so","coza","cokr","es","lk",
	"sd","sr","sj","sz","se","sy","tj","tw","tz","th","tg","tk","to","tt","tn","tc","tv","ug","ua",
	"uk","uy","uz","va","ve","vg","ws","ye","yu","zm","zw","gov","info","biz", "name"};
 
tbMgr.tbFrequencyDomainName = {"com", "org", "net", "cn", "cc", "info", "tv", "us", "biz", "mobi", "it"};
tbMgr.bEditBlogState = -1;
tbMgr.bForceSend	= 0;	-- 强制映射
tbMgr.tbAfterPaintCallBack	= {};

function tbMgr:Init()
	self.nAutoSelectNpc	= 0;			-- 自动选中Npc模式
	self.nCurLockNpc	= 0;			-- 当前锁定NpcIndex（自动模式时）
	self.nCurUiModel	= 0;
	self.nEnterTime		= 0;			-- 进入游戏时的时间
	self.bAgreementFlag	= 0;
	self.tbUiState    	= {};			-- UI状态组
end


function tbMgr:OpenWindow(szUiGroup, ...)
	local tbWnd = Ui(szUiGroup);
	if (not tbWnd) then
		return;
	end
	if (self:WindowVisible(szUiGroup) == 1) then
		self:CloseWindow(szUiGroup, unpack(arg));		-- 已经打开则需要先执行关闭
	end
	local nRetCode = 1;
	
	if tbWnd.PreOpen then
		nRetCode = tbWnd:PreOpen(unpack(arg)) or 1;
	end
	
	if nRetCode ~= 1 then
		return;
	end
	
	if tbWnd.OnOpen then
		nRetCode = tbWnd:OnOpen(unpack(arg)) or 1;		-- 打开前
	end
	if nRetCode == 1 then
		Wnd_Show(szUiGroup, self.WND_MAIN);
		UiNotify:OnNotify(UiNotify.emUIEVENT_WND_OPENED, szUiGroup);
	else
		self:CloseWindow(szUiGroup, unpack(arg));		-- 打开失败要执行关闭操作
	end
	self:OnActiveWnd(szUiGroup, 1);
	UiNotify:OnNotify(UiNotify.emUIEVENT_WND_ACTIVED, szUiGroup);
	return nRetCode;
end

function tbMgr:CloseWindow(szUiGroup, ...)
	if (self:WindowVisible(szUiGroup) ~= 1) then
		return;											-- 已经关闭了就什么都不做
	end
	local tbWnd = Ui(szUiGroup);
	if (not tbWnd) then
		return;
	end
	if tbWnd.OnClose then
		tbWnd:OnClose(unpack(arg));						-- 关闭前
	end
	if tbWnd.Init then
		tbWnd:Init();									-- 存在初始化函数则调用之
	end
	self:WindowReset(szUiGroup);						-- 复位整个窗口的控件
	if (1 ~= LoadWndConfig(szUiGroup)) then							-- 复位窗口设置
		Ui:LoadExWndConfig(szUiGroup);
	end
	Wnd_Hide(szUiGroup, self.WND_MAIN);
	UiNotify:OnNotify(UiNotify.emUIEVENT_WND_CLOSED, szUiGroup);
end

function tbMgr:SwitchWindow(szUiGroup, ...)
	if self:WindowVisible(szUiGroup) ~= 1 then
		self:OpenWindow(szUiGroup, unpack(arg));
	else
		self:CloseWindow(szUiGroup, unpack(arg));
	end
end

function tbMgr:WindowVisible(szUiGroup)
	return Wnd_Visible(szUiGroup, self.WND_MAIN);
end

function tbMgr:WindowReset(szUiGroup)
	return Wnd_Reset(szUiGroup, self.WND_MAIN);
end

function tbMgr:MoveWindow(szUiGroup, nX, nY)
	return Wnd_SetPos(szUiGroup, self.WND_MAIN, nX, nY);
end

function tbMgr:SetExclusive(szUiGroup, bSet)
	Wnd_SetExclusive(szUiGroup, self.WND_MAIN, bSet);
end

function tbMgr:SwitchUiModel(nModel)

	if nModel then
		self.nCurUiModel = nModel;
	else
		self.nCurUiModel = math.mod(self.nCurUiModel + 1, 3);
	end

	if self.nCurUiModel == 0 then
		local tbTempData = Ui.tbLogic.tbTempData;
		Open("map", tbTempData.nMiniMapState + 5); -- TODO: huangxin +5 为了把状态0 和参数0区分开 非常龊 会整理
		Open("playerbar", 1);
		self:OpenWindow(Ui.UI_POPBAR);
		self:OpenWindow(Ui.UI_SIDEBAR);
		self:OpenWindow(Ui.UI_SKILLBAR);
		self:OpenWindow(Ui.UI_SHORTCUTBAR);
		self:OpenWindow(Ui.UI_PLAYERSTATE);
		self:OpenWindow(Ui.UI_BUFFBAR);
		self:OpenWindow(Ui.UI_TASKTRACK);
		self:OpenWindow(Ui.UI_SERVERSPEED);
		if (self:WindowVisible(Ui.UI_MSGPAD) ~= 1) then
			self:OpenWindow(Ui.UI_MSGPAD);
		end
		if (self:WindowVisible(Ui.UI_GLOBALCHAT) ~= 1) then
			self:OpenWindow(Ui.UI_GLOBALCHAT);
		end
	elseif self.nCurUiModel == 1 then
		Open("map", 0);
		Open("playerbar", 0);
		self:CloseWindow(Ui.UI_POPBAR);
		self:OpenWindow(Ui.UI_SIDEBAR);
		self:OpenWindow(Ui.UI_SKILLBAR);
		self:OpenWindow(Ui.UI_SHORTCUTBAR);
		self:OpenWindow(Ui.UI_PLAYERSTATE);
		self:OpenWindow(Ui.UI_BUFFBAR);
		self:CloseWindow(Ui.UI_TASKTRACK);
		self:CloseWindow(Ui.UI_SERVERSPEED);
		self:CloseWindow(Ui.UI_GLOBALCHAT);
		UiCallback:HideMsgPad()
	elseif self.nCurUiModel == 2 then
		Open("map", -1);
		self:CloseWindow(Ui.UI_POPBAR);
		self:CloseWindow(Ui.UI_SIDEBAR);
		self:CloseWindow(Ui.UI_SKILLBAR);
		self:CloseWindow(Ui.UI_SHORTCUTBAR);
		self:CloseWindow(Ui.UI_PLAYERSTATE);
		self:CloseWindow(Ui.UI_BUFFBAR);
		self:CloseWindow(Ui.UI_TASKTRACK);
		self:CloseWindow(Ui.UI_GLOBALCHAT);
		UiCallback:HideMsgPad()
	end

end


function tbMgr:OnActiveWnd(szUiGroup, nAction)
	if nAction > 0 then
		Wnd_BringTop(szUiGroup, self.WND_MAIN);
	end
end

function tbMgr:OnLButtonDown()

	local tbMouse = Ui.tbLogic.tbMouse;
	if (tbMouse:ThrowAway() == 1) then
		return;
	end

	local nRetCode = 0;

	if self:GetUiState(self.UIS_ACTION_VIEWITEM) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_VIEWITEM);
	elseif self:GetUiState(self.UIS_ACTION_FOLLOW) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_FOLLOW);
	elseif self:GetUiState(self.UIS_ACTION_MAKEFRIEND) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_MAKEFRIEND);
	elseif self:GetUiState(self.UIS_ACTION_TRADE) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_TRADE);
	elseif self:GetUiState(self.UIS_TRADE_PLAYER) == 1 then
	elseif self:GetUiState(self.UIS_TRADE_NPC) == 1 then
	elseif self:GetUiState(self.UIS_STALL_BUY) == 1 then
	elseif self:GetUiState(self.UIS_OFFER_SELL) == 1 then
	elseif self:GetUiState(self.UIS_ACTION_GIFT) == 1 then
	else
		local nNpcIndex	= Mouse_Action()	-- 默认鼠标左键点击事件，返回选中的nNpcIndex
		if (self.nAutoSelectNpc ~= 1) then
			UiSelectNpc(nNpcIndex or 0);
		end
	end

	if nRetCode == 1 then
		uiPopBar:ReleaseAllAction();
	end

end

function tbMgr:OnRButtonDown()
	if (self:GetUiState(self.UIS_ACTION_VIEWITEM) == 1) or (self:GetUiState(self.UIS_ACTION_FOLLOW) == 1) or
	(self:GetUiState(self.UIS_ACTION_MAKEFRIEND) == 1) or (self:GetUiState(self.UIS_ITEM_REPAIR) == 1) or
	(self:GetUiState(self.UIS_ACTION_TRADE) == 1) then
		Ui(Ui.UI_POPBAR):ReleaseAllAction();
	else
		Mouse_Force1();	-- 默认鼠标右键点击事件
	end
end

function tbMgr:OnPressESC()
	if (self:WindowVisible(Ui.UI_WORLDMAP_SUB) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_SUB)
		return;
	elseif (self:WindowVisible(Ui.UI_WORLDMAP_AREA) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_AREA)
		return;
	elseif (self:WindowVisible(Ui.UI_WORLDMAP_GLOBAL) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_GLOBAL)
		return;
	end

	if (self:WindowVisible(Ui.UI_WORLDMAP_DOMAIN) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_DOMAIN)
		return;
	end
	
	if (self:WindowVisible(Ui.UI_TEXTINPUT) == 1) then
		self:CloseWindow(Ui.UI_TEXTINPUT)
		return
	end

	if (self:WindowVisible(Ui.UI_JBEXCHANGE) == 1) then
		self:CloseWindow(Ui.UI_JBEXCHANGE)
		return
	end

	if (self:WindowVisible(Ui.UI_IBSHOPCART) == 1) then
		self:CloseWindow(Ui.UI_IBSHOPCART)
		return
	end

	if (self:WindowVisible(Ui.UI_IBSHOP) == 1) then
		self:CloseWindow(Ui.UI_IBSHOP)
		return
	end
	
	if (CloseWndsInGame() == 0 and self:WindowVisible(Ui.UI_ITEMBOX) == 0) then
		if (self:WindowVisible(Ui.UI_SKILLPROGRESS) == 0) then
			self:SwitchWindow(Ui.UI_SYSTEM);
		else
			me.BreakProcess();
		end
	end
	
	if (self:WindowVisible(Ui.UI_ITEMBOX) == 1) then
		self:CloseWindow(Ui.UI_ITEMBOX);
		return;
	end

end

function tbMgr:OnReadyEsc()
	if (self:WindowVisible(Ui.UI_SYSTEM) ~= 0) then
		self:CloseWindow(Ui.UI_SYSTEM);
		return;
	end
	CloseWndsInGame();
	me.BreakProcess();
	self:SwitchWindow(Ui.UI_SYSTEM);
end

function tbMgr:OnMessage(nMsg, szUiGroup, szWnd, ...)

	local tbWnd = Ui(szUiGroup);
	if (not tbWnd) or (type(tbWnd) ~= "table") then
		return;
	end
	local fnReg = tbWnd.RegisterMessage;
	if (type(fnReg) == "function") then
		local tbReg = fnReg(tbWnd);
		for _, tb in ipairs(tbReg) do
			if (nMsg == tb[1]) and (szWnd == tb[2]) and tb[3] then
				tb[3](tb[4] or tbWnd, unpack(arg));
			end
		end
	end

	local szFunc = self.tbMsg[nMsg];
	if (not szFunc) then
		return;
	end

	local fnFunc = tbWnd[szFunc];
	if (type(fnFunc) == "function") then
		fnFunc(tbWnd, szWnd, unpack(arg));
	end

end

function tbMgr:OnEnterGame()
	self:SwitchUiModel(0);
	Player.tbGlobalFriends:Init();
	ForbitGameSpace(0);
	self:OpenWindow(Ui.UI_NEWSMSG);
	self:OpenWindow(Ui.UI_SERVERSPEED);
	self:OpenWindow(Ui.UI_GLOBALCHAT);
	self:OpenWindow(Ui.UI_GLOBALCHATBUY);
	self.nEnterTime	= GetTime();
	
	if self.IVER_nOpenDaily == 1 then			-- 马来版不要日报
		if IsDailyOpen() == 1 then
			Ui.tbLogic.tbDaily:OnStart(); 
		end
	end
	
	Ui.tbLogic.tbPassPodTime:OnStart();
	Ladder:ClearLadder();
	Player.tbOnlineExp:OnStartCheckOnlineExpState();
	
	Ui(Ui.UI_SYSTEM)._no_name_or_life = 1; -- 将禁止显示血条的功能关掉
	Ui(Ui.UI_SYSTEM):Update();
	
	Ui(Ui.UI_SKILLBAR)._disable_switch_skill = nil;
	Ui.tbLogic.tbMsgChannel:LoadChannelSetting();
end

function tbMgr:OnLeaveGame()
	ForbitGameSpace(0);
	Open("map", -1);
	Open("chatroom", 0);
	Open("playerbar", 0);
	for i, _ in pairs(Ui.tbWnd) do
		self:CloseWindow(i);	-- 关闭所有窗口
	end
	self:ClearUiState();			-- 清除UI状态
	SetCursorImageIdx(Ui.CURSOR_NORMAL);	-- 恢复鼠标形状
	Player.tbOnlineExp:OnEndCheckOnlineExpState();
end


function tbMgr:SetUiState(nState)
	if self.tbUiState[nState] ~= 1 then   -- 有可能为nil
		self.tbUiState[nState] = 1;
		Ui:Output("[INF] SetUiState("..nState..") --> "..self.tbUiState[nState]);
		self:OnSwitchUiState(nState);
	else
		Ui:Output("[INF] SetUiState("..nState..") == "..self.tbUiState[nState]);
	end
end

function tbMgr:ReleaseUiState(nState)
	if self.tbUiState[nState] == 1 then
		self.tbUiState[nState] = 0;
		Ui:Output("[INF] ReleaseUiState("..nState..") --> "..self.tbUiState[nState]);
		self:OnSwitchUiState(nState);
	end
end

function tbMgr:ClearUiState()
	self.tbUiState = {};
end

function tbMgr:IsIdleState()
	for i,v in pairs(self.tbUiState) do
		if (v == 1) then
			return 0;
		end
	end
	return 1;
end

function tbMgr:GetUiState(nState)
	if self.tbUiState[nState] == 1 then
		return 1;
	end
	return 0;
end


function tbMgr:ReleaseMouseState()
	self:ReleaseUiState(self.UIS_STALL_SETPRICE);
	self:ReleaseUiState(self.UIS_OFFER_SETPRICE);
	self:ReleaseUiState(self.UIS_ITEM_SPLIT);	
	self:ReleaseUiState(self.UIS_TRADE_SELL);	
	self:ReleaseUiState(self.UIS_TRADE_BUY);
	self:ReleaseUiState(self.UIS_ITEM_REPAIR);
	self:ReleaseUiState(self.UIS_TRADE_REPAIR);
	self:ReleaseUiState(self.UIS_TRADE_REPAIR_EX);	
	Ui(Ui.UI_ITEMBOX):UpdateBtnState();
	Ui(Ui.UI_SHOP):UpdateBtnState();
end

function tbMgr:SwitchUiState(nState)
	if self:GetUiState(nState) == 1 then
		self:ReleaseUiState(nState);
	else
		self:SetUiState(nState);
	end
	return self.tbUiState[nState];
end

function tbMgr:OnSwitchUiState(nState)
	if (self:GetUiState(self.UIS_TRADE_PLAYER) == 1) or (self:GetUiState(self.UIS_TRADE_NPC) == 1) or
	(self:GetUiState(self.UIS_STALL_BUY) == 1) or (self:GetUiState(self.UIS_STALL_SETPRICE) == 1) or
	(self:GetUiState(self.UIS_OFFER_SELL) == 1) or (self:GetUiState(self.UIS_OFFER_SETPRICE) == 1) or
	(self:GetUiState(self.UIS_BEGIN_STALL) == 1) or (self:GetUiState(self.UIS_BEGIN_OFFER) == 1) or
	(self:GetUiState(self.UIS_ACTION_GIFT) == 1) or (self:GetUiState(self.UIS_OPEN_REPOSITORY) == 1) or
	(self:GetUiState(self.UIS_EQUIP_ENHANCE) == 1) or (self:GetUiState(self.UIS_EQUIP_PEEL) == 1) or
	(self:GetUiState(self.UIS_EQUIP_COMPOSE) == 1) or (self:GetUiState(self.UIS_EQUIP_UPGRADE) == 1) or
	(self:GetUiState(self.UIS_EQUIP_REFINE) == 1) or (self:GetUiState(self.UIS_EQUIP_STRENGTHEN) == 1) or
	(self:GetUiState(self.UIS_HOLE_MAKEHOLE) == 1) or (self:GetUiState(self.UIS_HOLE_MAKEHOLEEX) == 1) or
	(self:GetUiState(self.UIS_STONE_EXCHAGNE) == 1) or (self:GetUiState(self.UIS_STONE_BREAK_UP) == 1) or
	(self:GetUiState(self.UIS_HOLE_ENCHASE) == 1) or
	(self:GetUiState(self.UIS_EQUIP_TRANSFER) == 1) or (self:GetUiState(self.UIS_EQUIP_RECAST) == 1) or
	(self:GetUiState(self.UIS_SWITCH_EQUIP_SERIES) == 1) or (self:GetUiState(self.UIS_WEAPON_PEEL) == 1) or
	(self:GetUiState(self.UIS_RESTART_DOWNLOADER) == 1)	then
		ForbitGameSpace(1);
	else
		ForbitGameSpace(0);
	end
	Ui(Ui.UI_ITEMBOX):UpdateBtnState();
	Ui.tbLogic.tbMouse:OnStateChanged(nState);
end

function tbMgr:ChangeAutoSelect()
	if (self.nAutoSelectNpc == 1) then
		self.nAutoSelectNpc	= 0;
	else
		self.nAutoSelectNpc	= 1;
	end
	self.nCurLockNpc	= 0;
	UiAutoSelect(self.nAutoSelectNpc);
end

function tbMgr:LockCurSelect()
	if (self.nAutoSelectNpc ~= 1) then	-- 非自动选中模式下不支持快捷键
		return;
	end
	if (self.nCurLockNpc ~= 0) then
		self.nCurLockNpc	= UiSelectNpc(0);
	else
		self.nCurLockNpc	= UiSelectNpc();
	end
	if (self.nCurLockNpc ~= 0) then	-- 锁定成功取消自动选中
		UiAutoSelect(0);
	else
		UiAutoSelect(1);
	end
end

function tbMgr:RegistEvent()
	for _, tbWnd in pairs(Ui.tbWnd) do
		if tbWnd.RegisterEvent then
			local tbReg = tbWnd:RegisterEvent();
			for _, tbEvent in pairs(tbReg) do
				UiNotify:RegistNotify(tbEvent[1], tbEvent[2], tbEvent[3] or tbWnd);
			end
		end
	end
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_UI_INPUT,			self.OnTextInput,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_SHOW_MAILCONTENT, 	self.OpenMailView,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_ITEMGIFT_OPEN,		self.OpenItemGift,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_ENHANCE_OPEN,		self.OpenItemEnhance,	self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_PREPARE_ITEMREPAIR, 	self.PrepareItemRepair,	self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYSTEM_MESSAGE,		self.OnSystemMsg,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_STOPLOGOUT,			self.OnStopLogout,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_TASK_SHOWBOARD,		self.OnShowInfoBoard,	self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_PROGRESSBAR_TIMER,	self.StartProgress,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_OPEN_KINCREATE,		self.OpenKinCreate,		self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_OPEN_TONGCREATE,		self.OpenTongCreate,	self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_SELECT_NPC,		self.OnSyncSelectNpc,	self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_CONFIRMATION, 		self.OnConfirm, 		self);
end

function tbMgr:UseItem(pItem)

	if (self:IsIdleState() ~= 1) then
		return;
	end

	if (pItem.IsEquip() == 1) and (me.CanUseItem(pItem) ~= 1) then
		me.UseItem(pItem);				-- 不能是使用的装备也发协议，因为可能可以改变装备的
		return;
	end
	
	if (not pItem) or (me.CanUseItem(pItem) ~= 1) then
		return;							-- 不能使用
	end

	if (pItem.IsEquip() ~= 1) then
		me.UseItem(pItem);				-- 使用的不是装备
		return;
	end
	
	local nEquipPos = pItem.nEquipPos;
	local nRoom = Item.ROOM_EQUIP;
	if (nEquipPos >= Item.EQUIPPOS_NUM) then
		nRoom = Item.ROOM_PARTNEREQUIP;
		nEquipPos = pItem.nEquipPos - Item.EQUIPPOS_NUM;
		
		if (me.nPartnerCount == 0) then
			me.Msg("Hiện tại ngươi không có đồng hành, không thể mặc trang bị đồng hành!");
			return;
		end	
	end
		
	local pCurEquip = me.GetItem(nRoom, nEquipPos, 0)
	if pCurEquip then
		if me.IsAccountLock() == 1 then
			me.Msg("Bạn đang ở trạng thái khóa, không thể tách trang bị trên người");
			return;
		end
	end
	
	if (pItem.nBindType == Item.BIND_NONE) or (pItem.IsBind() == 1) then
		me.UseItem(pItem);				-- 已经绑定或不需要绑定
		return;
	end

	local tbMsg = {};
	tbMsg.szMsg = "Trang bị sẽ khóa, sau khi khóa không thể vứt bỏ và giao dịch với người chơi khác, khóa không?";
	tbMsg.nOptCount = 2;
	function tbMsg:Callback(nOptIndex, pItem)
		if (nOptIndex == 2) and pItem then
			me.UseItem(pItem);
		end
	end

	self:OpenWindow(Ui.UI_MSGBOX, tbMsg, pItem);

end

function tbMgr:OnTextInput(nType, szTitle, nMax)
	local tbParam = {};
	tbParam.tbTable	  = nil;
	tbParam.fnAccept  = nil;
	tbParam.szTitle	  = szTitle;
	tbParam.szDefault = "";
	tbParam.nType	  = nType;
	tbParam.tbRange   = {0, nMax};
	if nMax <= 0 then
		tbParam.tbRange   = {0, nil};
	end	
	self:OpenWindow(Ui.UI_TEXTINPUT, tbParam);
end

function tbMgr:OpenMailView()
	self:OpenWindow(Ui.UI_MAILVIEW);
end

function tbMgr:OpenItemGift(szTable)
	local tbGift = KLib.GetValByStr(szTable);
	if (not tbGift) or (type(tbGift) ~= "table") then
		error("Vô hiệu cho giao diện đối tượng!");
		self:CloseWindow(Ui.UI_ITEMGIFT);
		return;
	end
	self:OpenWindow(Ui.UI_ITEMBOX);
	self:OpenWindow(Ui.UI_ITEMGIFT, tbGift);
end

function tbMgr:OpenItemEnhance(nMode, nMoneyType)
	self:OpenWindow(Ui.UI_EQUIPENHANCE, nMode, nMoneyType);
end

function tbMgr:OnSystemMsg(szMsg)
	SysMsg(szMsg);	-- 实现了 me.Msg
end

function tbMgr:GetLinkText(szUiGroup, szWnd, szLink)
	return self:_CallLinkClassFun(szUiGroup, szWnd, szLink, "GetText") or szLink;
end

function tbMgr:GetLinkTip(szUiGroup, szWnd, szLink)
	return self:_CallLinkClassFun(szUiGroup, szWnd, szLink, "GetTip") or "";
end

function tbMgr:OnLinkClick(szUiGroup, szWnd, szLink)
	self:_CallLinkClassFun(szUiGroup, szWnd, szLink, "OnClick");
end

function tbMgr:_CallLinkClassFun(szUiGroup, szWnd, szLink, szFuncName)
	local szType	= szLink;
	local szLinkData= "";
	
	local nAt	= string.find(szLink, ":");

	if (nAt) then
		szType		= string.sub(szLink, 1, nAt - 1);
		szLinkData	= string.sub(szLink, nAt + 1);
	end
	
	local tbWnd			= Ui(szUiGroup);
	if (tbWnd) then
		local fnFunc	= tbWnd["Link_"..szType.."_"..szFuncName]
		if (fnFunc) then
			return fnFunc(tbWnd, szWnd, szLinkData);
		end
	end

	local tbClass		= self.tbLinkClass[szType];
	if (not tbClass) then
		return;
	end

	local fnFunc		= tbClass[szFuncName];
	assert(fnFunc);

	return fnFunc(tbClass, szLinkData);
end

function tbMgr:OnNoOperation()
	if (Player.tbOffline:CanSleep() == 1) then
		ExitGame();
	end
end

function tbMgr:PrepareItemRepair()
	if me.nAutoFightState == 1 then
		return;
	end
	self:SetUiState(self.UIS_ITEM_REPAIR);
	self:OpenWindow(Ui.UI_PLAYERPANEL);
end

function tbMgr:OnStopLogout()
	Ui.nExitMode = Ui.EXITMODE_NONE;
end

function tbMgr:OnShowInfoBoard(szMsg)
	self:OpenWindow(Ui.UI_INFOBOARD, szMsg);
end

function tbMgr:StartProgress()
	self:OpenWindow(Ui.UI_SKILLPROGRESS);
end

function tbMgr:OpenKinCreate()
	self:OpenWindow(Ui.UI_KINCREATE, 0);
end

function tbMgr:OpenTongCreate()
	self:OpenWindow(Ui.UI_KINCREATE, 1);
end

function tbMgr:OnSyncSelectNpc()
	local pNpc = me.GetSelectNpc();
	if pNpc then
		self:OpenWindow(Ui.UI_SELECTNPC, pNpc);
	else
		self:CloseWindow(Ui.UI_SELECTNPC);
	end
end

function tbMgr:OnConfirm(nCfmId, ...)
	local tbConfirm = Ui.tbLogic.tbConfirm;
	tbConfirm:OnConfirm(nCfmId, unpack(arg));
end

function tbMgr:CheckNeedAddWarring(szMsg)
	szMsg = Lib:Convert2Semiangle(szMsg);	-- 全角->半角
	szMsg = string.lower(szMsg);			-- 大写->小写
	szMsg = self:FilterGameInfo(szMsg);		-- 滤去游戏定义的特殊
	return self:__HaveDoubtfulInfo(szMsg);
end

function tbMgr:FilterGameInfo(szMsg, tbGameInfo)
	szMsg = string.gsub(szMsg, "<item=[^>]*>", "");
	szMsg = string.gsub(szMsg, "<pic=[^>]*>", "");
	szMsg = string.gsub(szMsg, "<color=[^>]*>", "");
	
	return szMsg;
end

function tbMgr:__Filter(szSrcStr)
	local nStrLen = string.len(szSrcStr);
	local szDesStr	= "";
	local nIter 	= 1;
	
	while(nIter <= nStrLen) do
		if (string.byte(szSrcStr, nIter) > 128) then
			nIter = nIter + 2;
		else
			local nChar = string.byte(szSrcStr, nIter);
			if ((nChar >= string.byte("a") and nChar <= string.byte("z")) or 
				(nChar >= string.byte("0") and nChar <= string.byte("9")) or 
				nChar == string.byte(".") or nChar == string.byte("@")) then
				szDesStr = szDesStr..string.sub(szSrcStr, nIter, nIter);
			end
			
			nIter = nIter + 1;
		end
	end
	
	return szDesStr;
end

function tbMgr:__HaveDoubtfulInfo(szMsg)
	if (self:HaveMaskInfo(szMsg) == 1) then
		return 2;
	end
	
	if (self:HaveNumberInfo(szMsg) == 1) then
		return 1;
	end
	
	if (self:HaveDomainName(szMsg) == 1) then
		return 1;
	end
	
	szMsg = self:__Filter(szMsg);			-- 过滤无用符号，只剩字母和数字
	if (self:HaveSiteInfo(szMsg) == 1) then
		return 1;
	end	
	
	if (self:HaveEmailInfo(szMsg) == 1) then
		return 1;
	end
	
	return 0;
end

function tbMgr:HaveMaskInfo(szMsg)
	szMsg = string.gsub(szMsg, "0", "o");
	szMsg = string.gsub(szMsg, " ", "");
	for _, szPostfix in ipairs(self.tbFrequencyDomainName) do
		if (string.find(szMsg, "%w*[%..]"..szPostfix)) then
			return 1;	
		end
	end
end

function tbMgr:HaveDomainName(szMsg)
	szMsg = string.gsub(szMsg, "0", "o");
	szMsg = string.gsub(szMsg, " ", "");
	if (string.find(szMsg, "%a+[%..]%a%a+")) then
		return 1;
	end
	
	for _, szPrifix in ipairs(self.tbPreFix) do
		if (string.find(szMsg, szPrifix.."%w*[%..]")) then
			return 1;
		end
	end
	for _, szDomainName in ipairs(self.tbAccurateDomainName) do
		if (string.find(szMsg, "[.,:_,.~]"..szDomainName.."%A") or string.find(szMsg, "[.,:_,.~]"..szDomainName.."$")) then
			return 1;
		end
	end
	for _, szDomainName in ipairs(self.tbDomainName) do
		if (string.find(szMsg, "%A"..szDomainName.."%A") or string.find(szMsg, "%A"..szDomainName.."$")) then
			return 1;
		end
	end
	
	return 0;
end


function tbMgr:HaveSiteInfo(szMsg)
	local szIP =  "%d+%.%d+%.%d+%.%d+";
	if (string.find(szMsg, szIP)) then
		return 1;
	end
	szMsg = string.gsub(szMsg, "0", "o");
	
	for _, szPostfix in ipairs(self.tbFrequencyDomainName) do
		if (string.find(szMsg, ".+"..szPostfix)) then
			return 1;	
		end
	end
	
	return 0;
end


function tbMgr:HaveNumberInfo(szSrcStr)
	local szDesStr	= "";
	local nIter 	= 1;
	local nStrLen = string.len(szSrcStr);
	local nSpace = 0;
	if (string.len(szSrcStr) <= 2) then
		return 0;
	end
	
	szSrcStr = string.gsub(szSrcStr, "o", "0");
	
	if (string.find(szSrcStr, "^%d+$") and string.len(szSrcStr) >= 15) then
		return 0;
	end
	
	while(nIter <= nStrLen) do
		if (not string.find(szDesStr, "q")) then
			if (string.find(szDesStr, "%d%d%d%d%d%d%d%d*")) then
				return 1;
			end
		else
			if (string.find(szDesStr, "[1-9]%d%d%d%d%d*")) then
				return 1;	
			end
		end
	
		if (string.byte(szSrcStr, nIter) > 128) then
			nIter = nIter + 2;
			szDesStr = "";
		else
			local nChar = string.byte(szSrcStr, nIter);
			if ((nChar >= string.byte("a") and nChar <= string.byte("z")) or 
				(nChar >= string.byte("0") and nChar <= string.byte("9"))) then
				szDesStr = szDesStr..string.sub(szSrcStr, nIter, nIter);
			elseif(nChar ~= string.byte(" ")) then
				nSpace = nSpace + 1;
			end
			
			nIter = nIter + 1;
		end
		if (nSpace > 3) then
			szDesStr = "";
			nSpace = 0;
		end
	end
end


function tbMgr:HaveEmailInfo(szMsg)
	local szEmail = "%w+@%w+.%w+";
	
	if (string.find(szMsg, szEmail)) then
		return 1;
	end
	
	return 0;
end

local localehelp = VFactory:GetClass("localehelp");
function localehelp:HaveSpecialChar(szSrcStr)
	do return 0; end	-- TODO: 马上改掉
	szSrcStr = Lib:Convert2Semiangle(szSrcStr)
	szSrcStr = tbMgr:FilterGameInfo(szSrcStr);
	local nStrLen = string.len(szSrcStr);
	if (nStrLen < 2) then
		return 0;
	end
	local nIter 	= 1;
	while(nIter <= nStrLen) do
		if (string.byte(szSrcStr,nIter) == 215 and
			(string.byte(szSrcStr,nIter+1) >= 250 and string.byte(szSrcStr,nIter+1) <= 254)) then
			return 1;
		elseif (string.byte(szSrcStr,nIter) >= 176 and string.byte(szSrcStr,nIter) <= 247  and 
			string.byte(szSrcStr,nIter+1) >= 161 and string.byte(szSrcStr,nIter+1) <= 254) then		
			nIter = nIter + 2;
		elseif (string.byte(szSrcStr,nIter) >= 129 and string.byte(szSrcStr,nIter) <= 160  and 
			string.byte(szSrcStr,nIter+1) >= 64 and string.byte(szSrcStr,nIter+1) <= 254) then		
			nIter = nIter + 2;
		elseif (string.byte(szSrcStr,nIter) >= 170 and string.byte(szSrcStr,nIter) <= 254  and 
			string.byte(szSrcStr,nIter+1) >= 64 and string.byte(szSrcStr,nIter+1) <= 160) then		
			nIter = nIter + 2;
		elseif (string.byte(szSrcStr,nIter) >= 32 and string.byte(szSrcStr,nIter) <= 127) then
			nIter = nIter + 1;
		elseif ((string.byte(szSrcStr,nIter) == 161 and string.byte(szSrcStr,nIter+1) == 164) or 
				(string.byte(szSrcStr,nIter) == 161 and string.byte(szSrcStr,nIter+1) == 190) or 
				(string.byte(szSrcStr,nIter) == 161 and string.byte(szSrcStr,nIter+1) == 191) or
				(string.byte(szSrcStr,nIter) == 161 and string.byte(szSrcStr,nIter+1) == 171) or       --、号
				(string.byte(szSrcStr,nIter) == 161 and string.byte(szSrcStr,nIter+1) == 162) or       --～号
				(string.byte(szSrcStr,nIter) == 161 and string.byte(szSrcStr,nIter+1) == 173)) then
			nIter = nIter + 2;
		else
			return 1;
		end
	end	
	return 0;
end

function tbMgr:CheckLockAccountState()
	if (1 == IVER_g_nLockAccount) then
		local szGateWayName = GetClientLoginGateway();
		if (szGateWayName and string.sub(szGateWayName, 1, 4) == "gate") then
			return 1;
		end
	end
	return 0;
end

local vnlocalehelp = VFactory:GetClass("vnlocalehelp");
function vnlocalehelp:HaveSpecialChar(szSrcStr)
	return 0;
end

function tbMgr:HaveSpecialChar(szSrcStr)
	return VFactory:New("localehelp"):HaveSpecialChar(szSrcStr);
end


