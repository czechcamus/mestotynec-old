<?php
$pref = "../";
require "usrfce.php";

$uploaddir = "../../home/mp/";
$aid = (isset($_REQUEST['aid']) ? $_REQUEST['aid'] : '');
$doc = (isset($_REQUEST['doc']) ? $_REQUEST['doc'] : '');
$docid = (isset($_REQUEST['docid']) ? $_REQUEST['docid'] : '');

if (empty($aid) || !CheckLogin($aid)) {
  die("Neautorizovany pristup!");
}

WriteLog($aid,$docid);

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

function CheckLogin($a)
// zkontroluje přihlášení podle řetězce $a
{
  $q = "SELECT id FROM mpuser WHERE auth='".$a."'";
  $sr = mysql_query($q);
  if (mysql_num_rows($sr) > 0) {
    return true;
  } else {
    return false;
  }
}

function WriteLog($a,$d)
// zapíše přístup uživatele do logu
{
  list($hash,$u) = explode('x',$a);
  $q = "INSERT INTO mplog SET idmpuser = ".strval($u).", idmpdoc = $d, ipaddr = '".$SERVER['REMOTE_ADDR']."'";
  $sr = mysql_query($q);
  if (!$sr) {
    die("Chyba v dotazu - $q");
  } 
  return true;
}
?>
