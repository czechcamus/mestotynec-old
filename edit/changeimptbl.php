<?php
include "../scripts/settings.php";
include "./scripts/editfce.php";
$idredaktor = CheckLogin();

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$akce = $_GET["akce"];
$tbl = $_GET["tbl"];
$id = $_GET["itemid"];

if (($akce == "add") || ($akce == "edit")):
	// načtení struktury
	$dotaz = "SELECT * FROM $tbl";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst strukturu tabulky - formimptbl.tpl!");
	else:
		if ($akce == "add"):
			$dotaz = "INSERT INTO $tbl (";
		else:
			$dotaz = "UPDATE $tbl SET ";
		endif;
		$sloupce = "";
		$hodnoty = "";
		$dotazbody = "";
		while ($polozka = mysql_fetch_field($result)):
			$jmpol = $polozka->name;
			if ($jmpol != "id"):
				$hodnpol = $_GET["$jmpol"];
				if ($akce == "add"):
					$sloupce .= ($sloupce ? ", ".$jmpol : $jmpol);
					$hodnoty .= ($hodnoty ? ", \"$hodnpol\"" : "\"$hodnpol\"");
				else:
					$dotazbody .= ($dotazbody ? ", ".$jmpol." = \"$hodnpol\"" : $jmpol." = \"$hodnpol\""); 
				endif;
			endif;
		endwhile;
		if ($akce == "add"):
			$dotaz .= $sloupce.") VALUES (".$hodnoty.")";
		else:
			$dotaz .= $dotazbody." WHERE id = $id";
		endif;
	endif;
endif;

// zapis
if ($akce == "del"):
	if ($id):
		$dotaz = "DELETE FROM $tbl WHERE id=$id";
	else: 
		$dotaz = "DROP TABLE $tbl";
	endif;
endif;


$result = mysql_query("$dotaz");
if (!$result):
	if ($akce == "add"):
		die("nepodařilo se vložit záznam - changeimptbl.php");
	elseif ($akce == "edit"):
		die("nepodařilo se změnit záznam - changeimptbl.php");
	else:
		die("nepodařilo se smazat záznam - changeimptbl.php");
	endif;
else: 
	if (($akce == "del") && (!$id)):
		$dotaz = "DELETE FROM tablename WHERE tblname=\"".$tbl."\"";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba při úpravě tabulky tablename po smazání tabulky $tbl - changeimptbl.php");
		endif;
	endif;
endif;

if (($akce == "add") || ($akce == "edit")):
	$path = substr($script, 0, StrRPos($script, "/"))."/contenttbl.php?tbl=$tbl";
else:
	$path = substr($script, 0, StrRPos($script, "/"))."/importedtbl.php";
endif;

Header("Location: http://".$server.":".$port.$path);
?>
