<?php
  // kontrolni promenna
  $kontrola = mt_rand(1000,9999);

	// naplnění proměnných
	$errnr = $_GET["errnr"];
	$artid = $_GET["artid"];
	if ($errnr):
		$pisatel = $_GET["pisatel"];
		$email = $_GET["email"];
		$text = $_GET["text"];
	else:
		$posta = $_GET["posta"];
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
				<label for="pisatel" class="required">Jméno a příjmení pisatele *</label>
				<input type="text" size="50" maxlength="100" name="pisatel" id="pisatel" value="<?php echo $pisatel; ?>" class="txtinput" />
				<label for="email" class="required">E-mail *</label>
				<input type="text" size="50" maxlength="100" name="email" id="email" value="<?php echo $email; ?>" class="txtinput" />
				<label for="text" class="required">Text *</label>
				<textarea rows="5" cols="40" name="text" id="text" class="txtinput" ><?php echo $text ?></textarea>
  			<label for="kontrolkod" class="required">Kontrolní kód (opište <img src="scripts/kod.php?n=<?php echo $kontrola; ?>">) *</label>
  			<input type="text" size="4" maxlength="4" name="kontrolkod" id="kontrolkod" class="txtinput" value="<?php echo $kontrolkod; ?>" />
				<div>
				<input type="hidden" name="form" value="sdel" />
				<input type="hidden" name="artid" value="<?php echo $artid; ?>" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
  			<input type="hidden" name="kontrola" value="<?php echo $kontrola; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
