if not MODULE_GAMESERVER then
	return;
end
function GoiBeBanhBao:ThongBaoBeBanhBao_GS()
		local nMapIndex = SubWorldID2Idx(4);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","Bạn đang chơi <color=gold>Kiếm Thế Chí Tôn<color> Phiên Bản V2.6 được phát triển và chia sẻ bởi Team: <color=green>ThànhBG và CôngHmc<color>. Mọi thắc mắc hãy liên hệ với <color=pick>FanPage Kiếm Thế Chí Tôn<color> để được hỗ trợ"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Bạn đang chơi <color=gold>Kiếm Thế Chí Tôn<color> Phiên Bản V2.6 được phát triển và chia sẻ bởi Team: <color=green>ThànhBG và CôngHmc<color>. Mọi thắc mắc hãy liên hệ với <color=pick>FanPage Kiếm Thế Chí Tôn<color> để được hỗ trợ");
KDialog.MsgToGlobal("Bạn đang chơi <color=gold>Kiếm Thế Chí Tôn<color> Phiên Bản V2.6 được phát triển và chia sẻ bởi Team: <color=green>ThànhBG và CôngHmc<color>. Mọi thắc mắc hãy liên hệ với <color=pick>FanPage Kiếm Thế Chí Tôn<color> để được hỗ trợ");	
end