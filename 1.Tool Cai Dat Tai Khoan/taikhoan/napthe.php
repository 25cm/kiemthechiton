<?php
error_reporting(E_ALL & ~E_NOTICE & ~8192);  
session_start();
define('IN_ECS', true);
include_once("inc/#config.php");
if($_SESSION['user_login'] == NULL) { die("<center>Bạn phải đăng nhập trước !</center>"); }
else {
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Nạp thẻ - Kiếm Thế Chí Tôn</title>

<!--Nếu có jquery rồi không thêm code này-->
<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js"></script>
</head>
<body>
<table cellspacing="0" style="width:100%;border:none;">
  <tbody>
    <tr valign="top">
      <td width="85%" valign="top"><div class="CardFormCont">
          <!--<form method="POST" id="payCardNL" name="formPayCardNL" action="https://www.nganluong.vn/mobile_card.api.post.v2.php">-->
		  <form method="POST" id="payCardNL" name="formPayCardNL" action="./mobile_card.api.post.test.v2.php">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
              <tbody>
                <tr>
                  <td colspan="2"><div style="clear:both" id="hehe"></div></td>
                </tr>
                <tr valign="top">
                  <th> <span class="redfont">*</span> Loại thẻ: </th>
                  <td style="padding:5px;"><div class="cardtype">
                      <label for="type_card1"><img src="https://www.nganluong.vn/webskins/skins/nganluong/micro_checkout/images/logo-mobifone.png" ></label>
                      <input type="radio" name="type_card" value="VMS" id="type_card1" checked="checked">
                    </div>
                    <div class="cardtype">
                      <label for="type_card2"><img src="https://www.nganluong.vn/webskins/skins/nganluong/micro_checkout/images/logo-vinaphone.png"></label>
                      <input type="radio" name="type_card" value="VNP" id="type_card2">
                    </div>
                    <div class="cardtype">
                      <label for="type_card3"><img src="https://www.nganluong.vn/webskins/skins/nganluong/micro_checkout/images/logo-viettel.png"></label>
                      <input type="radio" name="type_card" value="VIETTEL" id="type_card3">
                    </div>
                    <div class="cardtype">
                      <label for="type_card4"><img src="https://www.nganluong.vn/webskins/skins/nganluong/deposit_style/images/gate.png" alt="Thẻ gate"></label>
                      <input type="radio" name="type_card" value="GATE" id="type_card4">
                    </div>
                    <div class="cardtype">
                      <label for="type_card5"><img src="https://www.nganluong.vn/webskins/skins/nganluong/deposit_style/images/vcoin.png" alt="Thẻ vcoin"></label>
                      <input type="radio" name="type_card" value="VCOIN" id="type_card5">
                    </div></td>
                </tr>
                <tr valign="top">
                  <th> <span class="redfont">*</span> Tên tài khoản: </th>
                  <td style="padding:5px;"><input type="text" name="ref_code" id="ref_code"  value="<?=$_SESSION['user_login']?>" disabled="disabled" style="width:365px;height:23px;"></td>
                </tr>
                <tr valign="top">
                  <th> <span class="redfont">*</span> Mã thẻ: </th>
                  <td style="padding:5px;"><input type="text" style="width:365px;height:23px;" name="pin_card" id="pin_card" maxlength="14"></td>
                </tr>
                <tr valign="top">
                  <th> <span class="redfont">*</span> Số serial: </th>
                  <td style="padding:5px;"><input type="text" style="width:365px;height:23px;" name="card_serial" id="card_serial"></td>
                </tr>
                <tr valign="top">
                  <th style="padding:5px;text-align:right;font-weight:bold"></th>
                  <td style="padding:5px;"><input type="submit" class="paymentbtns" value=" " name="paymentbtns"></td>
                </tr>
                <tr>
                  <td style="padding:5px;"></td>
                  <td style="padding:5px;"><i><u>Ghi chú:</u> Các trường có dấu <em class="redfont">(*)</em> là bắt buộc phải nhập</i></td>
                </tr>		
              </tbody>
            </table>
          </form>
        </div></td>
    </tr>
  </tbody>
</table><br />
<center style="margin-left:-780px">
                        <table id="table2" height="190" width="200" border="1" cellspacing="0" bordercolor="#666666">
                        <tbody style="color: #111;">
                          <tr>
                            <td align="center" colspan="2" bgcolor="#666666">
                                <label class="lbtext" style="color: white; font-size: 14px;">Bảng giá thẻ nạp</label></td>
                            </tr>
                          <tr>
                            <td width="99" align="center" bgcolor="#999999"><label class="lbtext">Mệnh giá</label></td>
                            <td width="155" align="center" bgcolor="#999999"><label class="lbtext">Tiền Xu nhận</label></td>
                            </tr>
                          <tr>
                            <td align="center"><label class="lbtext">10.000</label></td>
                            <td align="center"><label class="lbtext">100</label></td>
                            </tr>
                          <tr>
                          <tr>
                            <td align="center"><label class="lbtext">20.000</label></td>
                            <td align="center"><label class="lbtext">200</label></td>
                            </tr>
                          <tr>
                          <tr>
                            <td align="center"><label class="lbtext">30.000</label></td>
                            <td align="center"><label class="lbtext">300</label></td>
                            </tr>
                          <tr>
                            <td align="center"><label class="lbtext">50.000</label></td>
                            <td align="center"><label class="lbtext">500</label></td>
                          </tr>
                          <tr>
                            <td align="center"><label class="lbtext">100.000</label></td>
                            <td align="center"><label class="lbtext">1000</label></td>
                          </tr>
                          <tr>
                            <td align="center"><label class="lbtext">200.000</label></td>
                            <td align="center"><label class="lbtext">2000</label></td>
                          </tr>
                          <tr>
                            <td align="center"><label class="lbtext">500.000</label></td>
                            <td align="center"><label class="lbtext">5000</label></td>
                          </tr>
                        </tbody></table>
                        </center>
<br />
Sau khi nạp thẻ các bạn đến NPC Sứ giả hoạt động ở các Tân Thủ Thôn để nhận Tiền Xu.<br />
Tiền Xu được dùng để mua trang bị Hoàng Kim trong game và có thể dùng để đổi ra đồng chi tiết tại NPC Sứ giả hoạt động.<br />
<div class="MrchntNLcpy"> H&#7895; tr&#7907; thanh to&aacute;n b&#7903;i Ng&acirc;nL&#432;&#7907;ng.vn, <a target="_blank" href="http://help.nganluong.vn/[domain].html" title="H&#432;&#7899;ng d&#7851;n Thanh to&aacute;n tr&#7921;c tuy&#7871;n  qua Ng&acirc;nL&#432;&#7907;ng.vn">Xem h&#432;&#7899;ng d&#7851;n thanh to&aacute;n</a> </div>
</div>
</div>
<div id=""></div>
<div id="backgroundPopup"></div>
<script type="text/javascript">
            $('#payCardNL').submit(function() {
				if($("#payCardNL").valid()){
				data = $(this).serialize();
				$('#hehe').html('<div class="warningbox"><p><img src="./images/loading.gif" width="16" alt="vui lòng chờ giây lát">&nbsp;&nbsp;&nbsp;<blink><em class="redfont">Vui lòng giữ nguyên màn hình đợi trong giây lát...</em></blink></p></div>');
				//alert(data);
				$.ajax({
				url: "./mobile_card.api.post.test.v2.php",
				type: "POST",
				data: data,    
				cache: false,
				success: function (message) {    //alert(message);
				if(message!="")
				  $('#hehe').html(" <div class='warningbox'><div style='padding-top: 2px;'><p>"+message+"</p></div></div>"); 
				}      
            }); 
            return false;
			}
            });
            </script>
<link href="./style/merchant_checkout.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./style/js/jquery.validate.js"></script> 
<script type="text/javascript" src="./style/js/popup.js"></script>
</body>
</html>
<? } ?>