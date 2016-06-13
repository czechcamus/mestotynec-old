<?php
$pref = "../";
require "usrfce.php";

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$fp = $_GET["fp"];
$username = $_GET["username"];
$userpwd = $_GET["userpwd"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref.(strstr($fp,".php") ? $fp : "page.php?fp=$fp");

if ($username):
	$dotaz = "SELECT * FROM uzivatel WHERE user='$username' AND povol=1";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nechytačka na výběr z tabulky uživatelů 1 - login.php");
	else:
		if (mysql_num_rows($result) == 1):
			$dotaz = "SELECT * FROM uzivatel WHERE user='$username' AND pwd='$userpwd' AND povol=1";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nechytačka na výběr z tabulky uživatelů 2 - login.php");
			else:
				$record = mysql_fetch_array($result);
				if ($record["id"]):
					session_name("UserSess");
					session_start();
					$_SESSION["userid"] = $record["id"];
					$path .= (strstr($fp,".php") ? "?" : "&").SID;
				endif;
			endif;
		endif;
	endif;
endif;
// návrat na původní stránku
Header("Location: http://".$server.":".$port.$path);
?>
