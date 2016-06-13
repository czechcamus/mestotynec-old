<?php
	if ($step != 2):
		$tblheader = GetHeaderFromCsv($csvname,"importcsv.php");
		if (!$tblheader):
			die("Soubor CSV nebyl nalezen - formimpcsv2!");
		endif;
	endif;
	
	if ($tblheader):
		$oddelovac = ($oddelovac ? $oddelovac : ";");
		$tblheader = substr($tblheader,0,strlen($tblheader)-2);
		$headerarr = explode($oddelovac,$tblheader);
		echo "<div id=\"formcontent\">\n";
		echo "<h3>Import souboru CSV do tabulky - krok 2 ze 2</h3>\n";
		echo "<form action=\"./checkimport.php\" method=\"post\">\n";
		echo "<fieldset>\n";
		for ($i = 0; $i < count($headerarr); $i++):
			$srcfield = strtolower($headerarr[$i]);
			echo "<div><strong>Zdrojové pole - název: </strong> ".$srcfield."</div>\n";
			echo "<div><label class=\"noblock\" for=\"naz".$srcfield."\">Cílové pole - název: </label>";
			echo "<input type=\"text\" name=\"naz".$srcfield."\" id=\"naz".$srcfield."\" value=\"".$srcfield."\" size=\"15\">";
			echo "<label class=\"noblock\" for=\"typ".$srcfield."\"> typ: </label>";
			echo "<select name=\"typ".$srcfield."\" id=\"typ".$srcfield."\">";
				echo "<option value=\"t\">text</option>\n";
				echo "<option value=\"n\">číslo</option>\n";
			echo "</select>\n";
			echo "<label class=\"noblock\" for=\"len".$srcfield."\"> délka: </label>";
			echo "<input type=\"text\" name=\"len".$srcfield."\" id=\"len".$srcfield."\" value=\"35\" size=\"3\">";
			echo "</div>\n";
		endfor;
		echo "<div>\n";
		echo "<div>Názvy polí musí obsahovat pouze alfanumerická data bez diakritiky, mezer, interpunkce apod.</div>";
		echo "<input type=\"hidden\" name=\"csvname\" value=\"".$csvname."\" />\n";
		echo "<input type=\"hidden\" name=\"oddelovac\" value=\"".$oddelovac."\" />\n";
		echo "<input type=\"hidden\" name=\"titulek\" value=\"".$titulek."\" />\n";
		echo "<input type=\"hidden\" name=\"tblname\" value=\"".$tblname."\" />\n";
		echo "<input type=\"hidden\" name=\"step\" value=\"2\" />\n";
		echo "<input type=\"submit\" value=\"dokončit\" />\n";
		echo "</div>\n";
		echo "</fieldset>\n";
		echo "</form>\n";
		echo "</div>\n";
	else:
		if ($step != 2):
			echo "<h3>Import se nezdařil - nepodařilo se najít hlavičku tabulky - formimpcsv2!</h3>\n";
			echo "<form action=\"./importcsv.php\" method=\"get\">\n";
		else:
			echo "<h3>Import se podařil - gratuluji!</h3>\n";
			echo "<form action=\"./importedtbl.php\" method=\"get\">\n";
		endif;
		echo "<fieldset>\n";
		echo "<input type=\"submit\" value=\"OK\" />\n";
		echo "</fieldset>\n";
		echo "</form>\n";
	endif;
?>