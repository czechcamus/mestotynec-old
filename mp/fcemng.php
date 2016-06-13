<?php
include_once 'classes/Controller.php';

class ControllerMng extends Controller 
{
	public $tpl = 'mng.tpl.html', $title = 'Správa funkcí', $pref = 'fce', $what = 'funkci', $data = array(), $page = 0, $fce = 1, $curl_aid = '', $userinfo = '';	
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
			$res = $db->makeQuery("SELECT * FROM mpfce ORDER BY nazev");
			while ($rec = mysql_fetch_array($res)) 
			{
				$this->data[$rec['id']] = $rec['nazev'];
			}
		}
		$db->closeConnection();
	}
}

new ControllerMng();
?>