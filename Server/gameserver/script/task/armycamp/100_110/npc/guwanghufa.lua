-----------------------------------------------------------
-- 文件名　：guwanghufa.lua
-- 文件描述：蛊王护法
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-27 10:28:48
-----------------------------------------------------------

-- 蛊王护法
local tbHuFa = Npc:GetClass("guwanghufa");

tbHuFa.DENG_ID = 4147;
-- 五行及颜色
tbHuFa.tbSeries = {{"Kim", 0}, {"Mộc", 1}, {"Thổ", 4}, {"Thủy", 2}, {"Hỏa", 3}};


tbHuFa.tbPos = {{1842, 2768}, {1878, 2858}, {1840, 2931}, {1767, 2891}, {1767, 2810}}

tbHuFa.tbText = {
	{"Cái chết của tôi chẳng là gì cả! "," Cổ Vương chắc chắn sẽ khiến chúng ta tái sinh！"},
	{{"Cổ Thần, cứu tôi! "," Người bảo vệ của ta "}, {" Đồ ngốc, tôi phải quan tâm đến một vấn đề tầm thường như vậy! "," Cổ Vương"}},
}

function tbHuFa:OnDeath(pNpc)

	local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nChangShengDengCount >= 5) then
		return;
	end;

	him.SendChat(self.tbText[2][1][1]);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[2][1][1], him.szName);
		teammate.Msg(self.tbText[2][2][1], self.tbText[2][2][2]);
	end;	
	tbInstancing.nChangShengDengCount = tbInstancing.nChangShengDengCount + 1;

	local nIndex = him.GetTempTable("Task").nId;
	if (not nIndex or nIndex > 5) then
		return;
	end;

	local pDeng = KNpc.Add2(self.DENG_ID, 110, tbInstancing.tbChangShengDeng[tbInstancing.nChangShengDengCount], 
		nSubWorld, self.tbPos[nIndex][1], self.tbPos[nIndex][2], 0, 0, 0, 0, self.tbSeries[tbInstancing.tbChangShengDeng[tbInstancing.nChangShengDengCount]][2]);
	assert(pDeng);
	
	local pPlayer  	= pNpc.GetPlayer();
	-- 灯的序号
	local nIndex = tbInstancing.tbChangShengDeng[tbInstancing.nChangShengDengCount];
	if (not nIndex) then
		return;
	end;
	pDeng.GetTempTable("Task").nNo = nIndex;
	pDeng.GetTempTable("Task").nCheck = 0; 
	
	local szTitle = pDeng.szName .. "(" .. self.tbSeries[nIndex][1] .. ")";
	pDeng.szName = szTitle;

end;


function tbHuFa:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing:NpcSay(him.dwId, self.tbText[1]);
end;