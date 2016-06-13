<div id="contentbar">
<?php
	// výběr témat
	$dotaz = "SELECT * FROM tema WHERE switchoff=0 ORDER BY public DESC LIMIT $zac,$poczazstr";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat záznamy z tabulky témat - tema.tpl!");
	else:
		$poctemat = GetNumRecords("tema","switchoff=0");
		echo "<div class=\"articlebox\">\n";
		echo "<h2>Diskusní fórum - přehled témat</h2>\n";
		if ($poctemat):
			echo "<table class=\"table\">\n";
			echo "<col />\n";
			echo "<col class=\"zapissl3\" />\n";
			echo "<col class=\"zapissl4\" />\n";
			echo "<tr>\n";
			echo "<th>název tématu</th>";
			echo "<th class=\"textcenter\">počet zápisů</th>";
			echo "<th class=\"textcenter\">poslední změna</th>\n";
			echo "</tr>\n";
			$i = 0;
			while ($record = mysql_fetch_array($result)):
				$idtema = $record["id"];
				$poczap = GetNumRecords("zapis","idtema=$idtema");
				$maxcas = GetMaxTime("zapis","caszapisu","idtema=$idtema");
				$ppcas = GetIntTime($maxcas);
				$datumcas = ($ppcas != -1 ? date("d.m.Y v H:i",$ppcas) : "");
				echo "<tr class=\"bg$i\">\n";
				echo "<td class=\"bold\"><a href=\"diskuse.php?idtema=$idtema\" title=\"zobrazit příspěvky\">".$record["nazev"]."</a></td>";
				echo "<td class=\"textcenter\">".$poczap."</td>";
				echo "<td class=\"textcenter\">".($datumcas ? $datumcas : "---")."</td>";
				echo "</tr>\n";
				$i = ($i ? 0 : 1);
			endwhile;
			echo "</table>\n";
			if ($poctemat > $poczazstr):
				echo "<div class=\"control textcenter\">\n";
				$pocstr = ceil($poctemat/$poczazstr);
				for ($i=1;$i<=$pocstr;$i++):
					echo "&nbsp;";
					if ($zac != (($i-1)*$poczazstr)):
						echo "<a href=\"diskuse.php?zac=".(($i-1)*$poczazstr)."\" title=\"strana $i\">";
					endif;
					echo $i;
					if ($zac != (($i-1)*$poczazstr)):
						echo "</a>";
					endif;
					echo "&nbsp;";
				endfor;
				echo "</div>\n";
			endif;
		endif;
		echo "</div>\n";
	endif;
?>
</div>
