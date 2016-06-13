<?php
ob_start(); /* template body */ ?><h2>Údaje redaktora</h2>
<?php if ((isset($this->scope["errorstring"]) ? $this->scope["errorstring"] : null)) {
?>
	<p class="error"><?php echo $this->scope["errorstring"];?></p>
<?php 
}?>

<form method="get" enctype="multipart/form-data" class="editform">
	<fieldset>
		<label for="user" class="required">Uživatelské jméno *</label>
		<input type="text" size="8" name="user" id="user" value="<?php echo $this->scope["user"];?>" maxlength="20" />
		<label for="pwd" class="required">Uživatelské heslo *</label>
		<input type="text" size="8" name="pwd" id="pwd" value="<?php echo $this->scope["pwd"];?>" maxlength="8" />
		<label for="jmeno" class="required">Jméno *</label>
		<input type="text" size="50" name="jmeno" id="jmeno" value="<?php echo $this->scope["jmeno"];?>" maxlength="50" />
		<label for="prijmeni" class="required">Příjmení *</label>
		<input type="text" size="50" name="prijmeni" id="prijmeni" value="<?php echo $this->scope["prijmeni"];?>" maxlength="50" />
		<label for="email" class="required">E-mail *</label>
		<input type="text" size="20" name="email" id="email" value="<?php echo $this->scope["email"];?>" maxlength="50" />
		<div>
		<?php if ((isset($this->scope["act"]) ? $this->scope["act"] : null) == 'edit') {
?>
			<input type="hidden" name="idrec" id="idrec" value="<?php echo $this->scope["idrec"];?>" />
		<?php 
}?>

		<input type="hidden" name="redactorlisturl" id="redactorlisturl" value="<?php echo $this->scope["redactorlisturl"];?>" />
		<input type="hidden" name="aid" id="aid" value="<?php echo $this->scope["aid"];?>" />
		<input type="hidden" name="act" id="act" value="<?php echo $this->scope["act"];?>" />
		<input type="submit" name="savebtn" value="uložit" class="subinput" />
		<input type="submit" name="savebtn" value="zpět" class="subinput" />
		</div>
	</fieldset>
</form><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>