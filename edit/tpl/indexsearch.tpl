<?php
// vymazání indexového souboru
$dotazdel = "DELETE FROM search";
$resultdel = mysql_query("$dotazdel");
if (!$resultdel):
	die("Nepodařilo se vymazat záznamy z indexového souboru - indexsearch.tpl!");
endif;

// spuštění funkce
GetSearch();

// přidání záznamů do tabulky search
for ($i = 0; $i < count($titlearr);$i++):
	$titlevar = addslashes ($titlearr[$i]);
	$pathvar = addslashes ($patharr[$i]);
	$wordsvar = addslashes ($words[$i]);
	$dotaz = "INSERT INTO search (titulek,filename,obsah) VALUES ('$titlevar','$pathvar','$wordsvar')";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Zápis do tabulky search se nezdařil - indexsearch.tpl - $dotaz!");
	endif;
endfor;

// konec dobrý, všechno dobré
?>
<h3>Indexace webu byla úspěšně dokončena</h3>
<form action="./index.php" method="get">
	<div>
	<input type="submit" value="OK" />
	</div>
</form>