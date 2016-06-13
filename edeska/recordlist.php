<?php
// nacteni nastaveni souboru
include_once 'inc/settings.inc';
include_once $classpath.'dwoo/dwooAutoload.php';
include_once $classpath.'camus/MySqlHandle.php';
include_once $classpath.'camus/LogUser.php';
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
	$scriptname = basename($_SERVER['PHP_SELF'],'.php');

	// údaje uživatele
	$userarr = $loguser->getinfo();
	$userinfo = $userarr['jmeno']." ".$userarr['prijmeni'];
	if (($userarr['admin'] == 1) || ($userarr['udeska'] == 1)) {
		// predavane promenne v url
		foreach ($_GET as $urlvar => $value) {
			${$urlvar} = $value;
		}
		
		if (!isset($act)) {
			// neni nastaveno razeni?
			if (!isset($ord)) {
				$ord = "c6d";	
			}
			
			// neni nastaven filtr?
			if (!isset($filterval) || (isset($submitbutton) && ($submitbutton == "zrušit filtr"))) {
				$filterval = '';
				$filtercol = '';
			}
			
			// obrazky sipek
			for ($i = 1; $i <= 7; $i++) {
				$imgarr["col".$i."imgup"] = "og1au";
				$imgarr["col".$i."imgdown"] = "og1ad";
			}
			
			// vyber razeni
			$img2name = "og2a".(substr($ord,-1));
			switch (substr($ord,0,2)) {		
				case "c1":
					$orderstat = "nazev ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col1img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c2":
					$orderstat = "znacka ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col2img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c3":
					$orderstat = "typ ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col3img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c4":
					$orderstat = "verze ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col4img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c5":
					$orderstat = "puvodce ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col5img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c6":
					$orderstat = "datumr ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col6img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c7":
					$orderstat = "datume ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col7img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
			}	
			
			// číslo stránky
			$thispage = (isset($pagenr) ? $pagenr : 1);
			
			// instance kontroleru
			$dwoo = new Dwoo('tpl/compiled/');
			
			// sablony
			$main = new Dwoo_Template_File('tpl/main.tpl.html');
			$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
			$table = new Dwoo_Template_File('tpl/recordtable.tpl.html');
			$filter = new Dwoo_Template_File('tpl/filterform.tpl.html');
			$record = new Dwoo_Template_File('tpl/recordrecord.tpl.html');
			$recpages = new Dwoo_Template_file('tpl/recpages.tpl.html');
			
			// dotaz pro vyber dat tabulky
			$dat = date("Y-m-d",time());
			$query = "SELECT d.id, d.nazev, d.znacka, t.nazev AS typ, d.version AS verze, p.nazev AS puvodce, d.datumr, d.datume, DATE_FORMAT(d.datumr,'%d.%m.%Y') AS zverejneni_od, DATE_FORMAT(d.datume,'%d.%m.%Y') AS zverejneni_do  
				FROM udeska AS d, udtyp AS t, udpuvodce AS p  
				WHERE d.id_typ=t.id AND d.id_puvodce=p.id   
				".($filterval ? " HAVING $filtercol LIKE '%$filterval%'" : "")." 
				ORDER BY $orderstat";

			// počet záznamů
			$qr1 = $db->makeQuery($query);
			$recnr = mysql_num_rows($qr1);
			
			// dotaz pro výběr skupiny záznamů
			$qr = $db->makeQuery($query." LIMIT ".(($thispage-1)*$recperpage).",$recperpage");
			$listdata = '';
			
			// vyber vsech dat z tabulky
			while ($arr = mysql_fetch_array($qr)) {
				$arr['curl_aid'] = $loguser->curl_aid;
				$arr['editable'] = IsEditable($db,'udeska','id_rel',$arr['id']); 
				$listdata .= $dwoo->get($record, $arr);
			}
			
			// stránkování
			$pagecnt = ceil($recnr/$recperpage);
			$recpagecontent = '';
			if ($recnr > $recperpage) {
				for ($i = 1; $i <= $pagecnt; $i++) {
					$pagearr = array("thispage" => $thispage, "pagenr" => $i, "urlstring" => ($ord ? "ord=$ord&amp;" : "").($filterval ? "filtercol=$filtercol&amp;filterval=$filterval&amp;" : "")."$loguser->curl_aid&amp;ordtyp=$ordtyp&amp;pagenr=$i");
					$recpagecontent .= $dwoo->get($recpages, $pagearr);
				}
			}
			
			// data pro formulář filtru
			$colarr = array('nazev','znacka','typ','verze','puvodce','zverejneni_od','zverejneni_do');
			$filterformcontent = new Dwoo_Data();
			$filterformcontent->assign('ord',$ord);
			$filterformcontent->assign('colarr',$colarr);
			$filterformcontent->assign('filtercol',$filtercol);
			$filterformcontent->assign('filterval',$filterval);
			$filterformcontent->assign('aid',$loguser->aid);
			$filterformdata = $dwoo->get($filter,$filterformcontent);
			
			// kompletace tabulky
			$tablecontent = new Dwoo_Data();
			$tablecontent->assign('tablecontent',$listdata);
			$tablecontent->assign('filterform',$filterformdata);
			$tablecontent->assign('imgarr',$imgarr);
			$tablecontent->assign('filterstring',"&amp;filtercol=$filtercol&amp;filterval=$filterval");
			$tablecontent->assign('curl_aid',$loguser->curl_aid);
			$tablecontent->assign('recpagecontent',$recpagecontent);
			$tabledata = $dwoo->get($table,$tablecontent);
			
			// tvorba menu
			$menudata = $dwoo->get($menu,array('scriptname' => $scriptname, 'curl_aid' => $loguser->curl_aid, 'admin' => ($userarr['admin'] ? 1 : 0)));
			
			// data pro hlavni sablonu
			$data = new Dwoo_Data();
			$data->assign('data',$tabledata);
			$data->assign('copyright','Camus');
			$data->assign('keywords','úřední deska,aldesk,camus');
			$data->assign('description','seznam vyvěšení na úřední desce');
			$data->assign('czday',GetActualCzDay());
			$data->assign('userinfo',$userinfo);
			$data->assign('curl_aid',$loguser->curl_aid);
			$data->assign('idred',$loguser->id);
			$data->assign('menudata',$menudata);
			$data->assign('title','Aldesk 1 - seznam vyvěšení na úřední desce');

			// vystup
			$dwoo->output($main,$data);
		} else {
			// požadavek na smazání zápisu
			if (isset($savebtn)) {
				if ($savebtn == 'ano') {
					// fyzické smazání záznamu
					@$db->makeQuery("DELETE FROM udeska WHERE id=$idrec");
				}
				// původní seznam zápisů
				$host  = $_SERVER['HTTP_HOST'];
				$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
				header("Location: http://$host$uri/$urlstring");	
			} else {
				// formulář pro potvrzení mazání
				// instance kontroleru
				$dwoo = new Dwoo('tpl/compiled/');
				
				// sablony
				$main = new Dwoo_Template_File('tpl/main.tpl.html');
				$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
				$deleteform = new Dwoo_Template_File('tpl/deleteform.tpl.html');
				
				// data pro formulář
				$deletedata = new Dwoo_Data();
				$deletedata->assign('deletetitle',"zápis: ".TableColumnValue($db,'udeska','nazev',$idrec));
				$deletedata->assign('urlstring',basename($_SERVER['HTTP_REFERER']));
				$deletedata->assign('idrec',$idrec);
				$deletedata->assign('aid',$loguser->aid);
				$deleteformdata = $dwoo->get($deleteform,$deletedata);
	
				// tvorba menu
				$menudata = $dwoo->get($menu,array('scriptname' => $scriptname, 'curl_aid' => $loguser->curl_aid, 'admin' => ($userarr['admin'] ? 1 : 0)));
				
				// data pro hlavní šablonu
				$data = new Dwoo_Data();
				$data->assign('data',$deleteformdata);
				$data->assign('copyright','Camus');
				$data->assign('keywords','úřední deska,aldesk,camus');
				$data->assign('description','smazání vyvěšení');
				$data->assign('czday',GetActualCzDay());
				$data->assign('userinfo',$userinfo);
				$data->assign('curl_aid',$loguser->curl_aid);
				$data->assign('idred',$loguser->id);
				$data->assign('menudata',$menudata);
				$data->assign('title','Aldesk 1 - smazání vyvěšení');
				
				// vystup
				$dwoo->output($main,$data);
			}
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