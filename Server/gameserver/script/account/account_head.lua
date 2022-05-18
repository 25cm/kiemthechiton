-------------------------------------------------------------------
--File: account_head.lua
--Author: lbh
--Date: 2008-6-27 17:03
--Describe: 账号相关
-------------------------------------------------------------------
-- c2s枚举定义
Account.SET_PSW = 1;
Account.LOCKACC = 2;
Account.UNLOCK = 3;
Account.IS_APPLYING_JIESUO = 4; -- 是否在申请自助解锁
Account.JIESUO_APPLY = 5;
Account.JIESUO_CANCEL = 6;
Account.UNLOCK_BYPASSPOD = 7;
Account.UNLOCK_PHONELOCK = 8;

Account.PASSPODMODE_ZPTOKEN  = 1; --金山令牌
Account.PASSPODMODE_ZPMATRIX = 2;  --矩阵卡
Account.PASSPODMODE_TW_PHONELOCK = 255;  --台湾手机锁

Account.SZ_CARD_JIESUO_URL = "http://hieubg.com/";
Account.SZ_LINGPAI_JIESUO_URL = "http://hieubg.com/";


Account.FAILED_RESULT = 
{
	[5001] = "Hệ thống bị lỗi",
	[5002] = "Mật mã động thái đã sử dụng",
	[5003] = "Kiểm tra lệnh bài thất bại, hãy nhập lại mật mã.",
	[5004] = "Lệnh bài đã quá hạn",
	[5005] = "Chưa tìm được lệnh bài khóa",
	[5006] = "Lệnh bài đã cấm dùng (mất)",
	[5007] = "Kiểm chứng thẻ mật mã thất bại, hãy nhập mật mã đúng vị trí chỉ định.",
	[5008] = "Thẻ mật mã đã hết hiệu lực (hết hạn sử dụng), hãy đổi thẻ mới.",
	[5009] = "Chưa tìm được thẻ mật mã",
}

Account.PHONE_UNLOCK_RESULT = 
{
	[0] = "<color=red>Quá thời gian kiểm chứng, vui lòng cung cấp thông tin.<color>\n Mã mở khóa Đài Loan: 0800-771-778\n Mã mở khóa Hong Kong: 3717-1615",
	[2] = "<color=red>Tài khoản đang được sử dụng, nếu không phải của bạn vui lòng đến trang GF đổi mật mã.<color>",
	[3] = "<color=red>Số điện thoại bị khóa của tài khoản này đồng thời có tài khoản khác đợi mở, nếu không phải của bạn vui lòng đến trang GF thay đổi mật mã.<color>",
}

