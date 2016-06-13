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
			$datum = $record["datum"];
			$den = substr($datum,8,2);
			$mes = substr($datum,5,2);
			$rok = substr($datum,0,4);
			$nazev = $record["nazev"];
			$popis = $record["popis"];
			$nahled = $record["nahled"];
			$snimek = $record["snimek"];
			$idautor = $record["idautor"];
		endif;
		echo "<h3>Editace údajů obrázku pro fotogalerii</h3>";
	else:
		echo "<h3>Přidání obrázku pro fotogalerii</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="nazev">Název obrázku</label>
			<input type="text" size="75" maxlength="150" name="nazev" id="nazev" value="<?php echo $nazev ?>" />
			<div>
			<strong>Datum pořízení snímku:</strong><br />
			<label for="den" class="noblock">den</label>
			<input type="text" size="2" name="den" id="den" value="<?php echo $den ?>" />
			<label for="mes" class="noblock">měsíc</label>
			<input type="text" size="2" name="mes" id="mes" value="<?php echo $mes ?>" />
			<label for="rok" class="noblock">rok</label>
			<input type="text" size="4" name="rok" id="rok" value="<?php echo $rok ?>" />
			</div>
			<label for="nahled">Soubor náhledu</label>
			<input type="text" size="75" maxlength="150" name="nahled" id="nahled" value="<?php echo $nahled ?>" />
			<label for="snimek">Soubor obrázku</label>
			<input type="text" size="75" maxlength="150" name="snimek" id="snimek" value="<?php echo $snimek ?>" />
			<label for="snimektmp">Upload obrázku</label>
			<input type="file" accept="image/jpeg,image/png" name="snimektmp" id="snimektmp" /> 
			<div class="filltip">Povolené formáty obrázků jsou <strong>JPEG</strong> a <strong>PNG</strong>.</div>
			<label for="popis">Popis obrázku</label>
			<textarea rows="5" cols="60" name="popis" id="popis"><?php echo $popis ?></textarea>
			<?php
				$txtarea = "popis";
				include "tpl/editbtns.tpl";?>
			<label for="idautor">Autor snímku</label>
			<select name="idautor" id="idautor">
				<?php
					$dotaz = "SELECT * FROM autor ORDER BY prijmeni";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se načíst autory - formimg.tpl!");
					else:
						while ($record = mysql_fetch_array($result)):
							echo "<option value=\"".$record["id"]."\" ".($idautor == $record["id"] ? " selected=\"selected\"" : "").">".$record["jmeno"]." ".$record["prijmeni"]."</option>";
						endwhile;
					endif;
				?>
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