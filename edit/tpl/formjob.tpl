<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formjob.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$nazev = $record["nazev"];
			$level = $record["level"];
		endif;
		echo "<h3>Editace pracovního zařazení</h3>";
	else:
		echo "<h3>Přidání pracovníého zařazení</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="nazev">Název zařazení</label>
			<input type="text" name="nazev" id="nazev" size="50" maxlength="50" value="<?php echo $nazev; ?>">
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
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>