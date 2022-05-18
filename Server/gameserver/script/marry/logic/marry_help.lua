-------------------------------------------------------
-- 文件名　：marry_help.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-01-27 18:44:31
-- 文件描述：
-------------------------------------------------------

Require("\\script\\marry\\logic\\marry_def.lua");

if (not MODULE_GAMESERVER) then
	return 0;
end

-- 皇家婚礼
function Marry:UpdateHelpSuper(nDay)
	
	local nRet, szMaleName, szFemaleName, _, szDate = Marry:GetCurWeekSuperInfo(nDay);	
	
	if nRet then
		
		local nAddTime = GetTime();
		local nEndTime = nAddTime + 60 * 60 * 24 * 30;
		local nKinIdMale = KKin.GetPlayerKinMember(KGCPlayer.GetPlayerIdByName(szMaleName));
		local nKinIdFemale = KKin.GetPlayerKinMember(KGCPlayer.GetPlayerIdByName(szFemaleName));
		local pKinMale = KKin.GetKin(nKinIdMale);
		local pKinFemale = KKin.GetKin(nKinIdFemale);
		
		local szMaleKin = "Vô";
		local szFemaleKin = "Vô";
		
		if pKinMale then
			szMaleKin = pKinMale.szName;
		end
		
		if pKinFemale then
			szFemaleKin = pKinFemale.szName;
		end
		
		szMaleKin = szMaleKin .. " gia tộc";
		szFemaleKin= szFemaleKin .. " gia tộc";
		
		local szMsg = string.format([[
	
<bclr=red><color=yellow>Đại gia tổ chức [Hoàng Gia Khánh Điển] là: <color><bclr>
	
<color=yellow>    %s<color>
	
<bclr=red>%s<bclr>  <pic=49>  <bclr=red>%s<bclr>
<color=gold>%s<color>       <color=gold>%s<color>

<color=yellow>    Nếu như trong cuộc đời chỉ có thể thực hiện một người nguyện vọng, như vậy ta nguyện cho ta tối quý trọng nhân bằng thực sự tình ý! Điển lễ đích lễ nhạc đã tấu hưởng, tại đây khói lửa xán lạn đích mỗi một một trong nháy mắt, chúng ta đích toàn bộ thế giới đều muốn trở nên huyến lệ, tân kỳ! <color>
            <pic=\image\effect\fightskill\public\jiehun\qw.spr>

]], szDate, Lib:StrFillR(szMaleName, 30), Lib:StrFillL(szFemaleName, 30), Lib:StrFillR(szMaleKin, 30), Lib:StrFillL(szFemaleKin, 30));
		
		Task.tbHelp:AddDNews(Task.tbHelp.NEWSKEYID.NEWS_MARRY_SUPER, "[Hoàng Gia Khánh Điển]", szMsg, nEndTime, nAddTime);
	end
end

-- 每日婚礼
function Marry:UpdateHelpDaily(nDate)
	
	local tbMsg = {[1] = "", [2] = "", [3] = "", [4] = ""};
	local nCurrDate = nDate or tonumber(GetLocalDate("%Y%m%d"));	
	for nWeddingLevel, tbMap in pairs(self.tbGlobalBuffer) do
		local tbRow = tbMap[nCurrDate];
		if tbRow then
			if nWeddingLevel <= 2 then
				for nIndex, tbInfo in pairs(tbRow) do
					tbMsg[nWeddingLevel] = tbMsg[nWeddingLevel] 
						.. string.format("<color=yellow>%s<color>", Lib:StrFillR(tbInfo[1], 16)) 
						.. " và "
						.. string.format("<color=yellow>%s<color>", Lib:StrFillL(tbInfo[2], 16));
					if math.mod(#tbMsg[nWeddingLevel], 2) == 0 then
						tbMsg[nWeddingLevel] = tbMsg[nWeddingLevel] .. "\n";
					end
				end
			else
				tbMsg[nWeddingLevel] = string.format("<color=yellow>%s<color>", Lib:StrFillR(tbRow[1], 16))
				.. " và " .. string.format("<color=yellow>%s<color>", Lib:StrFillL(tbRow[2], 16));
			end
		end
	end
	
	local nAddTime = GetTime();
	local nEndTime = nAddTime + 60 * 60 * 24 * 30;
		
	local szMsg = string.format([[
<color=yellow>Danh sách lễ cưới ngày hôm nay tại server: <color>

<bclr=red><color=yellow>Lễ cưới Hoàng Gia: <color><bclr>
    %s

<bclr=blue><color=yellow>Lễ cưới Vương Hầu: <color><bclr>
    %s

<color=gold>Lễ cưới Quý Tộc: <color>
    %s

<color=green>Lễ cưới Hiệp Sỹ: <color>
    %s
]], tbMsg[4], tbMsg[3], tbMsg[2], tbMsg[1]);
		
	Task.tbHelp:AddDNews(Task.tbHelp.NEWSKEYID.NEWS_MARRY_DAILY, "Danh sách lễ cưới hôm nay", szMsg, nEndTime, nAddTime);
end
