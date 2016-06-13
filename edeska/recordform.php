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
	$maintable = 'udeska';
	
	$scriptname = basename($_SERVER['PHP_SELF'],'.php');
	
	// údaje uživatele
	$userarr = $loguser->getinfo();
	$userinfo = $userarr['jmeno']." ".$userarr['prijmeni'];
	if (($userarr['admin'] == 1) || ($userarr['udeska'] == 1)) {
		// predavane promenne v url
		foreach ($_GET as $urlvar => $value) {
			${$urlvar} = $value;
		}
	
		// predavane promenne ve formuláři
		foreach ($_POST as $urlvar => $value) {
			${$urlvar} = $value;
		}
		
		if (isset($savebtn)) {
			$showform = false;
			if ($savebtn == "uložit") {
				$id_typ = (isset($id_typ) ? $id_typ : 0);
				$id_puvodce = (isset($id_puvodce) ? $id_puvodce : 0);
				// kontrola vyplnění povinných údajů
				$errorstring = CheckRequired(array($nazev,$id_typ,$id_puvodce,$datum1,$datum2));
				if ($errorstring) {
					$showform = true;
				} else {
					// kontrola správnosti datumů
					$errorstring = CheckValidDate(array($datum1,$datum2));
					if ($errorstring) {
						$showform = true;
					} else {
						// kontrola hodnot datumů 1
						$dbdatum1 = DateConvertForDb($datum1);
						$dbdatum2 = DateConvertForDb($datum2);
						$errorstring = ($dbdatum1 > $dbdatum2 ? "Počáteční datum je větší než datum koncové!" : "");
						if ($errorstring) {
							$showform = true;
						} else {
							// kontrola hodnot datumů 2
							$dbdatum3 = ($datum3 ? DateConvertForDb($datum3) : '');
							$dbdatum4 = ($datum4 ? DateConvertForDb($datum4) : '');
							$errorstring = ($dbdatum3 > $dbdatum4 ? "Počáteční datum je větší než datum koncové!" : "");
							if ($errorstring) {
								$showform = true;
							} else {
								// naplnění vlastností záznamu
								$rec = new RecordHandle();
								$rec->assign('nazev',$nazev);
								$rec->assign('text',$text);
								$rec->assign('znacka',$znacka);
								$rec->assign('id_typ',$id_typ);
								$rec->assign('id_puvodce',$id_puvodce);
								$rec->assign('datum1',$dbdatum1);
								$rec->assign('datum2',$dbdatum2);
								if ($datum3 && $datum4) {
									$rec->assign('datum3',$dbdatum3);
									$rec->assign('datum4',$dbdatum4);
								}
								if ($_FILES['docfiletmp']['name']) {
									$fullfile = CreateFile2Handle($_FILES['docfiletmp'],$_SERVER['PHP_SELF'],'download/edeska'); // místo $weburl -> $_SERVER['PHP_SELF']
									if (!$fullfile) {
										die("$scriptname - chyba pri uploadu souboru \$docfiletmp");
									}
								} else {
									$fullfile = htmlspecialchars(strip_tags($docfile),ENT_QUOTES);
								}
								$rec->assign('docfile',$fullfile);
								$rec->assign('public',1);
								$rec->assign('id_redaktor',$loguser->id);
								$timestamp = time();
								$thistime = date("Y-m-d H:i:s",$timestamp);
                                                                $rec->assign('istempfile',(isset($istempfile) ? 1 : 0));
								if ($act == 'add') {
									$rec->assign('datumr',$thistime);
									$rec->assign('datume',($lhuta ? date("Y-m-d H:i:s",$timestamp+($lhuta*86400)) : $thistime));
									$rec->assign('newtime',$thistime);
									$rec->assign('version',1);
									$rec->assign('public',1);
									$rec->assign('id_redaktor',$loguser->id);
									$idrec = $rec->insert($db,$maintable);
								} else {
									if (isset($newversion)) {
										$rec->assign('version',TableColumnValue($db,$maintable,'version',$idrec)+1);
										$datumr = TableColumnValue($db,$maintable,'datumr',$idrec);
										$rec->assign('datumr',$datumr);
										$datume = ($lhuta ? date("Y-m-d H:i:s",mktime(substr($datumr,11,2),substr($datumr,14,2),substr($datumr,17,2),substr($datumr,5,2),substr($datumr,8,2),substr($datumr,0,4))+($lhuta*86400)) : $datumr);
										$rec->assign('datume',$datume);
										$rec->assign('newtime',$thistime);
										$rec->assign('id_rel',$idrec);
										$rec->assign('public',1);
										$rec->assign('id_redaktor',$loguser->id);
										@$rec->insert($db,$maintable);
										// úprava původního záznamu
										$rec2 = new RecordHandle();
										$rec2->assign('lasttime',$thistime);
										$rec2->assign('public',0);
										$rec2->update($db,$maintable,$idrec);
									} else {
										if ($lhuta) {
											$datumr = TableColumnValue($db,$maintable,'datumr',$idrec);
											$datume = ($lhuta ? date("Y-m-d H:i:s",mktime(substr($datumr,11,2),substr($datumr,14,2),substr($datumr,17,2),substr($datumr,5,2),substr($datumr,8,2),substr($datumr,0,4))+($lhuta*86400)) : $datumr);
											$rec->assign('datume',$datume);
										}						
										$rec->update($db,$maintable,$idrec);
									}
								}
							}
						}
					}
				}
			}
			$page = urldecode($recordlisturl);	
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
				// výběr z tabulky udeska
				$query = "SELECT nazev,text, znacka, istempfile, id_typ, id_puvodce, DATE_FORMAT(datum1,'%d.%m.%Y') AS datum1, 
								 DATE_FORMAT(datum2,'%d.%m.%Y') AS datum2, DATE_FORMAT(datum3,'%d.%m.%Y') AS datum3, 
								 DATE_FORMAT(datum4,'%d.%m.%Y') AS datum4, docfile, version 
								 FROM $maintable WHERE id=$idrec";
				$ar = $db->makeQuery($query);
				$arr = mysql_fetch_array($ar);
				foreach ($arr as $key => $value) {
					${$key} = $value;
				}
				$lhuta = (mktime(0,0,0,substr($datum2,3,2),substr($datum2,0,2),substr($datum2,6,4))-mktime(0,0,0,substr($datum1,3,2),substr($datum1,0,2),substr($datum1,6,4)))/86400;
			}
	
			// url řetězec pro návrat
			if ($act == "add") {
				$recordlisturl = "recordlist.php?$loguser->curl_aid";
			} else {
				if (!isset($recordlisturl)) {
					$recordlisturl = basename($_SERVER['HTTP_REFERER']);
				} else {
					$recordlisturl = urldecode($recordlisturl);
				}
			}
			
			// instance kontroleru
			$dwoo = new Dwoo('tpl/compiled/');
			
			// sablony
			$main = new Dwoo_Template_File('tpl/main.tpl.html');
			$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
			$form = new Dwoo_Template_File('tpl/recordform.tpl.html');
			$optionselect = new Dwoo_Template_File('tpl/optionselect.tpl.html');
			
			// seznam kategorií
			$qr = $db->makeQuery("SELECT id,nazev FROM udtyp ORDER BY nazev");
			$typdata = '';
			while ($arr = mysql_fetch_array($qr)) {
				$arr['idselect'] = (isset($id_typ) ? $id_typ : 0);
				$arr['idoption'] = $arr['id'];
				$arr['titleoption'] = $arr['nazev'];
				$typdata .= $dwoo->get($optionselect,$arr);
			}
			
			// seznam původců
			$qr = $db->makeQuery("SELECT id,nazev,ulice,misto FROM udpuvodce ORDER BY nazev+ulice+misto");
			$puvodcedata = '';
			while ($arr = mysql_fetch_array($qr)) {
				$arr['idselect'] = (isset($id_puvodce) ? $id_puvodce : 0);
				$arr['idoption'] = $arr['id'];
				$arr['titleoption'] = $arr['nazev'].($arr['ulice'] ?  ", ".$arr['ulice'] : '').($arr['misto'] ?  ", ".$arr['misto'] : '');
				$puvodcedata .= $dwoo->get($optionselect,$arr);
			}
			
			// celý formulář
			$fdata = new Dwoo_Data();
			$fdata->assign('nazev',(isset($nazev) ? $nazev : ''));
			$fdata->assign('text',(isset($text) ? $text : ''));
			$fdata->assign('znacka',(isset($znacka) ? $znacka : ''));
			$fdata->assign('typdata',$typdata);
			$fdata->assign('puvodcedata',$puvodcedata);
			$fdata->assign('datum1',(isset($datum1) ? $datum1 : date("d.m.Y",time())));
			$fdata->assign('lhuta',(isset($lhuta) ? $lhuta : $deflhuta));
			$fdata->assign('datum2',(isset($datum2) ? $datum2 : ''));
			$fdata->assign('datum3',(isset($datum3) ? $datum3 : ''));
			$fdata->assign('datum4',(isset($datum4) ? $datum4 : ''));
			$fdata->assign('docfile',(isset($docfile) ? $docfile : ''));
			$fdata->assign('version',(isset($version) ? $version : 1));
			$fdata->assign('istempfile',(isset($istempfile) && $istempfile ? true : false));
			$fdata->assign('newversion',(isset($newversion) && $newversion ? true : false));
			if ($act == "edit") {
				$fdata->assign('idrec',$idrec);
			}
			$fdata->assign('recordlisturl',urlencode($recordlisturl));
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
			$data->assign('description','formulář zápisu úřední desky');
			$data->assign('czday',GetActualCzDay());
			$data->assign('userinfo',$userinfo);
			$data->assign('curl_aid',$loguser->curl_aid);
			$data->assign('idred',$loguser->id);
			$data->assign('menudata',$menudata);
			$data->assign('title','Aldesk 1 - formulář zápisu úřední desky');
			
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