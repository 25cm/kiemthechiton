--date :27/09/2012
SpecialEvent.Topplayer = SpecialEvent.Topplayer ;
local Topplayer = SpecialEvent.Topplayer ;
local tbItem = Item:GetClass("TopPlayer");
function tbItem:OnUse()
	local nLevel = it.nLevel;
	local nf = me.nFaction;
	local nSex = me.nSex;
	local szMsg ="Lệnh bài <color=gold>"..Topplayer.Name[nLevel].."<color> dùng để xây dựng tượng bất duyệt. Khi xây dựng tượng có thể nhận một món quà!\n <color=green>Chú ý:<color> thời gian tồn tại của tượng là 7 ngày. say 7 ngày tượng sẽ mất kể từ lúc xây dựng!"
	local tbOpt =
	{
		{"Xây tượng",self.CallNpc,self,nf,nSex,nLevel,it.dwId},
		{"Kết thúc đối thoại"}
	}
	Dialog:Say(szMsg,tbOpt)
end
function tbItem:CallNpc(nf,nSex,nLevel,dwId)
	local Item = KItem.GetObjById(dwId);
	if nf == 0 then 
		me.Msg("Bạn chưa gia nhập môn phái."); return ;
	end
	local nMapId,nX,nY = me.GetWorldPos();
	-- if nMapId ~= 29 then
		-- Dialog:Say("chỉ xây dựng tại Lâm An!");return;
	-- end
	local tbNpcList = KNpc.GetAroundNpcList(me, 10);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nKind == 3 then
			Dialog:Say("Bạn đứng quá gần <color=green>".. pNpc.szName .."<color> không thể xây được!")
			return;
		end
	end
	local pNpc = KNpc.Add2(Topplayer.IdNpc[nf][nSex+1], 170, -1,nMapId, nX,nY)
	pNpc.szName =	"Tượng Của "..me.szName;
	pNpc.SetTitle(Topplayer.OPT[nLevel]);
	Item.Delete(me);
	return 1, pNpc;
	
end