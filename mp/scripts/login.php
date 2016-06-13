<?php
include_once '../inc/setting.inc';
include_once '../classes/MySqlHandle.php';
include_once '../classes/LogUser.php';

// promenne prostredi
$host  = $_SERVER['HTTP_HOST'];
$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');

// nacteni promennych
$err = '';
$arr = $_REQUEST;
$db = new MySqlHandle();
$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);
$err = CheckRequired($arr);
if (empty($err)) {
	$user = new LogUser;          // vyvtoření a nastavení instance LogUser
	$user->sql = $db;
	if ($arr['user']) {
		$user->login($arr['user'], $arr['pwd']);
	}
}
$db->closeConnection();
if (empty($user->id)) {
	$err = 'Chybné přihlašovací údaje';
}

// kam dal
if (empty($err)) {
	$page = "../index.php?$user->curl_aid";
} else {
	$page = "../".basename($_SERVER['HTTP_REFERER'])."?err=$err";
	foreach ($arr as $key => $val) {
		$page .= "&$key=$val";
	}
}
header("Location: http://$host$uri/$page");
exit;

function CheckRequired($fields)
// v případě nevyplnění povinné položky vrací funkce chybový řetězec
{
	$e = '';
	$reqfields = split(',',$fields['required']);
	foreach ($reqfields as $field) {
		if (empty($fields[$field])) {
			$e = 'Chybí některý z povinných údajů (označené hvězdičkou)!';
		}
	}
	return $e;
}
?>