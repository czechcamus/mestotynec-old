<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formselperson.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$tblname = $record["tblname"];
			$sloupce = $record["sloupce"];
			$nazsloupce = $record["nazsloupce"];
			$poleraz = $record["poleraz"];
			$tabulka = $record["tabulka"];
		endif;
		echo "<h3>Editace výběru tabulky</h3>";
	else:
		echo "<h3>Přidání výběru tabulky</h3>";
	endif;
?>
	<form action="./edit.php" method="get">
		<fieldset>
			<label for="tblname">Výběr tabulky</label>
			<select name="tblname" id="tblname">
				<?php
					$dotaz = "SELECT * FROM tablename WHERE typ='tbl' AND imported=1 ORDER BY titulek";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se načíst tabulky - formseltbl.tpl!");
					else:
						while ($record = mysql_fetch_array($result)):
							echo "<option value=\"".$record["tblname"]."\" ".($tblname == $record["tblname"] ? " selected=\"selected\"" : "").">".$record["titulek"]."</option>";
						endwhile;
					endif;
				?>
			</select>
			<div>
				<input type="hidden" name="mtid" value="<?php echo $mtid ?>" />
			<?php if ($akce != "add"): ?>
				<input type="hidden" name="sloupce" value="<?php echo $sloupce ?>" />
				<input type="hidden" name="nazsloupce" value="<?php echo $nazsloupce ?>" />
				<input type="hidden" name="poleraz" value="<?php echo $poleraz ?>" />
				<input type="hidden" name="tabulka" value="<?php echo $tabulka ?>" />
			<?php endif; ?>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="tbltyp" value="<?php echo $tbltyp ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="hidden" name="step" value="1" />
			<input type="submit" value="pokračovat" />
			</div>			
		</fieldset>		
	</form>
</div>