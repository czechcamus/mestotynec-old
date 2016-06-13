<?php
	// naplnění proměnných
	$errnr = $_GET["errnr"];
	if ($errnr):
		$otazka4opt4txt = $_GET["otazka4opt4txt"];
		$otazka4opt5txt = $_GET["otazka4opt5txt"];
    $otazka5opt1txt = $_GET["otazka5opt1txt"];
		$sdeleni7 = $_GET["sdeleni7"];
		$otazka8opt2txt = $_GET["otazka8opt2txt"];
		$otazka8opt3txt = $_GET["otazka8opt3txt"];
		$sdeleni10 = $_GET["sdeleni10"];		
	else:
		$posta = $_GET["posta"];
	endif;
	
	if (!$posta):
		if ($errnr):
			echo "<p class=\"error\">".VypisChybu($errnr)."</p>\n";
		endif; ?>
		<form action="scripts/checkform.php" method="post" class="publicform">
			<fieldset>
  			<label for="otazka1">1. Jste</label>
        <input type="radio" name="otazka1" value="muz" class="radioinput" /> muž<br />
	      <input type="radio" name="otazka1" value="zena" class="radioinput" /> žena<br />
  			<label for="otazka2">2. Kolik je Vám let?</label>
        <input type="radio" name="otazka2" value="mene nez 20" class="radioinput" /> méně než 20<br />
        <input type="radio" name="otazka2" value="21 - 35" class="radioinput" /> 21 - 35<br />
        <input type="radio" name="otazka2" value="35 - 50" class="radioinput" /> 35 - 50<br />
        <input type="radio" name="otazka2" value="více než 50" class="radioinput" /> více než 50<br />        
        <label for="otazka3">3. Bydlíte</label>
        <input type="radio" name="otazka3" value="v tynci nad sazavou" class="radioinput" /> v Týnci nad Sázavou<br />
        <input type="radio" name="otazka3" value="v okoli do cca 10 km" class="radioinput" /> v okolí do cca 10 km<br />
        <input type="radio" name="otazka3" value="v okoli nad cca 10 km" class="radioinput" /> v okolí nad cca 10 km<br />
  			<label for="otazka4">4. Kolikrát chodíte cvičit do veřejného sportovního zařízení?</label>
        <input type="radio" name="otazka4" value="tydne" class="radioinput" /> týdně - <label for="otazka4opt4txt" class="noblock">kolikrát?</label> <input type="text" size="20" maxlength="100" name="otazka4opt4txt" id="otazka4opt4txt" value="<?php echo $otazka4opt4txt; ?>" class="txtinput noblock" /><br />
        <input type="radio" name="otazka4" value="mesicne" class="radioinput" /> měsíčně - <label for="otazka4opt5txt" class="noblock">kolikrát?</label> <input type="text" size="20" maxlength="100" name="otazka4opt5txt" id="otazka4opt5txt" value="<?php echo $otazka4opt5txt; ?>" class="txtinput noblock" /><br />
        <input type="radio" name="otazka4" value="pouze vyjimecne" class="radioinput" /> pouze výjimečně <br />
        <input type="radio" name="otazka4" value="cvicim jenom doma" class="radioinput" /> cvičím jenom doma<br />
        <input type="radio" name="otazka4" value="necvicim vubec" class="radioinput" /> necvičím vůbec<br />
  			<label for="otazka5">5. Kde využíváte nejčastěji sportovní služby?</label>
        <input type="radio" name="otazka5" value="v miste bydliste" class="radioinput" /> v místě bydliště<br />
        <input type="radio" name="otazka5" value="dojizdim do" class="radioinput" /> dojíždím do - <label for="otazka5opt6txt" class="noblock">uveďte město:</label> <input type="text" size="20" maxlength="100" name="otazka5opt6txt" id="otazka5opt6txt" value="<?php echo $otazka5opt6txt; ?>" class="txtinput noblock" /><br />        
   			<label for="otazka6">6. Měl - měla byste zájem o cvičení v novém moderním fitcentru v Týnci nad Sázavou?</label>
        <input type="radio" name="otazka6" value="ano" class="radioinput" /> ano<br />
        <input type="radio" name="otazka6" value="ne" class="radioinput" /> ne<br />
        <label for="sdeleni7">7. Jaké aktivity byste chtěl - chtěla ve fitcentru využívat? (vypište)</label>
        <textarea rows="10" cols="70" name="sdeleni7" id="sdeleni7" class="txtinput" ><?php echo $sdeleni7 ?></textarea>
				<label for="otazka8">8. Kolikrát byste do centra chodil-a?</label>
        <input type="radio" name="otazka8" value="tydne" class="radioinput" /> týdně - <label for="otazka8opt7txt" class="noblock">kolikrát?</label> <input type="text" size="20" maxlength="100" name="otazka8opt7txt" id="otazka8opt7txt" value="<?php echo $otazka8opt7txt; ?>" class="txtinput noblock" /><br />
        <input type="radio" name="otazka8" value="mesicne" class="radioinput" /> měsíčně - <label for="otazka8opt8txt" class="noblock">kolikrát?</label> <input type="text" size="20" maxlength="100" name="otazka8opt8txt" id="otazka8opt8txt" value="<?php echo $otazka8opt8txt; ?>" class="txtinput noblock" /><br />
        <input type="radio" name="otazka8" value="pouze vyjimecne" class="radioinput" /> pouze výjimečně <br />
        <input type="radio" name="otazka8" value="neuvazuji o cviceni ve fitcentru" class="radioinput" /> neuvažuji o cvičení ve fitcentru<br />
  			<label for="otazka9">9. Kolik jste ochoten – ochotná maximálně zaplatit za 1 hodinu/lekci cvičení - služeb?</label>
        <input type="radio" name="otazka9" value="do 50" class="radioinput" /> do 50,- Kč<br />
        <input type="radio" name="otazka9" value="do 70" class="radioinput" /> do 70,- Kč<br />
        <input type="radio" name="otazka9" value="do 100" class="radioinput" /> do 100,- Kč<br />
        <input type="radio" name="otazka9" value="za specialni cviceni, sluzby i vice" class="radioinput" /> za speciální cvičení, služby i více<br />                        
        <label for="sdeleni10">10. Vaše připomínky a náměty: (vypište)</label>
        <textarea rows="10" cols="70" name="sdeleni10" id="sdeleni10" class="txtinput" ><?php echo $sdeleni10 ?></textarea>
				<div>
				<input type="hidden" name="form" value="dotazfit" />
				<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
				<input type="submit" value="odeslat formulář" title="tlačítko odeslat formulář" class="subinput" />
				</div>
			</fieldset>
		</form>
	<?php endif; ?>
