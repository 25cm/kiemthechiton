Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Module.action_callnpc = EventKind;

function EventKind:ExeNpcStartFun(tbParam)
	return EventManager.EventKind.Module.default.ExeNpcStartFun(self, tbParam);
end

function EventKind:ExeNpcEndFun(tbNpc)
	--Ö´ĞĞÕÙ»½¹ÖÎï½áÊø;
	return EventManager.EventKind.Module.default.ExeNpcEndFun(self, tbNpc);
end

