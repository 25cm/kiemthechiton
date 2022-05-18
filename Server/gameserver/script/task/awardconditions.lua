function TaskAwardCond:None()
	return 1;
end

--------------------------------------------------------------
-- 男性
function TaskAwardCond:IsMale()
	if (me.nSex == 0) then
		return 1;
	end
end

-- 女性
function TaskAwardCond:IsFemale()
	if (me.nSex == 1) then
		return 1;
	end
end
--------------------------------------------------------------
function TaskAwardCond:IsJin()
	if (me.nSeries == Env.SERIES_METAL) then
		return 1;
	end
end

function TaskAwardCond:IsMu()
	if (me.nSeries == Env.SERIES_WOOD) then
		return 1;
	end
end

function TaskAwardCond:IsShui()
	if (me.nSeries == Env.SERIES_WATER) then
		return 1;
	end
end


function TaskAwardCond:IsHuo()
	if (me.nSeries == Env.SERIES_FIRE) then
		return 1;
	end
end


function TaskAwardCond:IsTu()
	if (me.nSeries == Env.SERIES_EARTH) then
		return 1;
	end
end


--------------------------------------------------------------
-- 少林
function TaskAwardCond:DaoShaoLin()
	if (me.nFaction == Player.FACTION_SHAOLIN and me.nRouteId == Player.ROUTE_DAOSHAOLIN) then
		return 1;
	end
end

function TaskAwardCond:QuanShaoLin()
	return;
end

function TaskAwardCond:GunShaoLin()
  	if (me.nFaction == Player.FACTION_SHAOLIN and me.nRouteId == Player.ROUTE_GUNSHAOLIN) then
		return 1;
	end
end



-- 天王
function TaskAwardCond:DaoTianWang()
	return;
end

function TaskAwardCond:QiangTianWang()
	if (me.nFaction == Player.FACTION_TIANWANG and me.nRouteId == Player.ROUTE_QIANGTIANWANG) then
		return 1;
	end
end

function TaskAwardCond:ChuiTianWang()
	if (me.nFaction == Player.FACTION_TIANWANG and me.nRouteId == Player.ROUTE_CHUITIANWANG) then
		return 1;
	end
end 


-- 唐門
function TaskAwardCond:FeiDaoTangMen()
	if (me.nFaction == Player.FACTION_TANGMEN and me.nRouteId == Player.ROUTE_FEIDAOTANGMEN) then
		return 1;
	end
end 

function TaskAwardCond:XiuJianTangMen()
	if (me.nFaction == Player.FACTION_TANGMEN and me.nRouteId == Player.ROUTE_XIUJIANTANGMEN) then
		return 1;
	end
end 


function TaskAwardCond:FeiBiaoTangMen()
	return;
end 


-- 五毒
function TaskAwardCond:DaoWuDu()
	if (me.nFaction == Player.FACTION_WUDU and me.nRouteId == Player.ROUTE_DAOWUDU) then
		return 1;
	end
end 

function TaskAwardCond:ZhangWuDu()
	if (me.nFaction == Player.FACTION_WUDU and me.nRouteId == Player.ROUTE_ZHANGWUDU) then
		return 1;
	end
end 

function TaskAwardCond:ZuZhouWuDu()
	return;
end 


-- 峨嵋
function TaskAwardCond:ZhangEMei()
	if (me.nFaction == Player.FACTION_EMEI and me.nRouteId == Player.ROUTE_ZHANGEMEI) then
		return 1;
	end
end 

function TaskAwardCond:JianEMei()
	return;
end 

function TaskAwardCond:FuZhuEMei()
	if (me.nFaction == Player.FACTION_EMEI and me.nRouteId == Player.ROUTE_FUZHUEMEI) then
		return 1;
	end
end 


-- 翠煙
function TaskAwardCond:JianCuiYan()
	if (me.nFaction == Player.FACTION_CUIYAN and me.nRouteId == Player.ROUTE_JIANCUIYAN) then
		return 1;
	end
end 

function TaskAwardCond:DaoCuiYan()
	if (me.nFaction == Player.FACTION_CUIYAN and me.nRouteId == Player.ROUTE_DAOCUIYAN) then
		return 1;
	end
end 


-- 丐幫
function TaskAwardCond:ZhangGaiBang()
	if (me.nFaction == Player.FACTION_GAIBANG and me.nRouteId == Player.ROUTE_ZHANGGAIBANG) then
		return 1;
	end
end 

function TaskAwardCond:GunGaiBang()
	if (me.nFaction == Player.FACTION_GAIBANG and me.nRouteId == Player.ROUTE_GUNGAIBANG) then
		return 1;
	end
end 


-- 天忍
function TaskAwardCond:ZhanTianRen()
	if (me.nFaction == Player.FACTION_TIANREN and me.nRouteId == Player.ROUTE_ZHANTIANREN) then
		return 1;
	end
end 

function TaskAwardCond:MoTianRen()
	if (me.nFaction == Player.FACTION_TIANREN and me.nRouteId == Player.ROUTE_MOTIANREN) then
		return 1;
	end
end 

function TaskAwardCond:ZuZhouTianRen()
	return;
end 


-- 武當
function TaskAwardCond:QiWuDang()
	if (me.nFaction == Player.FACTION_WUDANG and me.nRouteId == Player.ROUTE_QIWUDANG) then
		return 1;
	end
end 

function TaskAwardCond:JianWuDang()
	if (me.nFaction == Player.FACTION_WUDANG and me.nRouteId == Player.ROUTE_JIANWUDANG) then
		return 1;
	end
end 


-- 昆侖
function TaskAwardCond:DaoKunLun()
	if (me.nFaction == Player.FACTION_KUNLUN and me.nRouteId == Player.ROUTE_DAOKUNLUN) then
		return 1;
	end
end 

function TaskAwardCond:JianKunLun()
	if (me.nFaction == Player.FACTION_KUNLUN and me.nRouteId == Player.ROUTE_JIANKUNLUN) then
		return 1;
	end
end


function TaskAwardCond:FuZhuKunLun()
	return;
end


-- 明教
function TaskAwardCond:ChuiMingJiao()
	if (me.nFaction == Player.FACTION_MINGJIAO and me.nRouteId == Player.ROUTE_CHUIMINGJIAO) then
		return 1;
	end
end

function TaskAwardCond:JianMingJiao()
	if (me.nFaction == Player.FACTION_MINGJIAO and me.nRouteId == Player.ROUTE_JIANMINGJIAO) then
		return 1;
	end
end

-- 大理段勢
function TaskAwardCond:ZhiDuanShi()
	if (me.nFaction == Player.FACTION_DUANSHI and me.nRouteId == Player.ROUTE_ZHIDUANSHI) then
		return 1;
	end
end

function TaskAwardCond:QiDuanShi()
	if (me.nFaction == Player.FACTION_DUANSHI and me.nRouteId == Player.ROUTE_QIDUANSHI) then
		return 1;
	end
end

function TaskAwardCond:ArmyCampReputeLimit90_100()
--	if (me.GetReputeLevel(1, 2) <= 4) then
	return 1;
--	end
	
--	return nil, "您的軍營聲望已經達到上限,不會再獲得聲望!";
end

function TaskAwardCond:FuNiuShanExtAreaTaskNum()
--	1024，54，小於等於50
	if (me.GetTask(1024, 54) <= 50) then
		return 1;
	end
end


--------------------------------------------------------------
-- 少林
function TaskAwardCond:ShaoLin()
	if (me.nFaction == Player.FACTION_SHAOLIN) then
		return 1;
	end
end

-- 天王
function TaskAwardCond:TianWang()
	if (me.nFaction == Player.FACTION_TIANWANG) then
		return 1;
	end
end

-- 唐門
function TaskAwardCond:TangMen()
	if (me.nFaction == Player.FACTION_TANGMEN) then
		return 1;
	end
end 

-- 五毒
function TaskAwardCond:WuDu()
	if (me.nFaction == Player.FACTION_WUDU) then
		return 1;
	end
end 

-- 峨嵋
function TaskAwardCond:EMei()
	if (me.nFaction == Player.FACTION_EMEI) then
		return 1;
	end
end 

-- 翠煙
function TaskAwardCond:CuiYan()
	if (me.nFaction == Player.FACTION_CUIYAN) then
		return 1;
	end
end 

-- 丐幫
function TaskAwardCond:GaiBang()
	if (me.nFaction == Player.FACTION_GAIBANG) then
		return 1;
	end
end 

-- 天忍
function TaskAwardCond:TianRen()
	if (me.nFaction == Player.FACTION_TIANREN) then
		return 1;
	end
end 

-- 武當
function TaskAwardCond:WuDang()
	if (me.nFaction == Player.FACTION_WUDANG) then
		return 1;
	end
end 

-- 昆侖
function TaskAwardCond:KunLun()
	if (me.nFaction == Player.FACTION_KUNLUN) then
		return 1;
	end
end 

-- 明教
function TaskAwardCond:MingJiao()
	if (me.nFaction == Player.FACTION_MINGJIAO) then
		return 1;
	end
end

-- 大理段勢
function TaskAwardCond:DuanShi()
	if (me.nFaction == Player.FACTION_DUANSHI) then
		return 1;
	end
end
