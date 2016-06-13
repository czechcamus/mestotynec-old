<?php
	// vytvoří soubor
	$fp = FOpen("deletefile.php","w");
	FPutS($fp, "<?php\n");
	FPutS($fp, "\$fn = \$_GET[\"fn\"];\n");
	FPutS($fp, "if (\$fn):\n");
	FPutS($fp, "\$lastchr = strrchr(\$fn,\"/\");\n");
	FPutS($fp, "\$df = (\$lastchr == \"/\" ? rmdir(\"../\".\$fn) : unlink(\"../\".\$fn));\n");
	FPutS($fp, "endif;\n");
	FPutS($fp, "if (!\$fn):\n");
	FPutS($fp, "?>\n");
	FPutS($fp, "<form action=\"deletefile.php\" method=\"get\">\n");
	FPutS($fp, "<input type=\"text\" name=\"fn\" />\n");
	FPutS($fp, "<input type=\"submit\" name=\"smazat\" />\n");
	FPutS($fp, "</form>\n");
	FPutS($fp, "<?php else:\n");
	FPutS($fp, "if (\$df): ?>\n");
	FPutS($fp, "<h3>Soubor byl uspesne vymazan</h3>\n");
	FPutS($fp, "<?php else: ?>\n");
	FPutS($fp, "<h3>Vymaz se nepovedl</h3>\n");
	FPutS($fp, "<?php endif; ?>\n");
	FPutS($fp, "<form action=\"deletefile.php\" method=\"get\">\n");
	FPutS($fp, "<input type=\"submit\" name=\"ok\" value=\"ok\" />\n");
	FPutS($fp, "</form>\n");
	FPutS($fp, "<?php endif; ?>\n");
	FClose($fp);
?>
