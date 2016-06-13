<?php
	// pokud je určeno id článku, tak se zobrazí detail článku
	$mtid = $_GET["mtid"];
	if ($mtid):
		include "tpl/content/photo.tpl";
	else:
		// určení hlavních zpráv
		$datcheck = date("Y-m-d", time());
		$dotazmt = "SELECT mt.id AS mtid, mt.menuid, mt.titulek, mt.thumbimg, mt.titlethumbimg, mt.cssthumbimg, mt.caszapisu, mt.idautor, me.id, me.filename, au.nick, au.email FROM mastertxt AS mt, menu AS me, autor AS au WHERE mt.switchoff=0 AND mt.publish=1 AND mt.menuid=me.id AND mt.idautor=au.id AND mt.menuid=".$menu["id"]." AND mt.datum1<='$datcheck' AND mt.datum2>='$datcheck' ORDER BY mt.caszapisu DESC";
		$resultmt = mysql_query("$dotazmt");
		if (!$resultmt):
			die("Nepodařilo se určit hlavní zprávy - maininfo!");
		else:
			if (mysql_num_rows($resultmt)):
				echo "<div>\n";
				while ($recordmt=mysql_fetch_array($resultmt)):
					$mtid = $recordmt["mtid"];
					// titulek, autor a čas zápisu
					echo "<h4>";
					echo $recordmt["titulek"];
					echo "</h4>\n";
					echo "<p>Zapsal: ";
					if ($recordmt["email"]):
						echo "<a href=\"mailto:".$recordmt["email"]."\" title=\"Napište autorovi\">";
					endif;
					echo $recordmt["nick"];
					if ($recordmt["email"]):
						echo "</a>";
					endif;
					echo "</p>\n";
					// generování časového údaje
					$ppcas = GetIntTime($recordmt["caszapisu"]);
					$datumcas = date("d.m.Y v H:i",$ppcas);
					echo "<p>Zapsáno: ".$datumcas."</p>\n";
					// načtení obsahu
					$mtid = $recordmt["mtid"];
					$dotazct = "SELECT * FROM content AS ct, tablename AS tn WHERE ct.switchoff=0 AND ct.mtid=$mtid AND ct.idtbl=tn.id ORDER BY pozice";
					$resultct = mysql_query("$dotazct");
					if (!$resultct):
						die("Nepodařilo se načíst obsah!");
					else:
						$poz = 0; // proměnná pro určení pozice snímku
						while ($recordct=mysql_fetch_array($resultct)):
							$record = TblHandler($recordct["contid"],$recordct["tblname"]);
							if ($recordct["typ"] == "txt"):
							 	echo "<div";
							 	if ($record["cssstyl"]):
							 		echo " class=\"".$record["cssstyl"]."\"";
							 	endif;
							 	echo ">\n";
								if ($record["txt"]):
									echo $record["txt"];
								endif;
							 	echo "</div>\n";
							elseif ($recordct["typ"] == "tbl"):
								$dotazsel = "SELECT ".$record["sloupce"]." FROM ".$record["tblname"]." ORDER BY ".$record["poleraz"];
								// výběr z tabulky
								$resultsel = mysql_query("$dotazsel");
								if (!$resultsel):
									die("Nezdařil se výběr z tabulky - maininfo.tpl!");
								endif;
								$sloupce = explode(",",$record["sloupce"]);
								$nazsloupce = explode(",",$record["nazsloupce"]);
								$pocsl = count($sloupce);
								if ($record["tabulka"]):
									echo "<table>\n";
									echo "<tr>\n";
									for ($i=0;$i<$pocsl;$i++):
										echo "<th>".$nazsloupce[$i]."</th>\n";
									endfor;
									echo "</tr>\n";
								endif;
								while ($recordsel = mysql_fetch_array($resultsel)):
									if ($record["tabulka"]):
										echo "<tr>\n";
									else:
										echo "<div>\n";
									endif;
									for ($i=0;$i<$pocsl;$i++):
										$nazsl = trim($nazsloupce[$i]);
										$hodnsl = $recordsel[$i];
										if ($record["tabulka"]):
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
									if ($record["tabulka"]):
										echo "</tr>\n";
									else:
										echo "</div>\n";
									endif;
								endwhile;
								if ($record["tabulka"]):
									echo "</table>\n";
								endif;
							elseif ($recordct["typ"] == "lst"):
								echo "<".$record["styl"];
								if ($record["itemstyl"]):
									echo " class=\"".$record["itemstyl"]."\"";
								endif;
								echo ">";
								$items = Explode("\n",$record["txt"]);
								for ($i=0; $i<Count($items);$i++):
									echo "<li";
									if ($record["cssstyl"]):
										echo " class=\"".$record["cssstyl"]."\"";
									endif;
									echo ">";
									echo $items[$i];
									echo "</li>\n";
								endfor;
								echo "</".$record["styl"].">\n";
							elseif ($recordct["typ"] == "img"):
								$itemid = $recordct[0]; // sloupec id z tabulky content
								echo "<div>\n";
								echo "<h5><a href=\"page.php?fp=$fp&amp;mtid=$mtid&amp;itemid=$itemid&amp;pozice=$poz".($_SESSION["userid"] ? "&amp;".SID : "")."\">".$record["nazev"]."</a></h5>\n";
								echo "<div>Datum: <strong>";
							 	if ($record["datum"]!="0000-00-00"):
							 		echo ereg_replace("([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})","\\3.\\2.\\1",$record["datum"]);
							 	else:
							 		echo "neznámé";
							 	endif;
								echo "</strong></div>\n";
								echo "<div>Autor: <strong>";
								if ($record["idautor"]):
									$dotazaut = "SELECT * FROM autor WHERE id=".$record["idautor"];
									$resultaut = mysql_query("$dotazaut");
									if (!$resultaut):
										die("Nepodařilo se vybrat autora snímku fotogalerie - maininfo.tpl");
									else:
										$recordaut = mysql_fetch_array($resultaut);
									endif;
									echo $recordaut["jmeno"]." ".$recordaut["prijmeni"];
								else:
									echo "neznámý";					
								endif;
								echo "</strong></div>\n";
								echo "</div>\n";
								++$poz;
							elseif ($recordct["typ"] == "lnk"):
								echo "<".$record["styl"];
								echo ">\n";
								if ($record["addrlnk"]):
									$urlpath = (strpos($record["addrlnk"],"http://") == 0 ? $record["addrlnk"] : "http://".$record["addrlnk"]);
									echo "<a href=\"".$urlpath."\"";
									$cssurl = ($record["typlnk"] == "e" ? " class=\"extlink\"" : ($record["typlnk"] == "s" ? " class=\"downlink\"" : ""));
									echo $cssurl.">";
								endif;
								echo $record["txt"];
								if ($record["addrlnk"]):
									echo "</a>";
								endif;
								echo "</".$record["styl"].">\n";
							elseif ($recordct["typ"] == "scr"):
								include $record["umisteni"];
							elseif ($recordct["typ"] == "cst"):
								$usercst = HasUserCst($_SESSION["userid"],$record["id"]);
								echo "<h5>".$record["otazka"]."</h5>\n";
								echo "<ul>\n";
								$i = 1;
								while ($record["odp".$i]):
									echo "<li class=\"answer\">";
									if (!$usercst):
										echo "<a href=\"scripts/odpoved.php?fp=$fp&amp;idcst=".$record["id"]."&amp;odp=$i".($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"odpovědět\">";
									endif;
									echo $record["odp".$i];
									if (!$usercst):
										echo "</a>\n";
									endif;
									echo "</li>\n";
									++$i;
								endwhile;
								echo "</ul>\n";
							elseif ($recordct["typ"] == "per"):
								$dotazsel = GetSelPersQuery($record);
								// výběr z tabulky osoba
								$resultsel = mysql_query("$dotazsel");
								if (!$resultsel):
									die("Nezdařil se výběr z tabulky osobních údajů - content.tpl!");
								endif;
								$pocsl = mysql_num_fields($resultsel);
								if ($record["tabulka"]):
									echo "<table>\n";
									echo "<tr>\n";
									echo "<th>Jméno a příjmení</th>";
									for ($i=4;$i<$pocsl;$i++):
										if (mysql_field_name($resultsel,$i) != "nazev_strany"):
											echo "<th>".GetCzechFieldName(mysql_field_name($resultsel,$i))."</th>\n";
										endif;
									endfor;
									echo "</tr>\n";
								endif;
								while ($recordsel = mysql_fetch_array($resultsel)):
									if ($record["tabulka"]):
										echo "<tr>\n";
										$jmenoprij = "";
										$jmenoprij = "";
										$jmenoprij .= ($jmenoprij ? " " : "").$recordsel["prijmeni"];
										$jmenoprij .= ($jmenoprij ? " " : "").$recordsel["jmeno"];
										$jmenoprij .= ($recordsel["titulpred"] ? ", ".$recordsel["titulpred"] : "");
										$jmenoprij .= ($recordsel["titulza"] ? ", ".$recordsel["titulza"] : "");
										echo "<td>".$jmenoprij."</td>";
										for ($i=4;$i<$pocsl;$i++):
											$nazsl = mysql_field_name($resultsel,$i);
											if (mysql_field_name($resultsel,$i) != "nazev_strany"):
												$hodnsl = $recordsel[$i];
												echo "<td class=\"textcenter\">";
												if ($nazsl != "img"):
													if (($nazsl == "email1" || $nazsl == "email2") && $hodnsl):
														echo "<a href=\"mailto:".$hodnsl."\" title=\"e-mailová adresa\">";
													endif;
													echo $hodnsl;
													if (($nazsl == "email1" || $nazsl == "email2") && $hodnsl):
														echo "</a>";
													endif;
												else:
													echo "obr.";
												endif;
												echo "</td>\n";
											endif;
										endfor;
										echo "</tr>\n";
									else:
										echo "<div>\n";
										echo "<strong>".($recordsel["titulpred"] ? $recordsel["titulpred"]." " : "").$recordsel["jmeno"]." ".$recordsel["prijmeni"].($recordsel["titulza"] ? ", ".$recordsel["titulza"] : "")."</strong><em>";
										if ($recordsel["prac_zarazeni"]):
											echo ", ".($recordsel["prac_zarazeni"]);
										elseif ($recordsel["nazev_funkce_zast"]):
											echo ", ".($recordsel["nazev_funkce_zast"]);
										elseif ($recordsel["nazev_funkce_rada"]):
											echo ", ".($recordsel["nazev_funkce_rada"]);
										elseif ($recordsel["nazev_funkce_rada"]):
											echo ", ".($recordsel["nazev_funkce_rada"]);
										elseif ($recordsel["nazev_funkce_vybor"]):
											echo ", ".($recordsel["nazev_funkce_vybor"]);
										elseif ($recordsel["nazev_funkce_komise"]):
											echo ", ".($recordsel["nazev_funkce_komise"]);
										endif;
										if ($recordsel["nazev_strany"]):
											echo ", (".($recordsel["zkratka"]).")";
										endif;
										echo "</em></div>\n";
										$radek2 = "";
										$radek2 .= ($recordsel["telefon1"] ? $recordsel["telefon1"] : "");
										$radek2 .= ($recordsel["telefon2"] ? ($recordsel["telefon1"] ? ", ".$recordsel["telefon2"] : $recordsel["telefon2"]) : "");
										$radek2 .= ($recordsel["mobil1"] ? ($radek2 ? ", " : "").$recordsel["mobil1"] : "");
										$radek2 .= ($recordsel["mobil2"] ? ($recordsel["mobil1"] ? ", ".$recordsel["mobil2"] : $recordsel["mobil2"]) : "");
										$radek2 .= ($recordsel["fax"] ? ($radek2 ? ", " : "").$recordsel["fax"] : "");
										$radek2 .= ($recordsel["email1"] ? ($radek2 ? ", " : "")."<a href=\"mailto:".$recordsel["email1"]."\" title=\"e-mailová adresa\">".$recordsel["email1"]."</a>" : "");
										$radek2 .= ($recordsel["email2"] ? ($recordsel["email1"] ? ", <a href=\"mailto:".$recordsel["email2"]."\" title=\"e-mailová adresa\">".$recordsel["email2"]."</a>" : "<a href=\"mailto:".$recordsel["email2"]."\" title=\"e-mailová adresa\">".$recordsel["email2"]."</a>") : "");
										$radek2 .= ($recordsel["icq"] ? ($radek2 ? ", " : "").$recordsel["icq"] : "");
										if ($radek2):
											echo "<div>\n";
											echo $radek2;
											echo "</div>\n";
										endif;
										$radek3 = "";
										$radek3 .= ($recordsel["nazev_odboru"] ? $recordsel["nazev_odboru"] : "");
										$radek3 .= ($recordsel["nazev_oddeleni"] ? ($radek3 ? " - ".$recordsel["nazev_oddeleni"] : $recordsel["nazev_oddeleni"]) : "");
										$radek3 .= ($recordsel["nazev_budovy"] ? ($radek3 ? ", ".$recordsel["nazev_budovy"] : $recordsel["nazev_budovy"]).($recordsel["ulice"] ? ", ".$recordsel["ulice"] : "") : "");
										$radek3 .= ($recordsel["dvere"] ? ($radek3 ? ", č. dveří ".$recordsel["dvere"] : "č. dveří ".$recordsel["nazev_oddeleni"]) : "");
										if ($radek3):
											echo "<div>\n";
											echo $radek3;
											echo "</div>\n";
										endif;
										echo "<hr />\n";
									endif;
								endwhile;
								if ($record["tabulka"]):
									echo "</table>\n";
								endif;
							endif;
						endwhile;
					endif;
					echo "<hr />\n";
				endwhile;
				echo "</div>\n";
			endif;
		endif;
	endif;
?>
