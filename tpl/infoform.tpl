<div id="contentbar">
<div class="articlebox">
<?php
$fp = $_GET["fp"];
$form = $_GET["form"];
if ($form == "cst"):
	$idcst = $_GET["idcst"];
	$odp = $_GET["odp"];
elseif ($form == "i106" || $form == "sdel" || $form == "dotazbus" || $form == "dotazjid" || $form == "dotazvize"):
	$posta = $_GET["posta"];
elseif ($form == "register"):
	$akce = $_GET["akce"];
endif;
if ($form == "cst"):
	$record = TblHandler($idcst,"soutez");
	echo "<h4>Vaše odpověď v soutěži byla přijata</h4>\n";
	echo "<p>Na otázku <strong>".$record["otazka"]."</strong><br />\n";
	echo "jste odpověděl(a) <strong>".$record["odp".$odp]."</strong></p>\n";
	echo "<h6>Děkujeme</h6>\n";
	echo "<form action=\"page.php\" method=\"get\" class=\"publicform\">\n";
	echo "<fieldset>\n";
	echo "<input type=\"hidden\" name=\"fp\" value=\"".$fp."\" />\n";
	echo "<input type=\"submit\" value=\"návrat\" title=\"tlačítko návrat\" class=\"subinput\" />\n";
	echo "</fieldset>\n";
	echo "</form>\n";
elseif ($form == "i106" || $form == "sdel" || $form == "vzkaz" || $form == "dotazbus" || $form == "dotazvize"):
	if ($posta):
		if ($form == "i106"):
			echo "<h4>Vaše žádost byla úspěšně odeslána</h4>\n";
		elseif ($form == "vzkaz"):
			echo "<h4>Váš vzkaz byl úspěšně odeslán</h4>\n";
		elseif ($form == "dotazbus" || $form == "dotazjid" || $form == "dotazvize"):
			echo "<h4>Vaše odpovědi byly úspěšně odeslány</h4>\n";
		else:
			echo "<h4>Vaše sdělení bylo úspěšně odesláno</h4>\n";
		endif;
		echo "<h6>Děkujeme</h6>\n";
		echo "<form action=\"page.php\" method=\"get\" class=\"publicform\">\n";
		echo "<fieldset>\n";
		echo "<input type=\"hidden\" name=\"fp\" value=\"".$fp."\" />\n";
		echo "<input type=\"submit\" value=\"návrat\" title=\"tlačítko návrat\" class=\"subinput\" />\n";
		echo "</fieldset>\n";
		echo "</form>\n";
	else:
		if ($form == "i106"):
			echo "<h4>Vaši žádost se nepodařilo odeslat</h4>\n";
		elseif ($form == "vzkaz"):
			echo "<h4>Váš vzkaz se nepodařilo odeslat</h4>\n";
		elseif ($form == "dotazbus" || $form == "dotazjid" || $form == "dotazvize"):
			echo "<h4>Vaše odpovědi se nepodařilo odeslat</h4>\n";
		else:
			echo "<h4>Vaše sdělení se nepodařilo odeslat</h4>\n";
		endif;
		echo "<h6>Litujeme</h6>\n";
		echo "<form action=\"page.php\" method=\"get\" class=\"publicform\">\n";
		echo "<fieldset>\n";
		echo "<input type=\"hidden\" name=\"fp\" value=\"".$fp."\" />\n";
		echo "<input type=\"submit\" value=\"návrat\" title=\"tlačítko návrat\" class=\"subinput\" />\n";
		echo "</fieldset>\n";
		echo "</form>\n";
	endif;
elseif ($form == "register"):
	if ($akce == "add"):
		echo "<h4>Vaše žádost o registraci byla uložena</h4>\n";
	else:
		echo "<h4>Změny v registraci byly uloženy</h4>\n";
	endif;
	echo "<h6>Děkujeme</h6>\n";
	if ($akce == "add"):
		echo "<strong>Na Vaši e-mailovou adresu byla odeslána zpráva pro potvrzení registrace</strong>\n";
	elseif ($akce == "updmail"):
		echo "<strong>Na Vaši e-mailovou adresu byla odeslána zpráva pro potvrzení změn v registraci</strong>\n";
	endif;
	echo "<form action=\"index.php\" method=\"get\" class=\"publicform\">\n";
	echo "<fieldset>\n";
	echo "<input type=\"submit\" value=\"ok\" title=\"tlačítko ok\" class=\"subinput\" />\n";
	echo "</fieldset>\n";
	echo "</form>\n";
endif;
?>
</div>
</div>
