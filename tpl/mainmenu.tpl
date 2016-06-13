<?php
	$dotaz = "SELECT * FROM menu WHERE level=0 AND switchoff=0 ORDER BY pozice";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Z tabulky s hlavní nabídkou se nepodařilo načíst ani Ň - Mainmenu 1");
	else:
		echo "<ul>\n";
		while ($record = mysql_fetch_array($result)):
			$akey = ereg_replace('(.*\()(.)(\).*)','\\2',$record['titulek']);
			$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1<span class="letterkey">\\2</span>\\3',$record['titulek']);
			echo "<li".($fp==$record["filename"] ? " class=\"on\"" : "")."><a href=\"".(strstr($record["filename"],".php") ? $record["filename"] : "page.php?fp=".$record["filename"])."\" accesskey=\"$akey\" title=\"".$record["obsah"]." - klávesová zkratka: $akey\">".$titulek."</a>";
			if (($l1m["id"] == $record["id"]) && $sm):
				$branch = true;
				$idtop = $record["id"];
			elseif (($l1m["level"] > 0) && ($record["id"] == $l1m["idtop"] )):
				$branch = true;
				$idtop = $l1m["idtop"];
			else:
				$branch = false;
			endif;
			if ($branch):
				$dotaz2 = "SELECT * FROM menu WHERE level=1 AND idtop=$idtop AND switchoff=0 ORDER BY pozice";
				$result2 = mysql_query("$dotaz2");
				if (!$result2):
					die("Z tabulky s hlavní podnabídkou se nepodařilo načíst ani Ň - Mainmenu 2");
				else:
					echo "<ul>\n";
					while ($record2 = mysql_fetch_array($result2)):
						echo "<li".($l1m["filename"] == $record2["filename"] ? " class=\"on\"" : "")."><a href=\"page.php?fp=".$record2["filename"]."\" title=\"".$record2["obsah"]."\">".$record2["titulek"]."</a></li>\n";
					endwhile;
					echo "</ul>\n";
				endif;
			endif;
			echo "</li>\n";
		endwhile;
		echo "</ul>\n";
	endif;
?>
