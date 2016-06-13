<?php
	// záhlaví
	$mtid = $record["id"];
	// načtení obsahu článků
	$dotazct = "SELECT ct.id AS ctid, ct.idtbl, ct.mtid, ct.contid, ct.pozice, ct.uprava, ct.switchoff, tn.id AS tnid, tn.tblname, tn.typ FROM content AS ct, tablename AS tn WHERE ct.mtid=$mtid AND ct.idtbl=tn.id ORDER BY pozice";
	$resultct = mysql_query("$dotazct");
	if (!$resultct):
		die("Nepodařilo se načíst obsah z tabulky text - content!");
	else:
		while ($recordct = mysql_fetch_array($resultct)):
			$idcont = $recordct["ctid"];
			$tbl = $recordct["tblname"];
			$recordtbl = TblHandler($recordct["contid"],$recordct["tblname"]);
			$itemid = $recordtbl["id"];
		 	echo "<div class=\"itemmargin\">\n";
			if ($recordct["typ"] == "txt"):
			 	if ($recordtbl["img"]):
			 		echo "<img src=\"../img/".$recordtbl["img"]."\" alt=\"obrázek - ".$recordtbl["titleimg"]."\" title=\"".$recordtbl["titleimg"]."\" class=\"itemimg\" />\n";
			 	endif;
			 	echo "<div";
			 	if ($recordtbl["cssstyl"]):
			 		echo " class=\"".$recordtbl["cssstyl"]."\"";
		 		endif;
		 		echo ">";
		 		echo $recordtbl["txt"];
		 		echo "</div>\n";
			elseif ($recordct["typ"] == "tbl"):
				$dotazsel = "SELECT ".$recordtbl["sloupce"]." FROM ".$recordtbl["tblname"]." ORDER BY ".$recordtbl["poleraz"];
				// výběr z tabulky 
				$resultsel = mysql_query("$dotazsel");
				if (!$resultsel):
					die("Nezdařil se výběr z tabulky - content.tpl!");
				endif;
				$sloupce = explode(",",$recordtbl["sloupce"]);
				$nazsloupce = explode(",",$recordtbl["nazsloupce"]);
				$pocsl = count($sloupce);
				if ($recordtbl["tabulka"]):
					echo "<table>\n";
					echo "<tr>\n";
					for ($i=0;$i<$pocsl;$i++):
						echo "<th>".$nazsloupce[$i]."</th>\n";
					endfor;
					echo "</tr>\n";
				endif;
				while ($recordsel = mysql_fetch_array($resultsel)):
					if ($recordtbl["tabulka"]):
						echo "<tr>\n";
					endif;
					for ($i=0;$i<$pocsl;$i++):
						$nazsl = $nazsloupce[$i];
						$hodnsl = $recordsel[$i];
						if ($recordtbl["tabulka"]):
							echo "<td>";
							if ($nazsl != "img"):
								echo $hodnsl;
							else:
								echo "obr.";
							endif;
							echo "</td>\n";
						else:
							if ($hodnsl):
								echo "<div><strong>$nazsl:</strong> ";
								if ($nazsl != "img"):
									echo $hodnsl;
								else:
									echo "<img src=\"../img/$hodnsl\" alt=\"obrázek\" />";
								endif;
								echo "</div>\n";
							endif;
						endif;
					endfor;
					if ($recordtbl["tabulka"]):
						echo "</tr>\n";
					endif;
				endwhile;
				if ($recordtbl["tabulka"]):
					echo "</table>\n";
				endif;
			elseif ($recordct["typ"] == "lst"):
			 	echo "<".$recordtbl["styl"];
			 	if ($recordtbl["itemstyl"]):
			 		echo " class=\"".$recordtbl["itemstyl"]."\"";
		 		endif;
		 		echo ">";
				$items = explode("\n",$recordtbl["txt"]);
				for ($i=0; $i<Count($items);$i++):
					echo "<li";
				 	if ($recordtbl["cssstyl"]):
				 		echo " class=\"".$recordtbl["cssstyl"]."\"";
		 			endif;
					echo ">";
			 		echo $items[$i];
					echo "</li>\n";
				endfor;
		 		echo "</".$recordtbl["styl"].">\n";
			elseif ($recordct["typ"] == "img"):
				echo "<p>Název obrázku: <strong>".$recordtbl["nazev"]."</strong></p>\n";
				echo "<p>Datum pořízení: <strong>";
			 	if ($recordtbl["datum"]!="0000-00-00"):
			 		echo ereg_replace("([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})","\\3.\\2.\\1",$recordtbl["datum"]);
			 	else:
			 		echo "neznámé";
			 	endif;
				echo "</strong></p>\n";
				echo "<img src=\"../img/".$recordtbl["nahled"]."\" alt=\"obrázek - ".$recordtbl["nazev"]."\" title=\"".$recordtbl["nazev"]."\" class=\"itemimg\" />\n";
			 	if ($recordtbl["popis"]):
			 		echo "<p>".$recordtbl["popis"]."</p>\n";
			 	endif;
				echo "<p>Jméno autora: <strong>";
				if ($recordtbl["idautor"] && ($recordtbl["idautor"] != 999)):
					$dotazaut = "SELECT * FROM autor WHERE id=".$recordtbl["idautor"];
					$resultaut = mysql_query("$dotazaut");
					if (!$resultaut):
						die("Nepodařilo se vybrat autora snímku fotogalerie - content.tpl");
					else:
						$recordaut = mysql_fetch_array($resultaut);
					endif;
					echo $recordaut["jmeno"]." ".$recordaut["prijmeni"];
				else:
					echo "neznámé";					
				endif;
				echo "</strong></p>\n";
			elseif ($recordct["typ"] == "lnk"):
			 	echo "<".$recordtbl["styl"];
			 	if ($recordtbl["cssstyl"]):
			 		echo " class=\"".$recordtbl["cssstyl"]."\"";
		 		endif;
		 		echo ">\n";
			 	if ($recordtbl["addrlnk"]):
					$urlpath = (strpos($recordtbl["addrlnk"],"http://") == 0 ? $recordtbl["addrlnk"] : "http://".$recordtbl["addrlnk"]);
			 		echo "<a href=\"".$urlpath."\"";
					$cssurl = ($recordtbl["typlnk"] == "e" ? " class=\"extlink\"" : ($recordtbl["typlnk"] == "s" ? " class=\"downlink\"" : ""));
					echo $cssurl.">";
		 		endif;
		 		echo $recordtbl["txt"];
			 	if ($recordtbl["addrlnk"]):
					echo "</a>";
				endif;
		 		echo "</".$recordtbl["styl"].">\n";
			elseif ($recordct["typ"] == "scr"):
				echo "<div>PHP skript: <strong>".$recordtbl["nazev"]."</strong></div>\n";
				echo "<div>Umístění skriptu: ".$recordtbl["umisteni"]."</div>\n";
			elseif ($recordct["typ"] == "cst"):
				echo "<div><strong>".$recordtbl["otazka"]."</strong></div>\n";
			 	if ($recordtbl["img"]):
			 		echo "<img src=\"../img/".$recordtbl["img"]."\" alt=\"soutěžní obrázek\" title=\"soutěžní obrázek\" />\n";
			 	endif;
				$i = 1;
				echo "<ul>\n";
				while ($recordtbl["odp".$i]):
					echo "<li>".$recordtbl["odp".$i].($recordtbl["spravne"] == $i ? " &laquo;" : "")."</li>\n";
					++$i;
				endwhile;
				echo "</ul>\n";
			elseif ($recordct["typ"] == "per"):
				$dotazsel = GetSelPersQuery($recordtbl);
				// výběr z tabulky osoba
				$resultsel = mysql_query("$dotazsel");
				if (!$resultsel):
					die("Nezdařil se výběr z tabulky osobních údajů - content.tpl!");
				endif;
				$pocsl = mysql_num_fields($resultsel);
				if ($recordtbl["tabulka"]):
					echo "<table>\n";
					echo "<tr>\n";
					for ($i=0;$i<$pocsl;$i++):
						echo "<th>".mysql_field_name($resultsel,$i)."</th>\n";
					endfor;
					echo "</tr>\n";
				endif;
				while ($recordsel = mysql_fetch_array($resultsel)):
					if ($recordtbl["tabulka"]):
						echo "<tr>\n";
					endif;
					for ($i=0;$i<$pocsl;$i++):
						$nazsl = mysql_field_name($resultsel,$i);
						$hodnsl = $recordsel[$i];
						if ($recordtbl["tabulka"]):
							echo "<td>";
							if ($nazsl != "img"):
								echo $hodnsl;
							else:
								echo "obr.";
							endif;
							echo "</td>\n";
						else:
							if ($hodnsl):
								echo "<div><strong>$nazsl:</strong> ";
								if ($nazsl != "img"):
									echo $hodnsl;
								else:
									echo "<img src=\"../img/$hodnsl\" alt=\"obrázek\" />";
								endif;
								echo "</div>\n";
							endif;
						endif;
					endfor;
					if ($recordtbl["tabulka"]):
						echo "</tr>\n";
					endif;
				endwhile;
				if ($recordtbl["tabulka"]):
					echo "</table>\n";
				endif;
			endif;
			echo "<div>".($recordct["switchoff"] ? "<a href=\"./switch.php?tbl=content&amp;sw=0&amp;itemid=$idcont\" class=\"imglink\"><img src=\"./img/switchoff.gif\" alt=\"obr vypnuto\" title=\"vypnuto - zapnout kliknutím \" height=\"15\" width=\"15\" /></a>\n" : "<a href=\"./switch.php?tbl=content&amp;sw=1&amp;menuid=$menuid&amp;itemid=$idcont\" class=\"imglink\"><img src=\"./img/switchon.gif\" alt=\"obr zapnuto\" title=\"zapnuto - vypnout kliknutím\" height=\"15\" width=\"15\" /></a>\n");
			echo "<a href=\"./edit.php?tbl=$tbl&amp;akce=edit&amp;mtid=$mtid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/edit.gif\" alt=\"obr upravit\" title=\"upravit obsah\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./delete.php?tbl=$tbl&amp;mtid=$mtid&amp;itemid=$itemid\" class=\"imglink\"><img src=\"./img/delete.gif\" alt=\"obr smazat\" title=\"smazat obsah\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./changetbl.php?akce=up&amp;tbl=content&amp;mtid=$mtid&amp;itemid=$idcont\" class=\"imglink\"><img src=\"./img/moveup.gif\" alt=\"obr posunout nahoru\" title=\"posunout obsah nahoru\" height=\"15\" width=\"15\" /></a>\n";
			echo "<a href=\"./changetbl.php?akce=down&amp;tbl=content&amp;mtid=$mtid&amp;itemid=$idcont\" class=\"imglink\"><img src=\"./img/movedown.gif\" alt=\"obr posunout dolů\" title=\"posunout obsah dolů\" height=\"15\" width=\"15\" /></a>\n";
		 	echo "</div></div>\n";
		endwhile;
		echo "<div class=\"contentcontrol\">\n";
		// vytvoření tlačítek
		$dotaztn = "SELECT * FROM tablename WHERE imported=0";
		$resulttn = mysql_query("$dotaztn");
		if (!$resulttn):
			die("Totální nezdar při výběru dat z tabulky tablename - content.tpl!");
		else:
			while ($recordtn = mysql_fetch_array($resulttn)):
				echo "<a href=\"./edit.php?menuid=$menuid&amp;mtid=$mtid&amp;akce=add&amp;tbl=".$recordtn["tblname"]."&amp;tbltyp=".$recordtn["typ"]."\" class=\"button\">přidat&nbsp;".$recordtn["titulek"]."</a>\n";
			endwhile;
		endif;
		echo "</div>\n";
	endif;
?>