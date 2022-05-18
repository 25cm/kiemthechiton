-----------------------------------------------------------
-- 文件名　：taohuazhangnpc.lua
-- 文件描述：桃花瘴区脚本 [鼎]
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-26 20:23:33
-----------------------------------------------------------

-- 桃花瘴区鼎
local tbNpc = Npc:GetClass("jiuningding");

tbNpc.tbNeedItemList = 
{
	{20, 1, 623, 1, 20},
}
function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nTaoHuaZhangPass == 0) then
		Dialog:Say("Lò luyện này có thể chế thuốc giải khi bị dính độc!",
			{
				{"[Chế thuốc]", self.Pharmacy, self, tbInstancing, me.nId},
				{"[Kết thúc đối thoại]"}
			});
	end
end

function tbNpc:Pharmacy(tbInstancing, nPlayerId)
	Task:OnGift("Đặt vào 20 Nhiếp Không Thảo.", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing}, true);
end;

function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	assert(pPlayer);
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Thuốc đã được chế, ngươi sẽ không còn bị dính độc!");
	end;
	-- 删除桃花瘴的瘴气
	for i = 1, 3 do 
		if (tbInstancing.tbZhangQiId[i]) then
			local pNpc = KNpc.GetById(tbInstancing.tbZhangQiId[i]);
			if (pNpc) then
				pNpc.Delete();
			end;
		end;
	end;
	
	-- 删除禁制
	if (tbInstancing.nJinZhiTaoHuaLin) then
		local pNpc = KNpc.GetById(tbInstancing.nJinZhiTaoHuaLin);
		if (pNpc) then
			pNpc.Delete();
		end;
	end;
	-- 添加天绝使	
	local pTianJueShi = KNpc.Add2(4150, tbInstancing.nNpcLevel, -1 , tbInstancing.nMapId, 1710, 3100); -- 天绝使
	local tbTianJueShi = Npc:GetClass("tianjueshi");
	tbInstancing:NpcSay(pTianJueShi.dwId, tbTianJueShi.tbText);
	pTianJueShi.GetTempTable("Task").tbSayOver = {tbTianJueShi.SayOver, tbTianJueShi, tbInstancing, pTianJueShi.dwId, nPlayerId};
	
	-- 设置桃花瘴可以通过
	tbInstancing.nTaoHuaZhangPass = 1;
end;

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nTaoHuaZhangPass == 1) then
		return 0;
	end	
	return 1; 
end

-- 桃花瘴 天绝使
local tbTianJueShi = Npc:GetClass("tianjueshi");

tbTianJueShi.tbText = {
"Bạn là ai? Làm sao bạn biết cách vào núi?",
"Có phải không? Không! Không thể!",
"Không ổn rồi! Có người xông vào núi!",
}
tbTianJueShi.tbTrack = {{1704, 3095}, {1697, 3089}};

function tbTianJueShi:SayOver(tbInstancing, nNpcId, nPlayerId)
	assert(nNpcId and nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	assert(pNpc);
	
	tbInstancing:Escort(nNpcId, nPlayerId, self.tbTrack);
	pNpc.GetTempTable("Npc").tbOnArrive = {self.OnArrive, self, nNpcId, nPlayerId};
end;

function tbTianJueShi:OnArrive(nNpcId, nPlayerId)
	assert(nNpcId and nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end;
	
	pNpc.Delete();
end;

-- 桃花瘴指引
local tbTaoHusLinZhiYin = Npc:GetClass("taohualinzhiyin");

tbTaoHusLinZhiYin.szText = "    Phía trước là rừng hoa đào ở núi Đào Hoa Lâm nguy hiểm tự nhiên, chướng khí hoa đào trong rừng buồn cho người và vật, may mà chúng tôi biết đường.。\n\n    Bạn cần phải<color=red> Đánh bại Bích Lân Xà để nhận lấy 20 Nhiếp Không Thảo và đặt chúng vào Lò Chế Thuốc.<color> Khí dược luyện chế có thể dùng để chống độc làm tiêu tán chướng khí.";

function tbTaoHusLinZhiYin:OnDialog()
	local tbOpt = {{"Kết thúc đối thoại"}, };
	Dialog:Say(self.szText, tbOpt);
end;