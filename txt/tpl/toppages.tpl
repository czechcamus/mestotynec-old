<?php
	// výběr dat z tabulky toppages
	$dotaz = "SELECT t.menuid, t.cetnost, m.id, m.filename, m.titulek, m.obsah FROM toppages AS t, menu AS m WHERE t.menuid=m.id ORDER BY t.cetnost DESC LIMIT 0,5";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezdařil se výběr z tabulky toppages - toppages.tpl!");
	else:
		$pzaz = mysql_num_rows($result);
		if ($pzaz):
			echo "<div id=\"bestbox\">\n";
			echo "<h3>nejnavštěvovanější</h3>\n";
			echo "<div class=\"margin\">\n";
			echo "<ul>\n";
			while ($record = mysql_fetch_array($result)):
				$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1<span class="letterkey">\\2</span>\\3',$record["titulek"]);
				echo "<li><div><a href=\"page.php?fp=".$record["filename"].($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"".$record["obsah"]."\">".$titulek."</a></div></li>\n";
			endwhile;
			echo "</ul>\n";
			echo "</div>\n";
			echo "</div><!-- end bestbox -->\n";
			echo "<hr />\n";
		endif;
	endif;
?>			
