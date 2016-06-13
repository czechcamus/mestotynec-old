<div id="contentbar">
<?php
	// zjištění verze mysql serveru
	$mysqlver = GetMysqlVer();
	
	// výběr nalezených záznamů
	if ($mysqlver < "4.0.1"):
		if (strlen($searchtext) > 2):
			$dotaz = "SELECT DISTINCT * FROM search WHERE LOCATE(LCASE('$searchtext'), LCASE(obsah)) > 0 LIMIT $zac,$poczazstr";
		endif;
	else:
		$dotaz = "SELECT * FROM search WHERE MATCH (obsah) AGAINST ('$searchtext' IN BOOLEAN MODE) LIMIT $zac,$poczazstr";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat záznamy z tabulky search - search.tpl!");
	else:
		$pocnalezu = mysql_num_rows($result);
		echo "<div class=\"articlebox\">\n";
		if (!$pocnalezu):
			echo "<h4>Nenalezen žádný výskyt výrazu \"$searchtext\"...</h4>\n";
		else:
			echo "<h4>Počet nalezených stránek: $pocnalezu</h4>\n";
		endif;		
		echo "<strong>Nejste spokojen(a) s výsledkem hledání?</strong>\n";
		if ($mysqlver <= "4.0.1"):
			if (!$pocnalezu):
				echo "<p>Důvodem nenalezení žádného výskytu může být buď skutečnost, že výraz není v celém webu použit, je kratší než
				čtyři znaky anebo také to (možná častěji), že je web hledanými výrazy přeplněn ;-)</p>\n";
			endif;
			echo "<p>Zkuste <strong>upřesnit</strong> hledaný výraz.</p>\n";
		else:
			echo "<p>Zkuste hledaný výraz upřesnit použitím operátorů: <br />
			\"+\" = výsledná stránka musí obsahovat hledané slovo<br />
			\"-\" = stránka	nesmí obsahovat hledané slovo.</p>\n";
		endif;
		echo "<dl>\n";
		while ($record = mysql_fetch_array($result)):
			echo "<dt><a href=\"".$record["filename"]."\">".$record["titulek"]."</a></dt>\n";
			if (strlen($record["obsah"]) > 200):
				$poz = strpos($record["obsah"], $searchtext);
				if ($poz > 20):
					echo "<dd class=\"italic\">...".utf8_substr($record["obsah"], ($poz-15), 179)."...</dd>\n";
				else:
					echo "<dd class=\"italic\">".utf8_substr($record["obsah"], 0, 197)."...</dd>\n";
				endif;
			else:
				echo "<dd class=\"italic\">".utf8_substr($record["obsah"], 0,strlen($record["obsah"]))."...</dd>\n";
			endif;
		endwhile;
		echo "</dl>\n";
		if ($pocnalezu > $poczazstr):
			echo "<div class=\"control textcenter\">\n";
			$pocstr = ceil($pocnalezu/$poczazstr);
			for ($i=1;$i<=$pocstr;$i++):
				echo "&nbsp;";
				if ($zac != (($i-1)*$poczazstr)):
					echo "<a href=\"search.php?searchtext=$searchtext&amp;zac=".(($i-1)*$poczazstr)."\" title=\"strana $i\">";
				endif;
				echo $i;
				if ($zac != (($i-1)*$poczazstr)):
					echo "</a>";
				endif;
				echo "&nbsp;";
			endfor;
			echo "</div>\n";
		endif;
		echo "<hr class=\"masterclear\" />\n";
		echo "</div><!-- end searchbox -->\n";
	endif;
?>
</div>