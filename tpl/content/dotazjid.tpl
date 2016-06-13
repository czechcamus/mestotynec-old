<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$sdeleni2 = $_GET["sdeleni2"];
		$sdeleni3 = $_GET["sdeleni3"];
	else:
		$posta = $_GET["posta"];
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
				<label for="otazka1">1. Kterou variantu byste zvolili?</label>
        <input type="radio" name="otazka1" value="eurest" class="radioinput" /> Eurest<br />
        <input type="radio" name="otazka1" value="skolni jidelna" class="radioinput" />Školní jídelna<br />
        <label for="sdeleni2">2. Proč jste upřednostnili tuto variantu? (vypište)</label>
        <textarea rows="10" cols="40" name="sdeleni2" id="sdeleni2" class="txtinput" ><?php echo $sdeleni2 ?></textarea><br />
        <label for="sdeleni3">3. Jaké máte výhrady k druhé variantě? (vypište)</label>
        <textarea rows="10" cols="40" name="sdeleni3" id="sdeleni3" class="txtinput" ><?php echo $sdeleni3 ?></textarea>
				<div>
				<input type="hidden" name="form" value="dotazjid" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
