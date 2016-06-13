<?php
// spuštění session
session_name("UserSess");
session_start();

$pref = "";
require "scripts/usrfce.php";

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$ipadr = $_SERVER["REMOTE_ADDR"];
$fp = $_GET["fp"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref.(strstr($fp,".php") ? $fp : "page.php?fp=$fp");
$idvote = $_GET["idvote"];
$iduser = $_SESSION["userid"];
$odp = $_GET["odp"];

// zápis hlasu do tabulky
$dotaz = "INSERT INTO hlas (idvote,odp,ipadr) VALUES ($idvote,$odp,'$ipadr')";
$result = mysql_query("$dotaz");
if (!$result):
	die("Nezadařilo se přidat hlas - hlas.php");
endif;

// zásilka cookie
setcookie("idankety",$idvote,time()+157680000);

// návrat na původní stránku
header("Location: http://".$server.":".$port.$path);
?>
