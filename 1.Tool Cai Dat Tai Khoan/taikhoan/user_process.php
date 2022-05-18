<?php
session_start();
define('IN_ECS', true);
// include file connect
include 'inc/#config.php';
// Make connect
$dbconn = new connectMySQL;
// Connect to acc_db
$dbconn->connect('jxaccount');

	if($_GET['page']=='dangxuat'){
		$_SESSION['user_login'] = '';
		session_destroy();
		echo "Thoát thành công!";
	}
?>