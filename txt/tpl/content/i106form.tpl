<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$zadatel = $_GET["zadatel"];
		$vyrizuje = $_GET["vyrizuje"];
		$ulice = $_GET["ulice"];
		$mesto = $_GET["mesto"];
		$psc = $_GET["psc"];
		$telefon = $_GET["telefon"];
		$fax = $_GET["fax"];
		$email = $_GET["email"];
		$text = $_GET["text"];
		$doruceni = $_GET["doruceni"];
	else:
		$posta = $_GET["posta"];
		if ($_SESSION["userid"] && !$posta):
			$record = TblHandler($_SESSION["userid"],"uzivatel");
			$zadatel = $record["jmeno"]." ".$record["prijmeni"];
			$vyrizuje = $zadatel;
			$ulice = $record["ulice"];
			$mesto = $record["mesto"];
			$psc = $record["psc"];
			$email = $record["email"];
		endif;
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p>".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post">
			<fieldset>
				<label for="zadatel" class="required">Žadatel (jméno a příjmení nebo název organizace)</label>
				<input type="text" size="50" maxlength="100" name="zadatel" id="zadatel" value="<?php echo $zadatel; ?>" />
				<label for="vyrizuje">Vyřizuje (jméno a příjmení)</label>
				<input type="text" size="50" maxlength="100" name="vyrizuje" id="vyrizuje" value="<?php echo $vyrizuje; ?>" />
				<label for="ulice" class="required">Adresa - ulice/obec a č.p.</label>
				<input type="text" size="50" maxlength="100" name="ulice" id="ulice" value="<?php echo $ulice; ?>" />
				<label for="mesto" class="required">Adresa - město/pošta</label>
				<input type="text" size="50" maxlength="100" name="mesto" id="mesto" value="<?php echo $mesto; ?>" />
				<label for="psc" class="required">Adresa - psč</label>
				<input type="text" size="5" maxlength="10" name="psc" id="psc" value="<?php echo $psc; ?>" />
				<label for="telefon">Telefon</label>
				<input type="text" size="10" maxlength="10" name="telefon" id="telefon" value="<?php echo $telefon; ?>" />
				<label for="fax">Fax</label>
				<input type="text" size="10" maxlength="10" name="fax" id="fax" value="<?php echo $fax; ?>" />
				<label for="email" class="required">E-mail</label>
				<input type="text" size="50" maxlength="100" name="email" id="email" value="<?php echo $email; ?>" />
				<label for="text" class="required">Text</label>
				<textarea rows="5" cols="40" name="text" id="text"><?php echo $text ?></textarea>
				<label for="doruceni" class="required">Způsob doručení odpovědi</label>
				<select name="doruceni" id="doruceni">
					<option value="email" <?php echo ($doruceni == "email" ? "selected=\"selected\"" : "")?>>e-mailem</option>
					<option value="posta" <?php echo ($doruceni == "posta" ? "selected=\"selected\"" : "")?>>poštou</option>
					<option value="fax" <?php echo ($doruceni == "fax" ? "selected=\"selected\"" : "")?>>faxem</option>
				</select>
			</fieldset>
			<div>
			<input type="hidden" name="form" value="i106" />
			<?php if ($_SESSION["userid"]): ?>
				<input type="hidden" name="UserSess" value="<?php echo $strsess; ?>" />
			<?php endif; ?>
			<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
			<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
			</div>
		</form>
	<?php endif; ?>