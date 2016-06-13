<div id="contentbar">
<?php
	// výběr odpovědí
	$dotaz = "SELECT * FROM zapis WHERE idtema=$idtema AND idtop=$idtop ORDER BY caszapisu";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat záznamy z tabulky odpovědí - odpoved.tpl!");
	else:
		$recordtema = TblHandler($idtema,"tema");
		$recordzap = TblHandler($idtop,"zapis");
		$pocodp = mysql_num_rows($result);
		$ppcas = GetIntTime($recordzap["caszapisu"]);
		$datumcas = date("d.m.Y v H:i",$ppcas);
		include "tpl/diskusenavbar.tpl";
		echo "<div class=\"articlebox\">\n";
		echo "<h2>".$recordzap["titulek"]."</h2>\n";
		echo "<div class=\"zapis\">\n";
		echo "<div class=\"jmeno\"><strong>".($recordzap["email"] ? "<a href=\"mailto:".$recordzap["email"]."\" title=\"napište autorovi\">" : "").$recordzap["jmeno"].($recordzap["email"] ? "</a>" : "")."</strong></a> napsal ".$datumcas."</div>\n";
		echo "<div class=\"post\">".nl2br($recordzap["text"])."</div>\n";
		echo "</div>\n";
		if ($pocodp):
			while ($record = mysql_fetch_array($result)):
				$ppcas = GetIntTime($record["caszapisu"]);
				$datumcas = date("d.m.Y v H:i",$ppcas);
				echo "<div class=\"".($record["employee"] ? "odpovedemp" : "odpoved")."\">\n";
				echo "<div class=\"jmeno\"><strong>".($record["email"] ? "<a href=\"mailto:".$record["email"]."\" title=\"napište autorovi\">" : "").$record["jmeno"].($record["email"] ? "</a>" : "")."</strong></a> napsal ".$datumcas."</div>\n";
				echo "<div class=\"post\">".nl2br($record["text"])."</div>\n";
				echo "</div>\n";
			endwhile;
		endif;
		if ($fullreg || $recordtema["public"]):
			include "tpl/content/diskuseform.tpl";
		endif;
		echo "</div>\n";
	endif;
?>
</div>
