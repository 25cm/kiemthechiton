--月满西楼
--孙多良
--2008.09.03

local tbItem = Item:GetClass("yuemanxilou")
tbItem.nAddHour = 30; --增加30分钟；
tbItem.DEF_MAX  = 100;
tbItem.TASK_GROUP = 2027;
tbItem.TASK_COUNT = 89;

function tbItem:OnUse()
	local nCount = me.GetTask(self.TASK_GROUP, self.TASK_COUNT);
	if nCount >= self.DEF_MAX then
		Dialog:Say("Mỗi nhân vật chỉ có thể sử dụng tối đa 100 chiếc bánh này");
		return 0;
	end
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("Trống 2 ô mới nhận được Phần Thưởng");
		return 0;
	end
	local tbItemInfo = {bForceBind = 1};
	local tbItemId1 = {18,1,463,1,0,0};
	local nCount1 = me.GetItemCountInBags(18,1,463,1);
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 100);
	-- fill 3 rate	
	local tbRate = {55,30,10,5};
	local tbAward = {1,2,3,4}
	 
			for i = 1, 4 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if (tbAward[nIndex]==1) then
me.SetTask(self.TASK_GROUP, self.TASK_COUNT, nCount+1);
me.AddStackItem(18,1,26000,1,tbItemInfo,2);
me.AddJbCoin(2000);
me.Msg("Nhận được <color=yellow>2000 Đồng<color>");
me.Msg("Nhận được <color=yellow>2 Mật Tịch Hỏa Long Kiếm<color>");
	end
	----------------------------------
	if (tbAward[nIndex]==2) then
	me.SetTask(self.TASK_GROUP, self.TASK_COUNT, nCount+1);
me.AddStackItem(18,1,26000,1,tbItemInfo,3);
	me.AddJbCoin(3000);
me.Msg("Nhận được <color=yellow>3000 Đồng<color>");
me.Msg("Nhận được <color=yellow>3 Mật Tịch Hỏa Long Kiếm<color>");
	end	
----------------------------------------------
			if (tbAward[nIndex]==3) then
		me.SetTask(self.TASK_GROUP, self.TASK_COUNT, nCount+1);		
me.AddStackItem(18,1,26000,1,tbItemInfo,4);
	me.AddJbCoin(5000);
me.Msg("Nhận được <color=yellow>5000 Đồng<color>");
me.Msg("Nhận được <color=yellow>4 Mật Tịch Hỏa Long Kiếm<color>");
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> ăn <color=red>Bánh Trung Thu<color> nhận được <color=gold>5000 Đồng<color> thật may mắn !");	

	end
	------------------------------------
				if (tbAward[nIndex]==4) then
	me.SetTask(self.TASK_GROUP, self.TASK_COUNT, nCount+1);			
me.AddStackItem(18,1,26000,1,tbItemInfo,5);
me.AddJbCoin(10000);
me.Msg("Nhận được <color=yellow>1 Vạn Đồng<color>");
me.Msg("Nhận được <color=yellow>5 Mật Tịch Hỏa Long Kiếm<color>");
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> ăn <color=red>Bánh Trung Thu<color> nhận được <color=gold>1 Vạn Đồng<color> thật may mắn !");	
	
	end
	return 1;
end

function tbItem:InitGenInfo()
	-- 设定有效期限
	--local nSec = Lib:GetDate2Time(math.floor(SpecialEvent.ZhongQiu2008.TIME_STATE[3]*10000));
	--it.SetTimeOut(0, nSec);
	
	return	{ };
end

function tbItem:GetTip()
	local szTip = "";
	local nUse =  me.GetTask(self.TASK_GROUP, self.TASK_COUNT);
	szTip = szTip .. string.format("<color=green>Đã sử dụng %s/%s chiếc.<color>", nUse, self.DEF_MAX);
	return szTip;
end
