<?php
ob_start(); /* template body */ ?><tr<?php if ((isset($this->scope["editable"]) ? $this->scope["editable"] : null) == 0) {
?> class='oldver'<?php 
}?>><td><?php echo $this->scope["nazev"];?></td><td><?php echo $this->scope["znacka"];?></td><td><?php echo $this->scope["typ"];?></td><td class='textcenter'><?php echo $this->scope["verze"];?></td><td><?php echo $this->scope["puvodce"];?></td><td class='textcenter'><?php echo $this->scope["zverejneni_od"];?></td><td class='textcenter'><?php echo $this->scope["zverejneni_do"];?></td><td class="buttons"><?php if ((isset($this->scope["editable"]) ? $this->scope["editable"] : null) == 1) {
?><a href="recordform.php?<?php echo $this->scope["curl_aid"];?>&amp;idrec=<?php echo $this->scope["id"];?>&amp;act=edit" title="upravit"><img src="img/edit.gif" alt="obrázek - tlačítko upravit" height="20" width="20" /></a> <a href="?<?php echo $this->scope["curl_aid"];?>&amp;idrec=<?php echo $this->scope["id"];?>&amp;act=delete" title="smazat"><img src="img/delete.gif" alt="obrázek - tlačítko smazat" height="20" width="20" /></a><?php 
}?></td></tr><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>