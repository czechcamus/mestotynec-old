<?php include "./tpl/header.tpl";
	if ($recordred["admin"] || $recordred["schval"]):
		include "./tpl/articles.tpl";
	endif;
	include "./tpl/links.tpl";
	include "./tpl/footer.tpl";
?>
