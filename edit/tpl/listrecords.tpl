<?php
	// záhlaví
	if ($tbl == "zapis"):
		$idtema = $_GET["idtema"];
		echo "<p><strong>Správa příspěvků v diskusním fóru</strong></p>\n";
	elseif ($tbl == "soutez"):
		echo "<p><strong>Správa soutěží</strong></p>\n";
	elseif ($tbl == "firmy_cinnosti"):
    $idfirmy = $_GET["idfirmy"];
		echo "<div class=\"control\"><a href=\"./edit.php?fn=$fn&amp;akce=add&amp;tbl=$tbl&amp;ttbl=$ttbl&amp;title=$title&amp;placelevel=$placelevel&amp;idfirmy=$idfirmy\" class=\"button\">přidat - $title</a></div>\n";
	else:
 		echo "<div class=\"control\"><a href=\"./edit.php?fn=$fn&amp;akce=add&amp;tbl=$tbl&amp;ttbl=$ttbl&amp;title=$title&amp;placelevel=$placelevel\" class=\"button\">přidat - $title</a></div>\n";
	endif;
	
	// výpis záznamů
	if ($tbl == "firmy_cinnosti"):
		$dotaz = "SELECT t.id,c.nazev,t.idredaktor FROM $tbl AS t,cinnosti AS c WHERE t.idfirmy=$idfirmy AND t.idcinnosti=c.id ORDER BY c.cznazev";
	elseif ($tbl == "redaktor"):
	  $dotaz = "SELECT id, user, jmeno,	prijmeni,	email, admin,	schval,	web, anketa, soutez, pocasi, ciselniky,	uzivatele, import, kalendar, diskuse, udeska FROM $tbl WHERE id!=0";
	else:
	  $dotaz = "SELECT * FROM $tbl WHERE id!=0";
	endif;
	if ($tbl == "kalendar"):
		$dotaz .= " AND datum_do >= ".(time()-86400)." ORDER BY datum";
	elseif ($tbl == "mista"):
		if ($placelevel == 1):
			$dotaz .= " AND level1!=0 AND level2=0";
		elseif ($placelevel == 2):
			$dotaz .= " AND level2!=0 AND level3=0";
		elseif ($placelevel == 3):
			$dotaz .= " AND level3!=0 AND level4=0";
		elseif ($placelevel == 4):
			$dotaz .= " AND level4!=0";
		endif;
		$dotaz .= " ORDER BY name";
	elseif ($tbl == "podnik"):
		$dotaz .= " ORDER BY podnik,mesto";
	elseif ($tbl == "poradatel"):
		$dotaz .= " ORDER BY jmeno";
	elseif ($tbl == "osoba"):
		$dotaz .= " ORDER BY prijmeni";
	elseif ($tbl == "typakce"):
		$dotaz .= " ORDER BY popis";
	elseif ($tbl == "tema"):
		$dotaz .= " ORDER BY public,nazev";
	elseif ($tbl == "zapis"):
		$dotaz .= " AND idtema=$idtema ORDER BY caszapisu DESC";
	elseif ($tbl == "soutez"):
		$dotaz .= " ORDER BY id DESC";
	elseif ($tbl == "firmy" || $tbl == "cinnosti"):
		$dotaz .= " ORDER BY cznazev";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky $tbl - listrecords.tpl!");
	else:
		$pocsl = mysql_num_fields($result);
		echo "<table>\n";
		echo "<tr>\n";
		if (($tbl == "kalendar" && ($recordred["admin"] || $recordred["schval"])) || ($tbl == "tema")):
			echo "<th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>\n";
		elseif ($tbl == "soutez"):
			echo "<th>&nbsp;</th>\n";
		else:
			echo "<th>&nbsp;</th><th>&nbsp;</th>\n";
		endif;
		for ($i=1; $i<$pocsl;$i++):
			echo "<th>".mysql_field_name($result,$i)."</th>\n";
		endfor;
		echo "</tr>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record[0];
			echo "<tr>\n";
			if ($tbl == "kalendar" && ($recordred["admin"] || $recordred["schval"])):
				echo "<td>".($record["schvaleno"] ? "<a href=\"./publish.php?fn=$fn&amp;tbl=$tbl&amp;sw=0&amp;ttbl=$ttbl&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/publishon.gif\" alt=\"obr schváleno\" title=\"schváleno - zrušit kliknutím \" height=\"15\" width=\"15\" /></a>\n" :
				"<a href=\"./publish.php?fn=$fn&amp;tbl=$tbl&amp;sw=1&amp;ttbl=$ttbl&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/publishoff.gif\" alt=\"obr neschváleno\" title=\"neschváleno - schválit kliknutím\" height=\"15\" width=\"15\" /></a>")."</td>\n";
			elseif ($tbl == "tema"):
				echo "<td>".($record["switchoff"] ? "<a href=\"./switch.php?tbl=$tbl&amp;sw=0&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/switchoff.gif\" alt=\"obr vypnuto\" title=\"vypnuto - zapnout kliknutím \" height=\"15\" width=\"15\" /></a>\n" :
				"<a href=\"./switch.php?tbl=$tbl&amp;sw=1&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/switchon.gif\" alt=\"obr zapnuto\" title=\"zapnuto - vypnout kliknutím\" height=\"15\" width=\"15\" /></a>\n")."</td>\n";
			elseif ($tbl == "soutez"):
				echo "<td>".($record["losovano"] ? "<a href=\"./switch.php?tbl=$tbl&amp;sw=0&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/loson.gif\" alt=\"obr losováno\" title=\"losováno - zrušit kliknutím \" height=\"15\" width=\"15\" /></a>\n" :
				"<a href=\"./switch.php?tbl=$tbl&amp;sw=1&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/losoff.gif\" alt=\"obr nelosováno\" title=\"nelosováno - změnit kliknutím\" height=\"15\" width=\"15\" /></a>\n")."</td>\n";
			endif;
			if ($tbl != "soutez"):
				echo "<td><a href=\"./edit.php?fn=$fn&amp;tbl=$tbl&amp;ttbl=$ttbl&amp;title=$title&amp;akce=edit&amp;itemid=$itemid".($placelevel ? "&amp;placelevel=$placelevel" : "").($tbl == "zapis" ? "&amp;idtema=$idtema" : "").($tbl == "firmy_cinnosti" ? "&amp;idfirmy=$idfirmy" : "")."\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit záznam\" height=\"15\" width=\"15\" /></a></td>\n";
				echo "<td><a href=\"./delete.php?fn=$fn&amp;tbl=$tbl&amp;ttbl=$ttbl&amp;title=$title&amp;itemid=$itemid".($placelevel ? "&amp;placelevel=$placelevel" : "").($tbl == "zapis" ? "&amp;idtema=$idtema" : "").($tbl == "firmy_cinnosti" ? "&amp;idfirmy=$idfirmy" : "")."\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat záznam\" height=\"15\" width=\"15\" /></a></td>\n";
			endif;
			for ($i=1; $i<$pocsl;$i++):
				if (($tbl == "tema") && ($i == 1)):
					echo "<td><a href=\"zapismng.php?idtema=".$record[0]."\" title=\"správce zápisů\">".$record[$i]."</a></td>\n";
				elseif (($tbl == "soutez") && ($i == 1)):
					echo "<td><a href=\"odpovedmng.php?idsoutez=".$record[0]."\" title=\"správce odpovědí\">".$record[$i]."</a></td>\n";
				elseif (($tbl == "firmy") && ($i == 1)):
					echo "<td><a href=\"firmactionmng.php?idfirmy=".$record[0]."\" title=\"správce činnsotí firmy\">".$record[$i]."</a></td>\n";
				else:
					echo "<td>".((mysql_field_name($result,$i) == "datum") || (mysql_field_name($result,$i) == "datum_do") ? date("d.m.Y",$record[$i]) : $record[$i])."</td>\n";
				endif;
			endfor;
			echo "</tr>\n";
		endwhile;
		echo "</table>\n";
		if ($tbl == "zapis"):
		  echo "<h4><a href=\"diskusemng.php\" title=\"správce diskuse\">zpět k přehledu témat</a></h4>";
		elseif ($tbl == "firmy_cinnosti"):
		  echo "<h4><a href=\"firmmng.php\" title=\"správce firem\">zpět k přehledu firem</a></h4>";
		endif;
	endif;
?>
