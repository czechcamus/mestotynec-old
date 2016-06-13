		<div id="left2">
<?php
	// záhlaví
	echo "<div class=\"controlcenter\"><a href=\"./edit.php?akce=add&amp;tbl=mastertxt&amp;menuid=$menuid\" class=\"button\">přidat článek</a></div>";
	echo "<h2>Platné články:</h2>\n";
	// výpis schválených článků
	$actualdate = date("Y-m-d",time());
	if ($recordred["admin"] || $recordred["schval"]):
		$dotaz = "SELECT id,titulek,datum1,datum2,publish FROM mastertxt WHERE publish=1 AND datum1<='$actualdate' AND datum2>='$actualdate' ORDER BY titulek";
	else:
		$dotaz = "SELECT id,titulek,datum1,datum2,publish FROM mastertxt WHERE idredaktor=".$recordred["id"]." AND datum1<='$actualdate' AND datum2>='$actualdate' ORDER BY titulek";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst články - articlelist - $dotaz!");
	else:
		$poczaz = mysql_num_rows($result);
		if ($poczaz):
			while ($record = mysql_fetch_array($result)):
				echo "<div class=\"article\">\n";
				$itemid = $record["id"];
				if ($menuid):
					$thismenu = IsArticleInThisMenu($itemid,$menuid);
				endif;
				if ($recordred["admin"] || $recordred["schval"] || !$record["publish"]):
					echo "<a href=\"./contentmng.php?itemid=$itemid&amp;menuid=$menuid\" title=\"Editovat článek\">\n";
				endif;
				echo $record["titulek"];
				if ($recordred["admin"] || $recordred["schval"] || !$record["publish"]):
					echo "</a>";
				endif;
				echo "&nbsp;";
				if ($menuid && !$thismenu):
					echo "<a href=\"./articlejoin.php?itemid=$itemid&amp;menuid=$menuid\" title=\"Připojit článek\" class=\"imglink\">";
					echo "<img src=\"./img/join.gif\" alt=\"obr připojit\" title=\"připojit článek k menu\" height=\"15\" width=\"15\" />";
					echo "</a>\n";
				elseif (!$menuid):
					$dotazmenu = "SELECT * FROM articlejoin AS aj, menu AS me WHERE aj.mtid=$itemid AND aj.menuid=me.id";
					$resultmenu = mysql_query("$dotazmenu");
					if (!$resultmenu):
						die("Chyba v dotazu - $dotazmenu");
					else:
						if (mysql_num_rows($resultmenu)):
							echo " <span class=\"menujoin\">(<em>Připojení k :</em> ";
							$p = 1;
							while ($recordmenu = mysql_fetch_array($resultmenu)):
								$titulek = ($recordmenu["level"] ? $recordmenu["titulek"] : ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$recordmenu['titulek']));
								echo ($p ? "" : ", ");
								echo $titulek;
								$p = 0;
							endwhile;
							echo ")</span>\n";
						endif;
					endif;
				endif;
				echo "</div>\n";
			endwhile;
		endif;
	endif;
	echo "<h2>Archiv článků:</h2>\n";
	// výpis z archivu článků
	$actualdate = date("Y-m-d",time());
	if ($recordred["admin"] || $recordred["schval"]):
		$dotaz = "SELECT id,titulek,datum1,datum2,publish FROM mastertxt WHERE datum2<'$actualdate' ORDER BY titulek";
	else:
		$dotaz = "SELECT id,titulek,datum1,datum2,publish FROM mastertxt WHERE idredaktor=".$recordred["id"]." AND datum2<'$actualdate' ORDER BY titulek";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst články - articlelist - $dotaz!");
	else:
		$poczaz = mysql_num_rows($result);
		if ($poczaz):
			while ($record = mysql_fetch_array($result)):
				echo "<div class=\"article\">\n";
				$itemid = $record["id"];
				if ($menuid):
					$thismenu = IsArticleInThisMenu($itemid,$menuid);
				endif;
				if ($recordred["admin"] || $recordred["schval"] || !$record["publish"]):
					echo "<a href=\"./contentmng.php?itemid=$itemid&amp;menuid=$menuid\" title=\"Editovat článek\">\n";
				endif;
				echo $record["titulek"];
				if ($recordred["admin"] || $recordred["schval"] || !$record["publish"]):
					echo "</a>";
				endif;
				echo "&nbsp;";
				if ($menuid && !$thismenu):
					echo "<a href=\"./articlejoin.php?itemid=$itemid&amp;menuid=$menuid\" title=\"Připojit článek\" class=\"imglink\">";
					echo "<img src=\"./img/join.gif\" alt=\"obr připojit\" title=\"připojit článek k menu\" height=\"15\" width=\"15\" />";
					echo "</a>\n";
				elseif (!$menuid):
					$dotazmenu = "SELECT * FROM articlejoin AS aj, menu AS me WHERE aj.mtid=$itemid AND aj.menuid=me.id";
					$resultmenu = mysql_query("$dotazmenu");
					if (!$resultmenu):
						die("Chyba v dotazu - $dotazmenu");
					else:
						if (mysql_num_rows($resultmenu)):
							echo " <span class=\"menujoin\">(<em>Připojení k :</em> ";
							$p = 1;
							while ($recordmenu = mysql_fetch_array($resultmenu)):
								$titulek = ($recordmenu["level"] ? $recordmenu["titulek"] : ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$recordmenu['titulek']));
								echo ($p ? "" : ", ");
								echo $titulek;
								$p = 0;
							endwhile;
							echo ")</span>\n";
						endif;
					endif;
				endif;
				echo "</div>\n";
			endwhile;
		endif;
	endif;
?>
		</div><!-- end left -->
