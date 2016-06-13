<?php
include_once 'classes/Controller.php';

class ControllerPrint extends Controller 
{
	public $tpl = 'printuser.tpl.html', $title = 'Údaje uživatele', $id = 0, $text1 = '', $text2 = '', $username = '', $userpswd = '', $curl_aid = '', $userinfo = '', $today = '';
	
	public function start()
	{
		// data
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
			$this->today = date('d.m.Y',time());
			$this->curl_aid = $user->curl_aid;
			// data - text
			include_once 'classes/TxtHandle.php';
			$fp1 = new TxtHandle();
			$this->text1 = $fp1->readFile("inc/text1.txt");
			$fp2 = new TxtHandle();
			$this->text2 = $fp2->readFile("inc/text2.txt");
			// data - databáze
			$this->id = $_REQUEST['id'];
			$arr = mysql_fetch_array($db->makeQuery("SELECT * FROM mpuser WHERE id=$this->id"));
			
			// plneni promennych
			foreach ($arr as $key => $var) {
				$this->$key = $var;
			}
		}			
		// ukonceni spojeni
		$db->closeConnection();
	}
}

new ControllerPrint();
?>