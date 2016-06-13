<?php include "../scripts/settings.php";
include "./scripts/editfce.php";
$idredaktor = CheckLogin();
$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$menuid = $_POST["menuid"];
$akce = $_POST["akce"];
$tbl = $_POST["tbl"];
$mtid = $_POST["mtid"];
if (($akce == "add") || ($akce == "edit")):
	$id = $_POST["itemid"];
	$peron = $_POST["peron"];
	$zamon = ($_POST["zamon"] ? 1 : 0);
	$zaron = $_POST["zaron"];
	$oddelon = $_POST["oddelon"];
	$odboron = $_POST["odboron"];
	$budon = $_POST["budon"];
	$vyboron = $_POST["vyboron"];
	$zaston = ($_POST["zaston"] ? 1 : 0);
	$radaon = ($_POST["radaon"] ? 1 : 0);
	$clvybon = ($_POST["clvybon"] ? 1 : 0);
	$clkomon = ($_POST["clkomon"] ? 1 : 0);
	$vyboron = $_POST["vyboron"];
	$komiseon = $_POST["komiseon"];
	$polesel = "";
	$poleval = 0;
	if ($peron):
		$polesel = "id";
		$poleval = $_POST["selperson"];
	elseif ($zamon):
		if ($zaron):
			$polesel = "idzarazeni";
			$poleval = $_POST["selzarazeni"];
		elseif ($oddelon):
			$polesel = "idoddeleni";
			$poleval = $_POST["seloddel"];
		elseif ($odboron):
			$polesel = "idodbor";
			$poleval = $_POST["selodbor"];
		elseif ($budon):
			$polesel = "idbudova";
			$poleval = $_POST["selbudova"];
		else:
			$polesel = "idzarazeni";
		endif;
	elseif ($zaston):
		$polesel = "idzarzast";
	elseif ($radaon):
		$polesel = "idzarrada";
	elseif ($clvybon):
		$polesel = "idvybor";
		if ($vyboron):
			$poleval = $_POST["selvybor"];
		endif;
	elseif ($clkomon):
		$polesel = "idkomise";
		if ($komiseon):
			$poleval = $_POST["selkomise"];
		endif;
	endif;
	$poleraz = $_POST["selorder"];
	$pimg = ($_POST["pimg"] ? 1 :0 );
	$pidbudova = ($_POST["pidbudova"] ? 1 : 0 );
	$pidodbor = ($_POST["pidodbor"] ? 1 : 0 );
	$pidoddeleni = ($_POST["pidoddeleni"] ? 1 : 0 );
	$pidzarazeni = ($_POST["pidzarazeni"] ? 1 : 0 );
	$pdvere = ($_POST["pdvere"] ? 1 :0 );
	$pidstrana = ($_POST["pidstrana"] ? 1 : 0 );
	$pidzarzast = ($_POST["pidzarzast"] ? 1 : 0 );
	$pidzarrada = ($_POST["pidzarrada"] ? 1 : 0 );
	$pidvybor = ($_POST["pidvybor"] ? 1 : 0 );
	$pidzarvybor = ($_POST["pidzarvybor"] ? 1 : 0 );
	$pidkomise = ($_POST["pidkomise"] ? 1 : 0 );
	$pidzarkomise = ($_POST["pidzarkomise"] ? 1 : 0 );
	$ptelefon1 = ($_POST["ptelefon1"] ? 1 : 0 );
	$ptelefon2 = ($_POST["ptelefon2"] ? 1 : 0 );
	$pmobil1 = ($_POST["pmobil1"] ? 1 : 0 );
	$pmobil2 = ($_POST["pmobil2"] ? 1 : 0 );
	$pfax = ($_POST["pfax"] ? 1 : 0 );
	$picq = ($_POST["picq"] ? 1 : 0 );
	$pemail1 = ($_POST["pemail1"] ? 1 : 0 );
	$pemail2 = ($_POST["pemail2"] ? 1 : 0 );
	$tabulka = ($_POST["selview"] == "tabulka" ? 1 : 0);
else:
	$id = $_POST["itemid"];
	$menuid = $_POST["menuid"];
	$idtop = $menuid;
	$actualrec = TblHandler($id,$tbl);
	if (($akce == "up") || ($akce == "down")):
		$pozice = $actualrec["pozice"];
		$newpozice = ($akce == "up" ? $pozice - 1 : $pozice + 1);
	endif;
endif;
// zapis
if ($akce == "add"):
	$dotaz = "INSERT INTO $tbl (polesel,poleval,poleraz,ptelefon1,ptelefon2,pmobil1,pmobil2,pfax,picq,pemail1,pemail2,pimg,zamon,zaston,
		radaon,clvybon,clkomon,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere,pidstrana,pidzarzast,pidzarrada,pidvybor,pidzarvybor,
		pidkomise,pidzarkomise,tabulka,uprava)
		VALUES ('$polesel',$poleval,'$poleraz',$ptelefon1,$ptelefon2,$pmobil1,$pmobil2,$pfax,$picq,$pemail1,$pemail2,$pimg,$zamon,$zaston,
		$radaon,$clvybon,$clkomon,$pidzarazeni,$pidodbor,$pidoddeleni,$pidbudova,$pdvere,$pidstrana,$pidzarzast,$pidzarrada,$pidvybor,$pidzarvybor,
		$pidkomise,$pidzarkomise,$tabulka,1)";
elseif ($akce == "edit"):
	$dotaz = "UPDATE $tbl SET polesel = '$polesel', poleval = $poleval, poleraz = '$poleraz', ptelefon1 = $ptelefon1, ptelefon2 = $ptelefon2,
		pmobil1 = $pmobil1, pmobil2 = $pmobil2, pfax = $pfax, picq = $picq, pemail1 = $pemail1, pemail2 = $pemail2, pimg = $pimg,
		zamon = $zamon, zaston = $zaston, radaon = $radaon, clvybon = $clvybon, clkomon = $clkomon, pidzarazeni = $pidzarazeni,
		pidodbor = $pidodbor, pidoddeleni = $pidoddeleni, pidbudova = $pidbudova, pdvere = $pdvere,	pidstrana = $pidstrana,
		pidzarzast = $pidzarzast, pidzarrada = $pidzarrada, pidvybor = $pidvybor, pidzarvybor = $pidzarvybor, pidkomise = $pidkomise,
		pidzarkomise = $pidzarkomise, tabulka = $tabulka WHERE id=$id";
elseif ($akce == "del"):
	$dotaz = "DELETE FROM $tbl WHERE id=$id";
else:
	$dotaz = "SELECT * FROM $tbl WHERE mtid=$mtid";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Chyba pri výberu dat - changesel - úprava pozice!");
	else:
		$maxpozice = mysql_num_rows($result);
		if (($newpozice != 0) && ($newpozice <= $maxpozice)):
			$dotaz = "UPDATE $tbl SET pozice = $newpozice, uprava = 1 WHERE id=$id";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Zmena úpravy nepro¹la - changesel!");
			else:
				$chgpozice = ($akce == "up" ? $newpozice+1 : $newpozice-1);
				$dotaz = "UPDATE $tbl SET pozice = $chgpozice WHERE mtid=$mtid AND uprava!=1 AND pozice=$newpozice";
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Zmena pozice se nezdarila - changesel!");
				else:
					$dotaz = "UPDATE $tbl SET uprava = 0 WHERE uprava=1";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Zmena v sloupci úprava se nezdarila - changesel!");
					endif;
				endif;
			endif;
		endif;
	endif;
endif;
$result = mysql_query("$dotaz");
if (!$result):
	if ($akce == "add"):
		die("nepodarilo se vlo¾it záznam - changesel.php");
	elseif ($akce == "edit"):
		die("nepodarilo se zmenit záznam - changesel.php");
	else:
		die("nepodarilo se smazat záznam - changesel.php");
	endif;
else: 
	if ($akce == "add"):
		$pozice = GetNewPozice("content",$mtid);
		$idtbl = GetTblId($tbl);
		$contid = GetUprId($tbl);
		$dotaz = "INSERT INTO content (idtbl,mtid,contid,pozice) VALUES ($idtbl,$mtid,$contid,$pozice)";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Pridání obsahu do tabulky content prece jen úplne nedopadlo - changesel!");
		endif;
	elseif ($akce == "del"):
		// zji¹tení pozice v tabulce content
		$dotaz = "SELECT * FROM content WHERE contid=$id";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba pri výberu záznamu ke smazání z tabulky content - changesel!");
		else:
			$record = mysql_fetch_array($result);
			$pozice = $record["pozice"];
		endif;
		// výber záznamu pro úpravu
		$dotaz = "SELECT * FROM content WHERE pozice>$pozice AND mtid=$mtid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba pri výberu dat - changesel - úprava tabulky content po mazání!");
		else:
			while ($record = mysql_fetch_array($result)):
				$ctid = $record["id"];
				$chgpozice = $record["pozice"]-1;
				$dotaz = "UPDATE content SET pozice = $chgpozice WHERE id=$ctid";
				$result2 = mysql_query("$dotaz");
				if (!$result2):
					die("Zmena pozice se nezdarila - changesel!");
				endif;
			endwhile;
		endif;
		// smazání záznamu z tabulky content
		$dotaz = "DELETE FROM content WHERE contid=$id";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba pri mazání záznamu v tabulce content - changesel!");
		endif;
	endif;
endif;
$path = substr($script, 0, StrRPos($script, "/"))."/contentmng.php?itemid=$mtid&menuid=$menuid";
Header("Location: http://".$server.":".$port.$path);
?>