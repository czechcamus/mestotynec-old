<?php
// byl již změněn výběr?
$misto_id = $_GET["misto_id"];
$typakce_id = $_GET["typakce_id"];
$obdobi = $_GET["obdobi"];

// standardně se zobrazí všechny akce v libovolné lokalitě
if (!$misto_id):
	$misto_id = 1;
	$typakce_id = 99;
	$obdobi = $dnyakcikal;
endif;


// načtení položek pro seznam typu akcí
$sql_dotaz = "SELECT * FROM typakce ORDER BY popis";
$result = mysql_query("$sql_dotaz");

if (!$result):
	 die("nepodařilo se vybrat typy akcí - kalendar.php");
else:
	echo "<form action=\"page.php\" method=\"get\" id=\"calendarform\">\n";
	echo "<fieldset>\n";
	echo "<label for=\"typakce_id\" class=\"noblock\">Typ akcí:</label>\n";
	echo "<select name=\"typakce_id\" id=\"typakce_id\" size=\"1\">";
	echo "<option value=\"99\"".($typakce=="99" ? " selected=\"selected\"" : "").">Bez rozlišení</option>\n";
	while ($record = mysql_fetch_array($result)):
		echo "<option value=\"".$record["id"]."\"";
		echo ($typakce_id==$record["id"] ? " selected=\"selected\"" : "");
		echo ">".$record["popis"]."</option>\n";
	endwhile;
	echo "</select>\n";
	echo "<label for=\"obdobi\" class=\"noblock\">Program na:</label>\n"; 
	echo "<select name=\"obdobi\" id=\"obdobi\" size=\"1\">\n";
	echo "<option value=\"1\"".($obdobi==1 ? " selected=\"selected\"" : "").">dnes</option>\n";
	echo "<option value=\"7\"".($obdobi==7 ? " selected=\"selected\"" : "").">příštích 7 dnů</option>\n";
	echo "<option value=\"30\"".($obdobi==30 ? " selected=\"selected\"" : "").">příštích 30 dnů</option>\n";
	echo "<option value=\"365\"".($obdobi==365 ? " selected=\"selected\"" : "").">příštích 365 dnů</option>\n";
	echo "</select>\n";
	echo "<input type=\"hidden\" name=\"fp\" value=\"".$kalendarfile."\" />\n";
	echo "<input type=\"hidden\" name=\"misto_id\" value=\"".$misto_id."\" />\n";
	echo "<input type=\"submit\" name=\"odeslano\" value=\"Vybrat\" class=\"subinput\" />\n";
	echo "</fieldset>\n";
	echo "</form>\n";
endif;

// načtení dat pro kalendář
$resultkal = KalendarSelect($misto_id,$obdobi,$typakce_id);
$pocakci = mysql_num_rows($resultkal);
if (!$pocakci):
	echo "<p class=\"bold\">Nenalezen žádný vyhovující záznam...</p>\n";
else:
	echo "<div>\n";
	$i = 1;
	while ($record = mysql_fetch_array($resultkal)):
		$kid = "id".$record["kid"];
		$datum1 = date('d.m.Y',$record["datum"]);
		$datum2 = date('d.m.Y',$record["datum_do"]);
		echo "<div>\n";
		echo "<div>".$datum1;
		$i = ($i == 1 ? 0 : 1);
		if ($datum2 != $datum1):
			echo " - ".$datum2;
		endif;
		if ($record["zacatek"]):
			echo "<br />".$record["zacatek"];
		endif;
		echo "</div>\n";
		if ($record["podnik"]):
			echo "<div>".$record["podnik"];
			if ($record["ulice"]):
				echo "<br />".$record["ulice"];
			endif;
			if ($record["mesto"]):
				echo "<br />".$record["mesto"];
			endif;
			echo "</div>\n";
		endif;
		echo "</div>\n";
		echo "<div>\n";
		echo "<h5>".$record["titulek"]."</h5>\n";
		if ($record["anotace"]):
			echo "<p>".nl2br($record["anotace"])."</p>\n";
		endif;
		if ($record["jmeno"]):
			echo "<p>Pořadatel: ".$record["jmeno"];
			if ($record["telefon"]):
				echo ", tel. ".$record["telefon"];
			endif;
			if ($record["email"]):
				echo ", <a href=\"mailto:".$record["email"]."\" title=\"Mailová adresa pořadatele\">".$record["email"]."</a>";
			endif;
			echo "</p>\n";
		endif;
		echo "<hr />\n";
	endwhile;
	echo "</div>\n";
endif;
?>