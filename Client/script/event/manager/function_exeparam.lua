Require("\\script\\event\\manager\\define.lua");
local tbFun = EventManager.tbFun;
--�����жϲ�����Ӧ������

--���ú�����

--��ִͨ�к���

--�ѱ�֤��ǰmeΪ���
tbFun.tbExeParamFun = 
{
	SetItemTime 	= "ExeSetItemTime",		--��Ʒ���ʱ������ʱ��	
	SetAwardId  	= "ExeSetAwardId",		--������
	SetAwardIdUi	= "ExeSetAwardIdUi",	--������潱����
	SetMsg			= "ExeSetMsg",			--npc�Ի�����
	SetTask			= "ExeSetTask",			--��ͨ���������¼	
	SetTaskCurTime  = "ExeSetTaskCurTime",	--���õ�ǰʱ��
	SetGTask		= "ExeSetGTask",			--��ͨ���������¼	
	SetGTaskCurTime = "ExeSetGTaskCurTime",	--���õ�ǰʱ��	
	SetExt			= "ExeSetExt",			--��չ������ĳֵ
	SetTaskMsg		= "ExeSetTaskMsg",		--����ϵͳ����
	SetGTaskMsg		= "ExeSetGTaskMsg",		--����ϵͳ����
	SetNpcTask		= "ExeSetNpcTask",		--����npc��ʱ����ֵ
	
	SetLuaScript	= "ExeSetLuaScript",	--���ýű�
	CreateLink		= "ExeCreateLink",		--��������
	
	AddTaskDay		= "ExeAddTaskDay",		--ÿ�����������¼
	AddTask			= "ExeAddTask",			--��ͨ���������¼	
	AddGTaskDay		= "ExeAddGTaskDay",		--ÿ�����������¼
	AddGTask		= "ExeAddGTask",		--��ͨ���������¼		
	AddItem			= "ExeAddItem",			--������Ʒ
	AddBuffType		= "ExeAddBuffType",		--����buff�����ܾ���buff��Ԫ����ʹ�ù�1��
	AddTitle		= "ExeAddTitle",		--���ӳƺ�
	AddExt			= "ExeAddExt",			--��չ������ĳֵ
	AddSkillBuff	= "ExeAddSkillBuff",	--���Ӽ���buff
	AddNpcInNear	= "ExeAddNpcInNear",	--����npc
	AddBaseExp		= "ExeAddBaseExp",		--���ӻ�׼����
	AddExp			= "ExeAddExp",			--���Ӿ���
	AddBaseMoney	= "ExeAddBaseMoney", 	--���ӵȼ��������Ч�ʵİ�����
	AddFactionExSum = "ExeAddFactionExSum",	--���Ӹ��޻���
	AddBindMoney	= "ExeAddBindMoney",	--���Ӱ�����
	AddMoney		= "ExeAddMoney",		--��������
	AddBindCoin		= "ExeAddBindCoin",		--���Ӱ󶨽��
	AddBuyHeShiBiSum= "ExeAddBuyHeShiBiSum",--�������������������(��ٴ�����)
	AddNpcTask		= "ExeAddNpcTask",		--����npc��ʱ����ֵ
	
	MinusTask		= "ExeMinusTask",		--�����������	
	MinusGTask		= "ExeMinusGTask",		--�����������	
	
	OpenShop		= "ExeOpenShop",		--���̵�
	DelItem			= "ExeDelItem",			--ɾ����Ʒ
	DelLinkUseItem  = "ExeDelLinkUseItem",	--ɾ��ʹ����Ʒ�¼����ӹ�������Ʒ
	WriteLog		= "ExeWriteLog",					--�Զ����ռ�	
	GoToEvent		= "ExeGoToEvent",			--�¼���ת	
	GoToOtherEvent	= "ExeGoToOtherEvent",		--�¼���ת�������¼�	
	
	CoinBuyHeShiBi  = "ExeCoinBuyHeShiBi",	--��ҹ�����ϱڣ�

	AddXiulianTime 	= "ExeAddXiulianTime",	-- ��������ʱ��
	CallRabbit		= "ExeCallRabbit",			-- �ٻ��Ʊ���
	
	DelTitle		= "ExeDelTitle"	,			--ȥ���ƺ�	
	AddTongMoney 	= "ExeAddTongMoney",		--���Ӱ���ʽ�"szTongName,Money"	����ʽ�
	AddSpeTitle		= "ExeAddSpeTitle",			--�����Զ���ƺ�
	DelSpeTitle		= "ExeDelSpeTitle",			--ȥ���Զ���ƺ�	
	AddTaskRepute	= "ExeAddTaskRepute",		--��������
	DelTaskRepute	= "ExeDelTaskRepute",		--��������
	DelBaiJuTime	= "ExeDelBaiJuTime",		--���ٰ׾�ʱ��	
	AddKinRepute 	= "ExeAddKinRepute",		--���ӽ�������
	AddExBindCoinByPay = "ExeAddExBindCoinByPay",  --��ֵ��ȡ��𣨰�һ�����ʷ��أ�
	AddExOpenFuDai	= "ExeAddExOpenFuDai",		--���Ӷ��⿪��������
	AddExOpenQiFu	= "ExeAddExOpenQiFu",		--���Ӷ���������
	MinusKinRepute	= "ExeMinusKinRepute",		--���ٽ�������
	GiveBazhuStatuary 	= "ExeGiveBazhuStatuary",		--�����������֮ӡ�����ʸ�
	GiveKuaFuLianSaiStatuary 	= "ExeGiveKuaFuLianSaiStatuary",		--�������������������ʸ�
	AddHonor		= "ExeAddHonor",			--��������ֵ
	ClearMarry		= "ExeClearMarry",			--���Ԥ�����񣬲��۳����
};

--��player�޹ص�ִ�к���
tbFun.tbExeParamFunWithOutPlayer =
{
	SetLuaScriptNotMe= "ExeSetLuaScript",	--���ýű�
	DropNpc			= "ExeDropNpc",			--npc���䣨Id��
	DropNpcType		= "ExeDropNpcType",		--npc���䣨���ͣ���ͨ����Ϊclassname�����������ͣ�_JINGYING:��Ӣ��_SHOULING:���죬_ALLNPC:����npc��
	AddNewsMsg		= "ExeNewsMsg",			--���繫��
	OpenIBReturen	= "ExeOpenIBReturen",	--������ҷ���
	OpenDuKinQizi	= "ExeOpenDuKinQizi",	--�������忾�ھ��鷭��
	OpenJinTiaoFuLi = "ExeOpenJinTiaoFuLi",	--ʹ�ý�������
	OpenTongYinFuLi = "ExeOpenTongYinFuLi",	--ʹ�ð����������
	OpenDomainState = "ExeOpenDomain",		--���ð���֮ӡ��ǰ״̬-- 0 -- not open-- 1 -- intime-- 2 -- over
	SetBaiHuAwardTimes	= "ExeSetBaiHuAwardTimes",	--���Ӱ׻�boss���䱶��
	SetSongJinAwardTimes	= "ExeSetSongJinAwardTimes",	--�����ν�������
	SetLotterData	= "ExeSetLotteryData",		--���ó齱�����ں�����
};

--ִ�п���������ʱ�䵽�رտ�����������
tbFun.tbExeParamFunCloseEvent =
{
	OpenIBReturen 	= "ExeCloseIBReturen",	--�رս�ҷ���
	OpenDuKinQizi 	= "ExeCloseDuKinQizi",	--�رռ��忾�ھ��鷭��
	OpenJinTiaoFuLi = "ExeCloseJinTiaoFuLi",--�رս�������
	OpenTongYinFuLi = "ExeCloseTongYinFuLi",--�رհ����������	
	OpenDomainState = "ExeCloseDomain",		--���ð���֮ӡ��ǰ״̬-- 0 -- not open-- 1 -- intime-- 2 -- over
	SetBaiHuAwardTimes	= "ExeCloseBaiHuAwardTimes",	--�رհ׻�boss���䱶��
	SetSongJinAwardTimes	= "ExeCloseSongJinAwardTimes",	--�ر��ν�������
	SetLotterData = "ExeCloseLotteryData",	--�رճ齱
};

--����ִ��START----------
--������(nCheckType -  nil:��ͨ�ļ��,��麯����ִ��;  1:ѡ���麯��,ѡ����ʹ��)ִ�к�����ʹ������ 2:event�Ҳ���ʱ������
function tbFun:ExeParam(tbParam, nCheckType)
	if tbParam== nil then
		tbParam = {};
	end
	local nFlagW, szMsgW = self:ExeParamWithOutPlayer(tbParam, nCheckType)
	if nFlagW == 1 then
		return nFlagW, szMsgW;
	end
	local tbTaskPacth = self:GetParam(tbParam, "SetTaskBatch", 1);
	local nTaskPacth = 0;
	for _, nT in pairs(tbTaskPacth) do
		local nTempId = tonumber(nT) or 0;
		if nTempId > nTaskPacth then
			nTaskPacth = nTempId
		end
	end
	local nFlag = nil;
	if nCheckType == 2 then
		nFlag = 1;
	end	
	local nEventId 	= tonumber(self:GetParam(tbParam, "__nEventId",nFlag)[1]);
	local nPartId 	= tonumber(self:GetParam(tbParam, "__nPartId",nFlag)[1]);	
	EventManager:GetTempTable().BASE_nTaskBatch = nTaskPacth;
	EventManager:GetTempTable().nCurEventId = nEventId;
	EventManager:GetTempTable().nCurPartId  = nPartId;	
	local nReFlag = 0;
	local szReMsg = nil;
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbExeParamFun[szFlag] ~= nil then
				local fncExcute = self[self.tbExeParamFun[szFlag]];
				if fncExcute then
					if szContent ~= nil then
						local nFlag, szMsg = fncExcute(self, szContent, tbParam)
						if nFlag and nFlag ~= 0 then
							nReFlag = nFlag;
							szReMsg = szMsg;
							break;
							--����������.
						end;
					end
				end
			end
		end
	end
	EventManager:GetTempTable().BASE_nTaskBatch = 0;
	EventManager:GetTempTable().nCurEventId = 0;
	EventManager:GetTempTable().nCurPartId  = 0;	
	return nReFlag, szReMsg;
end

function tbFun:ExeParamWithOutPlayer(tbParam, nCheckType)
	if tbParam== nil then
		tbParam = {};
	end
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbExeParamFunWithOutPlayer[szFlag] ~= nil then
				local fncExcute = self[self.tbExeParamFunWithOutPlayer[szFlag]];
				if fncExcute then
					if szContent ~= nil then
						local nFlag, szMsg = fncExcute(self, szContent, tbParam)
						if nFlag and nFlag ~= 0 then
							return nFlag, szMsg;
							--����������.
						end;
					end
				end
			end
		end
	end
	return 0;
end

function tbFun:ExeParamCloseEvent(tbParam)
	if tbParam== nil then
		tbParam = {};
	end
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbExeParamFunWithOutPlayer[szFlag] ~= nil then
				local fncExcute = self[self.tbExeParamFunCloseEvent[szFlag]];
				if fncExcute then
					if szContent ~= nil then
						local nFlag, szMsg = fncExcute(self, szContent, tbParam)
						if nFlag and nFlag ~= 0 then
							return nFlag, szMsg;
							--����������.
						end;
					end
				end
			end
		end
	end
	return 0;
end

function tbFun:ExeSetItemLiveTime(szParam)
	if szParam == nil then
		print("���ϵͳ����ItemLiveTime��ʱ�޲�����");
		return 1;
	end
	if tonumber(szParam) ~= nil then
		it.SetTimeOut(0, (GetTime() + tonumber(szParam) * 60));
	end
	return {};
end

function tbFun:ExeSetItemTime(szParam)
	if szParam == "" then
		return 0;
	end
	if szParam == nil then
		print("���ϵͳ����ItemTime��ʱ�޲�����");
		return 1;
	end
	if tonumber(szParam) ~= nil then
		if tonumber(szParam) > 0 then
			me.SetItemTimeout(it, tonumber(szParam), 0);
		end
	else
		local nStartTime = self:DateFormat(szParam, 0);
		if nStartTime > 0 then
			local nSec = math.floor(((Lib:GetDate2Time(nStartTime) - GetTime()) / 60));
			if nSec > 0 then
				me.SetItemTimeout(it, nSec, 0);
			end
		end
	end
	it.Sync();
	return 0;
end

function tbFun:ExeSetAwardIdUi(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nParam = tonumber(tbParam[1]);	
	local szContent = "�����������:\n";
	local szMoney = "";
	for ni, tbItem in ipairs(self.AwardList[nParam].tbMareial) do
		if tbItem.nJxMoney ~= 0 then
			szMoney = string.format("%s%s����\n", szMoney, tbItem.nJxMoney);
		end
		
		if tbItem.nJxBindMoney ~= 0 then
			szMoney = string.format("%s%s������\n", szMoney, tbItem.nJxBindMoney);
		end
		
		if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			local szName = KItem.GetNameById(tbItem.nGenre,tbItem.nDetail,tbItem.nParticular,tbItem.nLevel);
			szContent = string.format("%s<color=yellow>%s<color>��<color=yellow>%s<color>\n", szContent, tbItem.nAmount, szName);
		end
	end
	szContent = string.format("%s%s", szContent, szMoney);
	EventManager.Gift:OnOpen(szContent, self.AwardList[nParam], tbGParam);	
end

--��������
function tbFun:ExeSetAwardId(nParam, tbParam)
	nParam = tonumber(nParam);
	if not nParam then
		print("���ϵͳ����TxtPath�������޲�����");
		return 1;
	end
	
	if not self.AwardList[nParam] then
		print("���ϵͳ����TxtPath���������ڡ�");
		return 1;		
	end
	
	for ni, tbItem in ipairs(self.AwardList[nParam].tbMareial) do
		self:_DelItem(me, tbItem);
	end
	
	self:_GetRandomAward(self.AwardList[nParam].nMaxProb, self.AwardList[nParam].tbAward);
end

function tbFun:_GetRandomAward(nMaxProb, tbParam)
	
	local nRateSum = 0;
	
	for nId, tbItem in pairs(tbParam) do
		if tbItem.nRandRate == 0 then
			self:_GetItem(me, tbItem);
		end
	end
	
	if nMaxProb > 0 then
		local nRate = MathRandom(1, nMaxProb);
		for nId, tbItem in pairs(tbParam) do
			nRateSum = nRateSum + tbItem.nRandRate;
			if nRate <= nRateSum then
				self:_GetItem(me, tbItem);
				return 1;
			end
		end	
	end
end

function tbFun:_GetItem(pPlayer, tbItem)
	local szGolbalAnnouce = string.format("%s���Ǻ��˵�ͷ", me.szName);
	if tbItem.nJxMoney ~= 0 then
		pPlayer.Earn(tbItem.nJxMoney, Player.emKEARN_EVENT);
		local szAnnouce = string.format("��ϲ�������<color=yellow>%s��<color>", tbItem.nJxMoney);
		pPlayer.Msg(szAnnouce);
		if tbItem.nAnnouce ~= 0 then
			szGolbalAnnouce = szGolbalAnnouce..string.format("�������<color=yellow>%s��<color>", tbItem.nJxMoney);
		end
		EventManager:WriteLog(string.format("�����%s��", tbItem.nJxMoney), pPlayer);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]����������%s",tbItem.nJxMoney));
	end
	
	if tbItem.nJxBindMoney ~= 0 then
		pPlayer.AddBindMoney(tbItem.nJxBindMoney, Player.emKBINDMONEY_ADD_EVENT);
		local szAnnouce = string.format("��ϲ�������<color=yellow>%s��������<color>", tbItem.nJxBindMoney);
		pPlayer.Msg(szAnnouce);
		if tbItem.nAnnouce ~= 0 then
			szGolbalAnnouce = szGolbalAnnouce..string.format("�������<color=yellow>%s��������<color>", tbItem.nJxBindMoney);
		end
		EventManager:WriteLog(string.format("�����%s��������", tbItem.nJxBindMoney), pPlayer);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ð�������%s",tbItem.nJxBindMoney));
	end
	
	if tbItem.nJxCoin ~= 0 then
		pPlayer.AddBindCoin(tbItem.nJxCoin, Player.emKBINDCOIN_ADD_EVENT);
		local szAnnouce = string.format("��ϲ�������<color=yellow>%s<color>��%s", tbItem.nJxCoin, IVER_g_szCoinName);
		pPlayer.Msg(szAnnouce);
		if tbItem.nAnnouce ~= 0 then
			szGolbalAnnouce = szGolbalAnnouce..string.format("�������<color=yellow>%s<color>��%s", tbItem.nJxCoin, IVER_g_szCoinName);
		end
		EventManager:WriteLog(string.format("�����%s�󶨽��", tbItem.nJxCoin), pPlayer);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ð󶨽�ң�%s",tbItem.nJxCoin));
	end
	
	if tbItem.nExpBase ~= 0 then
		local nAddExp = pPlayer.GetBaseAwardExp() * tbItem.nExpBase;
		local nCanAddExp = nAddExp;
		if nCanAddExp ~= 0 then
			pPlayer.AddExp(nCanAddExp);
			local szAnnouce = string.format("��ϲ�������<color=yellow>%s��<color>����", nCanAddExp);
			pPlayer.Msg(szAnnouce);
			if tbItem.nAnnouce ~= 0 then
				szGolbalAnnouce = szGolbalAnnouce..string.format("�������<color=yellow>%s��<color>����", nCanAddExp);
			end		
			EventManager:WriteLog(string.format("�����%s����", nCanAddExp), pPlayer);
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���þ��飺%s",nCanAddExp));
		end
	end
	
	if tbItem.nExp ~= 0 then
		local nCanAddExp = tbItem.nExp;
		if nCanAddExp ~= 0 then
			pPlayer.AddExp(nCanAddExp);
			local szAnnouce = string.format("��ϲ�������<color=yellow>%s��<color>����", nCanAddExp);
			pPlayer.Msg(szAnnouce);
			if tbItem.nAnnouce ~= 0 then
				szGolbalAnnouce = szGolbalAnnouce..string.format("�������<color=yellow>%s��<color>����", nCanAddExp);
			end		
			EventManager:WriteLog(string.format("�����%s����", nCanAddExp), pPlayer);
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���þ��飺%s",nCanAddExp));
		end
	end
	
	if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
		local tbItemInfo ={};
		
		if self:TimerOutCheck(tbItem.szTimeLimit) == 1 then
			tbItemInfo.bTimeOut = 1;
		end
		
		if tbItem.nBind > 0 then
			tbItemInfo.bForceBind = tbItem.nBind;
		end
	
		if tbItemInfo.bTimeOut ~= 1 then
			local nAddCount = pPlayer.AddStackItem(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItemInfo, tbItem.nAmount);
			if nAddCount > 0 then
				EventManager:WriteLog(string.format("�����Ʒ%s%s��", KItem.GetNameById(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel), nAddCount), pPlayer);
				pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]������Ʒ��%s��%s", nAddCount, tbItem.szName));
			end
		else
			for ni= 1 , tbItem.nAmount do
				local pItem = pPlayer.AddItemEx(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItemInfo, Player.emKITEMLOG_TYPE_JOINEVENT);
				if pItem then
					if tbItem.szTimeLimit ~= "" then
						Setting:SetGlobalObj(pPlayer, nil, pItem);
						self:ExeSetItemTime(tbItem.szTimeLimit);
						Setting:RestoreGlobalObj();
					end
					local szAnnouce = string.format("��ϲ�������һ��<color=yellow>%s<color>", pItem.szName);
					pPlayer.Msg(szAnnouce);
					if tbItem.nAnnouce ~= 0 then
						szGolbalAnnouce = szGolbalAnnouce..string.format("�������һ��<color=yellow>%s<color>", pItem.szName);
					end				
					EventManager:WriteLog(string.format("�����Ʒ%s1��", pItem.szName), pPlayer);
					pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]������Ʒ��%s", pItem.szName));
				else
					Dbg:WriteLog("�ϵͳ",  pPlayer.szName, string.format(",�����Ʒʧ��:(%s,%s,%s,%s,%s)",tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries));
				end
			end
		end
	end
	
	if tbItem.nAnnouce ~= 0 then
		szGolbalAnnouce = szGolbalAnnouce.."��";
		KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szGolbalAnnouce);
	end	
	
	if tbItem.nFriendMsg ~= 0 then
		pPlayer.SendMsgToFriend("���ĺ���[<color=yellow>"..pPlayer.szName.."<color>]"..tbItem.szDesc..
			"�����<color=yellow>"..tbItem.szName.."<color>��");
	end	
	
	if tbItem.nKinTongMsg ~= 0 then
		Player:SendMsgToKinOrTong(pPlayer, tbItem.szDesc.."�����"..tbItem.szName.."��", 1);
	end
	
	return 1;
end

function tbFun:_DelItem(pPlayer, tbItem, nDelItem)
	if tbItem.nJxMoney ~= 0 then
		pPlayer.CostMoney(tbItem.nJxMoney, Player.emKPAY_EVENT);
		EventManager:WriteLog(string.format("�۳�����%s", tbItem.nJxMoney), pPlayer);
	end
	
	if tbItem.nJxBindMoney ~= 0 then
		local nCostMoney = tbItem.nJxBindMoney;
		pPlayer.CostBindMoney(tbItem.nJxBindMoney, Player.emKBINDMONEY_COST_EVENT);
		EventManager:WriteLog(string.format("�۳�������%s", tbItem.nJxBindMoney), pPlayer);
	end
	
	if nDelItem == nil then
		if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			pPlayer.ConsumeItemInBags(tbItem.nAmount,tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries)
			EventManager:WriteLog(string.format("ɾ������Ʒ%s%s", KItem.GetNameById(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries), tbItem.nAmount), pPlayer);
		end
	end
	return 1;
end

function tbFun:ExeAddTaskDay(szParam, tbParam)
	local tbParam = self:SplitStr(szParam);
	if #tbParam < 2 then
		print("���ϵͳ����TaskDay�����������ԡ�");
		return 1;
	end
	--local nMaxCount = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[1]);
	local nTaskId2 = tonumber(tbParam[2]);
	local nTask2   = EventManager:GetTask(nTaskId2);	
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if (nNowDay > nTask2) then
		EventManager:SetTask(nTaskId1, 0);
		EventManager:SetTask(nTaskId2, nNowDay);
	end	
	EventManager:SetTask(nTaskId1, EventManager:GetTask(nTaskId1) + 1);
	return 0;
end

--Task:MaxCount;TaskId									--���λֻ����ȡMaxCount��;��Ҫ1���������
function tbFun:ExeAddTask(szParam)
	local tbParam = self:SplitStr(szParam);
	if #tbParam < 2 then
		print("���ϵͳ����TaskDay�����������ԡ�");
		return 1;
	end
	--local	nMaxCount = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[1]);
	local nNum 	   = tonumber(tbParam[2]) or 1;
	if nTaskId1 == 0 then
		return 1;
	end
	local nTask1 = EventManager:GetTask(nTaskId1);
	--if nTask1 > nMaxCount and nMaxCount ~= 0 then
	--	return 1, "���μӵĴ����Ѵ����ޡ�";
	--end
	EventManager:SetTask(nTaskId1, nTask1 + nNum);
	return 0;
end

function tbFun:ExeAddGTaskDay(szParam, tbParam)
	local tbParam = self:SplitStr(szParam);
	if #tbParam < 2 then
		print("���ϵͳ����TaskDay�����������ԡ�");
		return 1;
	end
	--local nMaxCount = tonumber(tbParam[1]);
	local nGroupId = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[2]);
	local nTaskId2 = tonumber(tbParam[3]);
	local nTask2   = me.GetTask(nGroupId, nTaskId2);	
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if (nNowDay > nTask2) then
		me.SetTask(nGroupId, nTaskId1, 0);
		me.SetTask(nGroupId, nTaskId2, nNowDay);
	end	
	me.SetTask(nGroupId, nTaskId1, EventManager:GetTask(nTaskId1) + 1);
	return 0;
end

--Task:MaxCount;TaskId									--���λֻ����ȡMaxCount��;��Ҫ1���������
function tbFun:ExeAddGTask(szParam)
	local tbParam = self:SplitStr(szParam);
	if #tbParam < 2 then
		print("���ϵͳ����TaskDay�����������ԡ�");
		return 1;
	end
	--local	nMaxCount = tonumber(tbParam[1]);
	local nGroupId = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[2]);
	local nNum 	   = tonumber(tbParam[3]) or 1;
	if nTaskId1 == 0 then
		return 1;
	end
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	me.SetTask(nGroupId, nTaskId1, nTask1 + nNum);
	return 0;
end

function tbFun:ExeSetTask(szParam)
	local tbParam = self:SplitStr(szParam);
	if #tbParam < 2 then
		print("���ϵͳ����TaskDay�����������ԡ�");
		return 1;
	end
	--local	nMaxCount = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[1]);
	local nNum 	   = tonumber(tbParam[2]);
	EventManager:SetTask(nTaskId1, nNum);
	return 0;	
end

function tbFun:ExeSetGTask(szParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[2]);
	local nNum 	   = tonumber(tbParam[3]);
	me.SetTask(nGroupId, nTaskId1, nNum);
	return 0;	
end
function tbFun:ExeDropNpc(szParam, tbGParam)
	local tbDropItem = self:GetParam(tbGParam, "SetDropItemId", 1);
	local tbDropRate = self:GetParam(tbGParam, "SetDroprate", 1);
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	
	local nType 		= 0;
	local varDropParam 	= nil;
	local nDropSum		= 0;
	local nMaxProb		= 0;
	if #tbDropItem > 0 then
		nType = 1;
		local tbParamTemp = self:SplitStr(tbDropItem[1]);
		varDropParam = tonumber(tbParamTemp[1]);
		nDropSum = tonumber(tbParamTemp[2]) or 1;
		
		if not self.DropItemList[varDropParam] then
			return 1;
		end
		
		nMaxProb = self.DropItemList[varDropParam].nMaxProb;		
	end
	
	if #tbDropRate > 0 then
		nType = 2;
		local tbParamTemp = self:SplitStr(tbDropRate[1]);
		varDropParam = tbParamTemp[1];
		nDropSum = tonumber(tbParamTemp[2]) or 1;
	end
	

	local tbNpcParam = self:SplitStr(szParam);
	for _, nNpcId in pairs(tbNpcParam) do
		if not tonumber(nNpcId) then
			return;
		end
		local tbNpc = EventManager:GetNpcClass(tonumber(nNpcId), 1)
		tbNpc.tbDropSum 	= tbNpc.tbDropSum or {};
		tbNpc.tbDropType 	= tbNpc.tbDropType or {};
		tbNpc.tbMaxProb 	= tbNpc.tbMaxProb or {};
		tbNpc.tbDropParam 	= tbNpc.tbDropParam or {};
		tbNpc.tbParam 		= tbNpc.tbGParam or {};		
		tbNpc.tbEventList   = tbNpc.tbEventList or {};
		
		local nOverlap = 0;
		for i, varDropParamTemp in pairs(tbNpc.tbDropParam)  do
			if varDropParamTemp == varDropParam and tbNpc.tbEventList[i] == (nEventId * 10000 + nPartId) then
				nOverlap = 1;
				break;
			end
		end
		
		if nOverlap == 0 then
			local nNpcParamCount = #tbNpc.tbDropParam + 1;
			tbNpc.tbDropSum[nNpcParamCount] 	= nDropSum;
			tbNpc.tbDropType[nNpcParamCount] 	= nType;
			tbNpc.tbMaxProb[nNpcParamCount] 	= nMaxProb;
			tbNpc.tbDropParam[nNpcParamCount] 	= varDropParam;
			tbNpc.tbParam[nNpcParamCount] 		= tbGParam;
			tbNpc.tbEventList[nNpcParamCount] = (nEventId * 10000 + nPartId);
		end

		tbNpc.OnEventDeath = function(tbNpc, pNpc)
			local pPlayer = pNpc.GetPlayer();
			for ni=1, #tbNpc.tbDropParam do
				local nFlag, szMsg = self:CheckParam(tbNpc.tbParam[ni]);
				if nFlag ~= 1 then
					if tbNpc.tbDropType[ni] == 2 then
						pPlayer.DropRateItem(tbNpc.tbDropParam[ni], tbNpc.tbDropSum[ni], pPlayer.nCurLucky, -1, him);
					end
					if tbNpc.tbDropType[ni] == 1 then
						for nSum = 1, tbNpc.tbDropSum[ni] do
							local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
							for nId, tbItem in pairs(self.DropItemList[tbNpc.tbDropParam[ni]].tbItem) do
								if tbItem.nRandRate == 0 and tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
									
									--����������.
									local nRandLarger = tbNpc.tbDropSum[ni];
									if nRandLarger <= 1  or nRandLarger > 3 then
										nRandLarger = 3;
									end
									local nRX  = MathRandom(nRandLarger*nRandLarger) - nRandLarger;
									local nRY  = MathRandom(nRandLarger*nRandLarger) - nRandLarger;
									local pObj = KItem.AddItemInPos(nNpcMapId, nNpcPosX + nRX, nNpcPosY + nRY, tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries);
								end
							end
							local nRate = MathRandom(1, tbNpc.tbMaxProb[ni]);
							local nRateSum = 0;
							for nId, tbItem in pairs(self.DropItemList[tbNpc.tbDropParam[ni]].tbItem) do
								nRateSum = nRateSum + tbItem.nRandRate;
								if nRate <= nRateSum and tbItem.nRandRate ~= 0 then
									if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
										
										--����������.
										local nRandLarger = tbNpc.tbDropSum[ni];
										if nRandLarger <= 1 or nRandLarger > 3 then
											nRandLarger = 3;
										end
										local nRX  = MathRandom(nRandLarger*nRandLarger + 1) - nRandLarger;
										local nRY  = MathRandom(nRandLarger*nRandLarger + 1) - nRandLarger;
										local pObj = KItem.AddItemInPos(nNpcMapId, nNpcPosX + nRX, nNpcPosY + nRY, tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries);
									end
									break;
								end
							end
						end
						--�������ѭ������
					end
				end
			end
		end
	end
end


function tbFun:ExeDropNpcType(szParam, tbGParam)
	local tbDropItem = self:GetParam(tbGParam, "SetDropItemId", 1);
	local tbDropRate = self:GetParam(tbGParam, "SetDroprate", 1);
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	local nType 		= 0;
	local varDropParam 	= nil;
	local nDropSum		= 0;
	local nMaxProb		= 0;
	if #tbDropItem > 0 then
		nType = 1;
		local tbParamTemp = self:SplitStr(tbDropItem[1]);
		varDropParam = tonumber(tbParamTemp[1]);
		nDropSum = tonumber(tbParamTemp[2]) or 1;
		
		if not self.DropItemList[varDropParam] then
			return 1;
		end
		
		nMaxProb = self.DropItemList[varDropParam].nMaxProb;		
	end
	
	if #tbDropRate > 0 then
		nType = 2;
		local tbParamTemp = self:SplitStr(tbDropRate[1]);
		varDropParam = tbParamTemp[1];
		nDropSum = tonumber(tbParamTemp[2]) or 1;
	end
	

	local tbNpcParam = self:SplitStr(szParam);
	for _, szNpcClass in pairs(tbNpcParam) do
		if szNpcClass == "" then
			return;
		end
		local tbNpc = EventManager:GetNpcClass(tostring(szNpcClass), 1)
		tbNpc.tbDropSum 	= tbNpc.tbDropSum or {};
		tbNpc.tbDropType 	= tbNpc.tbDropType or {};
		tbNpc.tbMaxProb 	= tbNpc.tbMaxProb or {};
		tbNpc.tbDropParam 	= tbNpc.tbDropParam or {};
		tbNpc.tbParam 		= tbNpc.tbParam or {};		
		tbNpc.tbEventList   = tbNpc.tbEventList or {};
		
		local nOverlap = 0;
		for i, varDropParamTemp in pairs(tbNpc.tbDropParam)  do
			if varDropParamTemp == varDropParam and tbNpc.tbEventList[i] == (nEventId * 10000 + nPartId) then
				nOverlap = 1;
				break;
			end
		end
		
		if nOverlap == 0 then
			local nNpcParamCount = #tbNpc.tbDropParam + 1;
			tbNpc.tbDropSum[nNpcParamCount] 	= nDropSum;
			tbNpc.tbDropType[nNpcParamCount] 	= nType;
			tbNpc.tbMaxProb[nNpcParamCount] 	= nMaxProb;
			tbNpc.tbDropParam[nNpcParamCount] 	= varDropParam;
			tbNpc.tbParam[nNpcParamCount] 		= tbGParam;
			tbNpc.tbEventList[nNpcParamCount] = (nEventId * 10000 + nPartId)
		end

		tbNpc.OnEventDeath = function(tbNpc, pNpc)
			local pPlayer = pNpc.GetPlayer();
			for ni=1, #tbNpc.tbDropParam do
				local nFlag, szMsg = self:CheckParam(tbNpc.tbParam[ni]);
				if nFlag ~= 1 then
					if tbNpc.tbDropType[ni] == 2 then
						pPlayer.DropRateItem(tbNpc.tbDropParam[ni], tbNpc.tbDropSum[ni], pPlayer.nCurLucky, -1, him);
					end
					if tbNpc.tbDropType[ni] == 1 then
						for nSum = 1, tbNpc.tbDropSum[ni] do
							local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
							for nId, tbItem in pairs(self.DropItemList[tbNpc.tbDropParam[ni]].tbItem) do
								if tbItem.nRandRate == 0 and tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
									
									--����������.
									local nRandLarger = tbNpc.tbDropSum[ni];
									if nRandLarger <= 1  or nRandLarger > 3 then
										nRandLarger = 3;
									end
									local nRX  = MathRandom(nRandLarger*nRandLarger) - nRandLarger;
									local nRY  = MathRandom(nRandLarger*nRandLarger) - nRandLarger;
									local pObj = KItem.AddItemInPos(nNpcMapId, nNpcPosX + nRX, nNpcPosY + nRY, tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries);
								end
							end
							local nRate = MathRandom(1, tbNpc.tbMaxProb[ni]);
							local nRateSum = 0;
							for nId, tbItem in pairs(self.DropItemList[tbNpc.tbDropParam[ni]].tbItem) do
								nRateSum = nRateSum + tbItem.nRandRate;
								if nRate <= nRateSum and tbItem.nRandRate ~= 0 then
									if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
										
										--����������.
										local nRandLarger = tbNpc.tbDropSum[ni];
										if nRandLarger <= 1 or nRandLarger > 3 then
											nRandLarger = 3;
										end
										local nRX  = MathRandom(nRandLarger*nRandLarger + 1) - nRandLarger;
										local nRY  = MathRandom(nRandLarger*nRandLarger + 1) - nRandLarger;
										local pObj = KItem.AddItemInPos(nNpcMapId, nNpcPosX + nRX, nNpcPosY + nRY, tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries);
									end
									break;
								end
							end
						end
						--�������ѭ������
					end
				end
			end
		end
	end

end

function tbFun:ExeNewsMsg(szParam)
	local tbParam = self:SplitStr(szParam);
	if tbParam[1] == nil then
		print("���ϵͳ����NewsMsg�����������ԡ�");
		return 1;
	end
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, tbParam[1]);
end

function tbFun:ExeSetMsg(szParam)
	local tbParam = self:SplitStr(szParam);
	local nType = tonumber(tbParam[1]);
	local szMsg = self:StrVal(tbParam[2]);
	if nType == 0 then
		me.Msg(szMsg);
	elseif nType == 1 then
		Dialog:Say(szMsg);
	elseif nType == 2 then
		Dialog:SendBlackBoardMsg(me, szMsg)
	elseif nType == 3 then
		me.SendMsgToFriend(szMsg);
	elseif nType == 4 then
		Player:SendMsgToKinOrTong(me, szMsg, 1);
	elseif nType == 5 then
		KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	end
	return 0;
end

--�����Ʒ
function tbFun:ExeAddItem(szParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem	= tbParam[1];
	local nCount	= tonumber(tbParam[2]) or 1;
	local nBind		= tonumber(tbParam[3]) or 1;
	local nTimeOut	= tbParam[4] or 0;
	local tbItem = self:SplitStr(szItem);
	if nTimeOut == "" then
		nTimeOut = 0;
	end
	local tbItemInfo ={};
	
	if self:TimerOutCheck(nTimeOut) == 1 then
		tbItemInfo.bTimeOut = 1;
	end
	
	if nBind > 0 then
		tbItemInfo.bForceBind = nBind;
	end
	if tbItemInfo.bTimeOut ~= 1 then
		local nAddCount = me.AddStackItem(tbItem[1], tbItem[2], tbItem[3], tbItem[4], tbItemInfo, nCount);	
		if nAddCount > 0 then
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]������Ʒ��%s��%s",nAddCount, KItem.GetNameById(unpack(tbItem))));
			EventManager:WriteLog(string.format("�����Ʒ%s%s��", KItem.GetNameById(unpack(tbItem)), nAddCount), me);
		end
	else
		for i=1, nCount do
			local pItem = me.AddItemEx(tbItem[1], tbItem[2], tbItem[3], tbItem[4], tbItemInfo, Player.emKITEMLOG_TYPE_JOINEVENT);
			if pItem then
				Setting:SetGlobalObj(me, nil, pItem);
				self:ExeSetItemTime(nTimeOut);
				Setting:RestoreGlobalObj()
				EventManager:WriteLog(string.format("�����Ʒ%s", pItem.szName), me);
			end
		end
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]������Ʒ��%s��%s",nCount, KItem.GetNameById(unpack(tbItem))));
	end
	
	return 0;
end

function tbFun:ExeAddBuffType(szParam)
	local nType = tonumber(szParam);
	if not nType then
		print("���ϵͳ����AddBuffType�����������ԡ�");
	end
	if nType == 1 then
		--���Ӽ���״̬
		me.AddSkillState(385, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(386, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(387, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		--����ֵ880, 4��30��,����־���879, 6����70����
		me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(879, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
		EventManager:WriteLog("���ף��buff", me);
	end
	return 0
end

function tbFun:ExeAddTitle(szParam)
	local tbParam = self:SplitStr(szParam);
	local szTitle = tbParam[1];
	local tbTille = self:SplitStr(szTitle);
	
	me.AddTitle(unpack(tbTille));
	me.SetCurTitle(unpack(tbTille));	
	EventManager:WriteLog("��óƺ�", me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]��óƺ�%s,%s,%s,%s",unpack(tbTille)));
	return 0;
end

function tbFun:ExeAddExt(szParam)
	local tbParam = self:SplitStr(szParam);
	local nExt = tonumber(tbParam[1]);
	me.__AddMonthPayExtValue((nExt * 2^28))
	EventManager:WriteLog(string.format("ExeAddExt%s", (nExt * 2^28)), me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���³�ֵ����չ�����λ��������%s",nExt));
	return 0;
end

function tbFun:ExeSetExt(szParam)
	local tbParam = self:SplitStr(szParam);
	local nBit = tonumber(tbParam[1]) or 0;
	local nValue = tonumber(tbParam[2]) or 0;
	me.SetActiveValue(nBit, nValue);
	EventManager:WriteLog(string.format("������չ��%sλΪ%s",nBit, nValue), me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���³�ֵ����չ�����λ��������%s:%s", nBit, nValue));
	return 0;
end

function tbFun:ExeAddSkillBuff(szParam)
	local tbParam = self:SplitStr(szParam);
	local nSkill = tonumber(tbParam[1]);
	local nLevel = tonumber(tbParam[2]);
	local nMin 	 = tonumber(tbParam[3]);
	me.AddSkillState(nSkill, nLevel, 2, nMin*60*18, 1, 0, 1);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���Ӽ���buff��%s",nSkill));
	EventManager:WriteLog(string.format("[�]���Ӽ���buff��%s",nSkill), me);
	return 0;
end

function tbFun:ExeAddNpcInNear(szParam)
	local tbParam = self:SplitStr(szParam);
	local nNpcId 	= tonumber(tbParam[1]);
	local nLiveTime = tonumber(tbParam[2]) or 0;
	local nBeLong 	= tonumber(tbParam[3]) or 0;
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	local pNpc = KNpc.Add2(nNpcId, 100, -1, nMapId, nPosX, nPosY, 0, 0);
	if pNpc then
		if nLiveTime > 0 then
			pNpc.SetLiveTime(nLiveTime * Env.GAME_FPS)
		end
		if nBeLong == 1 then
			pNpc.szName = me.szName .. "��" .. pNpc.szName;
			pNpc.GetTempTable("Npc").EventManager = {};
			pNpc.GetTempTable("Npc").EventManager.nBeLongPlayerId = me.nId;
		end
	end
end

function tbFun:ExeAddBaseExp(szParam)
	local tbParam = self:SplitStr(szParam);
	local nBase   = tonumber(tbParam[1]);
	local nType   = tonumber(tbParam[2]) or 0;	--Ĭ�Ϸ���
	local nUnit	  = 1;
	if nType == 1 then--��λΪ��
		nUnit = 60;
	end

	me.AddExp(math.floor(me.GetBaseAwardExp() * (nBase / nUnit)));
	EventManager:WriteLog(string.format("ExeAddBaseExp%s", (nBase / nUnit)), me);
end

function tbFun:ExeAddExp(szParam)
	local tbParam = self:SplitStr(szParam);
	local nExp 	= tonumber(tbParam[1]);
	me.AddExp(nExp);
	EventManager:WriteLog(string.format("ExeAddExp%s", nExp), me);
	return 0;
end

function tbFun:ExeDelItem(szParam)
	local tbParam = self:SplitStr(szParam);
	local szItem	= tbParam[1];
	local nCount	= tonumber(tbParam[2]) or 1;
	local tbItem = self:SplitStr(szItem);
	local nLastCount = me.ConsumeItemInBags(nCount,unpack(tbItem)) or nCount;
	EventManager:WriteLog(string.format("[�]ɾ����Ʒ%s��%s",(nCount-nLastCount), KItem.GetNameById(unpack(tbItem))), me);
	return 0;
end

function tbFun:ExeSetTaskCurTime(szParam)
	local tbParam = self:SplitStr(szParam);
	local nTaskId 	= tonumber(tbParam[1]);
	EventManager:SetTask(nTaskId, GetTime());
	return 0;
end

function tbFun:ExeSetGTaskCurTime(szParam)
	local tbParam = self:SplitStr(szParam);
	local nGroupId 	= tonumber(tbParam[1]);
	local nTaskId 	= tonumber(tbParam[2]);
	me.SetTask(nGroupId, nTaskId, GetTime());
	return 0;
end

function tbFun:ExeSetTaskMsg(szParam)
	local tbParam = self:SplitStr(szParam);
	local nType = tonumber(tbParam[1]);
	local szMsg = tbParam[2];
	local tbTask = {};
	for i, n in ipairs(tbParam) do
		if i >= 3 and tonumber(n) and tonumber(n) > 0 then
			table.insert(tbTask, EventManager:GetTask(tonumber(n)));
		end
	end
	
	if nType == 0 then
		me.Msg(string.format(szMsg, unpack(tbTask)));
	elseif nType == 1 then
		Dialog:Say(string.format(szMsg, unpack(tbTask)));
	elseif nType == 2 then
		Dialog:SendBlackBoardMsg(me, string.format(szMsg, unpack(tbTask)))
	end	
	return 0;
end

function tbFun:ExeSetGTaskMsg(szParam)
	local tbParam = self:SplitStr(szParam);
	local nType = tonumber(tbParam[1]);
	local szMsg = tbParam[2];
	local nGroupId = tonumber(tbParam[3]);
	local tbTask = {};
	for i, n in ipairs(tbParam) do
		if i >= 4 and tonumber(n) and tonumber(n) > 0 then
			table.insert(tbTask, me.GetTask(nGroupId, tonumber(n)));
		end
	end
	
	if nType == 0 then
		me.Msg(string.format(szMsg, unpack(tbTask)));
	elseif nType == 1 then
		Dialog:Say(string.format(szMsg, unpack(tbTask)));
	elseif nType == 2 then
		Dialog:SendBlackBoardMsg(me, string.format(szMsg, unpack(tbTask)))
	end	
	return 0;
end

function tbFun:ExeOpenShop(szParam)
	local tbParam = self:SplitStr(szParam);
	local nShopId = tonumber(tbParam[1]);
	local nType = tonumber(tbParam[2]) or 1;
	local nScal = tonumber(tbParam[3]) or 100;
	me.OpenShop(nShopId, nType, nScal);
	return 0;
end

function tbFun:ExeSetLuaScript(szParam)
	local tbParam = self:SplitStr(szParam);
	local szScript = tbParam[1];
	szScript = string.gsub(szScript, "<enter>", "\n");
	szScript = string.gsub(szScript, "<tab>", "\t");
	local szFun, szError = loadstring(szScript);
	if not szFun then
		print(szError);
		assert(szFun);
	end
	return szFun();	
end

function tbFun:ExeGoToEvent(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nEventPartId 	= tonumber(tbParam[1]) or 0;

	if nEventPartId > 0 then
		local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
		local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
		if nEventPartId == nPartId then
			print("���ϵͳ��Error!!!CheckTaskGotoEvent�ظ������Լ�");
			return 0;
		end
		return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
	end
end

function tbFun:ExeGoToOtherEvent(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nEventEId 	= tonumber(tbParam[1]) or 0;
	local nEventPartId 	= tonumber(tbParam[2]) or 0;
	if nEventPartId > 0 then
		local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
		local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
		if nEventEId == nEventId and nEventPartId == nPartId then
			print("���ϵͳ��Error!!!CheckTaskGotoEvent�ظ������Լ�");
			return 0;
		end
		return EventManager:GotoEventPartTable(nEventEId, nEventPartId, nCheckType);
	end	
end

function tbFun:ExeAddBaseMoney(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nMoney = tonumber(tbParam[1]) or 0;
	local nType  = tonumber(tbParam[2]) or 0;
	local nLimit = tonumber(tbParam[3]) or 0;
	local nAdd = math.floor(nMoney * me.GetProductivity() / 100);
	if nLimit > 0 and nAdd > nLimit then
		nAdd = nLimit;
	end
	
	if nAdd > 0 then
		if nType == 1 then
			me.Earn(nAdd, Player.emKEARN_EVENT);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]����������%s",nAdd));			
			EventManager:WriteLog(string.format("[�]����������%s",nAdd), me);
		elseif nType == 7 then
			me.AddBindMoney(nAdd, Player.emKBINDMONEY_ADD_EVENT);	
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ð�������%s",nAdd));
			EventManager:WriteLog(string.format("[�]���ð�������%s",nAdd), me);
		end
	end
end

function tbFun:ExeAddBindMoney(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nMoney = tonumber(tbParam[1]) or 0;
	if nMoney > 0 then
		me.AddBindMoney(nMoney, Player.emKBINDMONEY_ADD_EVENT);	
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ð�������%s",nMoney));
		EventManager:WriteLog(string.format("[�]���ð�������%s",nMoney), me);
	end
end

function tbFun:ExeAddMoney(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nMoney = tonumber(tbParam[1]) or 0;
	if nMoney > 0 then
		me.Earn(nMoney, Player.emKEARN_EVENT);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]����������%s",nMoney));			
		EventManager:WriteLog(string.format("[�]����������%s",nMoney), me);
	end
end

function tbFun:ExeAddBindCoin(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nMoney = tonumber(tbParam[1]) or 0;
	if nMoney > 0 then
		me.AddBindCoin(nMoney, Player.emKBINDCOIN_ADD_EVENT);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]����BindCoin��%s",nMoney));			
		EventManager:WriteLog(string.format("[�]����BindCoin��%s",nMoney), me);
	end
end

function tbFun:ExeAddFactionExSum(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nCount = tonumber(tbParam[1]) or 0;
	if nCount > 0 then
		Faction:AddExtraModifyTimes(me, nCount);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���Ӹ��޻���%s��",nCount));			
		EventManager:WriteLog(string.format("[�]���Ӹ��޻���%s��",nCount), me);
	end
	return 0;
end

function tbFun:ExeAddBuyHeShiBiSum(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nCount = tonumber(tbParam[1]) or 0;
	if nCount > 0 then
		SpecialEvent.BuyHeShiBi:AddCount(nCount);
	end
	return 0;	
end

function tbFun:ExeCoinBuyHeShiBi(szParam, tbGParam)
	SpecialEvent.BuyHeShiBi:BuyOnDialog();
end

function tbFun:ExeMinusTask(szParam)
	local tbParam = self:SplitStr(szParam);
	local nTaskId1 = tonumber(tbParam[1]);
	local nNum 	   = tonumber(tbParam[2]) or 1;
	if nTaskId1 == 0 then
		return 1;
	end
	local nTask1 = EventManager:GetTask(nTaskId1);
	EventManager:SetTask(nTaskId1, nTask1 - nNum);
	return 0;	
end

function tbFun:ExeMinusGTask(szParam)
	local tbParam = self:SplitStr(szParam);
	local nGroupId = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[2]);
	local nNum 	   = tonumber(tbParam[3]) or 1;
	if nTaskId1 == 0 then
		return 1;
	end
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	me.SetTask(nGroupId, nTaskId1, nTask1 - nNum);
	return 0;	
end

function tbFun:ExeOpenIBReturen(szParam)
	local tbParam = self:SplitStr(szParam);
	local nOpenType = tonumber(tbParam[1]);
	IbShop.EventOpen = nOpenType;
	print("[EventManager]OpenIBReturen:", nOpenType);
end

function tbFun:ExeCloseIBReturen()
	IbShop.EventOpen = 0;
	print("[EventManager]CloseIBReturen");
end

function tbFun:ExeOpenDuKinQizi(szParam)
	local tbParam = self:SplitStr(szParam);
	local nDouble = tonumber(tbParam[1]) or 1;
	SpecialEvent.ExtendAward:GetInitTable("KinQizi_Check").nBaseExp = nDouble;
	print("[EventManager]OpenDuKinQizi");
end

function tbFun:ExeCloseDuKinQizi()
	SpecialEvent.ExtendAward:GetInitTable("KinQizi_Check").nBaseExp = 1;
	print("[EventManager]CloseDuKinQizi");
end

function tbFun:ExeOpenJinTiaoFuLi(szParam)
	local tbParam = self:SplitStr(szParam);
	local nDouble = tonumber(tbParam[1]) or 0;
	Item:GetClass("jintiao").ExReturnBindMoney = nDouble;
	print("[EventManager]OpenJinTiaoFuLi");
end

function tbFun:ExeCloseJinTiaoFuLi()
	Item:GetClass("jintiao").ExReturnBindMoney = 0;
	print("[EventManager]CloseJinTiaoFuLi");
end

function tbFun:ExeOpenTongYinFuLi(szParam)
	local tbParam = self:SplitStr(szParam);
	local nDouble = tonumber(tbParam[1]) or 0;
	Item:GetClass("tongfunditem").ExReturnBindCoin = nDouble;
	print("[EventManager]OpenTongYinFuLi");
end

function tbFun:ExeCloseTongYinFuLi()
	Item:GetClass("tongfunditem").ExReturnBindCoin = 0;
	print("[EventManager]CloseTongYinFuLi");
end

function tbFun:ExeWriteLog(szParam)
	local tbParam = self:SplitStr(szParam);
	local szLog = self:StrVal((tbParam[1] or ""));
	EventManager:WriteLog(szLog, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[EventManager]\t%s", szLog));
end

local function OnSort(tbA, tbB)
	return tbA.nId < tbB.nId;
end

function tbFun:ExeCreateLink(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szMsg = self:StrVal(tbParam[1] or "��ã���ʲô���԰ﵽ����");
	local tbOpt = {};
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);	
	local tbTable = EventManager:GetEventTable(nEventId);
	local tbTempTable = {};
	for nEventPartId, tbPart in pairs(tbTable) do
		table.insert(tbTempTable, {nId=nEventPartId, tbPart=tbPart});
	end
	table.sort(tbTempTable, OnSort);
	
	for _, tbTemp in ipairs(tbTempTable) do
		local nEventPartId = tbTemp.nId;
		local tbPart = tbTemp.tbPart;
		local tbOptParam = self:GetParam(tbPart.tbEventPart.tbParam, "SetLink", 1);
		local szName 	 = self:StrVal(tbPart.tbEventPart.szName);
		for _, szLink in ipairs(tbOptParam) do
			local nLinkPart = tonumber(self:SplitStr(szLink)[1]) or 0;
			if nLinkPart == nPartId then
				local nFlag, szMsg = EventManager.tbFun:CheckParam(tbPart.tbEventPart.tbParam, 1);
				if nFlag and nFlag ~= 0 and nFlag ~= 2 then
					szName = self:SetGrayColor(szName);
				end
				table.insert(tbOpt, {szName, EventManager.GotoEventPartTable, EventManager, nEventId, nEventPartId, nil, nil, nil, 1});
			end
		end
	end
	if #tbOpt <= 0 then
		return 0;
	end
	table.insert(tbOpt, {"�����Ի�"});
	Dialog:Say(szMsg, tbOpt);
end

function tbFun:ExeDelLinkUseItem(szParam)
	local nType = EventManager:GetTempTable().nType or 0;
	if nType == 2 then
		if not EventManager:GetTempTable().tbParam or not EventManager:GetTempTable().tbParam.nItemId then
			return 0;
		end
		local nItemId = EventManager:GetTempTable().tbParam.nItemId;
		local pItem = KItem.GetObjById(nItemId);
		if pItem then
			pItem.Delete(me);
		end
	end	
end

function tbFun:ExeSetNpcTask(szParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	if him then
		local tbTable = him.GetTempTable("Npc");
		tbTable.EventManager = tbTable.EventManager or {};
		tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
		tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
		tbTable.EventManager.tbTask[szKey][me.nId] = nTskValue;
	end
	return 0;	
end

function tbFun:ExeAddNpcTask(szParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	if him then
		local tbTable = him.GetTempTable("Npc");
		tbTable.EventManager = tbTable.EventManager or {};
		tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
		tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
		tbTable.EventManager.tbTask[szKey][me.nId] = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;
		tbTable.EventManager.tbTask[szKey][me.nId] = tbTable.EventManager.tbTask[szKey][me.nId] + nTskValue;
	end
	return 0;	
end

function tbFun:ExeAddXiulianTime(szParam)
	
	local tbParam = self:SplitStr(szParam);
	local nTime = tonumber(tbParam[1]) or 0;
	
	local tbXiuLianZhu = Item:GetClass("xiulianzhu");
	tbXiuLianZhu:AddRemainTime(nTime * 60);
	me.Msg(string.format("��������ʱ��������<color=green>%sСʱ<color>��", nTime));
	
	return 0;
end

function tbFun:ExeCallRabbit(szParam)
	
	local tbParam = self:SplitStr(szParam);
	
	local nMapId, nX, nY = me.GetWorldPos();
	SpecialEvent.GameOpenTest:CallRabbit(nMapId, nX, nY, me.nLevel);
	
	return 0;
end


--���ӽ�������
function tbFun:ExeAddKinRepute(szParam)
	local tbParam = self:SplitStr(szParam);
	local nValue = tonumber(tbParam[1]) or 0;
	me.AddKinReputeEntry(nValue)	
	EventManager:WriteLog("���ӽ�������"..nValue, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ӽ�������%s",nValue));
	return 0;
end

--ȥ���ƺ�
function tbFun:ExeDelTitle(szParam)
	local tbParam = self:SplitStr(szParam);
	local szTitle = tbParam[1];
	local tbTille = self:SplitStr(szTitle);		
	me.RemoveTitle(unpack(tbTille));
	EventManager:WriteLog("�ƺű�ɾ��==", me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]ȥ���ƺ�%s,%s,%s,%s",unpack(tbTille)));
	return 0;
end

--���Ӱ���ʽ�
function tbFun:ExeAddTongMoney(szParam)
	local tbParam = self:SplitStr(szParam);	
	local nTongId = me.dwTongId;
	local cTong=KTong.GetTong(nTongId)
	if cTong then
	    if cTong.GetName() == tbParam[1] then
	     	 GCExcute{"Tong:AddBuildFund2_GC", nTongId, tonumber(tbParam[2]) or 0};
	     	 return 0;
	     end
	end
	EventManager:WriteLog("��Ұ����Ҫ���Ӱ�Ὠ���ʽ�İ�᲻�������:"..(tbParam[1] or ""), me);
	return 1, "��Ұ����Ҫ���Ӱ�Ὠ���ʽ�İ�᲻����";
end

--�����Զ���ƺ�
function tbFun:ExeAddSpeTitle(szParam)	
	local tbParam = self:SplitStr(szParam);
	local szTitle = tbParam[1] or "";
	local nTimeMin= tonumber(tbParam[2]) or 0;
	local szColor = tbParam[3] or "";
	local nEndTime = 0;
	if nTimeMin > 0 then
		nEndTime = GetTime()+ nTimeMin*60;
	end
	me.AddSpeTitle(szTitle, nEndTime, szColor);	
	--me.SetCurTitle(unpack(tbTille));	
	EventManager:WriteLog("����Զ���ƺ�"..szTitle, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]����Զ���ƺ�%s,%s,%s",szTitle,nTimeMin,szColor));
	return 0;
end

--ȥ���Զ���ƺ�
function tbFun:ExeDelSpeTitle(szParam)
	local tbParam = self:SplitStr(szParam);
	local szTitle = tbParam[1] or "";
	me.RemoveSpeTitle(szTitle);		
	EventManager:WriteLog("ȥ���Զ���ƺ�"..szTitle, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]ȥ���Զ���ƺ�%s",szTitle));
	return 0;
end

--��������
function tbFun:ExeAddTaskRepute(szParam)
	local tbParam = self:SplitStr(szParam);
	local nClass = tonumber(tbParam[1]) or 0;
	local nCamp  = tonumber(tbParam[2]) or 0;
	local nValue = tonumber(tbParam[3]) or 0;
	me.AddRepute(nClass, nCamp, nValue);
	EventManager:WriteLog("�����ı�:"..nClass.."|"..nCamp.."|"..nValue, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]��������:%s,%s,%s",nClass,nCamp,nValue));
	return 0;
end

--��������
function tbFun:ExeDelTaskRepute(szParam)
	local tbParam = self:SplitStr(szParam);
	local nClass = tonumber(tbParam[1]) or 0;
	local nCamp  = tonumber(tbParam[2]) or 0;
	local nValue = tonumber(tbParam[3]) or 0;
	nValue = -nValue;
	me.AddRepute(nClass, nCamp, nValue);
	EventManager:WriteLog("�����ı�:"..nClass.."|"..nCamp.."|"..nValue, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]��������:%s,%s,%s",nClass,nCamp,nValue));
	return 0;
end

--���ٰ׾�ʱ��
function tbFun:ExeDelBaiJuTime(szParam)
	local tbParam = self:SplitStr(szParam);
	local nType = tonumber(tbParam[1]) or 0;
	local nCValue = tonumber(tbParam[2]) or 0;
	local nValue = me.GetTask(5, nType) - nCValue;
	if nValue < 0 then
		nValue = 0;
	end
	me.SetTask(5, nType, nValue);	
	EventManager:WriteLog("���ٰ׾�ʱ��:"..nType.."|"..nCValue, me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ٰ׾�ʱ��%s,%s;ʣ��ʱ��:%s",nType, nCValue, nValue));
	return 0;
end

function tbFun:ExeAddExBindCoinByPay(szParam)
	local tbParam = self:SplitStr(szParam);
	local nTaskId = tonumber(tbParam[1]) or 0;
	local nMinMoney = tonumber(tbParam[2]) or 0;
	local nMaxMoney = tonumber(tbParam[3]) or 0;
	local nRate = tonumber(tbParam[4]) or 0;
	local nPay = me.GetExtMonthPay();
	if nMaxMoney < nPay and nMaxMoney ~= 0 then
		nPay = nMaxMoney;
	end
	local nCount = math.floor((nPay - nMinMoney)/ 50);
	local nTask = EventManager:GetTask(nTaskId);
	local nAddCoin = (nCount - nTask) * 50 * nRate;
	EventManager:SetTask(nTaskId, nCount);
	me.AddBindCoin(nAddCoin, Player.emKBINDCOIN_ADD_EVENT);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ð󶨽�ң�%s����ǣ�%s",nAddCoin, nTask));
	local szMsg = string.format("�����γɹ���ȡ��<color=yellow>%s�󶨽��<color>��", nAddCoin);
	Dialog:Say(szMsg);
	me.Msg(szMsg);
	return 0;
end

function tbFun:ExeAddExOpenFuDai(szParam)
	local tbParam = self:SplitStr(szParam);
	local nAddCount = tonumber(tbParam[1]) or 0;
	local nTaskCount = me.GetTask(2013, 4);
	if nAddCount > 0 then
		me.SetTask(2013,4, nTaskCount + nAddCount);
		EventManager:WriteLog("���ӿ�����������������:"..nAddCount, me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]���ӿ�������������᣻ԭ������%s,���Ӵ���:%s", nTaskCount, nAddCount));	
	end
	return 0;
end

function tbFun:ExeAddExOpenQiFu(szParam)
	local tbParam = self:SplitStr(szParam);
	local nAddCount = tonumber(tbParam[1]) or 0;
	if nAddCount > 0 then
		Task.tbPlayerPray:AddExPrayCount(me, nAddCount);
		EventManager:WriteLog("�������������:"..nAddCount, me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]�������������%s,", nAddCount));	
	end
	return 0;
end

function tbFun:ExeMinusKinRepute(szParam)
	local tbParam = self:SplitStr(szParam);
	local nDecreaseRepute = tonumber(tbParam[1]) or 0;
	if nDecreaseRepute > 0 then	
		local nOldReput = me.nPrestige;
		local nNewPrestige = math.max(nOldReput - nDecreaseRepute, 0);
		KGCPlayer.SetPlayerPrestige(me.nId, nNewPrestige);
		local szLog = string.format("����%d��������������%s��Ϊ%s", nDecreaseRepute, nOldReput, nNewPrestige);
		EventManager:WriteLog(szLog, me);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�]%s", szLog));
	end
	return 0;
end

function tbFun:ExeOpenDomain()
	if Domain.DomainTask:CheckState() == 1 then
		return 1, "����֮ӡ�Ѿ�������";
	end
	KGblTask.SCSetDbTaskInt(DBTASK_DOMAINTASK_OPENTIME, GetTime());
	KGblTask.SCSetDbTaskInt(DBTASK_DOMAIN_BATTLE_STEP, 2);
	print("[EventManager]ExeOpenDomain");
	return 0;
end

function tbFun:ExeCloseDomain()
	if Domain.DomainTask:CheckState() ~= 1 then
		return 1, "����֮ӡ�Ѿ��ر���";
	end
	KGblTask.SCSetDbTaskInt(DBTASK_DOMAINTASK_OPENTIME, 0);
	KGblTask.SCSetDbTaskInt(DBTASK_DOMAIN_BATTLE_STEP, 0);
	print("[EventManager]ExeCloseDomain");
	return 0;
end

function tbFun:ExeSetBaiHuAwardTimes(szParam)
	local tbParam = self:SplitStr(szParam);
	local nTimes = tonumber(tbParam[1]) or 1;
	if nTimes < 1 then
		print("��error��[EventManager]SetBaiHuAwardTimes:", nTimes);
		return 1;
	end
	BaiHuTang.nTimes	= nTimes;
	print("[EventManager]SetBaiHuAwardTimes:", nTimes);	
end

function tbFun:ExeSetSongJinAwardTimes(szParam)
	local tbParam = self:SplitStr(szParam);
	local nTimes = tonumber(tbParam[1]) or 1;
	if nTimes < 1 then
		print("��error��[EventManager]SetSongJinAwardTimes:", nTimes);
		return 1;
	end
	Battle.nTimes	= nTimes;
	print("[EventManager]SetSongJinAwardTimes:", nTimes);
end

function tbFun:ExeCloseBaiHuAwardTimes()
	BaiHuTang.nTimes	= 1;
	print("[EventManager]ExeCloseBaiHuAwardTimes:", BaiHuTang.nTimes);	
end

function tbFun:ExeCloseSongJinAwardTimes()
	Battle.nTimes	= 1;
	print("[EventManager]ExeCloseSongJinAwardTimes:", Battle.nTimes);
end

function tbFun:ExeSetLotteryData(szParam,tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szName = tbParam[1] or "";
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	local tbEvent = EventManager:GetEventTable(nEventId);
	if tbEvent[nPartId] then
		--���¼�
		local tbEventEx = EventManager.EventManager.tbEvent[nEventId];
		local nEventSDate = tbEventEx.tbEvent.nStartDate;
		local nEventEDate = tbEventEx.tbEvent.nEndDate;
		
		--С�¼�
		local tbPart  = tbEvent[nPartId];
		local nPartSDate = tbPart.tbEventPart.nStartDate;
		local nPartEDate = tbPart.tbEventPart.nEndDate;
		
		local nStartTime = nEventSDate;
		if nPartSDate > nStartTime then
			nStartTime = nPartSDate;
		end
		
		local nEndTime = nEventEDate;
		if nPartEDate < nEndTime then
			nEndTime = nPartEDate;
		end	
		if nStartTime == 0 or nEndTime == 0  then
			print("Error:[EventManager]ExeSetLotteryData", nStartTime, nEndTime );
			print(debug.traceback("[EventManager]ExeSetLotteryData"));
		end
		KGblTask.SCSetDbTaskInt(DBTASD_LOTTERY_STARTTIME, math.floor(nStartTime / 10000));
		KGblTask.SCSetDbTaskInt(DBTASD_LOTTERY_ENDTIME,  math.floor(nEndTime / 10000));	
		KGblTask.SCSetDbTaskStr(DBTASD_LOTTERY_STARTTIME, szName);
		print("[EventManager]ExeSetLotteryData",szName, nStartTime, nEndTime);
	end
end

function tbFun:ExeCloseLotteryData()
	print("[EventManager]ExeCloseLotteryData");
end

function tbFun:ExeGiveBazhuStatuary()
	GCExcute{"Domain.tbStatuary:AddStatuaryCompetence", me.szName, 1};
	EventManager:WriteLog("�����������֮ӡ�����ʸ�");
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "�����������֮ӡ�����ʸ�");	
end

function tbFun:ExeGiveKuaFuLianSaiStatuary(szParam)
	local tbParam = self:SplitStr(szParam);
	local nType = tonumber(tbParam[1] or 0);
	print(nType)
	if nType ~= 0 then
		nType = 2000 + nType;		--�����Ժ���չ��ntype��ʾ�ط�ֵ������ֵ������1��ʾ�ٰ���
	end
	me.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_STATUARY_TYPE, nType);
	GCExcute{"Domain.tbStatuary:AddStatuaryCompetence", me.szName, nType};
	EventManager:WriteLog("�������������������ʸ�");
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "�������������������ʸ�");
end

function tbFun:ExeAddHonor(szParam)
	local tbParam = self:SplitStr(szParam);
	local nClass = tonumber(tbParam[1]) or 0;
	local nType = tonumber(tbParam[2]) or 0;
	local nAddHonor = tonumber(tbParam[3]) or 0;
	if nAddHonor == 0 then
		return;
	end
	local szHonorName = PlayerHonor:GetHonorName(nClass, nType);
	if (not szHonorName) then
		return;
	end
	PlayerHonor:AddPlayerHonor(me, nClass, nType, nAddHonor);
	EventManager:WriteLog(string.format("����%s������ %s��", szHonorName, nAddHonor));
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("����%s������ %s��", szHonorName, nAddHonor));
end

function tbFun:ExeClearMarry(szParam)
	
	local tbParam = self:SplitStr(szParam);
	local nLevel = tonumber(tbParam[1]) or 0;
	local nVaild, szPartnerName, nDate, nWeddingLevel, nMapLevel = Marry:CheckPreWedding(me.szName);
	local nCozone, szCoPartnerName, nCoDate, nCoWeddingLevel, nCoMapLevel = Marry:CheckCozoneWedding(me.szName);
	
	if nVaild == 1 or nCozone == 1 then
		local tbFind = me.FindItemInAllPosition(18, 1, 594, nWeddingLevel);
		for _, tbItem in pairs(tbFind or {}) do
			local szName = tbItem.pItem.szName;
			local nRet = me.DelItem(tbItem.pItem, Player.emKLOSEITEM_USE);
			if nRet == 1 then
				Dbg:WriteLog("Marry", "���ϵͳ", me.szAccount, me.szName, string.format("�۳�%s", szName));
				me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("�����ϵͳ���۳�%s", szName));
				break;
			end
		end
		if nVaild == 1 then
			Marry:RemoveWedding_GS(nWeddingLevel, nDate, {me.szName, szPartnerName, nMapLevel});
		else
			Marry:RemoveCozoneWedding_GS(nCoWeddingLevel, nCoDate, {me.szName, szCoPartnerName, nCoMapLevel});
		end
		local szLog = string.format("ɾ��Ԥ������, ���ڣ�%s���ȼ���%s����ͼ��%s", nDate, nWeddingLevel, nMapLevel);
		Dbg:WriteLog("Marry", "���ϵͳ", me.szAccount, me.szName, szLog);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "�����ϵͳ��" .. szLog);
				
	else
		if nLevel >= 1 and nLevel <= 4 then
			local tbFind = me.FindItemInAllPosition(18, 1, 603, nLevel);
			for _, tbItem in pairs(tbFind or {}) do
				local szName = tbItem.pItem.szName;
				local nRet = me.DelItem(tbItem.pItem, Player.emKLOSEITEM_USE);
				if nRet == 1 then
					Dbg:WriteLog("Marry", "���ϵͳ", me.szAccount, me.szName, string.format("�۳�%s", szName));
					me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("�����ϵͳ���۳�%s", szName));
					break;
				end
			end
		end
	end
end
--����ִ��END------------