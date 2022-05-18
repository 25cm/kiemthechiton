
do return end

Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Double.TuoGuan = EventKind;

function EventKind:ExeStartFun()
	--执行双倍；
	--local szMsg = self.tbEventPart.szName .. "双倍启动";
	--KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	return 0;
end

function EventKind:ExeEndFun()
	--结束双倍;
	--local szMsg = self.tbEventPart.szName.."双倍结束";
	--KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	return 0;
end