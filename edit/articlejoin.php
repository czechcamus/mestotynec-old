<?php
	include "../scripts/settings.php";
	include "./scripts/editfce.php";
	$idredaktor = CheckLogin();

	$server = $_SERVER['SERVER_NAME'];
	$port = $_SERVER['SERVER_PORT'];
	$script = $_SERVER['SCRIPT_NAME'];
	
	$tbl = "articlejoin";
	$menuid = $_GET['menuid'];
	$itemid = $_GET['itemid'];
 
// zapis zmeny
	$pozice = GetNewPozice("articlejoin",$menuid);
	$dotaz = "INSERT INTO $tbl (menuid,mtid,pozice,idredaktor) VALUES ($menuid,$itemid,$pozice,$idredaktor)";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Chyba při připojení článku - articlejoin - $dotaz!");
	endif;

	$path = substr($script, 0, StrRPos($script, "/"))."/webmng.php?menuid=$menuid";

	Header("Location: http://".$server.":".$port.$path);
?>
