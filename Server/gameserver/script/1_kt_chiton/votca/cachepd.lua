--月满西楼
--孙多良
--2008.09.03

local tbItem = Item:GetClass("cachepd")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 2 then
		Dialog:Say("Trống 2 ô mới nhận được Phần Thưởng");
		return 0;
	end
	local tbItemInfo = {bForceBind = 1};
	local tbItemId1 = {18,1,20311,1,0,0};
	local nCount1 = me.GetItemCountInBags(18,1,20311,1);
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
me.AddStackItem(18,1,553,1,tbItemInfo,3);
me.Msg("Nhận được <color=yellow>3 Tiền Du Long<color>");
	end
	----------------------------------
	if (tbAward[nIndex]==2) then
me.AddStackItem(18,1,553,1,tbItemInfo,5);
me.Msg("Nhận được <color=yellow>5 Tiền Du Long<color>");
	end	
----------------------------------------------
			if (tbAward[nIndex]==3) then
me.AddStackItem(18,1,553,1,tbItemInfo,10);
me.Msg("Nhận được <color=yellow>10 Tiền Du Long<color>");
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> thả <color=red>Cá Chép Đỏ<color> nhận được <color=gold>10 Tiền Du Long<color> thật may mắn");	

	end
	------------------------------------
				if (tbAward[nIndex]==4) then
me.AddStackItem(18,1,553,1,tbItemInfo,20);
me.Msg("Nhận được <color=yellow>20 Tiền Du Long<color>");
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> thả <color=red>Cá Chép Đỏ<color> nhận được <color=gold>20 Tiền Du Long<color> thật may mắn");	

	end
	return 1;
end

function tbItem:InitGenInfo()
	-- 设定有效期限
	--local nSec = Lib:GetDate2Time(math.floor(SpecialEvent.ZhongQiu2008.TIME_STATE[3]*10000));
	--it.SetTimeOut(0, nSec);
	
	return	{ };
end

