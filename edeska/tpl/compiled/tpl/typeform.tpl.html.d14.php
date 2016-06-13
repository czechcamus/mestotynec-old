<?php
ob_start(); /* template body */ ?><h2>Údaje kategorie</h2>
<script type="text/javascript" src="jscripts/editfce_js.js"></script>
<?php if ((isset($this->scope["errorstring"]) ? $this->scope["errorstring"] : null)) {
?>
	<p class="error"><?php echo $this->scope["errorstring"];?></p>
<?php 
}?>

<form method="get" enctype="multipart/form-data" class="editform">
	<fieldset>
		<label for="nazev" class="required">Název *</label>
		<input type="text" name="nazev" id="nazev" size="40" maxlength="255" value="<?php echo $this->scope["nazev"];?>" />
		<?php if ((isset($this->scope["act"]) ? $this->scope["act"] : null) == 'edit') {
?>		
			<input type="hidden" name="idrec" id="idrec" value="<?php echo $this->scope["idrec"];?>" />
		<?php 
}?>

		<div>
		<input type="hidden" name="typelisturl" id="typelisturl" value="<?php echo $this->scope["typelisturl"];?>" />
		<input type="hidden" name="aid" id="aid" value="<?php echo $this->scope["aid"];?>" />
		<input type="hidden" name="act" id="act" value="<?php echo $this->scope["act"];?>" />
		<input type="submit" name="savebtn" value="uložit" class="subinput" />
		<input type="submit" name="savebtn" value="zpět" class="subinput" />
		</div>
	</fieldset>
</form><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>