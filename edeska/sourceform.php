<?php
// nacteni nastaveni souboru
include_once 'inc/settings.inc';
include_once $classpath.'dwoo/dwooAutoload.php';
include_once $classpath.'camus/MySqlHandle.php';
include_once $classpath.'camus/LogUser.php';
include_once $classpath.'camus/RecordHandle.php';
include_once $classpath.'camus/alshopfce.php';

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
	// hlavní tabulka
	$maintable = 'udpuvodce';
	
	$scriptname = basename($_SERVER['PHP_SELF'],'.php');
	
	// údaje uživatele
	$userarr = $loguser->getinfo();
	$userinfo = $userarr['jmeno']." ".$userarr['prijmeni'];
	if (($userarr['admin'] == 1) || ($userarr['udeska'] == 1)) {
		// predavane promenne v url
		foreach ($_GET as $urlvar => $value) {
			${$urlvar} = $value;
		}
	
		if (isset($savebtn)) {
			$showform = false;
			if ($savebtn == "uložit") {
				// kontrola vyplnění povinných údajů
				$errorstring = CheckRequired(array($nazev));
				if ($errorstring) {
					$showform = true;
				} else {
					// naplnění vlastností záznamu
					$rec = new RecordHandle();
					$rec->assign('nazev',$nazev);
					$rec->assign('ulice',$ulice);
					$rec->assign('misto',$misto);
					$rec->assign('psc',$psc);
					$rec->assign('udvlastnik',(isset($udvlastnik) && !empty($udvlastnik) ? 1 : 0));
					$rec->assign('id_redaktor',$loguser->id);
					if ($act == 'add') {
						$idrec = $rec->insert($db,$maintable);
					} else {
						$rec->update($db,$maintable,$idrec);
					}
				}
			}
			$page = urldecode($sourcelisturl);	
		} else {
			$showform = true;
		}
	
	// zobrazení formuláře	
		if ($showform) {
			// neznámý režim práce - konec
			if (!isset($act)) {
				die("$scriptname - chybi promenna \$act");
			}
			
			// režim editace - první načtení dat z databáze
			if (!isset($savebtn) && ($act == "edit")) {
				// neznámý záznam - konec
				if (!isset($idrec)) {
					die("$scriptname - chybi promenna \$idrec");
				}
				// výběr z tabulky udpuvodce
				$ar = $db->makeQuery("SELECT nazev, ulice, misto, psc, udvlastnik FROM $maintable WHERE id=$idrec");
				$arr = mysql_fetch_array($ar);
				foreach ($arr as $key => $value) {
					${$key} = $value;
				}
			}
	
			// url řetězec pro návrat
			if ($act == "add") {
				$sourcelisturl = "sourcelist.php?$loguser->curl_aid";
			} else {
				if (!isset($sourcelisturl)) {
					$sourcelisturl = basename($_SERVER['HTTP_REFERER']);
				} else {
					$sourcelisturl = urldecode($sourcelisturl);
				}
			}
			
			// instance kontroleru
			$dwoo = new Dwoo('tpl/compiled/');
			
			// sablony
			$main = new Dwoo_Template_File('tpl/main.tpl.html');
			$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
			$form = new Dwoo_Template_File('tpl/sourceform.tpl.html');
			
			// celý formulář
			$fdata = new Dwoo_Data();
			$fdata->assign('nazev',(isset($nazev) ? $nazev : ''));
			$fdata->assign('ulice',(isset($ulice) ? $ulice : ''));
			$fdata->assign('misto',(isset($misto) ? $misto : ''));
			$fdata->assign('psc',(isset($psc) ? $psc : ''));
			$fdata->assign('udvlastnik',(isset($udvlastnik) && $udvlastnik ? true : false));
			if ($act == "edit") {
				$fdata->assign('idrec',$idrec);
			}
			$fdata->assign('sourcelisturl',urlencode($sourcelisturl));
			$fdata->assign('aid',$loguser->aid);
			$fdata->assign('act',$act);
			$fdata->assign('errorstring',(isset($errorstring) ? $errorstring : '' ));
			$formdata = $dwoo->get($form,$fdata);
			
			// tvorba menu
			$menudata = $dwoo->get($menu,array('scriptname' => $scriptname, 'curl_aid' => $loguser->curl_aid, 'admin' => ($userarr['admin'] ? 1 : 0)));
		
			// data pro hlavni sablonu
			$data = new Dwoo_Data();
			$data->assign('data',$formdata);
			$data->assign('copyright','Camus');
			$data->assign('keywords','úřední,deska,správa,aldesk,camus');
			$data->assign('description','formulář zápisu původce');
			$data->assign('czday',GetActualCzDay());
			$data->assign('userinfo',$userinfo);
			$data->assign('curl_aid',$loguser->curl_aid);
			$data->assign('idred',$loguser->id);
			$data->assign('menudata',$menudata);
			$data->assign('title','Aldesk 1 - formulář zápisu původce');
						
			// vystup
			$dwoo->output($main,$data);
		} else {
			$host  = $_SERVER['HTTP_HOST'];
			$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
			header("Location: http://$host$uri/$page");	
		}
	} else {
		$page = "loginform.php";
		$errorstring = urlencode("Pro přístup nemáte dostatečná oprávnění");
		$varstring = "&errorstring=$errorstring";
		header("Location: http://$host$uri/$page?$loguser->curl_aid.$varstring");
	}
}	
// zavreni databaze
$db->closeConnection();
?>