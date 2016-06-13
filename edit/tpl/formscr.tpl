<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formscr.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$nazev = $record["nazev"];
			$umisteni = $record["umisteni"];
		endif;
		echo "<h3>Editace odkazu na PHP skript</h3>";
	else:
		echo "<h3>Přidání odkazu na PHP skript</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="nazev">Název skriptu</label>
			<input type="text" name="nazev" id="nazev" value="<?php echo $nazev ?>" size="30" maxlength="30" />
			<label for="umisteni">Umístění skriptu (v rámci struktury webu)</label>
			<input type="text" name="umisteni" id="umisteni" value="<?php echo $umisteni ?>" size="75" maxlength="150" />
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