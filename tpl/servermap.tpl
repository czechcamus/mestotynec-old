<div id="contentbar">
<?php
	echo "<div class=\"articlebox\">\n";
	echo "<h2>Mapa serveru</h2>\n";
	// výběr položek menu nejvyšší úrovně
	$dotaz0 = "SELECT * FROM menu WHERE level=0 AND switchoff=0 ORDER BY pozice";
	$result0 = mysql_query("$dotaz0");
	if (!$result0):
		die("Nepodařilo se vybrat záznamy z tabulky menu urovne 0 - servermap.tpl!");
	else:
		while ($record0 = mysql_fetch_array($result0)):
			echo "<div class=\"indent level1\">\n";
			$idtop0 = $record0["id"];
			$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record0["titulek"]); // titulek položky menu
			echo "<a href=\"".(strstr($record0["filename"],".php") ? $record0["filename"] : "page.php?fp=".$record0["filename"])."\" title=\"".$record0["obsah"]."\">".$titulek."</a>\n";
			echo "</div>\n";
			// výběr položek menu úrovně 1
			$dotaz1 = "SELECT * FROM menu WHERE idtop=$idtop0 AND switchoff=0 ORDER BY pozice";
			$result1 = mysql_query("$dotaz1");
			if (!$result1):
				die("Nepodařilo se vybrat záznamy z tabulky menu urovne 1 - servermap.tpl!");
			else:
				while ($record1 = mysql_fetch_array($result1)):
					echo "<div class=\"indent\"><div class=\"indent level2\">\n";
					$idtop1 = $record1["id"];
					$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record1["titulek"]); // titulek položky menu
					echo "<a href=\"".(strstr($record1["filename"],".php") ? $record1["filename"] : "page.php?fp=".$record1["filename"])."\" title=\"".$record1["obsah"]."\">".$titulek."</a>\n";
					echo "</div></div>\n";			
					// výběr položek menu úrovně 2
					$dotaz2 = "SELECT * FROM menu WHERE idtop=$idtop1 AND switchoff=0 ORDER BY pozice";
					$result2 = mysql_query("$dotaz2");
					if (!$result2):
						die("Nepodařilo se vybrat záznamy z tabulky menu urovne 2 - servermap.tpl!");
					else:
						while ($record2 = mysql_fetch_array($result2)):
							echo "<div class=\"indent\"><div class=\"indent\"><div class=\"indent level3\">\n";
							$idtop2 = $record2["id"];
							$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record2["titulek"]); // titulek položky menu
							echo "<a href=\"".(strstr($record2["filename"],".php") ? $record2["filename"] : "page.php?fp=".$record2["filename"])."\" title=\"".$record2["obsah"]."\">".$titulek."</a>\n";
							echo "</div></div></div>\n";
							// výběr položek menu úrovně 3
							$dotaz3 = "SELECT * FROM menu WHERE idtop=$idtop2 AND switchoff=0 ORDER BY pozice";
							$result3 = mysql_query("$dotaz3");
							if (!$result3):
								die("Nepodařilo se vybrat záznamy z tabulky menu urovne 3 - servermap.tpl!");
							else:
								while ($record3 = mysql_fetch_array($result3)):
									echo "<div class=\"indent\"><div class=\"indent\"><div class=\"indent\"><div class=\"indent level4\">\n";
									$idtop3 = $record3["id"];
									$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record3["titulek"]); // titulek položky menu
									echo "<a href=\"".(strstr($record3["filename"],".php") ? $record3["filename"] : "page.php?fp=".$record3["filename"])."\" title=\"".$record3["obsah"]."\">".$titulek."</a>\n";
									echo "</div></div></div></div>\n";
									// výběr položek menu úrovně 4
									$dotaz4 = "SELECT * FROM menu WHERE idtop=$idtop3 AND switchoff=0 ORDER BY pozice";
									$result4 = mysql_query("$dotaz4");
									if (!$result4):
										die("Nepodařilo se vybrat záznamy z tabulky menu urovne 4 - servermap.tpl!");
									else:
										while ($record4 = mysql_fetch_array($result4)):
											echo "<div class=\"indent\"><div class=\"indent\"><div class=\"indent\"><div class=\"indent\"><div class=\"indent level5\">\n";
											$idtop4 = $record4["id"];
											$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record4["titulek"]); // titulek položky menu
											echo "<a href=\"".(strstr($record4["filename"],".php") ? $record4["filename"] : "page.php?fp=".$record4["filename"])."\" title=\"".$record4["obsah"]."\">".$titulek."</a>\n";
											echo "</div></div></div></div></div>\n";
											// výběr položek menu úrovně 5
											$dotaz5 = "SELECT * FROM menu WHERE idtop=$idtop4 AND switchoff=0 ORDER BY pozice";
											$result5 = mysql_query("$dotaz5");
											if (!$result5):
												die("Nepodařilo se vybrat záznamy z tabulky menu urovne 5 - servermap.tpl!");
											else:
												while ($record5 = mysql_fetch_array($result5)):
													echo "<div class=\"indent\"><div class=\"indent\"><div class=\"indent\"><div class=\"indent\"><div class=\"indent\"><div class=\"indent level6\">\n";
													$titulek = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$record5["titulek"]); // titulek položky menu
													echo "<a href=\"".(strstr($record5["filename"],".php") ? $record5["filename"] : "page.php?fp=".$record5["filename"])."\" title=\"".$record5["obsah"]."\">".$titulek."</a>\n";
													echo "</div></div></div></div></div></div>\n";
												endwhile;
											endif;
										endwhile;
									endif;											
								endwhile;
							endif;							
						endwhile;
					endif;
				endwhile;
			endif;
		endwhile;
	endif;
	echo "<hr class=\"masterclear\" />\n";
	echo "</div><!-- end articlebox -->\n";
?>
</div>