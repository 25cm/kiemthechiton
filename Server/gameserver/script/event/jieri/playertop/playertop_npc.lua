SpecialEvent.Topplayer = SpecialEvent.Topplayer ;
local Topplayer = SpecialEvent.Topplayer ;
local Npc = {};
SpecialEvent.TopplayerNPC = Npc;
function Npc:OnDialog()
	local szMsg="Ngươi đến tìm ta có việt gì không?";
	local tbOpt =
	{
		{"Nhận lệnh bài",self.Item,self,me},
		{"Kết thúc đối thoại",self.Test,test},
	};
	Dialog:Say(szMsg,tbOpt);
end

function Npc:Test()
	local nf = me.nFaction;
	local nSex = me.nSex;
	me.Msg(":"..Topplayer.IdNpc[2][1]);
end
function Npc:Item(pPlayer)
	for i=1 ,5 do
		if GetTotalLadderRankByName(Topplayer.nLadderType[i], pPlayer.szName)==1 then
			pPlayer.AddItem(18,1,30292,i);
			me.Msg("Bạn nhận được lệnh bài xây tượng".." "..Topplayer.Name[i]);
		end
	end
end