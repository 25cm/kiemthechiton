-------------------------------------------------------------------
--File: playerprofile_gs.lua
--Author: Brianyao
--Date: 2008-9-24 11:17
--Describe: Gameserver玩家信息逻辑
-------------------------------------------------------------------

if not PProfile then --调试需要
	PProfile = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
else
	if not MODULE_GAMESERVER then
		return
	end
end

PProfile.c2sFun = {}
--注册能被客户端直接调用的函数
local function RegC2SFun(szName, fun)
	PProfile.c2sFun[szName] = fun
end

--修改记录，nOper对应PROFILE_STR_INFOXXXX , szStr 为字符串
function PProfile:ApplyEditStrInfo(nOper, szStr)

         local bCheckSuc = 0
         local nLen = #szStr
         

         
         if (nOper == self.emPF_BUFTASK_NAME)      then
             if nLen <= self.MAX_REAL_NAME_LEN then 
                bCheckSuc = 1
             else
                me.Msg("Độ dài của tên không đáp ứng yêu cầu")
             end
             
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("Câu bất hợp pháp trong tên")
                bCheckSuc = 0
             end     
         
         elseif (nOper == self.emPF_BUFTASK_AGNAME)     then
             if nLen <= self.MAX_NICK_NAME_LEN then 
                bCheckSuc = 1
             else
                me.Msg("Độ dài của biệt hiệu không đáp ứng yêu cầu")
             end
             
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("Câu bất hợp pháp trong biệt hiệu")
                bCheckSuc = 0
             end   
             
         elseif (nOper == self.emPF_BUFTASK_PROFESSION) then
             if nLen <= self.MAX_PROFESSION_LEN then 
                bCheckSuc = 1
             else
                me.Msg("职业长度不符合要求")
             end
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("职业中含有非法语句")
                bCheckSuc = 0
             end
             
         elseif (nOper == self.emPF_BUFTASK_CITY)       then
             if nLen <= self.MAX_CITY_LEN then 
                bCheckSuc = 1
             else
                me.Msg("城市长度不符合要求")
             end
             
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("城市中含有非法语句")
                bCheckSuc = 0
             end
             
         elseif (nOper == self.emPF_BUFTASK_TAG )       then
             if nLen <= self.MAX_SLEFTIPS_LEN then 
                bCheckSuc = 1
             else
                me.Msg("口头禅长度不符合要求")
             end
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("口头禅中含有非法语句")
                bCheckSuc = 0
             end
             
         elseif (nOper == self.emPF_BUFTASK_FAVORITE )  then
             if nLen <= self.MAX_FAVOR_LEN then 
                bCheckSuc = 1
             else
                me.Msg("爱好长度不符合要求")
             end
             
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("爱好中含有非法语句")
                bCheckSuc = 0
             end
             
         elseif (nOper == self.emPF_BUFTASK_BLOGURL )   then
             if nLen <= self.MAX_BLOG_LEN then 
                bCheckSuc = 1
             else
                me.Msg("博客长度不符合要求")
             end
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("博客中含有非法语句")
                bCheckSuc = 0
             end
             
         elseif (nOper == self.emPF_BUFTASK_COMMENT )   then
             if nLen <= self.MAX_DIARY_LEN then 
                bCheckSuc = 1
             else
                me.Msg("点点滴滴长度不符合要求")
             end
             if ( IsNamePass(szStr) ~=1 )       then
                me.Msg("点点滴滴中含有非法语句")
                bCheckSuc = 0
             end
         end

         if (bCheckSuc==1) then
             GCExcute{"PProfile:ApplyEditStrInfoGS",nOper,szStr,me.szName}
	 return
	 end
end
RegC2SFun("EditStr", PProfile.ApplyEditStrInfo)

--修改记录，nOper对应PROFILE_INT_INFOXXXX , nParam 为值
function PProfile:ApplyEditIntInfo(nOper, nParam)

         local nCheckSuc = 0
         
         if (nOper >= self.emPF_TASK_SEX and nOper <= self.emPF_TASK_FRIEND_ONLY ) then
             nCheckSuc = 1
         end
       
         if (nCheckSuc == 1) then -- 规则通过 then
              GCExcute{"PProfile:ApplyEditIntInfoGS", nOper,me.szName, nParam}
         else
              return 0
         end

	 return 1
end
RegC2SFun("EditInt", PProfile.ApplyEditIntInfo)

function PProfile:ApplyEditAllInfo(nSex,nBirth,nReins,nOnline,nFriendOnly,szRealName,szAGName,szProfession,szCity,szTag,szFavorite,szBLOGURL,szComment)
         
         if ( szRealName~= "" and szAGName~="" and szProfession~="" and szCity~="" and szTag~="" and szFavorite~="" and szBLOGURL~="" and szComment~="") then 
            --First Time Gift Here
            GCExcute{"PProfile:ApplyFirstTimeGift", me.szName}
         end       
         
         PProfile:ApplyEditIntInfo(self.emPF_TASK_SEX,nSex)
         PProfile:ApplyEditIntInfo(self.emPF_TASK_BIRTHD,nBirth)
         PProfile:ApplyEditIntInfo(self.emPF_TASK_REINS,nReins)
         PProfile:ApplyEditIntInfo(self.emPF_TASK_ONLINE,nOnline)
         PProfile:ApplyEditIntInfo(self.emPF_TASK_FRIEND_ONLY,nFriendOnly)
         
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_NAME,szRealName)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_AGNAME,szAGName)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_PROFESSION,szProfession)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_CITY,szCity)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_TAG,szTag)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_FAVORITE,szFavorite)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_BLOGURL,szBLOGURL)
         PProfile:ApplyEditStrInfo(self.emPF_BUFTASK_COMMENT,szComment)
         
end
RegC2SFun("EditAll", PProfile.ApplyEditAllInfo)

function PProfile:ApplyFirstTimeGiftRet(szPlayerName)
    local pPlayer = KPlayer.SearchPlayer(szPlayerName)
    if   (pPlayer~=nil) then
          pPlayer.AddBindCoin(100, Player.emKBINDCOIN_ADD_HELP_QUESTION) --第一次的奖励
          pPlayer.Msg(string.format("您完整地填写您的真实信息，系统给予了您奖励100绑定%s!", IVER_g_szCoinName))
    end
end