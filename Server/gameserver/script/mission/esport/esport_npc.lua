--������npc
--�����
--2008.12.25

--����
function Esport:OnDialog_SignUp(nSure)

	--if self.nReadyTimerId <= 0 or Timer:GetRestTime(self.nReadyTimerId) <= Esport.DEF_READY_TIME_ENTER  then
		--Dialog:Say("Th?i gian thi ??u l�� <color=yellow> 10 gi? s��ng ??n n?a ?��m <color>; n�� s? ???c t? ch?c n?a gi? m?t l?n v�� ??ng ky s? b?t ??u v��o m?t gi? r??i. Th?i gian ??ng ky l�� 10 ph��t. \ n \ n <color=red> Hi?n ch?a ??ng ky <color>");
		--return 0;
	--end
	
	if me.nTeamId <= 0 then
		if nSure == 1 then
			self:OnDialogApplySignUp();
			return 0;
		end
		if self:IsSignUpByAward(me) == 1 then
			Dialog:Say("B?n ch?a nh?n ???c ph?n th??ng c?a cu?c thi v?a r?i th�� ??ng ?��i qu�� c?a t?i nh��, t?i s? gi?n v�� kh?ng ??a b?n ?i ch?i ?au.");
			return 0;
		end		
		if self:IsSignUpByTask(me) == 0 then
			Dialog:Say("H?m nay b?n ?? tham gia r?t nhi?u l?n. H?y quay l?i ngh? ng?i v�� quay l?i v��o ng��y mai.");
			return 0;
		end
		local tbOpt = {
			{"T?i mu?n ?i", self.OnDialog_SignUp, self, 1},
			{"K?t th��c"},
			};
		Dialog:Say("B?n c�� mu?n t? m��nh v��o san c?a Yan Ruoxue v�� tham gia v��o tr?n n��m b��ng tuy?t t?i Feixuya kh?ng?", tbOpt);
		return 0;
	end
	

	if me.IsCaptain() == 0 then
		Dialog:Say("B?n kh?ng ph?i l�� ??i tr??ng, h?y y��u c?u ??i tr??ng c?a b?n ??ng ky.");
		return 0;
	end
	local tbPlayerList = KTeam.GetTeamMemberList(me.nTeamId);
	
	if nSure == 1 then
		self:OnDialogApplySignUp(tbPlayerList);
		return 0;
	end
	
	local tbOpt = {
		{"T?i mu?n ?i", self.OnDialog_SignUp, self, 1},
		{"K?t th��c"},
		};
	Dialog:Say(string.format("??i c?a b?n c�� mu?n v��o san c?a Yan Ruoxue v�� tham gia cu?c chi?n n��m b��ng tuy?t t?i Feixu Cliff kh?ng? ??i c�� <color=yellow>% s ng??i <color>, vui l��ng ??m b?o c��c c?u th? c�� m?t ? ?ay.", #tbPlayerList), tbOpt);
	return 0;
end

function Esport:OnDialogApplySignUp(tbPlayerList)
	if not tbPlayerList then
		GCExcute{"Esport:ApplySignUp",{me.nId}};
		return 0;
	end
	local nMapId, nPosX, nPosY	= me.GetWorldPos();	
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if not pPlayer then
			Dialog:Say("Ai ?�� trong ??i c?a b?n v?n ch?a ??n, ch��ng ta ch?a th? b?t ??u, h?y ??i anh ?y.");
			return 0;
		end
		if pPlayer.nLevel < self.DEF_PLAYER_LEVEL or pPlayer.nFaction <= 0 then
			
		end
		if pPlayer.nLevel < self.DEF_PLAYER_LEVEL or pPlayer.nFaction <= 0 then
			Dialog:Say(string.format("�����Ǹ�<color=yellow>%s<color>̫��С�˰ɣ�������������Σ���ˣ�50�������������Ժ������ɡ�", pPlayer.szName));
			return 0;
		end
		if self:IsSignUpByAward(pPlayer) == 1 then
			Dialog:Say(string.format("<color=yellow>%s<color>�ϴα����Ľ�����û���أ���׼��Ҫ�ҵ�����Ŷ���һ�������������ȥ��ġ�", pPlayer.szName));
			return 0;
		end				
		
		if self:IsSignUpByTask(pPlayer) == 0 then
			Dialog:Say(string.format("����<color=yellow>%s<color>�����ȥ�����ºö���ˣ����������ɡ�", pPlayer.szName));
			return 0;
		end
		local nMapId2, nPosX2, nPosY2	= pPlayer.GetWorldPos();
		local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
		if nMapId2 ~= nMapId or nDisSquare > 400 then
			Dialog:Say("�������ж��ѱ������⸽����");
			return 0;
		end
		if not pPlayer or pPlayer.nMapId ~= nMapId then
			Dialog:Say("�������ж��ѱ������⸽����");
			return 0;
		end
	end
	GCExcute{"Esport:ApplySignUp", tbPlayerList};
	return 0;
end

function Esport:IsSignUpByTask(pPlayer)
	Esport:TaskDayEvent();
	local nCount = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_COUNT);
	local nExCount = pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_EXCOUNT)
	if nCount <= 0 and nExCount <= 0 then
		return 0, 0 ,0;
	end
	return nCount + nExCount, nCount, nExCount;
end

function Esport:IsSignUpByAward(pPlayer)
	return pPlayer.GetTask(self.TSK_GROUP, self.TSK_ATTEND_AWARD);
end

function Esport:GetItemJinZhouBaoZu()
	local szMsg = "���ӣ�������ˣ�������ְ�������������ʲô���أ�";
	local tbNpc =  Npc:GetClass("esport_yanruoxue");
	local tbOpt = {
		{"��ȡ���䱬��", self.GetItemJinZhouBaoZuItem, self},
		{"������������", tbNpc.OnAboutNianShou, tbNpc},
		{"�˽�����", tbNpc.OnAboutNewYears, tbNpc},
		{"�������˼��ʸ��þ���"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function Esport:GetItemJinZhouBaoZuItem()
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("������������˶���������װ������");
		return 0;
	end
	if me.nLevel < 50 then
		Dialog:Say("��������Ϊ���㣬�������ⷴ�����������Է٣�����Ҫ50���Ժ��Ҳſɷ��ĸ��㡣");
		return 0;
	end
	
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDate = me.GetTask(self.TSK_GROUP, self.TSK_NEWYEAR_JINZHOUBAOZHU);
	
	if nCurDate <= nTaskDate then
		Dialog:Say("���Ѿ��ѱ��ڸ����ˣ������ж�ġ����ӣ����ס��������Ҫ�Լ�Ŭ��ȥ��ȡ��");
		return 0;
	end
	
	local pItem = me.AddItem(unpack(self.SNOWFIGHT_ITEM_JINZHOUBAOZHU));
	if pItem then
		pItem.Bind(1);
		me.SetTask(self.TSK_GROUP, self.TSK_NEWYEAR_JINZHOUBAOZHU, nCurDate);
		self:WriteLog("�õ���Ʒ"..pItem.szName, me.nId);
	end
	Dialog:Say("������ú��ˣ��������棬��������������������ȼ�Ļ��������令�����������ɴ������");
end
