<?php
	// výběr dat ze statistické tabulky
	$dotaz = "SELECT t.ajid, t.cetnost, m.filename, mt.id, mt.titulek FROM toppages AS t, articlejoin AS aj, menu AS m, mastertxt AS mt WHERE t.ajid=aj.id AND aj.menuid=m.id AND aj.mtid=mt.id ORDER BY t.cetnost DESC LIMIT 0,5";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezdařil se výběr z tabulky toppages - toppages.tpl - $dotaz!");
	else:
		$pzaz = mysql_num_rows($result);
		if ($pzaz):
			while ($record = mysql_fetch_array($result)):
				$ai = $record["id"];
				echo "<li><a href=\"page.php?fp=".$record["filename"]."&amp;artid=$ai\">".$record["titulek"]."</a></li>\n";
			endwhile;
		endif;
	endif;
?>			
