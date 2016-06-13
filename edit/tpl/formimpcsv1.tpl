<div id="formcontent">
	<?php if (!$errtxt): ?>
		<h3>Import souboru CSV do tabulky - krok 1 ze 2</h3>
	<?php else:
		echo "<h3>".$errtxt."</h3>\n";
	endif; ?>
	<form action="./checkimport.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<label for="csvtmp">Upload souboru CSV *</label>
			<input type="file" accept="text/plain" name="csvtmp" id="csvtmp" />
			<label for="oddelovac">Oddělovač položek v tabulce</label>
			<input type="text" name="oddelovac" id="oddelovac" value="<?php echo $oddelovac ?>" size="1" />
			<div class="filltip">Vyplňte pouze, pokud není oddělovačem implicitní středník ";".</div>
			<label for="tblname">Jméno cílové tabulky *</label>
			<input type="text" name="tblname" id="tblname" value="<?php echo $tblname ?>" size="25" />
			<label for="titulek">Popis obsahu *</label>
			<input type="text" name="titulek" id="titulek" value="<?php echo $titulek ?>" size="50" />
			<div>
			<div>Povinné údaje jsou označené hvězdičkou *</div>
			<input type="hidden" name="step" value="1" />
			<input type="submit" value="pokračovat" />
			</div>
		</fieldset>
	</form>
</div>