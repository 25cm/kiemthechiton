--- 房间设置

Require("\\script\\mission\\xoyogame\\room_base.lua");
Require("\\script\\player\\define.lua");

XoyoGame.RoomSetting = {};
local BaseRoom = XoyoGame.BaseRoom
local RoomSetting = XoyoGame.RoomSetting;

RoomSetting.tbRoom = {};
local tbRoom = RoomSetting.tbRoom;

-- 全拷贝table，注意不能出现table环链~否则会死循环
local function CopyTable(tbSourTable, tbDisTable)
	if not tbSourTable or not tbDisTable then
		return 0;
	end
	for varField, varData in pairs(tbSourTable) do
		if type(varData) == "table" then
			tbDisTable[varField] = {}
			CopyTable(varData, tbDisTable[varField]);
		else
			tbDisTable[varField] = varData;
		end
	end
end

-- 触发条件格式
-- {nLockId, nLockState}	锁ID，锁状态

-- AI类型,定义在xoyogame_def.lua 下要保持一致
-- 移动 	AI_MOVE, szRoad, nLockId, [nAttact, bRetort, bArriveDel]		按路线移动到本地图某个区域(具体路线要制定好，否则怪物可能穿越障碍行走)
-- 循环移动 AI_RECYLE_MOVE,	szRoad, [nAttact, bRetort, nTimes]				按路线循环移动
-- 攻击目标 AI_ATTACK, szNpc, nCamp											攻击目标为szNpc，改变NPC阵营

-- EVENT类型
-- 添加NPC		ADD_NPC, nIndex, nNum, nLock, szGroup, szPointName, [nTimes, nFrequency, szTimerName]
-- 删除npc		DEL_NPC, szGroup
-- 更改trap 	CHANGE_TRAP, ClassName, tbPoint
-- 执行脚本		DO_SCRIPT, szCmd
-- 更改战斗状态 CHANGE_FIGHT, nPlayerGroup, nFightState, nPkModel, [nCamp]	-- 房间内全体玩家
-- 目标信息 	TARGET_INFO, nPlayerGroup, szInfo							-- 在即时战报中显示信息(房间内全体成员)
-- 时间信息 	TIME_INFO, nPlayerGroup, szTimeInfo, nLock					-- 在即时战报中某个锁处的显示倒计时(改锁必须已经开始，否则执行无效)
-- 关闭即时消息 CLOSE_INFO, nPlayerGroup									-- 
-- 传送玩家		NEW_WORLD_PLAYER, nPlayerGroup, nX, nY						-- 
-- 改变NPC的AI	CHANGE_NPC_AI, szGroup, nAIType, ... 			-- 改变某群组NPC的AI
-- 电影模式		MOVIE_DIALOG, nPlayerGroup, szDialog
-- 黑条字模 	BLACK_MSG, nPlayerGroup, szDialog
-- 增加篝火		ADD_GOUHUO, nMinute, nBaseMultip, szGroup, szPointName		-- nMinute 时间（分钟）, nBaseMultip 经验倍数，第一个队伍有效
-- NPC发话		SEND_CHAT, szGroup, szChat
-- 给玩家加称号 ADD_TITLE， nPlayerGroup, nGenre, nDetail, nLevel, nParam

-- 锁结构
-- nTime, nNum, tbPrelock = {, ...}, tbEvent = {}
-- 

-- 等级1房间

-- 1,6 房间锁结构完全一致~先写模板再复制
tbRoom[1] = 
{
	fnPlayerGroup 	= nil,						-- 玩家分群函数,不填则默认1支队伍1个群体
	fnDeath			= nil,						-- 房间死亡脚本; 不填则默认
	fnWinRule		= nil,						-- 胜利条件，竞赛类的房间需要重定义，其他一般不需要填
	nRoomLevel		= 1,						-- 房间等级(1~5)
	nMapIndex		= 1,						-- 地图组的索引
	tbBeginPoint	= {41952 / 32, 80064 / 32},	-- 起始点，格式根据fnPlayerGroup需求而定，默认是{nX,nY}
	-- 房间涉及的NPC种类
	NPC = 
	{
-- 		编号  	npc模板				等级(-1默认)	5行(默认-1)
-- E.g  [0] = {nTemplate, 			nLevel, 		nSeries }
		[1] = {nTemplate = 3139, nLevel = -1, nSeries = -1},		-- 野狼1
		[2] = {nTemplate = 3140, nLevel = -1, nSeries = -1},		-- 野狼2
		[3] = {nTemplate = 3141, nLevel = -1, nSeries = -1},		-- 野狼3
		[4] = {nTemplate = 3218, nLevel = -1, nSeries =	-1},		-- Sói chúa
		
	},
	-- 锁结构
	LOCK = 
	{
		-- 1号锁不能不填，默认1号为起始锁
		[1] = {nTime = 15, nNum = 0,
			tbPrelock = {},
			tbStartEvent = 
			{
				{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này tựa hồ là một người bị vứt đi đích nông trại, chu vi đích trong rừng cũng tĩnh đích thần kỳ, chính cẩn thận hành động tuyệt vời..."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Chẳng tòng na toát ra nhiều như vậy mãnh thú! Tiên bắt bọn nó thanh lý điệu hơn nữa."},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Không nghĩ tới những ... này dã thú cánh như vậy hung hãn, xem ra chúng ta chỉ có thể hoán con đường còn muốn biện pháp đi tới liễu..."},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 32,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "1_yelang_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "1_yelang_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 28, 3, "guaiwu", "1_yelang_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 32 Sói Hoang"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "1_langwang"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước đỉnh núi truyền đến một tiếng huýt sáo dài, xem ra hữu canh hung mãnh đích dã thú đang chờ chúng ta liễu..."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Sói chúa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Thành công đích Đánh bại liễu những ... này hung mãnh đích dã thú, ngồi xuống khảo sưởi ấm, nghỉ ngơi một chút, đợi kế tiếp khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "1_gouhuo"},
	},
	},
	}
	}
	tbRoom[2] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 1,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 1,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {48032 / 32, 85024 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3142, nLevel = -1, nSeries = -1},		-- gấu chó 1
	[2] = {nTemplate = 3143, nLevel = -1, nSeries = -1},		-- gấu chó 2
	[3] = {nTemplate = 3144, nLevel = -1, nSeries = -1},		-- gấu chó 3
	[4] = {nTemplate = 3219, nLevel = -1, nSeries =	-1},		-- hùng vương
	[5] = {nTemplate = 3271, nLevel = 75, nSeries =	1},		-- nhâm hâm
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 0, "liehu", "2_renxin"},		-- xoát quái
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước có gian nông trại, quá khứ hoa vị kia đại thúc hỏi một chút lộ..."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3271>: \"Gần nhất núi này lý đích hùng người mù lão không an phận, đáng tiếc ta giá việc nhà nông mang đắc đi không ra, gặp các ngươi mấy người thân thủ hẳn là không sai, đi giúp ta thu thập hạ những ... này mãnh thú.\""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3271>: \"Không nghĩ tới các ngươi mấy người thực lực như thế chăng tể... Tưởng kế tục sấm cốc chỉ sợ là dữ nhiều lành ít. Ta xem các ngươi chính hoán điều an toàn điểm đích lộ.\""},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 28,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "2_heixiong_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "2_heixiong_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 24, 3, "guaiwu", "2_heixiong_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 28 Gấu Đen"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 4, 0, "guaiwu", "2_heixiong_4"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "2_xiongwang"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Cầu treo bên kia truyền đến trận trận tê rống, bang nhân đến giúp để, quá khứ Đánh bại thặng dư đích mãnh thú."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Gấu Chúa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3271>: \"Làm được không sai ma! Đừng nóng vội đừng nóng vội, ngồi xuống khảo sưởi ấm, nghỉ ngơi một hồi, tiền phương đích đường tự nhiên sẽ vì các ngươi mở ra.\""},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "2_gouhuo"},
	},
	},
	}
	}
	tbRoom[3] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 1,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 1,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {52832 / 32, 77408 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3147, nLevel = -1, nSeries = -1},		-- hoàng hổ
	[2] = {nTemplate = 3251, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[3] = {nTemplate = 3220, nLevel = -1, nSeries =	-1},		-- Hổ Vương
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Một mảnh kỳ quái đích khu vực, sườn núi hạ mơ hồ cảm giác được một cổ sát khí, chính cẩn thận tuyệt vời."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Sườn núi hạ đột nhiên xuất hiện liễu 4 tôn bạch hổ pho tượng, chu vi tụ tập liễu rất nhiều mãnh hổ, sự hữu kỳ hoặc, khứ điều tra một chút này pho tượng."},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "jiguan"},			-- thạch đôi
	{XoyoGame.MOVIE_DIALOG, -1, "Thám hiểm không thích hợp chúng ta, hoán con đường nhìn có cái gì ... không thể lực sống khả dĩ tố."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 4,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 24, 0, "guaiwu", "3_huanghu_3"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 4, 3, "jiguan", "3_shidui_jiguan"},			-- bộ phận then chốt
	{XoyoGame.TARGET_INFO, -1, "Điều tra 4 bức tượng được bảo vệ bởi Hổ Vàng"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 4, 0, "guaiwu", "3_huanghu_4"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 1, 4, "guaiwu", "3_huwang"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Điều tra liễu tất cả pho tượng bộ phận then chốt hậu, một tiếng điếc tai đích hổ gầm cho tới bây giờ thì đích sườn núi phương hướng truyền đến, quá khứ tham một đến tột cùng."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Hổ Chúa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Kinh qua một phen chiến đấu kịch liệt, là nên ngồi xuống khảo sưởi ấm, nghỉ ngơi một hồi, đợi một chút một khiêu chiến liễu."},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "3_gouhuo"},
	},
	},
	}
	}
	tbRoom[4] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 1,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 1,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {54400 / 32, 97600 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3148, nLevel = -1, nSeries = -1},		-- cá sấu 1
	[2] = {nTemplate = 3149, nLevel = -1, nSeries = -1},		-- cá sấu 2
	[3] = {nTemplate = 3150, nLevel = -1, nSeries = -1},		-- cá sấu 3
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này kháo thủy, phong cảnh ưu nhã, hẳn là khả dĩ điếu câu cá, nghỉ ngơi một chút lạp."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bất hảo! Trong nước dĩ nhiên hữu cá sấu, chúng ta bị vây quanh liễu. Nhanh lên mở một đường máu lao ra đi thôi."},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ là chê chúng ta da dày thịt béo, cá sấu đối chúng ta mất đi hứng thú, toàn bộ bò lại liễu trong nước. Xem ra chúng ta chỉ có thể hoán con đường còn muốn biện pháp đi tới liễu..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 40,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "4_eyu_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "4_eyu_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 36, 3, "guaiwu", "4_eyu_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 40 Cá Sấu"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Rốt cục Đánh bại liễu tất cả cá sấu, khả dĩ nghỉ ngơi một hồi khảo sưởi ấm liễu, tiêu dao trong cốc hung hiểm dị thường, chúng ta đắc chăm chú đối mặt tiếp theo hạng khiêu chiến a."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "4_gouhuo"},
	},
	},
	}
	}
	
	tbRoom[5] = {}
	CopyTable(tbRoom[2], tbRoom[5])
	tbRoom[5]. tbBeginPoint	= {56544 / 32, 90144 / 32};
	tbRoom[5]. NPC[1]. nTemplate = 3148;
	tbRoom[5]. NPC[2]. nTemplate = 3149;
	tbRoom[5]. NPC[3]. nTemplate = 3150;
	tbRoom[5]. NPC[4]. nTemplate = 3224;
	tbRoom[5]. NPC[5] = {nTemplate = 3272, nLevel = 75, nSeries =	2};
	tbRoom[5]. LOCK[1]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 5, 1, 0, "liehu", "5_rensen"};
	tbRoom[5]. LOCK[1]. tbStartEvent[2] = {XoyoGame.MOVIE_DIALOG, -1, "Phía trước có gian nông trại, quá khứ hoa vị kia đại thúc hỏi một chút lộ..."};
	tbRoom[5]. LOCK[2]. tbStartEvent[1]	=	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3272>: \"Gần nhất cũng không biết đâu tới nhiều như vậy cá sấu, làm hại ta cũng không dám đi ra ngoài bắt cá liễu, các ngươi mấy người tới vừa lúc! Đi giúp ta thu thập hạ những ... này mãnh thú.\""};
	tbRoom[5]. LOCK[2]. tbUnLockEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "<npc=3272>: \"Không nghĩ tới các ngươi mấy người thực lực như thế chăng tể... Tưởng kế tục sấm cốc chỉ sợ là dữ nhiều lành ít. Ta xem các ngươi chính hoán điều an toàn điểm đích lộ.\""};
	tbRoom[5]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "5_eyu_1"};		-- xoát quái
	tbRoom[5]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "5_eyu_2"};		-- xoát quái
	tbRoom[5]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 28, 3, "guaiwu", "5_eyu_3"};		-- xoát quái
	tbRoom[5]. LOCK[3]. tbStartEvent[4] = {XoyoGame.TARGET_INFO, -1, "Tiêu diệt 32 Cá Sấu"};
	tbRoom[5]. LOCK[3]. nNum = 32
	tbRoom[5]. LOCK[4]. tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "5_shuangtougui"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Thuyền đánh cá phụ cận truyền đến một trận động tĩnh, hình như là hữu vật gì vậy thượng liễu ngạn, quá khứ nhìn."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Dị Thú"},
	}
	tbRoom[5]. LOCK[4]. tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3272>: \"Làm được không sai ma! Đừng nóng vội đừng nóng vội, ngồi xuống khảo sưởi ấm, nghỉ ngơi một hồi, tiền phương đích đường tự nhiên sẽ vì các ngươi mở ra.\""},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "5_gouhuo"},
	}
	tbRoom[6] = {}
	CopyTable(tbRoom[1], tbRoom[6])
	tbRoom[6]. tbBeginPoint	= {53280 / 32, 89920 / 32};
	tbRoom[6]. NPC[1]. nTemplate = 3148;
	tbRoom[6]. NPC[2]. nTemplate = 3149;
	tbRoom[6]. NPC[3]. nTemplate = 3150;
	tbRoom[6]. NPC[4]. nTemplate = 3221;
	tbRoom[6]. LOCK[1]. tbStartEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Nơi này dòng nước chảy ròng ròng, đồng cỏ và nguồn nước um tùm, nhưng giá trong nước tựa hồ có chút dị động, đắc cẩn thận một chút."};
	tbRoom[6]. LOCK[2]. tbStartEvent[1]	=	{XoyoGame.MOVIE_DIALOG, -1, "Quả nhiên! Hơn mười điều cá sấu đột nhiên tòng trong nước xông ra, trước hết giết quang chúng nó tái tìm kiếm sấm cốc đích đường."};
	tbRoom[6]. LOCK[2]. tbUnLockEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ là chê chúng ta da dày thịt béo, cá sấu đối chúng ta mất đi hứng thú, toàn bộ bò lại liễu trong nước. Ai... Mới vừa vào cốc tựu ngộ thử mãnh thú, thật không biết phía trước còn có cái gì hung hiểm chờ chúng ta."};
	tbRoom[6]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "6_eyu_1"};		-- xoát quái
	tbRoom[6]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "6_eyu_2"};		-- xoát quái
	tbRoom[6]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 24, 3, "guaiwu", "6_eyu_3"};		-- xoát quái
	tbRoom[6]. LOCK[3]. tbStartEvent[4] = {XoyoGame.TARGET_INFO, -1, "Tiêu diệt 28 Cá Sấu"};
	tbRoom[6]. LOCK[3]. nNum = 28
	tbRoom[6]. LOCK[4]. tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 0, "guaiwu", "6_eyu_4"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "6_eyuwang"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Cương sát hoàn một nhóm, lại có kỷ chích càng hung mãnh đích cá sấu bò lên trên liễu lai. Thực sự là không dứt, không có biện pháp, sát!"},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Cá Sấu Lớn"},
	}
	tbRoom[6]. LOCK[4]. tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tiêu diệt Cá Sấu Lớn, khu vực này đã an toàn."},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "6_gouhuo"},
	}
	-- Hộ tống tiểu lộ
	tbRoom[7] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 1,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 1,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50560 / 32, 85952 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3141, nLevel = -1, nSeries = -1},		-- lang
	[2] = {nTemplate = 3273, nLevel = 25, nSeries = 3},		-- nhâm miểu
	[3] = {nTemplate = 3262, nLevel = -1, nSeries =	-1},		-- tiểu lộ Hộ tống
	[4] = {nTemplate = 3286, nLevel = 25, nSeries = 3},		-- nhâm miểu chiến đấu
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehu", "7_renmiao"},
	{XoyoGame.ADD_NPC, 3, 1, 5, "husong", "7_xiaolu"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3273>: \"Các vị đại hiệp, bang một mang khỏe? Gần nhất trong cốc dã lang tàn sát bừa bãi, ta nương tử đi ra ngoài đã lâu liễu, ta rất lo lắng tha, thế nhưng lại muốn chiếu cố trong nhà đích hài tử mà bất năng thoát thân, nếu như các vị có thể bả ta nương tử mang về lai, ta sẽ phi thường cảm kích các ngươi đích. Được rồi, các ngươi theo con đường này đi xuống dưới hẳn là là có thể tìm được tha liễu.\""},
	{XoyoGame.TARGET_INFO, -1, "Tìm và hộ tống Tiểu Lộ về nhà"},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.DEL_NPC, "liehu"},
	{XoyoGame.DEL_NPC, "liehu_zhandou"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3273>: \"Phi thường xin lỗi, ta vừa thái xung động liễu. Các ngươi nhanh lên đi thôi, ta cần lãnh tĩnh một chút... Tiền phương đích đường đợi sẽ mở ra, các ngươi tự giải quyết cho tốt.\" \n nói xong, hắn liền về tới phòng trong, chúng ta mơ hồ còn có thể nghe được bên trong truyền đến đích trẻ con đích khóc nỉ non thanh..."},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tiền phương có vị nữ tử bị bầy sói vây khốn, tha hẳn là hay chúng ta người muốn tìm liễu."},
	{XoyoGame.ADD_NPC, 1, 32, 0, "guaiwu", "7_yelang_3"},		-- xoát quái
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv1_7_xiaolu", 4, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3273>: \"Các vị đại hiệp đích đại ân đại đức chúng ta kiếp này nan báo. Lai lai lai, hát khẩu rượu, khảo sưởi ấm, đợi tiền phương đích đường sẽ mở ra liễu.\""},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "7_gouhuo"},
	}
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "liehu"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.ADD_NPC, 4, 1, 6, "liehu_zhandou", "7_renmiao"},		-- xoát quái
	{XoyoGame.MOVIE_DIALOG, -1, "Mắt thấy trứ nương tử tại chính trong tầm mắt rồi ngã xuống, vị kia hộ săn bắn tựa hồ nổi cơn điên, chúng ta có đúng hay không hẳn là khứ trấn an một chút hắn ni?"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Nhậm Diễu"},
	},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3273>: \"Các vị, phi thường xin lỗi. Nhìn chính nương tử chết ở trước mặt, ta vô pháp khống chế chính đích tình tự liễu. Hiện tại tỉnh táo lại ngẫm lại, cũng không có thể trách cứ các ngươi. Các vị nghỉ ngơi hạ, khảo sưởi ấm ba, tiền phương đích đường đợi sẽ mở ra.\""},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "7_gouhuo"},
	},
	},
	}
	}
	tbRoom[8] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 1,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 1,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {44736 / 32, 87968 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3147, nLevel = -1, nSeries = -1},		-- hoàng hổ
	[2] = {nTemplate = 3223, nLevel = -1, nSeries = -1},		-- mã vương
	[3] = {nTemplate = 3274, nLevel = -1, nSeries =	4},		-- Hộ tống NPC
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 2, "husong", "8_renyan"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tiền phương hữu một vị thân hình bưu hãn đích hộ săn bắn, quá khứ hoa hắn hỏi một chút lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3274>: \"Xong xong! Ngày hôm nay hựu đắc ai lão đại phê liễu! Các ngươi động như thế không còn dùng được ni?\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3274>: \"Các ngươi tới vừa lúc, yêm đang lo tìm không được nhân giúp đỡ ni. Núi này đính hữu một không người năng phục tùng đích mã vương, yêm môn siêu ca phân phó yêm ngày hôm nay nội đem mang về, bất quá giá dọc theo đường đi mãnh hổ đáng nói, yêm một người cảo bất định oa...\""},
	{XoyoGame.ADD_NPC, 1, 28, 0, "guaiwu", "8_huanghu_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Nhậm Diệm lên đỉnh đồi"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv1_8_renyan", 4, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 5, "guaiwu", "8_mawang"},		-- xoát quái
	{XoyoGame.MOVIE_DIALOG, -1, "Rốt cục đi tới đỉnh núi, tiền phương quả nhiên xuất hiện liễu một bưu hãn đích ngựa hoang, bang trợ Nhậm Diệm đưa hắn Thích sát."},
	{XoyoGame.TARGET_INFO, -1, "Thích sát Ngựa Chúa"},
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3274>: \"Cảm tạ cáp, yêm về trước đi báo cáo kết quả công tác liễu, ca mấy người trước tiên ở giá khảo sưởi ấm, đợi tiền phương đích đường tự nhiên hội mở ra đích.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "8_gouhuo"},
	},
	},
	}
	}
	tbRoom[9] = {}
	CopyTable(tbRoom[4], tbRoom[9]);
	tbRoom[9]. tbBeginPoint	= {47872 / 32, 98816 / 32};
	tbRoom[9]. NPC[1]. nTemplate = 3145;
	tbRoom[9]. NPC[2]. nTemplate = 3146;
	tbRoom[9]. NPC[3]. nTemplate = 3147;
	tbRoom[9]. LOCK[1]. tbStartEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Nhìn giá phiến trống trải đích khu vực, tâm tình cũng theo thư sướng đứng lên. Bất quá, trong rừng cây tựa hồ truyền đến liễu mãnh thú đích khí tức... Chính cẩn thận tuyệt vời."};
	tbRoom[9]. LOCK[2]. tbStartEvent[1]	=	{XoyoGame.MOVIE_DIALOG, -1, "Quả nhiên! Hơn mười đầu mãnh hổ tòng trong rừng nhảy lên ra, trước hết giết quang chúng nó tái tìm kiếm sấm cốc đích đường."};
	tbRoom[9]. LOCK[2]. tbUnLockEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ là chê chúng ta da dày thịt béo, con cọp môn đối chúng ta mất đi hứng thú, toàn bộ tiêu thất tại trong rừng rậm. Ai... Mới vừa vào cốc tựu ngộ thử mãnh thú, thật không biết phía trước còn có cái gì hung hiểm chờ chúng ta."};
	tbRoom[9]. LOCK[2]. tbUnLockEvent[2] = {XoyoGame.DEL_NPC, "guaiwu"};
	tbRoom[9]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "9_huanghu_1"};		-- xoát quái
	tbRoom[9]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "9_huanghu_2"};		-- xoát quái
	tbRoom[9]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 36, 3, "guaiwu", "9_huanghu_3"};		-- xoát quái
	tbRoom[9]. LOCK[3]. tbStartEvent[4] = {XoyoGame.TARGET_INFO, -1, "Tiêu diệt 40 Hổ Vàng"};
	tbRoom[9]. LOCK[3]. tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tảo thanh liễu trong rừng đích mãnh hổ, khu vực này hẳn là an toàn liễu. Nghỉ ngơi hạ, khảo sưởi ấm, đợi kế tiếp đích khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "9_gouhuo"},
	}
	tbRoom[10] = {}
	CopyTable(tbRoom[4], tbRoom[10]);
	tbRoom[10]. tbBeginPoint	= {45984 / 32, 95616 / 32};
	tbRoom[10]. NPC[1]. nTemplate = 3142;
	tbRoom[10]. NPC[2]. nTemplate = 3143;
	tbRoom[10]. NPC[3]. nTemplate = 3144;
	tbRoom[10]. LOCK[1]. tbStartEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Nhìn giá phiến trống trải đích khu vực, tâm tình cũng theo thư sướng đứng lên. Bất quá, trong rừng cây tựa hồ truyền đến liễu mãnh thú đích khí tức... Chính cẩn thận tuyệt vời."};
	tbRoom[10]. LOCK[2]. tbStartEvent[1]	=	{XoyoGame.MOVIE_DIALOG, -1, "Quả nhiên! Hơn mười Gấu Đen tòng trong rừng nhảy lên ra, trước hết giết quang chúng nó tái tìm kiếm sấm cốc đích đường."};
	tbRoom[10]. LOCK[2]. tbUnLockEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ là chê chúng ta da dày thịt béo, hùng người mù cũng đúng chúng ta mất đi hứng thú, toàn bộ tiêu thất tại trong rừng rậm. Ai... Mới vừa vào cốc tựu ngộ thử mãnh thú, thật không biết phía trước còn có cái gì hung hiểm chờ chúng ta."};
	tbRoom[10]. LOCK[2]. tbUnLockEvent[2] = {XoyoGame.DEL_NPC, "guaiwu"};
	tbRoom[10]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "10_heixiong_1"};		-- xoát quái
	tbRoom[10]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "10_heixiong_2"};		-- xoát quái
	tbRoom[10]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 36, 3, "guaiwu", "10_heixiong_3"};		-- xoát quái
	tbRoom[10]. LOCK[3]. tbStartEvent[4] = {XoyoGame.TARGET_INFO, -1, "Tiêu diệt 40 Gấu Đen"};
	tbRoom[10]. LOCK[3]. tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tảo thanh liễu trong rừng đích gấu chó, khu vực này hẳn là an toàn liễu. Nghỉ ngơi hạ, khảo sưởi ấm, đợi kế tiếp đích khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "10_gouhuo"},
	}
	tbRoom[11] = {}
	CopyTable(tbRoom[4], tbRoom[11]);
	tbRoom[11]. tbBeginPoint	= {50848 / 32, 96320 / 32};
	tbRoom[11]. NPC[1]. nTemplate = 3139;
	tbRoom[11]. NPC[2]. nTemplate = 3140;
	tbRoom[11]. NPC[3]. nTemplate = 3141;
	tbRoom[11]. LOCK[1]. tbStartEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Nhìn giá phiến trống trải đích khu vực, tâm tình cũng theo thư sướng đứng lên. Bất quá, trong rừng cây tựa hồ truyền đến liễu mãnh thú đích khí tức... Chính cẩn thận tuyệt vời."};
	tbRoom[11]. LOCK[2]. tbStartEvent[1]	=	{XoyoGame.MOVIE_DIALOG, -1, "Quả nhiên! Hơn mười Sói Hoang tòng trong rừng nhảy lên ra, trước hết giết quang chúng nó tái tìm kiếm sấm cốc đích đường."};
	tbRoom[11]. LOCK[2]. tbUnLockEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ là chê chúng ta da dày thịt béo, bầy sói cũng đúng chúng ta mất đi hứng thú, toàn bộ tiêu thất tại trong rừng rậm. Ai... Mới vừa vào cốc tựu ngộ thử mãnh thú, thật không biết phía trước còn có cái gì hung hiểm chờ chúng ta."};
	tbRoom[11]. LOCK[2]. tbUnLockEvent[2] = {XoyoGame.DEL_NPC, "guaiwu"};
	tbRoom[11]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "11_yelang_1"};		-- xoát quái
	tbRoom[11]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "11_yelang_2"};		-- xoát quái
	tbRoom[11]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 36, 3, "guaiwu", "11_yelang_3"};		-- xoát quái
	tbRoom[11]. LOCK[3]. tbStartEvent[4] = {XoyoGame.TARGET_INFO, -1, "Tiêu diệt 40 Sói Hoang"};
	tbRoom[11]. LOCK[3]. tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tảo thanh liễu trong rừng đích dã lang, khu vực này hẳn là an toàn liễu. Nghỉ ngơi hạ, khảo sưởi ấm, đợi kế tiếp đích khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "11_gouhuo"},
	}
	tbRoom[12] = {}
	CopyTable(tbRoom[4], tbRoom[12]);
	tbRoom[12]. tbBeginPoint	= {51200 / 32, 102112 / 32};
	tbRoom[12]. NPC[1]. nTemplate = 3142;
	tbRoom[12]. NPC[2]. nTemplate = 3143;
	tbRoom[12]. NPC[3]. nTemplate = 3144;
	tbRoom[12]. NPC[4] = {nTemplate = 3275, nLevel = -1, nSeries = 5};
	tbRoom[12]. LOCK[1]. tbStartEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Giá phiến trống trải đích khu vực trung, chỉ có một vị thần tình ngưng trọng đích hộ săn bắn, tựa hồ tương có chuyện gì phát sinh."};
	tbRoom[12]. LOCK[1]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 4, 1, 0, "liehu", "12_renyao"};		-- hộ săn bắn
	tbRoom[12]. LOCK[2]. tbStartEvent[1]	=	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3275>: \"Các vị, chúng ta bị hùng người mù vây quanh liễu. Ta cân chúng nó đấu liễu mấy người canh giờ liễu, chẳng các vị khả phủ giúp ta Tiêu diệt bọn họ ni? Cẩn thận! Lại nữa rồi!\""};
	tbRoom[12]. LOCK[2]. tbUnLockEvent[1] = {XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ là chê chúng ta da dày thịt béo, hùng người mù cũng đúng chúng ta mất đi hứng thú, toàn bộ tiêu thất tại trong rừng rậm. Ai... Mới vừa vào cốc tựu ngộ thử mãnh thú, thật không biết phía trước còn có cái gì hung hiểm chờ chúng ta."};
	tbRoom[12]. LOCK[2]. tbUnLockEvent[2] = {XoyoGame.DEL_NPC, "guaiwu"};
	tbRoom[12]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "12_heixiong_1"};		-- xoát quái
	tbRoom[12]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "12_heixiong_2"};		-- xoát quái
	tbRoom[12]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 36, 3, "guaiwu", "12_heixiong_3"};		-- xoát quái
	tbRoom[12]. LOCK[3]. tbStartEvent[4] = {XoyoGame.TARGET_INFO, -1, "Tiêu diệt 40 Gấu Đen"};
	tbRoom[12]. LOCK[3]. tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tảo thanh liễu trong rừng đích gấu chó, khu vực này hẳn là an toàn liễu. Nghỉ ngơi hạ, khảo sưởi ấm, đợi kế tiếp đích khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "12_gouhuo"},
	}
	-- đẳng cấp 2 gian phòng
	tbRoom[13] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {54528 / 32, 97600 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3151, nLevel = -1, nSeries = -1},		-- hoa báo 1
	[2] = {nTemplate = 3152, nLevel = -1, nSeries = -1},		-- hoa báo 2
	[3] = {nTemplate = 3153, nLevel = -1, nSeries = -1},		-- hoa báo 3
	[4] = {nTemplate = 3221, nLevel = -1, nSeries = -1},		-- cự ngạc
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Chòi nghỉ mát, thác nước, trong cốc phong cảnh quả nhiên rất khác biệt... Nhưng tổng nghĩ giá trong nước có chút dị dạng, chính cẩn thận hành động tuyệt vời..."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong rừng đột nhiên nhảy lên ra một đám hoa báo, xem ra hựu tránh không được một hồi ác chiến liễu..."},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Không nghĩ tới những ... này dã thú cánh như vậy hung hãn, xem ra chúng ta chỉ có thể hoán con đường còn muốn biện pháp đi tới liễu..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 32,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "13_huabao_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "13_huabao_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 28, 3, "guaiwu", "13_huabao_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 32 Báo Đốm"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 2,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 2, 4, "guaiwu", "13_jue"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Phía sau đích hồ sâu lý toát ra trận trận bọt khí, tựa hồ hữu vật gì vậy bò lên trên liễu ngạn... Quá khứ nhìn hơn nữa."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt thủy đàm biên đích mãnh thú"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Ác chiến lúc, chính tiên ngồi xuống khảo sưởi ấm, nghỉ ngơi một chút, đợi kế tiếp khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "13_gouhuo"},
	},
	},
	}
	}
	-- Hộ tống Vương Lão Hán
	tbRoom[14] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {59488 / 32, 96224 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3157, nLevel = -1, nSeries = -1},		-- bộ phận then chốt phủ thủ 1
	[2] = {nTemplate = 3159, nLevel = -1, nSeries = -1},		-- bộ phận then chốt phủ thủ 2
	[3] = {nTemplate = 3161, nLevel = -1, nSeries = -1},		-- bộ phận then chốt thú 1
	[4] = {nTemplate = 3162, nLevel = -1, nSeries = -1},		-- bộ phận then chốt thú 2
	[5] = {nTemplate = 3263, nLevel = -1, nSeries =	-1},		-- Hộ tống NPCVương Lão Hán
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 2, "husong", "14_wanglaohan"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tiêu dao khe hình rắc rối phức tạp, cũng không biết hiện tại rốt cuộc thân ở nơi nào, chính hoa giá trong cốc cư dân hỏi một chút lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3263>: \"Ôi... Ta đích thắt lưng a! Các ngươi chính tống ta về nhà dưỡng thương. Dĩ các ngươi loại thật lực này cũng đừng vãng cốc ở chỗ sâu trong đi, thái nguy hiểm liễu!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3263>: \"Ai! Trong cốc na cuồng nhân chỉnh đích những ... này bộ phận then chốt ngoạn ý hựu đi ra quấy rối liễu, nghĩ ra khứ thải điểm dược cũng không sống yên ổn. Các ngươi mấy người nhìn qua đĩnh cường đích, tựu bang lão hán một bả.\""},
	{XoyoGame.ADD_NPC, 1, 2, 0, "guaiwu", "14_jiguanfushou_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 16, 0, "guaiwu", "14_jiguanfushou_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 16, 0, "guaiwu", "14_xiaoxingjiguanshou_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 2, 0, "guaiwu", "14_xiaoxingjiguanshou_1"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Vương Lão Hán"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_14_wanglaohan", 4, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3263>: \"Các ngươi quả nhiên rất mạnh, nếu như có cơ hội đụng với chế tạo những ... này bộ phận then chốt thú đích chủ, nhất định phải giúp ta hảo hảo giáo huấn một chút hắn! Lão hán ta đi trước, các ngươi khảo sưởi ấm, một hồi tiền phương đích đường tự nhiên hội mở ra đích.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "14_gouhuo"},
	},
	},
	}
	}
	tbRoom[15] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {63456 / 32, 99104 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3151, nLevel = -1, nSeries = -1},		-- hoa báo 1
	[2] = {nTemplate = 3152, nLevel = -1, nSeries = -1},		-- hoa báo 2
	[3] = {nTemplate = 3153, nLevel = -1, nSeries = -1},		-- hoa báo 3
	[4] = {nTemplate = 3224, nLevel = -1, nSeries = -1},		-- dị thú
	[5] = {nTemplate = 3274, nLevel = -1, nSeries =	4},		-- Nhậm Diệm
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 2, "husong", "15_renyan"},
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước đích đình na hữu một vị hộ săn bắn trang phục đích đại thúc, nhìn qua lo lắng lo lắng, quá khứ hỏi một chút tình huống."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3274>: \"Không nghĩ tới các ngươi như thế không còn dùng được... Yêm tiên triệt liễu... Lộ tại phương nào? Các ngươi chính chậm rãi tìm đi.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3274>: \"Gần nhất cốc lý cư dân oán giận thuyết giá trong hồ hữu thủy quái đả thương người, yêm lão đại siêu ca phái yêm nhiều điều tra, không muốn đụng với báo đàn... Ca mấy người, bang một thủ.\""},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 32,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_15_renyan", 0, 100, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 1, 2, 4, "guaiwu", "15_huabao_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "15_huabao_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 28, 4, "guaiwu", "15_huabao_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Nhậm Diệm tiêu diệt 32 Báo Đốm"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong hồ toát ra trận trận bọt khí, tựa hồ hữu vật gì vậy bò lên trên liễu ngạn..."},
	{XoyoGame.ADD_NPC, 4, 1, 5, "guaiwu", "15_shuiguai"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Nhậm Diệm tiêu diệt Dị Thú"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3274>: \"Ca mấy người, cảm tạ cáp! Bất quá các ngươi kế tục vãng thâm nhập cốc lý khả năng hội ngộ thượng yêm lão đại, hắn tính tình không tốt lắm, các ngươi hay nhất cẩn thận một chút. Đợi tiền phương đích đường sẽ mở ra, các ngươi tiên khảo sưởi ấm. Yêm đi trước liễu cáp.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "15_gouhuo"},
	},
	},
	}
	}
	tbRoom[16] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50976 / 32, 109408 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3139, nLevel = -1, nSeries = -1},		-- lang
	[2] = {nTemplate = 3140, nLevel = -1, nSeries = -1},		-- lang
	[3] = {nTemplate = 3141, nLevel = -1, nSeries = -1},		-- lang
	[4] = {nTemplate = 3218, nLevel = -1, nSeries = -1},		-- Sói chúa
	[5] = {nTemplate = 3275, nLevel = -1, nSeries = 5};			-- Nhậm Nghiêu
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 2, "husong", "16_renyao"},
	{XoyoGame.MOVIE_DIALOG, -1, "Chu vi vân vụ lượn lờ, hình như tới rồi đỉnh núi, đình na hữu một vị hộ săn bắn trang phục đích đại thúc, quá khứ hỏi một chút lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3275>: \"Oa tắc! Giá đàn súc sinh rất hung mãnh! Ta tiên triệt liễu... Lộ tại phương nào? Các ngươi chính chậm rãi tìm đi.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3275>: \"Gần nhất bầy sói tàn sát bừa bãi, làm hại mọi người cũng không dám lên núi lai xem xét phong cảnh, ta phụng lão đại chi mệnh tới thu thập giá đàn mãnh thú, bất quá hình như số lượng có chút đa, các ngươi... Không ngại giúp ta một mang.\""},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 28,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_16_renyao", 0, 100, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 1, 2, 4, "guaiwu", "16_yelang_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "16_yelang_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 24, 4, "guaiwu", "16_yelang_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Nhậm Nghiêu tiêu diệt 28 Sói Hoang"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong rừng truyền đến một tiếng huýt sáo dài, xem ra thị bầy sói đích thủ lĩnh xuất hiện liễu..."},
	{XoyoGame.ADD_NPC, 3, 8, 0, "guaiwu", "16_langwanghuwei"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 1, 5, "guaiwu", "16_langwang"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Nhậm Nghiêu tiêu diệt Sói chúa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3275>: \"Hô! Rốt cục thanh tĩnh liễu. Đợi tiền phương đích đường sẽ mở ra, các ngươi tiên khảo sưởi ấm. Tại hạ tiên cáo từ liễu.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "16_gouhuo"},
	},
	},
	}
	}
	tbRoom[17] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {54432 / 32, 108160 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3139, nLevel = -1, nSeries = -1},		-- lang 1
	[2] = {nTemplate = 3140, nLevel = -1, nSeries = -1},		-- lang 2
	[3] = {nTemplate = 3141, nLevel = -1, nSeries = -1},		-- lang 3
	[4] = {nTemplate = 3218, nLevel = -1, nSeries = -1},		-- Sói chúa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Chu vi vân vụ lượn lờ, hình như tới rồi đỉnh núi, nhưng tiền phương năng nghe được trận trận sói tru, chính cẩn thận hành động tuyệt vời."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Quả nhiên, tòng bốn phía trong rừng thoát ra một đám dã lang, để tránh cho trở thành bọn họ đích mỹ thực, chỉ có liều mạng!"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Không nghĩ tới những ... này dã thú cánh như vậy hung hãn, xem ra chúng ta chỉ có thể hoán con đường còn muốn biện pháp đi tới liễu..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 28,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "17_yelang_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "17_yelang_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 24, 3, "guaiwu", "17_yelang_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 28 Sói Hoang"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 8, 0, "guaiwu", "17_langwanghuwei"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "17_langwang"},		-- vương
	{XoyoGame.MOVIE_DIALOG, -1, "Trong rừng truyền đến một tiếng huýt sáo dài, xem ra thị bầy sói đích thủ lĩnh xuất hiện liễu..."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Sói chúa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Ác chiến lúc, chính tiên ngồi xuống khảo sưởi ấm, nghỉ ngơi một chút, đợi kế tiếp khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "17_gouhuo"},
	},
	},
	}
	}
	tbRoom[18] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {61920 / 32, 111168 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3154, nLevel = -1, nSeries = -1},		-- hầu tử 1
	[2] = {nTemplate = 3155, nLevel = -1, nSeries = -1},		-- hầu tử 2
	[3] = {nTemplate = 3156, nLevel = -1, nSeries = -1},		-- hầu tử 3
	[4] = {nTemplate = 3284, nLevel = -1, nSeries = 1},		-- nhâm hâm
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 2, "husong", "18_renxin"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tiểu kiều, nước chảy, hoa đào, thực sự là đẹp không sao tả xiết! Bất quá chúng ta là tới sấm cốc đích, chính tiên hoa phía trước vị kia đại thúc để hỏi lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3284>: \"Ai nha! Chết tiệt hầu tử bả ta đích quần áo mới lộng phá, trở lại định tao nương tử đòn hiểm, giá khả như thế nào cho phải, như thế nào cho phải a! Ta... Tiên thiểm liễu, các ngươi chính nghĩ biện pháp hoa lộ.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3284>: \"Mấy thiếu hiệp, có đúng hay không nghĩ giá hoa đào rất đẹp a, bất quá gần đây trên núi đích dã hầu nhưng thường xuyên lai quấy rối, các ngươi có muốn hay không tùy ta cùng nhau giáo huấn một chút những ... này bát hầu?\""},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 16,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_18_renxin", 0, 100, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 3, 8, 4, "guaiwu", "18_yehou_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 8, 4, "guaiwu", "18_yehou_2"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Nhậm Hâm dạy lũ Khỉ Hoang 1 bài học"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 16,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3284>: \"Ai nha! Ăn đã đến giờ liễu, trễ chạy trở về thế nhưng cũng bị nương tử có, còn lại đích nhiệm vụ tựu giao cho các ngươi, ta thiểm tiên.\""},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.ADD_NPC, 1, 2, 5, "guaiwu", "18_yehou_3"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 14, 5, "guaiwu", "18_yehou_4"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Khỉ Hoang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thu thập liễu quấy rối đích hầu tử, rốt cục khả dĩ nghỉ ngơi hạ, tiên khảo sưởi ấm, đợi tiếp theo tràng khiêu chiến."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "18_gouhuo"},
	},
	},
	}
	}
	tbRoom[19] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {48640 / 32, 118272 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3157, nLevel = -1, nSeries = -1},		-- bộ phận then chốt nhân 1
	[2] = {nTemplate = 3160, nLevel = -1, nSeries = -1},		-- bộ phận then chốt nhân 2
	[3] = {nTemplate = 3159, nLevel = -1, nSeries = -1},		-- bộ phận then chốt nhân 3
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Thử Địa Âm khí rất nặng, không biết đợi sẽ có cái quỷ gì đông tây toát ra lai, chính cẩn thận hành động tuyệt vời."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Quả nhiên, bốn phía toát ra lai rất nhiều bộ phận then chốt phủ thủ, xem ra muốn kế tục sấm cốc, chỉ có đánh một trận liễu!"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Thoáng qua trong lúc đó tất cả bộ phận then chốt mọi người tiêu thất không gặp, chỉ còn lại có chật vật bất kham đích chúng ta. Tiêu dao cốc quả nhiên bỉ tưởng tượng đích yếu gian nguy rất nhiều..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 36,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "19_liezhijiguanren_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "19_liezhijiguanren_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 32, 3, "guaiwu", "19_liezhijiguanren_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 36 Cơ Quan Thủ Phủ"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Thực sự là một hồi ác chiến a! Nếu như có cơ hội đụng với chế tạo những ... này bộ phận then chốt nhân đích chủ, nhất định phải hảo hảo giáo huấn một chút hắn! Tạm thời chính tiên sưởi ấm nghỉ ngơi hạ, đợi kế tiếp khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "19_gouhuo"},
	},
	},
	}
	}
	tbRoom[20] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {52000 / 32, 118144 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3157, nLevel = -1, nSeries = -1},		-- bộ phận then chốt nhân 1
	[2] = {nTemplate = 3160, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt nhân 2
	[3] = {nTemplate = 3159, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt nhân 3
	[4] = {nTemplate = 3252, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[5] = {nTemplate = 3253, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[6] = {nTemplate = 3254, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[7] = {nTemplate = 3255, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[8] = {nTemplate = 3256, nLevel = -1, nSeries =	-1},		-- chướng ngại vật trên đường NPC
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ xông vào liễu một chỗ hạ mật đạo, con đường phía trước cũng bị trở trụ, xem ra yếu tiên tìm được mở những ... này lưới sắt lan đích bộ phận then chốt tài năng ly khai ở đây."},
	{XoyoGame.ADD_NPC, 8, 3, 0, "zhangai1", "20_luzhang_1"},		-- cản trở
	{XoyoGame.ADD_NPC, 8, 3, 0, "zhangai2", "20_luzhang_2"},		-- cản trở
	{XoyoGame.CHANGE_TRAP, "20_trap_1", {52192 / 32, 117664 / 32}},
	{XoyoGame.CHANGE_TRAP, "20_trap_2", {52896 / 32, 115008 / 32}},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Thoáng qua trong lúc đó tất cả bộ phận then chốt mọi người tiêu thất không gặp, chỉ còn lại có mê thất tại mật đạo lý đích chúng ta... Tiêu dao cốc quả nhiên bỉ tưởng tượng đích yếu gian nguy rất nhiều."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 2,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 0, "guaiwu", "20_liezhijiguanren_1"},		-- quái vật
	{XoyoGame.ADD_NPC, 2, 2, 0, "guaiwu", "20_liezhijiguanren_2"},		-- quái vật
	{XoyoGame.ADD_NPC, 3, 28, 0, "guaiwu", "20_liezhijiguanren_3"},		-- quái vật
	{XoyoGame.ADD_NPC, 4, 1, 3, "jiguan", "20_jiguan_1"},		-- bộ phận then chốt 1
	{XoyoGame.ADD_NPC, 5, 1, 3, "jiguan", "20_jiguan_2"},		-- bộ phận then chốt 1
	{XoyoGame.ADD_NPC, 6, 1, 4, "jiguan", "20_jiguan_3"},		-- bộ phận then chốt 2
	{XoyoGame.ADD_NPC, 7, 1, 5, "jiguan", "20_jiguan_4"},		-- bộ phận then chốt 3
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Mở khóa tất cả các cơ quan bí mật, tìm đường thoát"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "zhangai1"},
	{XoyoGame.CHANGE_TRAP, "20_trap_1", nil},
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "zhangai2"},
	{XoyoGame.CHANGE_TRAP, "20_trap_2", nil},
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Rốt cục tìm được rồi mật đạo đích xuất khẩu! Tiên dừng lại sưởi ấm sưởi ấm, đợi kế tiếp khiêu chiến."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "20_gouhuo"},
	},
	},
	}
	}
	-- Hộ tống Vương Lão Hán
	tbRoom[21] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {56512 / 32, 123264 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3157, nLevel = -1, nSeries = -1},		-- bộ phận then chốt phủ thủ 1
	[2] = {nTemplate = 3161, nLevel = -1, nSeries = -1},		-- bộ phận then chốt thú 1
	[3] = {nTemplate = 3263, nLevel = -1, nSeries =	-1},		-- Hộ tống NPCVương Lão Hán
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 2, "husong", "21_wanglaohan"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ xông vào liễu một chỗ hạ mật đạo, cũng không biết lối ra ở đâu. Phía trước có một lão bá, quá khứ hỏi một chút hắn."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3263>: \"Ôi... Ta đích thắt lưng a! Các ngươi chính tống ta về nhà dưỡng thương. Dĩ các ngươi loại thật lực này cũng đừng vãng cốc ở chỗ sâu trong đi, thái nguy hiểm liễu!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3263>: \"Biết không? Giá tiêu dao cốc lý sản đích tiên linh quả thế nhưng chế thuốc đích cực phẩm nga, cốc lý có vị gia bình thường đắt tìm ta thu ni. Giá bất, ngày hôm nay hựu hái điểm, đang muốn về nhà, rồi lại gặp gỡ những ... này bộ phận then chốt nhân. Nếu không các ngươi bang lão hán ta khai con đường, ta cho các ngươi chỉ rõ sấm cốc đích đường, làm sao?\""},
	{XoyoGame.ADD_NPC, 1, 18, 0, "guaiwu", "21_jiguanfushou_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 12, 0, "guaiwu", "21_xiaoxingjiguanshou_1"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Vương Lão Hán"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_21_wanglaohan_1", 4, 20, 1},	-- Hộ tống AI
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 6,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Vương Lão Hán: \"Ôi ta đích mẹ ơi! Động còn có mai phục ni! Ngô mệnh hưu hĩ!\""},
	{XoyoGame.ADD_NPC, 2, 6, 5, "guaiwu", "21_xiaoxingjiguanshou_2"},		-- xoát quái
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Vương Lão Hán: \"Cuối cùng cũng kiểm quay về một cái mệnh, nhanh lên ly khai địa phương quỷ quái này.\""},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_21_wanglaohan_2", 6, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3263>: \"Các ngươi thực sự là hảo tâm nhân a, nếu như có cơ hội đụng với chế tạo những ... này bộ phận then chốt nhân đích chủ, nhất định phải giúp ta hảo hảo giáo huấn một chút hắn! Lão hán ta đi trước, các ngươi khảo sưởi ấm, một hồi tiền phương đích đường tự nhiên hội mở ra đích.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "21_gouhuo"},
	},
	},
	}
	}
	tbRoom[22] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {46336 / 32, 123136 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3163, nLevel = -1, nSeries = -1},		-- phúc xà 1
	[2] = {nTemplate = 3164, nLevel = -1, nSeries = -1},		-- phúc xà 2
	[3] = {nTemplate = 3165, nLevel = -1, nSeries = -1},		-- phúc xà 3
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ tiến nhập một người vứt đi đích sơn động, chu vi đích tảng đá phùng lý truyền đến trận trận động tĩnh, xem ra thị xông vào xà oa liễu..."},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Xà! Tất cả đều là xà! Xem ra chúng nó thị ngửi được thực vật đích vị đạo... Quản không được nhiều như vậy liễu, mở một đường máu ba!"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Thoáng qua trong lúc đó còn lại đích độc xà đều đào vào khe đá lý, chỉ còn lại có chật vật bất kham đích chúng ta. Ai, liên mấy cái xà đều thu thập không xong, xem ra tiền phương càng dữ nhiều lành ít liễu."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 36,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "22_fushe_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "22_fushe_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 32, 3, "guaiwu", "22_fushe_3"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 36 Rắn Hổ"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Rốt cục bả giá oa xà tiêu diệt sạch sẽ, khả dĩ an tâm sưởi ấm nghỉ ngơi, đợi kế tiếp khiêu chiến liễu."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "22_gouhuo"},
	},
	},
	}
	}
	tbRoom[23] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {52096 / 32, 124448 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3166, nLevel = -1, nSeries = -1},		-- phản quân binh sĩ 1
	[2] = {nTemplate = 3167, nLevel = -1, nSeries = -1},		-- phản quân binh sĩ 2
	[3] = {nTemplate = 3168, nLevel = -1, nSeries = -1},		-- phản quân thống lĩnh 1
	[4] = {nTemplate = 3169, nLevel = -1, nSeries = -1},		-- phản quân thống lĩnh 2
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Núi này động đèn đuốc sáng trưng, vật tư phong phú, hơn nữa liên đầu thạch cơ loại này đại quy mô sát thương tính vũ khí đều có, đến tột cùng là ai giấu kín ở đây ni?"},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Phản quân thống lĩnh: \"Cư nhiên có người phát hiện liễu chúng ta đích bí mật căn cứ, các huynh đệ, biệt lưu người sống, cho ta sát!\""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Chỉ nghe thấy ngoài động có người hét lớn một tiếng: tiêu đầu mục bắt người tới! Trong khoảnh khắc, còn lại đích phản quân đều dĩ chạy trốn vô tung, chỉ còn lại có một người nghi vấn quanh quẩn tại chúng ta trong lòng: tiêu đầu mục bắt người là người ra sao cũng?"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 32,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 26, 3, "guaiwu", "23_panjunshibing_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "23_panjunshibing_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 2, 3, "guaiwu", "23_panjuntongling_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 2, 3, "guaiwu", "23_panjuntongling_2"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Ngăn cản tất cả Phản Quân"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Hoàn hảo chỉ là ta tạp ngư bộ đội, dễ dàng thu thập liễu bọn họ sau đó, khả dĩ an tâm sưởi ấm nghỉ ngơi, đợi kế tiếp khiêu chiến liễu."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "23_gouhuo"},
	},
	},
	}
	}
	tbRoom[24] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {55968 / 32, 126048 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3166, nLevel = -1, nSeries = -1},		-- phản quân binh sĩ 1
	[2] = {nTemplate = 3168, nLevel = -1, nSeries = -1},		-- phản quân thống lĩnh 1
	[3] = {nTemplate = 3169, nLevel = -1, nSeries = -1},		-- phản quân thống lĩnh 2
	[4] = {nTemplate = 3225, nLevel = -1, nSeries = -1},		-- sát đại mục
	[5] = {nTemplate = 3264, nLevel = -1, nSeries =	-1},		-- tiêu không thật
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 6, "husong", "24_xiaobushi"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tiến nhập một người đèn đuốc sáng trưng đích sơn động, tiền phương hữu một ra vẻ trung lương đích đại thúc, hoa hắn để hỏi lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "Dữ sát đại mục ác chiến một phen lúc, không thể tương kì Thích sát, lại bị hắn tòng mật đạo chạy trốn... \n phía sau truyền đến tiêu đầu mục bắt người đích thanh âm: \"Người đâu? Bào lạp? ! Ta kháo! 10 cấp ma đao thạch ăn không phải trả tiền liễu... Ta đích bạc a...\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3264>: \"Ta nãi uy chấn tứ hải đích tiêu không thật, tiêu thần bộ! Ngày gần đây nhận được mật báo, hữu một cổ phản loạn thế lực giấu kín tại tiêu dao cốc nghiên cứu chế tạo đại quy mô sát thương tính vũ khí, bọn họ đích đầu mục hẳn là tựu giấu ở nơi đây, các ngươi có muốn hay không Cùng ta cùng nhau đi vào đưa hắn tróc nã quy án?\""},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 27,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv2_24_xiaobushi", 0, 100, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 1, 24, 4, "guaiwu", "24_panjunshibing"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 3, 4, "guaiwu", "24_panjuntongling"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Tiêu Bất Thực bắt giữ Thủ Lĩnh Phản Quân"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Sơn động thâm nhập truyền đến gầm lên giận dữ: \"Chết tiệt tiêu đầu mục bắt người! Lão Cùng bổn đại gia đối nghịch, lão tử ngày hôm nay Cùng ngươi liều mạng! Các huynh đệ, xét nhà hỏa, thượng!\" \n<npc=3264>: \"Ai nha... Ma đao thạch không có! Các ngươi mấy người tiên đính trứ, ta đi một chút sẽ trở lại.\" \n nói xong nhanh như chớp đã không thấy tăm hơi hình bóng."},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.ADD_NPC, 3, 4, 0, "guaiwu", "24_panjuntongling_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 1, 5, "guaiwu", "24_shadamu"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Sát Đại Mục"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đánh bại liễu sát đại mục, thế nhưng lại bị hắn tòng mật đạo chạy trốn. \n trong sơn động chỉ để lại hắn bi tình đích rống giận: \"Ta còn hội trở về đích...\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "24_gouhuo"},
	},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3264>: \"Các ngươi giá đàn tiểu tặc cho ta chờ, tiêu gia gia ta ăn 10 cấp ma đao thạch trở lại hội các ngươi!\" \n nói xong nhanh như chớp đã không thấy tăm hơi hình bóng, xem ra giá tàn cục đắc kháo chúng ta chính tới thu thập liễu..."},
	},
	},
	}
	}
	-- 3 cấp gian phòng
	tbRoom[25] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50656 / 32, 85824 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3265, nLevel = -1, 	nSeries = -1},		-- hiểu phỉ Hộ tống
	[2] = {nTemplate = 3170, nLevel = -1, 	nSeries = -1}, 		-- người tuyết
	[3] = {nTemplate = 3231, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[4] = {nTemplate = 3326, nLevel = -1, 	nSeries = -1}, 		-- bí trong bảo khố
	[5] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Mấy ca ca tỷ tỷ, hiểu phỉ nghe nói tiêu dao cốc lý có rất nhiều hảo đồ chơi, sở dĩ len lén lưu liễu tiến đến, thế nhưng nhưng tại đây lạc đường liễu... Các ngươi năng bang giúp ta mạ?\""},
	{XoyoGame.ADD_NPC, 5, 4, 0, "qinghua", "25_qinghua"},		-- tình hoa
	{XoyoGame.ADD_NPC, 1, 1, 2, "husong", "25_xiaofei"},		-- Hộ tống NPC
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 360, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "Một đám người tuyết bả hiểu phỉ nâng lên, tiêu thất tại phong tuyết trong, chúng ta có thể làm đích cũng chỉ có khẩn cầu trời xanh phù hộ vị này tiểu thư phúc thiên mệnh lớn..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.ADD_NPC, 4, 6, 0, "mibao", "25_shandingxueren_1"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Tiều, bên kia kỷ cây thượng có chút kỳ quái đích văn tự, có thể là đi ra giá tuyết sơn đích then chốt, các ngươi bồi hiểu phỉ đi xem.\""},
	{XoyoGame.TARGET_INFO, -1, "Cùng Hiểu Phi tìm đường ra khỏi núi tuyết"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent = {
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_25_xiaofei_1", 4, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 10,
	tbPrelock = {4},
	tbStartEvent = {
	{XoyoGame.BLACK_MSG, -1, "Mới vừa đi đáo dưới tàng cây, đột nhiên gian toát ra một đám hung mãnh đích người tuyết lao thẳng tới hiểu phỉ..."},
	{XoyoGame.ADD_NPC, 2, 10, 5, "guaiwu", "25_shandingxueren_1"},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Oa... Hù chết hiểu phỉ liễu, hoàn hảo hữu các ngươi tại. Trên cây đích bí văn ta nhận thức, nữa tiếp theo cây na nhìn.\""},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_25_xiaofei_2", 6, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent = {},
	},
	[7] = {nTime = 0, nNum = 10,
	tbPrelock = {6},
	tbStartEvent = {
	{XoyoGame.BLACK_MSG, -1, "Hiểu phỉ đang chuẩn bị giải độc đệ nhị cây thượng đích bí văn, hựu toát ra một đám hung ác đích người tuyết..."},
	{XoyoGame.ADD_NPC, 2, 10, 7, "guaiwu", "25_shandingxueren_2"},
	},
	tbUnLockEvent = {},
	},
	[8] = {nTime = 0, nNum = 1,
	tbPrelock = {7},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Hảo! Cái này cũng giải đọc xong liễu. Kế tục, kế tiếp!\""},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_25_xiaofei_3", 8, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 0, nNum = 10,
	tbPrelock = {8},
	tbStartEvent = {
	{XoyoGame.BLACK_MSG, -1, "Vừa người tuyết... Hữu hoàn không để yên a!"},
	{XoyoGame.ADD_NPC, 2, 10, 9, "guaiwu", "25_shandingxueren_3"},
	},
	tbUnLockEvent = {},
	},
	[10] = {nTime = 0, nNum = 1,
	tbPrelock = {9},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Da! Chỉ còn tối hậu một người liễu, lập tức là có thể ly khai địa phương quỷ quái này lạc.\""},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_25_xiaofei_4", 10, 0, 1},	-- Hộ tống AI
	},
	tbUnLockEvent = {},
	},
	[11] = {nTime = 0, nNum = 10,
	tbPrelock = {10},
	tbStartEvent = {
	{XoyoGame.BLACK_MSG, -1, "Quả nhiên... Còn có mai phục... Những ... này người tuyết rốt cuộc muốn làm gì a?"},
	{XoyoGame.ADD_NPC, 2, 10, 11, "guaiwu", "25_shandingxueren_4"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"(*^__^*) hì hì... Nhiệm vụ hoàn thành! Những ... này trên cây viết chính là: đương tuyết chi nữ vương trở về là lúc, ngô tộc bí mật trong bảo khố mới có thể tái hiện quang mang! Đến tột cùng thị có ý tứ ni? Được rồi, các vị ca ca tỷ tỷ, hiểu phỉ đi trước hoa hảo đồ chơi lạp, sau này còn gặp lại lạc.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "25_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 3, 1, 0, "shangren", "25_liukuo"},
	},
	},
	},
	}
	tbRoom[26] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {54720 / 32, 84992 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3156, nLevel = -1, 	nSeries = -1},		-- hầu tử
	[2] = {nTemplate = 3157, nLevel = -1, 	nSeries = -1},		-- bộ phận then chốt phủ thủ 1
	[3] = {nTemplate = 3158, nLevel = -1, 	nSeries = -1},		-- bộ phận then chốt phủ thủ 2
	[4] = {nTemplate = 3159, nLevel = -1, 	nSeries = -1},		-- bộ phận then chốt phủ thủ 3
	[5] = {nTemplate = 3160, nLevel = -1, 	nSeries = -1},		-- bộ phận then chốt phủ thủ 4
	[6] = {nTemplate = 3289, nLevel = -1, 	nSeries = -1}, 		-- tấm bia đá bộ phận then chốt
	[7] = {nTemplate = 3231, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[8] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tiêu dao cốc lý muôn hình vạn trạng, cư nhiên còn có thử tuyết sơn tuyệt cảnh, quả nhiên thần kỳ!"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 8, 4, 0, "qinghua", "26_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Một nghĩ tới đây phong cảnh tú lệ nhưng bộ phận then chốt trọng trọng, thái nguy hiểm liễu, hoán điều an toàn đích lộ tái đi tới."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 24,
	tbPrelock = {1},
	tbStartEvent = {
	{XoyoGame.MOVIE_DIALOG, -1, "Tuyết sơn thượng chỗ chạy đến nhiều như vậy dã hầu? Thật khiến cho người ta mất hứng! Đánh bại chúng nó hơn nữa."},
	{XoyoGame.ADD_NPC, 1, 24, 3, "guaiwu", "26_xueyuan"},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 24 Khỉ Hoang"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent = {
	{XoyoGame.BLACK_MSG, -1, "Sườn núi thượng tựa hồ hữu động tĩnh gì, đi tới điều tra một phen."},
	{XoyoGame.ADD_NPC, 6, 1, 4, "jiguan", "26_shibei"},
	{XoyoGame.TARGET_INFO, -1, "Khảo sát bia đá"},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 16,
	tbPrelock = {4},
	tbStartEvent = {
	{XoyoGame.ADD_NPC, 2, 4, 5, "guaiwu", "26_jiguanfushou_1"},
	{XoyoGame.ADD_NPC, 3, 4, 5, "guaiwu", "26_jiguanfushou_2"},
	{XoyoGame.ADD_NPC, 4, 4, 5, "guaiwu", "26_jiguanfushou_3"},
	{XoyoGame.ADD_NPC, 5, 4, 5, "guaiwu", "26_jiguanfushou_4"},
	{XoyoGame.TARGET_INFO, -1, "Loại bỏ tất cả Cơ Quan Thủ Phủ"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Có thể tìm được đường sống trong chỗ chết thật không dễ dàng, ngồi xuống nghỉ ngơi hạ khảo sưởi ấm, đợi kế tiếp khiêu chiến."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "26_guohuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 7, 1, 0, "shangren", "26_liukuo"},
	},
	},
	}
	}
	tbRoom[27] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {56896 / 32, 84320 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3139, nLevel = -1, 	nSeries = -1},		-- dã lang 1
	[2] = {nTemplate = 3140, nLevel = -1, 	nSeries = -1},		-- dã lang 2
	[3] = {nTemplate = 3141, nLevel = -1, 	nSeries = -1},		-- dã lang 3
	[4] = {nTemplate = 3275, nLevel = -1, 	nSeries = -1},		-- Nhậm Nghiêu
	[5] = {nTemplate = 3218, nLevel = -1, 	nSeries = -1},		-- Sói chúa
	[6] = {nTemplate = 3288, nLevel = -1, 	nSeries = -1},		-- Nhậm Nghiêu ( cường công )
	[7] = {nTemplate = 3232, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[8] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước cái kia hộ săn bắn hình như ở nơi nào gặp qua, quá khứ nhìn."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 8, 5, 0, "qinghua", "27_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 4, 1, 0, "baohu", "27_renyao"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	},
	[2] = {nTime = 360, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3275>: \"Ta nghe nói vùng này đích dã lang trở nên dị thường liễu, riêng nhiều nhìn, kết quả bị chúng nó trọng thương, để làng đích an toàn, các ngươi mấy người khả dĩ giúp ta Tiêu diệt những ... này dã thú mạ?\""},
	{XoyoGame.ADD_NPC, 1, 1, 4, "guaiwu", "27_yelang_1"},
	{XoyoGame.ADD_NPC, 2, 1, 4, "guaiwu", "27_yelang_2"},
	{XoyoGame.ADD_NPC, 3, 18, 4, "guaiwu", "27_yelang_3"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 20 Sói Hoang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Chỉ nghe thấy đắc một tiếng kỳ quái đích tiếng hô, còn lại đích bầy sói toàn bộ đào trở về núi trung. Chúng ta trong lòng tràn ngập dấu chấm hỏi: rốt cuộc là ai hữu lớn như vậy đích uy hiếp lực?"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 30, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 20,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Không được, lũ sói đã tấn công Nhậm Nghiêu, mau bảo vệ!"},
	{XoyoGame.TARGET_INFO, -1, "Bảo vệ Nhậm Nghiêu, đông thời tiêu diệt 20 Sói Hoang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "baohu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[6]:Close()"},
	{XoyoGame.BLACK_MSG, -1, " Nhậm Nghiêu : các ngươi đứng vững, ta đi hoa cứu binh."},
	{XoyoGame.DO_SCRIPT, "for i = 10, 14 do self. tbLock[i]:Close() end"},
	},
	},
	[6] = {nTime = 150, nNum = 0,
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "baohu"},
	},
	},
	[7] = {nTime = 0, nNum = 1,
	tbPrelock = {6},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, " Nhậm Nghiêu : ta nghỉ ngơi tốt liễu, lai trợ các ngươi giúp một tay!"},
	{XoyoGame.ADD_NPC, 6, 1, 7, "qiangren", "27_renyao_1"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1, " Nhậm Nghiêu : ai nha! Má ơi!"},
	},
	},
	[8] = {nTime = 0, nNum = 4,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 4, 8, "guaiwu", "27_yelang_4"},
	{XoyoGame.BLACK_MSG, -1, "Hựu vọt kỷ đầu lang đi ra!"},
	{XoyoGame.TARGET_INFO, -1, "Kiên trì hay thắng lợi"},
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 0, nNum = 1,
	tbPrelock = {8},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 9, "guaiwu", "27_langwang"},
	{XoyoGame.ADD_NPC, 1, 4, 0, "guaiwu", "27_yelang_5"},
	{XoyoGame.BLACK_MSG, -1, "Sói chúa rốt cục xuất hiện liễu, thắng lợi ngay trước mắt."},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Sói chúa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3288>: \"Di, lang thế nào tựu toàn bộ không có? Oa ha ha ha, tiểu bằng hữu môn, làm được không sai a, lai khảo sưởi ấm nghỉ ngơi một chút.\""},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "27_renyao_1"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "27_guohuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 7, 1, 0, "shangren", "27_liukuo"},
	},
	},
	[10] = {nTime = 30, nNum = 0,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 0, "husong", "27_yelang_6"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "husong", "27_yelang_6"},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_27_yelang", 5, 0, 0, 1},
	},
	tbUnLockEvent = {},
	},
	}
	}
	for i = 1, 4 do
	local nNpcIdx = 3;
	if i > 3 then
	nNpcIdx = 2;
	end
	tbRoom[27]. LOCK[10 + i] = {nTime = 30, nNum = 0,
	tbPrelock = {9 + i},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 0, "husong"..i, "27_yelang_6"},
	{XoyoGame.ADD_NPC, nNpcIdx, 1, 0, "husong "..i, "27_yelang_6"},
	{XoyoGame.CHANGE_NPC_AI, "husong "..i, XoyoGame.AI_MOVE, "lv3_27_yelang", 5, 0, 0, 1},
	},
	tbUnLockEvent = {},
	};
	end
	tbRoom[28] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {51744 / 32, 90720 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3171, nLevel = -1, 	nSeries = -1},		-- nhà vườn 1
	[2] = {nTemplate = 3172, nLevel = -1, 	nSeries = -1},		-- nhà vườn 2
	[3] = {nTemplate = 3173, nLevel = -1, 	nSeries = -1},		-- nhà vườn 3
	[4] = {nTemplate = 3257, nLevel = -1, 	nSeries = -1},		-- túi bộ phận then chốt
	[5] = {nTemplate = 3231, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[6] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ tiến nhập một người vườn trái cây, tại tiêu dao trong cốc đi lâu như vậy, rốt cục có một hữu cật gì đó đích địa phương liễu, đều nhanh chết đói."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 6, 5, 0, "qinghua", "28_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Ai, đầu năm nay tưởng điền đầy bụng cũng không thị nhất kiện dễ chuyện a. Không có biện pháp, đói bụng lánh tầm hắn lộ."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 3, "jiguan", "28_guolan"},
	{XoyoGame.MOVIE_DIALOG, -1, "Xung tìm xem khán có cái gì ... không năng điền đầy bụng gì đó"},
	{XoyoGame.TARGET_INFO, -1, "Tìm trong vườn xem có gì ăn được không"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 40,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 4, "guaiwu", "28_guonong_1"},
	{XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "28_guonong_2"},
	{XoyoGame.ADD_NPC, 3, 36, 4, "guaiwu", "28_guonong_3"},
	{XoyoGame.BLACK_MSG, -1, "Bất hảo! Thâu đông tây bị phát hiện liễu, một đám hung thần ác sát đích nhà vườn triêu chúng ta đánh tới... ."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 40 Quả Nông"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "28_gouhuo"},
	{XoyoGame.ADD_NPC, 5, 1, 0, "shangren", "28_liukuo"},
	{XoyoGame.MOVIE_DIALOG, -1, "Cưỡng chế di dời liễu nhà vườn, ngồi xuống tiên bả món bao tử điền ăn no, khảo sưởi ấm, sau đó tái kế tục đi tới."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	},
	},
	}
	}
	tbRoom[29] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {56160 / 32, 89056 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3174, nLevel = -1, nSeries = -1},		-- thấp kém bộ phận then chốt nhân
	[2] = {nTemplate = 3175, nLevel = -1, nSeries = -1},		-- thấp kém bộ phận then chốt nhân
	[3] = {nTemplate = 3176, nLevel = -1, nSeries = -1},		-- thấp kém bộ phận then chốt nhân
	[4] = {nTemplate = 3227, nLevel = -1, nSeries =	-1},		-- tử uyển
	[5] = {nTemplate = 3232, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[6] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước có hộ nhân gia, quá khứ nhìn hữu không ai có thể cho chúng ta chỉ điểm hạ sấm cốc đích lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 6, 4, 0, "qinghua", "29_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3227>: \"Tựu điểm ấy tam cước miêu công phu? Không có ý nghĩa, bất với các ngươi chơi, bản cô nương ta hoa người khác đi.\""},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 120, nNum = 0,		-- tính theo thời gian tỏa
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 30,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Lại có bộ phận then chốt nhân đi ra tác loạn liễu? Tố điểm chuyện tốt, thanh lý điệu mấy thứ này."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại tất cả Cơ Quan Nhân Thô"},
	{XoyoGame.ADD_NPC, 1, 2, 4, "guaiwu", "29_liezhijiguanren_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "29_liezhijiguanren_2"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 26, 4, "guaiwu", "29_liezhijiguanren"},		-- xoát quái
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Tử uyển: \"Vì sao yếu phá hư ta tân tân khổ khổ làm được bộ phận then chốt nhân? Bồi!\""},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Tử Uyển và tất cả Cơ Quan Nhân"},
	{XoyoGame.ADD_NPC, 4, 1, 5, "guaiwu", "29_ziyuan"},		-- xoát quái
	},
	tbUnLockEvent =
	{
	},
	},
	[6] = {nTime = 0, nNum = 0,		-- kết thúc tỏa
	tbPrelock = {4,5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Ai, hảo tâm làm chuyện xấu... Ai, cái gì giang hồ a... Quên đi, tiên khảo sưởi ấm, kế tục đi tới."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "29_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 5, 1, 0, "shangren", "29_liukuo"},
	},
	},
	}
	}
	tbRoom[30] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {55168 / 32, 94656 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3141, nLevel = -1, nSeries = -1},		-- lang
	[2] = {nTemplate = 3266, nLevel = -1, nSeries =	-1},		-- Hộ tống NPC
	[3] = {nTemplate = 3232, nLevel = 75, nSeries = -1}, 		-- liễu rộng rãi
	[4] = {nTemplate = 3155, nLevel = -1, nSeries = -1},		-- hầu tử 1
	[5] = {nTemplate = 3156, nLevel = -1, nSeries = -1},		-- hầu tử 2
	[6] = {nTemplate = 3304, nLevel = -1, nSeries = -1},		-- bộ phận then chốt
	[7] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thật lớn một mảnh tây qua địa, thật lớn đích tây qua. Di? Thế nào còn có một vị khuôn mặt u sầu đầy mặt đích nông dân trồng dưa, quá khứ hỏi một chút tình huống."},
	{XoyoGame.ADD_NPC, 2, 1, 2, "husong", "30_yunsongxiguademache"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 7, 4, 0, "qinghua", "30_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	},
	[2] = {nTime = 360, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nông dân trồng dưa: trời ạ, đều tại ngươi thái vô dụng liễu. Ôi, ta giá khả thế nào hướng cốc chủ báo cáo kết quả công tác a..."},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nông dân trồng dưa: ta gần nhất dựa theo cốc chủ đích yêu cầu đào tạo liễu một loại kiểu mới tây qua. Hiện tại cốc chủ muốn ta bả thành quả vận quá khứ, thế nhưng đại bộ phận tây qua đều bị một đám hầu tử đoạt đi rồi, ai, chẳng các vị có thể hay không giúp ta đoạt lại."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.ADD_NPC, 4, 2, 0, "guaiwu", "30_yehou_1"},
	{XoyoGame.ADD_NPC, 5, 12, 0, "guaiwu", "30_yehou_2"},
	{XoyoGame.ADD_NPC, 6, 1, 3, "jiguan", "30_yehou_1"},
	{XoyoGame.TARGET_INFO, -1, "Xuống dưới tìm dưa hấu"},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 10, nNum = 0,
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_30_yunsongxiguademache", 5, 100, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 1, 30, 0, "guaiwu", "30_yelang"},
	{XoyoGame.BLACK_MSG, -1, "Nông dân trồng dưa: cái này khả dĩ cấp cốc chủ đưa đi liễu, lại muốn làm phiền các vị liễu."},
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Xe vận chuyển dưa hấu"},
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nông dân trồng dưa: \"Mấy khổ cực liễu, lai cật khẩu tây qua nghỉ ngơi một chút ba, ta phải kế tục chạy đi, đi trước liễu. Đợi tiền phương đích đường thì sẽ cho các ngươi mở.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "30_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 3, 1, 0, "shangren", "30_liukuo"},
	},
	},
	}
	}
	tbRoom[31] = {}
	CopyTable(tbRoom[28], tbRoom[31]);
	tbRoom[31]. tbBeginPoint	= {47456 / 32, 95584 / 32};
	tbRoom[31]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 4, 1, 3, "jiguan", "31_guolan"}
	tbRoom[31]. LOCK[4]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 2, 4, "guaiwu", "31_guonong_1"}
	tbRoom[31]. LOCK[4]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "31_guonong_2"}
	tbRoom[31]. LOCK[4]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 3, 36, 4, "guaiwu", "31_guonong_3"}
	tbRoom[31]. LOCK[4]. tbUnLockEvent[1] = {XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "31_gouhuo"}
	tbRoom[31]. LOCK[4]. tbUnLockEvent[2] = {XoyoGame.ADD_NPC, 5, 1, 0, "shangren", "31_liukuo"}
	tbRoom[32] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50720 / 32, 98784 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3179, nLevel = -1, nSeries = -1},		-- u linh
	[2] = {nTemplate = 3267, nLevel = -1, nSeries =	-1},		-- Hộ tống chu đại phi
	[3] = {nTemplate = 3231, nLevel = 75, nSeries =	-1},		-- liễu rộng rãi
	[4] = {nTemplate = 3325, nLevel = -1, nSeries =	-1},		-- bí trong bảo khố
	[5] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thử Địa Âm khí rất nặng, không biết cất dấu cái dạng gì đích nguy cơ. Di, phía trước có cá nhân, quá khứ hỏi một chút tình huống."},
	{XoyoGame.ADD_NPC, 2, 1, 3, "husong", "32_zhoudafei"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 5, 4, 0, "qinghua", "32_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thoáng qua trong lúc đó, chu đại phi Cùng tất cả u linh đều tiêu thất không gặp, chỉ để lại kinh hồn vị định đích chúng ta Cùng một đống tản ra kỳ quái quang mang đích vật thể, lẽ nào... Đây là trong truyền thuyết đích bí trong bảo khố?"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.ADD_NPC, 4, 6, 0, "mibao", "32_mibao"},		-- bí trong bảo khố
	},
	},
	[3] = {nTime = 0, nNum = 1,		-- đại phi tử vong
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3267>: \"Vì sao... Ta lại muốn chết ở loại địa phương này... Đến tột cùng còn muốn chờ nhiều ít niên, ta tài năng ly khai địa phương quỷ quái này a?\""},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[4] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3267>: \"Các ngươi... Thị người sống? Thật tốt quá! Van cầu các ngươi mang ta ly khai địa phương quỷ quái. Ở đây thật nhiều u linh, thật là đáng sợ. Tiều, chúng nó hựu đi ra liễu.\""},
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Chu Đại Phi"},
	{XoyoGame.ADD_NPC, 1, 36, 0, "guaiwu", "32_youmingjianke"},		-- xoát quái
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv3_32_zhoudafei", 5, 100, 1},	-- Hộ tống AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3267>: \"Cảm tạ các ngươi, ta rốt cục khả dĩ lại thấy ánh mặt trời liễu, ha ha ha! Ai? Vì sao... Vì sao cơ thể của ta tại tiêu thất, vì sao? Ta không nên trở lại cái kia địa phương... Không nên a...\" \n trong nháy, chu đại phi đích thân thể dĩ tro bụi mai một, chỉ để lại một đống lửa trại. Quên đi, không thèm nghĩ nữa nhiều như vậy, chuyên tâm sưởi ấm."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "32_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 3, 1, 0, "shangren", "32_liukuo"},
	},
	},
	}
	}
	tbRoom[33] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50432 / 32, 106496 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3174, nLevel = -1, nSeries = -1},		-- bộ phận then chốt mộc nhân
	[2] = {nTemplate = 3175, nLevel = -1, nSeries = -1},		-- bộ phận then chốt mộc nhân
	[3] = {nTemplate = 3176, nLevel = -1, nSeries = -1},		-- bộ phận then chốt mộc nhân
	[4] = {nTemplate = 3228, nLevel = -1, nSeries = -1},		-- tần trọng
	[5] = {nTemplate = 3290, nLevel = -1, nSeries =	-1},		-- chướng ngại vật trên đường NPC
	[6] = {nTemplate = 3232, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[7] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi đây rất là âm trầm, con đường phía trước cũng bị cản trở trở trụ, đợi khẳng định không có cái gì chuyện tốt phát sinh."},
	{XoyoGame.ADD_NPC, 5, 2, 0, "zhangai1", "33_luzhang"},		-- cản trở
	{XoyoGame.ADD_NPC, 7, 3, 0, "qinghua", "33_qinghua"},		-- tình hoa
	{XoyoGame.CHANGE_TRAP, "33_trap_1", {51552 / 32, 107360 / 32}},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong nháy, tất cả địch nhân đều tiêu thất vô tung, lẽ nào chúng ta vừa là ở nằm mơ?"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 30,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "33_jiguanmuren_1"},		-- quái vật
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "33_jiguanmuren_2"},		-- quái vật
	{XoyoGame.ADD_NPC, 3, 26, 3, "guaiwu", "33_jiguanmuren_3"},		-- quái vật
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 30 Cơ Quan Nhân Thô"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 12, 0, "guaiwu", "33_jiguanmuren_4"},		-- quái vật
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "33_qinzhong"},
	{XoyoGame.DEL_NPC, "zhangai1"},
	{XoyoGame.CHANGE_TRAP, "33_trap_1", nil},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3228>: \"Cư nhiên năng đánh bại ta chế tạo đích bộ phận then chốt nhân, thực lực khá tốt ma, nhiều chơi với ta ngoạn.\" \n tiền phương đích lưới sắt lan hình như mở liễu, quá khứ nhìn một cái là ai tại khiêu khích."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Tần Trọng"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Hữu kinh vô hiểm đích Đánh bại liễu tần trọng. Bất quá thực sự là quái nhân nơi chốn hữu, tiêu dao cốc lý đặc biệt đa, bọn họ thế nào tựu lão thích chỉnh những ... này bộ phận then chốt ngoạn ý lai dằn vặt người đâu?"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "33_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 6, 1, 0, "shangren", "33_liukuo"},
	},
	},
	}
	}
	tbRoom[34] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {53248 / 32, 104448 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3177, nLevel = -1, nSeries = -1},		-- âm u quỷ
	[2] = {nTemplate = 3178, nLevel = -1, nSeries = -1},		-- âm u quỷ
	[3] = {nTemplate = 3179, nLevel = -1, nSeries = -1},		-- âm u quỷ
	[4] = {nTemplate = 3229, nLevel = -1, nSeries = -1},		-- Quỷ Vương
	[5] = {nTemplate = 3276, nLevel = -1, nSeries = -1},		-- cọc gỗ
	[6] = {nTemplate = 3277, nLevel = -1, nSeries = -1},		-- cọc gỗ
	[7] = {nTemplate = 3278, nLevel = -1, nSeries = -1},		-- cọc gỗ
	[8] = {nTemplate = 3232, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[9] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi đây rất là âm trầm, đợi khẳng định không có chuyện tốt phát sinh. Nghìn vạn lần biệt xuất hiện cái loại này đông tây a!"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 9, 4, 0, "qinghua", "34_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong nháy, tất cả u linh đều tiêu thất vô tung, lẽ nào chúng ta vừa là ở nằm mơ?"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 34,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 3, "guaiwu", "34_youminggui_1"},		-- quái vật
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "34_youminggui_2"},		-- quái vật
	{XoyoGame.ADD_NPC, 3, 30, 3, "guaiwu", "34_youminggui_3"},		-- quái vật
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 34 U Minh Quỷ"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 12, 0, "guaiwu", "34_youminggui_4"},		-- quái vật
	{XoyoGame.ADD_NPC, 4, 1, 4, "guaiwu", "34_youmingguiwang"},		-- quái vật
	{XoyoGame.ADD_NPC, 5, 1, 0, "guaiwu", "34_muzhuang_1"},
	{XoyoGame.ADD_NPC, 6, 1, 0, "guaiwu", "34_muzhuang_2"},
	{XoyoGame.ADD_NPC, 7, 1, 0, "guaiwu", "34_muzhuang_3"},
	{XoyoGame.BLACK_MSG, -1, "Đột nhiên cảm giác được tiền phương truyền đến một cổ cường liệt đích hàn khí, tựa hồ hữu càng cường hãn đích lệ quỷ xuất hiện liễu"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại U Minh Quỷ Vương"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đánh bại U Minh Quỷ Vương, khu vực này đã an toàn. Nghỉ ngơi bên đống lửa, chuẩn bị thử thách tiếp theo."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "34_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 8, 1, 0, "shangren", "34_liukuo"},
	},
	},
	}
	}
	-- BOSS gian phòng
	tbRoom[37] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {58464 / 32, 91808 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3180, nLevel = -1, nSeries = -1},		-- ấu khuyển
	[2] = {nTemplate = 3240, nLevel = -1, nSeries =	-1},		-- vượng tài
	[3] = {nTemplate = 3241, nLevel = -1, nSeries =	1},		-- mộc siêu
	[4] = {nTemplate = 3232, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	[5] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tựa hồ xông vào liễu nhất hộ hộ săn bắn nhân gia... Xung tìm xem khán có hay không nhân có thể hỏi hỏi đường."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 5, 5, 0, "qinghua", "37_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nhân một hoa trứ, nhưng thật ra toát ra mấy cái chó săn triêu chúng ta đánh tới, cưỡng chế di dời chúng nó hơn nữa"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tiêu dao trong cốc quả nhiên tàng long ngọa hổ, chính hoán con đường kế tục đi tới."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 90, nNum = 0,		-- tính theo thời gian xoát boss
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 9,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 9, 4, "guaiwu", "37_liequan"},		-- quái vật
	{XoyoGame.TARGET_INFO, -1, "Đánh bại tất cả Chó Săn"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {{3,4}},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Người nào dám ở địa bàn của ta quấy rối! Chán sống?"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu", "37_wangcai"},
	{XoyoGame.ADD_NPC, 3, 1, 5, "guaiwu", "37_muchao"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Mộc Siêu"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Vị này hộ săn bắn dũng mãnh thiện chiến, có thể thoát hiểm đã vạn hạnh, hảo hảo chỉnh đốn hạ, hướng về trong cốc càng sâu chỗ đi tới liễu."},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "37_gouhuo"},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 4, 1, 0, "shangren", "37_liukuo"},
	},
	},
	}
	}
	-- sai mê gian phòng
	tbRoom[35] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= BaseRoom. GuessRule,		-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {53440 / 32,	93312 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3279, nLevel = 99, nSeries = -1},
	[2] = {nTemplate = 3231, nLevel = 75, 	nSeries = -1}, 		-- liễu rộng rãi
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3279>: \"Ha ha ha, trở thành tiêu dao cốc đích hiệp sĩ môn, để cho ta tới khảo khảo các ngươi đối cái này giang hồ đích lý giải trình độ. Mời các ngươi song phương đích đội trưởng lai ta giá tiếp thu khảo nghiệm.\""},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 360, nNum = 0,
	tbPrelock = {1};
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 2, "datinpc", "35_jiutiandaoren"},			-- đáp đề NPC
	{XoyoGame.ADD_NPC, 2, 1, 0, "shangren", "35_liukuo"},			-- đáp đề NPC
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Do đội trưởng trả lời cửu thiên đạo nhân đích vấn đề"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "datinpc"},
	{XoyoGame.DO_SCRIPT, "self:CheckWinner()"},		-- thủ động phán thắng bại
	{XoyoGame.DO_SCRIPT, "self:TeamBlackMsg(self. tbWinner, 'Chúng ta quả nhiên thị tài trí gồm nhiều mặt a ')"};
	{XoyoGame.DO_SCRIPT, "self:TeamBlackMsg(self. tbLoser, 'Ai, xem ra chúng ta đối cái này giang hồ đích lý giải trình độ còn chưa đủ a ')"};
	},
	},
	}
	}
	-- PK gian phòng
	tbRoom[36] =
	{
	fnPlayerGroup 	= BaseRoom. PKGroup,			-- PK phân tổ
	fnDeath			= BaseRoom. PKDeath,			-- PK gian phòng tử vong kịch bản gốc;
	fnWinRule		= BaseRoom. PKWinRule,		-- PK thắng lợi điều kiện
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {{47104/32, 89120/32}, {48512/32, 87648/32}},-- lúc đầu điểm,
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đối diện tựa hồ cũng là đối tiêu dao cốc tràn ngập lòng hiếu kỳ đích nhân, cũng không biết bọn họ đích công phu thế nào, đi thử hắn thử một lần."},
	{XoyoGame.TIME_INFO, -1, "<color=green> ly khai thủy PK thặng dư thời gian %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, "Địch quân đánh bại bên ta thành viên sổ: 0\n bên ta đánh bại địch quân thành viên sổ: 0"},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>PK thặng dư thời gian %s<color>", 2},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_CAMP},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self:CheckWinner()"},		-- thủ động phán thắng bại
	{XoyoGame.DO_SCRIPT, "self:TeamBlackMsg(self. tbWinner, 'Xem ra chính chúng ta đội ngũ kỹ cao một bậc a ')"};
	{XoyoGame.DO_SCRIPT, "self:TeamBlackMsg(self. tbLoser, 'Đối phương thực lực quá mạnh mẽ, chúng ta hoàn nhu nhiều hơn tôi luyện a ')"};
	},
	},
	}
	}
	-- đẳng cấp 4 gian phòng
	tbRoom[38] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {62016 / 32, 106592 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3280, nLevel = -1, nSeries = -1},		-- thúy tiểu âu
	[2] = {nTemplate = 3183, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm
	[3] = {nTemplate = 3188, nLevel = -1, nSeries =	-1},		-- Thủ Lĩnh Sấm Cốc Tặc
	[4] = {nTemplate = 3301, nLevel = 35, nSeries = -1},    -- tiêu không thật
	[5] = {nTemplate = 3321, nLevel = 35, nSeries = -1},    -- cái rương
	[6] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 0, "baohu", "38_cuixiaoou"},		-- Bảo vệNPC
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: gần nhất cốc lý tới thật nhiều hung thần ác sát đích kẻ cắp, ba ba mụ mụ hựu đi ra, tiểu âu rất sợ hãi mụ mụ khổ cực đào tạo đích bảo bối bị kẻ cắp môn đoạt đi rồi, các ngươi năng bang giúp ta mạ?"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 6, 6, 0, "qinghua", "38_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	},
	[2] = {nTime = 30, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 2, 0, "guaiwu1_1", "38_chuangguzei_1"},
	{XoyoGame.ADD_NPC, 2, 2, 0, "guaiwu2_1", "38_chuangguzei_2"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_1", XoyoGame.AI_MOVE, "lv4_38_chuangguzei_1", 10, 0, 0, 1},	-- tìm đường
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2_1", XoyoGame.AI_MOVE, "lv4_38_chuangguzei_2", 10, 0, 0, 1},  -- tìm đường
	},
	tbUnLockEvent = {},
	},
	[10] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "baohu"},
	{XoyoGame.DO_SCRIPT, "for i = 2, 9 do self. tbLock[i]:Close() end"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[11]:Close()"},
	},
	},
	[11] = {nTime = 240, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 11},
	{XoyoGame.TARGET_INFO, -1, "Bảo vệ Thúy Tiểu Âu"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[10]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[12]:Close()"},
	},
	},
	[12] = {nTime = 480, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Đúng lúc này, tiểu âu đứng lên! Nguyên lai vừa tha thị giả chết đích. May là vị này cơ trí đích tiểu cô nương hướng tiêu đầu mục bắt người nói rõ liễu tình huống, ta tài năng tránh được một kiếp, thực sự là cảm tạ trời đất a. \n<npc=3280>: thật tốt quá, ác nhân môn đều đi! Các ngươi đi xem nhà của ta đích bảo bối. Hẳn là tựu giấu ở thác nước phía dưới."},
	{XoyoGame.ADD_NPC, 5, 6, 0, "baoxiang", "38_baoxiang"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[13]:Close()"},
	},
	},
	[13] = {nTime = 0, nNum = 1,
	tbPrelock = {10},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 20, 0, "guaiwu", "38_chuanguzei_4"},
	{XoyoGame.ADD_NPC, 4, 1, 13, "guaiwu", "38_xiaobushi"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3264>: ta nhận được tuyến báo thuyết, nơi này cường đạo thường lui tới, nguy hại bách tính sinh hoạt bởi vậy nhiều nhìn. Không nghĩ tới các ngươi giá đàn không ai tính súc sinh, liên một tiểu cô nương cũng không buông tha! Ngày hôm nay sẽ cho các ngươi nếm thử Tiêu mỗ đích lợi hại!"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Tiêu Bất Thực"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 12},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.MOVIE_DIALOG, -1, "Kinh qua một hồi gian nan đích chiến đấu, chúng ta rốt cục chế trụ liễu tiêu đầu mục bắt người. Cùng tiêu đầu mục bắt người một phen giải thích lúc, hắn tin chúng ta, tịnh mang theo tiểu âu đích thi thể ly khai ở đây. Chúng ta cũng nên nghỉ ngơi hạ sau đó tiếp tục đi tới liễu."},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[12]:Close()"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "38_gouhuo"},
	},
	},
	[14] = {nTime = 240, nNum = 0,
	tbPrelock = {11},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Giá đàn cường đạo quá khó khăn triền liễu. Đây là, truyền đến một tiếng rống to: Tiêu mỗ ở đây! Ai dám lỗ mãng! Thanh tất, chỉ thấy đám kia cường đạo nhanh như chớp tác điểu thú tán. Chỉ để lại hoa chân múa tay vui sướng đích thúy tiểu âu Cùng chật vật bất kham đích chúng ta."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "baohu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[15]:Close()"},
	},
	},
	[15] = {nTime = 0, nNum = 2,
	tbPrelock = {11},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Chống đối liễu một trận, thế nhưng chính hữu rất nhiều cường đạo dũng liễu nhiều. Muốn chân chính Bảo vệ tiểu âu, phải lấy đầu của Thủ Lĩnh Sấm Cốc Tặc mới được."},
	{XoyoGame.ADD_NPC, 2, 18, 0, "guaiwu", "38_chuangguzei_3"},
	{XoyoGame.ADD_NPC, 3, 2, 15, "guaiwu", "38_chuangguzeitouling_3"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 2 Thủ Lĩnh Sấm Cốc Tặc"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 14},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thành công ngăn trở sấm cốc kẻ trộm thương tổn tiểu âu. Quá khứ Cùng tiểu âu tâm sự thiên, nghỉ ngơi một chút, tái kế tục đi tới."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[14]:Close()"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "38_gouhuo"},
	},
	},
	},
	}
	for i = 1, 7 do
	local nNpcIdx = 2;
	local nLockTime = 30;
	local nNpcCount = 2;
	if i > 6 then
	nNpcIdx = 3;
	nLockTime = 30;
	nNpcCount = 1;
	end
	tbRoom[38]. LOCK[2 + i] = {nTime = nLockTime, nNum = 0,
	tbPrelock = {1 + i},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, nNpcIdx, nNpcCount, 0, "guaiwu "..i.."_1", "38_chuangguzei_1"},
	{XoyoGame.ADD_NPC, nNpcIdx, nNpcCount, 0, "guaiwu "..i.."_2", "38_chuangguzei_2"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu "..i.."_1", XoyoGame.AI_MOVE, "lv4_38_chuangguzei_1", 10, 0, 0, 1},	-- tìm đường
	{XoyoGame.CHANGE_NPC_AI, "guaiwu "..i.."_2", XoyoGame.AI_MOVE, "lv4_38_chuangguzei_2", 10, 0, 0, 1},	-- tìm đường
	},
	tbUnLockEvent = {},
	};
	end
	tbRoom[39] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {57376 / 32, 107424 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3258, nLevel = -1, nSeries = -1},		-- túi
	[2] = {nTemplate = 3185, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm
	[3] = {nTemplate = 3184, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm
	[4] = {nTemplate = 3183, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm
	[5] = {nTemplate = 3188, nLevel = -1, nSeries =	-1},		-- Thủ Lĩnh Sấm Cốc Tặc
	[6] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này thế nào liên một quỷ ảnh chưa từng? Chân quái dị! Chung quanh tìm xem khán có cái gì khả nghi gì đó một."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 6, 6, 0, "qinghua", "39_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "Thủ Lĩnh Sấm Cốc Tặc: \"Các ngươi mấy người tên coi như có điểm bản lĩnh thật sự, hảo hán không ăn trước mắt khuy, các huynh đệ, triệt! \n trong nháy, tất cả kẻ cắp đều chạy trốn vô tung...\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 3, "jiguan", "39_zhuangyoubaowudedaizi"},		-- bộ phận then chốt
	{XoyoGame.TARGET_INFO, -1, "Chung quanh tìm xem khán có cái gì khả nghi gì đó"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {}
	},
	[4] = {nTime = 0, nNum = 32,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},		-- bộ phận then chốt
	{XoyoGame.ADD_NPC, 2, 3, 4, "guaiwu", "39_chuangguzei_1"},
	{XoyoGame.ADD_NPC, 2, 3, 4, "guaiwu", "39_chuangguzei_2"},
	{XoyoGame.ADD_NPC, 4, 26, 4, "guaiwu", "39_chuangguzei_3"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại tất cả Sấm Cốc Tặc đang phục kích bên trong"},
	},
	tbUnLockEvent = {}
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thủ Lĩnh Sấm Cốc Tặc: \"Một đám phế vật, mấy người mao đầu tiểu tử đều cảo bất định. Bổn đại gia lai hội hội các ngươi!\""},
	{XoyoGame.ADD_NPC, 5, 1, 5, "guaiwu", "39_chuangguzeitouling"},
	{XoyoGame.ADD_NPC, 3, 2, 0, "guaiwu", "39_chuangguzei_4"},
	{XoyoGame.ADD_NPC, 2, 2, 0, "guaiwu", "39_chuangguzei_4"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Thủ Lĩnh Sấm Cốc Tặc"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đánh bại liễu mai phục tại thử đích tất cả ác nhân. Khả dĩ an tâm khảo hạ hỏa, chuẩn bị nghênh tiếp tối hậu đích khiêu chiến liễu."},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "39_gouhuo"},
	}
	},
	},
	}
	tbRoom[40] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {51200 / 32, 104160 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3322, nLevel = -1, nSeries =	-1},		-- tấm bia đá bộ phận then chốt
	[2] = {nTemplate = 3276, nLevel = 1, nSeries =	-1},		-- cọc gỗ bộ phận then chốt _ khả bị công kích
	[3] = {nTemplate = 3323, nLevel = -1, nSeries =	-1},		-- cọc gỗ bộ phận then chốt _ bất khả công kích
	[4] = {nTemplate = 3324, nLevel = -1, nSeries =	-1},		-- cuồng bạo bộ phận then chốt nhân _ vô hình cổ
	[5] = {nTemplate = 3194, nLevel = -1, nSeries =	-1},		-- cuồng bạo bộ phận then chốt nhân _ phổ thông
	[6] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Giá phiến rừng trúc trong dĩ nhiên hữu hộ nhân gia, quá khứ nhìn có thể không thảo chén nước hát."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 6, 6, 0, "qinghua", "40_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.DEL_NPC, "guaiwu3"},
	{XoyoGame.DEL_NPC, "guaiwu4"},
	{XoyoGame.DEL_NPC, "jiguan1"},
	{XoyoGame.DEL_NPC, "jiguan2"},
	{XoyoGame.DEL_NPC, "jiguan3"},
	{XoyoGame.DEL_NPC, "jiguan4"},
	{XoyoGame.MOVIE_DIALOG, -1, "( một người kỳ quái đích thanh âm lần thứ hai vang lên ) \"Lữ nhân a, các ngươi không có tư cách thu được bảo tàng!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 0,
	tbPrelock = {6,9,12,15},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "( một người kỳ quái đích thanh âm lần thứ hai vang lên ) \"Thần kỳ đích lữ nhân a, các ngươi dĩ nhiên khả dĩ cởi ra ta thiết hạ đích bộ phận then chốt. Nói vậy các ngươi nghe qua rất nhiều 'Giấu đầu lòi đuôi' đích cố sự, bất quá nơi đây thực sự vô ngân! Oa ha ha ha ha cáp.\""},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "40_jiguan_1"},
	},
	},
	[4] = {nTime = 30, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 4, "jiguan", "40_shibei"},
	{XoyoGame.MOVIE_DIALOG, -1, "Kỳ quái, dĩ nhiên không ai tại gia. Trong viện hình như lập trứ một khối tấm bia đá, mặt trên viết đích dĩ nhiên là \"Nơi đây vô ngân! !\""},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Mau đào lên xem có gì!"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Ôi chao, hình như xúc động liễu vật gì vậy! \n( một người kỳ quái đích thanh âm ) \"Lữ nhân a, muốn thu được bảo tàng phải đi cởi ra tất cả đích bộ phận then chốt. Nhắc nhở các ngươi, bộ phận then chốt đích thủ hộ thú thị rất trung thành đích.\""},
	{XoyoGame.ADD_NPC, 2, 1, 5, "guaiwu1", "40_jiguan_1"},
	{XoyoGame.ADD_NPC, 2, 1, 8, "guaiwu2", "40_jiguan_2"},
	{XoyoGame.ADD_NPC, 2, 1, 11, "guaiwu3", "40_jiguan_3"},
	{XoyoGame.ADD_NPC, 2, 1, 14, "guaiwu4", "40_jiguan_4"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu1", "40_kuangbaojiguanren_1"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu2", "40_kuangbaojiguanren_2"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu3", "40_kuangbaojiguanren_3"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu4", "40_kuangbaojiguanren_4"},
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.TARGET_INFO, -1, "Mở 4 cơ quan. Lưu ý, phải mở kịp thời, các quái bảo vệ sẽ liên tục xuất hiện."},
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 5, "guaiwu1", "40_jiguan_1"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 6, "jiguan1", "40_jiguan_1"},
	},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 5, 12, 0, "guaiwu", "40_kuangbaojiguanren_1. 0"},
	{XoyoGame.ADD_NPC, 5, 3, 0, "guaiwu", "40_kuangbaojiguanren_1"},
	{XoyoGame.BLACK_MSG, -1, "Hựu xuất hiện liễu một nhóm thủ vệ."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[7]:Close()"},
	{XoyoGame.DO_SCRIPT, "for i = 1, 30 do self. tbLock[10 + 8 * i]:Close() end"},
	},
	},
	[7] = {nTime = 15, nNum = 0,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan1"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.ADD_NPC, 2, 1, 17, "guaiwu1", "40_jiguan_1"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu1", "40_kuangbaojiguanren_1"},
	},
	},
	[8] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 9, "jiguan2", "40_jiguan_2"},
	},
	},
	[9] = {nTime = 0, nNum = 1,
	tbPrelock = {8},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 5, 12, 0, "guaiwu", "40_kuangbaojiguanren_2. 0"},
	{XoyoGame.ADD_NPC, 5, 3, 0, "guaiwu", "40_kuangbaojiguanren_2"},
	{XoyoGame.BLACK_MSG, -1, "Hựu xuất hiện liễu một nhóm thủ vệ."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[10]:Close()"},
	{XoyoGame.DO_SCRIPT, "for i = 1, 30 do self. tbLock[12 + 8 * i]:Close() end"},
	},
	},
	[10] = {nTime = 15, nNum = 0,
	tbPrelock = {8},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan2"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.ADD_NPC, 2, 1, 19, "guaiwu2", "40_jiguan_2"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu2", "40_kuangbaojiguanren_2"},
	},
	},
	[11] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 12, "jiguan3", "40_jiguan_3"},
	},
	},
	[12] = {nTime = 0, nNum = 1,
	tbPrelock = {11},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 5, 12, 0, "guaiwu", "40_kuangbaojiguanren_3. 0"},
	{XoyoGame.ADD_NPC, 5, 3, 0, "guaiwu", "40_kuangbaojiguanren_3"},
	{XoyoGame.BLACK_MSG, -1, "Hựu xuất hiện liễu một nhóm thủ vệ."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[13]:Close()"},
	{XoyoGame.DO_SCRIPT, "for i = 1, 30 do self. tbLock[14 + 8 * i]:Close() end"},
	},
	},
	[13] = {nTime = 15, nNum = 0,
	tbPrelock = {11},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan3"},
	{XoyoGame.DEL_NPC, "guaiwu3"},
	{XoyoGame.ADD_NPC, 2, 1, 21, "guaiwu3", "40_jiguan_3"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu3", "40_kuangbaojiguanren_3"},
	},
	},
	[14] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 15, "jiguan4", "40_jiguan_4"},
	},
	},
	[15] = {nTime = 0, nNum = 1,
	tbPrelock = {14},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 5, 12, 0, "guaiwu", "40_kuangbaojiguanren_4. 0"},
	{XoyoGame.ADD_NPC, 5, 3, 0, "guaiwu", "40_kuangbaojiguanren_4"},
	{XoyoGame.BLACK_MSG, -1, "Hựu xuất hiện liễu một nhóm thủ vệ."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[16]:Close()"},
	{XoyoGame.DO_SCRIPT, "for i = 1, 30 do self. tbLock[16 + 8 * i]:Close() end"},
	},
	},
	[16] = {nTime = 15, nNum = 0,
	tbPrelock = {14},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan4"},
	{XoyoGame.DEL_NPC, "guaiwu4"},
	{XoyoGame.ADD_NPC, 2, 1, 23, "guaiwu4", "40_jiguan_4"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu4", "40_kuangbaojiguanren_4"},
	},
	},
	},
	}
	for i = 1, 30 do
	tbRoom[40]. LOCK[9 + 8 * i] = {nTime = 0, nNum = 1,
	tbPrelock = {8 * i - 1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 6, "jiguan1", "40_jiguan_1"},
	},
	};
	tbRoom[40]. LOCK[10 + 8 * i] = {nTime = 15, nNum = 0,
	tbPrelock = {9 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan1"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.ADD_NPC, 2, 1, 17 + 8 * i, "guaiwu1", "40_jiguan_1"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu1", "40_kuangbaojiguanren_1"},
	},
	};
	tbRoom[40]. LOCK[11 + 8 * i] = {nTime = 0, nNum = 1,
	tbPrelock = {2 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 9, "jiguan2", "40_jiguan_2"},
	},
	};
	tbRoom[40]. LOCK[12 + 8 * i] = {nTime = 15, nNum = 0,
	tbPrelock = {11 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan2"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.ADD_NPC, 2, 1, 19 + 8 * i, "guaiwu2", "40_jiguan_2"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu2", "40_kuangbaojiguanren_2"},
	},
	};
	tbRoom[40]. LOCK[13 + 8 * i] = {nTime = 0, nNum = 1,
	tbPrelock = {5 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 12, "jiguan3", "40_jiguan_3"},
	},
	};
	tbRoom[40]. LOCK[14 + 8 * i] = {nTime = 15, nNum = 0,
	tbPrelock = {13 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan3"},
	{XoyoGame.DEL_NPC, "guaiwu3"},
	{XoyoGame.ADD_NPC, 2, 1, 21 + 8 * i, "guaiwu3", "40_jiguan_3"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu3", "40_kuangbaojiguanren_3"},
	},
	};
	tbRoom[40]. LOCK[15 + 8 * i] = {nTime = 0, nNum = 1,
	tbPrelock = {8 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 15, "jiguan4", "40_jiguan_4"},
	},
	};
	tbRoom[40]. LOCK[16 + 8 * i] = {nTime = 15, nNum = 0,
	tbPrelock = {15 + 8 * i},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan4"},
	{XoyoGame.DEL_NPC, "guaiwu4"},
	{XoyoGame.ADD_NPC, 2, 1, 23 + 8 * i, "guaiwu4", "40_jiguan_4"},
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu4", "40_kuangbaojiguanren_4"},
	},
	};
	end
	tbRoom[41] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {56288 / 32, 115680 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3281, nLevel = -1, nSeries =	-1},		-- tinh hoa
	[2] = {nTemplate = 3154, nLevel = -1, nSeries =	-1},		-- dã hầu
	[3] = {nTemplate = 3155, nLevel = -1, nSeries =	-1},		-- dã hầu
	[4] = {nTemplate = 3156, nLevel = -1, nSeries =	-1},		-- dã hầu
	[5] = {nTemplate = 3222, nLevel = -1, nSeries =	-1},		-- dã hầu vương
	[6] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 0, "baishe", "41_jinghua"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3281>: \"Tiều giá hoa đào khai đích, thực sự là mỹ a! Nhưng trên núi đích dã hầu môn hình như đã kiềm chế không được liễu, lão vây bắt nhà của ta đích cây đào đảo quanh, giúp ta đánh đuổi chúng nó.\""},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 6, 6, 0, "qinghua", "41_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "Đại chiến một hồi sau đó, cái khác hầu tử đều đã bị kinh hách đào trở về trên núi, không nghĩ tới chúng ta liên kỷ con khỉ đều thu thập không được, xấu hổ a."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 32,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "41_yehou_1"},
	{XoyoGame.ADD_NPC, 3, 2, 3, "guaiwu", "41_yehou_2"},
	{XoyoGame.ADD_NPC, 4, 28, 3, "guaiwu", "41_yehou_3"},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt 32 Khỉ Hoang"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {}
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 6, 0, "guaiwu", "41_yehou_4"},
	{XoyoGame.ADD_NPC, 5, 1, 4, "guaiwu", "41_houwang"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Khỉ Chúa"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3281>: \"Những ... này hầu tử đều là thụ na chích hầu vương chỉ thị đích, thuận lợi cũng đem đánh đuổi.\""}
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3281>: \"Các vị hạnh khổ liễu, lai nghỉ ngơi hạ, khảo sưởi ấm, tái đi phía trước đi đi ra liễu tiêu dao cốc đích sâu nhất chỗ.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "41_gouhuo"},
	}
	},
	},
	}
	tbRoom[42] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {61216 / 32, 114016 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3268, nLevel = -1, nSeries = -1},		-- hương ngọc tiên
	[2] = {nTemplate = 3191, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang
	[3] = {nTemplate = 3159, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt phủ thủ
	[4] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- hoàn mỹ bộ phận then chốt cự lang
	[5] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước cái kia... Chẳng lẽ là? Người gặp người thích, hoa gặp hoa nở đích hương ngọc tiên?"},
	{XoyoGame.ADD_NPC, 1, 1, 2, "husong", "42_xiangyuxian"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 5, 6, 0, "qinghua", "42_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 1,		-- 4 phút nội hoặc mục tiêu tử vong
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "Hương ngọc tiên dĩ bản thân bị trọng thương ngẩn ra liễu, chúng ta cũng chính tốc tốc thoát đi nơi đây ba"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3268>: nghe nói nơi đây hữu một năng làm ra hoàn mỹ bộ phận then chốt thú đích thiên tài, vốn định lai tiếp hắn một chút, lại không nghĩ rằng hắn đích bộ phận then chốt thú như vậy hung hãn... Tiền phương có tòa nhà dân, các ngươi năng tống ta đáo na nhượng ta liệu hạ thương mạ?"},
	{XoyoGame.ADD_NPC, 2, 16, 0, "guaiwu", "42_jiguanjulang"},		-- xoát quái
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Hộ tống thời gian còn %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Hương Ngọc Tiên đến khu dân cư chữa bệnh"},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv4_42_xiangyuxian", 4, 100, 1, 1},	-- Hộ tống AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[5] = {nTime = 480, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[6]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.MOVIE_DIALOG, -1, "Những ... này bộ phận then chốt thú vô cùng hung hãn! Chúng ta chính tốc tốc thoát đi nơi đây."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[6] = {nTime = 0, nNum = 16,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Hựu toát ra một đống bộ phận then chốt lang, bắt bọn nó toàn bộ thanh lý điệu ba!"},
	{XoyoGame.ADD_NPC, 2, 14, 6, "guaiwu1", "42_jiguanjulang"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 2, 6, "guaiwu1", "42_jiguanjulang"},		-- xoát quái
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 5},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt tất cả Cơ Quan Cự Lang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Rốt cục đối phó liễu những ... này bộ phận then chốt lang, thực sự là một hồi ác chiến a, làm ra những ... này quỷ đông tây đích nhân rốt cuộc thị thần thánh phương nào ni?"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "42_jiguanjulang"},
	},
	},
	}
	}
	tbRoom[43] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {64768 / 32, 116832 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3189, nLevel = -1, nSeries = -1},		-- bộ phận then chốt cự lang 1
	[2] = {nTemplate = 3190, nLevel = -1, nSeries = -1},		-- bộ phận then chốt cự lang 2
	[3] = {nTemplate = 3191, nLevel = -1, nSeries = -1},		-- bộ phận then chốt cự lang 3
	[4] = {nTemplate = 3154, nLevel = -1, nSeries =	-1},		-- dã hầu 1
	[5] = {nTemplate = 3155, nLevel = -1, nSeries =	-1},		-- dã hầu 2
	[6] = {nTemplate = 3156, nLevel = -1, nSeries =	-1},		-- dã hầu 3
	[7] = {nTemplate = 3259, nLevel = -1, nSeries =	-1},		-- dã quả bộ phận then chốt
	[8] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này phong cảnh tú lệ, chân gọi người lưu luyến vong phản a."},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 8, 6, 0, "qinghua", "43_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	},
	[2] = {nTime = 480, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Ghê tởm, một khí lực liễu, chỉ có thể mắt mở trừng trừng nhìn chết tiệt hầu tử đào tẩu. Chân không cam lòng!"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 300, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 2, 4, "guaiwu", "43_jiguanjulang_1"},
	{XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "43_jiguanjulang_2"},
	{XoyoGame.ADD_NPC, 3, 24, 4, "guaiwu", "43_jiguanjulang_3"},
	{XoyoGame.MOVIE_DIALOG, -1, "Chết tiệt! Này bộ phận then chốt vật hựu xuất hiện liễu, vì sao luôn âm hồn không tiêu tan ni? Chẳng lẽ là gần nhất chuyện xấu tố hơn? ?"},
	{XoyoGame.TARGET_INFO, -1, "Trong 5 phút tiêu diệt 28 Cơ Quan Cự Lang"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 3},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Ghê tởm, những ... này bộ phận then chốt vật quá cường hãn liễu! Cũng không biết tạo liễu cái gì nghiệt, thật là!"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[4] = {nTime = 0, nNum = 28,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tại tiêu dao trong cốc đi lâu như vậy, mệt mỏi, món bao tử cũng đói bụng. Tại phụ cận hoa điểm dã quả ha ha."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[5] = {nTime = 60, nNum = 0,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 7, 1, 6, "jiguan", "43_yeguo"},
	{XoyoGame.TARGET_INFO, -1, "Hái 1 Trái Dại"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[6]:Close()"},
	},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	},
	},
	[7] = {nTime = 0, nNum = 14,
	tbPrelock = {{5, 6}},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 7, "guaiwu", "43_yehou_1"},
	{XoyoGame.ADD_NPC, 5, 1, 7, "guaiwu", "43_yehou_2"},
	{XoyoGame.ADD_NPC, 6, 12, 7, "guaiwu", "43_yehou_3"},
	{XoyoGame.BLACK_MSG, -1, "Một đám hầu tử đoạt đi rồi chúng ta đích trái cây, ghê tởm, cần phải giáo huấn một chút chúng nó."},
	{XoyoGame.TARGET_INFO, -1, "Dạy lũ Khỉ Hoang 1 bài học"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đuổi đi ghê tởm đích hầu tử, cầm lại liễu trái cây. Lần này đích tao ngộ thật khiến cho người ta không hờn giận. Hảo hảo nghỉ ngơi hạ, chuẩn bị kế tục đi tới."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "43_yeguo"},
	},
	},
	}
	}
	tbRoom[44] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {60576 / 32, 130688 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3189, nLevel = -1, nSeries = -1},		-- bộ phận then chốt cự lang
	[2] = {nTemplate = 3190, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang
	[3] = {nTemplate = 3191, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang
	[4] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang boss
	[5] = {nTemplate = 3289, nLevel = -1, nSeries =	-1},		-- tấm bia đá
	[6] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Không nghĩ tới trong cốc còn có như vậy quy mô to đích ngầm cung điện... Bốn phía liên một quỷ ảnh cũng không có, xem ra phải cẩn thận hành động mới được."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 6, 6, 0, "qinghua", "44_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng thời gian
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "Những ... này quỷ đông tây hung mãnh không gì sánh được, chính tốc tốc ly khai nơi đây tuyệt vời."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 12,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Hai khối tấm bia đá trống rỗng xuất hiện, hữu cần phải tiên điều tra một chút."},
	{XoyoGame.ADD_NPC, 5, 1, 4, "jiguan", "44_shibei_1"},		-- tấm bia đá
	{XoyoGame.ADD_NPC, 5, 1, 5, "jiguan", "44_shibei_2"},		-- tấm bia đá
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Khảo sát bia đá"},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 1, 6, 3, "guaiwu", "44_jiguanjulang_1"},		-- bộ phận then chốt cự lang
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 6, 3, "guaiwu", "44_jiguanjulang_2"},		-- bộ phận then chốt cự lang
	},
	},
	[6] = {nTime = 0, nNum = 0,
	tbPrelock = {4,5},
	tbStartEvent =
	{
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt tất cả Cơ Quan Cự Lang"},
	},
	tbUnLockEvent = {},
	},
	[7] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Địa cung trung truyền đến một tiếng nổ, tựa hồ hữu càng hung mãnh đích quái vật xuất hiện liễu..."},
	{XoyoGame.ADD_NPC, 3, 20, 0, "guaiwu", "44_jiguanjulang_3"},		-- bộ phận then chốt cự lang
	{XoyoGame.ADD_NPC, 4, 1, 7, "guaiwu", "44_wanmeidejiguanjulang"},		-- Cơ Quan Cự Lang Hoàn Mỹ
	{XoyoGame.TIME_INFO, -1, "<color=green> thặng dư thời gian %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt Cơ Quan Cự Lang Hoàn Mỹ"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "Kinh qua một hồi ác chiến, rốt cục Đánh bại liễu giá kinh khủng đích cự thú. Chỉnh lý một chút hành trang, chuẩn bị nghênh tiếp tối hậu đích khiêu chiến."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "44_gouhuo"},
	},
	},
	},
	}
	tbRoom[45] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {61760 / 32, 132864 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3280, nLevel = -1, nSeries = -1},		-- thôi âu
	[2] = {nTemplate = 3260, nLevel = -1, nSeries = -1},		-- trong bảo khố tương bộ phận then chốt
	[3] = {nTemplate = 3261, nLevel = -1, nSeries = -1},		-- chân trong bảo khố tương
	[4] = {nTemplate = 3298, nLevel = -1, nSeries = -1},		-- bộ phận then chốt 1
	[5] = {nTemplate = 3299, nLevel = -1, nSeries = -1},		-- bộ phận then chốt 2
	[6] = {nTemplate = 3300, nLevel = -1, nSeries = -1},		-- bộ phận then chốt 3
	[7] = {nTemplate = 3192, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt nhân bạo thương tổn
	[8] = {nTemplate = 3193, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt nhân bắn ngược
	[9] = {nTemplate = 3194, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt nhân phổ thông
	[10] = {nTemplate = 3176, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt người kiếm đoạn
	[11] = {nTemplate = 3256, nLevel = -1, nSeries =	-1},		-- cản trở
	[12] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt lang
	[13] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 2, "husong", "45_cuixiaoou"},		-- thôi âu
	{XoyoGame.ADD_NPC, 11, 6, 0, "tiezha", "45_zhangai"},		-- cản trở
	{XoyoGame.CHANGE_TRAP, "45_trap", {63232 / 32, 134336 / 32}},
	{XoyoGame.MOVIE_DIALOG, -1, "Giá âm trầm đích địa cung trung cư nhiên hữu một tiểu cô nương! Thái quỷ dị liễu."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 13, 6, 0, "qinghua", "45_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 1,		-- tổng thời gian
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: oa... Ở đây thật đáng sợ! Ba ba mụ mụ, tiểu âu không dám chạy loạn liễu, tiểu âu phải về gia..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,		-- nhiệm vụ bắt đầu
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: nghe nói phương diện này có rất nhiều hảo đồ chơi, ca ca tỷ tỷ, các ngươi năng theo ta cùng nhau ngoạn hội mạ?"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TARGET_INFO, -1, "Chơi cùng Thúy Tiểu Âu"},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,		--	Bắt đầu Hộ tống
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv4_45_cuixiaoou_1", 4, 0, 1},	-- Hộ tống AI
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: a, bên kia hữu tốt kỳ quái đích tượng đá! Ca ca tỷ tỷ, các ngươi khứ điều tra một chút."},
	{XoyoGame.ADD_NPC, 4, 1, 5, "jiguan", "45_jiguan_1"},		-- bộ phận then chốt 1
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 9, 12, 6, "guaiwu", "45_jiguanren_1"},		-- bộ phận then chốt nhân
	},
	},
	[6] = {nTime = 0, nNum = 12,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "tiezha"},
	{XoyoGame.CHANGE_TRAP, "45_trap", nil},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: ca ca tỷ tỷ thật là lợi hại oa! Cửa sắt mở da, kế tục đi thôi."},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv4_45_cuixiaoou_2", 7, 0, 1},	-- Hộ tống AI
	},
	},
	[7] = {nTime = 0, nNum = 1,
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: di? Phát hiện bảo tàng lạc! Ca ca tỷ tỷ nhanh đi mở."},
	{XoyoGame.ADD_NPC, 2, 1, 8, "jiguan", "45_baoxiang_2"},		-- trong bảo khố tương
	{XoyoGame.ADD_NPC, 3, 2, 16, "jiguan", "45_kongbaoxiang_2"},		-- khoảng không trong bảo khố tương
	},
	},
	[8] = {nTime = 0, nNum = 1,
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 9, 6, 9, "guaiwu", "45_jiguanren_2"},		-- bộ phận then chốt nhân
	{XoyoGame.ADD_NPC, 7, 2, 9, "guaiwu", "45_jiguanren_2_bao"},		-- bộ phận then chốt nhân
	},
	},
	[9] = {nTime = 0, nNum = 8,
	tbPrelock = {8},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: nguyên lai là bẩy rập... Hù chết tiểu âu liễu. Ca ca tỷ tỷ, các ngươi một thụ thương ba?"},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv4_45_cuixiaoou_3", 10, 0, 1},	-- Hộ tống AI
	},
	},
	[10] = {nTime = 0, nNum = 1,
	tbPrelock = {9},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: a? Lại có một người kỳ quái đích pho tượng! Ca ca tỷ tỷ, các ngươi dám đi điều tra sao?"},
	{XoyoGame.ADD_NPC, 5, 1, 11, "jiguan", "45_jiguan_2"},		-- bộ phận then chốt 2
	},
	},
	[11] = {nTime = 0, nNum = 1,
	tbPrelock = {10},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 9, 10, 12, "guaiwu", "45_jiguanren_3"},		-- bộ phận then chốt nhân
	{XoyoGame.ADD_NPC, 8, 2, 12, "guaiwu", "45_jiguanren_3_fandan"},		-- bộ phận then chốt nhân
	},
	},
	[12] = {nTime = 0, nNum = 12,
	tbPrelock = {11},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: ca ca các tỷ tỷ thật mạnh a! Càng làm những ... này quái đông tây thu thập liễu. (*^__^*) hì hì..."},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv4_45_cuixiaoou_4", 13, 0, 1},	-- Hộ tống AI
	},
	},
	[13] = {nTime = 0, nNum = 1,
	tbPrelock = {12},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: a? Hình như đáo đầu cùng liễu, bàn đánh bóng bàn thượng lại có một kỳ quái đích pho tượng da..."},
	{XoyoGame.ADD_NPC, 6, 1, 14, "jiguan", "45_jiguan_shibei"},		-- bộ phận then chốt 2
	},
	},
	[14] = {nTime = 0, nNum = 1,
	tbPrelock = {13},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 12, 1, 15, "guaiwu", "45_jiguanjulang"},		-- bộ phận then chốt lang
	{XoyoGame.ADD_NPC, 10, 3, 0, "guaiwu", "45_jiguanren_4"},		-- bộ phận then chốt nhân
	},
	},
	[15] = {nTime = 0, nNum = 1,
	tbPrelock = {14},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3280>: da! Ca ca tỷ tỷ, các ngươi quá tuyệt vời! A? Phải về gia liễu, không phải sẽ bị mụ mụ mạ đích. Ca ca tỷ tỷ lần sau muốn tới nhà của ta làm khách nga."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "45_gouhuo"},
	},
	},
	[16] = {nTime = 0, nNum = 2,
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	},
	}
	--
	tbRoom[46] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {66624 / 32, 131904 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3265, nLevel = -1, nSeries = -1},		-- Hộ tống NPC
	[2] = {nTemplate = 3256, nLevel = -1, nSeries =	-1},		-- cản trở
	[3] = {nTemplate = 3252, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[4] = {nTemplate = 3253, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[5] = {nTemplate = 3192, nLevel = -1, nSeries =	-1},		-- cuồng bạo bộ phận then chốt nhân _ bạo thương tổn
	[6] = {nTemplate = 3194, nLevel = -1, nSeries =	-1},		-- cuồng bạo bộ phận then chốt nhân _ phổ thông
	[7] = {nTemplate = 3189, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang _ cao tốc vô hình cổ
	[8] = {nTemplate = 3190, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang _ lôi trận
	[9] = {nTemplate = 3191, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt cự lang _ phổ thông
	[10] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 2, "husong", "46_xiaofei"},
	{XoyoGame.ADD_NPC, 2, 3, 0, "zhangai1", "46_luzhang"},
	{XoyoGame.CHANGE_TRAP, "46_trap", {64320 / 32, 132320 / 32}},
	{XoyoGame.MOVIE_DIALOG, -1, "Mơ hồ nghe thế địa cung trung hữu thiếu nữ đích cầu cứu thanh, không biết có đúng hay không ảo giác, tạm thời quá khứ nhìn."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 10, 6, 0, "qinghua", "46_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: ... ... ... ..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 2,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Nhân gia thật vất vả mới từ tuyết sơn trốn tới, không nghĩ tới lại bị nhốt tại giá liễu, những ... này bộ phận then chốt nhân thật đáng sợ. Ô... Ta cũng không tưởng trở thành lý đích một đống bạch cốt oa... Các ngươi khoái bang giúp ta.\""},
	{XoyoGame.ADD_NPC, 3, 1, 3, "jiguan", "46_shibei_1"},				-- bộ phận then chốt
	{XoyoGame.ADD_NPC, 4, 1, 3, "jiguan", "46_shibei_2"},				-- bộ phận then chốt
	{XoyoGame.ADD_NPC, 5, 12, 0, "guaiwu", "46_kuangbaojiguanren"},		-- quái vật
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Giải cứu Hiểu Phi bị mắc kẹt"},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Cửa sắt tiêu thất, nhanh lên ly khai địa phương quỷ quái này.\""},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv4_46_xiaofei", 4, 100, 1},	-- Hộ tống AI
	{XoyoGame.DEL_NPC, "zhangai1"},
	{XoyoGame.ADD_NPC, 8, 28, 0, "guaiwu", "46_jiguanjulang"},		-- quái vật
	{XoyoGame.CHANGE_TRAP, "46_trap", nil},
	{XoyoGame.TARGET_INFO, -1, "Bảo vệ Hiểu Phi"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3265>: \"Các ngươi thực sự là hảo tâm nhân, nghe nói tái đi phía trước đi hay tiêu dao cốc đích sâu nhất chỗ, không biết có hay không cơ hội nhìn thấy trong truyền thuyết anh tuấn tiêu sái đích cốc chủ ni, đi trước một bước liễu yêu.\" \n nói xong, vị này liều lĩnh đích tiểu thư hựu chẳng chạy đến địa phương nào đi..."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "46_gouhuo"},
	},
	},
	}
	}
	tbRoom[47] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {65088 / 32, 135744 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3182, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm _ di động khoái
	[2] = {nTemplate = 3185, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm _ toàn bộ bình hồi huyết
	[3] = {nTemplate = 3183, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm _ phổ thông
	[4] = {nTemplate = 3188, nLevel = -1, nSeries =	-1},		-- Thủ Lĩnh Sấm Cốc Tặc
	[5] = {nTemplate = 3291, nLevel = -1, nSeries =	-1},		-- sấm cốc kẻ trộm _ phổ thông
	[6] = {nTemplate = 3292, nLevel = -1, nSeries =	-1},		-- Thủ Lĩnh Sấm Cốc Tặc
	[7] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- Cơ Quan Cự Lang Hoàn Mỹ
	[8] = {nTemplate = 3261, nLevel = -1, nSeries =	-1},		-- trong bảo khố tương
	[9] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Cư nhiên tìm được rồi địa cung trung đích bảo tàng khố, bất quá hình như đã có người nhanh chân đến trước liễu, tiên giáo huấn một chút bọn người kia ba!"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 9, 6, 0, "qinghua", "47_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.DEL_NPC, "guaiwu3"},
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[9]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "Những ... này quỷ đông tây hung mãnh không gì sánh được, chính tốc tốc ly khai nơi đây tuyệt vời."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 20,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 3, "guaiwu", "47_chuangguzei_1"},
	{XoyoGame.ADD_NPC, 2, 1, 3, "guaiwu", "47_chuangguzei_2"},
	{XoyoGame.ADD_NPC, 3, 18, 3, "guaiwu", "47_chuangguzei_3"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 20 Sấm Cốc Tặc"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	tbUnLockEvent = {}
	},
	[4] = {nTime = 0, nNum = 2,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tòng địa cung thâm nhập truyền đến đã đấu đích thanh âm, tiền phương chắc chắn kỳ hoặc, quá khứ nhìn."},
	{XoyoGame.ADD_NPC, 5, 8, 10, "guaiwu2", "47_chuangguzei_4"},
	{XoyoGame.ADD_NPC, 6, 2, 10, "guaiwu3", "47_chuangguzeitouling"},
	{XoyoGame.ADD_NPC, 7, 2, 4, "guaiwu", "47_wanmeidejiguanjulang"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Cơ Quan Cự Lang Hoàn Mỹ"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2", XoyoGame.AI_ATTACK, "", 0},	-- cải biến trận doanh AI
	{XoyoGame.CHANGE_NPC_AI, "guaiwu3", XoyoGame.AI_ATTACK, "", 0},	-- cải biến trận doanh AI
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3292>: \"Mấy đại hiệp thực sự là trượng nghĩa! Hành tẩu giang hồ, là tối trọng yếu hay một người \"<color=gold> nghĩa <color>\" tự, ở đây đích trong bảo khố tương sẽ để lại cho các ngươi làm tạ ơn lễ. Các huynh đệ, mau ra đây cảm tạ mấy ân nhân cứu mạng!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 4, 150, "gouhuo", "47_gouhuo"},
	},
	},
	[5] = {nTime = 0, nNum = 0,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 8, 6, 0, "jiguan", "47_baoxiang"},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 3, nNum = 0,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 6, 10, "guaiwu2", "47_chuangguzei_5"},
	{XoyoGame.ADD_NPC, 3, 6, 10, "guaiwu2", "47_chuangguzei_5"},
	{XoyoGame.ADD_NPC, 6, 2, 10, "guaiwu3", "47_chuangguzei_5"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2", XoyoGame.AI_ATTACK, "", 0},	-- cải biến trận doanh AI
	{XoyoGame.CHANGE_NPC_AI, "guaiwu3", XoyoGame.AI_ATTACK, "", 0},	-- cải biến trận doanh AI
	},
	},
	[7] = {nTime = 3, nNum = 0,
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	[8] = {nTime = 8, nNum = 0,
	tbPrelock = {7},
	tbStartEvent =
	{
	{XoyoGame.SEND_CHAT, "guaiwu2", "Tạ ơn đại hiệp ân cứu mạng!"},
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 0, nNum = 0,
	tbPrelock = {8},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Kẻ trộm nói đều có thật không! Không biết hành tẩu giang hồ là tối trọng yếu thị một người \"<color=gold> trá <color>\" tự sao?"},
	{XoyoGame.SEND_CHAT, "guaiwu3", "Khẽ thôi! Đánh bại chúng!"},
	{XoyoGame.TARGET_INFO, -1, "Nguy hiêm! Đánh bại tất cả bọn cướp!"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2", XoyoGame.AI_ATTACK, "", 5},	-- cải biến trận doanh AI
	{XoyoGame.CHANGE_NPC_AI, "guaiwu3", XoyoGame.AI_ATTACK, "", 5},	-- cải biến trận doanh AI
	},
	},
	[10] = {nTime = 0, nNum = 24,
	tbPrelock = {9},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đi ra đi giang hồ thực sự là đại ý không được a!"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	},
	},
	}
	}
	-- PK gian phòng
	tbRoom[48] =
	{
	fnPlayerGroup 	= BaseRoom. PKGroup,			-- PK phân tổ
	fnDeath			= BaseRoom. PKDeath,			-- PK gian phòng tử vong kịch bản gốc;
	fnWinRule		= BaseRoom. PKWinRule,		-- PK thắng lợi điều kiện
	nRoomLevel		= 1,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 1,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {{65696/32, 121984/32}, {65600/32, 122144/32}},-- lúc đầu điểm,
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đối diện tựa hồ cũng là đối tiêu dao cốc tràn ngập lòng hiếu kỳ đích nhân, cũng không biết bọn họ đích công phu thế nào, đi thử hắn thử một lần."},
	{XoyoGame.TIME_INFO, -1, "<color=green> ly khai thủy PK thặng dư thời gian %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, "Địch quân đánh bại bên ta thành viên sổ: 0\n bên ta đánh bại địch quân thành viên sổ: 0"},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 480, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>PK thặng dư thời gian %s<color>", 2},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_CAMP},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self:CheckWinner()"},		-- thủ động phán thắng bại
	{XoyoGame.DO_SCRIPT, "self:TeamBlackMsg(self. tbWinner, 'Xem ra chính chúng ta đội ngũ kỹ cao một bậc a ')"};
	{XoyoGame.DO_SCRIPT, "self:TeamBlackMsg(self. tbLoser, 'Đối phương thực lực quá mạnh mẽ, chúng ta chính khoái lưu ba ')"};
	},
	},
	}
	}
	-- trong bảo khố tương gian phòng
	tbRoom[49] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {65696 / 32, 121984 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3261, nLevel = -1, nSeries = -1},		-- cái rương
	[2] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bảo tàng! Ha ha! Rốt cục nhượng chúng ta tìm được rồi! Bất quá... Còn giống như hữu những người khác cũng tìm được rồi ở đây..."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 2, 6, 0, "qinghua", "49_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nghỉ ngơi tốt liễu, chuẩn bị nghênh tiếp tiếp theo tràng khiêu chiến."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbTeam[2]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	},
	},
	[3] = {nTime = 0, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "49_baoxiang"},
	{XoyoGame.TARGET_INFO, -1, "Mở rương báu"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 120, nNum = 0,
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "49_baoxiang"},
	},
	},
	[5] = {nTime = 120, nNum = 0,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "49_baoxiang"},
	},
	},
	[6] = {nTime = 120, nNum = 0,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "49_baoxiang"},
	},
	},
	[7] = {nTime = 60, nNum = 0,
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "49_baoxiang"},
	},
	},
	}
	}
	tbRoom[50] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {61312 / 32, 121920 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3243, nLevel = 1, nSeries =	-1},		-- thỏ
	[2] = {nTemplate = 3244, nLevel = -1, nSeries =	4},		-- hạ tiểu thiến
	[3] = {nTemplate = 3241, nLevel = -1, nSeries =	1},		-- mộc siêu
	[4] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thật lớn một gian nông trại, chắc là một nhà giàu nhân gia, bất quá chủ nhân đi đâu rồi ni?"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 4, 6, 0, "qinghua", "50_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "boss"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3244>: \"Quên đi... Hỏa cũng phát qua, cái cũng đánh, để kỷ chích thỏ một cần phải làm ra mạng người. Ta đi ngọn núi tái trảo hai lai, các ngươi tự giải quyết cho tốt.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 60, nNum = 0,		-- tính theo thời gian xoát boss
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3244>: \"Các ngươi là ai? Tưởng đối ta đích thỏ thỏ làm gì?\""}
	},
	},
	[4] = {nTime = 0, nNum = 6,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong viện bính ra kỷ chích thỏ, nhìn qua thập phần màu mỡ, vị đạo nhất định không sai! Sấn chủ nhân không ở, len lén săn kỷ chích tiên"},
	{XoyoGame.ADD_NPC, 1, 6, 4, "guaiwu", "50_tuzi"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Lộng điểm thỏ thịt điền đầy bụng"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3244>: \"Các ngươi là ai? Cư nhiên liên như thế khả ái đích thỏ thỏ đều hạ thủ được! Thái ghê tởm liễu!\""},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {{3,4}},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 5, "boss", "50_xiaxiaoqian"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Hạ Tiểu Sảnh"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "boss"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3244>: vì sao... Vì sao... Muốn đả thương hại ta đích con thỏ nhỏ..."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[6]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "50_gouhuo"},
	},
	},
	[6] = {nTime = 100, nNum = 0,		-- tính theo thời gian sửa trận doanh
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3244>: \"Mệt mỏi quá a, nghỉ ngơi một hồi tiên o(∩_∩)o. . .\""},
	{XoyoGame.CHANGE_NPC_AI, "boss", XoyoGame.AI_ATTACK, "", 0},	-- cải biến trận doanh AI
	},
	},
	[7] = {nTime = 15, nNum = 0,		-- tính theo thời gian đối thoại
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3241>: \"Thiến thiến, yêm cho ngươi tống nguyên tiêu tới.\" \n<npc=3244>: \"Siêu ca, có người khi dễ ta! !\" \n<npc=3241>: \"Hắc! Người nào lớn như vậy đảm! ! Không muốn sống?\""},
	{XoyoGame.ADD_NPC, 3, 1, 0, "boss", "50_xiaxiaoqian"},
	{XoyoGame.CHANGE_NPC_AI, "boss", XoyoGame.AI_ATTACK, "", 0},	-- cải biến trận doanh AI
	},
	},
	[8] = {nTime = 5, nNum = 0,		-- tính theo thời gian sửa trận doanh
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "boss", XoyoGame.AI_ATTACK, "", 5},	-- cải biến trận doanh AI
	},
	},
	}
	}
	tbRoom[51] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {61056 / 32, 142176 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3245, nLevel = -1, nSeries =	3},		-- hồ khôn
	[2] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- hoàn mỹ bộ phận then chốt lang
	[3] = {nTemplate = 3190, nLevel = -1, nSeries =	-1},		-- kịch độc bộ phận then chốt lang
	[4] = {nTemplate = 3302, nLevel = -1, nSeries =	-1},		-- hồ khôn phân thân
	[5] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Một cổ cường liệt đích sát khí trước mặt phác lai, xem ra tiền phương tuyệt không sẽ có cái gì hảo vai đang chờ chúng ta."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 5, 6, 0, "qinghua", "51_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3245>: \"Không nghĩ tới các ngươi tựu điểm ấy năng lực, bất cùng các ngươi chơi... Ảnh độn!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 60, nNum = 0,		-- xoát quái
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1	, "Hồ khôn: \"Giết chóc ba! Ta đích kiệt tác!\""},
	{XoyoGame.ADD_NPC, 2, 4, 0, "fenshen", "51_xiaobin"},
	},
	},
	[4] = {nTime = 30, nNum = 0,		-- san quái
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "fenshen"},
	},
	},
	[5] = {nTime = 240, nNum = 0,		-- xoát quái
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Hồ khôn: \"Cấm thuật! Ảnh phân thân!\""},
	{XoyoGame.ADD_NPC, 4, 4, 0, "fenshen2", "51_xiaobin"},
	},
	},
	[6] = {nTime = 20, nNum = 0,		-- san quái
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "fenshen2"},
	},
	},
	[7] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3245>: \"Năng đi tới ở đây, chứng minh các ngươi điều không phải hời hợt hạng người. Đến đây đi! Nhượng ta đem bọn ngươi đích thân thể cải tạo thành kiệt xuất nhất đích tác phẩm ba!\""},
	{XoyoGame.ADD_NPC, 1, 1, 7, "guaiwu", "51_hukun"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Hồ Khôn"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3245>: \"Ghê tởm... Chẳng lẽ là ta đích tác phẩm còn chưa đủ hoàn mỹ... Chờ coi! Lần sau muốn cho các ngươi kiến thức đáo chân chính đích kinh khủng... Cấm thuật! Ảnh độn!\" \n trong nháy, cái này thần bí đích cuồng đồ dĩ bỏ chạy vô tung... Đã trải qua một hồi ác chiến đích chúng ta chính tiên nghỉ ngơi nghỉ ngơi, khảo sưởi ấm."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	{XoyoGame.DEL_NPC, "fenshen"},
	{XoyoGame.DEL_NPC, "fenshen2"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "51_gouhuo"},
	},
	},
	}
	}
	-- đẳng cấp 5 gian phòng
	-- 52, 54
	tbRoom[52] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50080 / 32, 105984 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3195, nLevel = -1, nSeries = -1},		-- quân viễn chinh
	[2] = {nTemplate = 3196, nLevel = -1, nSeries =	-1},		-- quân viễn chinh
	[3] = {nTemplate = 3197, nLevel = -1, nSeries =	-1},		-- đốc quân
	[4] = {nTemplate = 3246, nLevel = -1, nSeries =	-1},		-- giám quân
	[5] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Người này hoàn cảnh không sai, thị một nghỉ ngơi thật là tốt địa phương."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 5, 6, 0, "qinghua", "52_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Đốc quân: \"Sưu, cho ta tỉ mỉ đích sưu! Nhất định phải tìm được trong truyền thuyết đích ma thương! Cái gì? Phía trước có nhân? Trảo nhiều hỏi một chút!\""}
	},
	},
	[2] = {nTime = 600, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Giám quân: \"Cái gì, điều tra đội bên kia hữu ma thương đích đầu mối! Toán các ngươi vận khí tốt, ngày hôm nay hãy bỏ qua các ngươi. Các huynh đệ, triệt!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 34,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 4, 3, "guaiwu", "52_yuanzhengjun_1"},
	{XoyoGame.ADD_NPC, 2, 26, 3, "guaiwu", "52_yuanzhengjun_2"},
	{XoyoGame.ADD_NPC, 4, 4, 3, "guaiwu", "52_dujun"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 30 Quân Viễn Chinh, 4 Đốc quân"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 4, "guaiwu", "52_jianjun"},
	{XoyoGame.MOVIE_DIALOG, -1, "Giám quân: \"Đồ vô dụng, mấy người mao kẻ trộm đều cảo bất định! Cần phải yếu bổn đại gia tự mình động thủ sao!\""},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Giám Quân"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "52_gouhuo"},
	{XoyoGame.MOVIE_DIALOG, -1, "Giám quân: \"Các ngươi giá đàn mao kẻ trộm, dám tại động thủ trên đầu thái tuế, lá gan không nhỏ. Các ngươi chờ, xem ta sau đó thế nào thu thập các ngươi!\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	},
	}
	},
	}
	tbRoom[54] = {}
	CopyTable(tbRoom[52], tbRoom[54])
	tbRoom[54]. tbBeginPoint	= {43776 / 32, 89024 / 32};
	tbRoom[54]. LOCK[3]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 1, 4, 3, "guaiwu", "54_yuanzhengjun_1"};
	tbRoom[54]. LOCK[3]. tbStartEvent[2] = {XoyoGame.ADD_NPC, 2, 26, 3, "guaiwu", "54_yuanzhengjun_2"};
	tbRoom[54]. LOCK[3]. tbStartEvent[3] = {XoyoGame.ADD_NPC, 4, 4, 3, "guaiwu", "54_dujun"};
	tbRoom[54]. LOCK[4]. tbStartEvent[1] = {XoyoGame.ADD_NPC, 3, 1, 4, "guaiwu", "54_jianjun"};
	tbRoom[54]. LOCK[4]. tbUnLockEvent[1] = {XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "54_gouhuo"};
	tbRoom[53] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {45856 / 32, 95360 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3204, nLevel = -1, nSeries = -1},		-- bộ khoái
	[2] = {nTemplate = 3205, nLevel = -1, nSeries =	-1},		-- vũ trang bộ khoái
	[3] = {nTemplate = 3208, nLevel = -1, nSeries =	-1},		-- tầm bảo người (Hộ tống )
	[4] = {nTemplate = 3260, nLevel = -1, nSeries =	-1},		-- trong bảo khố tương bộ phận then chốt
	[5] = {nTemplate = 3206, nLevel = -1, nSeries =	-1},		-- truy tung người
	[6] = {nTemplate = 3207, nLevel = -1, nSeries =	-1},		-- tầm bảo người ( chiến đấu )
	[7] = {nTemplate = 3318, nLevel = 35, nSeries =	-1},		-- trong bảo khố tương
	[8] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 10, "husong", "53_xunbaozhe_husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3208>: các ngươi cũng không thể được không nên đột nhiên xuất hiện a, thiếu chút nữa một bị thủy cấp ế tử. Ai, kế tục uống nước."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 8, 6, 0, "qinghua", "53_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 600, nNum = 0,   -- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Giá thế đạo biến hóa cũng thắc lớn. Chúng ta đều tại đây trên giang hồ lăn lộn lâu như vậy liễu, dĩ nhiên liên điểm ấy sự đều tố bất hảo. Ai! Đây là cái gì giang hồ a!"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3208>: chúng ta gặp nhau hay duyên phận nột. Đã có duyên phận tựu làm phiền các vị tống ta đáo tiền phương đích đình na nghỉ ngơi hạ ba, phải biết rằng ta tại cốc lý cũng đi thật lâu liễu."},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 15, 0, "guaiwu3", "53_guaiwu_1"},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv5_53_xunbaozhe_1", 4, 100, 0},	-- Hộ tống AI
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Tầm Bảo Giả"},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 5, nNum = 0,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3208>: ta phát hiện tiền phương đích bãi đất thượng hữu cái rương, nói không chừng bên trong hữu bảo tàng nga, các ngươi có muốn hay không cũng cùng đi nhìn a."},
	{XoyoGame.TARGET_INFO, -1, "Bảo vệ Tầm Bảo Giả"},
	},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 8, 0, "guaiwu4", "53_guaiwu_2"},
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv5_53_xunbaozhe_2", 6, 100, 0},
	},
	tbUnLockEvent = {},
	},
	[7] = {nTime = 0, nNum = 1,
	tbPrelock = {6},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 7, "jiguan", "53_jiguan"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3208>: các vị, ta thực sự đi không đặng, phiền phức các ngươi đi xem trong rương mặt chứa cái gì."},
	{XoyoGame.TARGET_INFO, -1, "Mở rương"},
	},
	tbUnLockEvent = {},
	},
	[8] = {nTime = 0, nNum = 2,
	tbPrelock = {7},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 2, 8, "guaiwu", "53_boss"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3206>: thái, buông các ngươi trong tay đích thánh vật! ! Các ngươi giá đàn cường đạo, chuẩn bị cho tốt chịu chết đi! !"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 2 Truy Tông Giả"},
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 0, nNum = 1,
	tbPrelock = {8},
	tbStartEvent =
	{
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.ADD_NPC, 6, 1, 9, "guaiwu", "53_xunbaozhe_zhandou"},
	{XoyoGame.MOVIE_DIALOG, -1, "Ngay chúng ta nỗ lực đẩy lùi truy tung người là lúc, chúng ta phía sau truyền đến một trận âm hiểm cười. \n<npc=3206>: ghê tởm, không nghĩ tới các ngươi giá đàn đồng lõa thật đúng là rất cao. Bất quá yêm môn thị sẽ không tha khí đích, liều mạng cũng muốn Bảo vệ thánh vật. Các ngươi tiếp chiêu ba, C4 già lâu la! \n đoạt lại thánh vật hay là khả dĩ dẹp loạn bọn họ đích lửa giận."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Tầm Bảo Giả"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "Tuy rằng Đánh bại liễu tầm bảo người, thế nhưng chính một năng ngăn lại C4 già lâu la đích phát động, ai, hoa tốt địa phương, chờ bạo tạc đích một cơn lốc bả chúng ta đái ra tiêu dao cốc."},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "53_xunbaozhe_zhandou"},
	},
	},
	[10] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	[11] = {nTime = 0, nNum = 23,
	tbPrelock = {10},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 15, 11, "guaiwu", "53_guaiwu_1"},
	{XoyoGame.ADD_NPC, 2, 8, 11, "guaiwu", "53_guaiwu_2"},
	{XoyoGame.DEL_NPC, "guaiwu4"},
	{XoyoGame.DEL_NPC, "guaiwu3"},
	{XoyoGame.BLACK_MSG, -1, "Vũ trang bộ khoái: đại gia cùng tiến lên a, bả những ... này đồng lõa cũng tập nã quy án."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 23 Bổ Khoái Vũ Trang"},
	},
	},
	[12] = {nTime = 0, nNum = 2,
	tbPrelock = {11},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 2, 12, "guaiwu", "53_boss"},
	{XoyoGame.BLACK_MSG, -1, "Bất hảo, hữu cường liệt đích sát khí."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 2 Truy Tông Giả"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "53_boss"},
	{XoyoGame.ADD_NPC, 7, 6, 0, "baoxiang", "53_guaiwu_1"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3206>: ghê tởm, không nghĩ tới các ngươi giá đàn đồng lõa thật đúng là rất cao. Bất quá yêm môn cũng là không ăn tố đích, tiếp chiêu ba C4 già lâu la! ! \n<playername>: thiết, chúng ta đang lo không có cách nào khác xuất cốc ni, cái này được rồi, khả dĩ nương bạo tạc bay ra cốc lạc."},
	},
	},
	}
	}
	tbRoom[55] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {46784 / 32, 86432 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3199, nLevel = -1, nSeries = -1},		-- cường đạo lôi trận
	[2] = {nTemplate = 3202, nLevel = -1, nSeries = -1},		-- cường đạo hồi huyết
	[3] = {nTemplate = 3200, nLevel = -1, nSeries = -1},		-- cường đạo phổ thông
	[4] = {nTemplate = 3198, nLevel = -1, nSeries = -1},		-- cường đạo nội miễn
	[5] = {nTemplate = 3201, nLevel = -1, nSeries = -1},		-- cường đạo ngoại miễn
	[6] = {nTemplate = 3203, nLevel = -1, nSeries = -1},		-- cường đạo đầu lĩnh
	[7] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tiêu dao cốc non xanh nước biếc, đích thật là ở lại giai sở. Tiền phương hữu hai hộ nhân gia, quá khứ hỏi một chút lộ."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 7, 6, 0, "qinghua", "55_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 600, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3203>: \"Các ngươi coi như có điểm năng lực, hảo hán không ăn trước mắt khuy! Các huynh đệ, triệt!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 32,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3203>: \"Cái gì? Tìm không được thất màu tiên đan! Bả bên ngoài na mấy người người qua đường trảo nhiều hỏi một chút!\""},
	{XoyoGame.ADD_NPC, 1, 9, 3, "guaiwu", "55_qiangdao_1"},
	{XoyoGame.ADD_NPC, 2, 5, 3, "guaiwu", "55_qiangdao_2"},
	{XoyoGame.ADD_NPC, 3, 18, 3, "guaiwu", "55_qiangdao_3"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 32 Cường Đạo"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 2,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3203>: \"Cách lão tử! Còn có điểm thực lực ma. Đại gia ta lai hội hội các ngươi!\""},
	{XoyoGame.ADD_NPC, 4, 4, 0, "guaiwu", "55_qiangdao_4"},
	{XoyoGame.ADD_NPC, 5, 4, 0, "guaiwu", "55_qiangdao_5"},
	{XoyoGame.ADD_NPC, 6, 2, 4, "guaiwu", "55_qiangdaotouling"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 2 Thủ Lĩnh Cường Đạo"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thu thập liễu nhất bang trong chốn võ lâm đích bại hoại, trong lòng không gì sánh được vui sướng. Nghỉ ngơi một chút, chuẩn bị ly cốc."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "55_gouhuo"},
	},
	},
	}
	}
	tbRoom[56] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {51840 / 32, 92544 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3209, nLevel = -1, nSeries = -1},		-- Tào Tháo
	[2] = {nTemplate = 3235, nLevel = -1, nSeries =	-1},		-- chu du
	[4] = {nTemplate = 3236, nLevel = -1, nSeries =	-1},		-- ngụy binh
	[5] = {nTemplate = 3282, nLevel = -1, nSeries =	-1},		-- ngô binh
	[6] = {nTemplate = 3289, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt
	[8] = {nTemplate = 3228, nLevel = -1, nSeries =	4},			-- tần trọng
	[9] = {nTemplate = 3227, nLevel = -1, nSeries =	2},			-- tử uyển
	[10] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Ôi chao, nơi này là địa phương nào? Chỉ có 3 một bộ phận then chốt nhân Cùng 2 một tấm bia đá tại phương bắc Cùng phương tây đích dân ốc na xử trứ, đi xem."},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 10, 6, 0, "qinghua", "56_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Cái này tấm bia đá có điểm cổ quái, điều tra nhìn."},
	{XoyoGame.ADD_NPC, 1, 1, 0, "boss1", "56_caocao"},
	{XoyoGame.ADD_NPC, 6, 1, 2, "jiguan", "56_wei_jiguan"},
	{XoyoGame.TARGET_INFO, -1, "Mở cơ quan"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "boss2"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 2, 0, "boss2", "56_zhouyu"},
	{XoyoGame.ADD_NPC, 6, 1, 3, "jiguan", "56_shu_jiguan"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.DEL_NPC, "boss1"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[4] = {nTime = 120, nNum = 0,
	tbPrelock = {2},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 30, 0, "guaiwu1", "56_shibing_wei"},
	{XoyoGame.ADD_NPC, 5, 20, 0, "guaiwu2", "56_shibing_shu"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2", XoyoGame.AI_ATTACK, "", 5},	-- cải biến trận doanh AI
	{XoyoGame.MOVIE_DIALOG, -1, "Một đám bộ phận then chốt nhân đột nhiên xuất hiện hoàn đánh nhau đứng lên! ! Thật là có ý tứ. Chúng ta cũng đi thấu vô giúp vui."},
	{XoyoGame.TARGET_INFO, -1, "Loại trừ tất cả Ngô Binh"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[10]:Close()"},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 120, nNum = 0,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 27, 0, "guaiwu1", "56_shibing_shu"},
	{XoyoGame.BLACK_MSG, -1, "Ra mòi thị ngụy binh bắt đầu quy mô tiến công liễu."},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 2,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 20, 0, "guaiwu2", "56_shibing_wei"},
	{XoyoGame.ADD_NPC, 2, 2, 6, "boss2", "56_zhouyu"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2", XoyoGame.AI_ATTACK, "", 5},
	{XoyoGame.CHANGE_NPC_AI, "boss2", XoyoGame.AI_ATTACK, "", 5},
	{XoyoGame.BLACK_MSG, -1, "Bất hảo, ngụy binh tại một trận hỏa quang lúc tất cả đều tiêu thất, song song xuất hiện đại lượng ngô binh."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Thống Lĩnh Ngô Quân"},
	},
	tbUnLockEvent = {},
	},
	[7] = {nTime = 0, nNum = 2,
	tbPrelock = {{6, 10}},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 8, 1, 7, "guaiwu", "56_qinzhong"},
	{XoyoGame.ADD_NPC, 9, 1, 7, "guaiwu", "56_ziyuan"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.DEL_NPC, "boss1"},
	{XoyoGame.DEL_NPC, "boss2"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3227>: ta là thuyết chúng ta đích diễn tập vì sao gặp phải lệch lạc, nguyên lai lại là các ngươi giá đàn mạc danh kỳ diệu đích tên tại quấy rối. Lần trước Tiêu diệt ta kiệt tác đích sổ sách còn không có toán ni! ! \n<npc=3228>: sư muội, đừng nóng giận. Nhượng chúng ta cùng nhau giáo huấn một chút giá đàn cuồng vọng đích tên."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Tử Uyển và Tần Trọng"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "56_qinzhong"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3227>: vì sao? ? Đây là vì sao? ? \n<npc=3228>: sư muội chờ một chút ta! ! \n giá hai vị mới là mạc danh kỳ diệu ni."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[11]:Close()"},
	},
	},
	[8] = {nTime = 120, nNum = 0,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 30, 0, "guaiwu1", "56_shibing_wei"},
	{XoyoGame.ADD_NPC, 5, 20, 0, "guaiwu2", "56_shibing_shu"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1", XoyoGame.AI_ATTACK, "", 5},	-- cải biến trận doanh AI
	{XoyoGame.MOVIE_DIALOG, -1, "Một đám bộ phận then chốt nhân đột nhiên xuất hiện hoàn đánh nhau đứng lên! ! Thật là có ý tứ. Chúng ta cũng đi thấu vô giúp vui."},
	{XoyoGame.TARGET_INFO, -1, "Loại trừ tất cả Ngụy Binh"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[6]:Close()"},
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 120, nNum = 0,
	tbPrelock = {8},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 27, 0, "guaiwu1", "56_shibing_shu"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1", XoyoGame.AI_ATTACK, "", 5},
	{XoyoGame.BLACK_MSG, -1, "Bất hảo, ngụy binh bắt đầu quy mô tiến công liễu."},
	},
	tbUnLockEvent = {},
	},
	[10] = {nTime = 0, nNum = 1,
	tbPrelock = {9},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 10, "boss1", "56_caocao"},
	{XoyoGame.CHANGE_NPC_AI, "boss1", XoyoGame.AI_ATTACK, "", 5},
	{XoyoGame.BLACK_MSG, -1, "Thị thời gian phản công liễu."},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Thống Lĩnh Kỵ Binh"},
	},
	tbUnLockEvent = {},
	},
	[11] = {nTime = 600, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 11},
	},
	tbUnLockEvent =
	{
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.DEL_NPC, "boss1"},
	{XoyoGame.DEL_NPC, "boss2"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[7]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "Ở đây hay địa phương nào? Nơi đều là loạn thất bát tao đích ngoạn ý. Thực sự là mạc danh kỳ diệu."},
	},
	},
	}
	}
	tbRoom[57] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {50592 / 32, 96704 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3305, nLevel = -1, nSeries = -1},		-- cọc gỗ
	[2] = {nTemplate = 3313, nLevel = -1, nSeries = -1},		-- Cơ Quan Cự Lang Hoàn Mỹ
	[3] = {nTemplate = 3175, nLevel = -1, nSeries = -1},		-- thấp kém bộ phận then chốt nhân
	[4] = {nTemplate = 3306, nLevel = 65, nSeries = -1},		-- thái cực
	[5] = {nTemplate = 3311, nLevel = -1, nSeries = -1},		-- dương nghi
	[6] = {nTemplate = 3312, nLevel = -1, nSeries = -1},		-- âm nghi
	[7] = {nTemplate = 3307, nLevel = -1, nSeries = -1},		-- đông cung chòm sao Thương Long
	[8] = {nTemplate = 3308, nLevel = -1, nSeries = -1},		-- tây cung bạch hổ
	[9] = {nTemplate = 3309, nLevel = -1, nSeries = -1},		-- Nam Cung chu tước
	[10] = {nTemplate = 3310, nLevel = -1, nSeries = -1},		-- bắc cung huyền vũ
	[11] = {nTemplate = 3298, nLevel = -1, nSeries = -1},		-- bộ phận then chốt
	[12] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Có bản lĩnh tựu thử tòng cái này bộ phận then chốt trải rộng đích khu vực trốn tới. \n xem ra đích xuất ra điểm bản lĩnh thật sự liễu. Ở đây trên mặt đất hữu thật nhiều hãm hại, phải cẩn thận có cái gì lợi hại đích bộ phận then chốt."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.CHANGE_TRAP, "57_trap_1", {50976 / 32, 97568 / 32}},
	{XoyoGame.ADD_NPC, 12, 6, 0, "qinghua", "57_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2]= {nTime = 600, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Các ngươi đích năng lực cũng chỉ thường thôi, giết chết các ngươi hội ô uế tay của ta. Lập tức tòng ta đích trước mắt tiêu thất! !"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "luzhang"},
	{XoyoGame.DEL_NPC, "jiguan"},
	{XoyoGame.CHANGE_TRAP, "57_trap_1", nil},
	{XoyoGame.CHANGE_TRAP, "57_trap_2", nil},
	{XoyoGame.CHANGE_TRAP, "57_trap_3", nil},
	{XoyoGame.DO_SCRIPT, "self. tbLock[4]:Close()"},
	},
	},
	[3] = {nTime = 120, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Ngầm xuất hiện liễu bộ phận then chốt, hình như rất kinh khủng đích hình dạng."},
	{XoyoGame.TARGET_INFO, -1, "Giữ trong 2 phút"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu4"},
	{XoyoGame.DEL_NPC, "guaiwu5"},
	{XoyoGame.DEL_NPC, "guaiwu6"},
	{XoyoGame.CHANGE_TRAP, "57_trap_1", {52192 / 32, 96032 / 32}},
	{XoyoGame.CHANGE_TRAP, "57_trap_2", {52192 / 32, 96032 / 32}},
	},
	},
	[4] = {nTime = 20, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 5, 0, "guaiwu1", "57_tumuzhuang"},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 20, nNum = 0,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 5, 0, "guaiwu2", "57_tumuzhuang"},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 11, 1, 6, "jiguan", "57_jiguan_2"},
	{XoyoGame.BLACK_MSG, -1, "Đi trước hạ khu vực nhìn"},
	{XoyoGame.TARGET_INFO, -1, "Mở cơ quan tiếp theo"},
	},
	tbUnLockEvent = {},
	},
	[7] = {nTime = 120, nNum = 0,
	tbPrelock = {6},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Hựu xuất hiện liễu kinh khủng đích bộ phận then chốt cự lang, cẩn thận a."},
	{XoyoGame.TARGET_INFO, -1, "Giữ trong 2 phút"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu1"},
	{XoyoGame.DEL_NPC, "guaiwu2"},
	{XoyoGame.DEL_NPC, "guaiwu3"},
	{XoyoGame.CHANGE_TRAP, "57_trap_2", {53504 / 32, 94880 / 32}},
	{XoyoGame.CHANGE_TRAP, "57_trap_3", {53504 / 32, 94880 / 32}},
	},
	},
	[8] = {nTime = 20, nNum = 0,
	tbPrelock = {6},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu1", "57_wanmeidejiguanjulang"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1", XoyoGame.AI_RECYLE_MOVE, "lv5_57_wanmeidejiguanjulang", 0, 0, 120},
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 20, nNum = 0,
	tbPrelock = {8},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 2, 0, "guaiwu2", "57_wanmeidejiguanjulang"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2", XoyoGame.AI_RECYLE_MOVE, "lv5_57_wanmeidejiguanjulang", 0, 0, 120},
	},
	tbUnLockEvent = {},
	},
	[10] = {nTime = 20, nNum = 0,
	tbPrelock = {9},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 4, 0, "guaiwu3", "57_wanmeidejiguanjulang"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu3", XoyoGame.AI_RECYLE_MOVE, "lv5_57_wanmeidejiguanjulang", 0, 0, 120},
	},
	tbUnLockEvent = {},
	},
	[11] = {nTime = 0, nNum = 1,
	tbPrelock = {7},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 11, 1, 11, "jiguan", "57_jiguan_3"},
	{XoyoGame.BLACK_MSG, -1, "Đi trước hạ khu vực nhìn"},
	{XoyoGame.TARGET_INFO, -1, "Mở cơ quan tiếp theo"},
	},
	tbUnLockEvent = {},
	},
	[12] = {nTime = 0, nNum = 20,
	tbPrelock = {11},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Tựa hồ quá quan đích bí mật tại đây ta bộ phận then chốt nhân thân thượng."},
	{XoyoGame.TARGET_INFO, -1, "Giết 20 Cơ Quan Nhân Thô"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CHANGE_TRAP, "57_trap_3", nil},
	{XoyoGame.BLACK_MSG, -1, "Khả dĩ đi trước bộ phận then chốt trận đích tối hậu khu vực liễu."},
	},
	},
	[13] = {nTime = 0, nNum = 1,
	tbPrelock = {12},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 4, 1, 13, "guaiwu", "57_taiji"},
	{XoyoGame.TARGET_INFO, -1, "Tiêu diệt tất cả cơ quan"},
	},
	tbUnLockEvent = {},
	},
	[14] = {nTime = 0, nNum = 2,
	tbPrelock = {13},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 14, "guaiwu", "57_liangyi_yang"},
	{XoyoGame.ADD_NPC, 6, 1, 14, "guaiwu", "57_liangyi_yin"},
	},
	tbUnLockEvent = {},
	},
	[15] = {nTime = 0, nNum = 4,
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 7, 1, 15, "guaiwu", "57_donggongcanglong"},
	{XoyoGame.ADD_NPC, 8, 1, 15, "guaiwu", "57_xigongbaihu"},
	{XoyoGame.ADD_NPC, 9, 1, 15, "guaiwu", "57_nangongzhuque"},
	{XoyoGame.ADD_NPC, 10, 1, 15, "guaiwu", "57_beigongxuanwu"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Hữu kinh vô hiểm đích trốn ra bộ phận then chốt đại trận. Hồ khôn đích năng lực thực sự là kẻ khác tán dương, có cơ hội còn muốn hội hội vị này bộ phận then chốt đại sư."},
	{XoyoGame.CHANGE_TRAP, "57_trap_1", nil},
	{XoyoGame.CHANGE_TRAP, "57_trap_2", nil},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "57_taiji"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[16] = {nTime = 20, nNum = 0,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 5, 0, "guaiwu3", "57_tumuzhuang"},
	},
	tbUnLockEvent = {},
	},
	[17] = {nTime = 20, nNum = 0,
	tbPrelock = {16},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 5, 0, "guaiwu4", "57_tumuzhuang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu1"},
	},
	},
	[18] = {nTime = 20, nNum = 0,
	tbPrelock = {17},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 5, 0, "guaiwu5", "57_tumuzhuang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu2"},
	},
	},
	[19] = {nTime = 20, nNum = 0,
	tbPrelock = {18},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 5, 0, "guaiwu6", "57_tumuzhuang"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu3"},
	},
	},
	[20] = {nTime = 20, nNum = 0,
	tbPrelock = {19},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu4"},
	{XoyoGame.DEL_NPC, "guaiwu5"},
	{XoyoGame.DEL_NPC, "guaiwu6"},
	},
	},
	[21] = {nTime = 15, nNum = 0,
	tbPrelock = {11},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 3, 12, "guaiwu", "57_xiaoguai"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	}
	}
	for i = 1, 22 do
	tbRoom[57]. LOCK[21 + i] = {nTime = 15, nNum = 0,
	tbPrelock = {20 + i},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 3, 12, "guaiwu "..i, "57_xiaoguai"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu "..i},
	},
	};
	end
	tbRoom[58] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {54432 / 32, 103232 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3166, nLevel = -1, nSeries = -1},		-- phản quân binh sĩ 1
	[2] = {nTemplate = 3168, nLevel = -1, nSeries = -1},		-- phản quân thống lĩnh 1
	[3] = {nTemplate = 3169, nLevel = -1, nSeries = -1},		-- phản quân thống lĩnh 2
	[4] = {nTemplate = 3226, nLevel = -1, nSeries = -1},		-- sát đại mục
	[5] = {nTemplate = 3264, nLevel = -1, nSeries =	-1},		-- tiêu không thật
	[6] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- Cơ Quan Cự Lang Hoàn Mỹ
	[7] = {nTemplate = 3301, nLevel = 35, nSeries =	-1},		-- cường công NPC
	[8] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 6, "husong", "58_butou"},
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước vị kia... Chẳng lẽ là trong truyền thuyết đích thần bộ?"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 8, 6, 0, "qinghua", "58_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 600, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.MOVIE_DIALOG, -1, "Đây là cái gì giang hồ lạp! !"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3264>: \"Đúng vậy! Ta hay trong truyền thuyết đích tiêu thần bộ! Các ngươi mấy người, động như thế nhìn quen mắt ni? Nga, được rồi, ta nghe nói phản quân thủ lĩnh sát đại mục tựu cất giấu tại đây phụ cận, các ngươi có muốn hay không Cùng ta cùng nhau đưa hắn tróc nã quy án?\""},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv5_58_butou", 4, 100, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 1, 15, 0, "guaiwu", "58_panjunshibing_1"},		-- xoát quái
	{XoyoGame.ADD_NPC, 1, 15, 0, "guaiwu", "58_panjunshibing_2"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Cùng Tiêu Bất Thực bắt giữ Thủ Lĩnh Phản Quân"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 0, nNum = 1,
	tbPrelock = {{4,6}},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tiền phương truyền đến một tiếng rống to: \"Ngươi sát gia gia ở đây, đái loại đích cứ tới đây bắt ta a!\" \n<npc=3264>: \"Lần trước cho ngươi chạy, ngày hôm nay ta muốn cho ngươi biết sự lợi hại của ta!\" \n chỉ thấy tiêu đầu mục bắt người cương rút ra đao, liền thống khổ đích té trên mặt đất rên rỉ đáo: \"Ôi liệt, ôi liệt, ta đích món bao tử a. Các ngươi mấy người hãy đi trước giúp ta bả hắn nã ở, ta đi một chút sẽ trở lại.\" Nói xong nhanh như chớp chạy."},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.ADD_NPC, 3, 4, 0, "guaiwu", "58_panjunshouling"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 1, 5, "guaiwu", "58_shadamu"},		-- xoát quái
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Phản Quân và Sát Đại Mục"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3264>: \"Các ngươi giá đàn tiểu tặc cho ta chờ, tiêu gia gia ta ăn 10 cấp hộ giáp phiến trở lại hội các ngươi!\" \n nói xong nhanh như chớp đã không thấy tăm hơi hình bóng. Đột nhiên truyền đến một tiếng rống to: \"Tiêu không thật a tiêu không thật, ngươi cũng có ngày hôm nay! !\""},
	},
	},
	[7] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Tiêu không thật: chủ nhân, ta rốt cục bắt được liễu 《 quỳ mộc bảo điển 》 liễu, nâm cũng nhanh thiên hạ vô địch liễu"},
	{XoyoGame.ADD_NPC, 6, 2, 0, "guaiwu", "58_wanmeidejiguanjulang"},
	{XoyoGame.ADD_NPC, 7, 1, 7, "guaiwu", "58_xiaobushi"},
	{XoyoGame.TARGET_INFO, -1, "Phía Tây, không cho Tiêu Bất Thực thoát"},
	},
	tbUnLockEvent=
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Không nghĩ tới dĩ nhiên là hồ khôn chính là tay sai. Bất quá cái này bộ phận then chốt nhân cũng quá tượng thực sự liễu."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "58_gouhuo"},
	},
	},
	}
	}
	tbRoom[59] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {56960 / 32, 95104 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3210, nLevel = -1, nSeries = -1},		-- thị vệ chậm chạp
	[2] = {nTemplate = 3211, nLevel = -1, nSeries = -1},		-- thị vệ hỗn loạn
	[3] = {nTemplate = 3212, nLevel = -1, nSeries = -1},		-- thị vệ lạp nhân
	[4] = {nTemplate = 3213, nLevel = -1, nSeries = -1},		-- thị vệ lôi trận
	[5] = {nTemplate = 3291, nLevel = -1, nSeries = -1},		-- sấm cốc kẻ trộm
	[6] = {nTemplate = 3292, nLevel = -1, nSeries = -1},		-- Thủ Lĩnh Sấm Cốc Tặc
	[7] = {nTemplate = 3317, nLevel = 35, nSeries = -1},		-- trong bảo khố tương
	[8] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Tiền phương sát khí rất nặng, hay nhất không nên lộn xộn."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 8, 6, 0, "qinghua", "59_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 599, nNum = 0,		-- tổng cộng lúc chi 1
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3292>: \"Các huynh đệ, nhìn giá phụ cận có cái gì đáng giá gì đó, toàn bộ lấy đi!\" \n<npc=3210>: \"Tiền phương chính là tiêu dao cốc cấm địa! Thiện sấm người tử!\""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3292>: \"Quả nhiên có điểm thực lực. Hảo hán không ăn trước mắt khuy, các huynh đệ, triệt!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 600, nNum = 0,		-- tổng cộng lúc chi 2
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "shiwei_2"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3210>: \"Thời gian không còn sớm, chư vị cũng nên ly cốc liễu. Hôm nay lúc đó biệt quá, hữu duyên tái kiến.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "59_gouhuo"},
	},
	},
	[4] = {nTime = 0, nNum = 32,		--	Sát kẻ trộm tiến chi nhánh 2
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 32, 4, "guaiwu", "59_chuangguzei"},
	{XoyoGame.TARGET_INFO, -1, "Ai giúp? Hãy đưa ra quyết định."},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 8},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[5] = {nTime = 0, nNum = 4,		--	Sát thị vệ tiến chi nhánh 1
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 5, "shiwei", "59_shiwei_1"},
	{XoyoGame.ADD_NPC, 2, 1, 5, "shiwei", "59_shiwei_2"},
	{XoyoGame.ADD_NPC, 3, 1, 5, "shiwei", "59_shiwei_3"},
	{XoyoGame.ADD_NPC, 4, 1, 5, "shiwei", "59_shiwei_4"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 8},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[4]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[6] = {nTime = 0, nNum = 4,		--	Chi nhánh 1
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 4, 0, "guaiwu", "59_chuangguzei_2"},
	{XoyoGame.ADD_NPC, 6, 4, 6, "guaiwu", "59_chuangguzeitouling"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3292>: \"Ở đây thế nhưng tiêu dao cốc giấu trong bảo khố nơi, chúng ta đang lo không ai thu thập những ... này đáng ghét đích thị vệ ni, cái này được rồi, một đám ngu ngốc giúp chúng ta không ít mang, ha ha ha ha cáp\""},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Thủ Lĩnh Sấm Cốc Tặc"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3292>: \"Không nghĩ tới các ngươi bọn người kia như thế cường... Thực sự là tính sai...\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "59_gouhuo"},
	{XoyoGame.ADD_NPC, 7, 3, 0, "baoxiang", "59_chuangguzei_2"},
	{XoyoGame.ADD_NPC, 7, 3, 0, "baoxiang", "59_chuangguzeitouling"},
	},
	},
	[7] = {nTime = 0, nNum = 4,		--	Chi nhánh 2
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.DEL_NPC, "shiwei"},
	{XoyoGame.ADD_NPC, 1, 1, 7, "shiwei_2", "59_shiwei_5"},
	{XoyoGame.ADD_NPC, 2, 1, 7, "shiwei_2", "59_shiwei_6"},
	{XoyoGame.ADD_NPC, 3, 1, 7, "shiwei_2", "59_shiwei_7"},
	{XoyoGame.ADD_NPC, 4, 1, 7, "shiwei_2", "59_shiwei_8"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3210>: \"Đa tạ mấy hiệp sĩ hỗ trợ, mấy võ công cao cường, không bằng chúng ta luận bàn một chút?\""},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Trưởng Thị Vệ"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3210>: \"Mấy quả nhiên thực lực phi phàm, ta đợi cam bái hạ phong!\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "59_gouhuo"},
	},
	},
	[8] = {nTime = 599, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {},
	},
	}
	}
	tbRoom[60] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,		-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {57024 / 32, 88480 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3294, nLevel = -1, nSeries = -1},		-- thị vệ
	[2] = {nTemplate = 3295, nLevel = -1, nSeries = -1},		-- thị vệ
	[3] = {nTemplate = 3296, nLevel = -1, nSeries = -1},		-- thị vệ
	[4] = {nTemplate = 3297, nLevel = -1, nSeries = -1},		-- thị vệ
	[5] = {nTemplate = 3214, nLevel = -1, nSeries = -1},		-- rắn lục
	[6] = {nTemplate = 3215, nLevel = -1, nSeries = -1},		-- thạch hoành hà
	[7] = {nTemplate = 3216, nLevel = -1, nSeries = -1},		-- khương quách lai
	[8] = {nTemplate = 3217, nLevel = -1, nSeries = -1},		-- ngô kiến
	[9] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này thác nước như vậy đồ sộ, chân gọi người lưu luyến vong phản."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 9, 6, 0, "qinghua", "60_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 598, nNum = 0,		-- tổng cộng thì thị vệ vị Tiêu diệt
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Thị vệ: \"Cốc chủ hữu rất chi đức, hôm nay tạm tha nhữ chờ một mạng, thỉnh tốc tốc ly cốc, vật trở lại phạm!\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[4]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	},
	},
	[3] = {nTime = 600, nNum = 0,		-- tổng cộng thì Tiêu diệt thị vệ
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3214>: \"Có thể cùng ta đợi chiến thành thế cân bằng, quả nhiên thị hậu sinh khả uý, bất quá hôm nay thời gian không còn sớm, chư vị cũng nên ly cốc liễu, tương lai hữu duyên tái chiến.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	},
	},
	[4] = {nTime = 0, nNum = 28,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "? ? : tứ đại hộ pháp ở đây thanh tu, ai dám quấy rối! !"},
	{XoyoGame.ADD_NPC, 1, 7, 4, "guaiwu", "60_shiwei_1"},
	{XoyoGame.ADD_NPC, 2, 7, 4, "guaiwu", "60_shiwei_2"},
	{XoyoGame.ADD_NPC, 3, 7, 4, "guaiwu", "60_shiwei_3"},
	{XoyoGame.ADD_NPC, 4, 7, 4, "guaiwu", "60_shiwei_4"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại 28 Thị Vệ"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green> thặng dư thời gian %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[5] = {nTime = 0, nNum = 4,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 5, 1, 5, "guaiwu", "60_zhuyeqing"},
	{XoyoGame.ADD_NPC, 6, 1, 5, "guaiwu", "60_shihengxia"},
	{XoyoGame.ADD_NPC, 7, 1, 5, "guaiwu", "60_qiangguolai"},
	{XoyoGame.ADD_NPC, 8, 1, 5, "guaiwu", "60_wujian"},
	{XoyoGame.MOVIE_DIALOG, -1, "? ? : năng Đánh bại trong cốc thị vệ, xem ra chư vị võ công tương đương rất cao, để chúng ta lai lảnh giáo một phen ba"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Trúc Diệp Thanh, Thạch Hoàng Hà, Khương Quách Lai, Ngô Kiến"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 3},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3214>: \"Quả nhiên thị hậu sinh khả uý, xem ra ta đợi tại đây trong cốc tập võ nhiều, cũng chỉ là ếch ngồi đáy giếng a!\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "60_gouhuo"},
	},
	},
	}
	}
	tbRoom[61] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {54176 / 32, 82464 / 32},-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3268, nLevel = -1, nSeries = 3},			-- hương ngọc tiên
	[2] = {nTemplate = 3176, nLevel = -1, nSeries =	-1},		-- thấp kém bộ phận then chốt nhân
	[3] = {nTemplate = 3191, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt lang
	[4] = {nTemplate = 3157, nLevel = -1, nSeries =	-1},		-- bộ phận then chốt phủ thủ
	[5] = {nTemplate = 3192, nLevel = -1, nSeries =	-1},		-- cuồng bạo bộ phận then chốt nhân
	[6] = {nTemplate = 3242, nLevel = -1, nSeries =	-1},		-- hoàn mỹ bộ phận then chốt lang
	[7] = {nTemplate = 3162, nLevel = -1, nSeries =	-1},		-- cơ quan nhỏ thú
	[8] = {nTemplate = 3245, nLevel = -1, nSeries =	-1},		-- hồ khôn
	[9] = {nTemplate = 3305, nLevel = -1, nSeries =	-1},		-- đột cọc gỗ
	[10] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 2, "husong", "61_xiangyuxian"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Phía trước cái kia... Chẳng lẽ là? Người gặp người thích, hoa gặp hoa nở đích hương ngọc tiên?"},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 10, 6, 0, "qinghua", "61_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 1,		-- tính theo thời gian
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.DEL_NPC, "husong"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	{XoyoGame.MOVIE_DIALOG, -1, "Một đạo bóng đen tòng chúng ta trước mặt hiện lên, bắt đi liễu hương ngọc tiên, thoáng qua gian, những ... này bộ phận then chốt quái thú cũng tiêu thất đích vô tung vô ảnh..."},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 5, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3268>: \"Mấy thiếu hiệp rất nhìn quen mắt, không biết có thể hay không bang tiểu nữ tử một người mang?\" \n<playername>: \"Thỉnh giảng!\" \n<npc=3268>: \"Vừa hữu một cuồng đồ nói là đối ta nhất kiến chung tình, muốn cùng ta giao hảo. Ta không nghe theo, hắn liền phóng xuất thật nhiều kinh khủng đích bộ phận then chốt quái thú lai uy hiếp ta, các ngươi năng Bảo vệ ta ly khai ở đây mạ?\""},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TARGET_INFO, -1, "Hộ tống Hương Ngọc Tiên"},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_NPC_AI, "husong", XoyoGame.AI_MOVE, "lv5_61_xiangyuxian", 4, 10, 1, 1},	-- Hộ tống AI
	{XoyoGame.ADD_NPC, 2, 6, 0, "guaiwu", "61_liezhijiguanren"},		-- xoát quái
	{XoyoGame.ADD_NPC, 3, 6, 0, "guaiwu", "61_jiguanjulang"},		-- xoát quái
	{XoyoGame.ADD_NPC, 4, 3, 0, "guaiwu", "61_jiguanfushou"},		-- xoát quái
	{XoyoGame.ADD_NPC, 5, 6, 0, "guaiwu", "61_kuangbaojiguanren"},		-- xoát quái
	{XoyoGame.ADD_NPC, 6, 2, 0, "guaiwu", "61_wanmeijiguanlang"},		-- xoát quái
	{XoyoGame.ADD_NPC, 7, 3, 0, "guaiwu", "61_xiaoxingjiguanshou"},		-- xoát quái
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	},
	},
	[5] = {nTime = 600, nNum = 0,		-- tính theo thời gian
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 5},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DEL_NPC, "boss"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3245>: \"Hương hương, lẽ nào chúng ta thực sự hữu duyên vô phân?\" Hồ khôn thì thào tự nói, tiêu thất tại rừng rậm trung... \n<npc=3268>: \"Cái kia người điên đi? Thực sự là rất đa tạ liễu! Ôi chao nha, sắc trời không còn sớm, ta cai ly cốc liễu, sau khi rời khỏi đây nếu như có cơ hội tái kiến ta nhất định tống bả hảo vũ khí cho các ngươi.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "61_gouhuo"},
	},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3268>: \"Hô, rốt cục khả dĩ tùng một hơi thở liễu. A? Tên kia hình như đuổi tới, ta tiên giấu đứng lên, các ngươi giúp ta tha trụ hắn.\" \n<npc=3245>: \"Hương hương, ngươi vì sao không chịu tiếp thu ta? ! Ta biết ngươi trốn ở chỗ này, ta nhất định sẽ tìm được của ngươi!\""},
	{XoyoGame.ADD_NPC, 8, 1, 6, "boss", "61_hukun"},		-- hồ khôn
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Hồ Khôn"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[5]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[7]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[9]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[11]:Close()"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[12]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3268>: \"Các ngươi đánh bại cái kia đại phôi đản liễu? Thực sự là rất đa tạ liễu! Ôi chao nha, sắc trời không còn sớm, ta cai ly cốc liễu, sau khi rời khỏi đây nếu như có cơ hội tái kiến ta nhất định tống bả hảo vũ khí cho các ngươi.\""},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "61_gouhuo"},
	},
	},
	[7] = {nTime = 60, nNum = 0,		-- xoát quái
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1	, "Hồ khôn: \"Cho ta tử! Cấm thuật: mộc độc trận\""},
	{XoyoGame.ADD_NPC, 9, 32, 0, "fenshen", "61_fenshen"},
	},
	},
	[8] = {nTime = 30, nNum = 0,		-- san quái
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "fenshen"},
	},
	},
	[9] = {nTime = 120, nNum = 0,		-- xoát quái
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Hồ khôn: \"Còn không tử? ! Siêu · cấm thuật: mộc độc hải\""},
	{XoyoGame.ADD_NPC, 9, 65, 0, "fenshen2", "61_fenshen_2"},
	},
	},
	[10] = {nTime = 30, nNum = 0,		-- san quái
	tbPrelock = {9},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "fenshen2"},
	},
	},
	[11] = {nTime = 58, nNum = 0,		-- xoát quái
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.SEND_CHAT, "boss", "Muốn biết địa ngục thị bộ dáng gì nữa mạ?"},
	},
	},
	[12] = {nTime = 118, nNum = 0,		-- xoát quái
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.SEND_CHAT, "boss", "Địa ngục thế nhưng hữu 18 tằng đích, ta cái này tống các ngươi quá khứ!"},
	},
	},
	}
	}
	-- trong bảo khố tương gian phòng
	tbRoom[62] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {67520 / 32, 93600 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3303, nLevel = -1, nSeries = -1},		-- cái rương
	[2] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bảo tàng! Ha ha! Rốt cục nhượng chúng ta tìm được rồi! Bất quá... Còn giống như hữu những người khác cũng tìm được rồi ở đây..."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 2, 12, 0, "qinghua", "62_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 600, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nghỉ ngơi tốt liễu, khả dĩ ly khai tiêu dao cốc liễu"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbTeam[2]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	},
	},
	[3] = {nTime = 0, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "62_baoxiang"},
	{XoyoGame.TARGET_INFO, -1, "Lấy kho báu ở trong rương"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 120, nNum = 0,
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "62_baoxiang"},
	},
	},
	[5] = {nTime = 120, nNum = 0,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "62_baoxiang"},
	},
	},
	[6] = {nTime = 120, nNum = 0,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "62_baoxiang"},
	},
	},
	[7] = {nTime = 120, nNum = 0,
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "62_baoxiang"},
	},
	},
	[8] = {nTime = 60, nNum = 0,
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "62_baoxiang"},
	},
	},
	}
	}
	tbRoom[63] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {56096 / 32, 76960 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3303, nLevel = -1, nSeries = -1},		-- cái rương
	[2] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bảo tàng! Ha ha! Rốt cục nhượng chúng ta tìm được rồi! Bất quá... Còn giống như hữu những người khác cũng tìm được rồi ở đây..."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 2, 10, 0, "qinghua", "63_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 600, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Nghỉ ngơi tốt liễu, khả dĩ ly khai tiêu dao cốc liễu"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbTeam[2]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	},
	},
	[3] = {nTime = 0, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "63_baoxiang"},
	{XoyoGame.TARGET_INFO, -1, "Lấy khó báu ở trong rương"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 120, nNum = 0,
	tbPrelock = {3},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "63_baoxiang"},
	},
	},
	[5] = {nTime = 120, nNum = 0,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 10, 0, "xiangzi", "63_baoxiang"},
	},
	},
	[6] = {nTime = 120, nNum = 0,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "63_baoxiang"},
	},
	},
	[7] = {nTime = 120, nNum = 0,
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "63_baoxiang"},
	},
	},
	[8] = {nTime = 60, nNum = 0,
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "xiangzi"},
	{XoyoGame.ADD_NPC, 1, 12, 0, "xiangzi", "63_baoxiang"},
	},
	},
	}
	}
	tbRoom[64] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {64896 / 32, 84736 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3247, nLevel = -1, nSeries = 5},		-- mặc quân
	[2] = {nTemplate = 3248, nLevel = -1, nSeries = -1},		-- nam đệ tử
	[3] = {nTemplate = 3249, nLevel = -1, nSeries = -1},		-- nữ đệ tử
	[4] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Ở đây tựa hồ là một người tư thục, không biết là người phương nào ở tại thử."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 4, 6, 0, "qinghua", "64_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 600, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3247>: \"Hảo hảo hảo, đình chỉ đình chỉ! Các ngươi công phu hỏa hậu còn kém như vậy điểm, bất quá lão phu rất hài lòng, lai, tiên nghỉ ngơi hội, đợi lão phu tống các ngươi ly khai tiêu dao cốc.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3247>: \"Có bằng hữu từ phương xa tới, bất diệc thuyết hồ. Ha ha ha ha cáp! Đã lâu không có ngoại nhân lai lão phu giá quang cố liễu. Lai lai lai, theo ta hoạt động hoạt động gân cốt.\""},
	{XoyoGame.ADD_NPC, 1, 1, 3, "guaiwu", "64_mojun"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Mặc Quân"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3247>: \"Đã lâu không có như thế sảng khoái đích đả thượng một hồi liễu, các vị công phu thực tại không sai, lai, uống chút rượu, nghỉ ngơi một chút, lão phu hội tống các vị ly khai tiêu dao cốc đích.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "64_gouhuo"},
	},
	},
	[4] = {nTime = 120, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu1_1", "64_nandizi"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "guaiwu1_2", "64_nvdizi"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_1", XoyoGame.AI_MOVE, "lv5_64_nandizi", 0, 100, 1},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_2", XoyoGame.AI_MOVE, "lv5_64_nvdizi", 0, 100, 1},
	{XoyoGame.BLACK_MSG, -1, "Hậu phương truyền đến đồng nam đồng giọng nữ, tựa hồ là lai bang trợ bọn họ lão sư đích."},
	},
	},
	[5] = {nTime = 60, nNum = 0,
	tbPrelock = {4},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu2_1", "64_nandizi"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "guaiwu2_2", "64_nvdizi"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2_1", XoyoGame.AI_MOVE, "lv5_64_nandizi", 0, 100, 1},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu2_2", XoyoGame.AI_MOVE, "lv5_64_nvdizi", 0, 100, 1},
	},
	},
	[6] = {nTime = 60, nNum = 0,
	tbPrelock = {5},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu1_1", "64_nandizi"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "guaiwu1_2", "64_nvdizi"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_1", XoyoGame.AI_MOVE, "lv5_64_nandizi", 0, 100, 1},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_2", XoyoGame.AI_MOVE, "lv5_64_nvdizi", 0, 100, 1},
	},
	},
	[7] = {nTime = 60, nNum = 0,
	tbPrelock = {6},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu1_1", "64_nandizi"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "guaiwu1_2", "64_nvdizi"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_1", XoyoGame.AI_MOVE, "lv5_64_nandizi", 0, 100, 1},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_2", XoyoGame.AI_MOVE, "lv5_64_nvdizi", 0, 100, 1},
	},
	},
	[8] = {nTime = 60, nNum = 0,
	tbPrelock = {7},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 0, "guaiwu1_1", "64_nandizi"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "guaiwu1_2", "64_nvdizi"},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_1", XoyoGame.AI_MOVE, "lv5_64_nandizi", 0, 100, 1},
	{XoyoGame.CHANGE_NPC_AI, "guaiwu1_2", XoyoGame.AI_MOVE, "lv5_64_nvdizi", 0, 100, 1},
	},
	},
	}
	}
	tbRoom[65] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {61952 / 32, 86432 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3250, nLevel = -1, nSeries = 2},		-- đường vũ
	[2] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Rừng trúc, gậy trúc đáp đích lôi đài, trúc ốc... Ở đây, chẳng lẽ là Thục trung Đường môn?"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 2, 6, 0, "qinghua", "65_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 600, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3250>: \"Thanh niên nhân nột, các ngươi còn phải nhiều hơn tu luyện a. Ta hảo thời gian dài không có kịch liệt vận động qua, ngày hôm nay động liễu hạ tựu xương sống thắt lưng bối đau nhức chân rút gân liễu, ai, trở lại nghỉ ngơi la.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3250>: \"Tại đây cốc ở đây liễu lâu như vậy, rất ít năng thấy sinh mặt ni. Khán mấy hẳn là thân thủ không sai, đến lão phu quá thượng mấy chiêu ba, không biết các ngươi có hay không bản lĩnh tiếp lão phu mười chiêu ni?\""},
	{XoyoGame.ADD_NPC, 1, 1, 3, "guaiwu", "65_tangyu"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Đường Vũ"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3250>: \"Ai, không thừa nhận không được a, nhân nột, tới rồi cái này niên linh, là nên hảo hảo nghỉ ngơi liễu, vũ đao lộng thương loại sự tình này, chính thích hợp các ngươi thanh niên nhân đi làm. Tuổi còn trẻ thật tốt a.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "65_gouhuo"},
	},
	},
	}
	}
	tbRoom[66] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {70016 / 32, 125824 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 			Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 		nLevel, 		nSeries }
	[1] = {nTemplate = 3320, nLevel = -1, nSeries = 2},		-- boss
	[2] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3320>: tiêu dao trong cốc đích ngoại nhân thị càng ngày càng nhiều liễu, khi dễ quá ngã đệ đệ đích nhân cũng là càng ngày càng nhiều liễu. Ta cái này làm ca ca đích thực sự nhìn không được liễu, nhất định phải giáo huấn một chút các ngươi. Muốn làm niên sư phụ truyền thụ kỹ xảo thì, ta để ngã đệ đệ buông tha liễu học nghệ, thế nhưng sư phụ hắn lão nhân gia bị ta đích hành động sở cảm động, truyền thụ liễu hắn bất thái độ làm người biết đích một mặt cho ta. Ngày hôm nay ta sẽ cho các ngươi biết cái gì là sống không bằng chết."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.ADD_NPC, 2, 6, 0, "qinghua", "66_qinghua"},		-- tình hoa
	},
	tbUnLockEvent = {},
	},
	[2] = {nTime = 480, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "boss"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3320>: a! Đệ đệ a, ngươi đã đến rồi, khán ca ca giúp ngươi giáo huấn giá đàn. . Ghê tởm, dĩ nhiên sấn ta phân thần chi tế trốn liễu. Hanh! Các ngươi lần sau biệt lạc ở trong tay ta!"},
	{XoyoGame.DO_SCRIPT, "self. tbLock[3]:Close()"},},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 3, "boss", "66_huqian"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Hồ Càn"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3320>: bất! Giá điều không phải thực sự! Đệ đệ, làm ca ca đích xin lỗi ngươi, một có thể giúp ngươi báo thù! Sư phụ a, đồ nhi bất hiếu, cho ngài lão bôi đen liễu!"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "66_huqian"},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	},
	},
	}
	}
	tbRoom[67] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 5,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {59968 / 32, 74336 / 32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 3314, nLevel = -1, nSeries = 3},		-- tiểu quái 1
	[2] = {nTemplate = 3315, nLevel = -1, nSeries = 3},		-- tiểu quái 1
	[3] = {nTemplate = 3316, nLevel = -1, nSeries = 3},		-- boss
	[4] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trong truyền thuyết đích gian phòng? ? ! ! Lẽ nào chúng ta hựu gặp phải tiêu dao trong cốc đích cao nhân lạp? ?"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 4, 6, 0, "qinghua", "67_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3314>: lớn mật, nữ nhi gia đích khuê phòng trung đích khởi dung ngươi chờ thiện sấm! \n囧rz, quả nhiên là như thế này."},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	},
	[2] = {nTime = 0, nNum = 3,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 2, "guaiwu", "67_shinv_1_1"},
	{XoyoGame.ADD_NPC, 2, 2, 2, "guaiwu", "67_shinv_2_1"},
	{XoyoGame.TARGET_INFO, -1, "Giải thích với các cô nương ở đây"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Không làm? Tiếp tục."},
	},
	},
	[3] = {nTime = 0, nNum = 3,
	tbPrelock = {2},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 3, "guaiwu", "67_shinv_1_2"},
	{XoyoGame.ADD_NPC, 2, 2, 3, "guaiwu", "67_shinv_2_2"},
	{XoyoGame.TARGET_INFO, -1, "Không làm? Tiếp tục."},
	},
	tbUnLockEvent =
	{
	{XoyoGame.BLACK_MSG, -1, "Có thể tiếp tục."},
	},
	},
	[4] = {nTime = 0, nNum = 3,
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 4, "guaiwu", "67_shinv_1_3"},
	{XoyoGame.ADD_NPC, 2, 2, 4, "guaiwu", "67_shinv_2_3"},
	{XoyoGame.TARGET_INFO, -1, "Có thể tiếp tục."},
	},
	tbUnLockEvent = {},
	},
	[5] = {nTime = 5, nNum = 0,
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.CHANGE_TRAP, "67_trap", {58400 / 32, 74336 / 32}},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3316>: ôi uy, nghĩ không ra sẽ có ngoài cốc người đi tới ở đây, nếu là như thế này để ta hảo hảo hầu hạ các vị. \n- -b, ở đây đến tột cùng thị địa phương nào."},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 1,
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 6, "guaiwu", "67_boss"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Diệp Tịnh"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3316>: các vị thực sự là quá mạnh mẽ liễu, Haa, lần sau nhớ kỹ trở lại hoa ta ngoạn, Haa."},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[7]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "67_gouhuo"},
	{XoyoGame.CHANGE_TRAP, "67_trap", nil},
	},
	},
	[7] = {nTime = 600, nNum = 0,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn %s<color>", 7},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "guaiwu"},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=3316>: ôi, thời gian không còn sớm liễu, ta muốn đi phao ôn tuyền lạp. Các ngươi lần sau trở lại bồi ta ngoạn ba, haa."},
	{XoyoGame.DO_SCRIPT, "self. tbLock[6]:Close()"},
	{XoyoGame.CHANGE_TRAP, "67_trap", nil},
	},
	},
	}
	}
Require("\\script\\mission\\xoyogame\\carrot_room\\carrot.lua")
	-- bạt cây cải củ ( phối trí biểu đã đóng bế bản gian phòng, bởi vì gian phòng ngoạn gia không trở về huyết, dữ thái hồi huyết kỹ năng tương xung đột, nguyệt thái kỹ năng bất năng cắt bỏ )
	tbRoom[68] =
	{
	DerivedRoom		= XoyoGame.RoomCarrot;
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= XoyoGame.RoomCarrot. PlayerDeath,
	fnWinRule		= BaseRoom. PKWinRule2,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {49664/32, 94112/32},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 4000, nLevel = -1, nSeries = -1},		-- cây cải củ
	-- kỹ năng
	[2] = {nTemplate = 4290, nLevel = -1, nSeries = -1},
	[3] = {nTemplate = 4291, nLevel = -1, nSeries = -1},
	[4] = {nTemplate = 4292, nLevel = -1, nSeries = -1},
	[5] = {nTemplate = 4293, nLevel = -1, nSeries = -1},
	[6] = {nTemplate = 4294, nLevel = -1, nSeries = -1},
	-- bẩy rập
	[7] = {nTemplate = 4295, nLevel = -1, nSeries = -1},
	[8] = {nTemplate = 4296, nLevel = -1, nSeries = -1},
	[9] = {nTemplate = 4297, nLevel = -1, nSeries = -1},
	[10] = {nTemplate = 4298, nLevel = -1, nSeries = -1},
	[11] = {nTemplate = 4299, nLevel = -1, nSeries = -1},
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 20, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này tựa hồ là một người bạt cây cải củ thật là tốt địa phương..."},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.TRANSFORM_CHILD},
	{XoyoGame.CHANGE_CAMP, 1, 1},
	{XoyoGame.CHANGE_CAMP, 2, 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_CAMP},
	},
	},
	[2] = {nTime = 390 - 20 - 1, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.DO_SCRIPT, "self:BeginPick();"},
	{XoyoGame.DO_SCRIPT, "self:SetPlayerLife();"},
	{XoyoGame.MOVIE_DIALOG, -1, "Chẳng tòng na toát ra nhiều như vậy cây cải củ! Tiên bắt bọn nó ăn tươi hơn nữa."},
	{XoyoGame.TARGET_INFO, -1, "Bên ta có 0 La Bặc\nBên họ có 0 La Bặc"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian kéo La Bặc còn %s<color>", 2},
	{XoyoGame.ADD_NPC, 1, 4, 0, "carrot", "68_carrot", 20, 15, "add_carrot"},
	{XoyoGame.ADD_NPC, {2,3,4,5,6}, 4, 0, "skill", "68_skill", 20, 15, "add_skill"},
	{XoyoGame.ADD_NPC, {7,8,9,10,11}, 4, 0, "trap", "68_trap", 20, 15, "add_trap"},
	{XoyoGame.DO_SCRIPT, "self:Phrase1Logic();"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "carrot"},
	{XoyoGame.DEL_NPC, "skill"},
	{XoyoGame.DEL_NPC, "trap"},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.CHANGE_FIGHT, -1, 0, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.DO_SCRIPT, "self:FinishMsg()"},
	},
	},
	}
	}
Require("\\script\\mission\\xoyogame\\hide_and_seek\\hide_and_seek.lua");
	-- tróc tiểu thâu
	tbRoom[69] =
	{
	DerivedRoom		= XoyoGame.RoomHideAndSeek;
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,
	fnWinRule		= XoyoGame.RoomHideAndSeek. WinRule,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 6,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {{1880, 3447}, {1717, 3611}},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Nơi này là cười nhỏ da môn ngoạn tróc tiểu thâu đích địa phương, nếu đi tới ở đây tựu Cùng bọn họ cùng nhau ngoạn trò chơi."},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.TRANSFORM_CHILD_2},
	{XoyoGame.SET_SKILL, -1, 1430},
	{XoyoGame.DISABLE_SWITCH_SKILL, -1, 1},
	--{XoyoGame.SHOW_NAME_AND_LIFE, 0},
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_CAMP},
	},
	},
	[2] = {nTime = 390 - 15 - 1, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bảo Quả Tử, Nhị A, Tiểu Hà, Tiểu Sở giá bốn người gây sự quỷ đã giấu được rồi, bọn họ bốn người trung chỉ có một là thật chính đích tiểu thâu, ngươi yếu tại thời gian kết thúc tiền nắm hắn. Hoa đối đích hữu tưởng, tìm lộn liễu yếu bị phạt. Nếu như muốn biết ai là thực sự tiểu thâu, vậy đi hỏi tiểu thần đồng dịch chu Cùng tiểu cơ linh dịch phàm ba!"},
	--{XoyoGame.TIME_INFO, -1, "<color=green> chơi trốn kiếm thặng dư thời gian %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "Bắt 0 tên vô lại"},
	{XoyoGame.DO_SCRIPT, "self:NewRound()"}
	},
	tbUnLockEvent =
	{
	{XoyoGame.TARGET_INFO, -1, ""},
	--{XoyoGame.SHOW_NAME_AND_LIFE, 1},
	},
	},
	}
	}
	Require("\\script\\mission\\xoyogame\\invade\\invade.lua");
	-- kim quân xâm lấn
	tbRoom[70] =
	{
	DerivedRoom		= XoyoGame.RoomInvade,
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= XoyoGame.RoomInvade. WinRule,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 6,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {1670, 3650},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 4652, nLevel = -1, nSeries = -1},		-- môn a1
	[2] = {nTemplate = 4653, nLevel = -1, nSeries = -1},		-- môn a2
	[3] = {nTemplate = 4654, nLevel = -1, nSeries = -1},		-- môn b1
	[4] = {nTemplate = 4655, nLevel = -1, nSeries = -1},		-- môn b2
	[5] = {nTemplate = 4656, nLevel = -1, nSeries = -1},		-- chốt mở a1
	[6] = {nTemplate = 4657, nLevel = -1, nSeries = -1},		-- chốt mở a2
	[7] = {nTemplate = 4658, nLevel = -1, nSeries = -1},		-- chốt mở b1
	[8] = {nTemplate = 4659, nLevel = -1, nSeries = -1},		-- chốt mở b2
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Căn cứ thám tử hồi báo, kim quân đã tập kết ở cửa thành ngoại, tịnh binh chia làm hai đường chuẩn bị xâm chiếm bản thành, thỉnh các vị đại hiệp toàn lực đẩy lùi kim quân, vạn bất khả để cho bọn họ đánh tới nội cửa thành."},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 1, 1, 0, "gate_a1", "70_gate_a1"}, -- giá mấy người viết tại lv1 bên trong liễu
	{XoyoGame.ADD_NPC, 2, 1, 0, "gate_a2", "70_gate_a2"},
	{XoyoGame.ADD_NPC, 3, 1, 0, "gate_b1", "70_gate_b1"},
	{XoyoGame.ADD_NPC, 4, 1, 0, "gate_b2", "70_gate_b2"},
	{XoyoGame.ADD_NPC, 5, 1, 3, "switch_a1", "70_switch_a1"},
	{XoyoGame.ADD_NPC, 6, 1, 5, "switch_a2", "70_switch_a2"},
	{XoyoGame.ADD_NPC, 7, 1, 4, "switch_b1", "70_switch_b1"},
	{XoyoGame.ADD_NPC, 8, 1, 6, "switch_b2", "70_switch_b2"},
	{XoyoGame.NPC_CAN_TALK, "switch_a1", 0},
	{XoyoGame.NPC_CAN_TALK, "switch_a2", 0},
	{XoyoGame.NPC_CAN_TALK, "switch_b1", 0},
	{XoyoGame.NPC_CAN_TALK, "switch_b2", 0},
	{XoyoGame.CHANGE_TRAP, "to_trapA1", {1709, 3468}},
	{XoyoGame.CHANGE_TRAP, "to_trapA2", {1868, 3391}},
	{XoyoGame.CHANGE_TRAP, "to_trapB1", {1858, 3629}},
	{XoyoGame.CHANGE_TRAP, "to_trapB2", {1939, 3464}},
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_CAMP},
	},
	},
	[2] = {nTime = 630 - 15 - 1, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Trống trận đã vang lên, kim quân đã bắt đầu tiến công liễu!"},
	{XoyoGame.TARGET_INFO, -1, "Đẩy lùi quân xâm lược"},
	{XoyoGame.DO_SCRIPT, "self:AddJinJun();"}
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self:FinishMsg()"},
	--{XoyoGame.MOVIE_DIALOG, -1, "Nghĩ không ra kim quân như vậy hung hãn, dĩ nhiên một đường công phá nội thành, ta quân đã chiến bại!"},
	--{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	},
	},
	[3] = {nTime = 0, nNum = 1, -- switch_a1 -> trap_a1, gate_a1
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {
	{XoyoGame.DEL_NPC, "gate_a1"},
	{XoyoGame.CHANGE_TRAP, "to_trapA1", nil},
	},
	},
	[4] = {nTime = 0, nNum = 1, -- switch_b1 -> trap_b1, gate_b1
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {
	{XoyoGame.DEL_NPC, "gate_b1"},
	{XoyoGame.CHANGE_TRAP, "to_trapB1", nil},
	},
	},
	[5] = {nTime = 0, nNum = 1, -- switch_a2 -> trap_a2, gate_a2
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {
	{XoyoGame.DEL_NPC, "gate_a2"},
	{XoyoGame.CHANGE_TRAP, "to_trapA2", nil},
	},
	},
	[6] = {nTime = 0, nNum = 1, -- switch_b2 -> trap_b2, gate_b2
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {
	{XoyoGame.DEL_NPC, "gate_b2"},
	{XoyoGame.CHANGE_TRAP, "to_trapB2", nil},
	},
	},
	[7] = {nTime = 120 + 15, nNum = 0, -- a1, b1 tại trong khoảng thời gian này lúc mở ra
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {
	{XoyoGame.NPC_CAN_TALK, "switch_a1", 1},
	{XoyoGame.NPC_CAN_TALK, "switch_b1", 1},
	},
	},
	[8] = {nTime = 300 + 15, nNum = 0, -- a2, b2 tại trong khoảng thời gian này lúc mở ra
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent = {
	{XoyoGame.NPC_CAN_TALK, "switch_a2", 1},
	{XoyoGame.NPC_CAN_TALK, "switch_b2", 1},
	},
	},
	[9] = {nTime = 0, nNum = 0,
	tbPrelock = {1},
	tbStartEvent = {
	{XoyoGame.TIME_INFO, -1, "<color=green> trạm kiểm soát thặng dư thời gian: %s\n đạo thứ nhất cửa thành mở ra thời gian: %s\n đạo thứ hai cửa thành mở ra thời gian: %s<color>\n", {2, 7, 8}},
	}
	},
	}
	}
	Require("\\script\\mission\\xoyogame\\thief\\thief.lua");
	-- phi tặc
	tbRoom[71] =
	{
	DerivedRoom		= XoyoGame.RoomThief;
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 6,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {1600, 3784},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC = {},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.MOVIE_DIALOG, -1, "Đỉnh núi hữu quan phủ bộ khoái, chẳng lẽ là tại trảo phi tặc?"},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.CHANGE_CAMP, 1, 1},
	},
	tbUnLockEvent =
	{
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_CAMP},
	},
	},
	[2] = {nTime = 630 - 15 - 1, nNum = 0,		-- tính theo thời gian
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Phi tặc bả tang vật giao cho liễu một người tên là trương đức hằng đích nhân, bắt được hắn đoạt lại thanh hoa bình sứ."},
	{XoyoGame.TIME_INFO, -1, "<color=green> thặng dư thời gian %s<color>", 2},
	{XoyoGame.TARGET_INFO, -1, "<color=red> tương phi tặc cản nhập quan phủ đích mai phục quyển \n tìm ra trương đức hằng đoạt lại thanh hoa bình sứ <color>"},
	{XoyoGame.DO_SCRIPT, "self:AddThief()"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "if self:IsWin() == 1 then self. tbTeam[1]. bIsWiner = 1 end"},
	{XoyoGame.DO_SCRIPT, [[
	if self:IsWin() == 1 then
	self:MovieDialog(-1, "Tất cả cáo một đoạn lạc, nghỉ ngơi một chút kế tục chúng ta đích lữ trình.");
	else
	self:MovieDialog(-1, "Một có thể nhân tang tịnh lấy được, thực sự là thất bại trong gang tấc a!");
	end
	]]},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	},
	}
	}
	-- trong bảo khố ngọc (boss)
	tbRoom[72] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 5,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 6,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {1564, 3506},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 4665, nLevel = -1, nSeries = 1},		-- trong bảo khố ngọc
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bất tri bất giác trung, đã đi tới tiêu dao cốc ở chỗ sâu trong, phía trước có tọa tòa nhà lớn."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 600, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4665>: \"Hơi chút sống giật mình gân cốt, cho các ngươi lĩnh giáo một chút tiêu dao cốc đại công tử đích lợi hại. .\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 1,
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4665>: \"Người tới người nào dám thiện sấm tiêu dao cốc, lộng lẫy viên khởi là các ngươi nói đến là đến nói đi là đi đích! ! !\""},
	{XoyoGame.ADD_NPC, 1, 1, 3, "guaiwu", "72_baoyu"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Bảo Ngọc"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4665>: \"Các ngươi quả nhiên thật sự có tài, bản công tử ngày hôm nay nhận thức tài liễu.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "72_gouhuo"},
	},
	},
	}
	}
	-- oanh oanh (boss)
	tbRoom[73] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 4,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 4,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {1852, 3879},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 4666, nLevel = -1, nSeries = 3},		-- oanh oanh
	[2] = {nTemplate = 4667, nLevel = -1, nSeries = -1},		-- lão mụ tử
	[3] = {nTemplate = 6563, nLevel = -1, nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "Bất tri bất giác trung đi tới một mảnh hoa khai liễu lục đích khu vực, chung quanh đi dạo tiên."},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	{XoyoGame.ADD_NPC, 3, 6, 0, "qinghua", "73_qinghua"},		-- tình hoa
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 480, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent = {},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4666>: \"Cho các ngươi biết bản tiểu thư đích lợi hại, dám ở tiêu dao trong cốc dương oai đích nhân thật đúng là không nhiều lắm kiến.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 14,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4666>: \"Trương mụ lý mụ, nhìn phía trước đám kia nhân là cái gì địa vị.\""},
	{XoyoGame.ADD_NPC, 2, 14, 3, "guaiwu", "73_laomazi"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Lão Ma Tử"},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4666>: \"Các ngươi muốn làm gì, không nên ép đắc bản tiểu thư xuất thủ điều không phải?\""},
	{XoyoGame.ADD_NPC, 1, 1, 4, "guaiwu", "73_yingying"},
	{XoyoGame.TARGET_INFO, -1, "Đánh bại Oanh Oanh"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4666>: \"Hanh! Ta phải đi về hoa cha cáo trạng khứ, các ngươi trốn không thoát.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "73_gouhuo"},
	},
	},
	}
	}
	-- tín xuân ca đắc sống mãi
	tbRoom[74] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 2,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 2,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {1628, 3079},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 4668, nLevel = -1, nSeries = -1},		-- củi đốt
	[2] = {nTemplate = 4669, nLevel = -1, nSeries = -1},		-- liệt hỏa
	[3] = {nTemplate = 4670, nLevel = -1, nSeries = -1},		-- công tượng đồ đệ
	[4] = {nTemplate = 4671, nLevel = -1, nSeries = -1},		-- công tượng sư phụ
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 1, 0, "tudi", "74_gongjiangtudi"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Mệt mỏi quá a, mỗi ngày đều có kiền bất tận đích sống.\""},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 240, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Sư phụ không ở, chúng ta cảo điểm hoạt động tiêu khiển hạ ba, bên kia hữu kỷ đôi hỏa, các ngươi giúp ta điểm đứng lên.\""},
	{XoyoGame.TARGET_INFO, -1, "Trợ giúp Công Tượng Đồ Đệ đốt lửa"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Các ngươi không đáng tin cậy, chính ta chính đến đây đi.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "liehuo"},
	},
	},
	[3] = {nTime = 0, nNum = 1,		-- lửa trại 1
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 3, "ganchai1", "74_chun1"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai1"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun1"},
	},
	},
	[4] = {nTime = 0, nNum = 1,		-- lửa trại 2
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 4, "ganchai2", "74_chun2"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai2"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun2"},
	},
	},
	[5] = {nTime = 0, nNum = 1,		-- lửa trại 3
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 5, "ganchai3", "74_chun3"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai3"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun3"},
	},
	},
	[6] = {nTime = 0, nNum = 1,		-- lửa trại 4
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 6, "ganchai4", "74_chun4"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai4"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun4"},
	},
	},
	[7] = {nTime = 0, nNum = 1,		-- lửa trại 5
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 7, "ganchai5", "74_chun5"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai5"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun5"},
	},
	},
	[8] = {nTime = 0, nNum = 1,		-- lửa trại 6
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 8, "ganchai6", "74_chun6"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai6"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun6"},
	},
	},
	[9] = {nTime = 0, nNum = 1,		-- lửa trại 7
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 9, "ganchai7", "74_chun7"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai7"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun7"},
	},
	},
	[10] = {nTime = 0, nNum = 1,		-- lửa trại 8
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 10, "ganchai8", "74_chun8"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai8"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun8"},
	},
	},
	[11] = {nTime = 0, nNum = 1,		-- lửa trại 9
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 11, "ganchai9", "74_chun9"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai9"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun9"},
	},
	},
	[12] = {nTime = 0, nNum = 1,		-- lửa trại 10
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 12, "ganchai10", "74_chun10"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai10"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun10"},
	},
	},
	[13] = {nTime = 0, nNum = 1,		-- lửa trại 11
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 13, "ganchai11", "74_chun11"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai11"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun11"},
	},
	},
	[14] = {nTime = 5, nNum = 0,		-- giai đoạn nghỉ ngơi
	tbPrelock = {3,4,5,6,7,8,9,10,11,12,13},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Nghỉ ngơi một chút, chúng ta tái kế tục.\""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Trở lại trở lại.\""},
	},
	},
	[15] = {nTime = 0, nNum = 1,		-- lửa trại 12
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 15, "ganchai12", "74_chun12"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai12"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun12"},
	},
	},
	[16] = {nTime = 0, nNum = 1,		-- lửa trại 13
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 16, "ganchai13", "74_chun13"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai13"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun13"},
	},
	},
	[17] = {nTime = 0, nNum = 1,		-- lửa trại 14
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 17, "ganchai14", "74_chun14"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai14"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun14"},
	},
	},
	[18] = {nTime = 0, nNum = 1,		-- lửa trại 15
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 18, "ganchai15", "74_chun15"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai15"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun15"},
	},
	},
	[19] = {nTime = 0, nNum = 1,		-- lửa trại 16
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 19, "ganchai16", "74_chun16"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai16"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun16"},
	},
	},
	[20] = {nTime = 0, nNum = 1,		-- lửa trại 17
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 20, "ganchai17", "74_chun17"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai17"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun17"},
	},
	},
	[21] = {nTime = 0, nNum = 1,		-- lửa trại 18
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 21, "ganchai18", "74_chun18"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai18"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun18"},
	},
	},
	[22] = {nTime = 0, nNum = 1,		-- lửa trại 19
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 22, "ganchai19", "74_chun19"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai19"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun19"},
	},
	},
	[23] = {nTime = 0, nNum = 1,		-- lửa trại 20
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 23, "ganchai20", "74_chun20"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai20"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun20"},
	},
	},
	[24] = {nTime = 0, nNum = 1,		-- lửa trại 21
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 24, "ganchai21", "74_chun21"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai21"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun21"},
	},
	},
	[25] = {nTime = 0, nNum = 1,		-- lửa trại 22
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 25, "ganchai22", "74_chun22"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai22"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun22"},
	},
	},
	[26] = {nTime = 5, nNum = 0,		-- giai đoạn nghỉ ngơi
	tbPrelock = {15,16,17,18,19,20,21,22,23,24,25},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Nghỉ ngơi một chút, chúng ta tái kế tục.\""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Không ngừng cố gắng, cũng nhanh hoàn thành liễu.\""},
	},
	},
	[27] = {nTime = 0, nNum = 1,		-- lửa trại 23
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 27, "ganchai23", "74_chun23"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai23"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun23"},
	},
	},
	[28] = {nTime = 0, nNum = 1,		-- lửa trại 24
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 28, "ganchai24", "74_chun24"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai24"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun24"},
	},
	},
	[29] = {nTime = 0, nNum = 1,		-- lửa trại 25
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 29, "ganchai25", "74_chun25"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai25"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun25"},
	},
	},
	[30] = {nTime = 0, nNum = 1,		-- lửa trại 26
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 30, "ganchai26", "74_chun26"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai26"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun26"},
	},
	},
	[31] = {nTime = 0, nNum = 1,		-- lửa trại 27
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 31, "ganchai27", "74_chun27"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai27"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun27"},
	},
	},
	[32] = {nTime = 0, nNum = 1,		-- lửa trại 28
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 32, "ganchai28", "74_chun28"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai28"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun28"},
	},
	},
	[33] = {nTime = 0, nNum = 1,		-- lửa trại 29
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 33, "ganchai29", "74_chun29"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai29"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun29"},
	},
	},
	[34] = {nTime = 0, nNum = 1,		-- lửa trại 30
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 34, "ganchai30", "74_chun30"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai30"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun30"},
	},
	},
	[35] = {nTime = 0, nNum = 1,		-- lửa trại 31
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 35, "ganchai31", "74_chun31"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai31"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun31"},
	},
	},
	[36] = {nTime = 0, nNum = 1,		-- lửa trại 32
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 36, "ganchai32", "74_chun32"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai32"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun32"},
	},
	},
	[37] = {nTime = 0, nNum = 1,		-- lửa trại 33
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 37, "ganchai33", "74_chun33"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "ganchai33"},
	{XoyoGame.ADD_NPC, 2, 1, 0, "liehuo", "74_chun33"},
	},
	},
	[38] = {nTime = 30, nNum = 0,
	tbPrelock = {27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4670>: \"Đều hoàn thành liễu, ta đích kiệt tác đẹp. Tín xuân ca, đắc sống mãi, tâm tình khoái trá bắt đi.\""},
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "74_gouhuo"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DEL_NPC, "liehuo"},
	},
	},
	}
	}
	-- quân kỳ thao diễn
	tbRoom[75] =
	{
	fnPlayerGroup 	= nil,						-- ngoạn gia chia tổ hàm số, bất điền tắc cam chịu 1 chi đội ngũ 1 một quần thể
	fnDeath			= nil,						-- gian phòng tử vong kịch bản gốc; bất điền tắc cam chịu
	fnWinRule		= nil,						-- thắng lợi điều kiện, thi đua loại đích gian phòng cần trọng định nghĩa, cái khác giống nhau không cần điền
	nRoomLevel		= 3,						-- gian phòng đẳng cấp (1~5)
	nMapIndex		= 3,						-- địa đồ tổ đích hướng dẫn tra cứu
	tbBeginPoint	= {1495, 2772},	-- lúc đầu điểm, cách thức căn cứ fnPlayerGroup nhu cầu mà định, cam chịu thị {nX,nY}
	-- gian phòng liên quan đến đích NPC chủng loại
	NPC =
	{
	-- 		Đánh số 	npc gỗ cốp pha 				Đẳng cấp (-1 cam chịu )	5 đi ( cam chịu -1)
	-- E. g [0] = {nTemplate, 			nLevel, 		nSeries }
	[1] = {nTemplate = 4672, nLevel = -1, nSeries = -1},		-- tiêu dao cốc huấn luyện viên
	[2] = {nTemplate = 4673, nLevel = -1, nSeries = -1},		-- tiêu dao cốc quân kỳ
	[3] = {nTemplate = 4674, nLevel = -1, nSeries = -1},		-- hộ kỳ vệ binh
	[4] = {nTemplate = 6563, nLevel = -1, 	nSeries = -1}, 		-- tình hoa
	},
	-- tỏa kết cấu
	LOCK =
	{
	-- 1 hào tỏa không thể không điền, cam chịu 1 hào vi lúc đầu tỏa
	[1] = {nTime = 15, nNum = 0,
	tbPrelock = {},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 1, 1, 1, "jiaotou", "75_jiaotou"},
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Ta quân lũ chiến lũ bại, cứu kỳ nguyên nhân hay quân kỷ bất nghiêm, quân uy không phấn chấn.\""},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian chuẩn bị: %s<color>", 1},
	{XoyoGame.ADD_NPC, 4, 3, 0, "qinghua", "75_qinghua"},		-- tình hoa
	{XoyoGame.TARGET_INFO, -1, ""},
	},
	tbUnLockEvent =
	{
	},
	},
	[2] = {nTime = 360, nNum = 0,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.TARGET_INFO, -1, "Hoàn thành sáu đạo quân lệnh đích thao diễn"},
	{XoyoGame.TIME_INFO, -1, "<color=green>Thời gian còn lại: %s<color>", 2},
	{XoyoGame.CHANGE_FIGHT, -1, 1, Player. emKPK_STATE_PRACTISE},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Ai, xem ra các ngươi còn cần ta thao luyện.\""},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ thất bại"},
	{XoyoGame.DEL_NPC, "guaiwu"},
	},
	},
	[3] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {1},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Đạo thứ nhất quân lệnh: hữu biên đích ngôi cao hữu một mặt quân kỳ, tốc tốc cho ta mang tới.\""},
	{XoyoGame.ADD_NPC, 2, 1, 3, "guaiwu", "75_junqi4"},
	},
	tbUnLockEvent = {},
	},
	[4] = {nTime = 0, nNum = 3,		-- tổng cộng thì
	tbPrelock = {3},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 3, 4, "guaiwu", "75_weibing11"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Đạo thứ hai quân lệnh: bên trái đích ngôi cao hữu một mặt quân kỳ, tốc tốc cho ta mang tới.\""},
	},
	},
	[5] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {4},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 5, "guaiwu", "75_junqi7"},
	},
	tbUnLockEvent = {},
	},
	[6] = {nTime = 0, nNum = 5,		-- tổng cộng thì
	tbPrelock = {5},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 5, 6, "guaiwu", "75_weibing21"},
	},
	tbUnLockEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Đạo thứ ba quân lệnh: hai bên trái phải đích ngôi cao các hữu một mặt quân kỳ, tốc tốc cho ta mang tới.\""},
	},
	},
	[7] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {6},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 7, "guaiwu", "75_junqi2"},
	},
	tbUnLockEvent = {},
	},
	[8] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {7},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 8, "guaiwu", "75_weibing31"},
	},
	tbUnLockEvent = {},
	},
	[9] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {6},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 9, "guaiwu", "75_junqi8"},
	},
	tbUnLockEvent = {},
	},
	[10] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {9},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 10, "guaiwu", "75_weibing32"},
	},
	tbUnLockEvent = {},
	},
	[11] = {nTime = 5, nNum = 0,		-- tổng cộng thì
	tbPrelock = {8,10},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Đạo thứ tư quân lệnh: hai bên trái phải đích ngôi cao các hữu một mặt quân kỳ, tốc tốc cho ta mang tới.\""},
	},
	tbUnLockEvent = {},
	},
	[12] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {11},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 12, "guaiwu", "75_junqi1"},
	},
	tbUnLockEvent = {},
	},
	[13] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {12},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 13, "guaiwu", "75_weibing41"},
	},
	tbUnLockEvent = {},
	},
	[14] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {11},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 14, "guaiwu", "75_junqi6"},
	},
	tbUnLockEvent = {},
	},
	[15] = {nTime = 0, nNum = 5,		-- tổng cộng thì
	tbPrelock = {14},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 5, 15, "guaiwu", "75_weibing42"},
	},
	tbUnLockEvent = {},
	},
	[16] = {nTime = 5, nNum = 0,		-- tổng cộng thì
	tbPrelock = {13,15},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Đệ ngũ nói quân lệnh: hai bên đích ngôi cao cùng sở hữu ba mặt quân kỳ, tốc tốc cho ta mang tới.\""},
	},
	tbUnLockEvent = {},
	},
	[17] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {16},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 17, "guaiwu", "75_junqi3"},
	},
	tbUnLockEvent = {},
	},
	[18] = {nTime = 0, nNum = 3,		-- tổng cộng thì
	tbPrelock = {17},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 3, 18, "guaiwu", "75_weibing51"},
	},
	tbUnLockEvent = {},
	},
	[19] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {16},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 19, "guaiwu", "75_junqi5"},
	},
	tbUnLockEvent = {},
	},
	[20] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {19},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 20, "guaiwu", "75_weibing52"},
	},
	tbUnLockEvent = {},
	},
	[21] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {16},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 21, "guaiwu", "75_junqi7"},
	},
	tbUnLockEvent = {},
	},
	[22] = {nTime = 0, nNum = 5,		-- tổng cộng thì
	tbPrelock = {21},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 5, 22, "guaiwu", "75_weibing53"},
	},
	tbUnLockEvent = {},
	},
	[23] = {nTime = 5, nNum = 0,		-- tổng cộng thì
	tbPrelock = {18,20, 22},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Thứ sáu nói quân lệnh: hai bên đích ngôi cao các hữu hai mặt quân kỳ, tốc tốc cho ta mang tới.\""},
	},
	tbUnLockEvent = {},
	},
	[24] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {23},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 24, "guaiwu", "75_junqi2"},
	},
	tbUnLockEvent = {},
	},
	[25] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {24},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 25, "guaiwu", "75_weibing61"},
	},
	tbUnLockEvent = {},
	},
	[26] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {23},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 26, "guaiwu", "75_junqi4"},
	},
	tbUnLockEvent = {},
	},
	[27] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {26},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 27, "guaiwu", "75_weibing62"},
	},
	tbUnLockEvent = {},
	},
	[28] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {23},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 28, "guaiwu", "75_junqi6"},
	},
	tbUnLockEvent = {},
	},
	[29] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {28},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 29, "guaiwu", "75_weibing63"},
	},
	tbUnLockEvent = {},
	},
	[30] = {nTime = 0, nNum = 1,		-- tổng cộng thì
	tbPrelock = {23},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 2, 1, 30, "guaiwu", "75_junqi8"},
	},
	tbUnLockEvent = {},
	},
	[31] = {nTime = 0, nNum = 4,		-- tổng cộng thì
	tbPrelock = {30},
	tbStartEvent =
	{
	{XoyoGame.ADD_NPC, 3, 4, 31, "guaiwu", "75_weibing64"},
	},
	tbUnLockEvent = {},
	},
	[32] = {nTime = 5, nNum = 0,
	tbPrelock = {25, 27, 29, 31},
	tbStartEvent =
	{
	{XoyoGame.MOVIE_DIALOG, -1, "<npc=4672>: \"Nếu như bộ hạ đều như các ngươi như vậy ưu tú, nhất định thành tựu một phen kinh thiên đại nghiệp.\""},
	},
	tbUnLockEvent =
	{
	{XoyoGame.DO_SCRIPT, "self. tbTeam[1]. bIsWiner = 1"},		-- hoàn thành nhiệm vụ thiết trí tiêu chí
	{XoyoGame.DO_SCRIPT, "self. tbLock[2]:Close()"},
	{XoyoGame.CLOSE_INFO, -1},
	{XoyoGame.TARGET_INFO, -1, "Nhiệm vụ hoàn thành"},
	{XoyoGame.ADD_GOUHUO, 2, 150, "gouhuo", "75_gouhuo"},
	},
	},
	}
	}
