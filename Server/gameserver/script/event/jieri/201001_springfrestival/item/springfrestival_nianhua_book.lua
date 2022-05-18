
local tbBook = Item:GetClass("collectionbook");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbBook:InitGenInfo()
	local nSec = Lib:GetDate2Time(SpringFrestival.nOutTime)
	it.SetTimeOut(0, nSec);
	return	{ };
end

function tbBook:GetTip()
	local szTip = "";
	for i, szName in ipairs(SpringFrestival.tbShengXiao) do
		local nFlag = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_NIANHUA_BOOK + i - 1) or 0;
		local szColor = "white";		
		if nFlag ~= 1 then 
			szColor = "gray"; 
		end	
		local szMsg = string.format("<color=%s>", szColor);		
		szTip = szTip..Lib:StrFillL("", 5)..szMsg .. Lib:StrFillL(szName, 5).."<color>";
		if math.fmod(i, 4) == 0 then
			szTip = szTip .."\n";
		end
	end	
	return szTip;
end
