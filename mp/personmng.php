<?php
include_once 'classes/Controller.php';

class ControllerMng extends Controller 
{
	public $tpl = 'mng.tpl.html', $title = 'Správa osob', $pref = 'person', $what = 'osobu', $data = array(), $page = 0, $person = 1, $curl_aid = '', $userinfo = '';	
	public function start()
	{
		include_once 'inc/setting.inc';
		include_once 'classes/MySqlHandle.php';
		include_once 'classes/LogUser.php';
		$db = new MySqlHandle();
		$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);
		$user = new LogUser;          // vyvtoření a nastavení instance LogUser
		$user->sql = $db;
		$user->check();             // kontrola přihlášení
		if (empty($user->id)) {
			$host  = $_SERVER['HTTP_HOST'];
			$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
			header("Location: http://$host$uri/loginform.php");
		} else {
			$userarr = $user->getinfo();
			$this->userinfo = $userarr['jmeno']." ".$userarr['prijmeni'];
			$this->curl_aid = $user->curl_aid;
			$res = $db->makeQuery("SELECT p.id,p.titulpred,p.jmeno,p.prijmeni,p.titulza,DATE_FORMAT(p.narozen_d,'%d.%m.%Y') AS narozen_d,f.nazev FROM mpperson AS p, mpfce AS f WHERE p.idmpfce = f.id ORDER BY prijmeni");
			while ($rec = mysql_fetch_array($res)) 
			{
				$this->data[$rec['id']]['titulpred'] = $rec['titulpred'];
				$this->data[$rec['id']]['jmeno'] = $rec['jmeno'];
				$this->data[$rec['id']]['prijmeni'] = $rec['prijmeni'];
				$this->data[$rec['id']]['titulza'] = $rec['titulza'];
				$this->data[$rec['id']]['narozen_d'] = $rec['narozen_d'];
				$this->data[$rec['id']]['funkce'] = $rec['nazev'];
			}
		}
		$db->closeConnection();
	}
}

new ControllerMng();
?>