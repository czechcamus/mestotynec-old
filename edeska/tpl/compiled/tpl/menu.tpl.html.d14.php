<?php
ob_start(); /* template body */ ?><ul class="menu1">
  <li<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'recordlist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'recordform') {
?> class="on"<?php 
}?>><div><a href="recordlist.php?<?php echo $this->scope["curl_aid"];?>">správa vyvěšení</a>
  	<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'recordlist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'recordform') {
?>
    <ul>
      <li><div><a href="recordform.php?<?php echo $this->scope["curl_aid"];?>&amp;act=add">přidat vyvěšení</a></div></li>
    </ul>
    <?php 
}?>

  </div></li>
  <li<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'sourcelist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'sourceform') {
?> class="on"<?php 
}?>><div><a href="sourcelist.php?<?php echo $this->scope["curl_aid"];?>">správa původců</a>
  	<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'sourcelist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'sourceform') {
?>
    <ul>
      <li><div><a href="sourceform.php?<?php echo $this->scope["curl_aid"];?>&amp;act=add">přidat původce</a></div></li>
    </ul>
    <?php 
}?>

  </div></li>
  <li<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'typelist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'typeform') {
?> class="on"<?php 
}?>><div><a href="typelist.php?<?php echo $this->scope["curl_aid"];?>">správa kategorií</a>
  	<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'typelist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'typeform') {
?>
    <ul>
      <li><div><a href="typeform.php?<?php echo $this->scope["curl_aid"];?>&amp;act=add">přidat kategorii</a></div></li>
    </ul>
    <?php 
}?>

  </div></li>
  <?php if ((isset($this->scope["admin"]) ? $this->scope["admin"] : null) == 1) {
?>
  <li<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'redactorlist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'redactorform') {
?> class="on"<?php 
}?>><div><a href="redactorlist.php?<?php echo $this->scope["curl_aid"];?>">správa redaktorů</a>
  	<?php if ((isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'redactorlist' || (isset($this->scope["scriptname"]) ? $this->scope["scriptname"] : null) == 'redactorform') {
?>
    <ul>
      <li><div><a href="redactorform.php?<?php echo $this->scope["curl_aid"];?>&amp;act=add">přidat redaktora</a></div></li>
    </ul>
    <?php 
}?>

  </div></li>
  <?php 
}?>

</ul>
<ul class="menu2">  
  <li><div><a href="../edit/">správa městského webu</a></div></li>
</ul><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>