<?php
include_once 'classes/Controller.php';

class ControllerPerson extends Controller 
{
	public $tpl = 'personform.tpl.html', $title = 'Formulář pro údaje osoby', $id = 0, $titulpred = '', $jmeno = '', $prijmeni = '', $titulza = '', $narozen_d = '', $idmpfce = 0, $curl_aid = '', $userinfo = '';
	
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
				$this->id = $_REQUEST["id"];
				if (isset($_REQUEST['save'])) {
					$arr = $_REQUEST;
				} else {
					$arr = mysql_fetch_array($db->makeQuery("SELECT id,titulpred,jmeno,prijmeni,titulza,DATE_FORMAT(narozen_d,'%d.%m.%Y') AS narozen_d,idmpfce FROM mpperson WHERE id=$this->id"));
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
			$this->elements['titulpred'] = new HTML_Template_Flexy_Element;
			$this->elements['titulpred']->setValue($this->titulpred);
			$this->elements['jmeno'] = new HTML_Template_Flexy_Element;
			$this->elements['jmeno']->setValue($this->jmeno);
			$this->elements['prijmeni'] = new HTML_Template_Flexy_Element;
			$this->elements['prijmeni']->setValue($this->prijmeni);
			$this->elements['titulza'] = new HTML_Template_Flexy_Element;
			$this->elements['titulza']->setValue($this->titulza);
			$this->elements['narozen_d'] = new HTML_Template_Flexy_Element;
			$this->elements['narozen_d']->setValue($this->narozen_d);
			$this->elements['idmpfce'] = new HTML_Template_Flexy_Element;
			$res = $db->makeQuery("SELECT * FROM mpfce ORDER BY nazev");
			while ($rec = mysql_fetch_array($res)) 
			{
				$fce[$rec['id']] = $rec['nazev'];
			}
			$this->elements['idmpfce']->setOptions($fce);
			$this->elements['idmpfce']->setValue($this->idmpfce);
			$this->elements['act'] = new HTML_Template_Flexy_Element;
			$this->elements['act']->setValue($act);
			$this->elements['form'] = new HTML_Template_Flexy_Element;
			$this->elements['form']->setValue('person');
			
			// ukonceni spojeni
			if ($act == "edit") {
				$this->elements['id'] = new HTML_Template_Flexy_Element;
				$this->elements['id']->setValue($this->id);
			}
		}
		$db->closeConnection();
	}
}

new ControllerPerson();
?>