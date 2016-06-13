<?php
	// určení aktualit
	$dotazmt = "SELECT mt.id AS mtid, mt.titulek, mt.caszapisu, mt.menuid, mt.aktualinfo, mt.typinfoid, mt.perex, me.id, me.filename, ti.id, ti.cssname FROM mastertxt AS mt, menu AS me, typinfo AS ti WHERE mt.switchoff=0 AND mt.publish=1 AND mt.aktualinfo=1 AND mt.menuid=me.id AND mt.typinfoid=ti.id GROUP BY aj.mtid ORDER BY mt.caszapisu DESC LIMIT 0,$aktualcnt";
	$resultmt = mysql_query("$dotazmt");
	if (!$resultmt):
		die("Nepodařilo se určit aktuality - aktuality.tpl!");
	else:
		if (mysql_num_rows($resultmt)):
			echo "<h3>Aktuality</h3>\n";
			echo "<div>\n";
			while ($recordmt=mysql_fetch_array($resultmt)):
				echo "<div>\n";
				// generování časového údaje
				$ppcas = GetIntTime($recordmt["caszapisu"]);
				$datumcas = date("d.m.Y v H:i",$ppcas);
				echo "<div class=\"greynote\">".$datumcas."</div>\n";
				echo "<h4><a href=\"page.php?fp=".$recordmt["filename"].($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"podrobnosti\">";
				echo $recordmt["titulek"];
				echo "</a></h4>\n";
				// perex
				echo "<p>";
				if (strlen($recordmt["perex"])>80):
					echo utf8_substr($recordmt["perex"],0,80)."...";
				else:
					echo $recordmt["perex"];
				endif;
				echo "</p>\n";
				echo "</div>\n";
			endwhile;
			echo "<hr />\n";
			echo "</div>\n";
		endif;
	endif;	
?>
