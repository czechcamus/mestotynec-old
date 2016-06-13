<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formmastertxt.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$titulek = $record["titulek"];
			$den1 = substr($record["datum1"],8,2);
			$mes1 = substr($record["datum1"],5,2);
			$rok1 = substr($record["datum1"],0,4);
			if ($record["datum1"] == $record["datum2"]):
				$den2 = "";
				$mes2 = "";
				$rok2 = "";
			else:
				$den2 = substr($record["datum2"],8,2);
				$mes2 = substr($record["datum2"],5,2);
				$rok2 = substr($record["datum2"],0,4);
			endif;
			$perexhp = $record["perexhp"];
			$perexmid = $record["perexmid"];
			$idautor = $record["idautor"];
			$thumbimg = $record["thumbimg"];
			$titlethumbimg = $record["titlethumbimg"];
			$thumbimgon = ($record["thumbimg"] ? 1 : 0);
			$maininfo =  $record["maininfo"];
			$aktualinfo =  $record["aktualinfo"];
			$typinfoid = $record["typinfoid"];
			$perex =  $record["perex"];
		endif;
		echo "<h3>Editace hlavních údajů článku</h3>";
	else:
		$dat1 = date("Y-m-d",time());
		$den1 = substr($dat1,8,2);
		$mes1 = substr($dat1,5,2);
		$rok1 = substr($dat1,0,4);
		echo "<h3>Přidání článku</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="titulek">Titulek článku</label>
			<input type="text" name="titulek" id="titulek" value="<?php echo $titulek ?>" size="75" maxlength="150" />
			<div>
			<label for="den1" class="noblock">Datum platnosti článku od - den:</label>
			<input type="text" name="den1" id="den1" size="2" maxlength="2" value="<?php echo $den1; ?>">
			<label for="mes1" class="noblock">měsíc:</label>
			<input type="text" name="mes1" id="mes1" size="2" maxlength="2" value="<?php echo $mes1; ?>">
			<label for="rok1" class="noblock">rok:</label>
			<input type="text" name="rok1" id="rok1" size="4" maxlength="4" value="<?php echo $rok1; ?>">
			</div>
			<div>
			<label for="den2" class="noblock">Datum platnosti článku do - den:</label>
			<input type="text" name="den2" id="den2" size="2" maxlength="2" value="<?php echo $den2; ?>">
			<label for="mes2" class="noblock">měsíc:</label>
			<input type="text" name="mes2" id="mes2" size="2" maxlength="2" value="<?php echo $mes2; ?>">
			<label for="rok2" class="noblock">rok:</label>
			<input type="text" name="rok2" id="rok2" size="4" maxlength="4" value="<?php echo $rok2; ?>">
			</div>
			<label for="maininfo">Aktualita?</label>
			<input type="checkbox" name="maininfo" id="maininfo"<?php echo ($maininfo ? " checked=\"checked\"" : ""); ?> /> Ano 
			<label for="thumbimgon">Obrázek pro aktualitu?</label>
			<input type="checkbox" name="thumbimgon" id="thumbimgon"<?php echo ($thumbimgon ? " checked=\"checked\"" : ""); echo ($maininfo ? "" : " disabled=\"disabled\"");  ?> onclick="switchdisable('thumbimgon','thumbimgonpovolene','thumbimgonnepovolene')" /> Ano <input type="hidden" name="thumbimgonpovolene" id="thumbimgonpovolene" value="thumbimg,thumbimgtmp,titlethumbimg" /><input type="hidden" name="thumbimgonnepovolene" id="thumbimgonnepovolene" value="" />
			<label for="thumbimg">Soubor obrázku</label>
			<input type="text" size="75" name="thumbimg" id="thumbimg" value="<?php echo $thumbimg ?>" maxlength="150" <?php echo ($thumbimgon ? "" : " disabled=\"disabled\""); ?> />
			<label for="thumbimgtmp">Upload obrázku</label>
			<input type="file" accept="image/jpeg,image/png" name="thumbimgtmp" id="thumbimgtmp" <?php echo ($thumbimgon ? "" : " disabled=\"disabled\""); ?> />
			<div class="filltip">Povolené formáty obrázků jsou <strong>JPEG</strong> a <strong>PNG</strong>.</div>
			<label for="titlethumbimg">Titulek obrázku pro aktualitu</label>
			<input type="text" name="titlethumbimg" id="titlethumbimg" value="<?php echo $titlethumbimg ?>" size="75" maxlength="150" <?php echo ($thumbimgon ? "" : " disabled=\"disabled\""); ?> />
			<label for="perex">Perex</label>
			<textarea rows="15" cols="60" name="perex" id="perex"><?php echo $perex; ?></textarea>
			<?php
				$txtarea = "perex";
				include "tpl/editbtns.tpl";
			?>
			<label for="idautor">Autor článku</label>
			<select name="idautor" id="idautor">
				<?php
					$dotaz = "SELECT * FROM autor ORDER BY prijmeni";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se načíst autory - formmastertxt.tpl!");
					else:
						while ($record = mysql_fetch_array($result)):
							echo "<option value=\"".$record["id"]."\" ".($idautor == $record["id"] ? " selected=\"selected\"" : "").">".$record["jmeno"]." ".$record["prijmeni"]."</option>";
						endwhile;
					endif;
				?>
			</select>
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="mtid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="menuid" value="<?php echo $menuid ?>" />
			<input type="hidden" name="cssthumbimg" value="<?php echo $cssthumbimg ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>