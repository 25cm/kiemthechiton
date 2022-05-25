-------------------------------------------------------------------
--File: 	base.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:
--InterFace2:
--InterFace3:
-------------------------------------------------------------------
Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Module.npc_multdialog = EventKind;

function EventKind:OnDialog(szMsgFlag)
	if not szMsgFlag then
		 
		local szMsg 	= EventManager.tbFun:SplitStr(EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "SetLayer1Msg")[1] or "��ã���ʲô��Ҫ��æ��")[1];
		local tbSelect 	= EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "SetLayer2Msg");
		
		local tbOpt = {};
		for nId, szSelect in ipairs(tbSelect) do
			local tbParam = EventManager.tbFun:SplitStr(szSelect);
			table.insert(tbOpt, {EventManager.tbFun:StrVal(tbParam[1]), self.OnDialog, self, tbParam[2] or "��ã���ʲô��Ҫ��æ��"});
		end
		table.insert(tbOpt, {"�����Ի�"});
		Dialog:Say(EventManager.tbFun:StrVal(szMsg), tbOpt);
		return 0;
	end
	Dialog:Say(szMsgFlag);
	return 0;
end

