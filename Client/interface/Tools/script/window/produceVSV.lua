local produceVSV = Map.produceVSV or {};
Map.produceVSV = produceVSV;

local i;
local nSwitch = 0;
local VSTBId = 0;
local VSVId = 0;
local nproduceTimer;
local nVSVdau = 0;
local nHLco = 0;
local nTLco = 0;
local nNHHTco = 0;
local nTBVSco = 0;

function produceVSV:SwitchproduceVSV()
	if nSwitch == 0 then		
		self:Start_produceVSV();
	else		
		self:Stop_produceVSV();
	end
end

function produceVSV:Start_produceVSV()		
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Đứng Yên Chế Vỏ Sò Vàng [Alt+V]<color>");
	produceVSV:Vosovang();	
end

function produceVSV:Vosovang()			
	if me.IsAccountLock() ~= 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bạn Phải Mở Khóa Tài Khoản Trước <color>");
		produceVSV:Stop_produceVSV();
		return	
	else
		nSwitch = 1;
		nHLco = me.dwCurGTP;
		nTLco = me.dwCurMKP;
		nNHHTco = me.GetItemCountInBags(18,1,205,1,0,0);
		nVSVdau = me.GetItemCountInBags(18,1,325,1);
		nTBVSco = me.GetItemCountInBags(22,1,61,1);
		nproduceTimer = Ui.tbLogic.tbTimer:Register(0.7*Env.GAME_FPS, self.doing, self);			
	end		
end		

function produceVSV:doing()
	if nSwitch == 1 then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return
		end			
		if me.GetItemCountInBags(18,1,205,1,0,0) > 0 and me.dwCurGTP >= 100 then				
			if me.GetSingleLifeSkill(1).nLevel > 79 then
				me.DoRecipe(1557);
			elseif me.GetSingleLifeSkill(2).nLevel > 79 then
				me.DoRecipe(1558);
			elseif me.GetSingleLifeSkill(3).nLevel > 79 then
				me.DoRecipe(1559);
			elseif me.GetSingleLifeSkill(4).nLevel > 79 then
				me.DoRecipe(1560);
			elseif me.GetSingleLifeSkill(5).nLevel > 79 then
				me.DoRecipe(1561);
			end		
		end				
		if (me.GetItemCountInBags(18,1,205,1,0,0) == 0) or me.dwCurGTP < 100 then
			if me.GetItemCountInBags(22,1,61,1) >= 2 and me.dwCurMKP >= 225 then
				if me.GetSingleLifeSkill(6).nLevel > 79 then
					me.DoRecipe(1562);
				elseif me.GetSingleLifeSkill(7).nLevel > 79 then
					me.DoRecipe(1563);
				elseif me.GetSingleLifeSkill(8).nLevel > 79 then
					me.DoRecipe(1564);
				elseif me.GetSingleLifeSkill(9).nLevel > 79 then
					me.DoRecipe(1565);
				elseif me.GetSingleLifeSkill(10).nLevel > 79 then
					me.DoRecipe(1566);
				end
			else					
				local HLsx = (nHLco - me.dwCurGTP);
				local TLsx = (nTLco - me.dwCurMKP);			
				local nNHHTsx = (nNHHTco - me.GetItemCountInBags(18,1,205,1,0,0));
				local nTBVSsx = 0;
				local nVSVsx = 0;
				if (nTLco > me.dwCurMKP) then
					nVSVsx = math.floor(TLsx/225);
					nTBVSsx = nVSVsx*2;
				end				
				local szMsg	="                           <bclr=Black><color=yellow>FINISH<color><bclr>"..	
							"\n          "..
							"\n<color=yellow>Vỏ Sò Vàng: " .. " <color=red> ".. nVSVdau .. 
							"\n<color=102,153,0>SXz : <color><color=red> ".. nVSVsx .. "<color=102,153,0>          Hiện có: <color><color=red> "..me.GetItemCountInBags(18,1,325,1)..
							"\n          "..
							"\n<color=25,255,69>Ngũ Hành Hồn Thạch: " .. " <color=102,255,255> ".. nNHHTco .. 
							"\n<color=102,153,0>Use: <color><color=102,255,255> ".. nNHHTsx .. "<color=102,153,0>                Còn: <color><color=102,255,255> "..me.GetItemCountInBags(18,1,205,1,0,0).. 
							"\n          "..
							"\n<color=255,0,102>Vỏ Sò Thần Bí: <color> " .. " <color=255,204,255> "..nTBVSco.. 
							"\n<color=102,153,0>Use: <color><color=255,204,255> ".. nTBVSsx .. "<color=102,153,0>                Còn: <color><color=255,204,255> "..me.GetItemCountInBags(22,1,61,1).. 
							"\n          "..
							"\n<color=253,190,105>Hoạt Lực:<color> " .. " <color=204,102,0> ".. nHLco .. 
							"\n<color=102,153,0>Use: <color><color=204,102,0> ".. HLsx .. "<color=102,153,0>               Còn: <color><color=204,102,0> "..me.dwCurGTP.. 
							"\n          "..
							"\n<color=pink>Tinh Lực:<color> " .. " <color=204,255,51> ".. nTLco .. 
							"\n<color=102,153,0>Use: <color><color=204,255,51> ".. TLsx .. "<color=102,153,0>               Còn: <color><color=204,255,51> "..me.dwCurMKP.. 
							"\n           ";								
				local tbOpt = 	{ 	
					{ "<color=25,255,69>Exit<color>" }		
				};		
				Dialog:Say(szMsg, tbOpt);				
				produceVSV:Stop_produceVSV();
				return		
			end	
		end	
	else
		produceVSV:Stop_produceVSV();
		return
	end
end

function produceVSV:Stop_produceVSV()
	nSwitch = 0;
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white> Dừng Chế Vỏ Sò Vàng [Alt+V]<color>");	
	Ui.tbLogic.tbTimer:Close(nproduceTimer);
	nproduceTimer = 0;
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\Tools\\script\\window\\produceVSV.lua");	
end

local tCmd={"Map.produceVSV:SwitchproduceVSV()", "SwitchproduceVSV", "", "Alt+V", "Alt+V", "SwitchproduceVSV"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
  