<?php
// nacteni nastaveni souboru
include_once 'inc/settings.inc';
include_once $classpath.'dwoo/dwooAutoload.php';
include_once $classpath.'camus/MySqlHandle.php';
include_once $classpath.'camus/LogUser.php';
include_once $classpath.'camus/albert4fce.php';

// otevreni databaze
$db = new MySqlHandle();
$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);

// kontrola přihlášení uživatele
$loguser = new LogUser($db);          	// vyvtoření a nastavení instance LogUser
$loguser->check();             			// kontrola přihlášení
if (empty($loguser->id)) {
	$host  = $_SERVER['HTTP_HOST'];
	$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
	header("Location: http://$host$uri/loginform.php");
} else {
	$scriptname = basename($_SERVER['PHP_SELF'],'.php');
	// údaje uživatele
	$userarr = $loguser->getinfo();
	$userinfo = $userarr['jmeno']." ".$userarr['prijmeni'];
	
	// predavane promenne v url
	foreach ($_GET as $urlvar => $value) {
		${$urlvar} = $value;
	}
	
	// je předána proměnná act
	$act = (isset($act) ? $act : '');

	// je předán identifikátor zápisu
	if (!isset($idrec)) {
		die("$scriptname - chybi promenna \$idrec");
	}
	
	// je předán přepínač
	if (isset($public)) {
		@$db->makeQuery("UPDATE udeska SET public = ".($public == 'on' ? 1 : 0)." WHERE id=$idrec");
	}

	// instance kontroleru
	$dwoo = new Dwoo('tpl/compiled/');
	
	// sablony
	$main = new Dwoo_Template_File('tpl/main.tpl.html');
	$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
	$content = new Dwoo_Template_File('tpl/recordcontent.tpl.html');
	
	// dotaz pro vyber dat z tabulky udeska
	$qr = $db->makeQuery("SELECT d.nazev,d.znacka,d.text,d.version AS verze,d.docfile,d.public,p.nazev AS puvodce,t.nazev AS typ,DATE_FORMAT(d.datum1,'%d.%m.%Y') AS zverejneni_od,DATE_FORMAT(d.datum2,'%d.%m.%Y') AS zverejneni_do,DATE_FORMAT(d.newtime,'%d.%m.%Y %H:%i') AS newtime,IF(ISNULL(d.lasttime),'',DATE_FORMAT(d.lasttime,'%d.%m.%Y %H:%i')) AS lasttime FROM udeska AS d,udpuvodce AS p,udtyp AS t WHERE d.id = $idrec AND d.id_typ = t.id AND d.id_puvodce = p.id");
	$arr = mysql_fetch_array($qr);
	$arr['recordlisturl'] = "recordlist.php?$loguser->curl_aid";
	$arr['idrec'] = $idrec;
	$arr['curl_aid'] = $loguser->curl_aid;
	$arr['public'] = ($arr['public'] ? 'on' : 'off');
	$contentdata = $dwoo->get($content, $arr);
	
	// tvorba menu
	$menudata = $dwoo->get($menu,array('scriptname' => $scriptname, 'curl_aid' => $loguser->curl_aid, 'idrec' => $idrec, 'admin' => ($userarr['admin'] ? 1 : 0)));
	
	// data pro hlavni sablonu
	$data = new Dwoo_Data();
	$data->assign('data',$contentdata);
	$data->assign('copyright','Camus');
	$data->assign('keywords','úřední deska,aldesk,camus');
	$data->assign('description','detaily zápisu na úřední desce');
	$data->assign('czday',GetActualCzDay());
	$data->assign('userinfo',$userinfo);
	$data->assign('curl_aid',$loguser->curl_aid);
	$data->assign('idred',$loguser->id);
	$data->assign('menudata',$menudata);
	$data->assign('title','Aldesk 1 - detaily zápisu na úřední desce');
	
	// vystup
	$dwoo->output($main,$data);
}	
// zavreni databaze
$db->closeConnection();
?>