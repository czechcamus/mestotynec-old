<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$sdeleni11 = $_GET["sdeleni11"];
		$sdeleni12 = $_GET["sdeleni12"];
		$sdeleni13 = $_GET["sdeleni13"];
		$sdeleni14 = $_GET["sdeleni14"];    		
		$sdeleni15 = $_GET["sdeleni15"];    		
		$sdeleni16 = $_GET["sdeleni16"];    		
	else:
		$posta = $_GET["posta"];
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
        <label for="sdeleni11">1. S čím jsem v MC Motýlek spokojená/ý?</label>
        <textarea rows="10" cols="70" name="sdeleni11" id="sdeleni11" class="txtinput" ><?php echo $sdeleni11 ?></textarea><br />
        <label for="sdeleni12">2. Co bych dělal(a) jinak? </label>
        <textarea rows="10" cols="70" name="sdeleni12" id="sdeleni12" class="txtinput" ><?php echo $sdeleni12 ?></textarea>
        <label for="sdeleni13">3. Co se mi vůbec nelíbí?</label>
        <textarea rows="10" cols="70" name="sdeleni13" id="sdeleni13" class="txtinput" ><?php echo $sdeleni13 ?></textarea><br />
        <label for="sdeleni14">4. Jaké navrhuji změny?</label>
        <textarea rows="10" cols="70" name="sdeleni14" id="sdeleni14" class="txtinput" ><?php echo $sdeleni14 ?></textarea><br />
        <label for="sdeleni15">5. Co já osobně pro ty změny mohu udělat?</label>
        <textarea rows="10" cols="70" name="sdeleni15" id="sdeleni15" class="txtinput" ><?php echo $sdeleni15 ?></textarea><br />
        <label for="sdeleni16">6. Co mě baví dělat, jaké mám schopnosti, znalosti, co jsem schopna/schopen MC nabídnout?</label>
        <textarea rows="10" cols="70" name="sdeleni16" id="sdeleni16" class="txtinput" ><?php echo $sdeleni16 ?></textarea><br />
        <label for="sdeleni17">7. Kontakt na Vás (pokud nám chcete pomoci, ozveme se Vám) - nepovinné  </label>
        <textarea rows="10" cols="70" name="sdeleni17" id="sdeleni17" class="txtinput" ><?php echo $sdeleni17 ?></textarea><br />
				<div>
				<input type="hidden" name="form" value="dotazmc" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
