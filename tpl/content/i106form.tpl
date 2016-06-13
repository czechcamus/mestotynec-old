<?php
  // kontrolni promenna
  $kontrola = mt_rand(1000,9999);

	// naplnění proměnných
	$errnr = $_GET["errnr"];
	$artid = $_GET["artid"];
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
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
				<label for="zadatel" class="required">Žadatel (jméno a příjmení nebo název organizace) *</label>
				<input type="text" size="50" maxlength="100" name="zadatel" id="zadatel" value="<?php echo $zadatel; ?>" class="txtinput" />
				<label for="vyrizuje">Vyřizuje (jméno a příjmení)</label>
				<input type="text" size="50" maxlength="100" name="vyrizuje" id="vyrizuje" value="<?php echo $vyrizuje; ?>" class="txtinput" />
				<label for="ulice" class="required">Adresa - ulice/obec a č.p. *</label>
				<input type="text" size="50" maxlength="100" name="ulice" id="ulice" value="<?php echo $ulice; ?>" class="txtinput" />
				<label for="mesto" class="required">Adresa - město/pošta *</label>
				<input type="text" size="50" maxlength="100" name="mesto" id="mesto" value="<?php echo $mesto; ?>" class="txtinput" />
				<label for="psc" class="required">Adresa - psč *</label>
				<input type="text" size="5" maxlength="10" name="psc" id="psc" value="<?php echo $psc; ?>" class="txtinput" />
				<label for="telefon">Telefon</label>
				<input type="text" size="10" maxlength="10" name="telefon" id="telefon" value="<?php echo $telefon; ?>" class="txtinput" />
				<label for="fax">Fax</label>
				<input type="text" size="10" maxlength="10" name="fax" id="fax" value="<?php echo $fax; ?>" class="txtinput" />
				<label for="email" class="required">E-mail *</label>
				<input type="text" size="50" maxlength="100" name="email" id="email" value="<?php echo $email; ?>" class="txtinput" />
				<label for="text" class="required">Text *</label>
				<textarea rows="5" cols="40" name="text" id="text" class="txtinput" ><?php echo $text ?></textarea>
				<label for="doruceni" class="required">Způsob doručení odpovědi *</label>
				<select name="doruceni" id="doruceni" class="txtinput">
					<option value="email" <?php echo ($doruceni == "email" ? "selected=\"selected\"" : "")?>>e-mailem</option>
					<option value="posta" <?php echo ($doruceni == "posta" ? "selected=\"selected\"" : "")?>>poštou</option>
					<option value="fax" <?php echo ($doruceni == "fax" ? "selected=\"selected\"" : "")?>>faxem</option>
				</select>
  			<label for="kontrolkod" class="required">Kontrolní kód (opište <img src="scripts/kod.php?n=<?php echo $kontrola; ?>">) *</label>
  			<input type="text" size="4" maxlength="4" name="kontrolkod" id="kontrolkod" class="txtinput" value="<?php echo $kontrolkod; ?>" />
				<div>
				<input type="hidden" name="form" value="i106" />
				<input type="hidden" name="artid" value="<?php echo $artid; ?>" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
  			<input type="hidden" name="kontrola" value="<?php echo $kontrola; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
