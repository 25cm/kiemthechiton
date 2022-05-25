local tbLottery = Item:GetClass("luckylottery");

function tbLottery:OnUse()
	--me.AddBindCoin(Lottery.BASE_BIND_COIN);
	Lottery:UseTicket(me.szName, me.nId);
	return 1;
	--it.Delete(me);
end
