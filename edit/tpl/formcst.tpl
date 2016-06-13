<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
		// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formcst.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$otazka = $record["otazka"];
			$img = $record["img"];
			$imgon = ($record["img"] ? 1 : 0);
			$odp1 = $record["odp1"];
			$odp2 = $record["odp2"];
			$odp3 = $record["odp3"];
			$odp4 = $record["odp4"];
			$odp5 = $record["odp5"];
			$spravne = $record["spravne"];
		endif;
		echo "<h3>Editace soutěže</h3>";
	else:
		$dotaz = "SELECT MAX(id) FROM $tbl";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst maximální id content - formcst.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$itemid = $record[0] + 1;
		endif;
		echo "<h3>Přidání soutěže</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="otazka">Soutěžní otázka</label>
			<input type="text" name="otazka" id="otazka" value="<?php echo $otazka ?>" size="75" maxlength="250" />
			<label for="imgon">Soutěžní obrázek?</label>
			<input type="checkbox" name="imgon" id="imgon"<?php echo ($imgon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('imgon','imgonpovolene','imgonnepovolene')" /> Ano <input type="hidden" name="imgonpovolene" id="imgonpovolene" value="img,imgtmp,titleimg,cssimg" /><input type="hidden" name="imgonnepovolene" id="imgonnepovolene" value="" />
			<label for="img">Soubor obrázku</label>
			<input type="text" size="75" name="img" id="img" value="<?php echo $img ?>" maxlength="150" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
			<label for="imgtmp">Upload obrázku</label>
			<input type="file" accept="image/jpeg,image/gif,image/png" name="imgtmp" id="imgtmp" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
			<label for="odp1">1. odpověď</label>
			<input type="text" name="odp1" id="odp1" value="<?php echo $odp1 ?>" size="75" maxlength="150" />
			<label for="odp2">2. odpověď</label>
			<input type="text" name="odp2" id="odp2" value="<?php echo $odp2 ?>" size="75" maxlength="150" />
			<label for="odp3">3. odpověď</label>
			<input type="text" name="odp3" id="odp3" value="<?php echo $odp3 ?>" size="75" maxlength="150" />
			<label for="odp4">4. odpověď</label>
			<input type="text" name="odp4" id="odp4" value="<?php echo $odp4 ?>" size="75" maxlength="150" />
			<label for="odp5">5. odpověď</label>
			<input type="text" name="odp5" id="odp5" value="<?php echo $odp5 ?>" size="75" maxlength="150" />
			<label for="spravne">Správná odpověď</label>
			<select name="spravne" id="spravne">
				<option value="1" <?php echo ($spravne == "1" ? "selected=\"selected\"" : "")?>>1. odpověď</option>
				<option value="2" <?php echo ($spravne == "2" ? "selected=\"selected\"" : "")?>>2. odpověď</option>
				<option value="3" <?php echo ($spravne == "3" ? "selected=\"selected\"" : "")?>>3. odpověď</option>
				<option value="4" <?php echo ($spravne == "4" ? "selected=\"selected\"" : "")?>>4. odpověď</option>
				<option value="5" <?php echo ($spravne == "5" ? "selected=\"selected\"" : "")?>>5. odpověď</option>
			</select>
			<div>
			<input type="hidden" name="mtid" value="<?php echo $mtid ?>" />
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>