<div id="right">
<?php
	// výběr témat
	$dotaz = "SELECT * FROM tema WHERE switchoff=0 ORDER BY public DESC LIMIT $zac,$poczazstr";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat záznamy z tabulky témat - tema.tpl!");
	else:
		$poctemat = GetNumRecords("tema","switchoff=0");
		echo "<div>\n";
		echo "<h4>Diskusní fórum - přehled témat</h4>\n";
		if ($poctemat):
			echo "<table>\n";
			echo "<tr>\n";
			echo "<th>název tématu</th>";
			echo "<th>přístup</th>";
			echo "<th>počet zápisů</th>";
			echo "<th>poslední změna</th>\n";
			echo "</tr>\n";
			while ($record = mysql_fetch_array($result)):
				$idtema = $record["id"];
				$poczap = GetNumRecords("zapis","idtema=$idtema");
				$maxcas = GetMaxTime("zapis","caszapisu","idtema=$idtema");
				$ppcas = GetIntTime($maxcas);
				$datumcas = ($ppcas != -1 ? date("d.m.Y v H:i",$ppcas) : "");
				echo "<tr>\n";
				echo "<td class=\"bold\"><a href=\"diskuse.php?idtema=$idtema".($_SESSION["userid"] ? "&amp;".SID : "")."\">".$record["nazev"]."</a></td>";
				echo "<td class=\"textcenter\">".($record["public"] ? "volný" : "registrace")."</td>";
				echo "<td class=\"textcenter\">".$poczap."</td>";
				echo "<td class=\"textcenter\">".($datumcas ? $datumcas : "---")."</td>";
				echo "</tr>\n";
			endwhile;
			echo "</table>\n";
			if ($poctemat > $poczazstr):
				echo "<div>\n";
				$pocstr = ceil($poctemat/$poczazstr);
				for ($i=1;$i<=$pocstr;$i++):
					echo "&nbsp;";
					if ($zac != (($i-1)*$poczazstr)):
						echo "<a href=\"diskuse.php?zac=".(($i-1)*$poczazstr).($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"strana $i\">";
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
		echo "</div><!-- end maininfobox -->\n";
	endif;
?>
</div>