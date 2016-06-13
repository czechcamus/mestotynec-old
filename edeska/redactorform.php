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
	$maintable = 'redaktor';
	
	// název scriptu
	$scriptname = basename($_SERVER['PHP_SELF'],'.php');
	
	// údaje uživatele
	$userarr = $loguser->getinfo();
	$userinfo = $userarr['jmeno']." ".$userarr['prijmeni'];
	if (($userarr['admin'] == 1) || ($userarr['udeska'] == 1)) {
		// predavane promenne v url nebo formulari
		foreach ($_GET as $urlvar => $value) {
			${$urlvar} = $value;
		}
			
		if (isset($savebtn)) {
			$showform = false;
			if ($savebtn == "uložit") {
				// kontrola vyplnění povinných údajů
				$errorstring = CheckRequired(array($user,$pwd,$email,$jmeno,$prijmeni));
				if ($errorstring) {
					$showform = true;
				} else {
					// naplnění vlastností záznamu
					$rec = new RecordHandle();
					$rec->assign('user',$user);
					$rec->assign('pwd',$pwd);
					$rec->assign('jmeno',$jmeno);
					$rec->assign('prijmeni',$prijmeni);
					$rec->assign('email',$email);
					$rec->assign('udeska',(isset($admin) ? 0 : 1));
					if ($act == 'add') {
						$idrec = $rec->insert($db,$maintable);
					} else {
						@$rec->update($db,$maintable,$idrec);
					}
				}
			}
			$page = urldecode($redactorlisturl);	
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
				// výběr z tabulky redaktorů
				$qr = $db->makeQuery("SELECT id,user,pwd,jmeno,prijmeni,email FROM $maintable WHERE id=$idrec");
				$arr = mysql_fetch_array($qr);
				foreach ($arr as $key => $value) {
					${$key} = $value;
				}
			}
	
			// url řetězec pro návrat
			if ($act == "add") {
				$redactorlisturl = "redactorlist.php?$loguser->curl_aid";
			} else {
				if (!isset($redactorlisturl)) {
					$redactorlisturl = basename($_SERVER['HTTP_REFERER']);
				} else {
					$redactorlisturl = urldecode($redactorlisturl);
				}
			}
				
			// instance kontroleru
			$dwoo = new Dwoo('tpl/compiled/');
			
			// sablony
			$main = new Dwoo_Template_File('tpl/main.tpl.html');
			$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
			$form = new Dwoo_Template_File('tpl/redactorform.tpl.html');
			
			// celý formulář
			$fdata = new Dwoo_Data();
			$fdata->assign('user',(isset($user) ? $user : ''));
			$fdata->assign('pwd',(isset($pwd) ? $pwd : ''));
			$fdata->assign('jmeno',(isset($jmeno) ? $jmeno : ''));
			$fdata->assign('prijmeni',(isset($prijmeni) ? $prijmeni : ''));
			$fdata->assign('email',(isset($email) ? $email : ''));
			if ($act == "edit") {
				$fdata->assign('idrec',$idrec);
			}
			$fdata->assign('redactorlisturl',urlencode($redactorlisturl));
			$fdata->assign('aid',$loguser->aid);
			$fdata->assign('act',$act);
			$fdata->assign('errorstring',(isset($errorstring) ? $errorstring : '' ));
			$formdata = $dwoo->get($form,$fdata);
			
			// tvorba menu
			$menudata = $dwoo->get($menu,array('scriptname' => $scriptname, 'webname' => $webname, 'curl_aid' => $loguser->curl_aid, 'admin' => ($userarr['admin'] ? 1 : 0)));
		
			// data pro hlavni sablonu
			$data = new Dwoo_Data();
			$data->assign('data',$formdata);
			$data->assign('copyright','Camus');
			$data->assign('keywords','cms,albert,camus');
			$data->assign('description','formulář údajů redaktora');
			$data->assign('czday',GetActualCzDay());
			$data->assign('userinfo',$userinfo);
			$data->assign('curl_aid',$loguser->curl_aid);
			$data->assign('idred',$loguser->id);
			$data->assign('menudata',$menudata);
			$data->assign('title','Aldesk 1 - formulář údajů redaktora');
			
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