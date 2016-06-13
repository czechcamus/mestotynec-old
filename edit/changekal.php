<?php
include "../scripts/settings.php";
include "./scripts/editfce.php";
$idredaktor = CheckLogin();

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$akce = $_POST["akce"];
$tbl = $_POST["tbl"];
$ttbl = $_POST["ttbl"];
$fn = $_POST["fn"];
if (!$tbl):
	$akce = $_GET["akce"];
	$tbl = $_GET["tbl"];
	$ttbl = $_GET["ttbl"];
	$fn = $_GET["fn"];
endif;

if (($akce == "add") || ($akce == "edit")):
	$id = $_POST["itemid"];
	$misto_id = $_POST["misto_id"];
	$titulek = $_POST["titulek"];
	$typakce_id = $_POST["typakce_id"];
	$den1 = $_POST["den1"];
	$mes1 = $_POST["mes1"];
	$rok1 = $_POST["rok1"];
	$den2 = $_POST["den2"];
	$mes2 = $_POST["mes2"];
	$rok2 = $_POST["rok2"];
	$zacatek = $_POST["zacatek"];
	$anotace = $_POST["anotace"];
	$podnik_id = $_POST["podnik_id"];
	$porad_id = $_POST["porad_id"];
	// misto
	$dotaz = "SELECT * FROM podnik WHERE id=$podnik_id";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezdařil se výběr z tabulky podnik - changekal.php!");
	else:
		$record = mysql_fetch_array($result);
		$misto_id = $record["misto_id"];
	endif;
	// datum
	if (!($den1.$mes1.$rok1)):
		$dat1ok = 0;
	else:
		$dat1ok = checkdate($mes1,$den1,$rok1);
	endif;
	$datum = mktime(0,0,0,$mes1,$den1,$rok1);
	if (!($den2.$mes2.$rok2)):
		$dat2ok = 1;
		$datum_do = mktime(0,0,0,$mes1,$den1,$rok1);
	else:
		$dat2ok = checkdate($mes2,$den2,$rok2);
		$datum_do = mktime(0,0,0,$mes2,$den2,$rok2);
	endif;
else:
	$id = $_GET["itemid"];
endif;

// zapis
if ($akce == "add"):
	$dotaz = "INSERT INTO $tbl (typakce_id,titulek,datum,datum_do,zacatek,anotace,podnik_id,porad_id,misto_id,schvaleno,idredaktor) VALUES ($typakce_id,'$titulek',$datum,$datum_do,'$zacatek','$anotace',$podnik_id,$porad_id,$misto_id,0,$idredaktor)";
elseif ($akce == "edit"):
	$dotaz = "UPDATE $tbl SET typakce_id=$typakce_id,titulek='$titulek',datum=$datum,datum_do=$datum_do,zacatek='$zacatek',anotace='$anotace',
		podnik_id=$podnik_id,porad_id=$porad_id,misto_id=$misto_id,idredaktor=$idredaktor WHERE id=$id";
elseif ($akce == "del"):
	$dotaz = "DELETE FROM $tbl WHERE id=$id";
endif;

$result = mysql_query("$dotaz");
if (!$result):
	if ($akce == "add"):
		die("nepodařilo se vložit záznam - changetbl.php");
	elseif ($akce == "edit"):
		die("nepodařilo se změnit záznam - changetbl.php");
	else:
		die("nepodařilo se smazat záznam - changetbl.php");
	endif;
endif;

$path = substr($script, 0, strrpos($script, "/"))."/".$fn;

Header("Location: http://".$server.":".$port.$path);
?>
