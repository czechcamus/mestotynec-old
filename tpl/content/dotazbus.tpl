<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$otazka4opt1txt = $_GET["otazka4opt1txt"];
		$otazka6opt2txt = $_GET["otazka6opt2txt"];
		$sdeleni = $_GET["sdeleni"];
	else:
		$posta = $_GET["posta"];
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
				<label for="otazka1">1. Jak často využíváte veřejné dopravní prostředky?</label>
        <input type="radio" name="otazka1" value="denne" class="radioinput" /> denně<br />
        <input type="radio" name="otazka1" value="2-4x tydne" class="radioinput" /> 2-4x týdně<br />
        <input type="radio" name="otazka1" value="2-4x mesicne" class="radioinput" /> 2-4x měsíčně<br />
        <input type="radio" name="otazka1" value="vyjimecne" class="radioinput" /> výjimečně<br />
        <input type="radio" name="otazka1" value="nikdy" class="radioinput" /> nikdy<br />
				<label for="otazka2">2. Častěji jezdíte:</label>
        <input type="radio" name="otazka2" value="vlakem" class="radioinput" /> vlakem<br />
        <input type="radio" name="otazka2" value="autobusem (Connex - 339)" class="radioinput" /> autobusem (Connex - 339)<br />
        <input type="radio" name="otazka2" value="autobusem (CSAD Benesov)" class="radioinput" /> autobusem (ČSAD Benešov)<br />
        <input type="radio" name="otazka2" value="kombinuji vlak i autobus" class="radioinput" /> kombinuji vlak i autobus<br />
        <input type="radio" name="otazka2" value="jiný zpusob dopravy" class="radioinput" /> jiný způsob dopravy<br />        
				<label for="otazka3">3. Je kapacita dopravního prostředku dostatečná?</label>
        <input type="radio" name="otazka3" value="vetsinou vzdy sedim" class="radioinput" /> většinou vždy sedím<br />
        <input type="radio" name="otazka3" value="nejpozdeji v pulce cesty si sednu" class="radioinput" /> nejpozději v půlce cesty si sednu<br />
        <input type="radio" name="otazka3" value="vetsinou celou cestu stojim" class="radioinput" /> většinou celou cestu stojím<br />
				<label for="otazka4">4. Stalo se Vám někdy, že jste se do svého spoje nevešli?</label>
        <input type="radio" name="otazka4" value="ano, casto" class="radioinput" /> ano, často - <label for="otazka4opt1txt" class="noblock">uveďte stanici a čas</label> <input type="text" size="20" maxlength="100" name="otazka4opt1txt" id="otazka4opt1txt" value="<?php echo $otazka4opt1txt; ?>" class="txtinput noblock" /><br />
        <input type="radio" name="otazka4" value="ano" class="radioinput" /> ano<br />
        <input type="radio" name="otazka4" value="ne" class="radioinput" /> ne<br />
				<label for="otazka5">5. Jsou dopravní prostředky pohodlné?</label>
        <input type="radio" name="otazka5" value="ano" class="radioinput" /> ano<br />
        <input type="radio" name="otazka5" value="da se to vydrzet" class="radioinput" /> dá se to vydržet<br />
        <input type="radio" name="otazka5" value="velmi nepohodlne" class="radioinput" /> velmi nepohodlné<br />
				<label for="otazka6">6. Jste spokojen(a) s četností spojů?</label>
        <input type="radio" name="otazka6" value="ano" class="radioinput" /> ano<br />
        <input type="radio" name="otazka6" value="ne" class="radioinput" /> ne - <label for="otazka6opt2txt" class="noblock">uveďte cíl a požadovaný čas odjezdu</label> <input type="text" size="20" maxlength="100" name="otazka6opt2txt" id="otazka6opt2txt" value="<?php echo $otazka6opt2txt; ?>" class="txtinput noblock" /><br />
        <label for="sdeleni">7. Další sdělení, které se týká Vaší spokojenosti s veřejnou dopravou:</label>
        <textarea rows="5" cols="40" name="sdeleni" id="sdeleni" class="txtinput" ><?php echo $sdeleni ?></textarea>
				<div>
				<input type="hidden" name="form" value="dotazbus" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
