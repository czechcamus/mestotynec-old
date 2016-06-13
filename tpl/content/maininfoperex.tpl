<?php
	// určení hlavních zpráv
	$datcheck = date("Y-m-d", time());
	if ($fp == "index.php"):
		$dotazmt = "SELECT mt.id AS mtid, mt.menuid, mt.titulek, mt.thumbimg, mt.titlethumbimg, mt.cssthumbimg, mt.caszapisu, mt.perex, mt.maininfo, me.id, me.filename FROM mastertxt AS mt, menu AS me WHERE mt.switchoff=0 AND mt.publish=1 AND mt.menuid=me.id AND mt.perexhp=1 AND mt.maininfo=1 AND mt.datum1<='$datcheck' AND mt.datum2>='$datcheck' ORDER BY mt.datum1 DESC LIMIT 0,$perexhpcnt";
	else:
		$dotazmt = "SELECT mt.id AS mtid, mt.menuid, mt.titulek, mt.thumbimg, mt.titlethumbimg, mt.cssthumbimg, mt.caszapisu, mt.perex, mt.maininfo, me.id, me.filename FROM mastertxt AS mt, menu AS me WHERE mt.switchoff=0 AND mt.publish=1 AND mt.menuid=me.id AND mt.perexmid=".$menu["id"]." AND mt.maininfo=1 AND mt.datum1<='$datcheck' AND mt.datum2>='$datcheck' ORDER BY mt.datum1 DESC LIMIT 0,$perexcnt";
	endif;	
	$resultmt = mysql_query("$dotazmt");
	if (!$resultmt):
		die("Nepodařilo se určit hlavní zprávy - maininfoperex!");
	else:
		if (mysql_num_rows($resultmt)):
			while ($recordmt=mysql_fetch_array($resultmt)):
				echo "<div class=\"hpmaininfobox\">\n";
				echo "<div class=\"pack\">\n";
				echo "<div class=\"".($recordmt["thumbimg"] ? "margin2" : "margin")."\">\n";
				// titulek, náhledový obrázek a čas zápisu
				echo "<h4>";
				if ($recordmt["thumbimg"]):
					list($width, $height, $type, $attr) = getimagesize("img/".$recordmt["thumbimg"]);
					echo "<a href=\"page.php?fp=".$recordmt["filename"].($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"".$recordmt["titulek"]."\">";
					echo "<img src=\"img/".$recordmt["thumbimg"]."\" ".$attr." alt=\"Obrázek - ".$recordmt["titlethumbimg"]."\"";
					if ($recordmt["cssthumbimg"]):
						echo " class=\"".$recordmt["cssthumbimg"]."\"";
					endif;
					echo " />";
					echo "</a>\n";
				endif;
				echo "<a href=\"page.php?fp=".$recordmt["filename"].($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"".$recordmt["titulek"]."\">";
				echo $recordmt["titulek"];
				echo "</a>";
				echo "</h4>\n";
				// generování časového údaje
				$ppcas = GetIntTime($recordmt["caszapisu"]);
				$datumcas = date("d.m.Y v H:i",$ppcas);
				echo "<p class=\"greynote\">Zapsáno ".$datumcas."</p>\n";
				// perex
				echo "<p>";
				if (strlen($recordmt["perex"])>250):
					echo utf8_substr($recordmt["perex"],0,250)."...";
				else:
					echo $recordmt["perex"];
				endif;
				echo "</p>\n";
				echo "<div class=\"control\"><span class=\"rightarrowlink\"><a href=\"page.php?fp=".$recordmt["filename"].($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"".$recordmt["titulek"]."\">podrobnosti</a></span></div>\n";
				echo "<hr class=\"rightclear\" />\n";
				echo "</div>\n";
				echo "</div>\n";
				echo "</div><!-- end maininfobox -->\n";
			endwhile;
		endif;
	endif;	
?>
