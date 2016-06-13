<?php
include_once 'classes/Controller.php';

class ControllerLog extends Controller 
{
	public $tpl = 'log.tpl.html', $title = 'Prohlížení logu', $obdobi_od = '', $obdobi_do = '', $logform = true, $data = array(), $userinfo = '', $curl_aid = '';
	
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
			if (!isset($_REQUEST['obdobi_od']) || !isset($_REQUEST['obdobi_do']) || !CheckFieldDate($_REQUEST['obdobi_od']) || !CheckFieldDate($_REQUEST['obdobi_do'])) {
				// zobrazi formular
				include_once 'HTML/Template/Flexy/Element.php';
				$this->elements[$user->url_name] = new HTML_Template_Flexy_Element;
				$this->elements[$user->url_name]->setValue($user->url_aid);
				$this->elements['obdobi_od'] = new HTML_Template_Flexy_Element;
				$this->elements['obdobi_od']->setValue(SetNewDate($this->obdobi_od,"first"));
				$this->elements['obdobi_do'] = new HTML_Template_Flexy_Element;
				$this->elements['obdobi_do']->setValue(SetNewDate($this->obdobi_do,"last"));
			} else {
				//zobrazi log
				$this->logform = false;
				$this->obdobi_od = $_REQUEST['obdobi_od'];
				$this->obdobi_do = $_REQUEST['obdobi_do'];
				$obdobi_od_full = dateConvertForDb($_REQUEST['obdobi_od'])." 00-00-00";
				$obdobi_do_full = dateConvertForDb($_REQUEST['obdobi_do'])." 23-59-59";
				$res = $db->makeQuery("SELECT l.id,u.prijmeni AS uprijmeni,u.jmeno AS ujmeno,d.filetitle,d.filename,p.prijmeni AS pprijmeni,p.jmeno AS pjmeno,DATE_FORMAT(l.logtime,'%d.%m.%Y v %H:%i:%s') AS acctime  FROM mplog AS l, mpuser AS u, mpdoc AS d, mpperson AS p WHERE l.idmpuser = u.id AND l.idmpdoc = d.id AND d.idmpperson = p.id AND l.logtime >= '".$obdobi_od_full."' AND l.logtime <= '".$obdobi_do_full."' ORDER BY acctime DESC");
				while ($rec = mysql_fetch_array($res)) 
				{
					$this->data[$rec['id']]['user'] = $rec['uprijmeni']." ".$rec['ujmeno'];
					$this->data[$rec['id']]['person'] = $rec['pprijmeni']." ".$rec['pjmeno'];
					$this->data[$rec['id']]['filetitle'] = $rec['filetitle'];
					$this->data[$rec['id']]['filename'] = $rec['filename'];;
					$this->data[$rec['id']]['acctime'] = $rec['acctime'];
				}
			}
		}
		$db->closeConnection();
	}
}

new ControllerLog();

function SetNewDate($d,$c)
// není-li datum nastaveno, tak se nastaví první nebo poslední den loňského roku
{
	$newdate = '';
	if (empty($d)) {
		$thisyear = date('Y', time());
		if ($c == 'last') {
			$newdate = '31.12.'.$thisyear;
		} else {
			$newdate = '1.1.'.$thisyear;
		}
	} else {
		$newdate = $d;
	}
	return $newdate;
}

function CheckFieldDate($d)
// kontroluje správnost data
{
	list($den,$mesic,$rok) = split('[.]',$d,3);
	$den = (empty($den) ? 0 : strval($den));
	$mesic = (empty($mesic) ? 0 : strval($mesic));
	$rok = (empty($rok) ? 0 : strval($rok));
	if (!checkdate($mesic,$den,$rok)) {
		return false;
	}
	return true;
}

function dateConvertForDb($d)
// prevede datum do z formatu DD.MM.RRRR do formatu RRRR-MM-DD
{
	$p = "(0?[1-9]|[12][0-9]|3[01])\. ?(0?[1-9]|1[0-2])\. ?((18|19|20)[0-9]{2})";
	$r = "\\3-\\2-\\1";
	return ereg_replace($p, $r, $d);
}
?>