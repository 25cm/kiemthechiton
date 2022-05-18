-------------------------------------------------------------------
--File		: kingame_npc.lua
--Author	: zhengyuhua
--Date		: 2008-5-13 10:24
--Describe	: ؿű
-------------------------------------------------------------------

-- 븱Ի߼
function KinGame:OnEnterDialog(bConfirm)
	-- еĵͼIDÿп
	local nKinId, nMemberId = me.GetKinMember();	
	local cKin = KKin.GetKin(nKinId);
	local nRet = Kin:CheckSelfRight(nKinId, nMemberId, 2)
	local nRet2 = Kin:HaveFigure(nKinId, nMemberId, 3)
	local bIsOldPAction = EventManager.ExEvent.tbPlayerCallBack:IsOpen(me, 2);	-- Ƿٻڼμ
	local tbOpt = 
	{
		--{"޸ļؿĻʱ估ص", self.ChangeGameSetting, self, 0},
		{"Cầu Hồn Ngọc", self.OnBuyCallBossItem, self, 1},
		{"Mua trang bị Danh Vọng Gia Tộc", self.OpenReputeShop, self},
		{"Muốn dùng Đồng tiền cổ đổi phần thưởng", self.OnFinalAward, self},
		{"Nói về túi tiền đi", self.GameExplain, self, 2},
		{"Thuyết minh hoạt động", self.GameExplain, self, 1};
		{"Kết thúc đối thoại"}
	}
	if (0 == bIsOldPAction) then	-- ٻڼμӻԲκݶܲμ
		if not cKin or nRet2 ~= 1 then
			Dialog:Say("Ngươi chưa phải là thành viên gia tộc chính thức, trở thành <color=red>Thành viên chính thức<color> hãy đến tìm ta.", unpack(tbOpt));
			return 0;
		end
	elseif (not cKin) then
		Dialog:Say("Ngươi chưa phải là thành viên gia tộc, vào gia tộc hãy đến tìm ta.", unpack(tbOpt));
		return 0;
	end
	
	local tbData = Kin:GetKinData(nKinId);
	if tbData.nApplyKinGameMap and tbData.nApplyKinGameMap ~= him.nMapId then
		local szCity = GetMapNameFormId(tbData.nApplyKinGameMap);
		local szMsg = string.format("Tộc trưởng của ngươi nói vào trong %s rất khó, đi đến cung điện ngầm bí ẩn, sau đó đến %s tìm ta!", szCity, szCity)
		Dialog:Say(szMsg, unpack(tbOpt));		
		return 0;
	end
	if tbData.nApplyKinGameMap == him.nMapId then
		local tbGame = KinGame:GetGameObjByKinId(nKinId);
		if not tbGame then
			Dialog:Say("Đang chờ...");
			return;
		end
		if tbGame:IsStart() == 1 and tbGame:FindLogOutPlayer(me.nId) ~= 1 then
			Dialog:Say("Lối vào ải gia tộc đã đóng, ngươi không thể vào được nữa!", tbOpt);
			return 0;
		end
		local tbIsBagIn = {"Có, cho ta qua.",self.JoinGame, self } 
		local tbFind = me.FindItemInBags(unpack(self.QIANDAI_ITEM));
		if #tbFind < 1 then
			tbFind = me.FindItemInRepository(unpack(self.QIANDAI_ITEM));
			if #tbFind < 1 then
				tbIsBagIn = {"Có, cho ta qua.", self.GiveQianDai, self, 1};
			end
		end
		Dialog:Say("Sẵn sàng chưa? Bây giờ ta sẽ đưa ngươi đi.",
			{
				tbIsBagIn,
				unpack(tbOpt)
			})
		return 0;
	end
	local nTime = cKin.GetKinGameTime();
	local nDegree = cKin.GetKinGameDegree();
	if os.date("%W%w", nTime) == os.date("%W%w", GetTime()) then
		Dialog:Say("Ah? Không quay trở lại? Ngươi muốn đi không?",tbOpt);
		me.Msg("Hoạt động chỉ diễn ra 1 lần, hãy quay trở lại vào ngày mai.");
		return 0;
	end
	if os.date("%W", nTime) == os.date("%W", GetTime()) and nDegree >= KinGame.MAX_WEEK_DEGREE then
		Dialog:Say(string.format("   Tuần này đã vượt ải! Đi thường xuyên sẽ xảy ra tai nạn!\n   Một tuần được vào <color=red>%d<color> lần.", KinGame.MAX_WEEK_DEGREE), 
			tbOpt);
		me.Msg(string.format("Sự kiện này chỉ có thể được mở một tuần %d lần. Hãy trở lại vào tuần tới.", KinGame.MAX_WEEK_DEGREE));
		return 0;
	end
	if nRet == 1 and bConfirm ~= 1 then
		if self:GetCityGameNum(him.nMapId) >= self.MAX_GAME then
			Dialog:Say("Hư ~! Ở đây tựa hồ có người ở nghe trộm! Chúng ta hoán một thành thị tái trò chuyện ba!", tbOpt);
			me.Msg("Cai thành thị đích hoạt động nơi sân dĩ mãn!");
			return 0;
		end
		Dialog:Say("   Gần đây ta phát hiện ra một cung điện bí ẩn dưới lòng đất! Đã có một cuộc chiến, chưa bao giờ thấy một cơ thể lớn như vậy, ta sợ và mọi người thậm chí không thể đi ra ngoài mà sống sót. Dường như có sức mạnh của gia tộc của ngươi, ngươi đi đến nó? Ta có thể đáp ứng.\n   Tuy nhiên, cần lưu ý là <color=green>có 6 cơ quan bên trong cần phải mở, sau đó mọi người có thể vào cung điện dưới lòng đất.<color>",
			{
				{"Tốt!Quá khứ ta cũng từng vậy!", self.OnEnterDialog, self, 1},
				unpack(tbOpt)
			});
		return 0;
	elseif nRet == 1 then
		if me.CountFreeBagCell() < 1 then
			me.Msg("Hành trang đầy!");
			return 0;
		end
		local pItem = me.AddItemEx(unpack(self.OPEN_KEY_ITEM));
		if pItem then
			me.SetItemTimeout(pItem, self.KEY_ITME_TIME);
			pItem.Sync()
		end
		GCExcute{" KinGame:ApplyKinGame_GC", nKinId, nMemberId, him.nMapId, me.nId};
		Dialog:Say("   Ta đưa chìa khóa cổng cho ngươi, lối vào cung điện ngầm sẽ được đóng lại sau 10 phút, bên ngoài của người của ngươi không thể đi vào. Ngươi có 10 phút để tập hợp thành viên, nhưng nếu tất cả đã có mặt ở đây, có thể sử dụng khóa để mở luôn.\n Sẵn sàng và sau đó tìm ta!");
		return 0;
	else
		Dialog:Say("   Gần đây ta phát hiện ra một cung điện bí ẩn dưới lòng đất! Đã có một cuộc chiến, chưa bao giờ thấy một cơ thể lớn như vậy, ta sợ và mọi người thậm chí không thể đi ra ngoài mà sống sót. Dường như có sức mạnh của gia tộc của ngươi, ngươi đi đến nó? Ta có thể đáp ứng.\n   <color=red>Tộc trưởng ngươi có nhìn ta<color>.", 
			tbOpt);
		return 0;
	end
end 

-- ϸ˵
function KinGame:GameExplain(nType)
	if nType == 1 then
		Dialog:Say(string.format("   Hoạt động gia tộc, là thành viên chính thức mới được tham gia, do Tộc trưởng hoặc Tộc phó mở, có 10 phút vào phó bản, sau đó tự động bắt đầu và không vào được nữa.\n   Cần ít nhất 6 người tham gia, không đủ sẽ bị hủy bỏ. Độ khó và phần thưởng điều chỉnh theo số người, càng nhiều người phần thưởng càng cao.\n   <color=green>Chú ý: Mỗi tuần chỉ mở %d lần, 1 ngày 1 lần, thời gian hoạt động nhiều nhất là 2 giờ, bất luận thế nào sau 2 giờ tất cả người chơi sẽ được đưa về thành.<color>", KinGame.MAX_WEEK_DEGREE))
	elseif nType == 2 then
		Dialog:Say("Túi tiền đó à, trên đí có ký hiệu của ta, chứng minh sự tín nhiệm của ta với ngươi, không thấy ta sẽ cho lại. Hãy nhớ, khi tìm ta đổi bảo rương phải mang túi tiền trên người để bày tỏ thành ý!",
			{
				{"Mất túi tiền rồi, có thể cho lại?", self.GiveQianDai, self},
				{"Kết thúc đối thoại"}
			})
	end
end

-- Ǯ
function KinGame:GiveQianDai(bJoinGame)
	local tbFind1 = me.FindItemInBags(unpack(self.QIANDAI_ITEM));
	local tbFind2 = me.FindItemInRepository(unpack(self.QIANDAI_ITEM));
	if #tbFind1 > 0 or #tbFind2 > 0 then
		Dialog:Say("Không có mất gì đâu!");
		return 0;
	end
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Túi tiền mà ngươi có, trong phó bản có nhiều tiền xu cổ, thu thập số lượng xu cổ nhất định sẽ nhận thưởng.\n   <color=red>Oh, hành trang của ngươi thật đầy đủ, không phù hợp ta sẽ cung cấp cho túi tiền trước tiên.<color>");
		return 0;
	end
	me.AddItem(unpack(self.QIANDAI_ITEM));
	local tbOpt = {{"Tốt!"}};
	if bJoinGame == 1 then
		tbOpt = {"Tốt!", self.JoinGame, self};
	end
	Dialog:Say("Túi tiền mà ngươi có, trong phó bản có nhiều tiền xu cổ, thu thập số lượng xu cổ nhất định sẽ nhận thưởng.", tbOpt);
end

function KinGame:OnFinalAward()
		local tbFind1 = me.FindItemInBags(unpack(self.QIANDAI_ITEM));
		if #tbFind1 < 1 then
			Dialog:Say("Trên người của ngươi không có túi tiền! Cầm túi tiền và mang đến gặp ta.");
			return 0;
		end
		local szMsg = "Ta đã sai lầm, ngươi thực sự rất mạnh mẽ! Ngươi thu thập được rất nhiều tiền xu cổ, phải không? Ta sẽ đổi kho báu của ta để lấy nó!";
		local tbOpt = 
		{
			{"Dùng 100 tiền xu cổ để đổi",self.GiveFinalAward, self},
			{"Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end

function KinGame:GiveFinalAward()
	local pPlayer = me;
	local nCount = pPlayer.GetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID);
	if nCount < 100 then
		Dialog:Say("Ta muốn 100 Đồng tiền cổ, có đủ rồi hãy đưa ta. Ta đang rất bận.");
		return 0;
	end
	
	local nFreeCount, tbExecute = SpecialEvent.ExtendAward:DoCheck("KinGame", pPlayer, nCount);
	if me.CountFreeBagCell() < 1 + nFreeCount then
		me.Msg("Hành trang không đủ chỗ trống.");
		return 0;
	end
	SpecialEvent.ExtendAward:DoExecute(tbExecute);
	
	pPlayer.SetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID, nCount - 100);
	local nAddExp = self.LevelBaseExp[pPlayer.nLevel] * 30 * 2;
	pPlayer.AddExp(nAddExp);
	pPlayer.AddItem(unpack(self.ZHENCHANGBAOXIANG_ITEM))
	-- Ϊɱbossʱȡby zhangjinpin@kingsoft
	--pPlayer.AddKinReputeEntry(5, "kingame");
	Dialog:Say("Công dụng của Đồng tiền cổ, đây là phần thưởng của ngươi, hãy nhận nó.");
end

function KinGame:ShowInfo(nRoomId, nMapId)
	local tbGame = self:GetGameObjByMapId(nMapId);
	Lib:ShowTB1(tbGame.tbRoom[nRoomId].tbNextLock);
end

function KinGame:UnLock(nRoomId, nMapId)
	local tbGame = self:GetGameObjByMapId(nMapId);
	tbGame.tbRoom[nRoomId]:UnLock();
end


function KinGame:OpenReputeShop()
	local nFaction = me.nFaction;
	if nFaction <= 0 or me.GetCamp() == 0 then
		Dialog:Say("Nhân vật chữ trắng không thể mua trang bị Danh Vọng Gia Tộc.");
		return 0;
	end
	me.OpenShop(self.REPUTE_SHOP_ID[nFaction], 1, 100, me.nSeries) --ʹ
end

function KinGame:OnBuyCallBossItem(nStep, nItemLevel, szItemLevel)
	local nKinId, nMemberId = me.GetKinMember()
	local nRet, cKin = Kin:CheckSelfRight(nKinId, nMemberId, 2);
	local szInfo = "  Cầu Hồn Ngọc là bảo vật, dùng nó trong ải gia tộc, kêu gọi võ lâm cao thủ, đánh bại hắn mới được bảo vật.\n  <color=green>Cầu Hồn Ngọc (sơ) gọi được cao thủ võ lâm cấp 55\n  Cầu Hồn Ngọc (trung) gọi được cao thủ võ lâm cấp 75<color>\n  Mua Cầu Hồn Ngọc, phải tốn bạc cổ gia tộc. 24:00 mỗi tuần, tặng bạc cổ, căn cứ vào tổng điểm uy danh gia tộc. 1000 điểm nhận được 100, 2000 điểm nhận được 150, 4000 điểm nhận được 200.\n"
	local tbOpt = {{"Kết thúc đối thoại"}};
	if cKin and nStep == 1 then
		szInfo = szInfo..string.format("Số bạc cổ gia tộc hiện có:\n <color=red>%d/%d<color>", cKin.GetKinGuYinBi(), Kin.MAX_GU_YIN_BI);
		if nRet == 1 then
			tbOpt = {
				{string.format("Mua Cầu Hồn Ngọc sơ(%d Bạc cổ gia tộc)", self.GOU_HUN_YU_COST[1]), self.OnBuyCallBossItem, self, 2, 1, "Sơ"},
				{string.format("Mua Cầu Hồn Ngọc trung(%d Bạc cổ gia tộc)", self.GOU_HUN_YU_COST[2]), self.OnBuyCallBossItem, self, 2, 2, "Trung"},
				{"Kết thúc đối thoại"}
			}
		else
			szInfo = szInfo.."\n  Chỉ Tộc trưởng hoặc Tộc phó mới được phép mua. Hãy họi họ đến chỗ ta.";
		end
	elseif nRet == 1 and nStep >= 2 then
		if cKin.GetKinGuYinBi() < self.GOU_HUN_YU_COST[nItemLevel] then
			szInfo = "Bạc cổ gia tộc không đủ, lần sau hãy đến.";
			nRet = 0;
		end
		if me.CountFreeBagCell() <= 0 then
			szInfo = "Hành trang không đủ ô trống!";
			nRet = 0;
		end
		if nStep == 2 and nRet == 1 then
			szInfo = string.format("Ngươi muốn mua 1 Cầu Hồn Ngọc %s, cần %d Bạc cổ gia tộc, ngươi có chắc chắn?", szItemLevel, self.GOU_HUN_YU_COST[nItemLevel])
			tbOpt = {
				{"Xác định mua", self.OnBuyCallBossItem, self, 3, nItemLevel, szItemLevel},
				{"Để ta suy nghĩ lại"},
			}
		elseif nStep == 3 and nRet == 1 then
			me.AddWaitGetItemNum(1);		-- ɫ
			return GCExcute{"KinGame:BuyCallBossItem_GC", nKinId, nMemberId, nItemLevel};
		end
	end
	Dialog:Say(szInfo,tbOpt);
end

function KinGame:ChangeGameSetting(bConfirm)
	
	local szInfo = "Ta không có nghe thác ba? Nếu là như thế này, như vậy thỉnh nâm chuẩn bị cho tốt 100000 lưỡng ngân lượng, để ta lai vi nâm an bài tương quan chuyện hạng.";
	local tbOpt = {
					{"Ta chuẩn bị cho tốt liễu 100000 lưỡng ngân lượng. Còn lại chuyện tựu phiền phức nâm liễu.", self.ChangeGameSetting, self, 1},
					{"Để ta suy nghĩ lại"}
				  }
				  
	if bConfirm == 0 then 
		Dialog:Say(szInfo,tbOpt);
		return 0;
	end
	
	-- ޸ĶԻ
	local nKinId, nMemberId = me.GetKinMember();	
	local cKin = KKin.GetKin(nKinId);
	local nOrderTime1 = 0;
	local nOrderTime2 = 0;
	local nOrderTime3 = 0;
	local nOrderMapId = 0;
	cKin.SetKinGameOrderTime1(nOrderTime1);
	cKin.SetKinGameOrderTime2(nOrderTime2);
	cKin.SetKinGameOrderTime3(nOrderTime3);
	cKin.SetKinGameOrderMapId(nOrderMapId);
	
	KinGame:ApplyKinGame(nKinId, cKin.GetKinGameOrderMapId());
end