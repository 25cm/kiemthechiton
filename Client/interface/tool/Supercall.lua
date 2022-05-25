local tbSuperCall	= Map.tbSuperCall or {};
Map.tbSuperCall		= tbSuperCall;

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

local TimeridFire = Map.TimeridFire or 0;
Map.TimeridFire =TimeridFire;
local firedown = Map.firedown or 0;
Map.firedown = firedown;
local nPuFire=0;

function tbSuperCall:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbSuperCall.Say_bak	= tbSuperCall.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbSuperCall.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()
			tbSuperCall:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end

end

function tbSuperCall:OnSay(szChannelName, szName, szMsg, szGateway)
	print("szName:"..szName)
	local stype
	if szChannelName=="Kin" then
		stype="Gia Tộc"
	elseif  szChannelName=="Tong" then
		stype="Bang"
	elseif  szChannelName=="Friend" then
		stype="Hảo hữu"
	elseif  szChannelName=="Team" then
		stype="Đồng Đội"
	end
	Map.firedown = 0
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();	
	if  string.find(szMsg,"Dập Lửa") and szName==me.szName then
		Map.firedown = 0
		Map.TimeridFire = Ui.tbLogic.tbTimer:Register(10, tbSuperCall.Fire, self)
	elseif  string.find(szMsg,"Ngừng Dập") and szName==me.szName  then
		Map.firedown = 1
		UiManager:OpenWindow("UI_INFOBOARD","<bclr=Black><color=white>Ngừng dập lửa<color>");
		me.Msg("<color=green>Ngừng dập Lửa !<color>")
		Ui.tbLogic.tbTimer:Close(Map.TimeridFire);
		Timer:Close(self.FireTimerId);
		self.FireTimerId = nil;
	elseif  string.find(szMsg,"Đếm số") and szName==me.szName then
		Map.firedown = 0
		Map.TimeridFire = Ui.tbLogic.tbTimer:Register(20, tbSuperCall.Fire0, self)	
	end
end
function tbSuperCall:Fire0()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if Map.firedown == 1 then
		return 0
	end
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	SendChannelMsg("Team", "Tập trung,chuẩn bị đếm nè !!!")
	Map.TimeridFire = Ui.tbLogic.tbTimer:Register(50, tbSuperCall.Fire2, self)
	nPuFire = 0;
	return 0
end
function tbSuperCall:Fire2()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if Map.firedown == 1 then
		return 0
	end
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	SendChannelMsg("Team", "11111111111111111111111")
	Map.TimeridFire = Ui.tbLogic.tbTimer:Register(50, tbSuperCall.Fire3, self)
	nPuFire = 0;
	return 0
end

function tbSuperCall:Fire3()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if Map.firedown == 1 then
		return 0
	end
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	SendChannelMsg("Team", "22222222222222222222222")
	Map.TimeridFire = Ui.tbLogic.tbTimer:Register(50, tbSuperCall.Fire4, self)
	nPuFire = 0;
	return 0
end
function tbSuperCall:Fire4()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if Map.firedown == 1 then
		return 0
	end
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	SendChannelMsg("Team", "3333333333333333 -> Mở nào !!")
	nPuFire = 0;
	return 0
end

function tbSuperCall:Fire()
	if (me.GetMapTemplateId() < 65500) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Dập lửa chỉ hoạt động trong Hải Lăng !<color>");
		return;
	end
	
	local function fnOutfire()
		if (me.GetMapTemplateId() == 1) then
			Timer:Close(self.FireTimerId);
			self.FireTimerId = nil;
			return;
		end
		UiManager:OpenWindow("UI_INFOBOARD", "<color=Yellow>Đang dập lửa ... <color>");
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return;	
		end
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4235) then
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
		Timer:Close(self.FireTimerId);
		self.FireTimerId = nil;
	end
	if (not self.FireTimerId) then
		self.FireTimerId = Timer:Register(10, fnOutfire, self);
	end
	
end

function tbSuperCall:Callto2()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	SendChannelMsg("Kin", me.szName.."Triệu tập::"..me.szName..","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);

end
function tbSuperCall:Callto6()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	SendChannelMsg("Tong", me.szName.."Triệu tập::"..me.szName..","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
end
function tbSuperCall:Callto7()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	lSendChannelMsg("Friend", me.szName.."Triệu tập::"..me.szName..","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
end
function tbSuperCall:Callto5()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();

	SendChannelMsg("Team", me.szName.."Triệu tập::"..me.szName..","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
end
function tbSuperCall:OpenDoor()
	SendChannelMsg("Team", me.szName.."0 ...")
end
function tbSuperCall:Callto()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	SendChatMsg(me.szName.."Triệu tập::"..me.szName..","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY)
end

function tbSuperCall:OpenDoor()
       SendChannelMsg("Team", "֥�鿪��");
end

function tbSuperCall:AutoPuFire()
	if (me.GetMapTemplateId() < 65500) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Dập lửa chỉ hoạt động trong Hải Lăng !<color>");
		return;
	end
	if nPuFire == 0 then 
		nPuFire = 1;
		me.Msg("<color=yellow>Mở dập lửa ...<color>");
		SendChannelMsg("NearBy", "Dập Lửa");	
	else
		nPuFire = 0;
		me.Msg("<color=green>Tắt dập lửa !<color>");	
		SendChannelMsg("NearBy", "Ngừng Dập");
	end
end

function tbSuperCall:AutoPuFireStart()
	if nPuFire == 0 then
		tbSuperCall:AutoPuFire();
	end
end

function tbSuperCall:AutoPuFireStop()
	if nPuFire == 1 then
		tbSuperCall:AutoPuFire();
	end
end



function tbSuperCall:QuangAnhThach()
	if (me.GetMapTemplateId() < 65500) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ảnh Thạch chỉ hoạt động trong Hải Lăng !<color>");
		return;
	end
	if nPuFire == 0 then 
		nPuFire = 1;
		me.Msg("<color=yellow>Tự đếm số mở Quang Ảhh Thạch...<color>");
		SendChannelMsg("NearBy", "Đếm số");	
	end
end
function tbSuperCall:Split(szFullString, szSeparator)
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

function tbSuperCall:Init()
	tbSuperCall:ModifyUi()
	local szCmd1	= [=[
		Map.tbSuperCall:Callto1();
	]=];
	local szCmd2	= [=[
		Map.tbSuperCall:Callto2();
	]=];
	local szCmd3	= [=[
		Map.tbSuperCall:Callto3();
	]=];
	local szCmd6	= [=[
		Map.tbSuperCall:OpenDoor();
	]=];
	local szCmd7	= [=[
		Map.tbSuperCall:AutoPuFire();
	]=];
	local szCmd8	= [=[
		Map.tbAutoEgg:AutoPick();
	]=];
end

tbSuperCall:Init()