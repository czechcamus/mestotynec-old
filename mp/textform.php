<?php
include_once 'classes/Controller.php';

class ControllerTxt extends Controller 
{
	public $tpl = 'textform.tpl.html', $title = 'Formulář pro úpravu textů', $text1 = '', $text2 = '', $elements = array(), $curl_aid = '', $userinfo = '';
	
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
			// textové soubory
			include_once 'classes/TxtHandle.php';
			$fp1 = new TxtHandle();
			$this->text1 = $fp1->readFile("inc/text1.txt");
			$fp2 = new TxtHandle();
			$this->text2 = $fp2->readFile("inc/text2.txt");
			
			include_once 'HTML/Template/Flexy/Element.php';
			$this->elements[$user->url_name] = new HTML_Template_Flexy_Element;
			$this->elements[$user->url_name]->setValue($user->url_aid);
			$this->elements['text1'] = new HTML_Template_Flexy_Element;
			$this->elements['text1']->setValue($this->text1);
			$this->elements['text2'] = new HTML_Template_Flexy_Element;
			$this->elements['text2']->setValue($this->text2);
		}
		$db->closeConnection();
	}
}

new ControllerTxt();
?>