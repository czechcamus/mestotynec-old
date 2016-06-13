<?php
include "../scripts/settings.php";
include "./scripts/editfce.php";
$idredaktor = CheckLogin();

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$step = $_POST["step"];

if ($step == 1):
	$oddelovec = $_POST["oddelovac"];
	$tblname = $_POST["tblname"];
	$titulek = $_POST["titulek"];
	$csvtmp = $_FILES["csvtmp"];
	if ($csvtmp["tmp_name"] && $csvtmp["tmp_name"] != "none"):
		$csvname = CreateFile2Handle($csvtmp,"import");
		if (!$csvname):
			die("nepodařilo se uložit soubor CSV - checkimport");
		endif;
	else:
		$errtxt = "Nebyl uploadován CSV soubor pro import!";
	endif;
	if ($tblname):
		$tblname = CreateFilename($tblname,"nodot");
	else:
		$errtxt = "Chybí jméno cílové tabulky!";
	endif;
	if (!$titulek):
		$errtxt = "Chybí popis cílové tabulky!";
	endif;
else:
	// dotaz pro vytvoření tabulky, kam se budou data importovat
	$csvname = $_POST["csvname"];
	$tblheader = GetHeaderFromCsv($csvname,"checkimport.php");
	if (!$tblheader):
		die("Soubor CSV nebyl nalezen - formimpcsv2!");
	endif;
	$titulek = $_POST["titulek"];
	$tblname = $_POST["tblname"];
	$oddelovac = $_POST["oddelovac"];
	$tblheader = substr($tblheader,0,strlen($tblheader)-2);
	$headerarr = explode($oddelovac,$tblheader);
	$dotazinsert = "INSERT INTO $tblname (";
	$dotazcreate = "CREATE TABLE $tblname (id int(10) auto_increment";
	for ($i = 0; $i < count($headerarr); $i++):
		$sloupec = strtolower($headerarr[$i]);
		$naz = "naz".$sloupec;
		$nazpole = CreateFilename($_POST[$naz],"nodot");
		$typ = "typ".$sloupec;
		$typpole = $_POST[$typ];
		$typpole = ($typpole == "t" ? "varchar" : "decimal");
		$len = "len".$sloupec;
		$lenpole = $_POST[$len];
		$lenpole = ($typpole == "varchar" ? $lenpole : $lenpole.",2");
		$dotazinsert .= ($i == 0 ? "" : ", ").$nazpole;
		$dotazcreate .= ", ".$nazpole." ".$typpole."(".$lenpole.")";
	endfor;
	$dotazinsert .= ") VALUES (";
	$dotazcreate .= ", PRIMARY KEY (id))";
	
	// tvotba tabulky
	$result = mysql_query("$dotazcreate");
	if (!$result):
		die("Tvorba tabulky pro import neproběhla - checkimport.php");
	endif;
	
	// plnění tabulky daty
	$lenstr = strlen($script);
	$lenpath = strpos($script,"edit/".$callingsrc);
	$path = substr($script,0,$lenpath);
	$csvfile = "http://".$server.$path.$csvname;
	$csvcheckname = "../".$csvname;
	$i = 0; // první řádek s hlavičkou

	if (file_exists($csvcheckname)):
		$csvrows = file($csvcheckname);
		for ($i = 0; $i < count($csvrows); $i++):
			if ($i > 0):
				$record = explode($oddelovac,$csvrows[$i]);
				$dotaz = $dotazinsert;
				for ($j = 0; $j < count($record); $j++):
   					$hodnota = iconv("cp852","UTF-8",$record[$j]);
					$dotaz .= ($j == 0 ? "'" : ", '").$hodnota."'";
				endfor;
				$dotaz .= ")";
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Nepodařilo se vložit data do tabulky - checkimport.php");
				endif;
			endif;
		endfor;
	endif;
	
	// přidání záznamu do tabulky tablename
	$dotaztblinsert = "INSERT INTO tablename (tblname,titulek,typ,imported) VALUES ('$tblname','$titulek','tbl',1)";
	$result = mysql_query("$dotaztblinsert");
	if (!$result):
		die("Tabulku se nepodařilo přidat do seznamu tabulek - checkimport.php");
	endif;
	
endif;

if (!$errtxt):
	$csvname = urlencode($csvname);
	$path = substr($script, 0, StrRPos($script, "/"))."/importcsv.php?step=$step&csvname=$csvname&oddelovac=$oddelovac&tblname=$tblname&titulek=$titulek";
else:
	$path = substr($script, 0, StrRPos($script, "/"))."/importcsv.php?errtxt=$errtxt&step=0&oddelovac=$oddelovac&tblname=$tblname&titulek=$titulek";
endif;
Header("Location: http://".$server.":".$port.$path);
?>
