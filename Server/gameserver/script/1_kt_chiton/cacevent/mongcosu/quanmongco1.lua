local tbquanmongco1 = Npc:GetClass("quanmongco1");
function tbquanmongco1:OnDeath(pNpc)
	local pPlayer  	= pNpc.GetPlayer();
	-----------------------------------------------------------
        pPlayer.AddJbCoin(2000);--5v ??ng khóa
		pPlayer.AddStackItem(18,1,533,2,nil,3);
		pPlayer.AddExp(50000)
		pPlayer.AddBindCoin(3000);--5v ??ng khóa
		pPlayer.Msg("Bạn nhận được: <color=yellow>2000 Đồng<color>");
----------------------------------------------------------		
end