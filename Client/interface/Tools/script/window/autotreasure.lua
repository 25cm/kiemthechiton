local tbWaBao	= UiManager

local nwabaoState = 0;
local hlWaTimeId = 0;
local hlWaShiJian = 2;
local hlNowTu = 0;
local hlNowTuMap = 0;
local hlNowTuX = 0; 
local hlNowTuY = 0;
local hlNowTuFlg = 0; 
local hlJDFlg = 0;
local nRunning = 0;
local hlSelect = 0;
local nWaitTimes = 0;
local hlBaoS = {
	[1]={18,1,9,1},
	[2]={18,1,9,2},
	[3]={18,1,9,3},
	[4]={18,1,10,1},
	};
local nCount = {};
local hlXiang = {};

local tCmd={ "UiManager:hhStartWaBao()", "hhStartWaBao", "", "Ctrl+Shift+1", "Ctrl+Shift+1", "hhStartWaBao" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--：Ctrl+Shift+1
	
function tbWaBao:hhStartWaBao()
        if hlWaTimeId == 0 then 
		--me.Msg("<bclr=red><color=yellow>Bật tự đào kho báu (Ctrl+1)<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Hệ thống tự đào kho báu khởi động<color><bclr>");
		nWaitTimes = 0;
		hlNowTuFlg = 0;
		hlJDFlg = 0;
                hlWaTimeId = Ui.tbLogic.tbTimer:Register(hlWaShiJian * Env.GAME_FPS, tbWaBao.onWaBaoTime, self);
                
	else
		--me.Msg("<bclr=blue><color=white>Tắt  tự đào kho báu (Ctrl+1)<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=white>Hệ thống tự đào kho báu kết thúc<color><bclr>");
                Ui.tbLogic.tbTimer:Close(hlWaTimeId);
		hlWaTimeId = 0;
	end
end

function tbWaBao:hhEndWaBao()
        if hlWaTimeId ~= 0 then 
		--me.Msg("<bclr=blue><color=white>Tắt tự động đào bản đồ kho báu (Ctrl+1)<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=white>Hệ thống tự đào kho báu kết thúc<color><bclr>");
                Ui.tbLogic.tbTimer:Close(hlWaTimeId);
		hlWaTimeId = 0
	end
end

function tbWaBao:onWaBaoTime()
	if me.nTeamId <= 0 then
		me.Msg("Bạn phải tạo đội trước khi tự động săn kho báu");
		me.CreateTeam();
		return;
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	if (me.IsDead() == 1) then
		me.SendClientCmdRevive(0);  
		return;
	end

	tbWaBao:setWaBaoState()
	if nwabaoState == 88 then
		tbWaBao:hhEndWaBao()
	elseif nwabaoState == 5 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
	elseif nwabaoState == 11 then
		if (nWaitTimes <= 5) then
			if hlSelect == 0 then
				me.UseItem(hlNowTu.pItem);
				hlSelect = 1;
			elseif hlSelect == 1 then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
					me.AnswerQestion(0)
					hlSelect = 2
				else
					hlSelect = 0
				end
			elseif hlSelect == 2 then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
					UiManager:CloseWindow(Ui.UI_SAYPANEL);
				end
				hlSelect = 0
				nWaitTimes = 6
			end
			nWaitTimes = nWaitTimes + 1
			return;
		end
		hlSelect = 0
		nwabaoState = 0;
	elseif nwabaoState == 1 then

		--me.Msg("Chạy nhanh lên, nhanh nữa lên nào kho báu của ta!");
		local nCurMapId0 = hlNowTuMap
		local nWorldPosX0 = hlNowTuX
		local nWorldPosY0 = hlNowTuY
		local tbPosInfo ={}
		tbPosInfo.szType = "pos"
		tbPosInfo.szLink = "Điểm treo,"..nCurMapId0..","..nWorldPosX0..","..nWorldPosY0
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nCurMapId0,nX=nWorldPosX0,nY=nWorldPosY0})

	elseif nwabaoState == 2 then
		--me.Msg("Sai vị trí, tìm lại đi!")
		nWaitTimes = nWaitTimes + 1
		if (nWaitTimes <= 5) then
			if hlSelect == 0 then
				--me.Msg("Sai vị trí, tìm lại đi!");
				self:hlCutTu();
				hlSelect = 1;
			elseif hlSelect == 1 then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
					me.AnswerQestion(0)
					hlSelect = 2
				else
					hlSelect = 0
				end
			elseif hlSelect == 2 then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
					UiManager:CloseWindow(Ui.UI_SAYPANEL);
				end
				hlSelect = 0
				nWaitTimes = 5
					end
			return;
		elseif (nWaitTimes <= 60) then
			if nWaitTimes == 6 then
				tbWaBao:GetAroundXiang()
				if #hlXiang < 1 then
					
					nWaitTimes = 60
					return;
				end
				nWaitTimes = 7
				Map.tbAutoAim:AutoPickStart();
			end
			local nRet = me.GetSkillState(TreasureMap.nTiredSkillId);
			if (nRet ~=  -1 and nWaitTimes == 7) then
				me.Msg("Bạn phải chờ")
				nWaitTimes = 6
			return;
			end
			local hlTmpIndex = nWaitTimes - 6;
			local hlTmpXiang = hlXiang[hlTmpIndex]
			if hlTmpXiang then
				AutoAi.SetTargetIndex(hlTmpXiang.nIndex);
			end
			if hlTmpIndex >= #hlXiang then
				nWaitTimes = 60
			end
		else
			Map.tbAutoAim:AutoPickStop();
			nWaitTimes = 0;
			hlSelect = 0
			hlNowTuFlg = 0;
		end

	elseif nwabaoState == 6 then
		me.Msg("Bắt đầu ghép HT")
		if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
			return
		end
		local nId = tbWaBao:GetAroundNpcId(3574)
		tbWaBao:OpenExtBag()
		if nId then
			me.Msg("Dã luyện đại sư")
			if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) ~= 1 then
				AutoAi.SetTargetIndex(nId);
			end
			local function fnhexuan()
				for i = 1,5 do
					nCount[i] = me.GetItemCountInBags(18,1,1,i)
				end
				for i = 1,5 do
					nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
				end
				me.Msg("Thực hiện ghép")
				for i=1,5 do
					if nCount[i] > 3 then
						tbWaBao:MyFindItem2(18,1,1,i,1,4,114)
						if i < 5 then
							tbWaBao:MyFindItem2(18,1,1,i-1,1,3,114)
							tbWaBao:MyFindItem2(18,1,1,i-2,1,3,114)
						elseif i > 4 and i < 6 then
							tbWaBao:MyFindItem2(18,1,1,i-1,1,1,114)
							tbWaBao:MyFindItem2(18,1,1,i-2,1,3,114)
						elseif i > 5 then
							tbWaBao:MyFindItem2(18,1,1,i-2,1,1,114)
						end
						me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
						return
					end
				end
				if 	UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
					UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end
				me.Msg("Không có đủ Huyền tinh để ép hoặc chưa mở khóa tài khoản")
				return 0
			end
			local function CloseWindow4()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					UiManager:CloseWindow(Ui.UI_SAYPANEL);
				end
				return 0

			end
			local function fnCloseSay2()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(2)
					me.AnswerQestion(0)
					Ui.tbLogic.tbTimer:Register(15, CloseWindow4);
					Ui.tbLogic.tbTimer:Register(40, fnhexuan);
					return 0;
				end
			end
			Ui.tbLogic.tbTimer:Register(30, fnCloseSay2);
		else
			local nCurMapId0 = 28
			local nWorldPosX0 = 1550
			local nWorldPosY0 = 3336
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = "Điểm treo,"..nCurMapId0..","..nWorldPosX0..","..nWorldPosY0
			Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nCurMapId0,nX=nWorldPosX0,nY=nWorldPosY0})
		end
	end

end
function tbWaBao:setWaBaoState()
	if hlJDFlg == 0 then
		if nwabaoState == 11 then
			return;
		end
		for i,tbBao in pairs(hlBaoS) do
			local tbFind = me.FindItemInBags(unpack(tbBao));
			for j, tbItem in pairs(tbFind) do
				hlNowTu = tbItem
				local hlIsJianDing = hlNowTu.pItem.GetGenInfo(TreasureMap.ItemGenIdx_IsIdentify);
				if hlIsJianDing ~= 1 then 
					me.Msg("Chưa xác định, bây giờ phải xác định !");
					nwabaoState = 11
					nWaitTimes = 0
					return;
				end
			end
		end
		hlJDFlg = 1;
		nWaitTimes = 0
	end
	if hlNowTuFlg ==  0 then
		for i,tbBao in pairs(hlBaoS) do
			local tbFind = me.FindItemInBags(unpack(tbBao));
			for j, tbItem in pairs(tbFind) do
				hlSelect = 0
				hlNowTu = tbItem;
				local nTmapID = hlNowTu.pItem.GetGenInfo(2);
				hlNowTuFlg = 1;
				nwabaoState = 1;
				local pTabFile = KIo.OpenTabFile("\\setting\\task\\treasuremap\\treasuremap_pos.txt");

				hlNowTuMap = pTabFile.GetInt(nTmapID+1,4);
				hlNowTuX = pTabFile.GetInt(nTmapID+1,5);
				hlNowTuY = pTabFile.GetInt(nTmapID+1,6);
				local szTmap_Name	= pTabFile.GetStr(nTmapID+1,7);
				KIo.CloseTabFile(pTabFile);
				me.Msg("Đã tìm thấy trong <color=yellow>"..szTmap_Name.."<color> bản đồ kho báu")
	                        return;	
			end
		end
		nwabaoState = 88;
		return;
	end
	if (nWaitTimes == 0) then
		local nCount_FreeBag = me.CountFreeBagCell();
		local bFlag = 0 
		for i = 1,5 do
			nCount[i] = me.GetItemCountInBags(18,1,1,i)
			if nCount[i] > 3 then
				bFlag=1
			end
		end
		for i = 1,5 do
			nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)

			if nCount[i] > 3 then
				bFlag=1
			end
		end
		if (nCount_FreeBag < 5 and bFlag == 1)then
			nwabaoState = 6 
			return;
		end
	end

	tbWaBao:IsMoving();
	local nAtNpcPos = tbWaBao:IsArrival()
	if (nAtNpcPos == 1) or (me.nAutoFightState == 1) then
		nwabaoState = 2;
	elseif (nRunning == 0) then
		nwabaoState = 1;
	else
		nwabaoState = 5;
	end 
end

function tbWaBao:MyFindItem2(g,d,p,l,bOffer,count,p1)
	local k = 0
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
				local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
				if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
					if bOffer == 1 then
						k= k+1
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
						if k >= count then
							return
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1  then
							k= k+1
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end
	return 0;
end

function tbWaBao:hlCutTu(nTempId)
		for i,tbBao in pairs(hlBaoS) do
			local tbFind = me.FindItemInBags(unpack(tbBao));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
	                        return;	
			end
		end
end

function tbWaBao:GetAroundNpcId(nTempId)

	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end

function tbWaBao:GetAroundXiang()
	hlXiang = {};
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 30);
	local hlXiangIndex = 0
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == 2680) then --bảo rương cổ
			hlXiangIndex = hlXiangIndex + 1
			hlXiang[hlXiangIndex] = pNpc
		end
	end
end

function tbWaBao:IsArrival()
	local nDistance = tbWaBao:GetNpcDistance();
	if (me.nMapId == hlNowTuMap and nDistance <= 2) then
		return 1;
	end
	return 0;
end

function tbWaBao:GetNpcDistance()
	local nPosX = hlNowTuX;
	local nPosY = hlNowTuY;

	local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
	local nDistance = (nPosX-nMyPosX)^2 + (nPosY-nMyPosY)^2;
	return nDistance;
end

function tbWaBao:IsMoving()
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		nRunning = 1;
	else
		nRunning = 0;
	end
end

function tbWaBao:Sample()
end

function tbWaBao:OpenExtBag()	
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
		UiManager:SwitchWindow(Ui.UI_ITEMBOX);
	end	
	local tbItemBox = Ui(Ui.UI_ITEMBOX);	
	local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
	tbExtBagLayout:Show();     -- đánh mở túi mở rộng  
end