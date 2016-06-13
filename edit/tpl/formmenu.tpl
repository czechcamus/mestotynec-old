<div id="formcontent">
<?php
	// načtení hodnot pro editaci
	if ($akce == "edit"):
	// načtení obsahu
		$dotaz = "SELECT * FROM $tbl WHERE id=$itemid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst obsah - formmenu.tpl!");
		else:
			$record = mysql_fetch_array($result);
			$titulek = $record["titulek"];
			$filename = $record["filename"];
			$level = $record["level"];
			$idtop = $record["idtop"];
			$oldfilename = $filename;
			$pozice =  $record["pozice"];
			$obsah = $record["obsah"];
		endif;
		echo "<h3>Editace položky menu</h3>";
	else:
		$pozice = GetNewPozice("menu",$menuid);
		$level = GetLevelMenu($menuid);
		echo "<h3>Přidání položky do menu</h3>";
	endif;
?>
	<form action="./changetbl.php" method="post">
		<fieldset>
			<label for="titulek">Titulek položky menu</label>
			<input type="text" name="titulek" id="titulek" value="<?php echo $titulek ?>" size="75" maxlength="150" />
			<?php if (!$level): ?>
				<div class="filltip">Chcete-li označit nějaký znak jako &quot;horkou klávesu&quot;, uzavřete jej do kulatých závorek ().</div>
			<?php endif; ?>
			<label for="obsah">Popis obsahu položky menu</label>
			<textarea rows="5" cols="60" name="obsah" id="obsah"><?php echo $obsah ?></textarea>
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="pozice" value="<?php echo $pozice ?>" />
			<input type="hidden" name="level" value="<?php echo $level ?>" />
			<input type="hidden" name="menuid" value="<?php echo $menuid ?>" />
			<input type="hidden" name="filename" value="<?php echo $filename ?>" />
			<input type="hidden" name="oldfilename" value="<?php echo $oldfilename ?>" />
			<input type="hidden" name="tbl" value="menu" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="uložit" />
			</div>
		</fieldset>
	</form>
</div>