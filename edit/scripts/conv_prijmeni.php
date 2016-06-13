<?php
include "../../scripts/settings.php";

$sql_dotaz = "SELECT id,prijmeni FROM osoba";
$result = mysql_query("$sql_dotaz");
if (!$result):
	die("chyba - $sql_dotaz");
else:
	while ($record = mysql_fetch_array($result)):
		$updid = $record["id"];
		$prijmorder = $record["prijmeni"];
		$prijmorder = ereg_replace("ä","az",$prijmorder);
		$prijmorder = ereg_replace("ö","oz",$prijmorder);
		$prijmorder = ereg_replace("ü","uz",$prijmorder);
		$prijmorder = ereg_replace("Ä","Az",$prijmorder);
		$prijmorder = ereg_replace("Ö","Oz",$prijmorder);
		$prijmorder = ereg_replace("Ü","Uz",$prijmorder);
		$prijmorder = ereg_replace("á","az",$prijmorder);
		$prijmorder = ereg_replace("č","cz",$prijmorder);
		$prijmorder = ereg_replace("ď","dz",$prijmorder);
		$prijmorder = ereg_replace("é","ez",$prijmorder);
		$prijmorder = ereg_replace("ě","ez",$prijmorder);
		$prijmorder = ereg_replace("í","iz",$prijmorder);
		$prijmorder = ereg_replace("ľ","lz",$prijmorder);
		$prijmorder = ereg_replace("ň","nz",$prijmorder);
		$prijmorder = ereg_replace("ó","oz",$prijmorder);
		$prijmorder = ereg_replace("ř","rz",$prijmorder);
		$prijmorder = ereg_replace("š","sz",$prijmorder);
		$prijmorder = ereg_replace("ť","tz",$prijmorder);
		$prijmorder = ereg_replace("ú","uz",$prijmorder);
		$prijmorder = ereg_replace("ů","uz",$prijmorder);
		$prijmorder = ereg_replace("ý","yz",$prijmorder);
		$prijmorder = ereg_replace("ž","zz",$prijmorder);
		$prijmorder = ereg_replace("Á","Az",$prijmorder);
		$prijmorder = ereg_replace("Č","Cz",$prijmorder);
		$prijmorder = ereg_replace("Ď","Dz",$prijmorder);
		$prijmorder = ereg_replace("É","Ez",$prijmorder);
		$prijmorder = ereg_replace("Ě","Ez",$prijmorder);
		$prijmorder = ereg_replace("Í","Iz",$prijmorder);
		$prijmorder = ereg_replace("Ľ","Lz",$prijmorder);
		$prijmorder = ereg_replace("Ň","Nz",$prijmorder);
		$prijmorder = ereg_replace("Ó","Oz",$prijmorder);
		$prijmorder = ereg_replace("Ř","Rz",$prijmorder);
		$prijmorder = ereg_replace("Š","Sz",$prijmorder);
		$prijmorder = ereg_replace("Ú","Uz",$prijmorder);
		$prijmorder = ereg_replace("Ů","Uz",$prijmorder);
		$prijmorder = ereg_replace("Ý","Yz",$prijmorder);
		$prijmorder = ereg_replace("Ž","Zz",$prijmorder);
echo $prijmorder."<br />";		
		$sql_update = "UPDATE osoba SET prijmorder = '$prijmorder' WHERE id = $updid";
		$result2 = mysql_query("$sql_update");
		if (!$result2):
			die("chyba - $sql_update");
		endif;
	endwhile;
endif;
?>