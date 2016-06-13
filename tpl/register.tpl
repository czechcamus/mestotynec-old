<div id="right">
<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$user = $_GET["user"];
		$jmeno = $_GET["jmeno"];
		$prijmeni = $_GET["prijmeni"];
		$titul = $_GET["titul"];
		$ulice = $_GET["ulice"];
		$mesto = $_GET["mesto"];
		$psc = $_GET["psc"];
		$fullreg = $_GET["fullreg"];
		$letter = $_GET["letter"];
	else:
		$uid = $_GET["uid"];
		if ($_SESSION["userid"]):
			$record = TblHandler($_SESSION["userid"],"uzivatel");
			$user = $record["user"];
			$jmeno = $record["jmeno"];
			$prijmeni = $record["prijmeni"];
			$titul = $record["titul"];
			$ulice = $record["ulice"];
			$mesto = $record["mesto"];
			$psc = $record["psc"];
			$email = $record["email"];
			$fullreg = $record["fullreg"];
			$letter = $record["letter"];
		endif;
	endif;
	if (!$_SESSION["userid"]):
		$fullreg = 1;
		$letter = 1;
	endif;
	
	echo "<div class=\"maininfobox\">\n";
	echo "<div class=\"pack\">\n";
	echo "<div class=\"margin\">\n";
	
	if (!$uid): ?>
		<h4>Registrační formulář</h4>
		<?php if (!$_SESSION["userid"]): ?>
			<p>Registrací získáte výhody, které Vám umožní využít více funkcí, které náš web nabízí.</p>
			<p>Zvolíte-li <strong>zkrácenou</strong> registraci, budete moci hlasovat v anketách a dostávat
			newsletter s novinkami.</p>
			<p>Zvolíte-li <strong>plnou</strong> registraci, budete navíc moci soutěžit o ceny a diskutovat
			v diskusním fóru.</p>
			<p>Po vyplnění registračního formuláře obdržíte na Vaši adresu zprávu, ve které bude odkaz na potvrzující
			stránku. Aby byla registrace úspěšně dokončena, musíte ji potvrdit.</p>
		<?php else: ?>
			<p>Po změně e-mailu obdržíte na Vaši adresu zprávu, ve které bude odkaz na potvrzující
			stránku. Aby byla změna úspěšně dokončena, musíte ji potvrdit.</p>
		<?php endif; ?>
		<strong>Upozornění:</strong>
		<p>Je potřeba vyplnit všechna pole nadepsaná hnědě!</p>
		<?php if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" id="registerform">
			<fieldset>
				<legend>Údaje pro zkrácenou i plnou registraci:</legend>
				<label for="user" class="required">Uživatelské jméno</label>
				<input type="text" size="8" maxlength="8" name="user" id="user" value="<?php echo $user; ?>" <?php echo ($_SESSION["userid"] ? "disabled=\"disabled\"" : ""); ?> />
				<label for="pwd" class="required">Heslo</label>
				<input type="password" size="8" maxlength="8" name="pwd" id="pwd" value="<?php echo $pwd; ?>" />
				<label for="pwdagain" class="required">Heslo znovu</label>
				<input type="password" size="8" maxlength="8" name="pwdagain" id="pwdagain" value="<?php echo $pwdagain; ?>" />
				<label for="email" class="required">E-mail</label>
				<input type="text" size="50" maxlength="50" name="email" id="email" value="<?php echo $email; ?>" />
			</fieldset>
			<fieldset>
				<legend>Údaje pro plnou registraci:</legend>
				<label for="jmeno" class="required">Jméno</label>
				<input type="text" size="50" maxlength="50" name="jmeno" id="jmeno" value="<?php echo $jmeno; ?>" />
				<label for="prijmeni" class="required">Příjmení</label>
				<input type="text" size="50" maxlength="50" name="prijmeni" id="prijmeni" value="<?php echo $prijmeni; ?>" />
				<label for="titul">Titul</label>
				<input type="text" size="10" maxlength="15" name="titul" id="titul" value="<?php echo $titul; ?>" />
				<label for="ulice" class="required">Adresa - ulice/obec a č.p.</label>
				<input type="text" size="50" maxlength="50" name="ulice" id="ulice" value="<?php echo $ulice; ?>" />
				<label for="mesto" class="required">Adresa - město/pošta</label>
				<input type="text" size="50" maxlength="50" name="mesto" id="mesto" value="<?php echo $mesto; ?>" />
				<label for="psc" class="required">Adresa - psč</label>
				<input type="text" size="5" maxlength="10" name="psc" id="psc" value="<?php echo $psc; ?>" />
			</fieldset>
			<fieldset>
				<div>
					<input type="checkbox" name="fullreg" id="fullreg" <?php echo ($fullreg ? "checked=\"checked\"" : ""); ?> />
					<label for="fullreg" class="noblock">plná registrace</label>
				</div>
				<div>
					<input type="checkbox" name="letter" id="letter" <?php echo ($letter ? "checked=\"checked\"" : ""); ?> />
					<label for="letter" class="noblock">přeji si dostávat newsletter</label>
				</div>
			</fieldset>
			<div>
				<input type="hidden" name="form" value="register" />
				<?php if ($_SESSION["userid"]): ?>
					<input type="hidden" name="UserSess" value="<?php echo $strsess; ?>" />
					<input type="hidden" name="user" value="<?php echo $user; ?>" />
				<?php endif; ?>
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
			</div>
		</form>
	<?php else: ?>
		<h4>Potvrzení registrace</h4>
		<p>Pokud si přejete registraci potvrdit, stiskněte tlačítko OK. Poté se již budete moci přihlásit pomocí formuláře,
		který je umístěn vlevo nahoře.</p>
		<form action="scripts/registeryes.php" method="get" id="registerform">
			<input type="hidden" name="uid" value="<?php echo $uid; ?>" />
			<input type="submit" value="OK" title="tlačítko OK" class="subinput" />
		</form>
	<?php endif;
	echo "<hr class=\"masterclear\" />\n";
	echo "</div>\n";
	echo "</div>\n";
	echo "</div><!-- end maininfobox -->\n";
	?>
</div>