<?php
// nacteni nastaveni souboru
include_once 'inc/settings.inc';
include_once $classpath.'camus/MySqlHandle.php';
include_once $classpath.'camus/LogUser.php';

// otevreni databaze
$db = new MySqlHandle();
$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);

// proměnné prostředí
$host  = $_SERVER['HTTP_HOST'];
$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');

// kontrola přihlášení uživatele
$loguser = new LogUser($db);          	// vyvtoření a nastavení instance LogUser
$loguser->check();             			// kontrola přihlášení
if (empty($loguser->id)) {
	header("Location: http://$host$uri/loginform.php");
} else {
	// údaje uživatele
	$userarr = $loguser->getinfo();
	if (($userarr['admin'] == 1) || ($userarr['udeska'] == 1)) {
		$page = "recordlist.php";
		$varstring = "";
	} else {
		$page = "loginform.php";
		$errorstring = urlencode("Pro přístup nemáte dostatečná oprávnění");
		$varstring = "&errorstring=$errorstring";
	}
	header("Location: http://$host$uri/$page?$loguser->curl_aid.$varstring");
}	
// zavreni databaze
$db->closeConnection();
?>