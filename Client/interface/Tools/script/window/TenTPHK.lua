
local self = tbTenTPHK;

local tbTenTPHK	= Map.tbTenTPHK or {};
Map.tbTenTPHK		= tbTenTPHK;

local nTenTPstate = 0;
local nTimerId2 = 0;

local szCmd = [=[
	Map.tbTenTPHK:TenTPHKSwitch();
]=];

function tbTenTPHK:TenTPHKSwitch()
	if nTenTPstate == 0 then
		nTenTPstate = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật ăn 10 túi phúc rồi quit[Alt+G]<color>");
		me.Msg("<color=yellow>Bật<color>");
		nTimerId2 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.RunTenHK,self);
	else
		nTenTPstate = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt ăn 10 túi phúc rồi quit[Alt+G]<color>");
		me.Msg("<color=yellow>Tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId2);
		nTimerId2 = 0;
	end
end

function tbTenTPHK:RunTenHK()
local nFuCount, nFuLimit	= tbTenTPHK:GetFuDaiCountAndLimit();
if (nFuCount == 10) then
UiManager:StopBao();
Exit();	
end
if (nFuCount >= 11) then
UiManager:StopBao();
Exit();	
end
end
function tbTenTPHK:GetFuDaiCountAndLimit()
	local nFuCount	= me.GetTask(2013, 1); 
	local nFuDate	= me.GetTask(2013, 2); 
	local nFuLimit	= me.GetTask(2013, 3);

	local nNowDate	= GetTime();
	local nDay		= tonumber(os.date("%y%m%d", nNowDate));

	if (nFuDate < nDay) then
		nFuCount = 0;
	end
	
	if (nFuLimit <= 0) then
		nFuLimit = 10;
	end
	return nFuCount, nFuLimit;
end
	
local tCmd={"Map.tbTenTPHK:TenTPHKSwitch()", "TenTPHK", "", "Alt+G", "Alt+G", "TenTPHK"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);