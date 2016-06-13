<?php
include_once '../inc/setting.inc';
include_once '../classes/MySqlHandle.php';
include_once '../classes/RecordHandle.php';
include_once '../classes/LogUser.php';

// promenne prostredi
$host  = $_SERVER['HTTP_HOST'];
$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');

// ověření uživatele
$db = new MySqlHandle();
$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);
$user = new LogUser;          // vyvtoření a nastavení instance LogUser
$user->sql = $db;
$user->check();             // kontrola přihlášení
$user->logout();
$db->closeConnection();
// kam dal
$page = "../loginform.php";	
header("Location: http://$host$uri/$page");
exit;
?>