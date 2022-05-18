
local tbItem = Item:GetClass("wulingaoshouling");

tbItem.tbData = 
{
	[219] = {6, 1, 10},
	[220] = {6, 1, 20},
	[221] = {6, 1, 50},
	
	[222] = {6, 2, 10},
	[223] = {6, 2, 20},
	[224] = {6, 2, 50},
	
	[225] = {6, 3, 10},
	[226] = {6, 3, 20},
	[227] = {6, 3, 50},
	
	[228] = {6, 4, 10},
	[229] = {6, 4, 20},
	[230] = {6, 4, 50},
	
	[231] = {6, 5, 10},
	[232] = {6, 5, 20},
	[233] = {6, 5, 50},
}

function tbItem:OnUse()
	local tbParam = self.tbData[it.nParticular];
	assert(tbParam);

	local nTmpSeriers = math.floor(it.nParticular / 3) - 72
	local nFlag = Player:AddRepute(me, tbParam[1], tbParam[2], tbParam[3]);

	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("B?n ?? ??t ??n th��ch th?c c?a c��c v? s? uy t��n��" .. Env.SERIES_NAME[nTmpSeriers] .. "��M?c ?? cao nh?t��S? kh?ng th? s? d?ng danh ti?ng v? s? th��ch ??u��" .. Env.SERIES_NAME[nTmpSeriers] .. "������");
		return;
	end	

	if me.nSeries ~= nTmpSeriers then
		me.Msg("<color=yellow>N?m y?u t? c?a m? th?ng b��o b?n s? d?ng kh��c v?i n?m y?u t? c?a nhan v?t c?a b?n, vui l��ng s? d?ng n�� m?t c��ch c?n th?n��")
	end
	-- TODO:AddLog

	-- ������ʹ�ú��ٻ�boss,Ȼ��õ����ָ�������,Ȼ���㹴�����ƹ�Ա����....
	Spreader:OnGouhunyuRepute(tbParam[3]);
	
	return 1;
end

