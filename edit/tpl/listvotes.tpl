<?php
	// záhlaví
	echo "<div class=\"control\"><a href=\"./edit.php?akce=add&amp;tbl=anketa\" class=\"button\">přidat anketu</a></div>\n";
	
	// výpis anket
	if ($recordred["admin"]):
		$dotaz = "SELECT * FROM anketa ORDER BY id DESC LIMIT 0,30";
	else:
		$dotaz = "SELECT * FROM anketa WHERE idredaktor=$idredaktor ORDER BY id DESC LIMIT 0,30";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky anketa - listvotes.tpl!");
	else:
		echo "<ul>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record["id"];
			echo "<li>".$record["otazka"]."<br />".($record["aktiv"] ? "<a href=\"./switch.php?tbl=anketa&amp;sw=0&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/switchon.gif\" alt=\"obr zapnuto\" title=\"zapnuto - vypnout kliknutím\" height=\"15\" width=\"15\" /></a>\n" : "<a href=\"./switch.php?tbl=anketa&amp;sw=1&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/switchoff.gif\" alt=\"obr vypnuto\" title=\"vypnuto - zapnout kliknutím \" height=\"15\" width=\"15\" /></a>\n");
			echo "<a href=\"./edit.php?tbl=anketa&amp;akce=edit&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit anketu\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./delete.php?tbl=anketa&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat anketu\" height=\"15\" width=\"15\" /></a></li>\n";
		endwhile;
		echo "</ul>\n";
	endif;

?>