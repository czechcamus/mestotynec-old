<?php
// výběr z tabulky content
$dotaz = "SELECT * FROM content ORDER BY mtid, pozice";
$result = mysql_query("$dotaz");
if (!$result):
	die("Nezdařil se výběr z tabulky content - contentpoz.tpl!");
endif;

// spuštění funkce
$oldmt = 0;
while ($record = mysql_fetch_array($result)):
	if ($record["mtid"] != $oldmt):
		$oldmt = $record["mtid"];
		$poz = 1;
	endif;
	$id = $record["id"];
	$dotazupd = "UPDATE content SET pozice = $poz WHERE id=$id";
	$resultupd = mysql_query("$dotazupd");
	if (!$resultupd):
		die("Nezdařila se změna pozice položky v tabulce content - contentpoz.tpl!");
	endif;
	++$poz;
endwhile;

// konec dobrý, všechno dobré
?>
<h3>Seřazení položek článků proběhlo úspěšně</h3>
<form action="./index.php" method="get">
	<div>
	<input type="submit" value="OK" />
	</div>
</form>