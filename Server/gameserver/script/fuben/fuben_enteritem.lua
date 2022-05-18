-- ÎÄ¼şÃû¡¡£ºfuben.lua
-- ´´½¨Õß¡¡£ºjiazhenwei
-- ´´½¨Ê±¼ä£º2009-12-7
-- Ãè  Êö  £º

-- ¸±±¾µÀ¾ß½Å±¾

local tbFuBen= Item:GetClass("fuben_enter");

function tbFuBen:OnUse()	
	local tbOpt = {};
	local szMsg = "Sao chÃ©p vÃ o cÃ¡c mÃ£ thÃ´ng bÃ¡o,Ä‘Æ°a báº¡n Ä‘áº¿n má»™t phÃ³ báº£n cá»§a Ä‘á»™i trÆ°á»¡ng Ä‘Ã£ má»Ÿ";
	tbOpt = {
			{"Thá»±c hiá»‡n theo Ä‘á»™i trÆ°á»¡ng", Npc:GetClass("dataosha_city").OnEnter, Npc:GetClass("dataosha_city"), me.nId},
			{"Há»§y Bá»"},
		};
	Dialog:Say(szMsg, tbOpt);
	return;
end
	