-------------------------------------------------------
-- 文件名　：yuanyuezhuhongguo.lua
-- 文件描述：圆月朱红果 救玉兔用
-- 创建者　：ZouNan1@kingsoft.com
-- 创建时间：2009-08-31 14:03
-------------------------------------------------------
local tbYueGuo= Item:GetClass("zhuhongguo"); 

tbYueGuo.DELAY_TIME          = 1;     --使用进度条的时间参数	1秒	
tbYueGuo.USECD_TIME          = 5;     --月果的使用CD	
tbYueGuo.NEEDED_BAGCELL      = 1;     --至少需要背包空闲格子的数目	
tbYueGuo.AVAIL_AREA          = 20;    --月果使用的有效区域，?待定			
tbYueGuo.RABBIT_TEMPLATEID   = 3707;   --兔子的CLASS ID	
--任务变量 
tbYueGuo.TSK_GROUP     		 = 2069;  
tbYueGuo.TSK_COUNT           = 72;
tbYueGuo.TSK_DAY	         = 73;
tbYueGuo.TSK_TOTALCOUNT      = 74;		
		
tbYueGuo.MSG_ERR  = {
	 "Thất bại, ở gần đây không có Thỏ Ngọc!" ,
     "Túi đã đầy" ,
     "Vật phẩm đang CD, hãy thử lại sau",
	};
tbYueGuo.MSG_SUCC   = {
	"Ngươi đã cứu thành công 1 Thỏ Ngọc, hãy nhận chúc phúc!",
	"Ngươi đã cứu rất nhiều Thỏ Ngọc, nhận được chúc phúc!",	
	};
tbYueGuo.RABBIT_MSG = {
	"Ha ha…ăn no rồi" ,
	"Về nhà thôi ~~~~~" ,
	"Đa tạ đại hiệp tương trợ"  ,
	};

tbYueGuo.szName = "Nguyệt chu quả";

function tbYueGuo:OnUse()
    --判断物品CD 
    local nItemCD  = it.GetGenInfo(1);
    local nCurTime = GetTime(); 
    if (nItemCD + self.USECD_TIME) >= nCurTime then
    	me.Msg(self.MSG_ERR[3]);
    	return 0;
    end    
    --得到周围的兔子表
	local tbRabbit , nCount = self:GetRabbitAround();
	if nCount == 0 then
		me.Msg(self.MSG_ERR[1]);	
		return 0;		
	end	
    local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE, 
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	GeneralProcess:StartProcess("Đang cho thỏ ăn…" , self.DELAY_TIME* Env.GAME_FPS ,  {self.OnHelpRabbit , self , tbRabbit , it.dwId} , nil , tbEvent);	
end

--将玩家身边的兔子的ID放进兔子表，返回兔子表及兔子数目
function tbYueGuo:GetRabbitAround()
	local tbTempRabbit = {};
	local nCount = 0;
	local tbVar = KNpc.GetAroundNpcList(me , self.AVAIL_AREA);
	for _ , pNpc in pairs(tbVar) do
		if pNpc.nTemplateId == self.RABBIT_TEMPLATEID then
			tbTempRabbit[pNpc.dwId] = 1;
			nCount = nCount + 1;
		end
	end
	return tbTempRabbit , nCount;
end

--检测兔子表中的兔子是否还在玩家身边，以此生成新的兔子表 
function tbYueGuo:CheckRabbitAround(tbRabbit)
    local tbTempRabbit = self:GetRabbitAround();
    local nCount = 0;
    for nRabbitId , _ in pairs(tbRabbit) do
    	if tbTempRabbit[nRabbitId] then
      		nCount = nCount + 1;
      	else 
      		tbRabbit[nRabbitId] = nil;
    	end
    end
	return tbRabbit , nCount;
end

function tbYueGuo:OnHelpRabbit(tbRabbit , nItemId)
    if me.CountFreeBagCell() < self.NEEDED_BAGCELL then
	  	me.Msg(self.MSG_ERR[2]);
	  	return 0;
	end
	local nCount = 0;
    tbRabbit , nCount = self:CheckRabbitAround(tbRabbit); --读完条之后，再判断一次
    if nCount == 0 then 	
    	me.Msg(self.MSG_ERR[1]);
		return 0;
	end
	for nRabbitId , _ in pairs(tbRabbit) do
	    local pRabbit = KNpc.GetById(nRabbitId);
	    if pRabbit and (not pRabbit.GetTempTable("Npc").tbRabbitAbout or (pRabbit.GetTempTable("Npc").tbRabbitAbout.bIsCatch ~= 1)) then
	    	pRabbit.GetTempTable("Npc").tbRabbitAbout = pRabbit.GetTempTable("Npc").tbRabbitAbout or {};
	    	pRabbit.GetTempTable("Npc").tbRabbitAbout.bIsCatch = 1; --通知rabbit 吃饱，可以删了
	    	local nPos = math.floor(MathRandom(1, 3));
			pRabbit.SendChat(self.RABBIT_MSG[nPos]); 
	    	self:GetAward(nItemId); -- 救助了兔子，得到奖励	
    		return 1;         
 		end
 	end
 	me.Msg(self.MSG_ERR[1]);
 	return 0;
end

-- 救助兔子，?奖励 
function tbYueGuo:GetAward(nItemId)
    --更新物品CD
    local pItem = KItem.GetObjById(nItemId);
	if (not pItem) then
		return;
	end
    local nCurTime = GetTime(); 
    pItem.SetGenInfo(1, nCurTime);
    
    --更新救助兔子的数目
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if me.GetTask(self.TSK_GROUP, self.TSK_DAY) < nCurDate then
		me.SetTask(self.TSK_GROUP, self.TSK_DAY, nCurDate);
		me.SetTask(self.TSK_GROUP, self.TSK_COUNT, 0);
	end
	
	local nCurCount = me.GetTask(self.TSK_GROUP, self.TSK_COUNT) + 1;
	me.SetTask(self.TSK_GROUP, self.TSK_COUNT, nCurCount);
	local nTotalCount = me.GetTask(self.TSK_GROUP, self.TSK_TOTALCOUNT) + 1;
	me.SetTask(self.TSK_GROUP, self.TSK_TOTALCOUNT, nTotalCount);
	if nTotalCount == 100 then
		me.AddTitle(6,13,1,0);
		me.SetCurTitle(6,13,1,0);
	end
	local nPos = 1;
	if nCurCount <= 5  then   --小于或等于5个才给奖券
		local pItem =me.AddItem(18,1,466,1);
		if pItem then
			me.SetItemTimeout(pItem, 10080, 0);
		end
	else
		nPos = 2;
	end
	me.Msg(self.MSG_SUCC[nPos]);
	Dialog:SendBlackBoardMsg(me , self.MSG_SUCC[nPos]);	
end

function tbYueGuo:GetTip(nState)
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nCurCount = me.GetTask(self.TSK_GROUP, self.TSK_COUNT);
	if me.GetTask(self.TSK_GROUP, self.TSK_DAY) < nCurDate then
		nCurCount = 0;
	end	
	local szTip = string.format("<color=%s>Giúp đỡ Thỏ Ngọc %s/3<color>\n<color=yellow>Số Thỏ Ngọc được giúp đỡ hôm nay: %s\nTổng số Thỏ Ngọc được giúp đỡ: %s<color>",
		  nCurCount, me.GetTask(self.TSK_GROUP, self.TSK_TOTALCOUNT));	
	return szTip;
end
