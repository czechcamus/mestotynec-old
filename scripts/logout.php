<?php
// vymazání session a cookie
session_name("UserSess");
session_start();
$_SESSION = array();
if (isset($_COOKIE[session_name()])):
   setcookie(session_name(), '', time()-42000, '/');
endif;
session_destroy();

// proměnné pro návrat
$pref = "../";
require "usrfce.php";

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$fp = $_GET["fp"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref.(strstr($fp,".php") ? $fp : "page.php?fp=$fp");

// návrat na původní stránku
Header("Location: http://".$server.":".$port.$path);
?>
