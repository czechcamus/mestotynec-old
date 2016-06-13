<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formweather.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$datum = $record["datum"];
			$kodpoc = $record["kodpoc"];
			$rano = $record["rano"];
			$odpoledne = $record["odpoledne"];
			$den = substr($datum,8,2);
			$mes = substr($datum,5,2);
			$rok = substr($datum,0,4);
		endif;
		echo "<h3>Editace denních údajů počasí</h3>";
	else:
		echo "<h3>Přidání denních údajů počasí</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="den" class="noblock">Den:</label>
			<input type="text" name="den" id="den" size="2" maxlength="2" value="<?php echo $den; ?>">
			<label for="mes" class="noblock">měsíc:</label>
			<input type="text" name="mes" id="mes" size="2" maxlength="2" value="<?php echo $mes; ?>">
			<label for="rok" class="noblock">rok:</label>
			<input type="text" name="rok" id="rok" size="4" maxlength="4" value="<?php echo $rok; ?>">
			<label for="kodpoc">Charakter počasí:</label>
			<?php 
			$dotazkod = "SELECT * FROM kodpocasi";
			$resultkod = mysql_query("$dotazkod");
			if (!$resultkod):
				die("Nezdařil se výběr z tabulky kodpocasi - formweather.tpl!");
			else:
				echo "<select name=\"kodpoc\" id=\"kodpoc\">\n";
				while ($recordkod = mysql_fetch_array($resultkod)):
					echo "<option value=\"".$recordkod["kod"]."\" ".($kodpoc == $recordkod["kod"] ? "selected" : "").">".$recordkod["kod"]." - ".$recordkod["text"]."</option>\n";
				endwhile;
				echo "</select>\n";
			endif;
			?>
			<label for="rano">Teploty v noci:</label>
			<input type="text" name="rano" id="rano" value="<?php echo $rano ?>" size="15" maxlength="15" />
			<label for="odpoledne">Teploty ve dne:</label>
			<input type="text" name="odpoledne" id="odpoledne" value="<?php echo $odpoledne ?>" size="15" maxlength="15" />
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>