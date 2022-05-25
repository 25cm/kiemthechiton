
Ui.tbCheckPlugin = Ui.tbCheckPlugin or {};
local tbCheckPlugin = Ui.tbCheckPlugin;
tbCheckPlugin.tbIgnoreList = {};
tbCheckPlugin.tbErrorPluginName = {};
tbCheckPlugin.nColor = 0;
tbCheckPlugin.tbColorList = {"yellow", "red", "green", "blue", "orange"};
tbCheckPlugin.bOpenReport = 0;

function tbCheckPlugin:SaveIgnore()
end

function tbCheckPlugin:LoadIgnoreList()
end

function tbCheckPlugin:AskIgnore(szName, nVersion)
	
end

function tbCheckPlugin:BeginReport(nVersion)
end

function tbCheckPlugin:ReportPluginError(nVersion)
end

function tbCheckPlugin:GetPluginNameByPath(szPath)
end

function tbCheckPlugin:AnalyzeStack(szTxt)
end

function tbCheckPlugin:CheckLoadError(szTxt)
end

function tbCheckPlugin:CheckRuntimeError(szTxt)
end

function tbCheckPlugin:CheckSendDataError()
end

function tbCheckPlugin:CheckOpenReport()
end

function tbCheckPlugin:OpenReportError(bOpen)
end
