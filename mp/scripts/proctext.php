<?php
include_once '../inc/setting.inc';
include_once '../classes/MySqlHandle.php';
include_once '../classes/LogUser.php';
include_once '../classes/TxtHandle.php';

// promenne prostredi
$host  = $_SERVER['HTTP_HOST'];
$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');

// ověření uživatele
$db = new MySqlHandle();
$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);
$user = new LogUser;          // vyvtoření a nastavení instance LogUser
$user->sql = $db;
$user->check();             // kontrola přihlášení
if (empty($user->id)) {
	$host  = $_SERVER['HTTP_HOST'];
	$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
	header("Location: http://$host$uri/loginform.php");
} else {
	// nacteni promennych
	$arr = $_GET;
	$fp1 = new TxtHandle();
	$fp1->writeFile("../inc/text1.txt",$arr['text1']);
	$fp2 = new TxtHandle();
	$fp2->writeFile("../inc/text2.txt",$arr['text2']);
}
$db->closeConnection();

// kam dal
$page = "../usermng.php?$user->curl_aid";
header("Location: http://$host$uri/$page");
exit;
?>