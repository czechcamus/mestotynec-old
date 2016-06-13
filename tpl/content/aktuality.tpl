<div id="actualbox">
<?php
	// určení aktualit
	$datcheck = date("Y-m-d", time());
	$dotazmt = "SELECT aj.mtid, aj.menuid, mt.titulek, mt.caszapisu, DATE_FORMAT(mt.datum1,'%d.%m.%Y') AS datum1, mt.aktualinfo, mt.typinfoid, mt.perex, me.id, me.filename FROM articlejoin AS aj, mastertxt AS mt, menu AS me WHERE aj.switchoff=0 AND mt.publish=1 AND mt.maininfo=1 AND aj.menuid=me.id AND aj.mtid=mt.id AND mt.datum1<='$datcheck' AND mt.datum2>='$datcheck' GROUP BY aj.mtid ORDER BY mt.datum1 DESC LIMIT 0,$aktualcnt";		
//	$dotazmt = "SELECT mt.id AS mtid, mt.titulek, mt.caszapisu, mt.menuid, mt.aktualinfo, mt.typinfoid, mt.perex, me.id, me.filename FROM mastertxt AS mt, menu AS me WHERE mt.switchoff=0 AND mt.publish=1 AND mt.maininfo=1 AND mt.menuid=me.id ORDER BY mt.datum1 DESC LIMIT 0,$aktualcnt";
	$resultmt = mysql_query("$dotazmt");
	if (!$resultmt):
		die("Nepodařilo se určit aktuality - aktuality.tpl!");
	else:
		if (mysql_num_rows($resultmt)):
			echo "<h3>aktuality</h3>\n";
			while ($recordmt=mysql_fetch_array($resultmt)):
				echo "<div class=\"actualitem\">\n";
				// generování časového údaje
				// $ppcas = GetIntTime($recordmt["caszapisu"]);
				// $datum = date("d.m.Y",$ppcas);
				$datum = $recordmt["datum1"];
				$artid = $recordmt["mtid"];
				echo "<div class=\"datum\">".$datum."</div>\n";
				echo "<h4><a href=\"page.php?fp=".$recordmt["filename"]."&amp;artid=$artid\" title=\"detail článku - ".$recordmt["titulek"]."\">";
				echo $recordmt["titulek"];
				echo "</a></h4>\n";
				// perex
				echo "<p class=\"txt\">";
				if (strlen($recordmt["perex"])>120):
					echo utf8_substr($recordmt["perex"],0,120)."...";
				else:
					echo $recordmt["perex"];
				endif;
				echo "</p>\n";
				echo "<div class=\"details\"><a href=\"page.php?fp=".$recordmt["filename"]."&amp;artid=$artid\" title=\"detail článku - ".$recordmt["titulek"]."\">podrobnosti</a></div>\n";
				echo "</div>\n";
			endwhile;
			echo "<hr class=\"leftclear\" />\n";
		endif;
	endif;	
?>
</div><!-- end actualbox -->
