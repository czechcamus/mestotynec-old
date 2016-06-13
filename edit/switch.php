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
 
// zapis zmeny
	if ($tbl == "mastertxt"):
		$updatedcols = "caszapisu = caszapisu, switchoff = $sw";
	elseif ($tbl == "anketa"):
		$updatedcols = "aktiv = $sw";
	elseif ($tbl == "soutez"):
		$updatedcols = "losovano = $sw";
	else:
		$updatedcols = "switchoff = $sw";
	endif;	
	$dotaz = "UPDATE $tbl SET ".$updatedcols." WHERE id=$itemid";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Chyba při úpravě dat - switch - $dotaz!");
	endif;

// vymazání příznaku aktivní ankety u ostatních anket	
	if (($tbl == "anketa") && ($sw == 1)):
		$dotaz = "UPDATE $tbl SET aktiv = 0 WHERE id!=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba při úpravě ostatních anket - switch!");
		endif;
	endif;

	if ($tbl == "anketa"):
		$path = substr($script, 0, StrRPos($script, "/"))."/votemng.php";
	elseif ($tbl == "menu"):
		$path = substr($script, 0, StrRPos($script, "/"))."//webmng.php?menuid=$menuid";
	elseif ($tbl == "tema"):
		$path = substr($script, 0, StrRPos($script, "/"))."/diskusemng.php";
	elseif ($tbl == "soutez"):
		$path = substr($script, 0, StrRPos($script, "/"))."/contestmng.php";
	else:
		$path = substr($script, 0, StrRPos($script, "/"))."/contentmng.php?itemid=$itemid&menuid=$menuid";
	endif;

	Header("Location: http://".$server.":".$port.$path);
?>
