<?php
	// záhlaví
	echo "<div class=\"control\"><a href=\"./editrectbl.php?akce=add&amp;tbl=$tbl\" class=\"button\">přidat záznam</a></div>\n";
	
	// výběr a zobrazení dat
	$dotaz = "SELECT * FROM $tbl";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky $tbl - contenttbl.tpl!");
	else:
		echo "<table>\n";
		$i = 0;
		$pocsloupcu = mysql_num_fields($result);
		while ($record = mysql_fetch_array($result)):
			if ($i == 0):
				echo "<tr>";
				for ($j = 0; $j < $pocsloupcu; $j++):
					echo "<th>".mysql_field_name($result,$j)."</th>";
				endfor;
				echo "<th colspan=\"2\">&nbsp;</th>";
				$i = 1;
				echo "</tr>\n";
			endif;
			echo "<tr>";
			$itemid = $record["id"];
			for ($j = 0; $j < $pocsloupcu; $j++):
				echo "<td>".$record[$j]."</td>";
			endfor;
			echo "<td><a href=\"./editrectbl.php?tbl=$tbl&amp;akce=edit&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit záznam\" height=\"15\" width=\"15\" /></a></td>";
			echo "<td><a href=\"./delrectbl.php?tbl=$tbl&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat záznam\" height=\"15\" width=\"15\" /></a></td>";
			echo "</tr>\n";
		endwhile;
		echo "</table>\n";
	endif;

?>