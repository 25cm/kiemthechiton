local AutoAnswer = Ui.AutoAnswer or {};

local answer,answer1,nAnsIndex;
local nSwitch = 1;

function AutoAnswer:ModifyUi()
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	AutoAnswer.Say_bak	= AutoAnswer.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		AutoAnswer.Say_bak(uiSayPanel, tbParam);
		
		local function fnOnSay()
			AutoAnswer:OnSay(tbParam);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end

	AutoAnswer.EnterGame_bak	= AutoAnswer.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		AutoAnswer.EnterGame_bak(Ui);
	end
end

function UiManager:AutoAnswerSwitch()
	nSwitch = 1 - nSwitch;
	if nSwitch == 1 then
		--me.Msg("<color=yellow>Mở tự động trả lời Hoa Đăng-TĐKT [Ctrl+M]<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Mở tự động trả lời Hoa Đăng-TĐKT...[Ctrl+M]<color>");
	else
	if nSwitch == 0 then
		--me.Msg("<color=yellow>Tắt tự động trả lời Hoa Đăng-TĐKT [Ctrl+M]<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự động trả lời Hoa Đăng-TĐKT...[Ctrl+M]<color>");
	end
	end
end

function AutoAnswer:OnSay(tbParam)
		if nSwitch == 0 then
			return;
		end
		if string.find(tbParam[1], "Ngươi muốn đi đâu") then
			return;	
		end
		answer = nil;
		answer1 = nil;
		local pTabFile = KIo.OpenTabFile("\\interface\\AutoAnswer\\Tiku.txt");
		if (not pTabFile) then
			return;
		end
		local nHeight = pTabFile.GetHeight();
		for j=1,nHeight do
			local Str1 = pTabFile.GetStr(j,1);
			if string.find(tbParam[1],Str1) and (string.len(Str1) > 15) then
				answer = pTabFile.GetStr(j+1,1);
				answer1 = pTabFile.GetStr(j+1,2);
				break;
			end
		end
		if (me.nMapId >= 298 and me.nMapId <= 332 and Ui(Ui.UI_TEAM):IsTeamLeader() == 0) then
			if string.len(answer1) > 0 then
			else
			end
		end
		-- me.Msg("<color=yellow>Hỏi:<color><color=green>"..tbParam[1])
		for i, szAns in ipairs(tbParam[2]) do
			if  szAns == answer or szAns == answer1 then
				-- me.Msg("<color=yellow>Trả lời:<color><color=yellow>"..szAns);
				nAnsIndex = i;
				break;
			end
		end
		if nAnsIndex == nil then
			local szData = KFile.ReadTxtFile("\\interface\\AutoAnswer\\Titi.txt");
			if szData == nil then
				szData =" ";
			end
			if tbParam[2][3] == nil then
				tbParam[2][3] = " ";
			end
			szData = szData.."\r\n"..tbParam[1].."\r\n"..tbParam[2][1].."	"..tbParam[2][2].."	"..tbParam[2][3];
			--KFile.WriteFile("\\interface\\AutoAnswer\\Titi.txt", szData);
		end
	if (tbParam[2][nAnsIndex]) then
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", nAnsIndex);
	end
	nAnsIndex = nil;
end

function AutoAnswer:Init()
	self:ModifyUi();
end

AutoAnswer:Init();
	
	local tCmd={ "UiManager:AutoAnswerSwitch()", "AutoAnswerSwitch", "", "Ctrl+M", "Ctrl+M", "HoaÄÄƒng"};
		AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
		UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
