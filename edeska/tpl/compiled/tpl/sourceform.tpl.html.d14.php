<?php
ob_start(); /* template body */ ?><h2>Údaje původce</h2>
<script type="text/javascript" src="jscripts/editfce_js.js"></script>
<?php if ((isset($this->scope["errorstring"]) ? $this->scope["errorstring"] : null)) {
?>
	<p class="error"><?php echo $this->scope["errorstring"];?></p>
<?php 
}?>

<form method="get" enctype="multipart/form-data" class="editform">
	<fieldset>
		<label for="nazev" class="required">Název původce *</label>
		<input type="text" name="nazev" id="nazev" size="40" maxlength="255" value="<?php echo $this->scope["nazev"];?>" />
		<label for="ulice">Ulice</label>
		<input type="text" name="ulice" id="ulice" size="40" maxlength="255" value="<?php echo $this->scope["ulice"];?>" />
		<label for="misto">Místo</label>
		<input type="text" name="misto" id="misto" size="40" maxlength="255" value="<?php echo $this->scope["misto"];?>" />
		<label for="psc">PSČ</label>
		<input type="text" name="psc" id="psc" size="6" maxlength="6" value="<?php echo $this->scope["psc"];?>" />
		<div>
		<label for="udvlastnik" class="noblock">Vlastník této úřední desky?</label>
		<input type="checkbox" name="udvlastnik" id="udvlastnik"<?php if ((isset($this->scope["udvlastnik"]) ? $this->scope["udvlastnik"] : null)) {
?> checked="checked"<?php 
}?> /> Ano
		</div>
		<?php if ((isset($this->scope["act"]) ? $this->scope["act"] : null) == 'edit') {
?>		
			<input type="hidden" name="idrec" id="idrec" value="<?php echo $this->scope["idrec"];?>" />
		<?php 
}?>

		<div>
		<input type="hidden" name="sourcelisturl" id="sourcelisturl" value="<?php echo $this->scope["sourcelisturl"];?>" />
		<input type="hidden" name="aid" id="aid" value="<?php echo $this->scope["aid"];?>" />
		<input type="hidden" name="act" id="act" value="<?php echo $this->scope["act"];?>" />
		<input type="submit" name="savebtn" value="uložit" class="subinput" />
		<input type="submit" name="savebtn" value="zpět" class="subinput" />
		</div>
	</fieldset>
</form><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>