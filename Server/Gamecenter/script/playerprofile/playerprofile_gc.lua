-------------------------------------------------------------------
--File: playerprofile_gc.lua
--Author: Brianyao
--Date: 2008-9-24 14:57
--Describe: gamecenter 玩家信息
-------------------------------------------------------------------
if not PProfile then --调试需要
	PProfile = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
else
	if not MODULE_GC_SERVER then
		return
	end
end

--已经在服务器Check过逻辑了，这里只是做数据修改
function PProfile:ApplyEditStrInfoGS(nOper,szStr,szPlayerName)
         local pPProfile = nil
         local nRet      = 0
         
         pPProfile,nRet = KPProfile.GetPlayerProfileByName(szPlayerName)
         
         if (nRet==1) then
         
             if pPProfile == nil then 
                 KPProfile.CreateProfileByPlayerName(szPlayerName)
                 pPProfile = KPProfile.GetPlayerProfileByName(szPlayerName)
             end
             
             if (pPProfile ~= nil) then
                 local nTaskID = nOper
                 local nTaskValue = szStr
                 pPProfile.SetTaskBuff(nTaskID,nTaskValue)
             else
                 print("Profile Create Failed",szPlayerName)
             end
             
         end
         
	 return 1
end

--已经在服务器Check过逻辑了，这里只是做数据修改
function PProfile:ApplyEditIntInfoGS(nOper,szName,nParam)
         local pPProfile = nil
         local nRet = 0
         
         pPProfile,nRet = KPProfile.GetPlayerProfileByName(szName)
         if (nRet==1) then
         
             if pPProfile == nil then 
                 KPProfile.CreateProfileByPlayerName(szName)
                 pPProfile = KPProfile.GetPlayerProfileByName(szName)
             end
             
             if (pPProfile ~= nil) then
                 local nTaskID = nOper
                 local nTaskValue = nParam
                 pPProfile.SetTaskValue(nTaskID,nTaskValue)
             else 
                 print("Profile Create Failed",szName)
             end
             
         end
         
	 return 1
end

function PProfile:ApplyFirstTimeGift(szName)
       local pPProfile = nil
       local nRet = 0
       
       pPProfile,nRet = KPProfile.GetPlayerProfileByName(szName)
       if (nRet==1) then

             if pPProfile == nil then  -- 第一次修改
                  KPProfile.CreateProfileByPlayerName(szName)
                  pPProfile = KPProfile.GetPlayerProfileByName(szName)
                 
                  if (pPProfile ~= nil) then
                      GlobalExcute{"PProfile:ApplyFirstTimeGiftRet", szName}
                  end
             end       
             
       end
end
