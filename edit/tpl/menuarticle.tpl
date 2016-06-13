<div id="content">
<?php
if ($menuid):
	// záhlaví
	if ($recordred["admin"] || $recordred["schval"]):
		echo "<div class=\"controlcenter\"><a href=\"./articlemng.php?menuid=".$menuid."\" class=\"button\">články k připojení</a></div>";
	endif;
	echo "<h2>Všechny připojené články:</h2>\n";
	// načtení seznamu článků
	$actualdate = date("Y-m-d",time());
	$dotaz = "SELECT aj.id,aj.mtid,aj.menuid,aj.switchoff,mt.titulek FROM articlejoin AS aj, mastertxt AS mt, menu AS me WHERE aj.menuid=$menuid AND aj.menuid=me.id AND aj.mtid=mt.id AND mt.datum1<='$actualdate' AND mt.datum2>='$actualdate' ORDER BY aj.pozice";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se načíst články - menuarticle - $dotaz!");
	else:
		echo "<ul class=\"articleitems\">\n";
		while ($record = mysql_fetch_array($result)):
			$mtid = $record["mtid"];
			$itemid = $record["id"];
			echo "<li>";
			if ($recordred["admin"] || $recordred["schval"]):
				echo "<a href=\"./contentmng.php?itemid=$mtid&amp;menuid=$menuid\">";
			endif;
			echo $record["titulek"];
			if ($recordred["admin"] || $recordred["schval"]):
				echo "</a>";
				echo "<br />\n";
				echo ($record["switchoff"] ? "<a href=\"./switch.php?tbl=articlejoin&amp;sw=0&amp;itemid=$itemid&amp;menuid=$menuid\" class=\"imglink\"><img src=\"./img/switchoff.gif\" alt=\"obr vypnuto\" title=\"vypnuto - zapnout kliknutím \" height=\"15\" width=\"15\" /></a>\n" : "<a href=\"./switch.php?tbl=articlejoin&amp;sw=1&amp;itemid=$itemid&amp;menuid=$menuid\" class=\"imglink\"><img src=\"./img/switchon.gif\" alt=\"obr zapnuto\" title=\"zapnuto - vypnout kliknutím\" height=\"15\" width=\"15\" /></a>\n");
				echo "<a href=\"./delete.php?tbl=articlejoin&amp;itemid=$itemid&amp;menuid=$menuid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"odpojit článek\" height=\"15\" width=\"15\" /></a>\n";
				echo "<a href=\"./changetbl.php?akce=up&amp;tbl=articlejoin&amp;itemid=$itemid&amp;menuid=$menuid\" class=\"imglink\"><img src=\"./img/moveup.gif\" alt=\"obr posunout nahoru\" title=\"posunout článek nahoru\" height=\"15\" width=\"15\" /></a>\n";
				echo "<a href=\"./changetbl.php?akce=down&amp;tbl=articlejoin&amp;itemid=$itemid&amp;menuid=$menuid\" class=\"imglink\"><img src=\"./img/movedown.gif\" alt=\"obr posunout dolů\" title=\"posunout článek dolů\" height=\"15\" width=\"15\" /></a>\n";
			endif;
			echo "</li>\n";
		endwhile;
		echo "</ul>\n";
	endif;
endif;
?>
</div><!-- end menuarticle -->