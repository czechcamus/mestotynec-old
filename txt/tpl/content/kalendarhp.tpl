<?php
	// určení aktualit
	$resultkal = HPKalendarSelect($mistoakcihp,$dnyakcihp);
	if (mysql_num_rows($resultkal)):
		echo "<h3>Kalendář</h3>\n";
		echo "<div>\n";
		while ($record = mysql_fetch_array($resultkal)):
			$kid = "id".$record["kid"];
			$datum1 = date('d.m.Y',$record["datum"]);
			$datum2 = date('d.m.Y',$record["datum_do"]);
			echo "<div>".$datum1;
			if ($datum2 != $datum1):
				echo " - ".$datum2;
			endif;
			if ($record["zacatek"]):
				echo "<br />".$record["zacatek"];
			endif;
			echo "</div>\n";
			if ($record["podnik"]):
				echo $record["podnik"];
				if ($record["mesto"]):
					echo "<br />".$record["mesto"];
				endif;
			endif;
			echo "<h4><a href=\"page.php?fp=$kalendarfile".($_SESSION["userid"] ? "&amp;".SID : "")."#$kid\" title=\"podrobnosti v hlavním kalendáři\">".$record["titulek"]."</a></h4>\n";
			echo "<p>\n";
			if ($record["anotace"]):
				if (StrLen($record["anotace"])>150):
					echo utf8_substr($record["anotace"],0,150)."...";
				else:
					echo $record["anotace"];
				endif;
			endif;
			echo "</p>\n";
		endwhile;
		echo "<hr class=\"leftclear\" />\n";
		echo "</div>\n";
	endif;	
?>