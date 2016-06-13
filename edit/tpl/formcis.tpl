<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		echo "<h3>Editace - $title</h3>";
	else:
		$dotaz = "SELECT MAX(id) FROM $tbl";
		echo "<h3>Přidání - $title</h3>";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezdařil se výběr z tabulky $tbl - formcis.tpl!");
	else:
		$record = mysql_fetch_array($result);
		if ($akce == "edit"):
			if ($tbl == "zarazeni" || $tbl == "zarkomise" || $tbl == "zarvybor" || $tbl == "zarrada" || $tbl == "zarzast"):
				$nazev = $record["nazev"];
				$level = $record["level"];
			elseif ($tbl == "budova"):
				$nazev = $record["nazev"];
				$ulice = $record["ulice"];
			elseif ($tbl == "strana"):
				$nazev = $record["nazev"];
				$zkratka = $record["zkratka"];
			elseif ($tbl == "autor"):
				$nick = $record["nick"];
				$jmeno = $record["jmeno"];
				$prijmeni = $record["prijmeni"];
				$email = $record["email"];
			elseif ($tbl == "redaktor"):
				$username = $record["user"];
				$pwduser = $record["pwd"];
				$jmeno = $record["jmeno"];
				$prijmeni = $record["prijmeni"];
				$email = $record["email"];
				$admin = $record["admin"];
				$schval = $record["schval"];
				$web = $record["web"];
				$anketa = $record["anketa"];
				$soutez = $record["soutez"];
				$pocasi = $record["pocasi"];
				$ciselniky = $record["ciselniky"];
				$kalendar = $record["kalendar"];
				$uzivatele = $record["uzivatele"];
				$import = $record["import"];
				$diskuse = $record["diskuse"];
				$udeska = $record["udeska"];
			elseif ($tbl == "uzivatel"):
				$username = $record["user"];
				$pwduser = $record["pwd"];
				$jmeno = $record["jmeno"];
				$prijmeni = $record["prijmeni"];
				$titul = $record["titul"];
				$ulice = $record["ulice"];
				$mesto = $record["mesto"];
				$psc = $record["psc"];
				$email = $record["email"];
				$fullreg = ($record["fullreg"] ? true : false);
				$letter = ($record["letter"] ? true : false);
				$povol = ($record["povol"] ? true : false);
				$employee = ($record["employee"] ? true : false);
			elseif ($tbl == "osoba"):
				$jmeno = $record["jmeno"];
				$prijmeni = $record["prijmeni"];
				$titulpred = $record["titulpred"];
				$titulza = $record["titulza"];
				$img = $record["img"];
				$imgon = ($img ? true : false);
				$idbudova = $record["idbudova"];
				$idodbor = $record["idodbor"];
				$idoddeleni = $record["idoddeleni"];
				$idzarazeni = $record["idzarazeni"];
				$zaron = ($idzarazeni ? true : false);
				$dvere = $record["dvere"];
				$idstrana = $record["idstrana"];
				$politon = ($idstrana ? true : false);
				$idzarzast = $record["idzarzast"];
				$zaston =  ($idzarzast ? true : false);
				$idzarrada = $record["idzarrada"];
				$radaon =  ($idzarrada ? true : false);
				$idvybor = $record["idvybor"];
				$vyboron =  ($idvybor ? true : false);
				$idzarvybor = $record["idzarvybor"];
				$idkomise = $record["idkomise"];
				$komiseon =  ($idkomise ? true : false);
				$idzarkomise = $record["idzarkomise"];
				$telefon1 = $record["telefon1"];
				$telefon2 = $record["telefon2"];
				$mobil1 = $record["mobil1"];
				$mobil2 = $record["mobil2"];
				$fax = $record["fax"];
				$icq = $record["icq"];
				$email1 = $record["email1"];
				$email2 = $record["email2"];
			elseif ($tbl == "mista"):
				$level1 = $record["level1"];
				$level2 = $record["level2"];
				$level3 = $record["level3"];
				$level4 = $record["level4"];
				$level5 = $record["level5"];
				$level6 = $record["level6"];
				$name = $record["name"];
				if ($placelevel == 2):
					$idlevel1 = GetUpLevelPlace($placelevel,$level1,$level2,$level3,$level4,$level5,$level6);
				elseif ($placelevel == 3):
					$idlevel2 = GetUpLevelPlace($placelevel,$level1,$level2,$level3,$level4,$level5,$level6);
				elseif ($placelevel == 4):
					$idlevel3 = GetUpLevelPlace($placelevel,$level1,$level2,$level3,$level4,$level5,$level6);
				elseif ($placelevel == 5):
					$idlevel4 = GetUpLevelPlace($placelevel,$level1,$level2,$level3,$level4,$level5,$level6);
				elseif ($placelevel == 6):
					$idlevel5 = GetUpLevelPlace($placelevel,$level1,$level2,$level3,$level4,$level5,$level6);
				endif;
			elseif ($tbl == "podnik"):
				$podnik = $record["podnik"];
				$ulice = $record["ulice"];
				$misto_id = $record["misto_id"];
			elseif ($tbl == "poradatel"):
				$jmeno = $record["jmeno"];
				$telefon = $record["telefon"];
				$email = $record["email"];
			elseif ($tbl == "typakce"):
				$popis = $record["popis"];
			elseif ($tbl == "tema"):
				$nazev = $record["nazev"];
				$uvod = $record["uvod"];
				$idgarant = $record["idgarant"];
			elseif ($tbl == "zapis"):
				$jmeno = $record["jmeno"];
				$caszapisu = $record["caszapisu"];
				$titulek = $record["titulek"];
				$text = $record["text"];
			elseif ($tbl == "firmy"):
				$nazev = $record["nazev"];
				$dodatek = $record["dodatek"];
				$ulice = $record["ulice"];
				$mesto = $record["mesto"];
				$psc = $record["psc"];
				$telefony = $record["telefony"];
				$mobily = $record["mobily"];
				$faxy = $record["faxy"];
				$emaily = $record["emaily"];
				$web = $record["web"];
			elseif ($tbl == "firmy_cinnosti"):
				$idcinnosti = $record["idcinnosti"];
			else:
				$nazev = $record["nazev"];
			endif;
		else:
			$itemid = $record[0]+1;
		endif;
	endif;
	if (($tbl == "osoba") || ($tbl == "tema") || ($tbl == "zapis")):
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
<?php else: ?>
	<form action="./changetbl.php" method="get">
<?php endif; ?>
		<fieldset>
			<?php if ($tbl == "zarazeni" || $tbl == "zarkomise" || $tbl == "zarvybor" || $tbl == "zarrada" || $tbl == "zarzast"): ?>
				<label for="nazev">Název</label>
				<input type="text" name="nazev" id="nazev" size="50" maxlength="150" value="<?php echo $nazev; ?>" />
				<label for="level">Pozice</label>
				<select name="level" id="level">
					<option value="1" <?php echo ($level == "1" ? "selected=\"selected\"" : "")?>>1.</option>
					<option value="2" <?php echo ($level == "2" ? "selected=\"selected\"" : "")?>>2.</option>
					<option value="3" <?php echo ($level == "3" ? "selected=\"selected\"" : "")?>>3.</option>
					<option value="4" <?php echo ($level == "4" ? "selected=\"selected\"" : "")?>>4.</option>
					<option value="5" <?php echo ($level == "5" ? "selected=\"selected\"" : "")?>>5.</option>
					<option value="6" <?php echo ($level == "6" ? "selected=\"selected\"" : "")?>>6.</option>
					<option value="7" <?php echo ($level == "7" ? "selected=\"selected\"" : "")?>>7.</option>
					<option value="8" <?php echo ($level == "8" ? "selected=\"selected\"" : "")?>>8.</option>
					<option value="9" <?php echo ($level == "9" ? "selected=\"selected\"" : "")?>>9.</option>
				</select>
			<?php elseif ($tbl == "budova"): ?>
				<label for="nazev">Název</label>
				<input type="text" name="nazev" id="nazev" size="50" maxlength="150" value="<?php echo $nazev; ?>" />
				<label for="ulice">Ulice</label>
				<input type="text" name="ulice" id="ulice" size="50" maxlength="50" value="<?php echo $ulice; ?>" />
			<?php elseif ($tbl == "strana"): ?>
				<label for="nazev">Název</label>
				<input type="text" name="nazev" id="nazev" size="50" maxlength="150" value="<?php echo $nazev; ?>" />
				<label for="zkratka">Zkratka</label>
				<input type="text" name="zkratka" id="zkratka" size="15" maxlength="15" value="<?php echo $zkratka; ?>" />
			<?php elseif ($tbl == "autor"): ?>
				<label for="nick">Značka (zobrazí se u článků autora)</label>
				<input type="text" name="nick" id="nick" size="20" maxlength="20" value="<?php echo $nick; ?>" />
				<label for="jmeno">Jméno</label>
				<input type="text" name="jmeno" id="jmeno" size="50" maxlength="50" value="<?php echo $jmeno; ?>" />
				<label for="prijmeni">Příjmení</label>
				<input type="text" name="prijmeni" id="prijmeni" size="50" maxlength="50" value="<?php echo $prijmeni; ?>" />
				<label for="email">E-mail</label>
				<input type="text" name="email" id="email" size="50" maxlength="50" value="<?php echo $email; ?>" />
			<?php elseif ($tbl == "redaktor"): ?>
				<label for="username">Uživatelské jméno</label>
				<input type="text" name="username" id="username" size="8" maxlength="8" value="<?php echo $username; ?>" />
				<label for="pwduser">Heslo</label>
				<input type="text" name="pwduser" id="pwduser" size="8" maxlength="8" value="<?php echo $pwduser; ?>" />
				<label for="jmeno">Jméno</label>
				<input type="text" name="jmeno" id="jmeno" size="50" maxlength="50" value="<?php echo $jmeno; ?>" />
				<label for="prijmeni">Příjmení</label>
				<input type="text" name="prijmeni" id="prijmeni" size="50" maxlength="50" value="<?php echo $prijmeni; ?>" />
				<label for="email">E-mail</label>
				<input type="text" name="email" id="email" size="50" maxlength="50" value="<?php echo $email; ?>" />
				<?php if ($recordred["id"] != $itemid): ?>
				<div><input type="checkbox" name="admin" id="admin"<?php echo ($admin ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('admin','adminpovolene','adminnepovolene')" /><label for="admin" class="noblock">administrátor</label>
				<input type="hidden" name="adminpovolene" id="adminpovolene" value="" /><input type="hidden" name="adminnepovolene" id="adminnepovolene" value="schval,web,anketa,soutez,pocasi,ciselniky,kalendar,uzivatele,import" /></div>
				<div><input type="checkbox" name="web" id="web"<?php echo ($web ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> onclick="switchdisable('web','webpovolene','webnepovolene')" /><label for="web" class="noblock">správa webu</label>
				<input type="hidden" name="webpovolene" id="webpovolene" value="schval" /><input type="hidden" name="webnepovolene" id="webnepovolene" value="" /></div>
				<div><input type="checkbox" name="schval" id="schval"<?php echo ($schval ? " checked=\"checked\"" : ""); echo (($admin || !$web) ? " disabled=\"disabled\"" : ""); ?> onclick="uncheckbox('schval','schvalpovolene','schvalnepovolene')" /><label for="schval" class="noblock">schvalování článků</label>
				<input type="hidden" name="schvalpovolene" id="schvalpovolene" value="web" /><input type="hidden" name="schvalnepovolene" id="schvalnepovolene" value="" /></div>
				<div><input type="checkbox" name="anketa" id="anketa"<?php echo ($anketa ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="anketa" class="noblock">správa anket</label></div>
				<div><input type="checkbox" name="soutez" id="soutez"<?php echo ($soutez ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="soutez" class="noblock">správa soutěží</label></div>
				<div><input type="checkbox" name="kalendar" id="kalendar"<?php echo ($kalendar ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="kalendar" class="noblock">správa kalendáře</label></div>
				<div><input type="checkbox" name="pocasi" id="pocasi"<?php echo ($pocasi ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="pocasi" class="noblock">správa údajů počasí</label></div>
				<div><input type="checkbox" name="ciselniky" id="ciselniky"<?php echo ($ciselniky ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="ciselniky" class="noblock">správa číselníků</label></div>
				<div><input type="checkbox" name="uzivatele" id="uzivatele"<?php echo ($uzivatele ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="uzivatele" class="noblock">správa uživatelů</label></div>
				<div><input type="checkbox" name="diskuse" id="diskuse"<?php echo ($diskuse ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="diskuse" class="noblock">správa diskusního fóra</label></div>
				<div><input type="checkbox" name="import" id="import"<?php echo ($import ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="import" class="noblock">správa importů</label></div>
				<div><input type="checkbox" name="udeska" id="udeska"<?php echo ($udeska ? " checked=\"checked\"" : ""); echo ($admin ? " disabled=\"disabled\"" : ""); ?> /><label for="udeska" class="noblock">správa úřední desky</label></div>
				<?php else: ?>				
				<input type="hidden" name="admin" value="<?php echo $admin ?>" />
				<?php endif;
			elseif ($tbl == "uzivatel"): ?>
				<label for="username">Uživatelské jméno</label>
				<input type="text" name="username" id="username" size="8" maxlength="8" value="<?php echo $username; ?>" />
				<label for="pwduser">Heslo</label>
				<input type="text" name="pwduser" id="pwduser" size="8" maxlength="8" value="<?php echo $pwduser; ?>" />
				<label for="jmeno">Jméno</label>
				<input type="text" name="jmeno" id="jmeno" size="50" maxlength="50" value="<?php echo $jmeno; ?>" />
				<label for="prijmeni">Příjmení</label>
				<input type="text" name="prijmeni" id="prijmeni" size="50" maxlength="50" value="<?php echo $prijmeni; ?>" />
				<label for="titul">Titul</label>
				<input type="text" name="titul" id="titul" size="15" maxlength="15" value="<?php echo $titul; ?>" />
				<label for="ulice">Ulice</label>
				<input type="text" name="ulice" id="ulice" size="50" maxlength="50" value="<?php echo $ulice; ?>" />
				<label for="mesto">Město</label>
				<input type="text" name="mesto" id="mesto" size="50" maxlength="50" value="<?php echo $mesto; ?>" />
				<label for="psc">PSČ</label>
				<input type="text" name="psc" id="psc" size="50" maxlength="50" value="<?php echo $psc; ?>" />
				<label for="email">E-mail</label>
				<input type="text" name="email" id="email" size="50" maxlength="50" value="<?php echo $email; ?>" />
				<div><input type="checkbox" name="fullreg" id="anketa"<?php echo ($fullreg ? " checked=\"checked\"" : ""); ?> /><label for="fullreg" class="noblock">plná registrace</label></div>
				<div><input type="checkbox" name="letter" id="letter"<?php echo ($letter ? " checked=\"checked\"" : "");  ?> /><label for="letter" class="noblock">odběr newsletteru</label></div>
				<div><input type="checkbox" name="povol" id="povol"<?php echo ($povol ? " checked=\"checked\"" : ""); ?> /><label for="povol" class="noblock">potvrzení registrace</label></div>
				<div><input type="checkbox" name="employee" id="employee"<?php echo ($employee ? " checked=\"checked\"" : ""); ?> /><label for="employee" class="noblock">zaměstnanec úřadu</label></div>
			<?php elseif ($tbl == "osoba"): ?>
				<label for="titulpred">Titul před jménem</label>
				<input type="titulpred" name="titulpred" id="titulpred" size="15" maxlength="15" value="<?php echo $titulpred; ?>" />
				<label for="jmeno">Jméno</label>
				<input type="text" name="jmeno" id="jmeno" size="50" maxlength="50" value="<?php echo $jmeno; ?>" />
				<label for="prijmeni">Příjmení</label>
				<input type="text" name="prijmeni" id="prijmeni" size="50" maxlength="50" value="<?php echo $prijmeni; ?>" />
				<label for="titulza">Titul za jménem</label>
				<input type="text" name="titulza" id="titulza" size="15" maxlength="15" value="<?php echo $titulza; ?>" />
				<label for="telefon1">Telefon 1</label>
				<input type="text" name="telefon1" id="telefon1" size="9" maxlength="9" value="<?php echo $telefon1; ?>" />
				<label for="telefon2">Telefon 2</label>
				<input type="text" name="telefon2" id="telefon2" size="9" maxlength="9" value="<?php echo $telefon2; ?>" />
				<label for="mobil1">Mobil 1</label>
				<input type="text" name="mobil1" id="mobil1" size="9" maxlength="9" value="<?php echo $mobil1; ?>" />
				<label for="mobil2">Mobil 2</label>
				<input type="text" name="mobil2" id="mobil2" size="9" maxlength="9" value="<?php echo $mobil2; ?>" />
				<label for="fax">Fax</label>
				<input type="text" name="fax" id="fax" size="9" maxlength="9" value="<?php echo $fax; ?>" />
				<label for="icq">ICQ</label>
				<input type="text" name="icq" id="icq" size="9" maxlength="9" value="<?php echo $icq; ?>" />
				<label for="email1">E-mail 1</label>
				<input type="text" name="email1" id="email1" size="50" maxlength="50" value="<?php echo $email1; ?>" />
				<label for="email2">E-mail 2</label>
				<input type="text" name="email2" id="email2" size="50" maxlength="50" value="<?php echo $email2; ?>" />
				<label for="imgon">Fotografie?</label>
				<input type="checkbox" name="imgon" id="imgon"<?php echo ($imgon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('imgon','imgonpovolene','imgonnepovolene')" /> Ano <input type="hidden" name="imgonpovolene" id="imgonpovolene" value="img,imgtmp,maximg,titleimg,cssimg" /><input type="hidden" name="imgonnepovolene" id="imgonnepovolene" value="" />
				<label for="img">Soubor fotografie</label>
				<input type="text" size="75" name="img" id="img" value="<?php echo $img ?>" maxlength="150" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
				<label for="imgtmp">Upload fotografie</label>
				<input type="file" accept="image/jpeg,image/png" name="imgtmp" id="imgtmp" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
				<div class="filltip">Povolené formáty jsou <strong>JPEG</strong> a <strong>PNG</strong>.</div>
				<div><input type="checkbox" name="zaron" id="zaron"<?php echo ($zaron ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('zaron','zaronpovolene','zaronnepovolene')" /><label for="zaron" class="noblock">zaměstnanec úřadu?</label>
				<input type="hidden" name="zaronpovolene" id="zaronpovolene" value="idzarazeni,idodbor,idoddeleni,idbudova,dvere" /><input type="hidden" name="zaronnepovolene" id="zaronnepovolene" value="" /></div>
				<label for="idzarazeni">Pracovní zařazení</label>
				<select name="idzarazeni" id="idzarazeni" <?php echo ($zaron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM zarazeni ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst pracovní zařazení - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idzarazeni == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<label for="idodbor">Odbor úřadu</label>
				<select name="idodbor" id="idodbor" <?php echo ($zaron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM odbor ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst odbor úřadu - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idodbor == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<label for="idoddeleni">Oddělení</label>
				<select name="idoddeleni" id="idoddeleni" <?php echo ($zaron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM oddeleni ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst oddělení - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idoddeleni == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<label for="idbudova">Budova úřadu</label>
				<select name="idbudova" id="idbudova" <?php echo ($zaron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM budova ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst budovy - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idbudova == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<label for="dvere">Číslo dveří</label>
				<input type="text" name="dvere" id="dvere" size="15" maxlength="15" value="<?php echo $dvere; ?>" />
				<div><input type="checkbox" name="politon" id="politon"<?php echo ($politon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('politon','politonpovolene','politonnepovolene')" /><label for="politon" class="noblock">politická příslušnost?</label>
				<input type="hidden" name="politonpovolene" id="politonpovolene" value="idstrana" /><input type="hidden" name="politonnepovolene" id="politonnepovolene" value="" /></div>
				<label for="idstrana">Politická strana</label>
				<select name="idstrana" id="idstrana" <?php echo ($politon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM strana ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst strany - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idstrana == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<div><input type="checkbox" name="zaston" id="zaston"<?php echo ($zaston ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('zaston','zastonpovolene','zastonnepovolene')" /><label for="zaston" class="noblock">člen zastupitelstva?</label>
				<input type="hidden" name="zastonpovolene" id="zastonpovolene" value="idzarzast" /><input type="hidden" name="zastonnepovolene" id="zastonnepovolene" value="" /></div>
				<label for="idzarzast">Funkce v zastupitelstvu</label>
				<select name="idzarzast" id="idzarzast" <?php echo ($zaston ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM zarzast ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst funkce v zastupitelstvu - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idzarzast == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<div><input type="checkbox" name="radaon" id="radaon"<?php echo ($radaon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('radaon','radaonpovolene','radaonnepovolene')" /><label for="radaon" class="noblock">člen rady?</label>
				<input type="hidden" name="radaonpovolene" id="radaonpovolene" value="idzarrada" /><input type="hidden" name="radaonnnepovolene" id="radaonnepovolene" value="" /></div>
				<label for="idzarrada">Funkce v radě</label>
				<select name="idzarrada" id="idzarrada" <?php echo ($radaon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM zarrada ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst funkce v radě - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idzarrada == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<div><input type="checkbox" name="vyboron" id="vyboron"<?php echo ($vyboron ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('vyboron','vyboronpovolene','vyboronnepovolene')" /><label for="vyboron" class="noblock">člen výboru zastupitelstva?</label>
				<input type="hidden" name="vyboronpovolene" id="vyboronpovolene" value="idvybor,idzarvybor" /><input type="hidden" name="vyboronnnepovolene" id="vyboronnepovolene" value="" /></div>
				<label for="idvybor">Výbor zastupitelstva</label>
				<select name="idvybor" id="idvybor" <?php echo ($vyboron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM vybor ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst výbory zastupitelstva - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idvybor == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<label for="idzarvybor">Funkce ve výboru zastupitelstva</label>
				<select name="idzarvybor" id="idzarvybor" <?php echo ($vyboron ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM zarvybor ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst funkce ve výboru zastupitelstva - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idzarvybor == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<div><input type="checkbox" name="komiseon" id="komiseon"<?php echo ($komiseon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('komiseon','komiseonpovolene','komiseonnepovolene')" /><label for="komiseon" class="noblock">člen komise rady?</label>
				<input type="hidden" name="komiseonpovolene" id="komiseonpovolene" value="idkomise,idzarkomise" /><input type="hidden" name="komiseonnnepovolene" id="komiseonnepovolene" value="" /></div>
				<label for="idkomise">Komise rady</label>
				<select name="idkomise" id="idkomise" <?php echo ($komiseon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM komise ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst komise rady - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idkomise == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
				<label for="idzarkomise">Funkce v komisi rady</label>
				<select name="idzarkomise" id="idzarkomise" <?php echo ($komiseon ? "" : " disabled=\"disabled\""); ?>>
					<?php
						$dotaz = "SELECT * FROM zarkomise ORDER BY nazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst funkce v komisi rady - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idzarkomise == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
			<?php elseif ($tbl == "mista"):
				if ($placelevel == 2): ?>
					<label for="idlevel1">Výběr státu</label>
					<select name="idlevel1" id="idlevel1" <?php echo ($akce == "edit" ? "disabled=\"disabled\"" : ""); ?>>
						<?php
							$dotaz = "SELECT * FROM mista WHERE level2=0 ORDER BY name";
							$result = mysql_query("$dotaz");
							if (!$result):
								die("Nepodařilo se načíst státy - formcis.tpl!");
							else:
								while ($record = mysql_fetch_array($result)):
									echo "<option value=\"".$record["id"]."\" ".($idlevel1 == $record["id"] ? " selected=\"selected\"" : "").">".$record["name"]."</option>";
								endwhile;
							endif;
						?>
					</select>
				<?php elseif ($placelevel == 3): ?>
					<label for="idlevel2">Výběr kraje</label>
					<select name="idlevel2" id="idlevel2" <?php echo ($akce == "edit" ? "disabled=\"disabled\"" : ""); ?>>
						<?php
							$dotaz = "SELECT * FROM mista WHERE level2 !=0 AND level3=0 ORDER BY name";
							$result = mysql_query("$dotaz");
							if (!$result):
								die("Nepodařilo se načíst kraje - formcis.tpl!");
							else:
								while ($record = mysql_fetch_array($result)):
									echo "<option value=\"".$record["id"]."\" ".($idlevel2 == $record["id"] ? " selected=\"selected\"" : "").">".$record["name"]."</option>";
								endwhile;
							endif;
						?>
					</select>
				<?php elseif ($placelevel == 4): ?>
					<label for="idlevel3">Výběr regionu</label>
					<select name="idlevel3" id="idlevel3" <?php echo ($akce == "edit" ? "disabled=\"disabled\"" : ""); ?>>
						<?php
							$dotaz = "SELECT * FROM mista WHERE level3!=0 AND level4=0 ORDER BY name";
							$result = mysql_query("$dotaz");
							if (!$result):
								die("Nepodařilo se načíst regiony - formcis.tpl!");
							else:
								while ($record = mysql_fetch_array($result)):
									echo "<option value=\"".$record["id"]."\" ".($idlevel3 == $record["id"] ? " selected=\"selected\"" : "").">".$record["name"]."</option>";
								endwhile;
							endif;
						?>
					</select>
				<?php endif; ?>
				<label for="name">Název <?php echo ($placelevel == 1 ? "státu" : ($placelevel == 2 ? "kraje" : ($placelevel == 3 ? "regionu" : "obce"))); ?></label>
				<input type="text" name="name" id="name" size="50" maxlength="64" value="<?php echo $name; ?>" />
				<input type="hidden" name="placelevel" value="<?php echo $placelevel ?>" />
			<?php elseif ($tbl == "podnik"): ?>
				<label for="podnik">Název podniku</label>
				<input type="text" name="podnik" id="podnik" size="50" maxlength="50" value="<?php echo $podnik; ?>" />
				<label for="ulice">Ulice</label>
				<input type="text" name="ulice" id="ulice" size="50" maxlength="50" value="<?php echo $ulice; ?>" />
				<label for="misto_id">Výběr města/obce</label>
				<select name="misto_id" id="misto_id">
					<?php
						$dotaz = "SELECT * FROM mista WHERE level4!=0 ORDER BY name";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst obce - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($misto_id == $record["id"] ? " selected=\"selected\"" : "").">".$record["name"]."</option>";
							endwhile;
						endif;
					?>
				</select>
			<?php elseif ($tbl == "poradatel"): ?>
				<label for="jmeno">Název pořadatele</label>
				<input type="text" name="jmeno" id="jmeno" size="50" maxlength="50" value="<?php echo $jmeno; ?>" />
				<label for="telefon">Telefon</label>
				<input type="text" name="telefon" id="telefon" size="15" maxlength="15" value="<?php echo $telefon; ?>" />
				<label for="email">E-mail</label>
				<input type="text" name="email" id="email" size="50" maxlength="50" value="<?php echo $email; ?>" />
			<?php elseif ($tbl == "typakce"): ?>
				<label for="popis">Název kategorie</label>
				<input type="text" name="popis" id="popis" size="20" maxlength="20" value="<?php echo $popis; ?>" />
			<?php elseif ($tbl == "tema"): ?>
				<label for="nazev">Název tématu</label>
				<input type="text" name="nazev" id="nazev" size="50" maxlength="50" value="<?php echo $nazev; ?>" />
				<label for="uvod">Popis tématu</label>
				<textarea rows="15" cols="60" name="uvod" id="uvod"><?php echo $uvod; ?></textarea>
				<label for="idgarant">Moderátor</label>
				<select name="idgarant" id="idgarant">
					<?php
						$dotaz = "SELECT * FROM osoba ORDER BY prijmeni";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst osoby - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idgarant == $record["id"] ? " selected=\"selected\"" : "").">".$record["prijmeni"]." ".$record["jmeno"]."</option>";
							endwhile;
						endif;
					?>
				</select>
  			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<?php elseif ($tbl == "zapis"): ?>
				<label for="jmeno">Autor příspěvku</label>
				<input type="text" name="jmeno" id="jmeno" size="50" maxlength="50" value="<?php echo $jmeno; ?>" disabled="disabled" />
				<label for="caszapisu">Čas zápisu</label>
				<input type="text" name="caszapisu" id="caszapisu" size="20" maxlength="20" value="<?php echo $caszapisu; ?>" disabled="disabled" />
				<label for="titulek">Název příspěvku</label>
				<input type="text" name="titulek" id="titulek" size="50" maxlength="50" value="<?php echo $titulek; ?>" />
				<label for="text">Text příspěvku</label>
				<textarea rows="15" cols="60" name="text" id="text"><?php echo $text; ?></textarea>
				<input type="hidden" name="idtema" value="<?php echo $idtema ?>" />
			<?php elseif ($tbl == "firmy"): ?>
				<label for="nazev">Název firmy</label>
				<input type="text" name="nazev" id="nazev" size="50" maxlength="250" value="<?php echo $nazev; ?>"  />
				<label for="dodatek">Dodatek názvu</label>
				<input type="text" name="dodatek" id="dodatek" size="50" maxlength="250" value="<?php echo $dodatek; ?>"  />
				<label for="ulice">Adresa - ulice</label>
				<input type="text" name="ulice" id="ulice" size="50" maxlength="250" value="<?php echo $ulice; ?>"  />
				<label for="mesto">Adresa - město / obec</label>
				<input type="text" name="mesto" id="mesto" size="50" maxlength="250" value="<?php echo $mesto; ?>"  />
				<label for="psc">Adresa - PSČ</label>
				<input type="text" name="psc" id="psc" size="5" maxlength="5" value="<?php echo $psc; ?>"  />
				<label for="telefony">Telefony</label>
				<input type="text" name="telefony" id="telefony" size="50" maxlength="250" value="<?php echo $telefony; ?>"  />
				<label for="mobily">Mobily</label>
				<input type="text" name="mobily" id="mobily" size="50" maxlength="250" value="<?php echo $mobily; ?>"  />
				<label for="faxy">Faxy</label>
				<input type="text" name="faxy" id="faxy" size="50" maxlength="250" value="<?php echo $faxy; ?>"  />
				<label for="emaily">E-maily</label>
				<input type="text" name="emaily" id="emaily" size="50" maxlength="250" value="<?php echo $emaily; ?>"  />
				<label for="web">Web</label>
				<input type="text" name="web" id="web" size="50" maxlength="250" value="<?php echo $web; ?>"  />
			<?php elseif ($tbl == "firmy_cinnosti"): ?>
				<label for="idcinnosti">Činnost</label>
				<select name="idcinnosti" id="idcinnosti">
					<?php
						$dotaz = "SELECT * FROM cinnosti ORDER BY cznazev";
						$result = mysql_query("$dotaz");
						if (!$result):
							die("Nepodařilo se načíst činnosti - formcis.tpl!");
						else:
							while ($record = mysql_fetch_array($result)):
								echo "<option value=\"".$record["id"]."\" ".($idcinnosti == $record["id"] ? " selected=\"selected\"" : "").">".$record["nazev"]."</option>";
							endwhile;
						endif;
					?>
				</select>
  			<input type="hidden" name="idfirmy" value="<?php echo $idfirmy ?>" />
			<?php else: ?>
				<label for="nazev">Název</label>
				<input type="text" name="nazev" id="nazev" size="50" maxlength="150" value="<?php echo $nazev; ?>" />
			<?php endif; ?>
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="fn" value="<?php echo $fn ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="ttbl" value="<?php echo $ttbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
	<form action="<?php echo $fn; ?>">
		<div>
		<?php if ($tbl == "mista"): ?>
			<input type="hidden" name="placelevel" value="<?php echo $placelevel ?>" />
		<?php elseif ($tbl == "zapis"): ?>
			<input type="hidden" name="idtema" value="<?php echo $idtema ?>" />
		<?php endif; ?>
		<input type="submit" value="zpět" />
		</div>
	</form>
</div>
