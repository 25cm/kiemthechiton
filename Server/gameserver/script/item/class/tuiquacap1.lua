local tbTuiQuaCap1	= Item:GetClass("tuiquacap1");
function tbTuiQuaCap1:OnUse()
local tbItemId2 = {18,1,25204,1,0,0}
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 10000);
	-- fill 3 rate	
	local tbRate = {5000,3000,2000};
	local tbAward = 
{
	[1] = {18, 1,25194, 1};
	[2] = {18, 1,25292, 1};
	[3] = {18, 1,25299, 1};
}
	
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	local pItem = me.AddItem(unpack(tbAward[nIndex]));
	pItem.Bind(1)
	me.Msg("<color=yellow>Mở Quà Tặng Xuân Quý Tỵ [1] nhận được <color=cyan>"..pItem.szName.."<color>và <color=cyan>20tr EXP<color> <color=cyan>50v Bạc<color><color>");
	me.AddExp(30000000);
	me.Earn(500000,0);
	Task:DelItem(me, tbItemId2, 1);
	end