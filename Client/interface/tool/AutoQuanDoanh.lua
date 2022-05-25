----------Auto Quan Doanh by HOAHONGNET---------------
Ui.UI_AutoQuanDoanh = "UI_AutoQuanDoanh";
local uiAutoQuanDoanh = Ui.tbWnd[Ui.UI_AutoQuanDoanh] or {};
uiAutoQuanDoanh.UIGROUP = Ui.UI_AutoQuanDoanh;
Ui.tbWnd[Ui.UI_AutoQuanDoanh] = uiAutoQuanDoanh;
Map.tbAutoQuanDoanh		= uiAutoQuanDoanh;
local self = uiAutoQuanDoanh;



local eggStart     = 0;
local nPickState   = 0;
local nPickTimerId = 0;
local nPickTime    = 0.3; 
------------------------He Thong-------------------------
local BTNreload								= "Btnreload"
local BTNChatTraQuest						= "BtnChatTraQuest"
local BTNChatStartBuff						= "BtnChatStartBuff"
local BTNChatStartPK						= "BtnChatStartPK"
local BTNChatStopPK							= "BtnChatStopPK"
-----------------------HLVM-----------------------------
local BTNBDHLVM								= "BtnBDHLVM"
local BTNChatGoHLVM							= "BtnChatGoHLVM"
local BTNChatRungGai						= "BtnChatRungGai"
local BTNChatTang2							= "BtnChatTang2"
local BTNChatTang4							= "BtnChatTang4"
local BTNphong								= "Btnphong"
local BTNlam								= "Btnlam"
local BTNhoa								= "Btnhoa"
local BTNson								= "Btnson"
local BTNtangboss3							= "Btntangboss3"
------------------------BMS-------------------------------
local BTNBDBMS								= "BtnBDBMS"
local BTNChatGoBMS							= "BtnChatGoBMS"
local BTNChatBCNKT							= "BtnChatBCNKT"
local BTNChatBCDBC							= "BtnChatBCDBC"
local BTNChatGotoBossBMS					= "BtnChatGotoBossBMS"
local BTNChatQuitBMS						= "BtnChatQuitBMS"
------------------------HPNS--------------------------------------
local BTNBDHPNS								= "BtnBDHPNS"
local BTNChatGoHPNS							= "BtnChatGoHPNS"
local BTNChatBatChuot						= "BtnChatBatChuot"
local BTNChatVuotRao						= "BtnChatVuotRao"
local BTNChatTimNQ							= "BtnChatTimNQ"
local BTNChatThaoDuoc						= "BtnChatThaoDuoc"
local BTNChatBCDC							= "BtnChatBCDC"
local BTNChatQuitHPNS						= "BtnChatQuitHPNS"
------------------------Khác---------------------------------------
local BTNChatGoTDC							= "BtnChatGoTDC"
local BTNChatRTDC							= "BtnChatRTDC"
local BTNChatMTDC							= "BtnChatMTDC"
local BTNChatTrain							= "BtnChatTrain"
local BTNChatGhepHT							= "BtnChatGhepHT"
local BTNChatBVD							= "BtnChatBVD"
local BTNChatRTDLT							= "BtnChatRTDLT"
local BTNChatStartTDLT						= "BtnChatStartTDLT"
local BTNChatStopTDLT						= "BtnChatStopTDLT"
-----------------------het-----------------------------------------

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

Ui:RegisterNewUiWindow("UI_AutoQuanDoanh", "AutoQuanDoanh", {"a", 536, 450}, {"b", 694, 597}, {"c", 855, 670});

function uiAutoQuanDoanh:Init()

end

function uiAutoQuanDoanh:OnButtonClick(szWnd)
	if (szWnd == BTNreload) then
		self.ScrReload();
	elseif (szWnd == BTNChatTraQuest) then
		uiAutoQuanDoanh:ChatTraQuest();	
	elseif (szWnd == BTNChatStartBuff) then
		uiAutoQuanDoanh:ChatStartBuff();
	elseif (szWnd == BTNChatStartPK) then
		uiAutoQuanDoanh:ChatStartPK();
	elseif (szWnd == BTNChatStopPK) then
		uiAutoQuanDoanh:ChatStopPK();		
		--------------HLVM-------------
	elseif (szWnd == BTNBDHLVM) then
		uiAutoQuanDoanh:BDHLVM();
	elseif (szWnd == BTNChatGoHLVM) then
		uiAutoQuanDoanh:ChatGoHLVM();
	elseif (szWnd == BTNChatRungGai) then
		uiAutoQuanDoanh:ChatRungGai();	
	elseif (szWnd == BTNChatTang2) then
		uiAutoQuanDoanh:ChatTang2();	
	elseif (szWnd == BTNChatTang4) then
		uiAutoQuanDoanh:ChatTang4();	
	elseif (szWnd == BTNphong) then
		uiAutoQuanDoanh:phong();
	elseif (szWnd == BTNlam) then
		uiAutoQuanDoanh:lam();
	elseif (szWnd == BTNhoa) then
		uiAutoQuanDoanh:hoa();
	elseif (szWnd == BTNson) then
		uiAutoQuanDoanh:son();
	elseif (szWnd == BTNtangboss3) then
		uiAutoQuanDoanh:tangboss3();
--------------------BMS-------------
	elseif (szWnd == BTNBDBMS) then
		uiAutoQuanDoanh:BDBMS();
	elseif (szWnd == BTNChatGoBMS) then
		uiAutoQuanDoanh:ChatGoBMS();
	elseif (szWnd == BTNChatBCNKT) then
		uiAutoQuanDoanh:ChatBCNKT();
	elseif (szWnd == BTNChatBCDBC) then
		uiAutoQuanDoanh:ChatBCDBC();
	elseif (szWnd == BTNChatGotoBossBMS) then
		uiAutoQuanDoanh:ChatGotoBossBMS();
	elseif (szWnd == BTNChatQuitBMS) then
		uiAutoQuanDoanh:ChatQuitBMS();
--------------------HPNS----------------------------		
	elseif (szWnd == BTNBDHPNS) then
		uiAutoQuanDoanh:BDHPNS();
	elseif (szWnd == BTNChatGoHPNS) then
		uiAutoQuanDoanh:ChatGoHPNS();
	elseif (szWnd == BTNChatBatChuot) then
		uiAutoQuanDoanh:ChatBatChuot();
	elseif (szWnd == BTNChatVuotRao) then
		uiAutoQuanDoanh:ChatVuotRao();
	elseif (szWnd == BTNChatTimNQ) then
		uiAutoQuanDoanh:ChatTimNQ();
	elseif (szWnd == BTNChatThaoDuoc) then
		uiAutoQuanDoanh:ChatThaoDuoc();
	elseif (szWnd == BTNChatBCDC) then
		uiAutoQuanDoanh:ChatBCDC();
	elseif (szWnd == BTNChatQuitHPNS) then
		uiAutoQuanDoanh:ChatQuitHPNS();
--------------------Khác----------------------------
	elseif (szWnd == BTNChatGoTDC) then
		uiAutoQuanDoanh:ChatGoTDC();
	elseif (szWnd == BTNChatRTDC) then
		uiAutoQuanDoanh:ChatRTDC();
	elseif (szWnd == BTNChatMTDC) then
		uiAutoQuanDoanh:ChatMTDC();
	elseif (szWnd == BTNChatTrain) then
		uiAutoQuanDoanh:ChatTrain();
	elseif (szWnd == BTNChatGhepHT) then
		uiAutoQuanDoanh:ChatGhepHT();
	elseif (szWnd == BTNChatBVD) then
		uiAutoQuanDoanh:ChatBVD();
	elseif (szWnd == BTNChatRTDLT) then
		uiAutoQuanDoanh:ChatRTDLT();
	elseif (szWnd == BTNChatStartTDLT) then
		uiAutoQuanDoanh:ChatStartTDLT();
	elseif (szWnd == BTNChatStopTDLT) then
		uiAutoQuanDoanh:ChatStopTDLT();
-----------------------het-------------------------------------		
end
end

uiAutoQuanDoanh.PeepChatMsg =function(self)
	uiAutoQuanDoanh.OnMsgArrival_bak	= uiAutoQuanDoanh.OnMsgArrival_bak or UiCallback.OnMsgArrival;
	function uiAutoQuanDoanh:OnMsgArrival(nChannelID, szSendName, szMsg)
		uiAutoQuanDoanh:SeeChatMsg(szMsg);
		uiAutoQuanDoanh.OnMsgArrival_bak(UiCallback, nChannelID, szSendName, szMsg);
	end
end


function uiAutoQuanDoanh:OnPickTimer()
	if (nPickState == 0) then
		return 0
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	if Map.firedown == 1 then
		return 0
	end
----------------
if me.GetMapTemplateId() > 273 and me.GetMapTemplateId() < 556  then
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong map nhiệm vụ<color>");
		me.Msg("<color=yellow>Chức năng này chỉ hoạt động trong map nhiệm vụ<color>")
		nPickState = 0;
		return
	end
-------------------
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do		
		if (pNpc.nTemplateId == 4038) then  -- HLVM 
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào HLVM [Shift+A]<color>");
			me.AnswerQestion(2)
			me.AnswerQestion(1)
			break;
		elseif (pNpc.nTemplateId == 2955) then  --AutoQuanDoanh
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào VAGT [Shift+A]<color>");
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			break;	

		end
	end
	if me.GetMapTemplateId() > 65500 then
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình [Shift+A]");
		Timer:Close(nPickTimerId);
	end
end

function uiAutoQuanDoanh:AutoPick()
	if nPickState == 0 then 
		nPickState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Mở chức năng vào HLVM và VAGT [Shift+A]");
		nPickTimerId = Timer:Register(Env.GAME_FPS * nPickTime, self.OnPickTimer, self);
	else
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chức năng vào HLVM và VAGT [Shift+A]");
		Timer:Close(nPickTimerId);
	end
end



function uiAutoQuanDoanh:OnSay(szChannelName, szName, szMsg, szGateway)
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
	end
	
-------------------HLVM---------------------------
function uiAutoQuanDoanh:ChatGoHLVM()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Vào HLVM")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatRungGai()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Rừng Gai");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatTang2()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tầng 2");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatTang4()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tầng 4");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:BDHLVM()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,3,1"});
end
end

function uiAutoQuanDoanh:GotoHLVM()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,3,2"});
end
end

function uiAutoQuanDoanh:phong()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1808,3223);
end


function uiAutoQuanDoanh:lam()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1895,3196);
end

function uiAutoQuanDoanh:hoa()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1835,3281);
end

function uiAutoQuanDoanh:son()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1833,3185);
end

function uiAutoQuanDoanh:tang2()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1757,3454);
end

function uiAutoQuanDoanh:tangboss3()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1746,3648);
end

function uiAutoQuanDoanh:tang4()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1940,3595);
end


-------------------BMS-----------------------------------------
function uiAutoQuanDoanh:ChatGoBMS()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Vào BMS")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatBCNKT()
if me.GetMapTemplateId() > 65500 then
SendChannelMsg("Team", "Có bao nhiêu NKT rồi");
end
end

function uiAutoQuanDoanh:ChatBCDBC()
if me.GetMapTemplateId() > 65500 then
SendChannelMsg("Team", "Có bao nhiêu ĐBC rồi");
end
end

function uiAutoQuanDoanh:ChatGotoBossBMS()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em ra chỗ cổ vương nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatQuitBMS()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em quit khỏi BMS");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:BDBMS()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,2,1"});
end
end

function uiAutoQuanDoanh:GotoBMS()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,2,2"});
end
end


function uiAutoQuanDoanh:DanhBossBMS()                                   
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1819,2845);
end

function uiAutoQuanDoanh:QuitBMS()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1837,2837);
end

----------------------------HPNS-----------------------------------------
function uiAutoQuanDoanh:ChatGoHPNS()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Vào HPNS")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatBatChuot()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cùng nhau bắt chuột nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatVuotRao()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vượt rào nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatTimNQ()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em tìm nghĩa quân nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatThaoDuoc()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em hái thảo dược nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatBCDC()
if me.GetMapTemplateId() > 65500 then
SendChannelMsg("Team", "Anh em báo cáo đạo cụ nào");
end
end

function uiAutoQuanDoanh:ChatQuitHPNS()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em quit khỏi HPNS");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:BDHPNS()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,1,1"});
end
end

function uiAutoQuanDoanh:GotoHPNS()
if me.GetMapTemplateId() > 555 and me.GetMapTemplateId() < 560 then
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,1,2"});
end
end

function uiAutoQuanDoanh:TimNghiaQuan()						
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1764,3080);
end

function uiAutoQuanDoanh:QuitHPNS()						
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
me.StartAutoPath(1666,3760);
end
end
--------------------------Khac----------------------------
function uiAutoQuanDoanh:ChatGoTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào TDC 2 nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatRTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu TDC nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatMTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu TDC nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatTrain()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi train nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatGhepHT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi ghép HT nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatBVD()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em chạy BVĐ nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatRTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu TDLT nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStartTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Mở chế độ ôm cột TDLT")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStopTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tắt chế độ ôm cột TDLT")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
--------------------------HE THONG------------------------
function uiAutoQuanDoanh:GetTeamLeader()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if nAllotModel and tbMemberList then
    local tLeader = tbMemberList[1];
    local pNpc = KNpc.GetByPlayerId(tLeader.nPlayerID);
    if(not pNpc or pNpc.szName == me.szName) then
    	return nil;
    end
		return pNpc;
	end
end

function uiAutoQuanDoanh:ChatTraQuest()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả trả nhiệm vụ quân doanh");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStartBuff()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật hộ tống");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStartPK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật tự động đánh");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStopPK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả dừng mọi hoạt động");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function uiAutoQuanDoanh:StartAutoFight()
	if me.nAutoFightState ~= 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end


function uiAutoQuanDoanh:ScrReload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\tool\\AutoQuanDoanh.lua");
	me.Msg("<color=blue>Tự động tải lại hoàn thành! ");
end

LoadUiGroup(Ui.UI_AutoQuanDoanh, "AutoQuanDoanh.ini");