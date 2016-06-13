<?php
	$step = $_GET["step"];
	$csvname = urldecode($_GET["csvname"]);
	$oddelovac = $_GET["oddelovac"];
	$tblname = $_GET["tblname"];
	$titulek = $_GET["titulek"];
	$errtxt = $_GET["errtxt"];
	include "./tpl/header.tpl";
	if (!$step):
		include "./tpl/formimpcsv1.tpl";
	else:
		include "./tpl/formimpcsv2.tpl";
	endif;
	include "./tpl/footer.tpl";
?>