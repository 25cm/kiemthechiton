--File: log_ui.lua
--Author: sunduoliang
--Date: 2008-3-23 15:31:26
--Describe: Ui统计Log
-------------------------------------------------------------------
Log.Ui_TbSaveTempInit = {};

--记录Log Ui注释
Log.Ui_TbSaveTempInit = 
{
	--["角色等级"] = {},
	--["F1主角界面"] = {},
	--["F2物品界面"] = {},
	--["F3技能界面"] = {},
	--["F4任务界面"] = {},
	--["F5人际界面"] = {},
	--["F6家族界面"] = {},
	--["P组队界面"] = {},
	--["F8生活技能界面"] = {},
	--["F11系统设置界面"] = {},
	--["F12帮助系统界面"] = {},
	--["打开奇珍阁"] = {},
	--["打开大地图"] = {},
	--["切换小地图大小"] = {},
	--["V打坐"] = {},
	--["切换聊天频道"] = {},
	--["Ctrl+鼠标右键"] = {},
	--["交易"] = {},
	--["添加好友"] = {},
	--["组队"] = {},
	--["密聊"] = {},
	--["查看邮件"] = {},
	--["鼠标左右键技能更改"] = {},	
	--["快捷键更改"] = {},
	--["自动寻路"] = {},
	--["自动打怪"] = {},
	--["PK状态切换"] = {},
	--["在2级前是否点击白秋林"] = {},
	--["是否使用过车夫"] = {},
	--["是否使用过储物箱"] = {},
	--["是否改变过存点"] = {},	 
	--["是否使用过回城卷"] = {},	
	["Mở trang cẩm nang trợ giúp"] = {},
	["Mở trang hoạt động đề cử"] = {},
	["Mở trang trợ giúp chi tiết"] = {},
	["Mở biểu tượng tìm kiếm"] = {},
	["Mở trang tìm hiểu Kiếm Thế"] = {},
	[string.format("Chọn vào khu %s-Vật phẩm mới",IVER_g_szCoinName)] = {},
	[string.format("Chọn vào khu %s-Vật phẩm đề cử", IVER_g_szCoinName)] = {},
	["Mở trang bạc"] = {},
	["Mở khu đồng khóa-vật phẩm mới"] = {},
	["Mở khu đồng khóa-vật phẩm đề cử"] = {},
	["Mở điểm giao dịch"] = {},
	["Mở hộp thư"] = {},
	["Sử dụng Tu Luyện Châu"] = {},
};

--client 接口
function Log:Ui_SendLog(szField, nValue)
	-- do return end; -- 关闭
	if self.Ui_TbSaveTempInit[szField] == nil then
		return;
	end
	
	if self.Ui_TbSaveTempInit[szField][me.nId] == nil then
		me.CallServerScript({ "NewPlayerUiCmd", szField, nValue});
		self.Ui_TbSaveTempInit[szField][me.nId] = 1;
	end
end

--server 接口
function Log:Ui_LogSetValue(szField, nValue)
	-- do return end; -- 关闭
	-- 不合法的指令不予通过
	if self.Ui_TbSaveTempInit[szField] == nil then
		--print("指令不通过");
		return;
	end	
	
	if self.Ui_TbSaveTempInit[szField][me.nId] == nil then
		self.Ui_TbSaveTempInit[szField][me.nId] = 1;
		-- print(szKey, szField, nValue)
		KStatLog.ModifyField("ui", me.szName, szField, nValue)
		-- KStatLog.ModifyField("ui", szField, "点击数据统计", nValue)
	end
end
