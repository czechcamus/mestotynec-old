<?php
	$mtid = $_GET["mtid"]; // id článku - mastertxt
	$itemid = $_GET["itemid"]; // id položky obashu - content
	$pozice = $_GET["pozice"]; // pozice položky obashu - content
	$idtbl = $_GET["idtbl"]; // id tabulky - content
	$photodetail = 1; // příznak pro zobrazení pouze údajů obrázku - použito v right.tpl
	$prevpozice = $pozice-1;
	$nextpozice = $pozice+1;
	$pocsnimku = 0;
	
	// výběr všech záznamů fotogalerie pro vytvoření dočasné tabulky snímků
	$dotazsrc = "SELECT * FROM content AS ct, foto AS fo, autor AS au, mastertxt AS mt WHERE ct.idtbl=$idtbl AND ct.mtid=$mtid AND ct.mtid=mt.id AND ct.contid=fo.id AND fo.idautor=au.id ORDER BY ct.pozice";
	$resultsrc = mysql_query("$dotazsrc");
	if (!$resultsrc):
		die("Nepodařilo se načíst záznamy z tabulky content - photo.tpl!");
	else:
		$pocsnimku = mysql_num_rows($resultsrc);
		$dotaztmp = "CREATE TEMPORARY TABLE images (pozice SMALLINT PRIMARY KEY, datum DATE, nazev VARCHAR(150), popis TEXT, snimek VARCHAR(150), jmeno VARCHAR(50), prijmeni VARCHAR(50), filename VARCHAR(100)) DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci";
		$resulttmp = mysql_query("$dotaztmp");
		if (!$resulttmp):
			die("Nepodařilo se vytvořit dočasnou tabulku obrázků - photo.tpl!");
		else:
			$i = 0;
			while ($recordsrc = mysql_fetch_array($resultsrc)):
				$datum = $recordsrc["datum"];
				$nazev = $recordsrc["nazev"];
				$popis = $recordsrc["popis"];
				$snimek = $recordsrc["snimek"];
				$jmeno = $recordsrc["jmeno"];
				$prijmeni = $recordsrc["prijmeni"];
				$filename = $recordsrc["filename"];
				$dotazins = "INSERT INTO images (pozice, datum, nazev, popis, snimek, jmeno, prijmeni, filename) VALUES ($i, '$datum', '$nazev', '$popis', '$snimek', '$jmeno', '$prijmeni', '$filename')";
				$resultins = mysql_query("$dotazins");
				if (!$resultins):
					die("Nepodařilo se vložit záznam do dočasné tabulky - photo.tpl");
				endif;
				++$i;
			endwhile;
		endif;
	endif;
	
	// výběr konkrétního záznamu záznamu
	$dotaz = "SELECT * FROM images WHERE pozice=$pozice";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst záznam z dočasné tabulky images - photo.tpl!");
	else:
		$record = mysql_fetch_array($result);
		list($width, $height, $type, $attr) = getimagesize("img/".$record["snimek"]);
		echo "<div class=\"maininfobox\">\n";
		echo "<div class=\"pack\">\n";
		echo "<div class=\"photomargin\">\n";
		echo "<div class=\"control\">\n";
		echo "<span class=\"back2list\"><a href=\"page.php?fp=$fp\">zpět na seznam</a></span>\n";
		echo "</div>\n";
		echo "<div class=\"control\">\n";
		echo "<span class=\"leftarrowlink\">";
		if ($pozice > 0):
			echo "<a href=\"page.php?fp=$fp&amp;idtbl=$idtbl&amp;mtid=$mtid&amp;itemid=$itemid&amp;pozice=$prevpozice#navbarbox\">";
		endif;
		echo "předchozí";
		if ($pozice > 0):
			echo "</a>";
		endif;
		echo "</span>\n";
		for ($i=0; $i < $pocsnimku; $i++):
			if ($i != $pozice):
				echo "<a href=\"page.php?fp=$fp&amp;idtbl=$idtbl&amp;mtid=$mtid&amp;itemid=$itemid&amp;pozice=$i#navbarbox\">";
			endif;
			echo ($i+1);
			if ($i != $pozice):
				echo "</a>";
			endif;
			echo " ";
		endfor;
		echo "<span class=\"rightarrowlink\">";
		if ($pozice < ($pocsnimku - 1)):
			echo "<a href=\"page.php?fp=$fp&amp;idtbl=$idtbl&amp;mtid=$mtid&amp;itemid=$itemid&amp;pozice=$nextpozice#navbarbox\">";
		endif;
		echo "následující";
		if ($pozice < ($pocsnimku - 1)):
			echo "</a>";
		endif;
		echo "</span>\n";
		echo "</div>\n";
		echo "<img src=\"img/".$record["snimek"]."\" ".$attr." alt=\"Foto - ".$record["nazev"]."\" />\n";
		echo "<h5>".$record["nazev"]."</h5>\n";
		echo "<div class=\"photoinfo\">Datum pořízení: <strong>";
	 	if ($record["datum"]!="0000-00-00"):
	 		echo ereg_replace("([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})","\\3.\\2.\\1",$record["datum"]);
	 	else:
	 		echo "neznámé";
	 	endif;
		echo "</strong>";
		echo ", autor snímku: <strong>";
		if ($record["jmeno"] || $record["prijmeni"]):
			echo $record["jmeno"]." ".$record["prijmeni"];
		else:
			echo "neznámý";					
		endif;
		echo "</strong></div>\n";
		if ($record["popis"]):
			echo "<p>".NL2BR($record["popis"])."</p>\n";
		endif;
		echo "</div>\n";
		echo "</div>\n";
		echo "</div>\n";
	endif;
?>
