local ReloadCH = {};
Map.ReloadCH = ReloadCH;
------------------------Main
function ReloadCH:Reload(szFilePath)
	local szFileData = KFile.ReadTxtFile(szFilePath);
	assert(loadstring(szFileData, szFilePath))();
end
------------------------RELOAD các hàm khác
function ReloadCH:Tools()
	self:Reload("\\interface\\Tools\\script\\window\\Tools.lua");
	me.Msg("<color=lightblue>Reload Thanh TOOLS OK!");
end

function ReloadCH:Tool()
	self:Reload("\\interface\\tool\\tool.lua");
	me.Msg("<color=lightblue>Reload Thanh TOOL OK!");
end

function ReloadCH:PhimTat()
	self:Reload("\\interface\\Tools\\script\\window\\shortcuts.lua");
	me.Msg("<color=lightblue>Reload Phím Tắt OK!");
end

function ReloadCH:TDBuff()
	self:Reload("\\interface\\Tools\\script\\window\\AutoAsist.lua");
	me.Msg("<color=lightblue>Reload Tự Động Buff Phụ Trợ OK!");
end

function ReloadCH:WorldMap()
	self:Reload("\\interface\\Tools\\script\\window\\worldmap_sub.lua");
	me.Msg("<color=lightblue>Reload World Map OK!");
end

function ReloadCH:DaoKhoBau()
	UiManager:hhEndWaBao();
	self:Reload("\\interface\\Tools\\script\\window\\autotreasure.lua");
	me.Msg("<color=lightblue>Reload Đào Kho Báu OK!");
end

function ReloadCH:HLVM()
	self:Reload("\\interface\\tool\\AutoChiLing.lua");
	self:Reload("\\interface\\tool\\Supercall.lua");
	self:Reload("\\interface\\tool\\AutoQuanDoanh.lua");
	self:Reload("\\interface\\tool\\Input0.lua");
	me.Msg("<color=lightblue>Reload Auto HLVM OK!");
end

function ReloadCH:Mgr()
	self:Reload("\\interface\\Tools\\script\\window\\mgr.lua");
	me.Msg("<color=lightblue>Reload Manager OK!");
end

function ReloadCH:Miniclock()
	Ui(Ui.UI_MINICLOCK):Reload();
	me.Msg("<color=lightblue>Reload Đồng Hồ OK!");
end

function ReloadCH:BVD()
	self:Reload("\\interface\\sprBao\\SuperBao.lua");
	me.Msg("<color=lightblue>Reload SuperBao OK!");
end

function ReloadCH:BVDSetting()
	self:Reload("\\interface\\sprBao\\SprBao_setting.lua");
	me.Msg("<color=lightblue>Reload SuperBao Setting OK!");
end

function ReloadCH:TraLoiCH()
	self:Reload("\\interface\\AutoAnswer\\AutoAnswer.lua");
	self:Reload("\\interface\\AutoAnswer\\Hoadang.lua");
	me.Msg("<color=lightblue>Reload Trả Lời Câu Hỏi OK!");
end

function ReloadCH:TheoSau()
	self:Reload("\\interface\\btssl_autoFollow\\main.lua");
	self:Reload("\\interface\\btssl_autoFollow\\autoFollow.lua");
	me.Msg("<color=lightblue>Reload Tự Động Theo Sau - Hộ Tống OK!");
end

function ReloadCH:GhepHT()
	self:Reload("\\interface\\Compose\\Compose.lua");
	me.Msg("<color=lightblue>Reload Ghép HT Shift+X OK!");
end

function ReloadCH:F12()
	self:Reload("\\interface\\Tools\\script\\window\\helpsprite.lua");
	me.Msg("<color=lightblue>Reload Thông Tin F12 OK!");
end

function ReloadCH:HaiTac()
	self:Reload("\\interface\\AutoThief\\AutoThief.lua");
	me.Msg("<color=lightblue>Reload Auto Săn Hải Tặc OK!");
end

function ReloadCH:TuDongDanh()
	self:Reload("\\interface\\btssl_autofight\\script\\window\\auto_fight.lua");
	self:Reload("\\interface\\btssl_autofight\\script\\window\\autofight.lua");
	me.Msg("<color=lightblue>Reload Tự Động Đánh OK!");
end

function ReloadCH:SuperMapLink()
	self:Reload("\\interface\\supermaplink\\supermaplink.lua");
	me.Msg("<color=lightblue>Reload SuperMapLink OK!");
end

function ReloadCH:SuperMapLinkUI()
	UiManager:CloseWindow(Ui.UI_SUPERMAPLINK_UI);
	self:Reload("\\interface\\supermaplink\\maplink_ui.lua");
	me.Msg("<color=lightblue>Reload SuperMapLink UI OK!");
end

function ReloadCH:Self()
	self:Reload("\\interface\\Tools\\script\\window\\ReloadCH.lua");
	me.Msg("<color=lightblue>Reload ReloadCH OK!");
end
------------------Chọn File cần Reload và Reload Self
function ReloadCH:LinhTinh()
	self:Reload("\\interface\\UI_PLAYERPANEL\\playerpanel.lua");
	me.Msg("<color=lightblue>Reload Linh Tinh OK!");
end
--------------------------------------------------------------------