<?php
ob_start(); /* template body */ ?><form method="get" enctype="multipart/form-data" id="filterform">
	<fieldset>
		<label for="filtercol"><strong>Filtr</strong> - sloupec: </label>
		<select name="filtercol" id="filtercol">
			<?php 
$_fh0_data = (isset($this->scope["colarr"]) ? $this->scope["colarr"] : null);
if ($this->isArray($_fh0_data) === true)
{
	foreach ($_fh0_data as $this->scope['colname'])
	{
/* -- foreach start output */
?>
			    <option<?php if ((isset($this->scope["filtercol"]) ? $this->scope["filtercol"] : null) == (isset($this->scope["colname"]) ? $this->scope["colname"] : null)) {
?> selected="selected"<?php 
}?>><?php echo $this->scope["colname"];?></option>
			<?php 
/* -- foreach end output */
	}
}?>

		</select>
		<label for="filterval">hodnota: </label>
		<input type="text" name="filterval" id="filterval" value="<?php echo $this->scope["filterval"];?>" width="25" maxlength="250" class="txtinput" />
		<input type="hidden" name="ord" id="ord" value="<?php echo $this->scope["ord"];?>" />
		<input type="hidden" name="aid" id="aid" value="<?php echo $this->scope["aid"];?>" />
		<input type="submit" name="submitbutton" value="nastavit filtr" class="subinput" />
		<input type="submit" name="submitbutton" value="zrušit filtr" class="subinput" />
	</fieldset>
</form><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>