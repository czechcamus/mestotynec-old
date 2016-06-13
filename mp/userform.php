<?php
include_once 'classes/Controller.php';

class ControllerUser extends Controller 
{
	public $tpl = 'userform.tpl.html', $title = 'Formulář pro údaje uživatele', $id = 0, $username = '', $userpswd = '', $titulpred = '', $jmeno = '', $prijmeni = '', $titulza = '', $rc = '', $ulicecp = '', $mesto = '', $psc = '', $platnost = 0, $curl_aid = '', $userinfo = '';
	
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
					$arr = mysql_fetch_array($db->makeQuery("SELECT * FROM mpuser WHERE id=$this->id"));
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
			$this->elements['username'] = new HTML_Template_Flexy_Element;
			if (empty($this->username)) {
				$this->username = createUsername($db);
			}
			$this->elements['username']->setValue($this->username);
			$this->elements['userpswd'] = new HTML_Template_Flexy_Element;
			if (empty($this->userpswd)) {
				$this->userpswd = createUserpswd();
			}
			$this->elements['userpswd']->setValue($this->userpswd);
			$this->elements['titulpred'] = new HTML_Template_Flexy_Element;
			$this->elements['titulpred']->setValue($this->titulpred);
			$this->elements['jmeno'] = new HTML_Template_Flexy_Element;
			$this->elements['jmeno']->setValue($this->jmeno);
			$this->elements['prijmeni'] = new HTML_Template_Flexy_Element;
			$this->elements['prijmeni']->setValue($this->prijmeni);
			$this->elements['titulza'] = new HTML_Template_Flexy_Element;
			$this->elements['titulza']->setValue($this->titulza);
			$this->elements['rc'] = new HTML_Template_Flexy_Element;
			$this->elements['rc']->setValue($this->rc);
			$this->elements['ulicecp'] = new HTML_Template_Flexy_Element;
			$this->elements['ulicecp']->setValue($this->ulicecp);
			$this->elements['mesto'] = new HTML_Template_Flexy_Element;
			$this->elements['mesto']->setValue($this->mesto);
			$this->elements['psc'] = new HTML_Template_Flexy_Element;
			$this->elements['psc']->setValue($this->psc);
			$this->elements['platnost'] = new HTML_Template_Flexy_Element;
			$this->elements['platnost']->setValue($this->platnost);
			$this->elements['act'] = new HTML_Template_Flexy_Element;
			$this->elements['act']->setValue($act);
			$this->elements['form'] = new HTML_Template_Flexy_Element;
			$this->elements['form']->setValue('user');
			
			// ukonceni spojeni
			if ($act == "edit") {
				$this->elements['id'] = new HTML_Template_Flexy_Element;
				$this->elements['id']->setValue($this->id);
			}
		}
		$db->closeConnection();
	}
}

function createUsername(& $dbcon)
{
	$arr = mysql_fetch_array($dbcon->makeQuery("SELECT MAX(id) AS maxid FROM mpuser"));
	return "host".(isset($arr['maxid']) ? $arr['maxid']+1 : 1);
}

function createUserpswd()
{
	$valchars = array("1","2","3","4","5","6","7","8","9","0","a","b","c","d","e","f","g","h","i","j","k","l","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
	$pswdlength = "10";
	$pswd = '';

	for ($i = 0 ;$i <= $pswdlength-1 ;$i++)
	{
		$randchar = rand(0, count($valchars)-1);
		$pswd .= $valchars[$randchar];
	}
	return $pswd;
}


new ControllerUser();
?>