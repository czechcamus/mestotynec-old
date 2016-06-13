<?php
// spuštění session
session_name("UserSess");
session_start();

$pref = "../";
$infoformname = "infoform.php";
require "usrfce.php";


$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$fp = $_GET["fp"];
$idcst = $_GET["idcst"];
$iduser = $_SESSION["userid"];
$odp = $_GET["odp"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref.$infoformname."?form=cst&fp=$fp&idcst=$idcst&odp=$odp".($_SESSION["userid"] ? "&".SID : "");

if ($iduser):
	$dotaz = "INSERT INTO odpoved (idcst,iduser,odp) VALUES ($idcst,$iduser,$odp)";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezadařilo se přidat odpověď - odpoved.php");
	endif;
endif;

// návrat na původní stránku
Header("Location: http://".$server.":".$port.$path);
?>
