<?php 
session_start();
define('IN_ECS', true);
include_once("inc/#config.php");
$dbconn = new connectMySQL;
$dbconn->connect('jxaccount');

$error_code = '00';
$card_amount = 10000;
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
exit();
}
	
// kết thúc thanh toán thẻ cào



?>
