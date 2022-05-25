local tbAutoChiLing	= Map.tbAutoChiLing or {}; 
Map.tbAutoChiLing	= tbAutoChiLing;


local GuessSwitch = 1;
local Guess2Switch = 0;
local TeamLeaderGetBox=0;

local MainPlayer="";


local nChoseTime=0.6;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local nCheckMap1TimerId=0;
local nCheckMap2TimerId=0;
local nCheckMap3TimerId=0;
local nChose3TimerId=0;
local nAutoTaskTimerId=0;
local i,j,k,a,b,c

function tbAutoChiLing:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbAutoChiLing.Say_bak	= tbAutoChiLing.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbAutoChiLing.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()			
			tbAutoChiLing:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Timer:Register(1, fnOnSay);
	end

end

tbAutoChiLing.Init =function(self)
	self:ModifyUi();
end

function tbAutoChiLing:OnSay(szChannelName, szName, szMsg, szGateway)	
	local stype
	if   szChannelName=="Team" then
		stype="Đồng Đội"
	elseif  szChannelName=="Tong" then
		stype="Bang"
	elseif  szChannelName=="Friend" then
		stype="Hảo hữu"
	elseif  szChannelName=="Kin" then
		stype="Gia Tộc"
	elseif  szChannelName=="NearBy" then
		stype="Lân cận"
	end
	
	if (GuessSwitch == 0) then
		return;
	end

	if string.find(szMsg,"Triệu tập::") and szName~=me.szName and stype then
		me.Msg("<color=yellow>"..stype.."<color><color=green> ["..szName.."]<color><color=white> gọi bạn giúp đở<color>")
		local pos={};
		pos=self:Split(szMsg,"::");
		local tbMsg = {};
		tbMsg.szTitle = stype.." Gọi...";
		tbMsg.nOptCount = 2;
		tbMsg.tbOptTitle = { "Đến", "Không" };
		tbMsg.nTimeout = 10;
		tbMsg.szMsg = szName.." gọi bạn, bạn có đến không ?";
		function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
			if (nOptIndex == 0) then
			elseif (nOptIndex == 1) then
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = pos[2]
				-- me.Msg(tbPosInfo.szLink)
				Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
			elseif (nOptIndex == 2) then
			end
		end
		local szKey = "MsgBoxExample";	
		tbMsgInfo:AddMsg(szKey, tbMsg, "Đến", "Không", "...");
	elseif string.find(szMsg,"PK.:.Bang") and szName~=me.szName and stype=="Bang" then
		me.Msg("<color=yellow>"..stype.."<color><color=green> ["..szName.."]<color><color=white> gọi bạn bật PK Bang<color>")
		local pos={};
		pos=self:Split(szMsg,"::");
		local tbMsg = {};
		tbMsg.szTitle = stype.." Gọi...";
		tbMsg.nOptCount = 2;
		tbMsg.tbOptTitle = { "Bật", "Không" };
		tbMsg.nTimeout = 10;
		tbMsg.szMsg = szName.." gọi bạn bật PK Bang, bạn có bật không ?";
		function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
			if (nOptIndex == 0) then
			elseif (nOptIndex == 1) then
				SendChannelMsg("Tong","Đã chuyển PK Bang-Gia Tộc");
				SendChannelMsg("Kin","Đã chuyển PK Bang Hội-Gia Tộc!");
				me.nPkModel = Player.emKPK_STATE_TONG;
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = pos[2]
			elseif (nOptIndex == 2) then
			end
		end
		local szKey = "MsgBoxExample";		
		tbMsgInfo:AddMsg(szKey, tbMsg, "Bật", "Không", "...");
		elseif string.find(szMsg,"PK.:.Phe") and szName~=me.szName and stype=="Đồng Đội" then
		me.Msg("<color=yellow>"..stype.."<color><color=green> ["..szName.."]<color><color=white> gọi bạn bật PK Phe<color>")
		local pos={};
		pos=self:Split(szMsg,"::");
		local tbMsg = {};
		tbMsg.szTitle = stype.." Gọi...";
		tbMsg.nOptCount = 2;
		tbMsg.tbOptTitle = { "Bật", "Không" };
		tbMsg.nTimeout = 10;
		tbMsg.szMsg = szName.." gọi bạn bật PK Phe, bạn có bật không ?";
		function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
			if (nOptIndex == 0) then
			elseif (nOptIndex == 1) then
				SendChannelMsg("Team","Đã chuyển PK Phe !");
				me.nPkModel = Player.emKPK_STATE_CAMP;
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = pos[2]
			elseif (nOptIndex == 2) then
			end
		end
		local szKey = "MsgBoxExample";		
		tbMsgInfo:AddMsg(szKey, tbMsg, "Bật", "Không", "...");
	end	
	if string.find(szMsg,"3") and stype=="Đồng Đội" then
		if me.GetMapTemplateId() < 65500 then
		return
		end
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4223) then  
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bắt đầu mở Quang Ảnh Thạch");
	elseif string.find(szMsg,"Luyện.:.Công") and stype=="Đồng Đội" then
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=white>Đồng đội gọi bật [Luyện Công]<color>");
		me.Msg("<color=yellow>Đồng đội gọi bật [Luyện Công]<color>")
	end	
	---------------------------He Thong--------------------
	if  string.find(szMsg,"Tất cả bật tự động đánh") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
		AutoAi:StartAutoFight();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");	
		end
	end
	
	if  string.find(szMsg,"Tất cả dừng mọi hoạt động") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
		AutoAi:StopAutoFight();
		Map.tbAutoAim:AutoFollowStop();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Tất cả bật hộ tống") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
		Map.tbAutoAim:AutoFollowStart();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Tất cả trả nhiệm vụ quân doanh") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4237"});
		return;
		else 
		me.Msg("<color=lightgreen>Bạn không đứng trong bản đồ quân doanh");
		end
	end
	
	---------------------------HLVM------------------------
	if  string.find(szMsg,"Vào HLVM") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 555 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Quân Doanh!");
			return;
		else 
			Map.tbAutoQuanDoanh:GotoHLVM();
		end
	end
	
	if  string.find(szMsg,"Rừng Gai") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hải Lăng!");
			return;
		else 
			Ui.RungGaiHL:RRungGai();
		end
	end
	
	if  string.find(szMsg,"Tầng 2") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hải Lăng!");
			return;
		else 
				Map.tbAutoQuanDoanh:tang2();
				Map.tbAutoAim:AutoFollowStop();
			end
	end
	
	if  string.find(szMsg,"Tầng 4") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hải Lăng!");
			return;
		else 
				Map.tbSuperCall:AutoPuFireStop();
				Map.tbAutoAim:AutoFollowStop();
				Map.tbAutoQuanDoanh:tang4();
		end
	end

	----------------------BMS-------------------------
	if  string.find(szMsg,"Vào BMS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 555 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Quân Doanh!");
			return;
		else 
			Map.tbAutoQuanDoanh:GotoBMS();
		end
	end
	
	if  string.find(szMsg,"Có bao nhiêu NKT rồi") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbTool:NKT();
		end
	end


	if  string.find(szMsg,"Có bao nhiêu ĐBC rồi") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbTool:DBC();
		end
	end

	
	if  string.find(szMsg,"Anh em ra chỗ cổ vương nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:DanhBossBMS();
		end
	end
	
	if  string.find(szMsg,"Anh em quit khỏi BMS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:QuitBMS();
		end
	end
		
	--------------------------------HPNS-------------------------
	if  string.find(szMsg,"Vào HPNS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 555 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Quân Doanh!");
			return;
		else 
			Map.tbAutoQuanDoanh:GotoHPNS();
		end
	end
	if  string.find(szMsg,"Anh em cùng nhau bắt chuột nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoEgg:AutoPick();
		end
	end
	if  string.find(szMsg,"Anh em vượt rào nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Ui.VuotRaoHS:JumpSwitch();
		end
	end
	if  string.find(szMsg,"Anh em tìm nghĩa quân nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:TimNghiaQuan();
		end
	end	
	
	if  string.find(szMsg,"Anh em hái thảo dược nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoEgg2:AutoPick();
		end
	end	
	if  string.find(szMsg,"Anh em báo cáo đạo cụ nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbTool:DaoJu();
		end
	end		
	if  string.find(szMsg,"Anh em quit khỏi HPNS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:QuitHPNS();
		end
	end			
	-------------------------------Khác--------------------------
	if  string.find(szMsg,"Anh em vào TDC 2 nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237,2"});
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Anh em lấy rương máu TDC nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3234,3,1"});
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Anh em mở rương máu TDC nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
AutoAi:MoRuongThuocTDC();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	if  string.find(szMsg,"Anh em đi train nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
UiManager:StartGua();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
if  string.find(szMsg,"Anh em đi ghép HT nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
UiManager:hexuan();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
if  string.find(szMsg,"Anh em chạy BVĐ nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
UiManager:StartBao();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
if  string.find(szMsg,"Anh em lấy rương máu TDLT nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3406,2,1,1,1,1"});
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
if  string.find(szMsg,"Mở chế độ ôm cột TDLT") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
Map.tbcTDLT:StartCotTDLT();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
if  string.find(szMsg,"Tắt chế độ ôm cột TDLT") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
Map.tbcTDLT:StopCotTDLT();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	-------------------------------het---------------------------
	
	if string.find(szMsg,"mời <color=yellow>"..me.szName.."<color>") then	
		local s=szMsg;	
		self:OpenPanel();		
		Timer:Register(Env.GAME_FPS*nChoseTime,self.Chose2);    
		
	end
	
	if  string.find(szMsg,"trò chơi kết thúc") then
		if ( nChose3TimerId > 0 ) then
			Timer:Close(nChose2TimerId);
			nChose3TimerId=0;
		end
            	Timer:Register(Env.GAME_FPS*1.5, self.OpenPanel);  
		nChose3TimerId=Timer:Register(10,self.Chose3,self);
		Timer:Register(15,self.AutoFollow2);
        end
	
	if  string.find(szMsg,"Rương Hoàng Kim") then		
		Timer:Close(nChose3TimerId);
		nChose3TimerId=0;				
		Timer:Register(Env.GAME_FPS*1.5, self.OpenPanel);  		
		Timer:Register(Env.GAME_FPS*nChoseTime*5,self.Chose1);
		Timer:Register(15,self.AutoFollow3);		
    end

end


function tbAutoChiLing:OpenPanel()
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 200);
	for _, pNpc in ipairs(tbAroundNpc) do
		if pNpc.szName=="Du Long" or pNpc.szName=="Lối vào mật thất tầng " or pNpc.szName=="Lối vào Mật Thất 3" or pNpc.szName=="Chú Phù Ấn" then
			AutoAi.SetTargetIndex(pNpc.nIndex)
		end
	end
	return 0;
end

function tbAutoChiLing:Chose1()
		local nId = tbAutoChiLing:GetAroundNpcId(4210)
		if nId then
			return
		end	
        if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
			me.AnswerQestion(0);		
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
        return 0;
end 

function tbAutoChiLing:Chose2()
		local nId = tbAutoChiLing:GetAroundNpcId(4210)
		if nId then
			return
		end
    if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		me.AnswerQestion(2);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);	
	else
		me.AnswerQestion(0);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);	
	end
	if (UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1) and me.GetMapTemplateId() > 65500 then
		me.CallServerScript({ "DlgCmd", "InputNum", c });			
	end
	return 0;	
end 


function tbAutoChiLing:Chose3()
		local nId = tbAutoChiLing:GetAroundNpcId(4210)
		if nId then
			return
		end
        if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		me.AnswerQestion(0);		
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
end 


function tbAutoChiLing:ClosePanel()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	end
end


function tbAutoChiLing:AutoFollow2()
	local x2,y2,world = me.GetNpc().GetMpsPos();
	local nMyPosX2   = math.floor(x2/32);
	local nMyPosY2   = math.floor(y2/32);
	if (nMyPosX2 == 1788 and nMyPosY2 == 3293) then	
		me.Msg("<color=yellow>Tự động đi đến điểm Boss tầng 2<color>");		
		me.StartAutoPath(1771,3371);
	end
	if (nMyPosX2 == 1771 and nMyPosY2 == 3371) then				
		if (me.nAutoFightState ~= 1) then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());		
		end
		return 0;		
	end 
end

function tbAutoChiLing:AutoFollow3()
	local x3,y3,world = me.GetNpc().GetMpsPos();
	local nMyPosX3   = math.floor(x3/32);
	local nMyPosY3   = math.floor(y3/32);
	if (nMyPosX3 == 1775 and nMyPosY3 == 3490) then	
		me.Msg("<color=yellow>Tự động đi đến điểm Boss tầng 3<color>");
		me.AutoPath(1770,3556);
	end
	if (nMyPosX3 == 1770 and nMyPosY3 == 3556) then		
		if (me.nAutoFightState ~= 1) then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());		
		end
		return 0;
	end 
end

function tbAutoChiLing:AutoTask()	
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		me.AnswerQestion(0);		
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	elseif
		UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD);		
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
	end
end


function tbAutoChiLing:GuessSwitch()
	if GuessSwitch == 0 then
		GuessSwitch = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bật: <bclr=red><color=yellow>Hổ trợ Bạn Hữu-Quân Doanh [Alt+M]")
		me.Msg("<color=yellow>-Bật chức năng hổ trợ giúp đở Đội-Bang-Gia Tộc <color>");
		me.Msg("<color=yellow>-Bật chức năng hổ trợ Hải Lăng Vương Mộ <color>");
	else
		GuessSwitch = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt: <bclr=blue><color=white>Hổ trợ Bạn Hữu-Quân Doanh [Alt+M]")
		me.Msg("<color=green>-Ngừng chức năng hổ trợ gọi giúp đở Đội-Bang-Gia Tộc <color>");
		me.Msg("<color=green>-Ngừng chức năng hổ trợ hổ trợ Hải Lăng Vương Mộ <color>");
		Timer:Close(nAutoTaskTimerId);
		nAutoTaskTimerId=0;
		Timer:Close(nCheckMap1TimerId);
		nCheckMap1TimerId=0;
		Timer:Close(nCheckMap2TimerId);
		nCheckMap2TimerId=0;
		Timer:Close(nCheckMap3TimerId);
		nCheckMap3TimerId=0;
		Timer:Close(nChose3TimerId);
		nChose3TimerId=0;
		self.StopRun();
		Timer:Close(nDetectorTimerId);
		nDetectorTimerId=0;
	end
end

function tbAutoChiLing:Guess2Switch()
	if Guess2Switch == 0 then
		Guess2Switch = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bật <bclr=Black><color=yellow>hỗ trợ ngoài quân doanh [Alt+N]")
		me.Msg("<color=yellow>Bật hỗ trợ điều khiển tổ đội<color>");
	else
		Guess2Switch = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt <bclr=Black><color=white>hỗ trợ ngoài quân doanh [Alt+N]")
		me.Msg("<color=green>Ngừng chỗ trợ điều khiển tổ đội<color>");
	end
end

function tbAutoChiLing:Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

function tbAutoChiLing:GetAroundNpcId(self,nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end


local tCmd={ "Map.tbAutoChiLing:GuessSwitch()", "GuessSwitch", "", "alt+M", "alt+M", "GuessSwitch"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--alt+n
local tCmd={ "Map.tbAutoChiLing:Guess2Switch()", "Guess2Switch", "", "alt+N", "alt+N", "Guess2Switch"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--alt+n

tbAutoChiLing:Init();