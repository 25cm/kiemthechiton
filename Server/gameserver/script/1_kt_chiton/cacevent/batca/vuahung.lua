local tbTrong = Npc:GetClass("gu");
tbTrong.tbItemInfo = {bForceBind=1,};
function tbTrong:OnDialog()
DoScript("\\script\\event\\cacevent\\batca\\vuahung.lua");
if me.szName == "THKAdminGSZ" then
	KDialog.MsgToGlobal("<color=yellow>Tiếng trống vang lên báo hiệu <color=green>Giặc Ngoại Xâm<color> đã bị tiêu diệt khi tấn công vào <color=green>Đại Lý Phủ<color>, các nhân sĩ mau chóng tới <color=green>Chiến Trường Cổ<color> <pos=30,1645,3985> <color=yellow> chuẩn bị đột nhập cướp <color=green>Quân Lương<color> của chúng <pos=30,1959,3864>!<color>");	
return
end
end