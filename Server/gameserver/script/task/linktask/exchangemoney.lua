-- 用於兌換銀票
-- 普通兌換銀票
Require("\\script\\task\\linktask\\linktask_head.lua");

local tbExchangeNormal = Npc:GetClass("exchangenormal");

function tbExchangeNormal:OnDialog()
	local nNpcId = 0;
	if him.nTemplateId == 2961 then
		nNpcId = him.dwId;
		local nLimit = 0;
		
		if not BaiHuTang.tbGetAwardCount[nNpcId] then 
			BaiHuTang.tbGetAwardCount[nNpcId] = 0;
		end
		
		nLimit = BaiHuTang.tbGetAwardCount[nNpcId];
		
		if nLimit >= 30 then
			Dialog:Say("對不起，每場白虎堂我隻能兌換 <color=yellow>30 次<color>銀票，您還是下次再來吧！");
			return
		end;
	end;
	
	Dialog:Say("我這裡可以兌換義軍包萬同所開出的銀票，你現在要馬上兌換嗎？", 
		{"現在就兌換", LinkTask.ShowBillGiftDialog, LinkTask, nNpcId},
		{"不了"})
end


local tbYiJunJunXuGuan = Npc:GetClass("yijunjunxuguan");

-- 申請兌換銀票
function tbYiJunJunXuGuan:ApplyEchangeYinPia(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	
	--print("Step1：\n", pPlayer.szName.."申請兌換銀票");
	local nCurrTime = GetTime();
	local nToday = tonumber(os.date("%Y%m%d", nCurrTime));
	local nAvailablyData = pPlayer.GetTask(2057, 1);
	
	--print("Step2：", "今天日期是===>", nToday);
--	print("之前記錄的激活截至日期===>", nAvailablyData)
	
	if (nAvailablyData >= nToday) then
		LinkTask:ShowBillGiftDialog();
		return;
	end
	
	local szToday = os.date("%Y年%m月%d日", nCurrTime);
	local szAvailablyData = os.date("%Y年%m月%d日", nCurrTime + 3600 * 24 * 31);
	local szMsg = "每次充值 15 元就可以使一個游戲帳號下的一個角色擁有 31 天的銀票兌換期，您現在可以開啟 31 天的銀票兌換期，兌換期從 <color=yellow>"..szToday.."<color> 到 <color=yellow>"..szAvailablyData.."<color>，您確認要開啟嗎？";
	Dialog:Say(szMsg,
			{"是", self.ActiveForLinkTask, self, nPlayerId},
			{"否"}
		);
end



-- 是否可以激活當前
function tbYiJunJunXuGuan:ActiveForLinkTask(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
--	print("step3：\n"..pPlayer.szName.."申請激活當前帳號")
	local nToday = tonumber(os.date("%Y%m%d", GetTime()));
	local nAvailablyData = pPlayer.GetTask(2057, 1);
	if (nAvailablyData > nToday) then
		pPlayer.Msg("此帳號本月不需要激活了");
		return;
	end
	
	local nMoneyPerOne = 15;	-- 15塊激活一個
	--local nCurActiveNum = pPlayer.GetLinkTaskActiveAccountNum();
--	print("step4：\n"..pPlayer.szName.."當前已經激活的數目", nCurActiveNum, "\n本月沖值金額："..pPlayer.GetExtMonthPay());
	--assert(nCurActiveNum < 12);	-- liuchang 最多建立12個角色，之後有刪角色功能可能會有Bug
	
	if (nMoneyPerOne <= pPlayer.GetExtMonthPay()) then
		--pPlayer.AddLinTaskActiveAccount();
		local nAvailablyData =  tonumber(os.date("%Y%m%d", GetTime() + 3600 * 24 * 31)); -- 增加31天
		pPlayer.SetTask(2057, 1, nAvailablyData);
		self:ApplyEchangeYinPia(nPlayerId);
	else
		pPlayer.Msg("你當月沖值不夠，每次充值 15 元可以使一個角色擁有 31 天的銀票兌換期。");
	end
end
