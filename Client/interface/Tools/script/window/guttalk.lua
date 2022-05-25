local uiGutTalk = Ui(Ui.UI_GUTTALK)
local tbTimer = Ui.tbLogic.tbTimer;

local IMAGE_PORTRAIT		= "ImgPortrait";
local TEXT_DIALOG		    = "TxtDialog";
local DEFAULT_PORTRAIT		= "";


uiGutTalk.OnButtonClick = function(self ,szWndName, nParam)
	if self.nTimerId ==0 then
		self:ShowNextSentence();
	else
		if self.nTimerId and (self.nTimerId ~= 0) then
			tbTimer:Close(self.nTimerId);
			self.nTimerId = 0;
		end
		Txt_SetTxt(self.UIGROUP, TEXT_DIALOG, self.szOrgText);
	end
end

uiGutTalk.ShowNextSentence = function(self)
	local szPic = "";
	szPic, self.szMainText = self:GetNextSentence();
	self.szOrgText = self.szMainText;
	print(self.szMainText)
	if szPic and self.szMainText then
		Img_SetImage(self.UIGROUP, IMAGE_PORTRAIT, 1, szPic);
		me.Msg("<color=0,255,255>"..self.szOrgText.."<color>")
		tbTimer:Close(self.nTimerId);
		self.nTimerId = 0;
		Txt_SetTxt(self.UIGROUP, TEXT_DIALOG, self.szOrgText);

		if (not self.nTimerId) or (self.nTimerId == 0) then
			local function nextsentense()
			if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
			Ui(Ui.UI_GUTAWARD):OnButtonClick("zBtnAccept");	
			end
			uiGutTalk:OnButtonClick();
			end
			Ui.tbLogic.tbTimer:Register(5, nextsentense);
		end
	else
		UiManager:CloseWindow(self.UIGROUP);
	end
end

