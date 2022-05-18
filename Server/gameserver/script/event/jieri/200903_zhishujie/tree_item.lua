-- 09ֲ���� 

--��������
local tbOldSeed = EventManager:GetClass("item_seed_arbor_day_09");

function tbOldSeed:OnUse()
	local szMsg = "\nMỗi Nhân Vật:\n1 Ngày Nấu Được 10 Nồi Cháo\nTối đa là 500 Nồi Cháo\nNấu Cháo là công việc khó khăn, ngươi đã chắc chưa ?";
	local tbOpt = {
		{"Nấu ở đây!", self.PlantTree, self, me, it.dwId},
        {"Để ta suy nghĩ!"},
        };
        
    Dialog:Say(szMsg, tbOpt);
    return 0;
end

function tbOldSeed:PlantTree(pPlayer, dwItemId)
	local pItem = KItem.GetObjById(dwItemId);
	-- if not pItem then
		-- Dialog:Say("Túi Củi của Bạn đã hết hạn!");
		-- return;
	-- end
	
	local nRes, szMsg = SpecialEvent.ZhiShu2009:CanPlantTree(pPlayer);
	
	if nRes == 1 then
		local tbEvent = 
		{
			Player.ProcessBreakEvent.emEVENT_MOVE,
			Player.ProcessBreakEvent.emEVENT_ATTACK,
			Player.ProcessBreakEvent.emEVENT_SITE,
			Player.ProcessBreakEvent.emEVENT_USEITEM,
			Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
			Player.ProcessBreakEvent.emEVENT_DROPITEM,
			Player.ProcessBreakEvent.emEVENT_SENDMAIL,
			Player.ProcessBreakEvent.emEVENT_TRADE,
			Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
			Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
			Player.ProcessBreakEvent.emEVENT_LOGOUT,
			Player.ProcessBreakEvent.emEVENT_DEATH,
		}
		
		if SpecialEvent.ZhiShu2009:HasReachXpLimit(pPlayer) == 1 then
			Dialog:SendBlackBoardMsg(pPlayer, "Bạn đã thu được kinh nghiệm tối đa. Nấu Cháo sẽ không được kinh nghiệm.");
		end
		
		GeneralProcess:StartProcess("Đang Nấu Cháo ....", 1 * Env.GAME_FPS, 
			{SpecialEvent.ZhiShu2009.Plant1stTree, SpecialEvent.ZhiShu2009, pPlayer, dwItemId}, nil, tbEvent);
				
	elseif szMsg then
		Dialog:Say(szMsg);
	end
end

-- ����������
local tbNewSeed = Item:GetClass("new_seed_arbor_day_09");
function tbNewSeed:InitGenInfo()
	it.SetTimeOut(0, GetTime() + 24 * 3600);
	return {};
end

-- ��ˮ��
local tbJug = Item:GetClass("jug_arbor_day_09");
function tbJug:InitGenInfo()
	it.SetTimeOut(0, Lib:GetDate2Time(20180518));
	return {};
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_zhishujie\\tree_item.lua")