<?php
	// záhlaví
	echo "<div class=\"control\"><a href=\"./edit.php?akce=add&amp;tbl=pocasi\" class=\"button\">přidat denní údaje o počasí</a></div>\n";
	
	// výpis anket
	$dotaz = "SELECT * FROM pocasi AS p, kodpocasi AS k WHERE p.kodpoc=k.kod ORDER BY datum DESC LIMIT 0,30";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky počasí - listweather.tpl!");
	else:
		echo "<ul>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record["id"];
			echo "<li><strong>".SetCzDateForm($record["datum"])."</strong> - ".$record["text"]." - v noci: ".$record["rano"]." - přes den: ".$record["odpoledne"]."<br />\n";
			echo "<a href=\"./edit.php?tbl=pocasi&amp;akce=edit&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit anketu\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./delete.php?tbl=pocasi&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat anketu\" height=\"15\" width=\"15\" /></a></li>\n";
		endwhile;
		echo "</ul>\n";
	endif;

?>