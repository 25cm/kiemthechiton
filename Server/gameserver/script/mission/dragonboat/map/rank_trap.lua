-- �ļ�������rank_trap.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-11 11:10:35
-- ��  ��  ������trap��


local tbMap 	= Map:GetClass(1535);

local tbTrap 	= {};
function tbTrap:OnPlayer()
	local nRank = self.nRank;
	local tbMis = Esport.DragonBoat:GetPlayerMission(me);
	if tbMis and tbMis:IsOpen() == 1 then
		local nSaveRank = tbMis:GetRank(me);
		if tbMis:GetPlayerGroupId(me) > 0 and nRank ~= nSaveRank and nSaveRank < Esport.DragonBoat.DEF_FINISH_RANK then
			tbMis:SetRank(nRank);
		end
	end
end

for nRank = 0, 69 do
	local tbTemp = tbMap:GetTrapClass("pm"..nRank);
	for szFnc in pairs(tbTrap) do			-- ���ƺ���
		tbTemp[szFnc] = tbTrap[szFnc];
	end
	tbTemp.nRank = nRank;
end
