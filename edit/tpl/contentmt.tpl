<div id="content2">
<?php
// načtení obsahu hlavních textů
if ($recordred["admin"] || $recordred["schval"]):
	$dotaz = "SELECT * FROM mastertxt WHERE id=$itemid";
else:
	$dotaz = "SELECT * FROM mastertxt WHERE id=$itemid AND idredaktor=$idredaktor";
endif;
$result = mysql_query("$dotaz");
if (!$result):
	die("Nepodařilo se načíst obsah z tabulky mastertxt - contentmt.tpl - $dotaz!");
else:
	while ($record = mysql_fetch_array($result)):
		$itemid = $record["id"];
		echo "<div class=\"textitem\">\n";
		echo "<div class=\"articlecontent\">\n<h4>".$record["titulek"]."</h4>\n";
		if ($record["datum1"]):
			$ppdat1 = GetIntTime($record["datum1"]);
			$dat1 = date("d.m.Y",$ppdat1);
			echo "<div>Platnost od: <strong>".$dat1."</strong>";
			if ($record["datum2"] != "9999-12-31"):
				$ppdat2 = GetIntTime($record["datum2"]);
				$dat2 = date("d.m.Y",$ppdat2);
				echo " do: <strong>".$dat2."</strong>";
			endif;
			echo "</div>\n";
		endif;
		if ($record["thumbimg"]):
			echo "<div><img src=\"../img/".$record["thumbimg"]."\" alt=\"obrázek - ".$record["titlethumbimg"]."\" title=\"".$record["titlethumbimg"]."\"";
			if ($record["cssimg"]):
				echo " class=\"".$record["cssthumbimg"]."\"";
			endif;
			echo " /></div>\n";
		endif;
		// generování časového údaje
		$ppcas = GetIntTime($record["caszapisu"]);
		$datumcas = date("d.m.Y v H:i",$ppcas);
		echo "<div>Čas zápisu: <strong>".$datumcas."</strong></div>\n";
		echo "<div>Aktualita: <strong>".($record["maininfo"] ? "Ano" : "Ne")."</strong></div>\n";
		if ($record["perex"]):
			echo "<div>Perex: <em>".$record["perex"]."</em></div>\n";
		endif;
		if ($recordred["admin"]):
			$recordredmt = TblHandler($record["idredaktor"],"redaktor");
			echo "<div>Redaktor článku: ".$recordredmt["jmeno"]." ".$recordredmt["prijmeni"]."</div>\n";
		endif;			
		echo "<div>";
		if ($recordred["admin"] || $recordred["schval"]):
			echo ($record["publish"] ? "<a href=\"./publish.php?tbl=mastertxt&amp;sw=0&amp;menuid=$menuid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/publishon.gif\" alt=\"obr schváleno\" title=\"schváleno - zrušit kliknutím \" height=\"15\" width=\"15\" /></a>\n" : "<a href=\"./publish.php?tbl=mastertxt&amp;sw=1&amp;menuid=$menuid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/publishoff.gif\" alt=\"obr neschváleno\" title=\"neschváleno - schválit kliknutím\" height=\"15\" width=\"15\" /></a>\n");
		endif;
		echo ($record["switchoff"] ? "<a href=\"./switch.php?tbl=mastertxt&amp;sw=0&amp;menuid=$menuid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/switchoff.gif\" alt=\"obr vypnuto\" title=\"vypnuto - zapnout kliknutím \" height=\"15\" width=\"15\" /></a>\n" : "<a href=\"./switch.php?tbl=mastertxt&amp;sw=1&amp;menuid=$menuid&amp;itemid=".$record["id"]."\" class=\"imglink\"><img src=\"./img/switchon.gif\" alt=\"obr zapnuto\" title=\"zapnuto - vypnout kliknutím\" height=\"15\" width=\"15\" /></a>\n");
		echo "<a href=\"./edit.php?tbl=mastertxt&amp;akce=edit&amp;menuid=$menuid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit hlavní údaje článku\" height=\"15\" width=\"15\" /></a>\n";
		echo "<a href=\"./delete.php?tbl=mastertxt&amp;menuid=$menuid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat celý článek\" height=\"15\" width=\"15\" /></a>\n";
		echo "</div>\n";
		echo "</div>\n";
		echo "<div class=\"itemscontent\">\n";
			include "./tpl/content.tpl";
		echo "</div>\n";
		echo "</div>\n";
	endwhile;
endif;
?>
</div><!-- end content2 -->