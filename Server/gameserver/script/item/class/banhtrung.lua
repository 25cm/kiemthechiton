local tbBanhTrung = Item:GetClass("banhtrung")
function tbBanhTrung:OnUse()
Dialog:Say("Đem ra cho người dân nghèo ở Tương Dương nhé")
end
function tbBanhTrung:OnDialog4()
local tbItemId2	= {18,1,25247,1,0,0};
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 10000);
	-- fill 3 rate	
	local tbRate = {400,400,400,400,200,200,200,7600,200};
	local tbAward = 
{
[1] = {18,1,25239,1};
[2] = {18,1,25240,1};
[3] = {18,1,25241,1};
[4] = {18,1,25242,1};
[5] = {18,13,20396,1};
[6] = {18,13,20391,1};
[7] = {18,13,20401,1};
[8] = {18,1,25194,1};
[9] = {18,1,25206,1};
}
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
			for i = 1, 9 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	local pItem = me.AddItem(unpack(tbAward[nIndex]));
	pItem.Bind(1);
	me.Msg("Nhận được <color=cyan>"..pItem.szName.."<color>"); 
	Task:DelItem(me, tbItemId2, 1);
		end