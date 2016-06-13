<?php
include_once 'classes/Controller.php';

class ControllerMng extends Controller 
{
	public $tpl = 'mng.tpl.html', $title = 'Správa dokumentů', $pref = 'doc', $what = 'dokument', $data = array(), $page = 0, $doc = 1, $curl_aid = '', $userinfo = '';	
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
			$res = $db->makeQuery("SELECT d.id,d.filetitle,filename,DATE_FORMAT(d.obdobiod_d,'%d.%m.%Y') AS obdobiod_d,DATE_FORMAT(d.obdobido_d,'%d.%m.%Y') AS obdobido_d,p.prijmeni,p.jmeno FROM mpdoc AS d, mpperson AS p WHERE d.idmpperson = p.id ORDER BY d.obdobido_d,d.obdobiod_d");
			while ($rec = mysql_fetch_array($res)) 
			{
				$this->data[$rec['id']]['filetitle'] = $rec['filetitle'];
				$this->data[$rec['id']]['filename'] = $rec['filename'];
				$this->data[$rec['id']]['obdobiod_d'] = $rec['obdobiod_d'];
				$this->data[$rec['id']]['obdobido_d'] = $rec['obdobido_d'];
				$this->data[$rec['id']]['prijmeni'] = $rec['prijmeni'];
				$this->data[$rec['id']]['jmeno'] = $rec['jmeno'];
			}
		}
		$db->closeConnection();
	}
}

new ControllerMng();
?>
