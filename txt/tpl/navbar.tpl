<?php
	// vytvoření navigačního řádku
	if ($menu["titulek"]):
		echo "<div><h3>\n";
		$menubar = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$menu["titulek"]); // titulek položky menu
		$mp = $menu["id"]; // číslo položky menu
		while ($mp):
			$dotaz = "SELECT * FROM menu WHERE id=$mp AND switchoff=0";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nepodařilo se určit položku menu!");
			else:
				$record = mysql_fetch_array($result);
				$mp = $record["idtop"];
				if ($menu["titulek"] != $record["titulek"]):
					$mt = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record["titulek"]); // titulek položky menu
					$menubar = "<a href=\"page.php?fp=".$record["filename"].($_SESSION["userid"] ? "&amp;".SID : "")."\">".$mt."</a> &bull; ".$menubar;
				endif;
			endif;
		endwhile;
		echo $menubar;
		echo "</h3>\n";
		echo "</div>\n";
	endif;
?>
