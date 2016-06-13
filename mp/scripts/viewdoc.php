<?php
include_once '../inc/setting.inc';
include_once '../classes/MySqlHandle.php';
include_once '../classes/LogUser.php';

// ověření uživatele
$db = new MySqlHandle();
$db->openConnection($dbuser,$dbpswd,$dbname,$dbserver);
$user = new LogUser;          // vyvtoření a nastavení instance LogUser
$user->sql = $db;
$user->check();             // kontrola přihlášení
if (empty($user->id)) {
	$host  = $_SERVER['HTTP_HOST'];
	$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
	header("Location: http://$host$uri/../loginform.php");
} else {
	$doc = (isset($_REQUEST['doc']) ? $_REQUEST['doc'] : '');
	switch (strtolower(substr($doc,-3))) {
	  case 'pdf':
	    header('Content-type: application/pdf');
	    break;
	  case 'doc';
	    header('Content-type: application/msword');
	    break;
	  case 'xls';
	    header('Content-type: application/vnd.ms-excel');
	    break;
	  case 'txt';
	    header('Content-type: text/plain');
	    break;
	  case 'jpg';
	    header('Content-type: image/jpeg');
	    break;
	  case 'gif';
	    header('Content-type: image/gif');
	    break;
	  case 'png';
	    header('Content-type: image/png');
	    break;
	}
	header('Content-Disposition: attachment; filename="'.$doc.'"');
	readfile($uploaddir.$doc);
}
exit;
?>