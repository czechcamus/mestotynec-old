<?php
	include "../scripts/settings.php";
	include "./scripts/editfce.php";
	$idredaktor = CheckLogin();

	$server = $_SERVER['SERVER_NAME'];
	$port = $_SERVER['SERVER_PORT'];
	$script = $_SERVER['SCRIPT_NAME'];
	
	$tbl = $_GET["tbl"];
	$menuid = $_GET['menuid'];
	$itemid = $_GET['itemid'];
	$sw =  $_GET['sw'];
	$tbl = $_GET["tbl"];
	$ttbl = $_GET["ttbl"];
	$fn = $_GET["fn"];
 
// zápis změny
	if ($tbl == "kalendar"):
		$updatedcols = "schvaleno = $sw";
	else:
		$updatedcols = "publish = $sw";
	endif;	
	$dotaz = "UPDATE $tbl SET ".$updatedcols." WHERE id=$itemid";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Chyba při úpravě dat - publish!");
	endif;
	
	if ($sw == 1):
		include "tpl/createxml.tpl";
	endif;

	if ($ttbl == "cis"):
		$path = substr($script, 0, strrpos($script, "/"))."/".$fn;
	else:
		$path = substr($script, 0, StrRPos($script, "/"))."/articlemng.php?itemid=$itemid&menuid=$menuid";
	endif;

	Header("Location: http://".$server.":".$port.$path);
?>
