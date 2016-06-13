<?php
include_once 'classes/Controller.php';

class ControllerFce extends Controller 
{
	public $tpl = 'fceform.tpl.html', $title = 'Formulář pro údaje funkce', $id = 0, $nazev = '', $curl_aid = '', $userinfo = '';
	
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
			$this->curl_aid = $user->curl_aid;
			$this->error = (isset($_REQUEST['err']) ? $_REQUEST['err'] : '');
			$act = (isset($_REQUEST['act']) ? $_REQUEST['act'] : '');
			if ($act == "edit") {
				$this->id = $_REQUEST['id'];
				if (isset($_REQUEST['save'])) {
					$arr = $_REQUEST;
				} else {
					// databaze
					$arr = mysql_fetch_array($db->makeQuery("SELECT * FROM mpfce WHERE id=$this->id"));
				}				
			} else {
				$arr = $_REQUEST;	
			}
			// plneni promennych
			foreach ($arr as $key => $var) {
				$this->$key = $var;
			}
			
			include_once 'HTML/Template/Flexy/Element.php';
			$this->elements[$user->url_name] = new HTML_Template_Flexy_Element;
			$this->elements[$user->url_name]->setValue($user->url_aid);
			$this->elements['nazev'] = new HTML_Template_Flexy_Element;
			$this->elements['nazev']->setValue($this->nazev);
			$this->elements['act'] = new HTML_Template_Flexy_Element;
			$this->elements['act']->setValue($act);
			$this->elements['form'] = new HTML_Template_Flexy_Element;
			$this->elements['form']->setValue('fce');
			
			// ukonceni spojeni
			if ($act == "edit") {
				$this->elements['id'] = new HTML_Template_Flexy_Element;
				$this->elements['id']->setValue($this->id);
			}
		}
		$db->closeConnection();
	}
}

new ControllerFce();
?>