<?php
include_once 'classes/Controller.php';

class ControllerDel extends Controller 
{
	public $tpl = 'delform.tpl.html', $title = '', $id = 0, $act = 'del', $form = '', $curl_aid = '';
	
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
			$this->id = $_REQUEST['id'];
			$this->form = $_REQUEST['form'];
			switch ($this->form) {
				case "fce":
					$txt = "funkci: ";
					$rec = mysql_fetch_array($db->makeQuery("SELECT nazev FROM mpfce WHERE id=$this->id"));
					$txt .= $rec['nazev'];
					break;
				case "person":
					$txt = "osobu: ";
					$rec = mysql_fetch_array($db->makeQuery("SELECT prijmeni, jmeno FROM mpperson WHERE id=$this->id"));
					$txt .= $rec['prijmeni']." ".$rec['jmeno'];
					break;
				case "user":
					$txt = "uživatele: ";
					$rec = mysql_fetch_array($db->makeQuery("SELECT prijmeni, jmeno FROM mpuser WHERE id=$this->id"));
					$txt .= $rec['prijmeni']." ".$rec['jmeno'];
					break;
				case "doc":
					$txt = "dokument: ";
					$rec = mysql_fetch_array($db->makeQuery("SELECT filetitle FROM mpdoc WHERE id=$this->id"));
					$txt .= $rec['filetitle'];
					break;
			}
			$this->title = $txt;		
			
			include_once 'HTML/Template/Flexy/Element.php';
			$this->elements[$user->url_name] = new HTML_Template_Flexy_Element;
			$this->elements[$user->url_name]->setValue($user->url_aid);
			$this->elements['act'] = new HTML_Template_Flexy_Element;
			$this->elements['act']->setValue($this->act);
			$this->elements['form'] = new HTML_Template_Flexy_Element;
			$this->elements['form']->setValue($this->form);
			$this->elements['id'] = new HTML_Template_Flexy_Element;
			$this->elements['id']->setValue($this->id);
		}
		$db->closeConnection();
	}
}

new ControllerDel();
?>