local tbNpc = Npc:GetClass("tranphap1");function tbNpc:OnDialog_1()	local szMsg = "Tỉ lệ: 500 <color=green>Mảnh Trận Pháp<color> = 1 <color=yellow>Trận pháp-Siêu Cấp<color>";		szMsg = "Tỉ lệ: 500 <color=green>Mảnh Trận Pháp<color> = 1 <color=yellow>Trận pháp-Siêu Cấp<color>";	Dialog:OpenGift(szMsg, nil, {self.Change, self});end;function tbNpc:Change(tbItemObj)		local number = 0;	for _, pItem in pairs(tbItemObj) do		if (pItem[1].nGenre == 18 and pItem[1].nDetail == 1 and pItem[1].nParticular == 26000 and pItem[1].nLevel == 1) then			--Kiem tra Danh Bo Lenh			number = pItem[1].nCount + number;				end	end	if number < 500 then		me.Msg("Cho vật phẩm vào, Tỉ lệ: 500 <color=green>Mảnh Trận Pháp<color> = 1 <color=yellow>Trận pháp-Siêu Cấp<color> (cho thừa sẽ bị mất).");		Dialog:Say("Cho vật phẩm vào, Tỉ lệ: 500 <color=green>Mảnh Trận Pháp<color> = 1 <color=yellow>Trận pháp-Siêu Cấp<color> (cho thừa sẽ bị mất).");		return 0;	else		-- check is Rương		local nCount1 = me.GetItemCountInBags(18, 1, 26000, 1);		if nCount1 == 0 then			Dialog:Say("Bạn phải để <color=green>Mảnh Trận Pháp<color> trong rương");			return 0;		end	end	me.ConsumeItemInBags(number, 18, 1, 26000, 1);	local nMG = math.floor(number / 500);	me.AddStackItem(1,15,7,5,nil,nMG);end;