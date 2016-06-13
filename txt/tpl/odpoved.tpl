<div id="right">
<?php
	// výběr odpovědí
	$dotaz = "SELECT * FROM zapis WHERE idtema=$idtema AND idtop=$idtop ORDER BY caszapisu";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat záznamy z tabulky odpovědí - odpoved.tpl!");
	else:
		if ($_SESSION["userid"]):
			$recorduser = TblHandler($_SESSION["userid"],"uzivatel");
			$fullreg = $recorduser["fullreg"];
		endif;
		$recordtema = TblHandler($idtema,"tema");
		$recordzap = TblHandler($idtop,"zapis");
		$pocodp = mysql_num_rows($result);
		$ppcas = GetIntTime($recordzap["caszapisu"]);
		$datumcas = date("d.m.Y v H:i",$ppcas);
		include "tpl/diskusenavbar.tpl";
		echo "<div>\n";
		echo "<h4>".$recordzap["titulek"]."</h4>\n";
		echo "<div>\n";
		echo "<div><strong>".($recordzap["email"] ? "<a href=\"mailto:".$recordzap["email"]."\" title=\"napište autorovi\">" : "").$recordzap["jmeno"].($recordzap["email"] ? "</a>" : "")."</strong></a> napsal ".$datumcas."</div>\n";
		echo "<div>".nl2br($recordzap["text"])."</div>\n";
		echo "</div>\n";
		if ($pocodp):
			while ($record = mysql_fetch_array($result)):
				$ppcas = GetIntTime($record["caszapisu"]);
				$datumcas = date("d.m.Y v H:i",$ppcas);
				echo "<div>\n";
				echo "<div><strong>".($record["email"] ? "<a href=\"mailto:".$record["email"]."\" title=\"napište autorovi\">" : "").$record["jmeno"].($record["email"] ? "</a>" : "")."</strong></a> napsal ".$datumcas."</div>\n";
				echo "<div>".nl2br($record["text"])."</div>\n";
				echo "</div>\n";
			endwhile;
		endif;
		if ($fullreg || $recordtema["public"]):
			include "tpl/content/diskuseform.tpl";
		endif;
		echo "<hr />\n";
		echo "</div><!-- end maininfobox -->\n";
	endif;
?>
</div>