--Rừng Gai
----------------------------
local RungGaiHL = Ui.RungGaiHL or {};
Ui.RungGaiHL = RungGaiHL;

function RungGaiHL:RRungGai()
	if (me.GetMapTemplateId() < 65500) then	
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hải Lăng<color>");
		return;
	end
	local nStartRun = 0;
	local nRunNum	= 1;
	local tbRunPos	= {
		[1]		= {PosX = 51360, PosY = 101664,},
		[2]		= {PosX = 51488, PosY = 101792,},
		[3]		= {PosX = 51616, PosY = 101952,},
		[4]		= {PosX = 51680, PosY = 102112,},
		[5]		= {PosX = 51744, PosY = 102272,},
		[6]		= {PosX = 51808, PosY = 102464,},
		[7]		= {PosX = 51872, PosY = 102688,},
		[8]		= {PosX = 51904, PosY = 102880,},
		[9]		= {PosX = 51936, PosY = 103168,},
		[10]	= {PosX = 51968, PosY = 103328,},
		[11]	= {PosX = 52000, PosY = 103552,},
		[12]	= {PosX = 52000, PosY = 103680,},
		[13]	= {PosX = 52000, PosY = 103808,},
		[14]	= {PosX = 52000, PosY = 103904,},
		[15]	= {PosX = 52000, PosY = 103936,},
		[16]	= {PosX = 51968, PosY = 104032,},
		[17]	= {PosX = 51904, PosY = 104128,},
		[18]	= {PosX = 51808, PosY = 104256,},
		[19]	= {PosX = 51808, PosY = 104384,},
		[20]	= {PosX = 51840, PosY = 104512,},
		[21]	= {PosX = 51904, PosY = 104608,},
		[22]	= {PosX = 52000, PosY = 104576,},
		[23]	= {PosX = 52064, PosY = 104416,},
		[24]	= {PosX = 52192, PosY = 104224,},
		[25]	= {PosX = 52352, PosY = 104096,},
		[26]	= {PosX = 52448, PosY = 104192,},
		[27]	= {PosX = 52480, PosY = 104288,},
		[28]	= {PosX = 52416, PosY = 104416,},
		[29]	= {PosX = 52384, PosY = 104544,},
		[30]	= {PosX = 52416, PosY = 104672,},
		[31]	= {PosX = 52480, PosY = 104672,},
		[32]	= {PosX = 52608, PosY = 104704,},
		[33]	= {PosX = 52704, PosY = 104832,},
		[34]	= {PosX = 52736, PosY = 104960,},
		[35]	= {PosX = 52672, PosY = 105088,},
		[36]	= {PosX = 52544, PosY = 105216,},
		[37]	= {PosX = 52512, PosY = 105376,},
		[38]	= {PosX = 52576, PosY = 105472,},
		[39]	= {PosX = 52704, PosY = 105568,},
		[40]	= {PosX = 52832, PosY = 105504,},
		[41]	= {PosX = 52960, PosY = 105344,},
		[42]	= {PosX = 53056, PosY = 105216,},
		[43]	= {PosX = 53216, PosY = 105408,},
		[44]	= {PosX = 53184, PosY = 105536,},
		[45]	= {PosX = 53088, PosY = 105696,},
		[46]	= {PosX = 53120, PosY = 105856,},
		[47]	= {PosX = 53216, PosY = 106016,},
		[48]	= {PosX = 53344, PosY = 106080,},
		[49]	= {PosX = 53536, PosY = 105856,},
		[50]	= {PosX = 53760, PosY = 105696,},
		[51]	= {PosX = 54016, PosY = 105696,},
		[52]	= {PosX = 54016, PosY = 105696,},
		[53]	= {PosX = 54208, PosY = 105760,},
		[54]	= {PosX = 54208, PosY = 105760,},
		[55]	= {PosX = 54336, PosY = 106144,},
		[56]	= {PosX = 54464, PosY = 106560,},
		[57]	= {PosX = 54621, PosY = 106653,},
		[58] 	= {PosX	= 55136, PosY = 105120,},
	};
	local function fnAutoRun()
		local nSize	 = Lib:CountTB(tbRunPos);	
		local nStartPosX = math.floor(tbRunPos[1].PosX / 32);
		local nStartPosY = math.floor(tbRunPos[1].PosY / 32);
		local nNextPosX  = tbRunPos[nRunNum].PosX;
		local nNextPosY  = tbRunPos[nRunNum].PosY;
		local nEndPosX	 = tbRunPos[nSize].PosX;
		local nEndPosY	 = tbRunPos[nSize].PosY;	
		local nMyPosX, nMyPosY, _ = me.GetNpc().GetMpsPos();
		if (nStartRun == 0) then
			if (nStartPosX ~= math.floor(nMyPosX / 32) and nStartPosY ~= math.floor(nMyPosY / 32)) then
				me.StartAutoPath(nStartPosX, nStartPosY);
				return;
			else
				nStartRun = 1;
			end
		end
		if (nMyPosX == nEndPosX and nMyPosY == nEndPosY) then
			if not (me.nFaction == 5 and me.CanCastSkill(98) == 1) then
				if (me.nAutoFightState ~= 1) then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());		
				end
			end
			Timer:Close(self.JJLTimerId);
			self.JJLTimerId = nil;
			return;
		elseif (nMyPosX == nNextPosX and nMyPosY == nNextPosY) then
			nRunNum = nRunNum + 1;
		else
			AutoAi.AiAutoMoveTo(nNextPosX, nNextPosY);
		end
	end
	if (not self.JJLTimerId) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu chạy qua Rừng gai<color>");
		self.JJLTimerId = Timer:Register(Env.GAME_FPS * 0.2, fnAutoRun, self);
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ngừng chạy qua Rừng gai<color>");
		Timer:Close(self.JJLTimerId);
		self.JJLTimerId = nil;
	end
end