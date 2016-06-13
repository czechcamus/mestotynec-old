<?php
	echo "<div>\n";
	echo "<a href=\"diskuse.php?".($_SESSION["userid"] ? SID : "")."\">přehled témat</a>";
	if ($idtop):
		echo " &bull; <a href=\"diskuse.php?idtema=$idtema".($_SESSION["userid"] ? "&amp;".SID : "")."\">".$recordtema["nazev"]."</a>\n";
	endif;
	echo "</div><!-- end navbarbox -->\n";
?>
