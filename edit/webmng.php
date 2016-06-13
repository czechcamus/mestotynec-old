<?php
	$menuid= $_GET['menuid'];
	include "./tpl/header.tpl";
	include "./tpl/menu.tpl";
	if ($menuid):
		include "./tpl/menuarticle.tpl";
//		include "./tpl/contentmt.tpl";
	endif;
	include "./tpl/footer.tpl";
?>
