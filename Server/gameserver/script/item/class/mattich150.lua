-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("mattich150")

local tbIdSkill = {
	[1]={1970},--Cai Bang rong
	[2]={1992},--Cai Bang bong
	[3]={1972},--ma Nhan
	[4]={1993},--Chien Nhan
	[5]={1982},--Thien Vuong Thuong
	[6]={1956},--Thien Vuong chuy
	[7]={1981},--Thieu Lam Dao
	[8]={1958},--Thieu Lam Bong
	[9]={1984},--Ngu Doc Dao
	[10]={1986},--Ngu Doc Chuong
	[11]={1959},--Duong Mon Tu Tien
	[12]={1988},--Duong Mon Ham Tinh
	[13]={1996},--Minh Giao chuy
	[14]={1961},--MG Kiem
	[15]={1978},--VD Khi
	[16]={1979},--VD Kiem
	[17]={1974},--Con Lon Dao
	[18]={1976},--Con Lon Kiem
	[19]={1962},--Nga My Chuong
	[20]={1990},--Nga My Kiem
	[21]={1966},--Thuy Yen Dao
	[22]={1964},--Thuy Yen Kiem
	[23]={1968},--Doan Thi Kiem
	[24]={1898},--Doan Thị Chỉ
}

function tbItem:OnUse()
	if me.nLevel < 150 then
		Dialog:Say("<color=green>Phải đạt cấp 150 trở lên để học bí tịch này!<color>");
		return 0;
	end
	--Kiem tra xem da hoc bi tich 150 nay hay chua
	if me.GetTask(3020, it.nLevel) > 0 then
		if me.GetTask(3020, it.nLevel) == 20 then
			Dialog:Say("<color=green>Cấp độ skill của bạn đã đạt cấp cao nhất rồi.<color>");
		else
			Dialog:Say("<color=green>Bạn đã học bí tịch này rồi, đến gặp Mộ Dung Phục để nâng skill lên nhé.<color>");
		end
		return 0;
	end
	
	--Chua hoc thi cho no hoc di thoi
	me.AddFightSkill(tbIdSkill[it.nLevel][1],1);
	me.SetTask(3020, it.nLevel, 1)
	Dialog:Say("<color=yellow>Chúc mừng bạn đã học được skill mới<color>");
	return 1;
end

local tbItem180 = Item:GetClass("mattich180")

local tbIdSkill180 = {
	[1]={1708},--Cai Bang rong
	[2]={1710},--Cai Bang bong
	[3]={1718},--ma Nhan
	[4]={1720},--Chien Nhan
	[5]={1722},--Thien Vuong Thuong
	[6]={1725},--Thien Vuong chuy
	[7]={1747},--Thieu Lam Dao
	[8]={1750},--Thieu Lam Bong
	[9]={1755},--Ngu Doc Dao
	[10]={1758},--Ngu Doc Chuong
	[11]={1751},--Duong Mon Tu Tien
	[12]={1753},--Duong Mon Ham Tinh
	[13]={1735},--Minh Giao chuy
	[14]={1737},--MG Kiem
	[15]={1734},--VD Khi
	[16]={1732},--VD Kiem
	[17]={1742},--Con Lon Dao
	[18]={1745},--Con Lon Kiem
	[19]={1712},--Nga My Chuong
	[20]={1716},--Nga My Kiem
	[21]={1738},--Thuy Yen Dao
	[22]={1740},--Thuy Yen Kiem
	[23]={1728},--Doan Thi Kiem
	[24]={1730},--Doan Thị Chỉ
}

function tbItem180:OnUse()
	if me.nLevel < 180 then
		Dialog:Say("<color=green>Phải đạt cấp 180 trở lên để học bí tịch này!<color>");
		return 0;
	end
	-- check 150
	if me.GetTask(3020, it.nLevel) > 0 then
		if me.GetTask(3020, it.nLevel) < 5 then
			Dialog:Say("<color=green>Skill 150 phải đạt cấp 5 trở lên mới học được kỹ năng này.<color>");
			return 0;
		end
	else
		Dialog:Say("<color=green>Bạn chưa học kỹ năng 150 này.<color>");
		return 0;
	end
	--Kiem tra xem da hoc bi tich 150 nay hay chua
	if me.GetTask(3047, it.nLevel) > 0 then
		if me.GetTask(3047, it.nLevel) == 20 then
			Dialog:Say("<color=green>Cấp độ skill của bạn đã đạt cấp cao nhất rồi.<color>");
		else
			Dialog:Say("<color=green>Bạn đã học bí tịch này rồi, đến gặp Mộ Dung Phục để nâng skill lên nhé.<color>");
		end
		return 0;
	end


	--Chua hoc thi cho no hoc di thoi
	me.AddFightSkill(tbIdSkill180[it.nLevel][1],1);
	me.SetTask(3047, it.nLevel, 1)
	Dialog:Say("<color=yellow>Chúc mừng bạn đã học được skill mới<color>");
	return 1;
end


