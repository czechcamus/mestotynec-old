<?php
ob_start(); /* template body */ ?>    <h2>Správa kategorií</h2> 
	<?php echo $this->scope["filterform"];?>

	<div class="recpagecontrol">
		<?php echo $this->scope["recpagecontent"];?>

	</div>
	<table>
		<col />
		<col class="buttons" />
		<tr>
			<th><a href="?ord=c1u<?php echo $this->scope["filterstring"];?>&amp;<?php echo $this->scope["curl_aid"];?>" title="seřadit vzestupně"><img src="img/<?php echo $this->scope["imgarr"]["col1imgup"];?>.gif" alt="obrázek - šipka nahoru" height="10" width="10" /></a> název <a href="?ord=c1d<?php echo $this->scope["filterstring"];?>&amp;<?php echo $this->scope["curl_aid"];?>" title="seřadit sestupně"><img src="img/<?php echo $this->scope["imgarr"]["col1imgdown"];?>.gif" alt="obrázek - šipka dolů" height="10" width="10" /></a></th>
			<th>&nbsp;</th>
		</tr>
		<?php echo $this->scope["tablecontent"];?>

	</table>
	<div class="recpagecontrol">
		<?php echo $this->scope["recpagecontent"];?>

	</div>
	<p><a href="#container" title="přejít nahoru"><img src="img/goup.gif" alt="obrázek - tlačítko přejít nahoru" height="20" width="20" /></a></p><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>