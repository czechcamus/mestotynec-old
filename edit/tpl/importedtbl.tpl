<?php
	$dotaz = "SELECT * FROM tablename WHERE imported=1";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje importovaných tabulek - importedtbl.tpl!");
	else:
		echo "<table>\n";
		echo "<tr>\n";
		echo "<th>&nbsp;</th>\n";
		echo "<th>tblname</th>\n";
		echo "<th>titulek</th>\n";
		echo "</tr>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record["id"];
			echo "<tr>\n";
			echo "<td><a href=\"./deltbl.php?tbl=".$record["tblname"]."\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat tabulku\" height=\"15\" width=\"15\" /></a></td>\n";
			echo "<td><a href=\"contenttbl.php?tbl=".$record["tblname"]."\">".$record["tblname"]."</a></td>\n";
			echo "<td>".$record["titulek"]."</td>\n";
			echo "</tr>\n";
		endwhile;
		echo "</table>\n";
	endif;

?>