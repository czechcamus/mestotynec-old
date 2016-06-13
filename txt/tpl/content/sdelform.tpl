<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$pisatel = $_GET["pisatel"];
		$email = $_GET["email"];
		$text = $_GET["text"];
	else:
		$posta = $_GET["posta"];
		if ($_SESSION["userid"] && !$posta):
			$record = TblHandler($_SESSION["userid"],"uzivatel");
			$pisatel = $record["jmeno"]." ".$record["prijmeni"];
			$email = $record["email"];
		endif;
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post">
			<fieldset>
				<label for="pisatel" class="required">Jméno a příjmení pisatele</label>
				<input type="text" size="50" maxlength="100" name="pisatel" id="pisatel" value="<?php echo $pisatel; ?>" />
				<label for="email" class="required">E-mail</label>
				<input type="text" size="50" maxlength="100" name="email" id="email" value="<?php echo $email; ?>" />
				<label for="text" class="required">Text</label>
				<textarea rows="5" cols="40" name="text" id="text"><?php echo $text ?></textarea>
			</fieldset>
			<div>
			<input type="hidden" name="form" value="sdel" />
			<?php if ($_SESSION["userid"]): ?>
				<input type="hidden" name="UserSess" value="<?php echo $strsess; ?>" />
			<?php endif; ?>
			<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
			<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
			</div>
		</form>
	<?php endif; ?>