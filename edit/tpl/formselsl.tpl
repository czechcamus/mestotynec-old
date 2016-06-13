<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	$tblname = $_GET["tblname"];
	if ($akce == "edit"):
		$sloupce = $_GET["sloupce"];
		$polesl = explode(",",$sloupce);
		$nazsloupce = $_GET["nazsloupce"];
		$polenazsl = explode(",",$nazsloupce);
		$poleraz = $_GET["poleraz"];
		$tabulka = $_GET["tabulka"];
		echo "<h3>Editace výběru sloupců tabulky</h3>";
	else:
		echo "<h3>Přidání výběru sloupců tabulky</h3>";
	endif;
?>
	<form action="./checkseltbl.php" method="get">
		<fieldset>
			<?php
				// výběr údajů tabulky
				$dotaz = "SELECT * FROM $tblname LIMIT 0,1";
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Výběr z tabulky $tblname se nezdařil - formselsl.tpl!");
				else:
					$pocsl = mysql_num_fields($result);
					for ($i=0;$i<$pocsl;$i++):
						$check = 0;
						$sloupec = mysql_field_name($result,$i);
						echo "<div>\n";
						echo "<label for=\"onsl$i\" class=\"noblock\">".$sloupec."</label>\n";
						for ($j=0;$j<count($polesl);$j++):
							if (trim($polesl[$j]) == trim($sloupec)):
								$check = 1;
								break;
							endif;
						endfor;
						echo "<input type=\"checkbox\" name=\"onsl$i\" id=\"onsl$i\" ".($check ? "checked=\"checked\"" : "")." />\n";
						echo "<input type=\"hidden\" name=\"sl$i\" id=\"sl$i\" value=\"$sloupec\" />\n";
						echo "<label for=\"nazsl\" class=\"noblock\">nadpis sloupce</label>\n";
						echo "<input type=\"text\" name=\"nazsl$i\" id=\"nazsl$i\" value=\"".($check ? trim($polenazsl[$j]) : $sloupec)."\" />\n";
						echo "</div>\n";
					endfor;
				endif;
			?>
			<label for="tblname">Pole pro řazení</label>
			<select name="poleraz" id="poleraz">
				<?php
					for ($i=0;$i<$pocsl;$i++):
						$polesl = mysql_field_name($result,$i);
						echo "<option value=\"".$polesl."\" ".($poleraz == $polesl ? " selected=\"selected\"" : "").">".$polesl."</option>";
					endfor;
				?>
			</select>
			<label for="selview">Zobrazit údaje jako</label>
			<select name="selview" id="selview">
				<option value="adresa" <?php echo (!$tabulka ? " selected=\"selected\"" : "") ?>>adresu</option>
				<option value="tabulka" <?php echo ($tabulka ? " selected=\"selected\"" : "") ?>>tabulku</option>
			</select>
			<div>
			<input type="hidden" name="mtid" value="<?php echo $mtid ?>" />
			<input type="hidden" name="tblname" value="<?php echo $tblname ?>" />
			<input type="hidden" name="pocsl" value="<?php echo $pocsl ?>" />
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>			
		</fieldset>		
	</form>
</div>