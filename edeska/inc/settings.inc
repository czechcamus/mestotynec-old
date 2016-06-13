<?php
// databaze
$dbuser = "mestotynec";
$dbpswd = "bwpnNqdd";
$dbname = "mestotynec";
//$dbuser = "aldesk";
//$dbpswd = "a1D3Sk01";
//$dbname = "aldesk";
$dbserver = "localhost";

// cesta ke tridam
//$classpath = (file_exists('../../../../../classes/dwoo/Dwoo.php') ? '../../../../../classes/' : (file_exists('../../../../classes/dwoo/Dwoo.php') ? '../../../../classes/' : (file_exists('../../../classes/dwoo/Dwoo.php') ? '../../../classes/' : (file_exists('../../classes/dwoo/Dwoo.php') ? '../../classes/' : (file_exists('../classes/dwoo/Dwoo.php') ? '../classes/' : (file_exists('classes/dwoo/Dwoo.php') ? 'classes/' : false))))));
$classpath = '../../home/HTML/classes/'; // ostrý hosting
if (!$classpath):
	die('No path to Dwoo - Bye!');
endif;

// nastavení systému
$recperpage = 20; 		// počet záznamů na stránce
$deflhuta = 15;			// stndardní lhůta vyvěšení
//$weburl = "http://localhost/vlastni_projekty/tynec/web";	// cesta k dokumentům
$weburl = "http://www.mestotynec.cz";	// cesta k dokumentům
?>