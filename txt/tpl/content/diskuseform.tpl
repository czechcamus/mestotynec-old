<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	$titulek = $_GET["titulek"];
	$idtema = $_GET["idtema"];
	$idtop = $_GET["idtop"];
	$jmeno = $_GET["jmeno"];
	$email = $_GET["email"];
	$text = $_GET["text"];
	if ($_SESSION["userid"] && !$errnr):
		$record = TblHandler($_SESSION["userid"],"uzivatel");
		$jmeno = $record["jmeno"]." ".$record["prijmeni"];
		$email = $record["email"];
	endif;
	if ($idtop):
		$record = TblHandler($idtop,"zapis");
		$titulek = $record["titulek"];
	endif;
	
	if ($errnr):
		echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
	endif; ?>
	<form action="scripts/checkform.php" method="post">
		<fieldset>
			<legend><?php echo ($idtop ? "Odpověď" : "Příspěvek"); ?></legend>
			<label for="jmeno" class="required">Jméno</label>
			<input type="text" size="50" maxlength="100" name="jmeno" id="jmeno" value="<?php echo $jmeno; ?>" <?php echo ($_SESSION["userid"] ? "disabled=\"disabled\"" : ""); ?> />
			<label for="email">E-mail</label>
			<input type="text" size="50" maxlength="100" name="email" id="email" value="<?php echo $email; ?>" <?php echo ($_SESSION["userid"] ? "disabled=\"disabled\"" : ""); ?> />
			<?php if (!$idtop): ?>
				<label for="titulek" class="required">Název příspěvku</label>
				<input type="text" size="50" maxlength="100" name="titulek" id="titulek" value="<?php echo $titulek; ?>" />
			<?php else: ?>
				<input type="hidden" name="titulek" value="<?php echo $titulek; ?>" />
			<?php endif; ?>
			<label for="text" class="required">Text <?php echo ($idtop ? "odpovědi" : "příspěvku"); ?></label>
			<textarea rows="5" cols="40" name="text" id="text"><?php echo $text ?></textarea>
			<div>Je potřeba vyplnit všechna pole, která jsou nadepsána hnědě!</div>
			<div>
			<input type="hidden" name="form" value="diskuse" />
			<?php if ($_SESSION["userid"]): ?>
				<input type="hidden" name="UserSess" value="<?php echo $strsess; ?>" />
				<input type="hidden" name="jmeno" value="<?php echo $jmeno; ?>" />
				<input type="hidden" name="email" value="<?php echo $email; ?>" />
			<?php endif; ?>
			<input type="hidden" name="idtema" value="<?php echo $idtema; ?>" />
			<input type="hidden" name="idtop" value="<?php echo $idtop; ?>" />
			<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
			<input type="submit" value="zápis" title="tlačítko zapsat" class="subinput" />
			</div>
		</fieldset>
	</form>