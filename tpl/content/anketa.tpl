<div id="anketabox">
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
			echo "<h3>anketa</h3>\n";
			echo "<p class=\"question\">".$record["otazka"]."</p>\n";
			$i = 1;
			while ($record["odp".$i]):
				$dotazhl = "SELECT * FROM hlas WHERE idvote=".$record["id"]." AND odp=$i";
				$resulthl = mysql_query("$dotazhl");
				if (!$dotazhl):
					die("Nezdařil se výběr z tabulky hlas - anketa.tpl!");
				endif;
				$pochl = mysql_num_rows($resulthl);
				$proc = ($celpochl ? round(($pochl/$celpochl)*100,2) : 0);
				$swidth = (!$proc ? 1 : round(146*($proc/100),0));
				echo "<div class=\"answeritem\">\n";
				echo "<div class=\"votenr\">$pochl</div>\n";
				echo "<div class=\"answertxt\">";
				if ($idankety != $record["id"]):
					echo "<a href=\"hlas.php?fp=$fp&amp;idvote=".$record["id"]."&amp;odp=$i\" title=\"hlasovat\">";
				endif;
				echo $record["odp".$i];
				if ($idankety != $record["id"]):
					echo "</a>\n";
				endif;
				echo "</div>\n";
				echo "<div class=\"voteimg\"><img src=\"img/design/rtut.gif\" width=\"$swidth\" height=\"7\" alt=\"ukazatel\" /></div>\n";
				echo "</div>\n";
				++$i;
			endwhile;
			echo "<div class=\"sum\">Celkem hlasů: $celpochl</div>\n";
		endif;
	endif;	
?>
</div><!-- end anketabox -->