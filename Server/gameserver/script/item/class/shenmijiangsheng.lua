--神秘疆绳
--sunduoliang
--2008.10.30

local tbItem = Item:GetClass("shenmijiangsheng");

tbItem.tbHorse = 
{
	{1, 12, 17, 3},	--奇珍阁（乌云踏雪）
	{1, 12, 19, 3}, --奇珍阁（绝影）
	{1, 12, 20, 3}, --奇珍阁（照夜玉狮子）
	{1, 12, 21, 3}, --奇珍阁（汗血宝马）
}

function tbItem:OnUse()
	local szMsg = "Dây cương thần bí, có khả năng bắt được những con ngựa cực phẩm, những con ngựa mà ngươi muốn có.\n<color=red>(Ngựa nhận được sẽ tự động khóa)<color>";
	local tbOpt = {};
	for nId, tbHorse in ipairs(self.tbHorse) do
		local szName = KItem.GetNameById(unpack(tbHorse));
		table.insert(tbOpt, {szName, self.GetHorse, self, it.dwId, nId});
	end
	table.insert(tbOpt, {"Để ta suy nghĩ đã"});
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:GetHorse(nItemId, nId, nFlag)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if not nFlag then
		local szMsg= string.format("Bạn đã chọn <color=yellow>%s<color>, ngựa sử dụng <color=red>sẽ tự động khóa<color>, bạn có chắc muốn sử dụng?", KItem.GetNameById(unpack(self.tbHorse[nId])));
		local tbOpt = 
		{
			{"Chắc chắn sử dụng", self.GetHorse, self, nItemId, nId, 1},
			{"Để ta suy nghĩ đã"},
		}
		Dialog:Say(szMsg, tbOpt);
		return;
	end
	if me.DelItem(pItem) ~= 1 then
		return
	end
	local pAddItem = me.AddItem(unpack(self.tbHorse[nId]));
	if pAddItem then
		pAddItem.Bind(1);
		me.SetItemTimeout(pAddItem, os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 365 * 24 * 3600), 0);
		me.Msg(string.format("Bạn nhận được 1 <color=yellow>%s<color>", pAddItem.szName));
	end
end
