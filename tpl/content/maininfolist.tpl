<?php
	$dotaz = "SELECT * FROM menu WHERE idtop=".$menu["id"]." AND switchoff=0 ORDER BY pozice";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Z tabulky s nabídkou se nepodařilo načíst ani Ň");
	else:
		$menurows = mysql_num_rows($result);
		if ($menurows):
			echo "<ul class=\"localmenu\">\n";
			while ($record = mysql_fetch_array($result)):
				$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1<span class="letterkey">\\2</span>\\3',$record['titulek']);
				echo "<li><a href=\"page.php?fp=".$record["filename"]."\" title=\"".$record["obsah"]."\">".$titulek."</a></li>\n";
			endwhile;
			echo "</ul>\n";
		endif;
	endif;
?>