<?php
	// výběr ankety
	$dotaz = "SELECT * FROM anketa WHERE aktiv=1";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat anketu - anketa.tpl!");
	endif;
	$record = mysql_fetch_array($result);
	// výběr hlásků
	$dotazank = "SELECT * FROM hlas AS h, anketa AS a WHERE h.idvote=a.id AND a.aktiv=1";
	$resultank = mysql_query("$dotazank");
	if (!$resultank):
		die("Nepodařilo se vybrat anketu a hlasy - anketa.tpl!");
	else:
		$celpochl = mysql_num_rows($resultank);
		if ($record["id"]):
			$recordank = mysql_fetch_array($resultank);
			$uservote = HasUserVote($_SESSION["userid"],$record["id"]);
			echo "<h3>Anketa</h3>\n";
			echo "<div>\n";
			echo "<p>".$record["otazka"]."</p>\n";
			$i = 1;
			while ($record["odp".$i]):
				echo "<div>";
				if (!$uservote):
					echo "<a href=\"scripts/hlas.php?fp=$fp&amp;idvote=".$record["id"]."&amp;odp=$i".($_SESSION["userid"] ? "&amp;".SID : "")."\"  title=\"hlasovat\">";
				endif;
				echo $record["odp".$i];
				if (!$uservote):
					echo "</a>\n";
				endif;
				echo "</div>\n";
				$dotazhl = "SELECT * FROM hlas WHERE idvote=".$record["id"]." AND odp=$i";
				$resulthl = mysql_query("$dotazhl");
				if (!$dotazhl):
					die("Nezdařil se výběr z tabulky hlas - anketa.tpl!");
				endif;
				$pochl = mysql_num_rows($resulthl);
				$proc = ($celpochl ? round(($pochl/$celpochl)*100,2) : 0);
				$swidth = round(173*($proc/100),0);
				echo "<div>$proc% ($pochl hl.)</div>\n";
				++$i;
			endwhile;
			echo "<p>Celkový počet hlasů: $celpochl</p>\n";
			echo "</div>\n";
			echo "<hr />\n";
		endif;
	endif;	
?>
