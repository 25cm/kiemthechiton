-- 文件名　：huihuangzhiguo_GS.lua
-- 创建者　：zhongchaolong
-- 创建时间：2007-10-11 11:50:00
--只放gameserver
--有关辉煌之种的活动行为，
--1、负责刷种子果子的npc
--2、根据角色等级返回，对应种子的等级
--3、返回黄金种子在哪个城市刷

Require("\\script\\event\\huihuangguo\\huihuangzhiguo_head.lua")
HuiHuangZhiGuo.tbSeedPos = {};

HuiHuangZhiGuo.nGoldenSeedRow			= 0;--黄金之种子所在的行数
HuiHuangZhiGuo.nNpcSeedTmpl				= 2609;--普通辉煌之种的模板id
HuiHuangZhiGuo.nNpcGoldenSeedTmpl		= 2610;--黄金辉煌之种的模板id
HuiHuangZhiGuo.nNpcFruitTmpl			= 2611;--普通辉煌之果的模板id
HuiHuangZhiGuo.nNpcGoldenFruitTmpl		= 2612;--黄金辉煌之果的模板id

local tbConfig =
{
	--[nMapId] = {szCityName,szMapName,szPosFile}
	[30] = {szMapName = "Chiến Trường Cổ",szPosFile = "\\setting\\event\\huihuangzhiguo\\guzhanchang\\seedposfile.txt"},
	[31] = {szMapName = "Quán Trọ Long Môn",szPosFile = "\\setting\\event\\huihuangzhiguo\\longmenkezhan\\seedposfile.txt"},
	[32] = {szMapName = "Quân Mã Trường",szPosFile = "\\setting\\event\\huihuangzhiguo\\junmachang\\seedposfile.txt"},
	[33] = {szMapName = "Mai Hoa Lĩnh",szPosFile = "\\setting\\event\\huihuangzhiguo\\meihualing\\seedposfile.txt"},
	[34] = {szMapName = "Trường Giang Hà Cốc",szPosFile = "\\setting\\event\\huihuangzhiguo\\changjianghegu\\seedposfile.txt"},
	[35] = {szMapName = "Thị trấn Bạch Tộc",szPosFile = "\\setting\\event\\huihuangzhiguo\\baizushiji\\seedposfile.txt"},
	[36] = {szMapName = "Nhạn Đãng Long Thu",szPosFile = "\\setting\\event\\huihuangzhiguo\\yandanglongqiu\\seedposfile.txt"},
	[37] = {szMapName = "Bờ Hồ Động Đình",szPosFile = "\\setting\\event\\huihuangzhiguo\\dongtinghupan\\seedposfile.txt"},
};

function HuiHuangZhiGuo:GreatSeedExecute(nMapId, nSeedLevel, nCount, nGrowPhase, nWetherMakeGoldFruit)
	--GC调用的显示辉煌之种函数
	-- 判断地图是否存在
	local nWorldIdx = SubWorldID2Idx(nMapId);
	if (nWorldIdx < 0) then	--如果不在该组服务器上
		print("没有这个地图");
		return
	end
	self:AddMapSeeds(nWorldIdx, nMapId, nSeedLevel, nCount,nWetherMakeGoldFruit, nGrowPhase);
end

--以下是刷出npc的部分
function HuiHuangZhiGuo:AddSeed(nNpcTmpl,nWorldIdx,nPosX,nPosY,nSeedLevel)
	if (nil ~= nPosX and nil ~= nPosY) then
		local pNPC = KNpc.Add(nNpcTmpl,nSeedLevel,Env.SERIES_NONE,nWorldIdx,nPosX*1,nPosY*1,0,0,0);
		local tbNpcInfo = pNPC.GetTempTable("HuiHuangZhiGuo");
		tbNpcInfo.nPlantTime = GetTime();
	end
end

function HuiHuangZhiGuo:AddMapSeeds(nWorldIdx, nMapId, nSeedLevel, nCount,  nWetherMakeGoldFruit, nGrowPhase)
	--显示辉煌之种与辉煌之果，先删除之前的种子
	local i					= 0;
	local nPosX				= 0;
	local nPosY				= 0;
	local nGoldenIndex		= 0;--黄金果子的坐标所在的表的索引
	local nNpcTmpl			= 0;--当前普通npc模板id
	local nNpcGoldenTmpl	= 0;--当前黄金npc模板id
	local nLineCount		= 0;--坐标表的行数
	
	if (nGrowPhase == 0) then --刷种子时,坐标表的处理
		if (self.tbSeedPos[nMapId] == nil) then
			self.tbSeedPos[nMapId]	= {};
			self.tbSeedPos[nMapId]	= Lib:LoadTabFile(tbConfig[nMapId].szPosFile);
		end
		
		if (self.tbSeedPos[nMapId] == nil) then --读取失败时
			print("read posfile error: %s",tbConfig[nMapId].szPosFile);
			Dbg:WriteLog("Quả Huy Hoàng : Tải file thất bại");
			return 0;
		end

		nLineCount = #self.tbSeedPos[nMapId];--坐标表的行数
		
		if (nLineCount > nCount) then --如果点数比行数少，打乱这个表，实现随机选点
			Lib:SmashTable(self.tbSeedPos[nMapId]);--打乱这个表
		elseif (nLineCount < nCount) then --点数多于行数时
			nCount = nLineCount;		
		end
		if (nWetherMakeGoldFruit == 1) then --如果这个城市需要产生黄金之种
			self.nGoldenSeedRow = MathRandom(1,nCount);
		end
	else
		if (self.tbSeedPos[nMapId] == nil) then --上次刷种子失败
			Dbg:WriteLog("Quả Huy Hoàng", "không có quả huy hoàng");
			return 0;
		end
	end
	
	if (nGrowPhase == 1) then --删除之前的npc
		ClearMapNpcWithName(nMapId, "Hạt Giống Huy Hoàng");
		ClearMapNpcWithName(nMapId, "Hạt Giống Hoàng Kim");
	else
		ClearMapNpcWithName(nMapId, "Quả Huy Hoàng");
		ClearMapNpcWithName(nMapId, "Quả Hoàng Kim");
	end
	
	if (nGrowPhase == 0) then --没有成熟,是产生种子
		--npc模板
		nNpcTmpl		= self.nNpcSeedTmpl;
		nNpcGoldenTmpl	= self.nNpcGoldenSeedTmpl;
	else --成熟了 产生果子
		--npc模板
		nNpcTmpl		= self.nNpcFruitTmpl;
		nNpcGoldenTmpl	= self.nNpcGoldenFruitTmpl;
	end
	
	
	for i = 1, nCount do
		nPosX = self.tbSeedPos[nMapId][i].TRAPX;
		nPosY = self.tbSeedPos[nMapId][i].TRAPY;
		if (i ~= self.nGoldenSeedRow or nWetherMakeGoldFruit ~= 1) then --普通果子
			self:AddSeed(nNpcTmpl,nWorldIdx,nPosX,nPosY,nSeedLevel);
		else--如果是黄金之种或黄金之果
			--需要公告下
			if (nGrowPhase == 0) then
				KDialog.NewsMsg(1, Env.NEWSMSG_COUNT, string.format("Tại %s Xuất hiện Hạt Giống Huy Hoàng", tbConfig[nMapId].szMapName));
			else
				KDialog.NewsMsg(1, Env.NEWSMSG_COUNT, string.format("%s Xuất Hiện Hạt Giống Hoàng Kim", tbConfig[nMapId].szMapName));
--				KGblTask.SCSetDbTaskInt(DBTASK_HuangJinZhiZhong_MapId,0);
			end
			self:AddSeed(nNpcGoldenTmpl,nWorldIdx,nPosX,nPosY,nSeedLevel);
		end
	end
end
--以上是刷npc的部分

function HuiHuangZhiGuo:GetGoldenSeedInWhere() --得到黄金之种子的所在地图
	local nGoldSeedMapId = KGblTask.SCGetDbTaskInt(DBTASK_HuangJinZhiZhong_MapId);
	if (tbConfig[nGoldSeedMapId] == nil) then
		return nil
	end
	return tbConfig[nGoldSeedMapId].szMapName;
end

function HuiHuangZhiGuo:GetPlayerRank() --根据人物等级返回对应的种子等级
	--返回 0 表示 70级以下 ， 1 表示70-99级	
	local nLevel = me.nLevel;
	if (nLevel < 70) then
		return 0;
	elseif (nLevel <= 99) then
		return 1;
	end
	return 0;
end

--以下npc对话部分
function HuiHuangZhiGuo:ShowEventInfo(szItemName)
	local szContent;
	local szGoldSeedMapName = self:GetGoldenSeedInWhere();
	szGoldSeedMapName = szGoldSeedMapName or "không biết"
	local tbOpt = 
	{
		{"Trở về","HuiHuangZhiGuo:OnDialog"},
		{"Kết thúc đối thoại"}
	}
	if (szItemName == "Quả Huy Hoàng") then
		szContent = "    <color=red>Mỗi Đêm Vào Lúc 19h30 Đến 20h00<color> trong thời gian này các map thông trấn xuất hiện Quả Huy Hoàng<color=red>5 ra quả<color>，và<color=red>3 phút kết trái<color>.<enter><enter><color=yellow> Xuất hiện tại：<enter>    Chiến Trường Cổ,Quán Trọ Long Môn,Quân Mã Trường,Mai Hoa Lĩnh,Trường Giang Hà Cốc,Thị trấn Bạch Tộc,Nhạn Đãng Long Thu,Bờ Hồ Động Đình<color><enter><enter><color=yellow> Hái Quả：<enter>    Trong thời gian hái quả không được cùng lúc hái quả khác nếu không quả đang hái sẽ bị giành mất.<color>";
	elseif (szItemName == "Quả Hoàng Kim") then
		szContent = string.format("Quả Hoàng Kim<enter>    Quả Hoàng Kim mỗi ngày xuất hiện 1 lần duy trì 1 phút tăng trường, hái được quả khi sử dụng nhận được trạng thái vô song và nhiều phần quà hấp dẫn<enter><enter><color=yellow>Xuất hiện địa điểm ：%s。<color>", szGoldSeedMapName);
	end
	Dialog:Say(szContent,tbOpt);
end
function HuiHuangZhiGuo:OnDialog()
	local szGoldSeedMapName = self:GetGoldenSeedInWhere();
	local szTitle;
	if (szGoldSeedMapName ~= nil ) then
		szTitle = string.format("Đêm nay 7h30 Quả Huy Hoàng xuất hiện trên bản đồ [<color=yellow>%s<color>]",szGoldSeedMapName);
	else
		szTitle = "Hôm nay Quả Hoàng Kim xuất hiện tại <color=yellow>không biết<color>。";
	end
	local tbOpt = 
	{
		{"Quả Huy Hoàng","HuiHuangZhiGuo:ShowEventInfo","Quả Huy Hoàng"},
		{"Quả Hoàng Kim","HuiHuangZhiGuo:ShowEventInfo","Quả Hoàng Kim"},
		{"Kết thúc đối thoại"}
	}
	Dialog:Say(szTitle,tbOpt);
end
--以上npc对话部分
