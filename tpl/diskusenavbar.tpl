<?php
	// vytvoření navigačního řádku
	echo "<div id=\"navbarbox\">\n";
	echo "<div class=\"pack\">\n";
	echo "<div class=\"margin\">\n";
	echo "<a href=\"diskuse.php?".($_SESSION["userid"] ? SID : "")."\">přehled témat</a>";
	if ($idtop):
		echo " &bull; <a href=\"diskuse.php?idtema=$idtema".($_SESSION["userid"] ? "&amp;".SID : "")."\">".$recordtema["nazev"]."</a>\n";
	endif;
	echo "</div>\n";
	echo "</div>\n";
	echo "</div><!-- end navbarbox -->\n";
?>
