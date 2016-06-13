<?php
	// záhlaví
	echo "<div class=\"control\"><a href=\"./edit.php?akce=add&amp;tbl=zarazeni\" class=\"button\">přidat pracovní zařazení</a></div>\n";
	
	// výpis budov
	$dotaz = "SELECT * FROM zarazeni WHERE idredaktor=$idredaktor ORDER BY level LIMIT 0,30";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky zarazeni - listjobs.tpl!");
	else:
		echo "<ul>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record["id"];
			echo "<li>".$record["nazev"]."<br />";
			echo "<a href=\"./edit.php?tbl=zarazeni&amp;akce=edit&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit zařazení\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./delete.php?tbl=zarazeni&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat zařazení\" height=\"15\" width=\"15\" /></a></li>\n";
		endwhile;
		echo "</ul>\n";
	endif;

?>