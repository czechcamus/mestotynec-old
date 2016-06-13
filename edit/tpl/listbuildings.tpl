<?php
	// záhlaví
	echo "<div class=\"control\"><a href=\"./edit.php?akce=add&amp;tbl=budova\" class=\"button\">přidat budovu</a></div>\n";
	
	// výpis budov
	$dotaz = "SELECT * FROM budova WHERE idredaktor=$idredaktor ORDER BY id DESC LIMIT 0,30";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky budova - listbuildings.tpl!");
	else:
		echo "<ul>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record["id"];
			echo "<li>".$record["nazev"]." - ".$record["ulice"]."<br />";
			echo "<a href=\"./edit.php?tbl=budova&amp;akce=edit&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit budovu :-)\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./delete.php?tbl=budova&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat budovu :-)\" height=\"15\" width=\"15\" /></a></li>\n";
		endwhile;
		echo "</ul>\n";
	endif;

?>