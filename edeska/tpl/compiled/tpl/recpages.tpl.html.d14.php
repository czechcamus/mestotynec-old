<?php
ob_start(); /* template body */ ;
if ((isset($this->scope["thispage"]) ? $this->scope["thispage"] : null) != (isset($this->scope["pagenr"]) ? $this->scope["pagenr"] : null)) {
?><a href="?<?php echo $this->scope["urlstring"];?>" title="Přejít na stránku č. <?php echo $this->scope["pagenr"];?>"><?php 
}
echo $this->scope["pagenr"];
if ((isset($this->scope["thispage"]) ? $this->scope["thispage"] : null) != (isset($this->scope["pagenr"]) ? $this->scope["pagenr"] : null)) {
?></a><?php 
}?> <?php  /* end template body */
return $this->buffer . ob_get_clean();
?>