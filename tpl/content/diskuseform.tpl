<?php
  // kontrolni promenna
  $kontrola = mt_rand(1000,9999);

	// naplnění proměnných
	$errnr = $_GET["errnr"];
	$titulek = $_GET["titulek"];
	$idtema = $_GET["idtema"];
	$idtop = $_GET["idtop"];
	$jmeno = $_GET["jmeno"];
	$email = $_GET["email"];
	$text = $_GET["text"];
	if ($idtop):
		$record = TblHandler($idtop,"zapis");
		$titulek = $record["titulek"];
	endif;
	
	if ($errnr):
		echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
	endif;
  echo "<h4>".($idtop ? "Odpověď" : "Příspěvek")."</h4>\n";
  ?>
	<form action="scripts/checkform.php" method="post" class="publicform">
		<fieldset>
			<label for="jmeno" class="required">Jméno *</label>
			<input type="text" size="50" maxlength="100" name="jmeno" id="jmeno" class="txtinput" value="<?php echo $jmeno; ?>" />
			<label for="email">E-mail</label>
			<input type="text" size="50" maxlength="100" name="email" id="email" class="txtinput" value="<?php echo $email; ?>" />
			<?php if (!$idtop): ?>
				<label for="titulek" class="required">Název příspěvku *</label>
				<input type="text" size="50" maxlength="100" name="titulek" id="titulek" class="txtinput" value="<?php echo $titulek; ?>" />
			<?php else: ?>
				<input type="hidden" name="titulek" value="<?php echo $titulek; ?>" />
			<?php endif; ?>
			<label for="text" class="required">Text <?php echo ($idtop ? "odpovědi" : "příspěvku"); ?> *</label>
			<textarea rows="5" cols="60" name="text" class="txtinput" id="text"><?php echo $text ?></textarea>
			<label for="kontrolkod" class="required">Kontrolní kód (opište <img src="scripts/kod.php?n=<?php echo $kontrola; ?>">) *</label>
			<input type="text" size="4" maxlength="4" name="kontrolkod" id="kontrolkod" class="txtinput" value="<?php echo $kontrolkod; ?>" />
			<div>Je potřeba vyplnit všechna pole, která jsou nadepsána červeně a označena hvězdičkou (*)!</div>
			<div>
			<input type="hidden" name="form" value="diskuse" />
			<input type="hidden" name="idtema" value="<?php echo $idtema; ?>" />
			<input type="hidden" name="idtop" value="<?php echo $idtop; ?>" />
			<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
			<input type="hidden" name="kontrola" value="<?php echo $kontrola; ?>" />
			<input type="submit" value="zápis" title="tlačítko zapsat" class="subinput" />
			</div>
		</fieldset>
	</form>
