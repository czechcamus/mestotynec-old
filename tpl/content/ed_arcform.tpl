<?php
	// naplnění proměnných
	$arcdatum = (isset($_GET["arcdatum"]) ? $_GET["arcdatum"] : "");
	$arctime = (isset($_GET["arctime"]) ? $_GET["arctime"] : "");
	if ($arcdatum):
    $errorstring = CheckValidDate(array($arcdatum));
    if ($errorstring):
      unset($_GET['sel']);
      echo "<p class=\"error\">$errorstring</p>\n";  
    endif;	   
	endif;
?>	
		<form method="get" class="publicform">
			<fieldset>
				<label for="arcdatum" class="noblock">Datum (DD.MM.RRRR)</label>
				<input type="text" size="10" maxlength="10" name="arcdatum" id="arcdatum" value="<?php echo $arcdatum; ?>" class="txtinput noblock" />
				<label for="arctime" class="noblock">Čas (HH:MM:SS)</label>
				<input type="text" size="8" maxlength="8" name="arctime" id="arctime" value="<?php echo $arctime; ?>" class="txtinput noblock" />
				<div>
				<input type="hidden" name="sel" value="1" />
				<input type="hidden" name="idform" value="arc" />
				<input type="submit" value="provést výběr" title="tlačítko provést výběr" class="subinput" />
				</div>
			</fieldset>
		</form>
