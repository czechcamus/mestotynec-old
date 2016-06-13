<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formvote.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$otazka = $record["otazka"];
			$odp1 = $record["odp1"];
			$odp2 = $record["odp2"];
			$odp3 = $record["odp3"];
			$odp4 = $record["odp4"];
			$odp5 = $record["odp5"];
			$odp6 = $record["odp6"];
			$odp7 = $record["odp7"];
			$odp8 = $record["odp8"];
			$odp9 = $record["odp9"];
			$odp10 = $record["odp10"];
		endif;
		echo "<h3>Editace ankety</h3>";
	else:
		echo "<h3>Přidání ankety</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="otazka">Anketní otázka</label>
			<input type="text" name="otazka" id="otazka" value="<?php echo $otazka ?>" size="75" maxlength="250" />
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
			<label for="odp6">6. odpověď</label>
			<input type="text" name="odp6" id="odp6" value="<?php echo $odp6 ?>" size="75" maxlength="150" />
			<label for="odp7">7. odpověď</label>
			<input type="text" name="odp7" id="odp7" value="<?php echo $odp7 ?>" size="75" maxlength="150" />
			<label for="odp8">8. odpověď</label>
			<input type="text" name="odp8" id="odp8" value="<?php echo $odp8 ?>" size="75" maxlength="150" />
			<label for="odp9">9. odpověď</label>
			<input type="text" name="odp9" id="odp9" value="<?php echo $odp9 ?>" size="75" maxlength="150" />
			<label for="odp10">10. odpověď</label>
			<input type="text" name="odp10" id="odp10" value="<?php echo $odp10 ?>" size="75" maxlength="150" />
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>