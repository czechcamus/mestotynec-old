<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formlnk.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$styl = $record["styl"];
			$typlnk = $record["typlnk"];
			$cssstyl = $record["cssstyl"];
			$addrlnk = $record["addrlnk"];
			$txt = $record["txt"];
		endif;
		echo "<h3>Editace odkazu na soubor ke stažení</h3>";
	else:
		echo "<h3>Přidání odkazu na soubor ke stažení</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="styl">Styl odkazu na soubor</label>
			<select name="styl" id="styl">
				<option value="p" <?php echo ($styl == "p" ? "selected=\"selected\"" : "")?>>odstavec</option>
				<option value="h5" <?php echo ($styl == "h5" ? "selected=\"selected\"" : "")?>>nadpis větší</option>
				<option value="h6" <?php echo ($styl == "h6" ? "selected=\"selected\"" : "")?>>nadpis menší</option>
				<option value="div" <?php echo ($styl == "div" ? "selected=\"selected\"" : "")?>>blok</option>
			</select>
			<label for="cssstyl">Vlastnosti textu</label>
			<select name="cssstyl" id="cssstyl">
				<option value="" <?php echo ($cssstyl == "" ? "selected=\"selected\"" : "")?>>normální</option>
				<option value="bold" <?php echo ($cssstyl == "bold" ? "selected=\"selected\"" : "")?>>tučný</option>
				<option value="italic" <?php echo ($cssstyl == "italic" ? "selected=\"selected\"" : "")?>>kurzíva</option>
				<option value="uppercase" <?php echo ($cssstyl == "uppercase" ? "selected=\"selected\"" : "")?>>všechna velká</option>
			</select>
			<label for="filetmp">Upload souboru</label>
			<input type="file" name="filetmp" id="filetmp" />
			<label for="addrlnk">URL odkazu na soubor (http://www...)</label>
			<input type="text" name="addrlnk" id="addrlnk" value="<?php echo $addrlnk ?>" size="75" maxlength="200" />
			<label for="txt">Text odkazu na soubor</label>
			<textarea rows="5" cols="60" name="txt" id="txt"><?php echo $txt ?></textarea>
			<?php
				$txtarea = "txt";
				$nolink = true;
				include "tpl/editbtns.tpl";?>
			<div>
			<input type="hidden" name="mtid" value="<?php echo $mtid ?>" />
			<input type="hidden" name="typlnk" value="s" />
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>