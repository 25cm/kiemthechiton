<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="SilverHand" />
	<title>Transaction API</title>
</head>
<body>
<?php
@session_start();
error_reporting(0);
define('IN_ECS', true);
include('BKTransactionAPI.php');
include ('#config.php');

//include('webjx.php');
if(isset($_POST['sbNapThe'])){
			

	$seri = $_POST['txtSoSeri'];
	$sopin = $_POST['txtSoPin'];
	$mang = $_POST['select_method'];
	$accname = $_POST['usernamme_login'];

	if($mang==92){
			$ten = "Mobiphone";
		}
	else if($mang==107){
			$ten = "Viettel";
		}
	 else if($mang==120){
			$ten = "Gate";
	}
	else if($mang==121){
	$ten = "VTC";
	}
	else $ten ="Vinaphone";
		//die($ten);
//Connect to mysql server

$dbconn = new connectMySQL;
$dbconn->connect('jxcoincard');	
	$timezone = +7; //(GMT +7:00)
 	$time = gmdate("d/m/Y H:i:s", time() + 3600*($timezone+date("0")));
	//$sqlinsert=("INSERT INTO infocard (username, mathe, seri, loaithe,time) VALUES('$accname','$sopin','$seri','$ten','$time')");
	//mysql_query($sqlinsert);

	$sqlsub1=mysql_query("SELECT mathe FROM `coincard` where mathe = '".$sopin."'");
	$rowsub1=mysql_fetch_array($sqlsub1);
	echo "SELECT mathe FROM `coincard` where mathe = '".$sopin."'";
	echo "<pre>";	print_r($rowsub1);	echo "</pre>";
	$sopin1 =  $rowsub1['mathe'];
	if($sopin1!=''){
		echo '<script>alert("Thông tin thẻ cào của bạn không hợp lệ hoặc đã được sử dụng!");</script>';
 		echo "<script>location.href='../napxu.php';</script>";
 	}
//die($mang);
/*
$bk = new BKTransactionAPI("http://sandbox.baokim.vn/services/transaction_api/init?wsdl");
$secure_pass = 'f2d34bcfe3cd3b12';

$transaction_id = time();
$info_topup = new TopupToMerchantRequest();
$info_topup->api_password = 'nhajben';
$info_topup->api_username = 'nhajben';
$info_topup->card_id = $mang;
$info_topup->merchant_id = '576';
*/
$bk = new BKTransactionAPI("https://www.baokim.vn/services/transaction_api/init?wsdl");
$secure_pass = '';

$transaction_id = time();
$info_topup = new TopupToMerchantRequest();
$info_topup->api_password = '';
$info_topup->api_username = '';
$info_topup->card_id = $mang;
$info_topup->merchant_id = '';


$info_topup->pin_field = $sopin;
$info_topup->seri_field = $seri;
$info_topup->transaction_id = $transaction_id;

$data_sign_array = (array)$info_topup;
ksort($data_sign_array);

$data_sign = md5($secure_pass . implode('', $data_sign_array));
$info_topup->data_sign = $data_sign;
$test = new TopupToMerchantResponse();

$test = $bk->DoTopupToMerchant($info_topup);


	
	
if($test->error_code==0){
	$sotien = $test->info_card;
	if($sotien==10000){$xu = 10;}
	else if($sotien==20000){$xu = 20;}
	else if($sotien==30000){$xu = 30;}
	else if($sotien==50000){$xu = 50;}
	else if($sotien==100000){$xu = 100;}
	else if($sotien==200000){$xu = 200;}
	else if($sotien==300000){$xu = 300;}
	else if($sotien==500000){$xu = 500;}




	$coin = rand(1000,9999).time();
	$logcard=("INSERT INTO coincard (loginName, CoinCardKey, value, used,mathe,loaithe,menhgia,time) 	VALUES('$accname','$coin','$xu',2,'$sopin','$ten','$sotien','$time')");
	$upxu=("UPDATE `jxaccount`.`account` SET xu = xu+'$xu' WHERE `account`.`loginName` = '$accname' LIMIT 1 ;");
	$q11 = mysql_query($logcard);
	if($q11){
		$q12 = mysql_query($upxu);
		if($q12){
    		echo  '<script>alert("Bạn đã nạp thành công thẻ cào '.$ten.' với mệnh giá '.$test->info_card.' - Mã giao dịch '.$coin.' và nhận đuợc '.$xu.' Xu. Bạn có thể bật Lịch Sử Giao Dịch để copy code và sử dụng");</script>'; //$total_results;
			echo "<script>location.href='../doixu.php';</script>";
			mysql_close() ;
		}
		else	echo  '<script>alert("Lỗi, vui lòng nhấn F5 để thử lại");</script>'; //$total_results;
	}
	else	echo  '<script>alert("Lỗi, vui lòng nhấn F5 để thử lại");</script>'; //$total_results;
 
}

else if($test->error_code==5){
	$sqlsub1=mysql_query("SELECT * FROM `coincard` where mathe = '".$sopin."'");
	$rowsub1=mysql_fetch_array($sqlsub1);	
	$sopin1 =  $rowsub1['mathe'];
	if($sopin1==''){
		$coin = rand(1000,9999).time();
		$logcard=("INSERT INTO coincard (loginName, CoinCardKey, value, used,mathe,loaithe,menhgia,time) 	VALUES('$accname','$coin','$xu',2,'$sopin','$ten','$sotien','$time')");
		$upxu=("UPDATE `jxaccount`.`account` SET xu = xu+'$xu' WHERE `account`.`loginName` = '$accname' LIMIT 1 ;");
		$q11 = mysql_query($logcard);
		if($q11){
			$q12 = mysql_query($upxu);
			if($q12){
	    		echo  '<script>alert("Bạn đã nạp thành công thẻ cào '.$ten.' với mệnh giá '.$test->info_card.' - Mã giao dịch '.$coin.' và nhận đuợc '.$xu.' Xu. Bạn có thể bật Lịch Sử Giao Dịch để copy code và sử dụng");</script>'; //$total_results;
	    		echo "<script>location.href='../doixu.php';</script>";
				mysql_close() ;
			}
			else	echo  '<script>alert("Lỗi, vui lòng nhấn F5 để thử lại");</script>'; //$total_results;
		}
		else	echo  '<script>alert("Lỗi, vui lòng nhấn F5 để thử lại");</script>'; //$total_results;
	}
}


else {echo '<script>alert("Thông tin thẻ cào của bạn không hợp lệ hoặc đã được sử dụng!");</script>';
 echo "<script>location.href='../napxu.php';</script>";
}
//var_dump($test);
//echo '<br /><br />ID request:' . $transaction_id;


}

//	echo "<script>location.href='../doixu.php';</script>";
?>

</body>
</html>