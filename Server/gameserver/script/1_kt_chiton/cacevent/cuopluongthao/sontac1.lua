local tbsontac1 = Npc:GetClass("sontac1");
function tbsontac1:OnDeath(pNpc)
	local pPlayer  	= pNpc.GetPlayer();
	-----------------------------------------------------------
        pPlayer.AddJbCoin(1000);--5v ??ng khóa
		pPlayer.AddStackItem(18,1,533,2,nil,3);
		pPlayer.AddExp(50000)
		pPlayer.AddBindCoin(2000);--5v ??ng khóa
		pPlayer.Msg("Bạn nhận được: <color=yellow>1000 Đồng<color>");
----------------------------------------------------------		
end