
Ui.tbLogic.tbMsgInfo = {};

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local tbTimer = Ui.tbLogic.tbTimer;

--[[ ����
function xxx:MsgBoxExample(...)
	local tbMsg = {};
	tbMsg.szTitle = "����";
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "��ť1", "��ť2" };
	tbMsg.nTimeout = 10;
	tbMsg.szMsg = "����MsgBox��ʹ�����ӡ��۹���";
	function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
		if (nOptIndex == 0) then
			me.Msg("[MsgBox����]��ʱ��...("..varParm1..", "..varParam2..")");
		elseif (nOptIndex == 1) then
			me.Msg("[MsgBox����]����˰�ť1...("..varParm1..", "..varParam2..")");
		elseif (nOptIndex == 2) then
			me.Msg("[MsgBox����]����˰�ť2...("..varParm1..", "..varParam2..")");
		end
	end
	local szKey = "MsgBoxExample";		-- ����ʶ���ظ���Ϣ����Ϣ���ң����ɹ����Լ�����
	tbMsgInfo:AddMsg(szKey, tbMsg, "����1", "����2", "...");
end
--]]

function tbMsgInfo:Init()
	self.tbTop   = nil;		-- ��ǰ������ʾ����
	self.tbQueue = {};		-- ����ʾ����
	UiNotify:RegistNotify(UiNotify.emUIEVENT_WND_CLOSED, self.OnMsgBoxClosed, self);
end

function tbMsgInfo:Clear()
	self:Init();
	self:Update();			-- ͨ�����¹ص�UI_MSGINFO
end

function tbMsgInfo:AddMsg(szKey, tbMsg, ...)		-- ���һ����Ϣ

	if (not tbMsg) then
		return;
	end

	local tbOrg, i = self:GetMsg(szKey);
	if szKey and (szKey ~= "") and tbOrg then		-- ���Ҫ�������Ϣ�Ѵ��ڲ��Ҳ��ڶ��ף�����Ҫ������ǰ�����ף��������ȼ���
		if (i > 1) then
			table.insert(self.tbQueue, 1, tbOrg);	-- �嵽����
			table.remove(self.tbQueue, i + 1);		-- ɾ��ԭ����
		end
		return;
	end

	tbMsg.bExclusive = 0;				-- UI_MSGINFO�е���Ϣ���ǷǶ�ռ��
	local tbInfo = { szKey = szKey, tbMsg = tbMsg, tbArgs = arg };
	if (not self.tbTop) then
		self.tbTop = tbInfo;	-- �����һ����Ϣ
	else
		table.insert(self.tbQueue, 1, tbInfo);	-- ��Ϊ�գ��¼ӵ�����
	end

	if (#self.tbQueue == 0) then		-- ֻ�е���һ����Ϣ������ʱ����Ҫ������ʾ����ʱ����Ϊ�գ�
		self:Update();
	end

end

function tbMsgInfo:DelMsg(szKey)		-- ɾ��ָ����Ϣ��ƥ��ؼ��֣��ж���ɾ���٣�

	-- �������Ҳ��Ҫ��ɾ�������ȹرյ�ǰ����
	-- ע�������Ǹ�ѭ�����ص���ǰ���ڵ�ͬʱ�������е���һ����Ϊ�µĶ��ף���Ȼ��Ҫ���֮
	while true do
		if (not self.tbTop) then
			return;						-- �����ѿգ�����Ҫ������
		end
		if (self.tbTop.szKey ~= szKey) then
			break;						-- ���ײ���Ҫɾ������˳����ڹرռ��
		end
		self:DelTopMsg();				-- ɾ������
	end

	local i = 1;

	-- ע������ֻ����while���κ���ʽ��for�ƺ����޷��õ���ȷ���
	while (i <= #self.tbQueue) do
		local tbInfo = self.tbQueue[i];
		if (tbInfo.szKey == szKey) then
			table.remove(self.tbQueue, i);
		else
			i = i + 1;
		end
	end

end

function tbMsgInfo:GetMsg(szKey)		-- ��ȡָ����Ϣ��ƥ��ؼ��֣����ص�һ����
	if (not self.tbTop) then
		return;
	end
	if (self.tbTop.szKey == szKey) then
		return self.tbTop, 0;
	end
	for i, tbInfo in ipairs(self.tbQueue) do
		if (tbInfo.szKey == szKey) then
			return tbInfo, i;
		end
	end
end

function tbMsgInfo:DelTopMsg()			-- ɾ��������Ϣ
	if (not self.tbTop) then
		return;
	end
	self.tbTop = nil;
	if (#self.tbQueue > 0) then
		self.tbTop = self.tbQueue[1];
		table.remove(self.tbQueue, 1);
	end
	self:Update();
end

function tbMsgInfo:Update()
	if (self.tbTop) then
		UiManager:OpenWindow(Ui.UI_MSGINFO, self.tbTop.tbMsg, unpack(self.tbTop.tbArgs));
	else
		UiManager:CloseWindow(Ui.UI_MSGINFO);
	end
end

function tbMsgInfo:OnMsgBoxClosed(szUiGroup)
	if (szUiGroup == Ui.UI_MSGINFO) then
		self:DelTopMsg();
	end
end
