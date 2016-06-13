<?php
// spuštění session
session_name("UserSess");
session_start();


$server = $_SERVER["SERVER_NAME"];
$script = $_SERVER["SCRIPT_NAME"];
$fp = $_GET["fp"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref.(strstr($fp,".php") ? $fp : "page.php?fp=$fp").($_SESSION["userid"] ? (strstr($fp,".php") ? "?" : "&").SID : "");
$nrskin = $_GET["nrskin"];

setcookie("nrskin",$nrskin,time()+157680000);


// návrat na původní stránku
header("Location: http://".$server.$path);
?>
