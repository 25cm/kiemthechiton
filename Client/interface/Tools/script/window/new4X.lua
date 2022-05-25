
local szRootPath = KLib:GetRootPath(); 
local szVerPath  = "\\setting\\item\\001\\other\\version.cfg";
local szItemFile = "\\setting\\item\\001\\other\\scriptitem.txt"; 
local szItemPath = szRootPath.."\\setting\\item\\001\\other\\scriptitem.txt"; 
local szOldIcon  = "\\image\\item\\other\\scriptitem\\xuanjing_002_s.spr";
local szIconPath = "\\setting\\item\\001\\other\\xuanjing_lv4.spr";
local nTimerId   = 0;


function AutoAi:MarkXuanJing()	
	local szGameVersion = KFile.ReadTxtFile("\\version.cfg");
	local pTabFile = KFile.ReadTxtFile(szVerPath);
	if pTabFile and pTabFile == szGameVersion then	
		print("Phiên bản mới nhất,không cần cập nhật");
	else
		os.remove(szItemPath);
		print("Đã thay đổi hình HT 4");
		nTimerId = Timer:Register(18, AutoAi.ReplaceAndWrite);
	end		
end


function AutoAi:ReplaceScriptItemText()	
	local pTabFile = KFile.ReadTxtFile(szItemFile);
	local tbStr  = Lib:SplitStr(pTabFile, "Huyền Tinh Cấp 4");
	local tmpStr = "";
	local szStr  = "";
	tmpStr = tmpStr..tbStr[1].."Huyền Tinh Cấp 4";
	szStr  = Lib:ReplaceStr(tbStr[2], szOldIcon, szIconPath);
	tmpStr = tmpStr..szStr.."Huyền Tinh Cấp 4";
	szStr  = Lib:ReplaceStr(tbStr[3], szOldIcon, szIconPath);
	tmpStr = tmpStr..szStr;
	return tmpStr;
end


function AutoAi:ReplaceAndWrite()
	local szIconSprFile = "";
	
	
	local szGameVersion = KFile.ReadTxtFile("\\version.cfg");
	
	
	local szWriteData = AutoAi:ReplaceScriptItemText();
	
	
	KFile.WriteFile(szItemFile, szWriteData);
	
	
	KFile.WriteFile(szVerPath, szGameVersion);	
	
	
	local tbNameList = KInterface.GetPluginNameList();
	local tbPluginInfoList = {};
	for _, szName in pairs(tbNameList) do
		local tempFile = KFile.ReadTxtFile("\\interface\\"..szName.."\\xuanjing_lv4.spr");
		if tempFile then
			szIconSprFile = tempFile;
			break;
		end
	end	
	

	local szIconFile = KFile.ReadTxtFile(szIconPath);
	if not szIconFile then
		KFile.WriteFile(szIconPath, szIconSprFile);
	end
	

	if nTimerId > 0 then
		Timer:Close(nTimerId);
	end
	return 0;
end	


function Lib:ReplaceStr(szStr, szFrom, szTo)	
	local nStart, nEnd	= string.find(szStr, szFrom);
	if nStart then
		szStr	= string.sub(szStr, 1, nStart - 1) .. szTo .. string.sub(szStr, nEnd + 1);
	end
	return szStr;
end

AutoAi:MarkXuanJing();