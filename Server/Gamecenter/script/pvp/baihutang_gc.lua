-------------------------------------------------------------------
--File		: baihutang_gc.lua
--Author	: ZouYing
--Date		: 2008-1-8 14:13
--Describe	: 白虎堂开始报名，开始PK和结束PK的触发
-------------------------------------------------------------------

if not MODULE_GC_SERVER then
	return;
end

function BaiHuTang:ApplyStart()
	GlobalExcute{"BaiHuTang:ApplyStart_GS"};
end

function BaiHuTang:PKStop()
	GlobalExcute{"BaiHuTang:PKStop_GS"};
end

function BaiHuTang:PKStart(nTaskId)
	GlobalExcute{"BaiHuTang:PKStart_GS", nTaskId};
end

function BaiHuTang:NextPvpStart()
	GlobalExcute{"BaiHuTang:NextPvpStart_GS"};
end
