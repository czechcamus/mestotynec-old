<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
		// načtení obsahu
		$dotazedit = "SELECT * FROM $tbl WHERE id=$itemid";
		$resultedit = mysql_query("$dotazedit");
		if (!$resultedit):
			die("Nepodařilo se načíst obsah - formimptbl.tpl!");
		else:
			$record = mysql_fetch_array($resultedit);
		endif;
		echo "<h3>Editace záznamu</h3>";
	else:
		echo "<h3>Přidání záznamu</h3>";
	endif;
	// načtení struktury
	$dotaz = "SELECT * FROM $tbl";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst strukturu tabulky - formimptbl.tpl!");
	endif;
	
	// vytvoření a zobrazení formuláře
	echo "<form action=\"./changeimptbl.php\" method=\"get\">\n";
	echo "<fieldset>\n";
	while ($polozka = mysql_fetch_field($result)):
		$jmpol = $polozka->name;
		if ($jmpol != "id"):
			echo "<label for=\"".$jmpol."\">".$jmpol."</label>\n";
			echo "<input type=\"text\" name=\"".$jmpol."\" id=\"".$jmpol."\" size=\"35\" value=\"".$record["$jmpol"]."\" />\n";
		endif;
	endwhile;
	echo "<div>\n";
	echo "<input type=\"hidden\" name=\"itemid\" value=\"$itemid\" />\n";
	echo "<input type=\"hidden\" name=\"tbl\" value=\"$tbl\" />\n";
	echo "<input type=\"hidden\" name=\"akce\" value=\"$akce\" />\n";
	echo "<input type=\"submit\" value=\"uložit\" />\n";
	echo "</div>\n";
	echo "</fieldset>\n";
	echo "</form>\n";
?>
</div>