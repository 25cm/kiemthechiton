<?php
	session_start();
	error_reporting(0);
	if (file_exists("laivt_firewall.php")) include_once "laivt_firewall.php"; 
	define('IN_ECS', true);
	include 'inc/#config.php';
	$dbconn = new connectMySQL;
	$dbconn->connect('jxaccount');
	

function echo_it($errors) {
	$echo = '<font color="#FF0000"><b>'.$errors.'</b></font>';
	return $echo;
}


if($_SESSION['user_login']!=''){
	$_SESSION['user_login'] = $_SESSION['user_login'];
	$sqlUserInfo = "Select * from  account where loginName = '".$_SESSION['user_login']."'";
	$resultUserInfo = mysql_query($sqlUserInfo);	
	$rowUserInfo = mysql_fetch_array($resultUserInfo, MYSQL_ASSOC);
}
// Neu nguoi dung da dang ky thi tien hanh chuyen ve dang nhap
if($_POST['submit']) {
	$action = $_POST['action'];
	if( $action == "dangky"){
		$username = $_POST['username'];
		$password = $_POST['password'];
		$verpassword = $_POST['verifyPassword'];
		$cmnd = $_POST['cmnd'];
		$safecode = $_POST['safecode'];
		$cauhoibimat = $_POST['cauhoibimat'];
		$traloicauhoi = $_POST['traloicauhoi'];
		$captcha = $_POST['captcha'];
		$email = $_POST['email'];
		
		if(preg_match('/[0-9]/',$username) or strlen($username) < 6) {
			$username_e = echo_it('Tài khoản chỉ được sử dụng ký tự, không được dùng số!');
			$e = 1;
		}
		if(strlen($password) < 6 or strlen($password) > 30) {
			$password_e = echo_it('Mật khẩu không hợp lệ!');
			$e = 1;
		}
		if($password != $verpassword) {
			$verpassword_e = echo_it('Nhập lại mật khẩu không khớp!');
			$e = 1;
		}
		if(!preg_match('/^([0-9]*)$/',$cmnd) or strlen($cmnd) < 9) {
			$cmnd_e = echo_it('Số CMND không hợp lệ!');
			$e = 1;
		}
		if(strlen($traloicauhoi)<3) {
			$traloicauhoi_e = echo_it('Vui lòng nhập câu trả lời!');
			$e = 1;
		}
		if(!preg_match('/^([a-zA-Z0-9]*)$/',$traloicauhoi) ) {
			$traloicauhoi_e = echo_it('Vui lòng nhập không dấu!');
			$e = 1;
		}
		if($captcha != $_SESSION['security_code']) {
			$captcha_e = echo_it('Mã kiểm tra không chính xác!');
			$e = 1;
		}
		if(!preg_match('/^[a-zA-Z0-9-_\.]+@{1}[a-zA-Z0-9-\.]+\.{1}[a-zA-Z]{2,4}$/',$email) or strlen($email) > 128) {
			$email_e = echo_it('Email không hợp lệ!');
			$e = 1;
		}
		
		$qCheck = mysql_query("SELECT * FROM account WHERE loginName = '$username'");
		if(mysql_num_rows($qCheck) != 0) {
			$username_e = echo_it('Tài khoản này đã có người sử dụng!');
			$e = 1;
		}
		$qCheck2 = mysql_query("SELECT * FROM account WHERE cEMail = '$email'");
		if(mysql_num_rows($qCheck2) != 0) {
			$email_e = echo_it('Email này đã có người sử dụng!');
			$e = 1;
		}
	//	$qCheck3 = mysql_query("SELECT * FROM account WHERE cRealName = '$cmnd'");
	//	if(mysql_num_rows($qCheck3) != 0) {
	//		$cmnd_e = echo_it('CMND này đã có người sử dụng!');
	//		$e = 1;
	//	}
		if(!$e) {
			$password = md5($password);
			$sqlInsert = "insert into account (loginName,password_hash,cEMail,cRealName,safecode,cQuestion,cAnswer,checkMember) values('$username','$password','$email','$cmnd','$safecode','$cauhoibimat','$traloicauhoi','1')";
			$regis = mysql_query($sqlInsert);
			if(!$regis) {
				$regis_e = echo_it('Lỗi, vui lòng thử lại!');
				echo mysql_error();
			}
			else{
				$_SESSION['reg_user'] = $username;
				echo '<script>alert("Chúc mừng bạn đã đăng ký thành công!\nBây giờ bạn có thể tham gia trò chơi!"); window.location="index.php";</script>';
				exit();
			}
		}
	}else if($action == "dangnhap"){
		$e = 0;
		$username = $_POST['usernamme_login'];
		$password = $_POST['password_login'];
		if($username==""){
			$username_login_e = echo_it('Vui lòng nhập tên đăng nhập!');
			$e = 1;
		}
		if($password==""){
			$password_login_e = echo_it('Vui lòng nhập mật khẩu!');
			$e = 1;
		}
		if($e==0) {
			$username = mysql_escape_string($username);
			$password = md5($password);
			$rsLogin = mysql_query("SELECT * FROM account WHERE loginName = '$username' and password_hash = '$password'");
			if(mysql_num_rows($rsLogin) == 0) {
				$login_e = echo_it('Đăng nhập không thành công!');
			}else if(mysql_num_rows($rsLogin) != 0) {
				$_SESSION['user_login']=$username;
				if(isset($_SESSION['page'])){
					if($_SESSION['page'] == "napxu"){
						echo '<script>window.location="napxu.php";</script>';
					}
					if($_SESSION['page'] == "doixu"){
						echo '<script>window.location="doixu.php";</script>';
					}
					else{
						echo '<script>window.location="index.php";</script>';
						exit();
					}
				}
				else{
					echo '<script>window.location="index.php";</script>';
					exit();
				}
			}	
		}
	}else if($action == "capnhat"){
		$e = 0;
		$username = $_SESSION['user_login'];
		$password = $_POST['password_update'];
		$passwordverify = $_POST['verifyPassword_update'];
		$cauhoibimat_update = $_POST['cauhoibimat_update'];
		$traloicauhoi_update = $_POST['traloicauhoi_update'];
		$cmnd_update = $_POST['cmnd_update'];
		if($rowUserInfo['checkMember']==1){
			$cmnd_update =$rowUserInfo['cRealName'];
		}
		$safecode_update = $_POST['safecode_update'];
		
		/*
		if($rowUserInfo['checkMember']==0){
			if($traloicauhoi_update=="") {
				$traloicauhoi_update_e = echo_it('Vui lòng nhập câu trả lời!');
				$e = 1;
			}
			if(!preg_match('/^([a-zA-Z0-9\ ]*)$/',$traloicauhoi_update) ) {
				$traloicauhoi_update_e = echo_it('Vui lòng nhập không dấu!');
				$e = 1;
			}
		}
		if($cmnd_update==''){
			$cmnd_update_e = echo_it('Vui lòng nhập CMND!');
			$e = 1;
		}
		if(!preg_match('/^([0-9]*)$/',$cmnd_update) or strlen($cmnd_update) < 9) {
			$cmnd_update_e = echo_it('Số CMND không hợp lệ!');
			$e = 1;
		}
		$qcmnd_update= mysql_query("SELECT * FROM account WHERE cRealName = '$cmnd' and loginName <> '$username' ");
		if(mysql_num_rows($qcmnd_update) != 0) {
			$qcmnd_update = echo_it('CMND này đã có người sử dụng!');
			$e = 1;
		}
		if(!preg_match('/^[a-zA-Z0-9-_\.]+@{1}[a-zA-Z0-9-\.]+\.{1}[a-zA-Z]{2,4}$/',$email_update) or strlen($email_update) > 128) {
			$email_update_e = echo_it('Email không hợp lệ!');
			$e = 1;
		}
		$qemail_update = mysql_query("SELECT * FROM account WHERE cEMail = '$email' and loginName <> '$username'");
		if(mysql_num_rows($qemail_update) != 0) {
			$email_update_e = echo_it('Email này đã có người sử dụng!');
			$e = 1;
		}
		*/
		if($password!=$passwordverify){
			$verpassword_update_e = echo_it('2 Mật khẩu phải trùng nhau!');
			$e = 1;
		}
		if($e==0) {
			
			if($password!=''){
				$password = md5($password);
				$passUpdate = "
						`password_hash` = '$password', ";
			}else if($password==''){
				$passUpdate="";
			}
			if($rowUserInfo['checkMember']==0){
				
			//	$passUpdate .= " , `cQuestion`='$cauhoibimat_update' , `cAnswer`='$traloicauhoi_update' , `checkMember`='1' ";
				$passUpdate .= " `checkMember`='1', ";
			}else if($rowUserInfo['checkMember']==1){
				$passUpdate .= "";
			}
			$sqlUpdate="UPDATE account SET 
							$passUpdate
							safecode = '$safecode_update'
							WHERE loginName = '$username' ;
							";
						
			@$rsUpdate = mysql_query($sqlUpdate);
		//	echo $sqlUpdate;
			if(!$rsUpdate) {
				$update_e = echo_it('Cập nhật không thành công!');
			}else{
				echo '<script>alert("Chúc mừng bạn đã cập nhập thành công!"); window.location=document.location;</script>';
				exit();
			}	
		}
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Đăng ký tài khoản Kiếm Thế Chí Tôn</title>
		<meta name="description" content="Kiếm Thế Chí Tôn - Quản lý tài khoản - Kiếm thế private" />
		<meta NAME="keywords" CONTENT="kiem the chi ton, đăng ký, đăng nhập, quản lý tài khoản, kiếm thế private">
		<meta NAME="distribution" CONTENT="Global">
		<meta NAME="robots" CONTENT="FOLLOW,INDEX">
		<link href="css/styles.css" media="screen" rel="stylesheet" type="text/css" />  
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    	<link rel="icon" type="image/png" href="/images/fav.png" />
        <link rel="stylesheet" href="css/nivo-slider.css" type="text/css" media="screen" />
		<script type="text/javascript" src="js/laivt_ajax.js"></script>
		<script type="text/javascript" src="js/script.js"></script>
		<script type="text/javascript">

         function checkEmail(email) {    
            var filter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(email)) {        
               return false;
            }
            return true;
         }
		 
		
		function check_formLOGIN(){//frm_login_l
			if(document.forms["frm_login_l"].username_login.value=="")
               {
               alert("Vui lòng nhập vào tên đăng nhập!");
               document.forms["frm_login_l"].username_login.focus();
               return false;
            }
			if(document.forms["frm_login_l"].password_login.value=="")
               {
               alert("Vui lòng nhập vào mật khẩu!");
               document.forms["frm_login_l"].password_login.focus();
               return false;
            }
			document.forms["frm_login_l"].submit();  
		}
         function check_form()
         {                      
            var illegalChars = /\W/; // allow letters, numbers, and underscores

            if(document.forms["frm_login"].username.value=="")
               {
               alert("Vui lòng nhập vào tên đăng nhập!");
               document.forms["frm_login"].username.focus();
               return false;
            }
            if ((document.forms["frm_login"].username.value.length < 6) | (document.forms["frm_login"].username.value.length > 24)) {
               document.forms["frm_login"].username.style.background = 'Yellow';
               //error = "Please select a username between 6-30 characters.\n";
               alert("Tên đăng nhập ít nhất 6 ký tự và nhiều nhất là 24 ký tự!");
               return false;
            } else if (illegalChars.test(document.forms["frm_login"].txt_username.value)) {
               document.forms["frm_login"].username.style.background = 'Yellow';
               //error = "The username contains illegal characters.\n";
               alert("Tên đăng nhập chỉ bao gồm a-Z, 0-9 và _!");
               return false;
            }
            if(document.forms["frm_login"].password.value=="")
               {
               alert("Vui lòng nhập vào mật khẩu đăng nhập!");
               document.forms["frm_login"].password.focus();
               return false;
            }
            if(document.forms["frm_login"].verifyPassword.value=="" || document.forms["frm_login"].verifyPassword.value!=document.forms["frm_login"].verifyPassword.value)
               {
               alert("Mật khẩu và nhập lại mật khẩu không khớp!");
               document.forms["frm_login"].verifyPassword.focus();
               return false;
            }
            if(document.forms["frm_login"].email.value=="")
               {
               alert("Vui lòng nhập vào địa chỉ email!");
               document.forms["frm_login"].email.focus();
               return false;
            }
            if(!checkEmail(document.forms["frm_login"].email.value))
               {
               alert("Địa chỉ email không hợp lệ!");
               document.forms["frm_login"].email.focus();
               return false;
            }
			if(document.forms["frm_login"].cmnd.value=="")
               {
               alert("Vui lòng nhập CMND!");
               document.forms["frm_login"].cmnd.focus();
               return false;
            }
			if(document.forms["frm_login"].traloicauhoi.value=="")
               {
               alert("Vui lòng nhập câu trả lời bí mật!");
               document.forms["frm_login"].traloicauhoi.focus();
               return false;
            }
            document.forms["frm_login"].submit();                                            
         }                
      </script>
	
<script language="javascript">
<!--
document.forms[form1].onsubmit = function() {
if(this.elements['Password'].value != this.elements['Password2'].value) {
alert('Passwords do not match');
return false;
}

return true;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += ''+ +''; }
  } if (errors) alert('Bạn chưa nhập đầy đủ thông tin');
  document.MM_returnValue = (errors == '');
}
//-->
</script>
<script>
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
</script>
<style type="text/css">
<!--
.style1 {color: #0000FF}
-->
</style>
</head>

	<body>
		<!--Logo
		<div id="log_in">
		<div><a style="height: 100px; width: 250px;float:left;" href="index.php" target="_blank"></a></div>
			
		</div>
		END Logo-->
		<?php include("boxes/menu.php"); ?>
		<!--Content-->

		<div id="content_wrapper">

			<div id="main_content">
<?php if(!isset($_SESSION['user_login']) or $_SESSION['user_login']==''){ ?>
        	<div id="content_main">
	<span>Đăng ký tài khoản</span>
	<div style="clear:both"></div>
		        <form id="frm_1" name="frm_login" method="post" onsubmit="javascript:  check_form();">
				<input type="hidden" name="action" id="action" value="dangky">
				<table id="paymentTable" style="width: 100%; height: auto; padding: 10px;" cellspacing="0" cellpadding="0">
<td colspan="3" style="padding-left: 20px;">
<input type="hidden" name="csrf" value="d679ed75d5f12e821b30318be93bf65a" id="csrf" /></td>

<tr>

    <td colspan="3" style="padding-bottom: 20px;"><span class="info_tit">Điền đầy đủ thông tin bên dưới</span></td>

</tr>

<tr>

    <td class="l">

        Tên tài khoản    </td>

    <td>

        <input id="cardNumber" name="username" type="text" class="text-field" value="<?=$username;?>" maxlength="24" autocomplete="off" />

        <span class="hi_r">*  (Gồm các ký tự a-z)</span>

        <div class="clearboth"><?=$username_e;?></div>

    </td>

</tr>



<tr>

    <td class="l">

        Mật khẩu    </td>

    <td>

        <input id="password" name="password" type="password" class="text-field" value="" maxlength="100" autocomplete="off" />

        <span class="hi_r"></span>
<div class="clearboth"><?=$password_e;?></div>
    </td>

</tr>


<tr>

    <td class="l">

        Nhập lại mật khẩu    </td>

    <td>

        <input id="verifyPassword" name="verifyPassword" type="password" class="text-field" value="" maxlength="100" autocomplete="off" />

        <span class="hi_r"></span>
<div class="clearboth"><?=$verpassword_e;?></div>
    </td>

</tr>


<tr>

    <td class="l">

        Địa chỉ Email    </td>

    <td>

        <input id="cardSerial" name="email" type="text" class="text-field" maxlength="500" value="<?=$email;?>" />

        <span class="hi_r">* Dùng mở khóa nhân vật</span>
<div class="clearboth"><?=$email_e;?></div>
    </td>

</tr>

<tr>

    <td class="l">

        CMND    </td>

    <td>

        <input id="cmnd" name="cmnd" type="text" class="text-field" maxlength="500" value="<?=$cmnd;?>" />

        <span class="hi_r">* Dùng mở khóa nhân vật</span>
<div class="clearboth"><?=$cmnd_e;?></div>
    </td>

</tr>

<tr>

    <td class="l">

        Mã Khóa Nhân Vật    </td>

    <td>

        <input id="safecode" name="safecode" type="text" class="text-field" maxlength="500" value="<?=$safecode;?>" />

        <span class="hi_r"></span>
<div class="clearboth"></div>
    </td>

</tr>

<tr>

    <td class="l">

        Câu hỏi bí mật    </td>

    <td>

	<SELECT NAME="cauhoibimat" id="cauhoibimat" style="height:25px;width:170px">
		<OPTION VALUE="11">Màu mà bạn thích nhất ?</OPTION>
		<OPTION VALUE="12">Tên trường cấp 3 của bạn ?</OPTION>
		<OPTION VALUE="13">Bạn thích nhất mùa nào ?</OPTION>
		<OPTION VALUE="14">Nơi mà bạn muốn đến nhất ?</OPTION>
	</SELECT>

        <span class="hi_r">* Không được thay đổi sau này</span>
<div class="clearboth"><?=$cauhoibimat_e;?></div>
<div class="clearboth"></div>
    </td>

</tr>

<tr>

    <td class="l">

        Trả lời    </td>

    <td>

       <input id="traloicauhoi" name="traloicauhoi" type="text" class="text-field" maxlength="500" />

        <span class="hi_r">* a->z và 0->9+không dấu.</span>
<div class="clearboth"><?=$traloicauhoi_e;?></div>
    </td>

</tr>

<tr>

    <td class="l">

        Mã bảo vệ    </td>

    <td>

        <input id="cardSerial" name="captcha" type="text" class="text-field" maxlength="4" />

        <span class="hi_r"><img src="captcha.php" alt="Mã kiểm tra" width="70" /></span>
		<div class="clearboth"><?=$captcha_e;?></div>
		<div class="clearboth"><?=$regis_e;?></div>
    </td>


</tr>






<tr>

    <td colspan="3" style="padding: 10px 0px;"><hr></td>

</tr>

<tr>

    <td colspan="3" width="100%" style="padding: 10px 0px;">

        <input class="sub" type="submit" value="Đăng ký" id="submit" name="submit" />

        <input class="dec" type="reset" name="reset" value="Nhập lại" />

    </td>

</tr>

</table></form>				</div>
				<div id="content_news">



					<span>Đăng nhập</span>

					<div style="clear: both"></div>
<form id="frm_1_l" name="frm_login_l" method="post" onsubmit="javascript:  check_formLOGIN();">
				<input type="hidden" name="action" id="action" value="dangnhap">
					<table align="center" border="0" cellspacing="10" cellpadding="0">

<tr>

    <td class="l">

        Tên tài khoản    </td>

    <td>

        <input type="text" value="" id="usernamme_login" name="usernamme_login" size="23" maxlength="255" />

<div class="clearboth"><?=$username_login_e;?></div>
    </td>

</tr>


<tr>

    <td class="l">

        Mật khẩu    </td>

    <td>

        <input type="password" value="" id="password_login" name="password_login" size="23" maxlength="255" />
<div class="clearboth"><?=$password_login_e;?></div>
    </td>

</tr>
  <td colspan="3" width="100%" style="padding: 0px 0px;">

        <input class="sub" type="submit" value="Đăng nhập" name="submit" />
	
        <input class="dec" type="reset" name="reset" value="Quên mật khẩu?" />
		<script type="text/javascript"> 
		$('.dec').popupWindow({ 
		windowURL:'reset.php', 
		windowName:'swip' 
		}); 
		</script>

    </td>
				</table>
</form>
<div class="clearboth"><center><?=$login_e;?></center></div>
				</div>        	
				<?php }else{ // da login. cap nhat tai khoan
				
				//////////////////////CAP NHAT TAI KHOAN///////////////////////////////
				
				
				?>
				
<div id="main_content">
        	<div id="content_main">
				<span>Cập nhật thông tin</span>
	<div style="clear:both"></div>
		        <form id="frm_1_update" name="frm_login_update" method="post" onsubmit="javascript:  check_formUpdate();">
				<input type="hidden" name="action" id="action" value="capnhat">
				<table id="paymentTable" style="width: 100%; height: auto; padding: 10px;" cellspacing="0" cellpadding="0">
<td colspan="3" style="padding-left: 20px;">
<input type="hidden" name="csrf" value="d679ed75d5f12e821b30318be93bf65a" id="csrf" /></td>


<tr>

    <td class="l">

        Tên tài khoản    </td>

    <td>

       <b> <?=$_SESSION['user_login'];?></b>

    </td>

</tr>



<tr>

    <td class="l">

        Mật khẩu    </td>

    <td>

        <input id="password_update" name="password_update" type="password" class="text-field" value="" maxlength="100" autocomplete="off" />
        <span class="hi_r"> Để trống để không sửa</span>
<div class="clearboth"><?=$password_update_e;?></div>
    </td>

</tr>


<tr>

    <td class="l">

        Nhập lại mật khẩu </td>

    <td>

        <input id="verifyPassword_update" name="verifyPassword_update" type="password" class="text-field" value="" maxlength="100" autocomplete="off" />
        <span class="hi_r"> Để trống để không sửa</span>
<div class="clearboth"><?=$verpassword_update_e;?></div>
    </td>

</tr>


<tr>

    <td class="l">

        Địa chỉ Email    </td>

    <td>

        <?php
    		$leng21 = explode("@", $rowUserInfo['cEMail']);
    		$leng2 = strlen($leng21[0])/2 - 1;
    		echo "****".substr($leng21[0],$leng2,50)."@".$leng21[1];
        ?>

    
    </td>

</tr>



<?php //cau hoi bi mat danh cho thanh vien cu
//	if($rowUserInfo['checkMember']==0){
?>


<tr>

    <td class="l">

        Câu hỏi bí mật    </td>

    <td>

	        <?php
	    		if($rowUserInfo['cQuestion'] == 11)	echo "Màu mà bạn thích nhất ?";
	    		elseif($rowUserInfo['cQuestion'] == 12)	echo "Tên trường cấp 3 của bạn ?";
	    		elseif($rowUserInfo['cQuestion'] == 13)	echo "Bạn thích nhất mùa nào ?";
	    		elseif($rowUserInfo['cQuestion'] == 14)	echo "Nơi mà bạn muốn đến nhất ?";
	        ?>

  
<div class="clearboth"></div>
    </td>

</tr>

<tr>

    <td class="l">

        Trả lời    </td>

    <td>

        	<?php
        		$leng1 = strlen($rowUserInfo['cAnswer'])/2 - 1;
        		echo "******".substr($rowUserInfo['cAnswer'],$leng1,50)
        	?>
    </td>

</tr>

<?php  //dong cau hoi bi mat?>
<tr>

    <td class="l">

        CMND    </td>

    <td>
	<?php if($rowUserInfo['checkMember']==0){ ?>
	<input id="cmnd_update" name="cmnd_update"  type="text" class="text-field" maxlength="500" value="<?=$rowUserInfo['cRealName'];?>" />
	<?php }else {?>
        <?=$rowUserInfo['cRealName'];?>
	<?php } ?>
	
	 
<div class="clearboth"><?=$cmnd_update_e;?></div>
    </td>

</tr>

<tr>

    <td class="l">

        Mã Khóa Nhân Vật    </td>

    <td>

        <input id="safecode_update" name="safecode_update" type="text" class="text-field" maxlength="500" value="<?=$rowUserInfo['safecode'];?>" />

        <span class="hi_r"></span>
<div class="clearboth"></div>
    </td>

</tr>


<tr>




<tr>

    <td colspan="3" style="padding: 10px 0px;"><hr></td>

</tr>

<tr>

    <td colspan="3" width="100%" style="padding: 10px 0px;">

        <input class="sub" type="submit" value="Cập nhật" id="submit" name="submit" />

        <input class="dec" type="reset" name="reset" value="Nhập lại" />
<?=$update_e;?>
    </td>

</tr>

</table></form>			</div>
</div>
				
							<div id="content_news">



					<span>Thông tin tài khoản</span>

					<div style="clear: both"></div>
<form id="frm_1_l" name="frm_login_l" method="post" onsubmit="javascript:  check_formLOGIN();">
				<input type="hidden" name="action" id="action" value="dangnhap">
					<table align="left" border="0" cellspacing="10" cellpadding="0">


<tr>

    <td class="l2">

        Tên tài khoản: </td>

    <td>  

       <b> <?=$_SESSION['user_login'];?></b>

    </td>

</tr>

<tr>

    <td class="l2">

        Địa chỉ Email:   </td>

    <td>

       <b>
        <?php
    		$leng21 = explode("@", $rowUserInfo['cEMail']);
    		$leng2 = strlen($leng21[0])/2 - 1;
    		echo "****".substr($leng21[0],$leng2,50)."@".$leng21[1];
        ?>
       </b>

    </td>

</tr>


<tr>

    <td class="l2">

        Mã Khóa Nhân Vật:    </td>

    <td>

     <b>  <?=$rowUserInfo['safecode'];?></b>

        <span class="hi_r"></span>
<div class="clearboth"></div>
    </td>

</tr>

<tr>

    <td class="l2">

        Coin hiện còn:    </td>

    <td>

     <b><font color='red'><?=$rowUserInfo['Coin'];?> Coin</font></b>

        <span class="hi_r"></span>
<div class="clearboth"></div>
    </td>

</tr>

<tr>

    <td class="l2">

        Đồng chưa load:    </td>

    <td>

     <b><font color='red'><?=round($rowUserInfo['Coin']/10000,0);?> Vạn</font></b>

        <span class="hi_r"></span>
<div class="clearboth"></div>
    </td>

</tr>




				</table>
</form>
				</div>  
				
				<!---- doi mat khau cap 2---->
			
				<!---- doi mat khau cap 2---->
				<?php } ?>
		  </div>

        </div>

        <!--END Content-->

        	</div>
        </div>
        <!--END Content-->
		<div style="clear:both; height: 10px;"></div>
				<!--Footer-->
		<div id="footer_cn">
			<div id="footer_top"><a href="#top"></a></div>
			<div id="footer_menu">
                                   
	</div>
			<div id="footer_des">

				<span>
					<span class="style1"><b>Copyright © 2013 by Kiếm Thế Chí Tôn.</b><br>
					<b>Bản quyền KingSoft. Kiếm Thế Chí Tôn phân phối miễn phí.</b></span><br>
			  </span>
				
					
	</div>
		<!--End Footer-->
   
	</body>

</html>