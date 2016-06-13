<?php
ob_start(); /* template body */ ?><h2>Opravdu chcete smazat <?php echo $this->scope["deletetitle"];?>?</h2>
<form method="get" enctype="multipart/form-data" id="deleteform" class="editform">
	<fieldset>
		<input type="hidden" name="idrec" id="idrec" value="<?php echo $this->scope["idrec"];?>" />
		<input type="hidden" name="aid" id="aid" value="<?php echo $this->scope["aid"];?>" />
		<input type="hidden" name="act" id="act" value="delete" />
		<input type="hidden" name="urlstring" id="urlstring" value="<?php echo $this->scope["urlstring"];?>" />
		<input type="submit" name="savebtn" value="ano" class="subinput" />
		<input type="submit" name="savebtn" value="ne" class="subinput" />
	</fieldset>
</form><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>