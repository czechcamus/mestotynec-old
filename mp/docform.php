<?php
include_once 'classes/Controller.php';

class ControllerDoc extends Controller 
{
	public $tpl = 'docform.tpl.html', $title = 'Formulář pro údaje dokumentu', $id = 0, $idmpperson = 0, $obdobiod_d = '', $obdobido_d = '', $filetitle = 'Čestné prohlášení (majetkové přiznání)', $filename = '', $fileupload = '', $maxfilesize = 0, $curl_aid = '';
	
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
					$arr = mysql_fetch_array($db->makeQuery("SELECT id,idmpperson,DATE_FORMAT(obdobiod_d,'%d.%m.%Y') AS obdobiod_d,DATE_FORMAT(obdobido_d,'%d.%m.%Y') AS obdobido_d,filetitle,filename FROM mpdoc WHERE id=$this->id"));				
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
			$this->elements['idmpperson'] = new HTML_Template_Flexy_Element;
			$res = $db->makeQuery("SELECT id,prijmeni,jmeno FROM mpperson ORDER BY prijmeni,jmeno");
			while ($rec = mysql_fetch_array($res)) 
			{
				$person[$rec['id']] = $rec['prijmeni']." ".$rec['jmeno'];
			}
			$this->elements['idmpperson']->setOptions($person);
			$this->elements['idmpperson']->setValue($this->idmpperson);
			$this->elements['obdobiod_d'] = new HTML_Template_Flexy_Element;
			$this->elements['obdobiod_d']->setValue(SetNewDate($this->obdobiod_d,"first"));
			$this->elements['obdobido_d'] = new HTML_Template_Flexy_Element;
			$this->elements['obdobido_d']->setValue(SetNewDate($this->obdobido_d,"last"));
			$this->elements['filetitle'] = new HTML_Template_Flexy_Element;
			$this->elements['filetitle']->setValue($this->filetitle);
			$this->elements['filename'] = new HTML_Template_Flexy_Element;
			$this->elements['filename']->setValue($this->filename);
			$this->elements['max_file_size'] = new HTML_Template_Flexy_Element;
			$this->elements['max_file_size']->setValue($this->maxfilesize = $maxfilesize);
			$this->elements['fileupload'] = new HTML_Template_Flexy_Element;
			$this->elements['fileupload']->setValue($this->fileupload);
			$this->elements['act'] = new HTML_Template_Flexy_Element;
			$this->elements['act']->setValue($act);
			$this->elements['form'] = new HTML_Template_Flexy_Element;
			$this->elements['form']->setValue('doc');
			
			// ukonceni spojeni
			if ($act == "edit") {
				$this->elements['id'] = new HTML_Template_Flexy_Element;
				$this->elements['id']->setValue($this->id);
			}
		}
		$db->closeConnection();
	}
}

new ControllerDoc();

function SetNewDate($d,$c)
// není-li datum nastaveno, tak se nastaví první nebo poslední den loňského roku
{
	$newdate = '';
	if (empty($d)) {
		$lastyear = date('Y', time() - (365 * 24 * 60 * 60));
		if ($c == 'last') {
			$newdate = '31.12.'.$lastyear;
		} else {
			$newdate = '1.1.'.$lastyear;
		}
	} else {
		$newdate = $d;
	}
	return $newdate;
}
?>