<?php
	$menuid= $_GET['menuid'];
	include "./tpl/header.tpl";
	if ($recordred["admin"] || $recordred["schval"]):
		include "./tpl/articles.tpl";
	endif;
	include "./tpl/articlelist.tpl";
	include "./tpl/footer.tpl";
?>
