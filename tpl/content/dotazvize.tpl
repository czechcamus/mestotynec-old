<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$sdeleni1 = $_GET["sdeleni1"];
        $sdeleni2 = $_GET["sdeleni2"];
		$otazka31txt = $_GET["otazka31txt"];
		$otazka32txt = $_GET["otazka32txt"];    
		$otazka33txt = $_GET["otazka33txt"];    
		$otazka34txt = $_GET["otazka34txt"];    
		$otazka35txt = $_GET["otazka35txt"];    
		$otazka36txt = $_GET["otazka36txt"];
        $otazka6txt = $_GET["otazka6txt"];
	else:
		$posta = $_GET["posta"];
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
        <label for="sdeleni1">1. V roce 2030 bych si v Týnci přál(a)</label>
        <textarea rows="10" cols="70" name="sdeleni1" id="sdeleni1" class="txtinput" ><?php echo $sdeleni1 ?></textarea>
        <label for="sdeleni2">2. V roce 2020 bych si v Týnci přál(a)</label>
        <textarea rows="10" cols="70" name="sdeleni2" id="sdeleni2" class="txtinput" ><?php echo $sdeleni2 ?></textarea>
  			<label for="otazka3">3. Přiřaďte následujícím oblastem pro život města pořadí od jedné do šesti dle důležitosti (1 = nejdůležitější) </label>
        <input type="text" size="20" maxlength="100" name="otazka31txt" id="otazka31txt" value="<?php echo $otazka31txt; ?>" class="txtinput noblock" /> <label for="otazka31txt" class="noblock">služby </label> <br />
  			<input type="text" size="20" maxlength="100" name="otazka32txt" id="otazka32txt" value="<?php echo $otazka32txt; ?>" class="txtinput noblock" /> <label for="otazka32txt" class="noblock">doprava </label> <br />
        <input type="text" size="20" maxlength="100" name="otazka33txt" id="otazka33txt" value="<?php echo $otazka33txt; ?>" class="txtinput noblock" /> <label for="otazka33txt" class="noblock">zaměstnání </label> <br />
        <input type="text" size="20" maxlength="100" name="otazka34txt" id="otazka34txt" value="<?php echo $otazka34txt; ?>" class="txtinput noblock" /> <label for="otazka34txt" class="noblock">volný čas </label> <br />
        <input type="text" size="20" maxlength="100" name="otazka35txt" id="otazka35txt" value="<?php echo $otazka35txt; ?>" class="txtinput noblock" /> <label for="otazka35txt" class="noblock">kultura </label> <br />
        <input type="text" size="20" maxlength="100" name="otazka36txt" id="otazka36txt" value="<?php echo $otazka36txt; ?>" class="txtinput noblock" /> <label for="otazka36txt" class="noblock">jiné (vypište pořadí a název) </label> <br />
        <label for="otazka4">4. Jste</label>
        <input type="radio" name="otazka4" value="muz" class="radioinput" /> muž<br />
	      <input type="radio" name="otazka4" value="zena" class="radioinput" /> žena<br />
  			<label for="otazka5">5. Kolik je Vám let?</label>
        <input type="radio" name="otazka5" value="0 - 10" class="radioinput" /> 0 - 10<br />
        <input type="radio" name="otazka5" value="11 - 20" class="radioinput" /> 11 - 20<br />
        <input type="radio" name="otazka5" value="19 - 30" class="radioinput" /> 21 - 30<br />
        <input type="radio" name="otazka5" value="31 - 40" class="radioinput" /> 31 - 40<br />
        <input type="radio" name="otazka5" value="41 - 50" class="radioinput" /> 41 - 50<br />
        <input type="radio" name="otazka5" value="51 - 60" class="radioinput" /> 51 - 60<br />
        <input type="radio" name="otazka5" value="61 - 70" class="radioinput" /> 61 - 70<br />
        <input type="radio" name="otazka5" value="71 - 80" class="radioinput" /> 71 - 80<br />
        <input type="radio" name="otazka5" value="více než 80" class="radioinput" /> více než 80<br />        
        <label for="otazka6">6. Kolik let bydlíte v Týnci?</label>
        <input type="text" size="20" maxlength="100" name="otazka6txt" id="otazka6txt" value="<?php echo $otazka6txt; ?>" class="txtinput noblock" /> <label for="otazka6txt" class="noblock"></label> <br />
        <label for="otazka7">7. Bydlíte</label>
        <input type="radio" name="otazka7" value="ve vlastním rodinnem dome" class="radioinput" /> ve vlastním rodinném domě<br />
        <input type="radio" name="otazka7" value="ve vlastnim byte" class="radioinput" /> ve vlastním bytě<br />
        <input type="radio" name="otazka7" value="v najmu" class="radioinput" /> v nájmu<br />
        <label for="otazka8">8. Bydlíte</label>
        <input type="radio" name="otazka8" value="ve meste" class="radioinput" /> ve městě<br />
        <input type="radio" name="otazka8" value="v mistni casti" class="radioinput" /> v místní části<br />
				<div>
				<input type="hidden" name="form" value="dotazvize" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
