<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formtxt.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$styl = $record["styl"];
			$cssstyl = $record["cssstyl"];
			$img = $record["img"];
			$imgon = ($record["img"] ? 1 : 0);
			$titleimg = $record["titleimg"];
			$cssimg = $record["cssimg"];
			$txt = $record["txt"];
		endif;
		echo "<h3>Editace textové položky článku</h3>";
	else:
		echo "<h3>Přidání textové položky článku</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="cssstyl">Globální vlastnosti textu</label>
			<select name="cssstyl" id="cssstyl">
				<option value="" <?php echo ($cssstyl == "" ? "selected=\"selected\"" : "")?>>normální</option>
				<option value="bold" <?php echo ($cssstyl == "bold" ? "selected=\"selected\"" : "")?>>tučný</option>
				<option value="italic" <?php echo ($cssstyl == "italic" ? "selected=\"selected\"" : "")?>>kurzíva</option>
				<option value="uppercase" <?php echo ($cssstyl == "uppercase" ? "selected=\"selected\"" : "")?>>všechna velká</option>
			</select>
			<label for="imgon">Obrázek k textu?</label>
			<input type="checkbox" name="imgon" id="imgon"<?php echo ($imgon ? " checked=\"checked\"" : ""); ?> onclick="switchdisable('imgon','imgonpovolene','imgonnepovolene')" /> Ano <input type="hidden" name="imgonpovolene" id="imgonpovolene" value="img,imgtmp,maximg,titleimg,cssimg" /><input type="hidden" name="imgonnepovolene" id="imgonnepovolene" value="" />
			<label for="img">Soubor obrázku</label>
			<input type="text" size="75" name="img" id="img" value="<?php echo $img ?>" maxlength="150" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
			<label for="imgtmp">Upload obrázku</label>
			<input type="file" accept="image/jpeg,image/png" name="imgtmp" id="imgtmp" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
			<div class="filltip">Povolené formáty obrázků jsou <strong>JPEG</strong> a <strong>PNG</strong>.</div>
			<label for="maximg">Maximální rozměr obrázku</label>
			<select name="maximg" id="maximg" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?>>
				<option value="500" <?php echo ($maximg == "500" ? "selected=\"selected\"" : "")?>>500 pixelů</option>
				<option value="250" <?php echo ($maximg == "250" ? "selected=\"selected\"" : "")?>>250 pixelů</option>
				<option value="150" <?php echo ($maximg == "150" ? "selected=\"selected\"" : "")?>>150 pixelů</option>
				<option value="80" <?php echo ($maximg == "80" ? "selected=\"selected\"" : "")?>>80 pixelů</option>
			</select>
			<label for="titleimg">Titulek obrázku</label>
			<input type="text" name="titleimg" id="titleimg" value="<?php echo $titleimg ?>" size="75" maxlength="150" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?> />
			<label for="cssimg">Vlastnosti obrázku</label>
			<select name="cssimg" id="cssimg" <?php echo ($imgon ? "" : " disabled=\"disabled\""); ?>>
				<option value="rightimg" <?php echo ($cssimg == "rightimg" ? "selected=\"selected\"" : "")?>>zarovnaný vpravo</option>
				<option value="leftimg" <?php echo ($cssimg == "leftimg" ? "selected=\"selected\"" : "")?>>zarovnaný vlevo</option>
				<option value="centerimg" <?php echo ($cssimg == "centerimg" ? "selected=\"selected\"" : "")?>>zarovnaný na střed</option>
			</select>
			<label for="txt">Text</label>
			<textarea rows="25" cols="140" name="txt" id="txt"><?php echo $txt ?></textarea>
			<?php
				$btns = "full";
				$txtarea = "txt";
				include "tpl/editbtns.tpl";
			?>
			<div>Zalomení řádku: <strong>&lt;br /&gt;</strong></div>
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