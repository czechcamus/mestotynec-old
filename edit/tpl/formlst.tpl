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
			$itemstyl = $record["itemstyl"];
			$cssstyl = $record["cssstyl"];
			$txt = $record["txt"];
		endif;
		echo "<h3>Editace textového seznamu článku</h3>";
	else:
		echo "<h3>Přidání textového seznamu článku</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="styl">Typ seznamu</label>
			<select name="styl" id="styl" onchange="switchlistitemtype('styl','ulpovolene','ulnepovolene')"> 
				<option value="ul" id="ul" <?php echo ($styl == "ul" ? "selected=\"selected\"" : "")?>>nečíslovaný seznam</option>
				<option value="ol" id="ol" <?php echo ($styl == "ol" ? "selected=\"selected\"" : "")?>>číslovaný seznam</option>
			</select>
			<input type="hidden" name="ulpovolene" id="ulpovolene" value="lstdisc,lstsquare,lstcircle" />
			<input type="hidden" name="ulnepovolene" id="ulnepovolene" value="lstdec,lstrom,lstlalfa,lstualfa" />
			<label for="itemstyl">Typ položek</label>
			<select name="itemstyl" id="itemstyl">
				<option value="lstnone" <?php echo ($itemstyl == "lstnone" ? "selected=\"selected\"" : "")?>>implicitní</option>
				<option value="lstdisc" id="lstdisc" <?php echo ($itemstyl == "lstdisc" ? "selected=\"selected\"" : ""); echo (($styl=="ol") ? "disabled=\"disabled\"" : ""); ?>>odrážka - kolečko</option>
				<option value="lstsquare" id="lstsquare" <?php echo ($itemstyl == "lstsquare" ? "selected=\"selected\"" : ""); echo (($styl=="ol") ? "disabled=\"disabled\"" : ""); ?>>odrážka - čtvereček</option>
				<option value="lstcircle" id="lstcircle" <?php echo ($itemstyl == "lstcircle" ? "selected=\"selected\"" : ""); echo (($styl=="ol") ? "disabled=\"disabled\"" : ""); ?>>odrážka - kroužek</option>
				<option value="lstdec" id="lstdec" <?php echo ($itemstyl == "lstdec" ? "selected=\"selected\"" : ""); echo (($styl=="ul" || !$styl) ? "disabled=\"disabled\"" : ""); ?>>1.,2.,3.,...</option>
				<option value="lstrom" id="lstrom" <?php echo ($itemstyl == "lstrom" ? "selected=\"selected\"" : ""); echo (($styl=="ul" || !$styl) ? "disabled=\"disabled\"" : ""); ?>>I.,II.,III.,...</option>
				<option value="lstlalfa" id="lstlalfa" <?php echo ($itemstyl == "lstlalfa" ? "selected=\"selected\"" : ""); echo (($styl=="ul" || !$styl) ? "disabled=\"disabled\"" : ""); ?>>a.,b.,c.,...</option>
				<option value="lstualfa" id="lstualfa" <?php echo ($itemstyl == "lstualfa" ? "selected=\"selected\"" : ""); echo (($styl=="ul" || !$styl) ? "disabled=\"disabled\"" : ""); ?>>A.,B.,C.,...</option>
			</select>
			<label for="cssstyl">Globální vlastnosti textu</label>
			<select name="cssstyl" id="cssstyl">
				<option value="" <?php echo ($cssstyl == "" ? "selected=\"selected\"" : "")?>>normální</option>
				<option value="bold" <?php echo ($cssstyl == "bold" ? "selected=\"selected\"" : "")?>>tučný</option>
				<option value="italic" <?php echo ($cssstyl == "italic" ? "selected=\"selected\"" : "")?>>kurzíva</option>
				<option value="uppercase" <?php echo ($cssstyl == "uppercase" ? "selected=\"selected\"" : "")?>>všechna velká</option>
			</select>
			<label for="txt">Text</label>
			<textarea rows="15" cols="60" name="txt" id="txt"><?php echo $txt ?></textarea>
			<div class="filltip">Jednotlivé položky seznamu oddělujte klávesou Enter!</div>
			<?php
				$txtarea = "txt";
				include "tpl/editbtns.tpl";?>
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