<?php
$pref = "../";
require "usrfce.php";

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$uid = $_GET["uid"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref."index.php";

// výběr uživatele pro potvrzení registrace
$dotaz = "SELECT * FROM uzivatel WHERE MD5(user)='$uid'";
$result = mysql_query("$dotaz");
if (!$result):
	die("Vyber se nezdaril - registeryes.php!");
else:
	$record = mysql_fetch_array($result);
	$id = $record["id"];
	$dotazyes = "UPDATE uzivatel SET povol=1 WHERE id=$id";
	$resultyes = mysql_query("$dotazyes");
	if (!$resultyes):
		die("Nepodarilo se potvrzeni registrace - registeryes.php!");
	endif;
endif;

// návrat na úvodní stránku
Header("Location: http://".$server.":".$port.$path);
?>