<?php
// naplnění proměnných
$errnr = $_GET["errnr"];
if ( $errnr ):
	$jmenoprijmeni = $_GET['jmenoprijmeni'];
	$adresa = $_GET['adresa'];
	$mistnicast = $_GET['mistnicast'];
	$problemyvydatnost = $_GET['problemyvydatnost'];
	$problemyvydatnostpopis = $_GET['problemyvydatnostpopis'];
	$problemykvalita = $_GET['problemykvalita'];
	$problemykvalitapopis = $_GET['problemykvalitapopis'];
	$typstudny = $_GET['typstudny'];
	$hloubkastudny = $_GET['hloubkastudny'];
	$vodnisloupec = $_GET['vodnisloupec'];
	$pocetosob = $_GET['pocetosob'];
	$pripojenivodovod = $_GET['pripojenivodovod'];
else:
	$jmenoprijmeni = '';
	$adresa = '';
	$mistnicast = '';
	$problemyvydatnost = 'ne';
	$problemyvydatnostpopis = '';
	$problemykvalita = 'ne';
	$problemykvalitapopis = '';
	$typstudny = 'kopana';
	$hloubkastudny = '';
	$vodnisloupec = '';
	$pocetosob = '';
	$pripojenivodovod = 'ne';
	$posta = $_GET["posta"];
endif;

if ( ! $posta ):
	if ( $errnr ):
		echo "<p class=\"error\">" . VypisChybu( $errnr ) . "</p>\n";
	endif; ?>
	<form action="scripts/checkform.php" method="post" class="publicform">
		<fieldset>
			<label for="jmenoprijmeni">Jméno a příjmení:</label>
			<input type="text" name="jmenoprijmeni" id="jmenoprijmeni" class="txtinput" size="80" value="<?php echo $jmenoprijmeni; ?>" />
			<label for="adresa">Adresa:</label>
			<input type="text" name="adresa" id="adresa" class="txtinput" size="80" value="<?php echo $adresa; ?>" />
			<label for="mistnicast">Místní část:</label>
			<input type="text" name="mistnicast" id="mistnicast" class="txtinput" size="80" value="<?php echo $mistnicast; ?>" />
		</fieldset>
		<fieldset>
			<h3>Informace o zdrojích pitné vody</h3>
			<label for="problemyvydatnost">Máte problémy s pitnou vodou z pohledu množství (vydatnosti zdroje)?</label>
			<input type="radio" name="problemyvydatnost" value="ano" class="radioinput"<?php echo $problemyvydatnost == "ano" ? " checked" : ""; ?> /> ano
			<input type="radio" name="problemyvydatnost" value="ne" class="radioinput"<?php echo $problemyvydatnost == "ne" ? " checked" : ""; ?> /> ne
			<label for="problemyvydatnostpopis">Krátce problémy popište:</label>
			<textarea rows="3" cols="60" name="problemyvydatnostpopis" id="problemyvydatnostpopis" class="txtinput"><?php echo $problemyvydatnostpopis ?></textarea>
			<label for="problemykvalita">Máte problémy s pitnou vodou z pohledu kvality?</label>
			<input type="radio" name="problemykvalita" value="ano" class="radioinput"<?php echo $problemykvalita == "ano" ? " checked" : ""; ?> /> ano
			<input type="radio" name="problemykvalita" value="ne" class="radioinput"<?php echo $problemykvalita == "ne" ? " checked" : ""; ?> /> ne
			<label for="problemykvalitapopis">Krátce problémy popište:</label>
			<textarea rows="3" cols="60" name="problemykvalitapopis" id="problemykvalitapopis" class="txtinput"><?php echo $problemykvalitapopis ?></textarea>
			<label for="typstudny">Typ Vaší studny</label>
			<input type="radio" name="typstudny" value="vrtana" class="radioinput"<?php echo $typstudny == "vrtana" ? " checked" : ""; ?> /> vrtaná
			<input type="radio" name="typstudny" value="kopana" class="radioinput"<?php echo $typstudny == "kopana" ? " checked" : ""; ?> /> kopaná<br />
			<label for="hloubkastudny" class="noblock">Hloubka studny (vrtu) v metrech:</label>
			<input type="text" name="hloubkastudny" id="hloubkastudny" class="txtinput noblock" size="3" /><br />
			<label for="vodnisloupec" class="noblock">Aktuální výška vodního sloupce v metrech:</label>
			<input type="text" name="vodnisloupec" id="vodnisloupec" class="txtinput noblock" size="3" /><br />
			<label for="pocetosob" class="noblock">Kolik trvale bydlících obyvatel studna zásobuje?:</label>
			<input type="text" name="pocetosob" id="pocetosob" class="txtinput noblock" size="3" /><br /><br />
			<label for="pripojenivodovod">Máte zájem o výhledové připojení na veřejný vodovod?</label>
			<input type="radio" name="pripojenivodovod" value="ano" class="radioinput"<?php echo $pripojenivodovod == "ano" ? " checked" : ""; ?> /> ano
			<input type="radio" name="pripojenivodovod" value="ne" class="radioinput"<?php echo $pripojenivodovod == "ano" ? " checked" : ""; ?> /> ne
		</fieldset>
		<fieldset>
			<div>
				<input type="hidden" name="form" value="dotazvoda"/>
				<input type="hidden" name="fp" value="<?php echo $fp; ?>"/>
				<input type="hidden" name="artid" value="<?php echo $artid; ?>"/>
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput"/>
			</div>
		</fieldset>
	</form>
<?php endif; ?>
