local tbValentineTitle = {};
SpecialEvent.ValentineTitle2009 = tbValentineTitle;

tbValentineTitle.tbLovers = {
	{"04","É²ÄÇÄ§·¨Ê¦"},
	{"04","¡¾³Ùµ½Ç§Äê¡¿"},
	{"04","½ðÇ¹ºáÌìÏÂ"},
	{"04","Å¯Å¯µÄÐ¡¹Å"},
	{"04","·ãÑ©èÉÐÛ"},
	{"04","Æ¯ÒÝ·Æ¶ù"},
	{"06","³à½Å°¡±â"},
	{"06","³à½ÅÐ¡ÃÃ"},
	{"02","´óŒšücüc‰Ä"},
	{"02","Ð¡Œš¶ß¶ß¹Ô"},
	{"05","ÀmŒ‘‚÷Õf"},
	{"05","ÀmŒ‘Éñ»°"},
	{"03","ÃêÊÓÒ»ÇÐÀäÒ¯"},
	{"03","¡¤ÃÔÄãžz¡¤"},
	{"04","Ø­Á÷Ã¥×ùØ­Ø¼É¨»Æ"},
	{"04","¡¾°×ÒÂÄ§Å®¡¿"},
};

function tbValentineTitle:CanGetTitle(pPlayer)
	if tonumber(GetLocalDate("%Y%m%d")) >= 20090323 then
		return 0;
	end
	
	local szGatewayName = string.sub(GetGatewayName(),5,6);
	for _, tb in ipairs(self.tbLovers) do
		if tb[1] == szGatewayName and tb[2] == pPlayer.szName then
			return 1;
		end
	end
	return 0;
end

function tbValentineTitle:GetTitle(pPlayer)
	local tbTitle = {[0] = {6,3,1,0},[1] = {6,3,2,0}};
	
	if pPlayer.FindTitle(unpack(tbTitle[pPlayer.nSex])) == 0 then
		pPlayer.AddTitle(unpack(tbTitle[pPlayer.nSex]));
		SpecialEvent:WriteLog(Dbg.LOG_INFO, "tbValentineTitle:GetTitle", pPlayer.szName);
	else
		Dialog:Say("ÄúÒÑ¾­Áì¹ýÁË¡£");
	end
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_valentinetitle\\logic.lua")