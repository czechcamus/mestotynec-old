<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formbuilding.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$nazev = $record["nazev"];
			$ulice = $record["ulice"];
		endif;
		echo "<h3>Editace údajů budovy</h3>";
	else:
		echo "<h3>Přidání údajů budovy</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="nazev">Název</label>
			<input type="text" name="nazev" id="nazev" size="50" maxlength="50" value="<?php echo $nazev; ?>">
			<label for="ulice">Ulice</label>
			<input type="text" name="ulice" id="ulice" size="50" maxlength="50" value="<?php echo $ulice; ?>">
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>