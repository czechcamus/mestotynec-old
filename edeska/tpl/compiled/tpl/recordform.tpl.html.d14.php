<?php
ob_start(); /* template body */ ?><h2>Údaje vyvěšení</h2>
<script type="text/javascript" src="jscripts/editfce_js.js"></script>
<p class="error" id="errorbox"><?php echo $this->scope["errorstring"];?></p>
<form method="post" enctype="multipart/form-data" class="editform">
	<fieldset>
		<label for="nazev" class="required">Titulek vyvěšení *</label>
		<input type="text" name="nazev" id="nazev" size="90" maxlength="255" value="<?php echo $this->scope["nazev"];?>" />
		<label for="text">Textový popis</label>
		<textarea name="text" id="text" rows="4" cols="60"><?php echo $this->scope["text"];?></textarea>
		<label for="znacka">Značka</label>
		<input type="text" name="znacka" id="znacka" size="20" maxlength="50" value="<?php echo $this->scope["znacka"];?>" />
		<label for="id_typ" class="required">Kategorie *</label>
		<select name="id_typ" id="id_typ">
			<?php echo $this->scope["typdata"];?>

		</select>
		<div>
		<label for="datum1" class="noblock required">Zveřejněno od *</label>
		<input type="text" name="datum1" id="datum1" size="10" maxlength="10" value="<?php echo $this->scope["datum1"];?>" onchange="checkValidDate('datum1')"/>
		<label for="lhuta" class="noblock">na lhůtu (dny)</label>
		<input type="text" name="lhuta" id="lhuta" size="3" maxlength="3" value="<?php echo $this->scope["lhuta"];?>" onblur="setEndDate()" />
		<label for="datum2" class="noblock required">do *</label>
		<input type="text" name="datum2" id="datum2" size="10" maxlength="10" value="<?php echo $this->scope["datum2"];?>"  onchange="checkValidDate('datum2')"/> (DD.MM.RRRR)
		</div>
		<label for="id_puvodce" class="required">Původce *</label>
		<select name="id_puvodce" id="id_puvodce">
			<?php echo $this->scope["puvodcedata"];?>

		</select>
		<div>
		<label for="datum3" class="noblock">Zveřejněno u původce od</label>
		<input type="text" name="datum3" id="datum3" size="10" maxlength="10" value="<?php echo $this->scope["datum3"];?>" onchange="checkValidDate('datum3')"/>
		<label for="datum4" class="noblock">do</label>
		<input type="text" name="datum4" id="datum4" size="10" maxlength="10" value="<?php echo $this->scope["datum4"];?>" onchange="checkValidDate('datum4')"/> (DD.MM.RRRR)
		</div>
		<div>
		<label for="version" class="noblock">Aktuální verze</label>
		<input type="text" name="version" id="version" size="2" maxlength="2" value="<?php echo $this->scope["version"];?>" disabled="disabled" />
		</div>
		<label for="docfile">Příloha</label>
		<input type="text" name="docfile" id="docfile" size="40" maxlength="255" value="<?php echo $this->scope["docfile"];?>" />
                <div>
                <label for="istempfile" class="noblock">Dočasný soubor přílohy?</label>
                <input type="checkbox" name="istempfile" id="istempfile"<?php if ((isset($this->scope["istempfile"]) ? $this->scope["istempfile"] : null)) {
?> checked="checked"<?php 
}?> /> Ano
                <input type="hidden" name="idrec" id="idrec" value="<?php echo $this->scope["idrec"];?>" />
                </div>
		<label for="docfiletmp">Upload přílohy</label>
		<input type="file" name="docfiletmp" id="docfiletmp" />
		<?php if ((isset($this->scope["act"]) ? $this->scope["act"] : null) == 'edit') {
?>		
			<div>
			<label for="newversion" class="noblock">Změnit číslo verze?</label>
			<input type="checkbox" name="newversion" id="newversion"<?php if ((isset($this->scope["newversion"]) ? $this->scope["newversion"] : null)) {
?> checked="checked"<?php 
}?> /> Ano
			<input type="hidden" name="idrec" id="idrec" value="<?php echo $this->scope["idrec"];?>" />
			</div>
		<?php 
}?>

		<div>
		<input type="hidden" name="recordlisturl" id="recordlisturl" value="<?php echo $this->scope["recordlisturl"];?>" />
		<input type="hidden" name="aid" id="aid" value="<?php echo $this->scope["aid"];?>" />
		<input type="hidden" name="act" id="act" value="<?php echo $this->scope["act"];?>" />
		<input type="submit" name="savebtn" value="uložit" class="subinput" />
		<input type="submit" name="savebtn" value="zpět" class="subinput" />
		</div>
	</fieldset>
</form><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>