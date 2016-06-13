<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formselperson.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$polesel = $record["polesel"];
			$poleval = $record["poleval"];
			$poleraz = $record["poleraz"];
			$peron = ($polesel == "id" ? true : false);
			$zamon = $record["zamon"];
			$zaston = $record["zaston"];
			$radaon = $record["radaon"];
			$clvybon = $record["clvybon"];
			$clkomon = $record["clkomon"];
			$zaron = ($record["polesel"] == "idzarazeni" ? true : false);
			$oddelon = ($record["polesel"] == "idoddeleni" ? true : false);
			$odboron = ($record["polesel"] == "idodbor" ? true : false);
			$budon = ($record["polesel"] == "idbudova" ? true : false);
			$vyboron = ($record["polesel"] == "idvybor" ? true : false);
			$komiseon = ($record["polesel"] == "idkomise" ? true : false);
			$poleval = $record["poleval"];
			$selperson = ($peron ? $poleval : 0);
			$selzarazeni = ($zaron ? $poleval : 0);
			$selodbor = ($odboron ? $poleval : 0);
			$seloddel = ($oddelon ? $poleval : 0);
			$selbudova = ($budon ? $poleval : 0);
			$selkomise = ($vyboron ? $poleval : 0);
			$selvybor = ($komiseon ? $poleval : 0);
			$poleraz = $record["poleraz"];
			$pimg = $record["pimg"];
			$pidbudova = $record["pidbudova"];
			$pidodbor = $record["pidodbor"];
			$pidoddeleni = $record["pidoddeleni"];
			$pidzarazeni = $record["pidzarazeni"];
			$pdvere = $record["pdvere"];
			$pidstrana = $record["pidstrana"];
			$pidzarzast = $record["pidzarzast"];
			$pidzarrada = $record["pidzarrada"];
			$pidvybor = $record["pidvybor"];
			$pidzarvybor = $record["pidzarvybor"];
			$pidkomise = $record["pidkomise"];
			$pidzarkomise = $record["pidzarkomise"];
			$ptelefon1 = $record["ptelefon1"];
			$ptelefon2 = $record["ptelefon2"];
			$pmobil1 = $record["pmobil1"];
			$pmobil2 = $record["pmobil2"];
			$pfax = $record["pfax"];
			$picq = $record["picq"];
			$pemail1 = $record["pemail1"];
			$pemail2 = $record["pemail2"];
			$tabulka = $record["tabulka"];
		endif;
		echo "<h3>Editace výběrových kritérií pro výpis osobních údajů</h3>";
	else:
		echo "<h3>Přidání výběrových kritérií pro výpis osobních údajů</h3>";
	endif;
?>
	<form action="./changesel.php" method="post"> 
		<fieldset>
			<fieldset>
				<legend>Výběr</legend>
				<div>
				<input type="checkbox" name="peron" id="peron"<?php echo ($peron ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('peron','peronpovolene','peronnepovolene');uncheckbox('peron','peronchecked','peronunchecked');" /><label for="peron" class="noblock">konkrétní osoba?</label>
				<input type="hidden" name="peronpovolene" id="peronpovolene" value="selperson" />
				<input type="hidden" name="peronnepovolene" id="peronnepovolene" value="zamon,zaston,radaon,clvybon,clkomon" />
				<input type="hidden" name="peronchecked" id="peronchecked" value="ptelefon1,ptelefon2,pmobil1,pmobil2,pfax,picq,pemail1,pemail2" />
				<input type="hidden" name="peronunchecked" id="peronunchecked" value="zamon,zaston,radaon,clvybon,clkomon,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere,pidstrana,pidzarzast,pidzarrada,pidvybor,pidzarvybor,pidkomise,pidzarkomise" />
				<select name="selperson" id="selperson" <?php echo ($peron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM osoba ORDER BY prijmeni";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst osobní údaje - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($selperson == $record["id"] ? " selected=\"selected\"" : "").">".$record["prijmeni"]. " ".$record["jmeno"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
				<div>
				<input type="checkbox" name="zamon" id="zamon"<?php echo ($zamon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('zamon','zamonpovolene','zamonnepovolene');uncheckbox('zamon','zamonchecked','zamonunchecked');" /><label for="zamon" class="noblock">zaměstnanci?</label>
				<input type="hidden" name="zamonpovolene" id="zamonpovolene" value="zaron,odboron,oddelon,budon" />
				<input type="hidden" name="zamonnepovolene" id="zamonnepovolene" value="peron,zaston,radaon,clvybon,clkomon" />
				<input type="hidden" name="zamonchecked" id="zamonchecked" value="ptelefon1,ptelefon2,pmobil1,pmobil2,pfax,picq,pemail1,pemail2,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere" />
				<input type="hidden" name="zamonunchecked" id="zamonunchecked" value="peron,zaston,radaon,clvybon,clkomon,pidstrana,pidzarzast,pidzarrada,pidvybor,pidzarvybor,pidkomise,pidzarkomise" />
				</div>
				<div>
				<input type="checkbox" name="zaron" id="zaron"<?php echo ($zaron ? " checked=\"checked\"" : ""); echo ($zamon ? "" : " disabled=\"disabled\""); ?> onclick="switchdisable('zaron','zaronpovolene','zaronnepovolene');uncheckbox('zaron','zaronchecked','zaronunchecked');" /><label for="zaron" class="noblock">pracovní zařazení</label>
				<input type="hidden" name="zaronpovolene" id="zaronpovolene" value="selzarazeni" />
				<input type="hidden" name="zaronnepovolene" id="zaronnepovolene" value="oddelon,odboron,budon" />
				<select name="selzarazeni" id="selzarazeni" <?php echo ($zaron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM zarazeni ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst pracovní zařazení - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($selzarazeni == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
				<div>
				<input type="checkbox" name="oddelon" id="oddelon"<?php echo ($oddelon ? " checked=\"checked\"" : ""); echo ($zamon ? "" : " disabled=\"disabled\""); ?> onclick="switchdisable('oddelon','oddelonpovolene','oddelonnepovolene');uncheckbox('oddelon','oddelonchecked','oddelonunchecked');" /><label for="oddelon" class="noblock">oddělení odboru úřadu</label>
				<input type="hidden" name="oddelonpovolene" id="oddelonpovolene" value="seloddel" />
				<input type="hidden" name="oddelonnepovolene" id="oddelonnepovolene" value="zaron,odboron,budon" />
				<select name="seloddel" id="seloddel" <?php echo ($oddelon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM oddeleni ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst oddělení odborů úřadu - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($seloddel == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
				<div>
				<input type="checkbox" name="odboron" id="odboron"<?php echo ($odboron ? " checked=\"checked\"" : ""); echo ($zamon ? "" : " disabled=\"disabled\""); ?> onclick="switchdisable('odboron','odboronpovolene','odboronnepovolene');uncheckbox('odboron','odboronchecked','odboronunchecked');" /><label for="odboron" class="noblock">odbor úřadu</label>
				<input type="hidden" name="odboronpovolene" id="odboronpovolene" value="selodbor" />
				<input type="hidden" name="odboronnepovolene" id="odboronnepovolene" value="zaron,oddelon,budon" />
				<select name="selodbor" id="selodbor" <?php echo ($odboron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM odbor ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst odbory úřadu - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($selodbor == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
				<div>
				<input type="checkbox" name="budon" id="budon"<?php echo ($budon ? " checked=\"checked\"" : ""); echo ($zamon ? "" : " disabled=\"disabled\""); ?> onclick="switchdisable('budon','budonpovolene','budonnepovolene');uncheckbox('budon','budonchecked','budonunchecked');" /><label for="budon" class="noblock">budova</label>
				<input type="hidden" name="budonpovolene" id="budonpovolene" value="selbudova" />
				<input type="hidden" name="budonnepovolene" id="budonnepovolene" value="zaron,oddelon,odboron" />
				<select name="selbudova" id="selbudova" <?php echo ($budon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM budova ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst budovy - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($selbudova == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
				<div>
				<input type="checkbox" name="zaston" id="zaston"<?php echo ($zaston ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('zaston','zastonpovolene','zastonnepovolene');uncheckbox('zaston','zastonchecked','zastonunchecked');" /><label for="zaston" class="noblock">zastupitelé?</label>
				<input type="hidden" name="zastonpovolene" id="zastonpovolene" value="" />
				<input type="hidden" name="zastonnepovolene" id="zastonnepovolene" value="peron,zamon,radaon,clvybon,clkomon" />
				<input type="hidden" name="zastonchecked" id="zastonchecked" value="pidstrana,pidzarzast" />
				<input type="hidden" name="zastonunchecked" id="zastonunchecked" value="peron,zamon,radaon,clvybon,clkomon,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere,pidzarrada,pidvybor,pidzarvybor,pidkomise,pidzarkomise" />
				</div>
				<div>
				<input type="checkbox" name="radaon" id="radaon"<?php echo ($radaon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('radaon','radaonpovolene','radaonnepovolene');uncheckbox('radaon','radaonchecked','radaonunchecked');" /><label for="radaon" class="noblock">radní?</label>
				<input type="hidden" name="radaonpovolene" id="radaonpovolene" value="" />
				<input type="hidden" name="radaonnepovolene" id="radaonnepovolene" value="peron,zaston,zamon,clvybon,clkomon" />
				<input type="hidden" name="radaonchecked" id="radaonchecked" value="pidzarrada" />
				<input type="hidden" name="radaonunchecked" id="radaonunchecked" value="peron,zamon,zaston,clvybon,clkomon,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere,pidzarzast,pidvybor,pidzarvybor,pidkomise,pidzarkomise" />
				</div>
				<div>
				<input type="checkbox" name="clvybon" id="clvybon"<?php echo ($clvybon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('clvybon','clvybonpovolene','clvybonnepovolene');uncheckbox('clvybon','clvybonchecked','clvybonunchecked');" /><label for="clvybon" class="noblock">členové výborů zastupitelstva?</label>
				<input type="hidden" name="clvybonpovolene" id="clvybonpovolene" value="vyboron" />
				<input type="hidden" name="clvybonnepovolene" id="clvybonnepovolene" value="peron,zaston,radaon,zamon,clkomon" />
				<input type="hidden" name="clvybonchecked" id="clvybonchecked" value="pidvybor,pidzarvybor" />
				<input type="hidden" name="clvybonunchecked" id="clvybonunchecked" value="peron,zamon,zaston,radaon,clkomon,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere,pidzarzast,pidzarrada,pidkomise,pidzarkomise" />
				</div>
				<div>
				<input type="checkbox" name="vyboron" id="vyboron"<?php echo ($vyboron ? " checked=\"checked\"" : ""); echo ($clvybon ? "" : " disabled=\"disabled\""); ?> onclick="switchdisable('vyboron','vyboronpovolene','vyboronnepovolene');uncheckbox('vyboron','vyboronchecked','vyboronunchecked');" /><label for="vyboron" class="noblock">výbor zastupitelstva</label>
				<input type="hidden" name="vyboronpovolene" id="vyboronpovolene" value="selvybor" />
				<input type="hidden" name="vyboronnepovolene" id="vyboronnepovolene" value="" />
				<select name="selvybor" id="selvybor" <?php echo ($vyboron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM vybor ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst výbory zastupitelstva - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($selvybor == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
				<div>
				<input type="checkbox" name="clkomon" id="clkomon"<?php echo ($clkomon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('clkomon','clkomonpovolene','clkomonnepovolene');uncheckbox('clkomon','clkomonchecked','clkomonunchecked');" /><label for="clkomon" class="noblock">členové komise rady?</label>
				<input type="hidden" name="clkomonpovolene" id="clkomonpovolene" value="komiseon" />
				<input type="hidden" name="clkomonnepovolene" id="clkomonnepovolene" value="peron,zaston,radaon,clvybon,zamon" />
				<input type="hidden" name="clkomonchecked" id="clkomonchecked" value="pidkomise,pidzarkomise" />
				<input type="hidden" name="clkomonunchecked" id="clkomonunchecked" value="peron,zamon,zaston,radaon,clvybon,pidzarazeni,pidodbor,pidoddeleni,pidbudova,pdvere,pidzarzast,pidzarrada,pidvybor,pidzarvybor" />
				</div>
				<div>
				<input type="checkbox" name="komiseon" id="komiseon"<?php echo ($komiseon ? " checked=\"checked\"" : ""); echo ($clkomon ? "" : " disabled=\"disabled\""); ?> onclick="switchdisable('komiseon','komiseonpovolene','komiseonnepovolene');uncheckbox('komiseon','komiseonchecked','komiseonunchecked');" /><label for="komiseon" class="noblock">komise rady</label>
				<input type="hidden" name="komiseonpovolene" id="komiseonpovolene" value="selkomise" />
				<input type="hidden" name="komiseonnepovolene" id="komiseonnepovolene" value="" />
				<select name="selkomise" id="selkomise" <?php echo ($komiseon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM komise ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst komise rady - formselperson.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($selkomise == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				</div>
			</fieldset>
			<fieldset>
				<legend>Zobrazované údaje</legend>
				<div>
				<input type="checkbox" name="ptelefon1" id="ptelefon1" <?php echo ($ptelefon1 ? " checked=\"checked\"" : ""); ?> /><label for="ptelefon1" class="noblock">telefon 1</label>
				<input type="checkbox" name="ptelefon2" id="ptelefon2" <?php echo ($ptelefon2 ? " checked=\"checked\"" : ""); ?> /><label for="ptelefon2" class="noblock">telefon 2</label>
				<input type="checkbox" name="pmobil1" id="pmobil1" <?php echo ($pmobil1 ? " checked=\"checked\"" : ""); ?> /><label for="pmobil1" class="noblock">mobil 1</label>
				<input type="checkbox" name="pmobil2" id="pmobil2" <?php echo ($pmobil2 ? " checked=\"checked\"" : ""); ?> /><label for="pmobil2" class="noblock">mobil 2</label>
				<input type="checkbox" name="pfax" id="pfax" <?php echo ($pfax ? " checked=\"checked\"" : ""); ?> /><label for="pfax" class="noblock">fax</label>
				<input type="checkbox" name="picq" id="picq" <?php echo ($picq ? " checked=\"checked\"" : ""); ?> /><label for="picq" class="noblock">icq</label>
				<input type="checkbox" name="pemail1" id="pemail1" <?php echo ($pemail1 ? " checked=\"checked\"" : ""); ?> /><label for="pemail1" class="noblock">email 1</label>
				<input type="checkbox" name="pemail2" id="pemail2" <?php echo ($pemail2 ? " checked=\"checked\"" : ""); ?> /><label for="pemail2" class="noblock">email 2</label>
				<input type="checkbox" name="pimg" id="pimg" <?php echo ($pimg ? " checked=\"checked\"" : ""); ?> /><label for="pimg" class="noblock">foto (obrázek)</label>
				</div>
				<div>
				<input type="checkbox" name="pidzarazeni" id="pidzarazeni" <?php echo ($pidzarazeni ? " checked=\"checked\"" : ""); ?> /><label for="pidzarazeni" class="noblock">pracovní zařazení</label>
				<input type="checkbox" name="pidodbor" id="pidodbor" <?php echo ($pidodbor ? " checked=\"checked\"" : ""); ?> /><label for="pidodbor" class="noblock">odbor úřadu</label>
				<input type="checkbox" name="pidoddeleni" id="pidoddeleni" <?php echo ($pidoddeleni ? " checked=\"checked\"" : ""); ?> /><label for="pidoddeleni" class="noblock">oddělení odboru úřadu</label>
				<input type="checkbox" name="pidbudova" id="pidbudova" <?php echo ($pidbudova ? " checked=\"checked\"" : ""); ?> /><label for="pidbudova" class="noblock">budova úřadu</label>
				<input type="checkbox" name="pdvere" id="pdvere" <?php echo ($pdvere ? " checked=\"checked\"" : ""); ?> /><label for="pdvere" class="noblock">číslo dveří</label>
				</div>
				<div>
				<input type="checkbox" name="pidstrana" id="pidstrana" <?php echo ($pidstrana ? " checked=\"checked\"" : ""); ?> /><label for="pidstrana" class="noblock">politická příslušnost</label>
				<input type="checkbox" name="pidzarzast" id="pidzarzast" <?php echo ($pidzarzast ? " checked=\"checked\"" : ""); ?> /><label for="pidzarzast" class="noblock">funkce v zastupitelstvu</label>
				<input type="checkbox" name="pidzarrada" id="pidzarrada" <?php echo ($pidzarrada ? " checked=\"checked\"" : ""); ?> /><label for="pidzarrada" class="noblock">funkce v radě</label>
				<input type="checkbox" name="pidvybor" id="pidvybor" <?php echo ($pidvybor ? " checked=\"checked\"" : ""); ?> /><label for="pidvybor" class="noblock">výbor zastupitelstva</label>
				<input type="checkbox" name="pidzarvybor" id="pidzarvybor" <?php echo ($pidzarvybor ? " checked=\"checked\"" : ""); ?> /><label for="pidzarvybor" class="noblock">funkce ve výboru zastupitelstva</label>
				<input type="checkbox" name="pidkomise" id="pidkomise" <?php echo ($pidkomise ? " checked=\"checked\"" : ""); ?> /><label for="pidkomise" class="noblock">komise rady</label>
				<input type="checkbox" name="pidzarkomise" id="pidzarkomise" <?php echo ($pidzarkomise ? " checked=\"checked\"" : ""); ?> /><label for="pidzarkomise" class="noblock">funkce v komisi rady</label>
				</div>
			</fieldset>
			<fieldset>
				<legend>Způsob zobrazení</legend>
				<label for="selorder">Řadit údaje podle:</label>
				<select name="selorder" id="selorder">
					<option value="prijmeni" <?php echo ($poleraz == "prijmeni" ? " selected=\"selected\"" : "") ?>>příjmení</option>
					<option value="funkce" <?php echo ($poleraz != "prijmeni" ? " selected=\"selected\"" : "") ?>>funkce</option>
				</select>
				<label for="selview">Zobrazit údaje jako:</label>
				<select name="selview" id="selview">
					<option value="adresa" <?php echo (!$tabulka ? " selected=\"selected\"" : "") ?>>adresu</option>
					<option value="tabulka" <?php echo ($tabulka ? " selected=\"selected\"" : "") ?>>tabulku</option>
				</select>
			</fieldset>
			<div>
			<input type="hidden" name="mtid" value="<?php echo $mtid ?>" />
			<input type="hidden" name="menuid" value="<?php echo $menuid ?>" />
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>			
		</fieldset>		
	</form>
</div>