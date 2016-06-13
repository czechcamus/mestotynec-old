		<div id="left">
<?php
	// vytvoření navigačního řádku
	echo "<div class=\"controlcenter\"><a href=\"./edit.php?menuid=".$menuid."&amp;akce=add&amp;tbl=menu\" class=\"button\">přidat položku nabídky</a></div>";
	echo "<div class=\"navmenu\">";
	$mp = $menuid; // číslo položky menu
	$pref = ($mp ? "<a href=\"./webmng.php\">hlavní nabídka</a><br />\n" : "<p><strong>hlavní nabídka:</strong></p>");
	$menubar = "";
	while ($mp):
		$dotaz = "SELECT * FROM menu WHERE id=$mp";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se určit položku menu - menu.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$mp = $record["idtop"];
			$mt = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record["titulek"]); // titulek menu
			if ($menuid != $record["id"]):
				$menubar = "<a href=\"./webmng.php?menuid=".$record["id"]."\">nabídka ".$mt."</a><br />".$menubar;
			else:
				$menubar = "<p><strong>nabídka ".$mt.":</strong></p>\n";
			endif;
		endif;
	endwhile;
	echo $pref.$menubar;
	echo "</div>";
	
	// výpis menu
	if ($menuid):
		$dotaz = "SELECT * FROM menu WHERE idtop=$menuid ORDER BY pozice";
	else:
		$dotaz = "SELECT * FROM menu WHERE level=0 ORDER BY pozice";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Z tabulky s nabídkou se nepodařilo načíst ani Ň - menu.tpl");
	else:
		$poczaz = mysql_num_rows($result);
		if ($poczaz):
			echo "<ul class=\"menuitems\">\n";
			while ($record = mysql_fetch_array($result)):
				$titulek = ($record["level"] ? $record["titulek"] : ereg_replace('(.*)\((.)(.*)\)','\\1<span class="letterkey">\\2</span>\\3',$record['titulek']));
				echo "<li><a href=\"./webmng.php?menuid=".$record["id"]."\">".$titulek."</a><br />\n";
				echo "<em>Obsah:</em> ".$record["obsah"]."<br />\n";
				if ($record["filename"] != "index.php"):
					echo ($record["switchoff"] ? "<a href=\"./switch.php?tbl=menu&amp;sw=0&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/switchoff.gif\" alt=\"obr vypnuto\" title=\"vypnuto - zapnout kliknutím \" height=\"15\" width=\"15\" /></a>\n" : "<a href=\"./switch.php?tbl=menu&amp;sw=1&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/switchon.gif\" alt=\"obr zapnuto\" title=\"zapnuto - vypnout kliknutím\" height=\"15\" width=\"15\" /></a>\n");
				endif;
				echo "<a href=\"./edit.php?tbl=menu&amp;akce=edit&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit položku menu\" height=\"15\" width=\"15\" /></a>\n";
				if ($record["filename"] != "index.php"):
					echo "<a href=\"./delete.php?tbl=menu&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat položku menu\" height=\"15\" width=\"15\" /></a>\n";
				endif;
				echo "<a href=\"./changetbl.php?akce=up&amp;tbl=menu&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/moveup.gif\" alt=\"obr posunout nahoru\" title=\"posunout položku menu nahoru\" height=\"15\" width=\"15\" /></a>\n";
				echo "<a href=\"./changetbl.php?akce=down&amp;tbl=menu&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/movedown.gif\" alt=\"obr posunout dolů\" title=\"posunout položku menu dolů\" height=\"15\" width=\"15\" /></a>\n";
				echo "</li>\n";
			endwhile;
			echo "</ul>\n";
		endif;
	endif;
?>
		</div><!-- end left -->
