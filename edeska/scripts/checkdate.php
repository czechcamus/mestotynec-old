<?php
// výpočet proměnných
$noval = (isset($_GET['noval']) ? 1 : 0);
$datum = (isset($_GET['datum']) ? $_GET['datum'] : 'no');
$vzor = "/^(0?[1-9]|[12][0-9]|3[01])\. ?(0?[1-9]|1[0-2])\. ?((18|19|20|21|22|23|24|25|26|27|28|29|99)[0-9]{2})?$/";
preg_match($vzor,$datum,$vysledky);
echo (isset($vysledky[0]) ? "" : (($noval && !$datum) ? "" : "Datum je chybné!"))."\n";
?>