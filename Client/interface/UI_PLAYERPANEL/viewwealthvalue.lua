-------------------------
-- bảng tài phú
-------------------------
local uiValue = Ui:GetClass("viewwealthvalue");

local tbEquitName = {};
local tbEquitExName = {};
local tbEquitQianghuaGrade = {}; 
local tbEquitQianghuaGradeMax = {};					
local tbEquitExQianghuaGrade = {};
local tbEquitExQianghuaGradeMax = {};
local tbEquitValue ={};
local tbEquitExValue = {};
local tbEquitQHValue = {};
local tbEquitExQHValue = {};
local tbOtherEquitName = {};
local tbOtherEquitValue = {};
local tbEquitDefineName ={"Nón", "Áo", "Lưng", "Vũ khí", "Giày", "Tay", "Phù", "Nhẫn", "Liên", "Bội"};
local tbOtherEquitDefineName = {"Ngựa", "Mặt Nạ", "Bí kíp", "Trận đồ", "Ngũ hành ấn", "Phi phong", "Quan ấn"};

local NUMBER			= 10;
local OTHERNUMBER	= 7;
local PAGESET_MAIN					= "PageSetMain";
local PAGE_HISTORY					= "PageHistory";	
local BTN_HONOR 					= "BtnHistory";		
local OUTLOOK_HISTORY				= "OutLookHistory";		

local TEXT_BASIC_CAIFURONGYU		= "TxtBasicCaifurongyu";
local TEXT_NOW_CAIFURONGYU			= "TxtNowCaifurongyu";    	
local TEXT_GRADE     				= "TxtBasicGrade";			

uiValue.BUTTON_CLOSE		= "BtnClose";                        
uiValue.BUTTON_UP   		= "BtnBasicUp";
uiValue.BUTTON_DOWN  	 	= "BtnBasicDown";

function uiValue:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BUTTON_CLOSE) then		
		UiManager:CloseWindow(self.UIGROUP);		
	elseif (szWnd == self.BUTTON_UP) then		
		self:OnIncrease();
	elseif (szWnd == self.BUTTON_DOWN) then			
		self:OnDecrease();
	end
end

function uiValue:OnOpen()
	PgSet_ActivePage(self.UIGROUP, PAGESET_MAIN, PAGE_HISTORY);
	self:UpdateEquitData();			
	self:UpdateOtherEquit();
	self:OnUpdateHonor();
	self:UpdateCaifurongyu();
end

function uiValue:UpdateEquitData()
	for i = 1 ,NUMBER do
		if( me.GetItem(Item.ROOM_EQUIP, i-1, 0) ~= nil ) then
			tbEquitName[i] =   me.GetItem(Item.ROOM_EQUIP, i-1, 0).szName;
			tbEquitQianghuaGrade[i] =  me.GetItem(Item.ROOM_EQUIP, i-1, 0).nEnhTimes;
			tbEquitQianghuaGradeMax[i] = Item:CalcMaxEnhanceTimes(me.GetItem(Item.ROOM_EQUIP, i-1, 0));
			tbEquitValue[i] = PlayerHonor:CaculateEquipOrgValue(Item.ROOM_EQUIP, i-1)/10000;
			tbEquitQHValue[i] = PlayerHonor:CaculateEquipEnhValue(Item.ROOM_EQUIP, i-1, tbEquitQianghuaGrade[i])/10000;
		else
			tbEquitName[i] =  tbEquitDefineName[i];
			tbEquitQianghuaGrade[i] = 0;
			tbEquitQianghuaGradeMax[i] = 0;
			tbEquitValue[i] = 0;
			tbEquitQHValue[i] = 0;
		end		
		if ( me.GetItem(Item.ROOM_EQUIPEX, i-1, 0) ~= nil ) then
			tbEquitExName[i] =   me.GetItem(Item.ROOM_EQUIPEX, i-1, 0).szName;
			tbEquitExQianghuaGrade[i] =  me.GetItem(Item.ROOM_EQUIPEX, i-1, 0).nEnhTimes;
			tbEquitExQianghuaGradeMax[i] = Item:CalcMaxEnhanceTimes(me.GetItem(Item.ROOM_EQUIPEX, i-1, 0));
			tbEquitExValue[i] = PlayerHonor:CaculateEquipOrgValue(Item.ROOM_EQUIPEX, i-1)/10000;
			tbEquitExQHValue[i] = PlayerHonor:CaculateEquipEnhValue(Item.ROOM_EQUIPEX, i-1, tbEquitExQianghuaGrade[i])/10000;
		else
			tbEquitExName[i] =  tbEquitDefineName[i];
			tbEquitExQianghuaGrade[i] = 0;
			tbEquitExQianghuaGradeMax[i] = 0;
			tbEquitExValue[i] = 0;
			tbEquitExQHValue[i] = 0;
		end
	end
end 

function uiValue:UpdateCaifurongyu()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_CAIFURONGYU, "Tài phú hiện tại:"..PlayerHonor.tbPlayerHonorData.tbHonorData[3].tbHonorSubList[1].nValue );
	Txt_SetTxt(self.UIGROUP, TEXT_NOW_CAIFURONGYU, "Tài phú (+):"..PlayerHonor:CaculateTotalWealthValue());
end

function uiValue:UpdateOtherEquit()
	for i = 1 ,OTHERNUMBER do
		if ( me.GetItem(Item.ROOM_EQUIP, i+9, 0) ~= nil ) then
			tbOtherEquitName[i] =   me.GetItem(Item.ROOM_EQUIP, i+9, 0).szName;	
			tbOtherEquitValue[i] =   me.GetItem(Item.ROOM_EQUIP, i+9, 0).nValue/10000;		
		else
			tbOtherEquitName[i] =  tbOtherEquitDefineName[i];
			tbOtherEquitValue[i] =  0;
		end	
	end	
end

function uiValue:OnIncrease()	
	if ( 0 == self.m_nSelTitleX) then
		if (tbEquitQianghuaGrade[self.m_nSelTitleY] < tbEquitQianghuaGradeMax[self.m_nSelTitleY] and 0 <= tbEquitQianghuaGrade[self.m_nSelTitleY] ) then
			tbEquitQianghuaGrade[self.m_nSelTitleY] = tbEquitQianghuaGrade[self.m_nSelTitleY] +1;
			tbEquitQHValue[self.m_nSelTitleY] = PlayerHonor:CaculateEquipEnhValue(Item.ROOM_EQUIP,self.m_nSelTitleY-1,tbEquitQianghuaGrade[self.m_nSelTitleY])/10000;		
		end
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,tbEquitQianghuaGrade[self.m_nSelTitleY] );
	elseif ( 1 == self.m_nSelTitleX) then
		if (tbEquitExQianghuaGrade[self.m_nSelTitleY] < tbEquitExQianghuaGradeMax[self.m_nSelTitleY] and 0 <= tbEquitExQianghuaGrade[self.m_nSelTitleY] ) then
			tbEquitExQianghuaGrade[self.m_nSelTitleY] = tbEquitExQianghuaGrade[self.m_nSelTitleY] +1;			
		tbEquitExQHValue[self.m_nSelTitleY] = PlayerHonor:CaculateEquipEnhValue(Item.ROOM_EQUIPEX,self.m_nSelTitleY-1,tbEquitExQianghuaGrade[self.m_nSelTitleY])/10000;
		end
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,tbEquitExQianghuaGrade[self.m_nSelTitleY] );
	end	
	self:OnUpdateHonor();		
	self:UpdateCaifurongyu();
end
function uiValue:OnDecrease()	
	if ( 0 == self.m_nSelTitleX) then		
		if (tbEquitQianghuaGrade[self.m_nSelTitleY] <= tbEquitQianghuaGradeMax[self.m_nSelTitleY] and 0 < tbEquitQianghuaGrade[self.m_nSelTitleY] ) then
			tbEquitQianghuaGrade[self.m_nSelTitleY] = tbEquitQianghuaGrade[self.m_nSelTitleY] -1;
			tbEquitQHValue[self.m_nSelTitleY] = PlayerHonor:CaculateEquipEnhValue(Item.ROOM_EQUIP,self.m_nSelTitleY-1,tbEquitQianghuaGrade[self.m_nSelTitleY])/10000;	
		end		
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,tbEquitQianghuaGrade[self.m_nSelTitleY] );
	elseif ( 1 == self.m_nSelTitleX) then
		if (tbEquitExQianghuaGrade[self.m_nSelTitleY] <= tbEquitExQianghuaGradeMax[self.m_nSelTitleY] and 0 < tbEquitExQianghuaGrade[self.m_nSelTitleY] ) then
			tbEquitExQianghuaGrade[self.m_nSelTitleY] = tbEquitExQianghuaGrade[self.m_nSelTitleY] -1;			
			tbEquitExQHValue[self.m_nSelTitleY] = PlayerHonor:CaculateEquipEnhValue(Item.ROOM_EQUIPEX,self.m_nSelTitleY-1,tbEquitExQianghuaGrade[self.m_nSelTitleY])/10000;
		end		
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,tbEquitExQianghuaGrade[self.m_nSelTitleY] );
	end	
	self:OnUpdateHonor();	
	self:UpdateCaifurongyu();
end
---bảng tài phú có 4 cột , cột 0 namequip , cột 1 gốc, cột 2 tăng lên , cột 3 (+)
function uiValue:OnUpdateHonor()           
         	
	OutLookPanelClearAll(self.UIGROUP, OUTLOOK_HISTORY);
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	--set độ rộng từng cột
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 0, 190);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 1, 15);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 2, 50);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 3, 20);	

	AddOutLookGroup(self.UIGROUP, OUTLOOK_HISTORY, "<color=green>Trang bị hiện tại");
	AddOutLookGroup(self.UIGROUP, OUTLOOK_HISTORY, "<color=red>Trang bị dự phòng");
	AddOutLookGroup(self.UIGROUP, OUTLOOK_HISTORY, "<color=blue>Trang bị hổ trợ");
	-----------k cho hiện cột gốc{nameequip,cột 1,cột 2,cột 3}
	for i = 1 , NUMBER do
		if (tbEquitValue[i] >= tbEquitExValue[i] ) then
			AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 0, {"*"..tbEquitName[i],"", string.format("%.2f",tbEquitQHValue[i]),tbEquitQianghuaGrade[i]});
			AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 1, {"*"..tbEquitExName[i],"",string.format("%.2f",tbEquitExQHValue[i]),tbEquitExQianghuaGrade[i]});
		else
			AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 0, {"*"..tbEquitName[i],"", string.format("%.2f",tbEquitQHValue[i]),tbEquitQianghuaGrade[i]});
			AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 1, {"*"..tbEquitExName[i],"", string.format("%.2f",tbEquitExQHValue[i]),tbEquitExQianghuaGrade[i]});
		end
	end
--- hỗ trợ
	for i = 1 , OTHERNUMBER do
		AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 2, {"*"..tbOtherEquitName[i], string.format("%.2f",tbOtherEquitValue[i])});
	end
	AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 2, {"*Unknow",string.format("%.2f",PlayerHonor:GetWulinmijiValue()/10000) });
	AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 2, {"*Unknow",string.format("%.2f",PlayerHonor:GetXisuijingValue()/10000) });
	AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, 2, {"*Unknow",string.format("%.2f",PlayerHonor:GetXiaohaoValue()/10000) });
end

function uiValue:OnOutLookItemSelected(szWndName, nGroupIndex, nItemIndex)
	if (szWndName ~= OUTLOOK_HISTORY) then
		return;
	end
	self.m_nSelTitleX = nGroupIndex;
	self.m_nSelTitleY = nItemIndex + 1;
	
	if (0 == nGroupIndex) then
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,tbEquitQianghuaGrade[nItemIndex+1] );
	elseif (1 == nGroupIndex) then
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,tbEquitExQianghuaGrade[nItemIndex+1] );
	else
		Txt_SetTxt(self.UIGROUP, TEXT_GRADE,0);
	end
end
Ui:RegisterNewUiWindow("UI_VIEWWEALTHVALUE", "viewwealthvalue", {"a", 366, 51}, {"b", 403, 131}, {"c", 403, 131});
