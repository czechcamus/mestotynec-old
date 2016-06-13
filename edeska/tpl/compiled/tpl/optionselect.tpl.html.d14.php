<?php
ob_start(); /* template body */ ?><option value="<?php echo $this->scope["idoption"];?>"<?php if ((isset($this->scope["idoption"]) ? $this->scope["idoption"] : null) == (isset($this->scope["idselect"]) ? $this->scope["idselect"] : null)) {
?> selected="selected"<?php 
}?>><?php echo $this->scope["titleoption"];?></option><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>