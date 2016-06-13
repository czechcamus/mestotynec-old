<?php
// nacteni nastaveni souboru
include_once 'inc/settings.inc';
include_once $classpath.'dwoo/dwooAutoload.php';
include_once $classpath.'camus/MySqlHandle.php';
include_once $classpath.'camus/LogUser.php';
include_once $classpath.'camus/alshopfce.php';

// predavane promenne v url
foreach ($_GET as $urlvar => $value) {
	${$urlvar} = $value;
}

// data z formuláře ?
if (isset($login)) {
	$showform = false;
	
	// otevreni databaze
	$db = new MySqlHandle();
	$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);

	// nacteni promennych
	$errorstring = CheckRequired(array($user,$pwd));
	if (empty($errorstring)) {
		$loguser = new LogUser($db);          // vyvtoření a nastavení instance LogUser
		if ($user) {
			$loguser->login($user, $pwd);
		}
		if (empty($loguser->id)) {
			$errorstring = 'Chybné přihlašovací údaje!';
		}
	}
	
	// kam dal
	if (empty($errorstring)) {
		$page = "index.php?$loguser->curl_aid";
	} else {
		$showform = true;
	}
	
	// zavreni databaze
	$db->closeConnection();
} else {
	$showform = true;
}
// formulář
if ($showform) {
	// instance kontroleru
	$dwoo = new Dwoo('tpl/compiled/');
	
	// sablona
	$loginform = new Dwoo_Template_File('tpl/loginform.tpl.html');
	
	// data pro formulář
	$data = new Dwoo_Data();
	$data->assign('copyright','Camus');
	$data->assign('keywords','úřední deska,aldesk,camus');
	$data->assign('description','přihlášení do systému');
	$data->assign('title','Aldesk 1 - přihlášení do systému');
	$data->assign('errorstring',(isset($errorstring) ? $errorstring : ''));
	$data->assign('user',(isset($user) ? $user : ''));
	$data->assign('pwd',(isset($pwd) ? $pwd : ''));
	
	// vystup
	$dwoo->output($loginform,$data);
} else {
	$host  = $_SERVER['HTTP_HOST'];
	$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
	header("Location: http://$host$uri/$page");	
}
?>