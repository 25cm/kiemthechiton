		<!--Mainmenu-->
		<div id="main_menu">
			<div id="main_mn">
<ul>
<li><a href="http://kiemthechiton.net" id="trang-chu">
	<span class="head_a"></span>
	Trang chủ<span class="head_b"></span></a><span class="head_b"></span>
</a></li>

	

<li><a href="http://kiemthechiton.net/forum" target='new' id="nap-ssroll">
	<span class="head_a"></span>
	Diễn đàn<span class="head_b"></span></a><span class="head_b"></span>
</a></li>

<li><a href="download.php" target='new' id="nap-ssroll">
	<span class="head_a"></span>
	Download Game<span class="head_b"></span></a><span class="head_b"></span>
</a></li>

<li><a href="napthe.php" target='new' id="nap-ssroll">
	<span class="head_a"></span>
	Nạp thẻ<span class="head_b"></span></a><span class="head_b"></span>
</a></li>

</ul>
                        <div id="main_reg">
						<?php if(!isset($_SESSION['user_login']) or $_SESSION['user_login']==''){?>
						<a href="index.php"><input class="login_b" type="submit" name="submitButtonName" value="Đăng ký" /></a>
						<?php }else{ ?>
						Chào: <font color=#fff size=4><?=$_SESSION['user_login'];?></font> (<a href="" onclick="return dangxuat();">Đăng xuất</a>)
						<?php }?>
						</div>
                    </div>
        </div>
		<!--END Mainmenu-->