	


local tbTaskItem = Item:GetClass("taskitem");


function tbTaskItem:OnUse()
	Task:OnTaskItem(it);
	return 0;
end

function tbTaskItem:IsPickable()
	for _, tbTask in pairs(Task:GetPlayerTask(me).tbTasks) do
		if (tbTask:IsItemToBeCollect({it.nGenre, it.nDetail, it.nParticular, it.nLevel}) == 1) then
			return 1;
		end
	end
	
	me.Msg("Không được nhặt.")
	
	return 0;
end

function tbTaskItem:PickUp()
	Task:SharePickItem(me, it);
	return 1;
end

function tbTaskItem:GetTip()
	local szTip = "";

	if (it.nParticular == 463) then
		szTip = szTip.."<color=0x8080ff>Cần 2000000 điểm kinh nghiệm tu luyện để hoàn thành.<color>";
	elseif(it.nParticular == 464) then
		szTip = szTip.."<color=0x8080ff>Cần 6000000 điểm kinh nghiệm tu luyện để hoàn thành.<color>";
	elseif(it.nParticular == 465) then
		szTip = szTip.."<color=0x8080ff>Cần 18000000 điểm kinh nghiệm tu luyện để hoàn thành.<color>";
	end

	return szTip;

end
