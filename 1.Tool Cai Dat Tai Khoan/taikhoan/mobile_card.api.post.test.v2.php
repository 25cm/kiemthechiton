<?php 
session_start();
define('IN_ECS', true);
include_once("inc/#config.php");
$dbconn = new connectMySQL;
$dbconn->connect('jxaccount');


//////////////////Thông tin được cấp khi đăng ký website trong phần tài khoản >> tích hợp  /////////////////////
	$ma_merchant = '30672'; // đăng ký website trên NL có : Merchant ID
	$matkhau_giaotiep = 'napthe_ktct'; // đăng ký website trên NL có : Mật khẩu giao tiếp 
	$taikhoan_nhantien = 'huynhtoan.ck@gmail.com'; // email Ngân Lượng
//form thanh toán qua thẻ cào	

	if ( $_POST["card_serial"] =="" ){echo 'Bạn chưa nhập số serial';}
	else if($_POST['pin_card'] =="" ){ echo 'Bạn chưa nhập mã thẻ cào';}
	else{
				
   		 function getParam($param_name){
			$result = '';
			if (!empty($_POST[$param_name]))		
				$result = trim($_POST[$param_name]);
			return $result;
		}
		 $ref_code_send        = getParam('ref_code')		;
		 $client_fullname_send = getParam('client_fullname');
		 $client_email_send    = getParam('client_email');
		 $client_mobile_send   = getParam('client_mobile');
		 
	
		////////////////////////////////
		$params = array(
				'func'					=> 'CardCharge',
				'version'				=> '2.0',
				'merchant_id'			=> $ma_merchant,
				'merchant_account'		=> $taikhoan_nhantien,//tài khoản nhận tiền
				'merchant_password'		=> md5($ma_merchant .'|'.$matkhau_giaotiep),
				'pin_card'				=> getParam('pin_card'),
				'card_serial'			=> getParam('card_serial'),
				'type_card'				=> getParam('type_card'),
				'ref_code'				=> $ref_code_send,
				'client_fullname'		=> $client_fullname_send,
				'client_email'			=> $client_email_send,
				'client_mobile'			=> $client_mobile_send,
			);
		//$params['merchant_password'] = MD5(getParam('merchant_id').'|'.getParam('password'));	
		
		$post_field = '';
		foreach ($params as $key => $value){
			if ($post_field != '') $post_field .= '&';
			$post_field .= $key."=".$value;
		}
		//return;
		
		$api_url = "https://www.nganluong.vn/mobile_card.api.post.v2.php";
		//var_dump( $post_field);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL,$api_url);
		curl_setopt($ch, CURLOPT_ENCODING , 'UTF-8');
		curl_setopt($ch, CURLOPT_VERBOSE, 1);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post_field);
		$result = curl_exec($ch);
		$status = curl_getinfo($ch, CURLINFO_HTTP_CODE); 
		$error = curl_error($ch);
		//echo $result ;
		
		if ($result != '' && $status==200){
			$arr_result = explode("|",$result);
				 
				 
			if (count($arr_result) == 13) {
				$error_code			= $arr_result[0];
				$merchant_id		= $arr_result[1];
				$merchant_account	= $arr_result[2];				
				$pin_card			= $arr_result[3];
				$card_serial		= $arr_result[4];
				$type_card			= $arr_result[5];
				$ref_code			= $arr_result[6];
				$client_fullname	= $arr_result[7];
				$client_email		= $arr_result[8];
				$client_mobile		= $arr_result[9];
				$card_amount		= $arr_result[10];
				$amount				= $arr_result[11];
				$transaction_id		= $arr_result[12];
				
				
				if ($error_code == '00'){
$TienDuocHuong = $card_amount *100; // điều chỉnh tỷ lệ cộng tiền $card_amount = 10000 khi nạp thẻ 10k
if($card_amount == 7500000) { $TienDuocHuong = '8000000'; }
elseif($card_amount == 15000000) { $TienDuocHuong = '20000000'; }
$sql="select * from jxsf8_paycoin WHERE account='".$_SESSION['user_login']."'";
$query = mysql_query($sql)or die ("Nạp thẻ thành công , tuy nhiên chưa được cộng tiền.");
$numrows = mysql_num_rows($query);
if($numrows >= 1) {
$sql="UPDATE jxsf8_paycoin SET jbcoin = jbcoin + $TienDuocHuong WHERE account='".$_SESSION['user_login']."'";
mysql_query($sql)or die ("Nạp thẻ thành công , tuy nhiên chưa được cộng tiền.");
} else { 
$sql="INSERT INTO jxsf8_paycoin (account,jbcoin) VALUES ('".$_SESSION['user_login']."','$TienDuocHuong')";
mysql_query($sql)or die ("Nạp thẻ thành công , tuy nhiên chưa được cộng tiền.");									
				}
									echo "Bạn đã nạp thẻ thành công, với mệnh giá thẻ: ".$card_amount;
									
				}
				else {
				
					
					$arrCode = array(
					   '00'=>  'Giao dịch thành công',
					   '99'=>  'Lỗi, tuy nhiên lỗi chưa được định nghĩa hoặc chưa xác định được nguyên nhân',
					   '01'=>  'Lỗi, địa chỉ IP truy cập API của NgânLượng.vn bị từ chối',
					   '02'=>  'Lỗi, tham số gửi từ merchant tới NgânLượng.vn chưa chính xác (thường sai tên tham số hoặc thiếu tham số)',
					   '03'=>  'Lỗi, Mã merchant không tồn tại hoặc merchant đang bị khóa kết nối tới NgânLượng.vn',
					   '04'=>  'Lỗi, Mã checksum không chính xác (lỗi này thường xảy ra khi mật khẩu giao tiếp giữa merchant và NgânLượng.vn không chính xác, hoặc cách sắp xếp các tham số trong biến params không đúng)',
					   '05'=>  'Tài khoản nhận tiền nạp của merchant không tồn tại',
					   '06'=>  'Tài khoản nhận tiền nạp của merchant đang bị khóa hoặc bị phong tỏa, không thể thực hiện được giao dịch nạp tiền',
					   '07'=>  'Thẻ đã được sử dụng ',
					   '08'=>  'Thẻ bị khóa',
					   '09'=>  'Thẻ hết hạn sử dụng',
					   '10'=>  'Thẻ chưa được kích hoạt hoặc không tồn tại',
					   '11'=>  'Mã thẻ sai định dạng',
					   '12'=>  'Sai số serial của thẻ',
					   '13'=>  'Mã thẻ và số serial không khớp',
					   '14'=>  'Thẻ không tồn tại',
					   '15'=>  'Thẻ không sử dụng được',
					   '16'=>  'Số lần thử (nhập sai liên tiếp) của thẻ vượt quá giới hạn cho phép',
					   '17'=>  'Hệ thống Telco bị lỗi hoặc quá tải, thẻ chưa bị trừ',
					   '18'=>  'Hệ thống Telco bị lỗi hoặc quá tải, thẻ có thể bị trừ, cần phối hợp với NgânLượng.vn để tra soát',
					   '19'=>  'Kết nối từ NgânLượng.vn tới hệ thống Telco bị lỗi, thẻ chưa bị trừ (thường do lỗi kết nối giữa NgânLượng.vn với Telco, ví dụ sai tham số kết nối, mà không liên quan đến merchant)',
					   '20'=>  'Kết nối tới telco thành công, thẻ bị trừ nhưng chưa cộng tiền trên NgânLượng.vn');
					echo "Xin chào ".$_SESSION['user_login'].", bạn gặp phải lỗi : ".$arrCode[$error_code];
				}
			}
			else var_dump(count($arr_result));
		}
		else echo "Có lỗi khi xử lý: ".$error ;	
	}
	
	
	exit();
	
// kết thúc thanh toán thẻ cào



?>
