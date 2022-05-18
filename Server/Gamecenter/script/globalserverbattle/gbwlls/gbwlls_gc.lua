function GbWlls:Gc_Anncone(szAnncone)
	GC_AllExcute({"GbWlls:Gb_Anncone", szAnncone});
end
	
function GbWlls:Gb_Anncone(szAnncone)
	if GLOBAL_AGENT then
		GC_AllExcute({"GbWlls:Anncone_GC", szAnncone});
	end
end

function GbWlls:Anncone_GC(szAnncone)
--	local nGate = tonumber(string.sub(GetGatewayName(), 5, -1));
--	if GbWlls.tbLeagueName[nGate] then
	GlobalExcute({"GbWlls:Anncone_GS", szAnncone});
--	end
end
