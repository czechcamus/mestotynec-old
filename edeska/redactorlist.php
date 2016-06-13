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
	if (($userarr['admin'] == 1) || ($userarr['udeska'] == 1)) {
		// predavane promenne v url
		foreach ($_GET as $urlvar => $value) {
			${$urlvar} = $value;
		}
		
		// není žádná akce?
		if (!isset($act)) {
			// neni nastaveno razeni?
			if (!isset($ord)) {
				$ord = "c1u";	
			}
			
			// neni nastaven filtr?
			if (!isset($filterval) || (isset($submitbutton) && ($submitbutton == "zrušit filtr"))) {
				$filterval = '';
				$filtercol = '';
			}
			
			// obrazky sipek
			for ($i = 1; $i <= 4; $i++) {
				$imgarr["col".$i."imgup"] = "og1au";
				$imgarr["col".$i."imgdown"] = "og1ad";
			}
			
			// vyber razeni
			$img2name = "og2a".(substr($ord,-1));
			switch (substr($ord,0,2)) {		
				case "c1":
					$orderstat = "redaktor ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col1img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c2":
					$orderstat = "user ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col2img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c3":
					$orderstat = "email ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col3img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
				case "c4":
					$orderstat = "admin ".(substr($ord,-1) == "u" ? "ASC" : "DESC");
					$imgarr["col4img".(substr($ord,-1) == "u" ? "up" : "down")] = $img2name;
					break;
			}	
			
			// číslo stránky
			$thispage = (isset($pagenr) ? $pagenr : 1);
			
			
			// instance kontroleru
			$dwoo = new Dwoo('tpl/compiled/');
			
			// sablony
			$main = new Dwoo_Template_File('tpl/main.tpl.html');
			$menu =  new Dwoo_Template_File('tpl/menu.tpl.html');
			$table = new Dwoo_Template_File('tpl/redactortable.tpl.html');
			$filter = new Dwoo_Template_File('tpl/filterform.tpl.html');
			$record = new Dwoo_Template_File('tpl/redactorrecord.tpl.html');
			$recpages = new Dwoo_Template_file('tpl/recpages.tpl.html');
		
			// počet záznamů
			$query = "SELECT id,user,CONCAT(prijmeni,' ',jmeno) AS redaktor,email,IF(admin=1,'ano','ne') AS admin FROM redaktor WHERE admin=1 OR udeska=1 ".($filterval ? "HAVING $filtercol LIKE '%$filterval%'" : '')." ORDER BY $orderstat";
			$qr1 = $db->makeQuery($query);
			$recnr = mysql_num_rows($qr1);
		
			// dotaz pro výběr skupiny záznamů
			$qr = $db->makeQuery($query." LIMIT ".(($thispage-1)*$recperpage).",$recperpage");
			$listdata = '';
			// vyber vsech dat z tabulky
			while ($arr = mysql_fetch_array($qr)) {
				$arr['curl_aid'] = $loguser->curl_aid;
				$listdata .= $dwoo->get($record, $arr);
			}
		
			// stránkování
			$pagecnt = ceil($recnr/$recperpage);
			$recpagecontent = '';
			if ($recnr > $recperpage) {
				for ($i = 1; $i <= $pagecnt; $i++) {
					$pagearr = array("thispage" => $thispage, "pagenr" => $i, "urlstring" => ($ord ? "ord=$ord&amp;" : "").($filterval ? "filtercol=$filtercol&amp;filterval=$filterval&amp;" : "")."$loguser->curl_aid&amp;idweb=$idweb&amp;pagenr=$i");
					$recpagecontent .= $dwoo->get($recpages, $pagearr);
				}
			}
		
			// data pro formulář filtru
			$colarr = array('redaktor','user','email','admin');
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
			$data->assign('keywords','cms,albert,camus');
			$data->assign('description','seznam redaktorů');
			$data->assign('czday',GetActualCzDay());
			$data->assign('userinfo',$userinfo);
			$data->assign('curl_aid',$loguser->curl_aid);
			$data->assign('idred',$loguser->id);
			$data->assign('menudata',$menudata);
			$data->assign('title','Aldesk 1 - seznam redaktorů');
		} else {
			// požadavek na smazání redaktora
			if (isset($savebtn)) {
				if ($savebtn == 'ano') {
					// fyzické smazání záznamu
					@$db->makeQuery("DELETE FROM redaktor WHERE id=$idrec");
				}
				// původní seznam 
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
				$deletedata->assign('deletetitle','redaktora: '.TableColumnValue($db,'redaktor','prijmeni',$idrec)." ".TableColumnValue($db,'redaktor','jmeno',$idrec));
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
				$data->assign('keywords','cms,albert,camus');
				$data->assign('description','smazání redaktora');
				$data->assign('czday',GetActualCzDay());
				$data->assign('userinfo',$userinfo);
				$data->assign('curl_aid',$loguser->curl_aid);
				$data->assign('idred',$loguser->id);
				$data->assign('menudata',$menudata);
				$data->assign('title','Aldesk 1 - smazání redaktora');
			}
		}
	}
		
	// vystup
	$dwoo->output($main,$data);
}	
// zavreni databaze
$db->closeConnection();
?>