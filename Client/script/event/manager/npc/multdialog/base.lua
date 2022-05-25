-------------------------------------------------------------------
--File: 	base.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:
--InterFace2:
--InterFace3:
-------------------------------------------------------------------
do return end
Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Npc.MultDialog = EventKind;

function EventKind:OnDialog(szMsgFlag)
	if not szMsgFlag then
		 
		local szMsg 	= EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "szMsg")[1] or "��ã���ʲô��Ҫ��æ��";
		local tbSelect 	= EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "szSel");
		local tbMsg	   	= EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "szSelMsg");
		
		local tbOpt = {};
		for nId, szSelect in ipairs(tbSelect) do
			table.insert(tbOpt, {szSelect, self.OnDialog, self, tbMsg[nId] or "��ã���ʲô��Ҫ��æ��"});
		end
		table.insert(tbOpt, {"�����Ի�"});
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	Dialog:Say(szMsgFlag);
	return 0;
end

