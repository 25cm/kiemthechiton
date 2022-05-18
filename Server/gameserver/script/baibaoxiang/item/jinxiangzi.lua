
Require("\\script\\baibaoxiang\\baibaoxiang_def.lua");

local tbJinxiangziItem = Item:GetClass("jinxiangzi");

function tbJinxiangziItem:OnUse()
local tbItemId1 = {18,1,324,1,0,0};
	if me.CountFreeBagCell() < 5 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 5 ô trống.");
		return 0;
	end
	
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	
	-- random
	nRand = MathRandom(1, 10360);
	
	-- fill 3 rate	
	local tbRate = {5000, 2000, 1000, 1000, 1000, 100, 40, 20, 200};
	local tbAward = {1 ,2, 3, 4, 5, 6, 7, 8, 9};
	
	-- get index
	for i = 1, 8 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	
	if (tbAward[nIndex]==1) then
	--Task:DelItem(me, tbItemId1, 1);
    me.AddStackItem(18,1,1194,1,tbItemInfo,2);
	end
	--------------------------
	if (tbAward[nIndex]==2) then
	--Task:DelItem(me, tbItemId1, 1);
    me.AddStackItem(18,1,1194,2,tbItemInfo,1);
	end
----------------------------------------------
	if (tbAward[nIndex]==3) then
	--Task:DelItem(me, tbItemId1, 1);
	me.AddStackItem(18,1,5001,51,tbItemInfo,15);
	end	
----------------------------------------------
	if (tbAward[nIndex]==4) then
	--Task:DelItem(me, tbItemId1, 1);
	me.AddStackItem(18,1,5002,52,tbItemInfo,20);
	end	
	
----------------------------------------------
	if (tbAward[nIndex]==5) then
	--Task:DelItem(me, tbItemId1, 1);
	me.AddStackItem(18,1,553,1,tbItemInfo,100);	
	end	
	
----------------------------------------------
			if (tbAward[nIndex]==6) then
				--Task:DelItem(me, tbItemId1, 1);
	me.AddItem(18,1,666,2);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> mở <color=gold>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=red>Đồng Hành 5 Kỹ Năng<color>");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> mở <color=yellow>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=gold>Đồng Hành 5 Kỹ Năng<color>");
	end
	------------------------------------
				if (tbAward[nIndex]==7) then
	--Task:DelItem(me, tbItemId1, 1);
	me.AddItem(18,1,547,2);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> mở <color=gold>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=red>Đồng Hành 6 Kỹ Năng<color>");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> mở <color=yellow>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=gold>Đồng Hành 6 Kỹ Năng<color>");
	end
	-------------------------------------
	if (tbAward[nIndex]==8) then
		--Task:DelItem(me, tbItemId1, 1);
	me.AddItem(18,1,1331,4);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> mở <color=gold>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=red>Tinh Thạch Thánh Hỏa<color>");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> mở <color=yellow>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=gold>Tinh Thạch Thánh Hỏa<color>");
	end
if (tbAward[nIndex]==9) then
		--Task:DelItem(me, tbItemId1, 1);
	me.AddStackItem(18,1,1331,3,tbItemInfo,2);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> mở <color=gold>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=red>Tinh Thạch Đoạn Hải<color>");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> mở <color=yellow>Rương Vừa Đẹp Vừa Cao Quý<color> nhận được <color=gold>Tinh Thạch Đoạn Hải<color>");
	end
	return 1;
end

function tbJinxiangziItem:WeekEvent()
	me.SetTask(Baibaoxiang.TASK_GROUP_ID, Baibaoxiang.TASK_BAIBAOXIANG_WEEKEND, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({tbJinxiangziItem.WeekEvent, tbJinxiangziItem});
