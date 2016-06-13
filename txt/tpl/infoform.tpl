<div id="right">
	<div class="maininfobox">
		<div class="pack">
			<div class="margin">
<?php if ($form == "cst"):
		$record = TblHandler($idcst,"soutez");
		echo "<h4>Vaše odpověď v soutěži byla přijata</h4>\n";
		echo "<p>Na otázku <strong>".$record["otazka"]."</strong><br />\n";
		echo "jste odpověděl(a) <strong>".$record["odp".$odp]."</p>\n";
		echo "<h6>Děkujeme</h6>\n";
		echo "<form action=\"page.php\" method=\"get\">\n";
		echo "<fieldset>\n";
		echo "<input type=\"hidden\" name=\"fp\" value=\"".$fp."\" />\n";
		if ($strsess):
			echo "<input type=\"hidden\" name=\"UserSess\" value=\"".$strsess."\" />\n";
		endif;
		echo "<input type=\"submit\" value=\"není zač\" title=\"tlačítko není zač\" class=\"subinput\" />\n";
		echo "</fieldset>\n";
		echo "</form>\n";
	elseif ($form == "i106" || $form == "sdel"):
		if ($posta):
			if ($form == "i106"):
				echo "<h4>Vaše žádost byla úspěšně odeslána</h4>\n";
			else:
				echo "<h4>Vaše sdělení bylo úspěšně odesláno</h4>\n";
			endif;
			echo "<h6>Děkujeme</h6>\n";
			echo "<form action=\"page.php\" method=\"get\">\n";
			echo "<fieldset>\n";
			echo "<input type=\"hidden\" name=\"fp\" value=\"".$fp."\" />\n";
			if ($strsess):
				echo "<input type=\"hidden\" name=\"UserSess\" value=\"".$strsess."\" />\n";
			endif;
			echo "<input type=\"submit\" value=\"není zač\" title=\"tlačítko není zač\" class=\"subinput\" />\n";
			echo "</fieldset>\n";
			echo "</form>\n";
		else:
			if ($form == "i106"):
				echo "<h4>Vaši žádost se nepodařilo odeslat</h4>\n";
			else:
				echo "<h4>Vaši sdělení se nepodařilo odeslat</h4>\n";
			endif;
			echo "<h6>Litujeme</h6>\n";
			echo "<form action=\"page.php\" method=\"get\">\n";
			echo "<fieldset>\n";
			echo "<input type=\"hidden\" name=\"fp\" value=\"".$fp."\" />\n";
			if ($strsess):
				echo "<input type=\"hidden\" name=\"UserSess\" value=\"".$strsess."\" />\n";
			endif;
			echo "<input type=\"submit\" value=\"no nic\" title=\"tlačítko no nic\" class=\"subinput\" />\n";
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
		echo "<form action=\"index.php\" method=\"get\">\n";
		echo "<fieldset>\n";
		if ($strsess):
			echo "<input type=\"hidden\" name=\"UserSess\" value=\"".$strsess."\" />\n";
		endif;
		echo "<input type=\"submit\" value=\"ok\" title=\"tlačítko ok\" class=\"subinput\" />\n";
		echo "</fieldset>\n";
		echo "</form>\n";
	endif; ?>
			</div>
		</div>
	</div>
</div>