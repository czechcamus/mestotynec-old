<?php
include_once '../inc/setting.inc';
include_once '../classes/MySqlHandle.php';
include_once '../classes/RecordHandle.php';
include_once '../classes/LogUser.php';

// promenne prostredi
$host  = $_SERVER['HTTP_HOST'];
$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
// ověření uživatele
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
	// nacteni promennych
	$err = '';
	if (isset($_REQUEST['act'])) {
		$arr = $_REQUEST;
	} else {
		// uploadovaný soubor je větší než limit
		$err = 'Uploadovaný soubor je větší než povolený limit!';	
	}
	if ((!(($arr['act'] == 'del') && (isset($arr['button2'])))) && (empty($err))) {
		if (!empty($_FILES['fileupload']['name'])) {
			$arr['filename'] = CreateFilename($_FILES['fileupload']['name']);
//			$uploadfile = "../" . $uploaddir . basename($arr['filename']);
			$uploadfile = $uploaddir . basename($arr['filename']);
			if (!move_uploaded_file($_FILES['fileupload']['tmp_name'], $uploadfile)) {
			    die("Nepodařilo se uploadovat soubor!");
			}
		}
		// kontrola promennych
		if ($arr['act'] != 'del') {
			$err = CheckRequired($arr);
			if (empty($err)) {
				foreach ($arr as $field => $val) {
					if (substr($field,-2) == '_d') {
						$err = CheckValidDate($val);
						if (!empty($err)) {
							break;
						}
					}
				}
				
			}
		}
		if (empty($err)) {
			// zapis dat
			switch ($arr['act']) {
				case 'add':
					$rec = new RecordHandle($arr['form']);
					$db->makeQuery($rec->addRecord($arr));
					break;
				case 'edit':
					$rec = new RecordHandle($arr['form']);
					$db->makeQuery($rec->editRecord($arr));
					break;
				case 'del':
					$rec = new RecordHandle($arr['form']);
					$db->makeQuery($rec->deleteRecord($arr));
					break;
			}
		}
	}
}
$db->closeConnection();
// kam dal
if (empty($err)) {
	$page = "../".$arr['form']."mng.php?$user->curl_aid";	
} else {
	$path = explode("?", basename($_SERVER['HTTP_REFERER']));
	$filename = $path[0];
	$page = "../$filename?err=$err";
	foreach ($arr as $key => $val) {
		$page .= "&$key=$val";
	}
}
header("Location: http://$host$uri/$page");
exit;

function CheckRequired($fields)
// v případě nevyplnění povinné položky vrací funkce chybový řetězec
{
	$e = '';
	$reqfields = split(',',$fields['required']);
	foreach ($reqfields as $field) {
		if (empty($fields[$field])) {
			$e = 'Chybí některý z povinných údajů (označené hvězdičkou)!';
		}
	}
	return $e;
}

function CheckValidDate($d)
// kontroluje správnost data
{
	$e = '';
	list($den,$mesic,$rok) = split('[.]',$d,3);
	$den = (empty($den) ? 0 : strval($den));
	$mesic = (empty($mesic) ? 0 : strval($mesic));
	$rok = (empty($rok) ? 0 : strval($rok));
	if (!checkdate($mesic,$den,$rok)) {
		$e = 'Některé datum je chybně zadané!';
	}
	return $e;
}

function CreateFilename($s)
// konvertuje řetězec $s do "čisté" formy bez diakritiky
{
	$sn = ereg_replace(" ","-",$s);
	$sn = ereg_replace("\"","",$sn);
	$sn = ereg_replace("„","",$sn);
	$sn = ereg_replace("“","",$sn);
	$sn = ereg_replace("\(","",$sn);
	$sn = ereg_replace("\)","",$sn);
	$sn = ereg_replace("!","",$sn);
	$sn = ereg_replace("\?","",$sn);
	$sn = ereg_replace(",","",$sn);
	$sn = ereg_replace(";","",$sn);
	$sn = ereg_replace("/","",$sn);
	$sn = ereg_replace("ä","a",$sn);
	$sn = ereg_replace("ö","o",$sn);
	$sn = ereg_replace("ü","u",$sn);
	$sn = ereg_replace("Ä","A",$sn);
	$sn = ereg_replace("Ö","O",$sn);
	$sn = ereg_replace("Ü","U",$sn);
	$sn = ereg_replace("á","a",$sn);
	$sn = ereg_replace("č","c",$sn);
	$sn = ereg_replace("ď","d",$sn);
	$sn = ereg_replace("é","e",$sn);
	$sn = ereg_replace("ě","e",$sn);
	$sn = ereg_replace("í","i",$sn);
	$sn = ereg_replace("ľ","l",$sn);
	$sn = ereg_replace("ň","n",$sn);
	$sn = ereg_replace("ó","o",$sn);
	$sn = ereg_replace("ř","r",$sn);
	$sn = ereg_replace("š","s",$sn);
	$sn = ereg_replace("ť","t",$sn);
	$sn = ereg_replace("ú","u",$sn);
	$sn = ereg_replace("ů","u",$sn);
	$sn = ereg_replace("ý","y",$sn);
	$sn = ereg_replace("ž","z",$sn);
	$sn = ereg_replace("Á","A",$sn);
	$sn = ereg_replace("Č","C",$sn);
	$sn = ereg_replace("Ď","D",$sn);
	$sn = ereg_replace("É","E",$sn);
	$sn = ereg_replace("Ě","E",$sn);
	$sn = ereg_replace("Í","I",$sn);
	$sn = ereg_replace("Ľ","L",$sn);
	$sn = ereg_replace("Ň","N",$sn);
	$sn = ereg_replace("Ó","O",$sn);
	$sn = ereg_replace("Ř","R",$sn);
	$sn = ereg_replace("Š","S",$sn);
	$sn = ereg_replace("Ú","U",$sn);
	$sn = ereg_replace("Ů","U",$sn);
	$sn = ereg_replace("Ý","Y",$sn);
	$sn = ereg_replace("Ž","Z",$sn);
	$sn = strtolower($sn);
	return $sn;
}	
?>
