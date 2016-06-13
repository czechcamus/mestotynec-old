<?php
// hlavička
header("Content-type: text/xml");
// výpočet proměnných
$datum1 = (isset($_GET['datum1']) ? $_GET['datum1'] : date("d.m.Y",time()));
$lhuta = (isset($_GET['lhuta']) ? $_GET['lhuta'] : 0);
$vzor = "/^(0?[1-9]|[12][0-9]|3[01])\. ?(0?[1-9]|1[0-2])\. ?((18|19|20|21|22|23|24|25|26|27|28|29|99)[0-9]{2})?$/";
preg_match($vzor,$datum1,$vysledky);
if (isset($vysledky[0])) {
	list($den,$mes,$rok) = split('[/.-]', $datum1);
	$cas2 = mktime(0,0,0,$mes,$den,$rok)+($lhuta*86400);
	$datum2 = date('d.m.Y', $cas2);
} else {
	$datum2 = '';
}	
echo "<"."?xml version='1.0' encoding='UTF-8'?".">\n";
echo "<datumy>\n";
echo "<datum>$datum1</datum>\n";
echo "<datum>$datum2</datum>\n";
echo "</datumy>";
?>