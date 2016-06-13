<?php
include "../scripts/settings.php";
include "./scripts/editfce.php";
$idredaktor = CheckLogin();

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$menuid = $_GET["menuid"];
$id = $_GET["itemid"];
$akce = $_GET["akce"];
$tbl = $_GET["tbl"];
$mtid = $_GET["mtid"];
$tblname = $_GET["tblname"];
$pocsl = $_GET["pocsl"];
$sloupce = "";
for ($i=0;$i<$pocsl;$i++):
	$sloupec = $_GET["sl$i"];
	$nazsloupec = $_GET["nazsl$i"];
	$onsl = $_GET["onsl$i"];
	if ($onsl):
		$sloupce .= ($sloupce ? ", ".$sloupec : $sloupec);
		$nazsloupce .= ($nazsloupce ? ", ".$nazsloupec : $nazsloupec);
	endif;
endfor;
$poleraz = $_GET["poleraz"];
$tabulka = ($_GET["selview"] == "tabulka" ? 1 : 0);

// zapis
if ($akce == "add"):
	$dotaz = "INSERT INTO $tbl (tblname,sloupce,nazsloupce,poleraz,tabulka,uprava)
		VALUES ('$tblname','$sloupce','$nazsloupce','$poleraz',$tabulka,1)";
elseif ($akce == "edit"):
	$dotaz = "UPDATE $tbl SET tblname = '$tblname', sloupce = '$sloupce', nazsloupce = '$nazsloupce', poleraz = '$poleraz', tabulka = $tabulka WHERE id=$id";
elseif ($akce == "del"):
	$dotaz = "DELETE FROM $tbl WHERE id=$id";
else:
	$dotaz = "SELECT * FROM $tbl WHERE mtid=$mtid";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Chyba pri vyberu dat - changeseltbl - uprava pozice!");
	else:
		$maxpozice = mysql_num_rows($result);
		if (($newpozice != 0) && ($newpozice <= $maxpozice)):
			$dotaz = "UPDATE $tbl SET pozice = $newpozice, uprava = 1 WHERE id=$id";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Zmena upravy neprosla - changeseltbl!");
			else:
				$chgpozice = ($akce == "up" ? $newpozice+1 : $newpozice-1);
				$dotaz = "UPDATE $tbl SET pozice = $chgpozice WHERE mtid=$mtid AND uprava!=1 AND pozice=$newpozice";
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Zmena pozice se nezdarila - changeseltbl!");
				else:
					$dotaz = "UPDATE $tbl SET uprava = 0 WHERE uprava=1";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Zmena v sloupci uprava se nezdarila - changeseltbl!");
					endif;
				endif;
			endif;
		endif;
	endif;
endif;

$result = mysql_query("$dotaz");
if (!$result):
	if ($akce == "add"):
		die("nepodarilo se vlozit zaznam - changeseltbl.php");
	elseif ($akce == "edit"):
		die("nepodarilo se zmenit zaznam - changeseltbl.php");
	else:
		die("nepodarilo se smazat zaznam - changeseltbl.php");
	endif;
else: 
	if ($akce == "add"):
		$pozice = GetNewPozice("content",$mtid);
		$idtbl = GetTblId($tbl);
		$contid = GetUprId($tbl);
		$dotaz = "INSERT INTO content (idtbl,mtid,contid,pozice) VALUES ($idtbl,$mtid,$contid,$pozice)";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Pridani obsahu do tabulky content prece jen uplne nedopadlo - changeseltbl!");
		endif;
	elseif ($akce == "del"):
		// zjištění­ pozice v tabulce content
		$dotaz = "SELECT * FROM content WHERE contid=$id";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba pri vyberu zaznamu ke smazani­ z tabulky content - changeseltbl!");
		else:
			$record = mysql_fetch_array($result);
			$pozice = $record["pozice"];
		endif;
		// výběr záznamu pro úpravu
		$dotaz = "SELECT * FROM content WHERE pozice>$pozice AND mtid=$mtid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba pri vyberu dat - changeseltbl - uprava tabulky content po mazani!");
		else:
			while ($record = mysql_fetch_array($result)):
				$ctid = $record["id"];
				$chgpozice = $record["pozice"]-1;
				$dotaz = "UPDATE content SET pozice = $chgpozice WHERE id=$ctid";
				$result2 = mysql_query("$dotaz");
				if (!$result2):
					die("Zmena pozice se nezdarila - changeseltbl!");
				endif;
			endwhile;
		endif;
		// smazání­ záznamu z tabulky content
		$dotaz = "DELETE FROM content WHERE contid=$id";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba pri mazani zaznamu v tabulce content - changeseltbl!");
		endif;
	endif;
endif;

$path = substr($script, 0, strrpos($script, "/"))."/webmng.php?menuid=$menuid";

Header("Location: http://".$server.":".$port.$path);
?>
