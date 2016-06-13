<div id="right">
<?php
	// výběr zápisů
	$dotaz = "SELECT * FROM zapis WHERE idtema=$idtema AND idtop=0 ORDER BY caszapisu DESC LIMIT $zac,$poczazstr";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nepodařilo se vybrat záznamy z tabulky zápisů - zapis.tpl!");
	else:
		if ($_SESSION["userid"]):
			$recorduser = TblHandler($_SESSION["userid"],"uzivatel");
			$fullreg = $recorduser["fullreg"];
		endif;
		$recordtema = TblHandler($idtema,"tema");
		if ($recordtema["idgarant"]):
			$recordgarant = TblHandler($recordtema["idgarant"],"osoba");
		endif;
		$poczap = GetNumRecords("zapis","idtema=$idtema AND idtop=0");
		include "tpl/diskusenavbar.tpl";
		echo "<div>\n";
		echo "<h4>".$recordtema["nazev"]."</h4>\n";
		echo "<p>".$recordtema["uvod"]."</p>\n";
		if (!$recordtema["public"]):
			echo "<p>Moderátor tématu: ".($recordgarant["email1"] ? "<a href=\"mailto:".$recordgarant["email1"]."\" title=\"e-mail moderátora\">" : "").($recordgarant["titulpred"] ? $recordgarant["titulpred"]." " : "").$recordgarant["jmeno"]." ".$recordgarant["prijmeni"].($recordgarant["titulza"] ? ", ".$recordgarant["titulza"] : "").($recordgarant["email1"] ? "</a>" : "")."</p>\n";
		endif;
		if ($poczap):
			echo "<table>\n";
			echo "<tr>\n";
			echo "<th>název příspěvku</th>";
			echo "<th>autor</th>";
			echo "<th>počet odpovědí</th>";
			echo "<th>poslední změna</th>\n";
			echo "</tr>\n";
			while ($record = mysql_fetch_array($result)):
				$idtop = $record["id"];
				$pocodp = GetNumRecords("zapis","idtop=$idtop");
				$maxcas = GetMaxTime("zapis","caszapisu","id=$idtop OR idtop=$idtop");
				$ppcas = GetIntTime($maxcas);
				$datumcas = date("d.m.Y v H:i",$ppcas);
				echo "<tr>\n";
				echo "<td class=\"bold\"><a href=\"diskuse.php?idtema=$idtema&amp;idtop=$idtop".($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"zobrazit příspěvek a odpovědi\">".$record["titulek"]."</a></td>";
				echo "<td class=\"textcenter\">".($record["email"] ? "<a href=\"mailto:".$record["email"]."\" title=\"napište autorovi\">" : "").$record["jmeno"].($record["email"] ? "</a>" : "")."</td>";
				echo "<td class=\"textcenter\">".$pocodp."</td>";
				echo "<td class=\"textcenter\">".($datumcas ? $datumcas : "---")."</td>";
				echo "</tr>\n";
			endwhile;
			echo "</table>\n";
			if ($poczap > $poczazstr):
				echo "<div>\n";
				$pocstr = ceil($poczap/$poczazstr);
				for ($i=1;$i<=$pocstr;$i++):
					echo "&nbsp;";
					if ($zac != (($i-1)*$poczazstr)):
						echo "<a href=\"diskuse.php?idtema=$idtema&amp;idtop=0&amp;zac=".(($i-1)*$poczazstr).($_SESSION["userid"] ? "&amp;".SID : "")."\" title=\"strana $i\">";
					endif;
					echo $i;
					if ($zac != (($i-1)*$poczazstr)):
						echo "</a>";
					endif;
					echo "&nbsp;";
				endfor;
				echo "</div>\n";
			endif;
		endif;
		if ($fullreg || $recordtema["public"]):
			include "tpl/content/diskuseform.tpl";
		endif;
		echo "</div><!-- end maininfobox -->\n";
	endif;
?>
</div>