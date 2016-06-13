<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		echo "<h3>Editace - $title</h3>";
	else:
		$dotaz = "SELECT MAX(id) FROM $tbl";
		echo "<h3>Přidání - $title</h3>";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezdařil se výběr z tabulky $tbl - formcis.tpl!");
	else:
		$record = mysql_fetch_array($result);
		if ($akce == "edit"):
			$titulek = $record["titulek"];
			$typakce_id = $record["typakce_id"];
			$den1 = substr(date("d-m-Y",$record["datum"]),0,2);
			$mes1 = substr(date("d-m-Y",$record["datum"]),3,2);
			$rok1 = substr(date("d-m-Y",$record["datum"]),6,4);
			if ($record["datum"] == $record["datum_do"]):
				$den2 = "";
				$mes2 = "";
				$rok2 = "";
			else:
				$den2 = substr(date("d-m-Y",$record["datum_do"]),0,2);
				$mes2 = substr(date("d-m-Y",$record["datum_do"]),3,2);
				$rok2 = substr(date("d-m-Y",$record["datum_do"]),6,4);
			endif;
			$zacatek = $record["zacatek"];
			$anotace = $record["anotace"];
			$podnik_id = $record["podnik_id"];
			$porad_id = $record["porad_id"];
		else:
			$itemid = $record[0]+1;
		endif;
	endif;
?>
	<form action="./changekal.php" method="post">
		<fieldset>
			<label for="podnik_id">Vyberte podnik</label>
			<select name="podnik_id" id="podnik_id">
				<?php
					$dotaz = "SELECT * FROM podnik ORDER BY podnik";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se určit podnik - formkal.tpl!");
					else:
						while ($record = mysql_fetch_array($result)):
							echo "<option value=\"".$record["id"]."\" ".($podnik_id == $record["id"] ? " selected=\"selected\"" : "").">".$record["podnik"]." ".$record["mesto"]."</option>";
						endwhile;
					endif;
				?>
			</select>
			<label for="porad_id">Vyberte pořadatele</label>
			<select name="porad_id" id="porad_id">
				<?php
					$dotaz = "SELECT * FROM poradatel ORDER BY jmeno";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se určit pořadatele - formkal.tpl!");
					else:
						while ($record = mysql_fetch_array($result)):
							echo "<option value=\"".$record["id"]."\" ".($porad_id == $record["id"] ? " selected=\"selected\"" : "").">".$record["jmeno"]."</option>";
						endwhile;
					endif;
				?>
			</select>
			<label for="typakce_id">Vyberte kategorii</label>
			<select name="typakce_id" id="typakce_id">
				<?php
					$dotaz = "SELECT * FROM typakce ORDER BY popis";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se určit kategorii - formkal.tpl!");
					else:
						while ($record = mysql_fetch_array($result)):
							echo "<option value=\"".$record["id"]."\" ".($typakce_id == $record["id"] ? " selected=\"selected\"" : "").">".$record["popis"]."</option>";
						endwhile;
					endif;
				?>
			</select>
			<label for="titulek">Název</label>
			<input type="text" name="titulek" id="titulek" size="50" maxlength="100" value="<?php echo $titulek; ?>">
			<div>
			<label for="den1" class="noblock">Datum od - den:</label>
			<input type="text" name="den1" id="den1" size="2" maxlength="2" value="<?php echo $den1; ?>">
			<label for="mes1" class="noblock">měsíc:</label>
			<input type="text" name="mes1" id="mes1" size="2" maxlength="2" value="<?php echo $mes1; ?>">
			<label for="rok1" class="noblock">rok:</label>
			<input type="text" name="rok1" id="rok1" size="4" maxlength="4" value="<?php echo $rok1; ?>">
			</div>
			<div>
			<label for="den2" class="noblock">Datum do - den:</label>
			<input type="text" name="den2" id="den2" size="2" maxlength="2" value="<?php echo $den2; ?>">
			<label for="mes2" class="noblock">měsíc:</label>
			<input type="text" name="mes2" id="mes2" size="2" maxlength="2" value="<?php echo $mes2; ?>">
			<label for="rok2" class="noblock">rok:</label>
			<input type="text" name="rok2" id="rok2" size="4" maxlength="4" value="<?php echo $rok2; ?>">
			</div>
			<label for="zacatek">Čas zahájení</label>
			<input type="text" name="zacatek" id="zacatek" size="50" maxlength="50" value="<?php echo $zacatek; ?>">
			<label for="anotace">Popis akce</label>
			<textarea rows="10" cols="60" name="anotace" id="anotace"><?php echo $anotace; ?></textarea>
			<?php
				$txtarea = "anotace";
				include "tpl/editbtns.tpl";
			?>
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="fn" value="<?php echo $fn ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="ttbl" value="<?php echo $ttbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
	<form action="<?php echo $fn; ?>">
		<div>
		<input type="submit" value="zpět" />
		</div>
	</form>
</div>