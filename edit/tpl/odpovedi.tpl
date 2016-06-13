<?php
	// záhlaví
	$recordcst = TblHandler($idsoutez,"soutez");
	echo "<p><strong>Odpovědi na otázku - ".$recordcst["otazka"]."</strong></p>\n";
	
	// výpis záznamů
	$dotaz = "SELECT o.id,u.jmeno,u.prijmeni,u.titul,u.ulice,u.mesto,u.psc,o.odp,s.spravne FROM odpoved AS o,soutez AS s,uzivatel AS u WHERE o.idcst=$idsoutez AND o.idcst=s.id AND o.iduser=u.id ORDER BY o.id DESC";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst údaje z tabulky souteze - odpovedi.tpl!");
	else:
		$pocsl = mysql_num_fields($result);
		echo "<table>\n";
		echo "<tr>\n";
		for ($i=1; $i<$pocsl;$i++):
			echo "<th>".mysql_field_name($result,$i)."</th>\n";
		endfor;
		echo "</tr>\n";
		while ($record = mysql_fetch_array($result)):
			$itemid = $record["id"];
			echo "<tr ".($record["spravne"] == $record["odp"] ? "class=\"bggreen\"" : "class=\"bgred\"").">\n";
			for ($i=1; $i<$pocsl;$i++):
				echo "<td>".((mysql_field_name($result,$i) == "datum") || (mysql_field_name($result,$i) == "datum_do") ? date("d.m.Y",$record[$i]) : $record[$i])."</td>\n";
			endfor;
			echo "</tr>\n";
		endwhile;
		echo "</table>\n";
	endif;
?>