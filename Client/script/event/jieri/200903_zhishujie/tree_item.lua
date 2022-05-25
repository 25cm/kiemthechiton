-- 09植树节 

--陈年树种
local tbOldSeed = EventManager:GetClass("item_seed_arbor_day_09");

function tbOldSeed:OnUse()
	local szMsg = "看上去干瘪瘪的种子，种植可能需要花大量时间，你确定在这里种植这颗树种么？";
	local tbOpt = {
		{"就在这种", self.PlantTree, self, me, it.dwId},
        {"我再考虑下"},
        };
        
    Dialog:Say(szMsg, tbOpt);
    return 0;
end

function tbOldSeed:PlantTree(pPlayer, dwItemId)
	local pItem = KItem.GetObjById(dwItemId);
	if not pItem then
		Dialog:Say("你的种子过期了。");
		return;
	end
	
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
			Dialog:SendBlackBoardMsg(pPlayer, "你今天通过种树得到的经验已达上限，种树不会再增加经验了。");
		end
		
		GeneralProcess:StartProcess("植树中", 5 * Env.GAME_FPS, 
			{SpecialEvent.ZhiShu2009.Plant1stTree, SpecialEvent.ZhiShu2009, pPlayer, dwItemId}, nil, tbEvent);
				
	elseif szMsg then
		Dialog:Say(szMsg);
	end
end

-- 饱满的树种
local tbNewSeed = Item:GetClass("new_seed_arbor_day_09");
function tbNewSeed:InitGenInfo()
	it.SetTimeOut(0, GetTime() + 24 * 3600);
	return {};
end

-- 洒水壶
local tbJug = Item:GetClass("jug_arbor_day_09");
function tbJug:InitGenInfo()
	it.SetTimeOut(0, Lib:GetDate2Time(20100518));
	return {};
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_zhishujie\\tree_item.lua")