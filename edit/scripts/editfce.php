<?php function VypisChybu($c)
	// $c označuje číslo chyby
	{
	die($_SERVER["SCRIPT_NAME"]);
		if ($c == 1):
			$txt = "Špatně zapsaná e-mailová adresa!";
		elseif ($c == 2):
			$txt = "Chybí jméno a příjmení";
		elseif ($c == 3):
			$txt = "Chybí e-mailová adresa";
		elseif ($c == 4):
			$txt = "Chybí text příspěvku";
		endif;
		return $txt;
	}
	function ChangePozice($s,$i,$p)
	// změní hodnotu v poli pozice 
	// $s označuje tabulku
	// $i číslo nadřazené položky
	// $p označuje koeficient změny
	{
		if ($s == "articlejoin"):
			$dotaz = "SELECT * FROM $s WHERE menuid=$i";
		else:
		endif;
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst data - ChangePozice - $dotaz!");
		else:
			while ($record = mysql_fetch_array($result)):
				$idrec = $record["id"];
				$du = "UPDATE $s SET pozice = pozice+$p WHERE id=$idrec";
				$ru = mysql_query("$du");
				if (!$ru):
					die("Nepodařilo se změnit pozici - ChangePozice - $du!");
				endif;
			endwhile;
		endif;
	}
	function GetNewPozice($s,$i)
	// určí číslo pozice pro novou položku
	// $s označuje tabulku
	// $i číslo nadřazené položky
	{
		if ($s == "menu"):
			if ($i):
				$dotaz = "SELECT * FROM $s WHERE idtop=$i";
			else:
				$dotaz = "SELECT * FROM $s WHERE level=0";
			endif;
		elseif ($s == "content"):
			$dotaz = "SELECT * FROM $s WHERE mtid=$i";
		elseif ($s == "articlejoin"):
			ChangePozice($s,$i,1);
		endif;
		if ($s == "articlejoin"):
			$poz = 1;
		else:
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nepodařilo se načíst data - Getnewpozice - $dotaz!");
			else:
				$poz = mysql_num_rows($result)+1;
			endif;
		endif;
		return $poz;
	}	
	function GetPozice($s,$i)
	// určí číslo pozice pro položku menu
	// $s označuje tabulku
	// $i číslo položky
	{
		if ($i):
			$dotaz = "SELECT pozice FROM $s WHERE id=$i";
		else:
			$dotaz = "SELECT pozice FROM $s WHERE level=0";
		endif;
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst data - Getpozice!");
		else:
			$record = mysql_fetch_array($result);
			$mp = $record["pozice"];
		endif;
		return $mp;
	}	
	function GetLevelMenu($i)
	// určí level menu, do kterého položka patří
	// $i číslo nadřazené položky
	{
		if ($i):
			$dotaz = "SELECT level FROM menu WHERE id=$i";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nepodařilo se načíst data - Getlevelmenu!");
			else:
				$record = mysql_fetch_array($result);
				$ml = $record["level"]+1;
			endif;
		else:
			$ml = 0;
		endif;
		return $ml;
	}	
	function GetLevel1MenuId($i)
	// určí ID menu pro 0. úroveň
	// $i číslo menu
	{
		$m = TblHandler($i,"menu");
		$m1l = $m["level"];
		if ($m1l > 0):
			$dotaz = "SELECT idtop,level FROM menu WHERE id=$i";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nepodařilo se načíst data - Getlevel1menuid!");
			else:
				$record = mysql_fetch_array($result);
				$m1l = $record["level"]-1;
				$i = $record["idtop"];
				while ($m1l > 0):
					$dotaz = "SELECT idtop,level FROM menu WHERE id=$i";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Nepodařilo se načíst data - Getlevel1menuid - úroveň 2!");
					else:
						$record = mysql_fetch_array($result);
						$m1l = $record["level"]-1;
						$i = $record["idtop"];
					endif;
				endwhile;
			endif;
		else:
			$i = 0;
		endif;
		return $i;
	}	
	function GetFilename($i,$t)
	// určí jméno souboru - sloupec filename
	// $i označuje číslo nadřazené nabídky
	// $t označuje titulek, ktery bude pouzit pro generovani jmena
	{
		$fn = CreateFilename($t,"nodot");
		if ($i):
			$dotaz = "SELECT filename FROM menu WHERE id=$i";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nepodařilo se načíst data - Getfilename!");
			else:
				$record = mysql_fetch_array($result);
				$mp = $record["filename"];
			endif;
			if ($mp):
				$fn = $mp."/".$fn;
			endif;
		endif;
		return $fn;
	}	
	function CreateFilename($s,$d)
	// konvertuje řetězec $s do "čisté" formy bez diakritiky atd.
	// pokud má $d hodnotu "yesdot", pak ponechává v url tečky, "nodot" je převádí na -
	{
		$sn = ereg_replace(" ","-",$s);
		$sn = ereg_replace("\"","",$sn);
		if ($d != "yesdot"):
			$sn = ereg_replace("\.","-",$sn);
		endif;
		$sn = ereg_replace("„","",$sn);
		$sn = ereg_replace("“","",$sn);
		$sn = ereg_replace("\(","",$sn);
		$sn = ereg_replace("\)","",$sn);
		$sn = ereg_replace("!","",$sn);
		$sn = ereg_replace("\?","",$sn);
		$sn = ereg_replace(",","",$sn);
		$sn = ereg_replace(";","",$sn);
		$sn = ereg_replace("/","",$sn);
		$sn = ereg_replace("ä","a",$sn);
		$sn = ereg_replace("ö","o",$sn);
		$sn = ereg_replace("ü","u",$sn);
		$sn = ereg_replace("Ä","A",$sn);
		$sn = ereg_replace("Ö","O",$sn);
		$sn = ereg_replace("Ü","U",$sn);
		$sn = ereg_replace("á","a",$sn);
		$sn = ereg_replace("č","c",$sn);
		$sn = ereg_replace("ď","d",$sn);
		$sn = ereg_replace("é","e",$sn);
		$sn = ereg_replace("ě","e",$sn);
		$sn = ereg_replace("í","i",$sn);
		$sn = ereg_replace("ľ","l",$sn);
		$sn = ereg_replace("ň","n",$sn);
		$sn = ereg_replace("ó","o",$sn);
		$sn = ereg_replace("ř","r",$sn);
		$sn = ereg_replace("š","s",$sn);
		$sn = ereg_replace("ť","t",$sn);
		$sn = ereg_replace("ú","u",$sn);
		$sn = ereg_replace("ů","u",$sn);
		$sn = ereg_replace("ý","y",$sn);
		$sn = ereg_replace("ž","z",$sn);
		$sn = ereg_replace("Á","A",$sn);
		$sn = ereg_replace("Č","C",$sn);
		$sn = ereg_replace("Ď","D",$sn);
		$sn = ereg_replace("É","E",$sn);
		$sn = ereg_replace("Ě","E",$sn);
		$sn = ereg_replace("Í","I",$sn);
		$sn = ereg_replace("Ľ","L",$sn);
		$sn = ereg_replace("Ň","N",$sn);
		$sn = ereg_replace("Ó","O",$sn);
		$sn = ereg_replace("Ř","R",$sn);
		$sn = ereg_replace("Š","S",$sn);
		$sn = ereg_replace("Ú","U",$sn);
		$sn = ereg_replace("Ů","U",$sn);
		$sn = ereg_replace("Ý","Y",$sn);
		$sn = ereg_replace("Ž","Z",$sn);
		$sn = strtolower($sn);
		return $sn;
	}	
	function HasSubmenu($i)
	// zjistí, zda má menu ID $i nějaké submenu
	{
		$dotaz = "SELECT * FROM menu WHERE idtop=$i";
		$result = mysql_query("$dotaz");
		$p = 0;
		if (!$result):
			die("Výběr z tabulky menu se nezdařil - HasSubmenu!");
		else:
			$p = mysql_num_rows($result);
		endif;
		return $p;
	}
	function HasArticle($i)
	// zjistí, zda má menu ID $i nějaký obsah
	{
		$dotaz = "SELECT * FROM mastertxt WHERE menuid=$i";
		$result = mysql_query("$dotaz");
		$p = 0;
		if (!$result):
			die("Výběr z tabulky menu se nezdařil - HasArticle!");
		else:
			$p = mysql_num_rows($result);
		endif;
		return $p;
	}
	function TblHandler($i,$t)
	// vrací pole s údaji tabulky
	// $i je id klíčové položky
	// $t je název tabulky
	{
		$dotaz = "SELECT * FROM $t WHERE id=$i";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Z tabulky se nepodařilo načíst ani Ň - fce TblHandler");
		else:
			$arr = mysql_fetch_array($result);
		endif;
		return $arr;
	}
	function UsrHandler($user,$pwd)
	// vrací pole s údaji tabulky
	// $user je uz. jmeno
	// $pwd je heslo
	{
		$dotaz = "SELECT * FROM uzivatel WHERE user='$user' AND pwd='$pwd'";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Z tabulky se nepodařilo načíst ani Ň - fce UsrHandler");
		else:
			$arr = mysql_fetch_array($result);
		endif;
		return $arr;
	}
	function GetContNr($mt)
	// vrací počet všech údajů článku
	// $mt je id článku
	{
		$dotaz = "SELECT * FROM content WHERE mtid=$mt";
		$result = mysql_query("$dotaz");
		$s = 0;
		if (!$result):
			die("Z tabulky obsahů se nepodařilo načíst ani Ň - fce GetContNr");
		else:
			$s = mysql_num_rows($result);
		endif;
		return $s;
	}
	function DeleteJoin($mt)
	// odstraňuje záznam o spojení
	// $mt je id hlavního článku
	{
		$dotaz = "DELETE FROM articlejoin WHERE mtid=$mt";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se odstranit záznamy - $dotaz!");
		endif;
	}
	function DeleteContent($mt)
	// čistí soubory s obsahem po smazání hlavního článku
	// $mt je id hlavního článku
	{
		$dotaz = "SELECT * FROM content AS ct, tablename AS tn WHERE ct.mtid=$mt AND ct.idtbl=tn.id";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst názvy tabulek - DeleteContent!");
		else:
			while ($record = mysql_fetch_array($result)):
				$dotaz2 = "DELETE FROM ".$record["tblname"]." WHERE id=".$record["contid"];
				$result2 = mysql_query("$dotaz2");
				if (!$result2):
					die("Jednotlivé části se nepodařilo vymazat - DeleteContent - ".$record["tblname"]."!");
				endif;
			endwhile;
			$dotaz3 = "DELETE FROM content WHERE mtid=$mt";
			$result3 = mysql_query("$dotaz3");
			if (!$result3):
				die("Jednotlivé části se nepodařilo vymazat - DeleteContent - content!");
			endif;
		endif;
	}
	function GetTblType($t)
	// výběr typu tabulky podle jejího jména $t
	{
		$dotaz = "SELECT * FROM tablename WHERE tblname='$t'";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nezdařil se výběr z tabulky tablename - GetTblType!");
		else:
			$record = mysql_fetch_array($result);
			$tt = $record["typ"];
		endif;
		return $tt;
	}
	function GetTblId($t)
	// výběr id tabulky podle jejího jména $t
	{
		$dotaz = "SELECT * FROM tablename WHERE tblname='$t'";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nezdařil se výběr z tabulky tablename - GetTblType!");
		else:
			$record = mysql_fetch_array($result);
			$ti = $record["id"];
		endif;
		return $ti;
	}
	function GetContPozice($i)
	// vrací číslo pozice obsahu
	// $i je id obsahu
	{
		$dotaz = "SELECT pozice FROM content WHERE contid=$i";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst data - GetContPozice!");
		else:
			$record = mysql_fetch_array($result);
			$cp = $record["pozice"];
		endif;
		return $cp;
		
	}
	function GetUprId($t)
	// vrací ID upraveného záznamu tabulky $t
	// upravený záznam poté odznačí
	{
		$dotaz = "SELECT * FROM $t WHERE uprava=1";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se načíst data - GetUprId!");
		else:
			$record = mysql_fetch_array($result);
			$ci = $record["id"];
			$dotaz = "UPDATE $t SET uprava=0 WHERE id=$ci";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nepodařilo se upravit tabulku - GetUprId!");
			endif;
		endif;
		return $ci;
	}
	function CreateFotoImg($img,$maxsize,$subpath,$i)
	// vytvoří a uloží do podadresáře $subpath z obrázku $img jeho kopii o zadaném maximálním rozměru $maxsize
	// v případě úspěchu vrací relativní cestu vzhledem k adresáři img
	// pokud je uveden identifikátor záznamu z tabulky content - $i, pak se tvoří jméno obrázku pro soutěž
	{
		$path = $_SERVER['DOCUMENT_ROOT'];
		$imgname = "../".$img; // bez /new/
		$imgfile = ereg_replace("temp/","",$img); 
		$newimgname = ($i ? "soutez".$i : CreateFilename($imgfile,"yesdot"));
		$fn = "";
		
		list($ps, $pv, $pt, $pa) = getimagesize($imgname);

		if ($pt == 1):
			if ($i):
				$newimgname .= ".gif";
			endif;
			$srcimg=imagecreatefromgif($imgname);
		elseif ($pt == 2):
			if ($i):
				$newimgname .= ".jpg";
			endif;
			$srcimg=imagecreatefromjpeg($imgname);
		elseif ($pt == 3):
			if ($i):
				$newimgname .= ".png";
			endif;
			$srcimg=imagecreatefrompng($imgname);
		else:
			return "";
		endif;
		$fn = "../img/".$subpath."/s".$maxsize."_".$newimgname; // testované jméno souboru na neexistenci
		$in = $subpath."/s".$maxsize."_".$newimgname;
		$i = 0;
		while (file_exists($fn)):
			++$i;
			$fn = "../img/".$subpath."/s".$maxsize."_".$i.$newimgname;
			$in = $subpath."/s".$maxsize."_".$i.$newimgname;
		endwhile;
		$new_v = $pv;
		$new_s = $ps;
		if ($pv > $maxsize || $ps > $maxsize):
			$koef = $pv/$ps;
			$new_v = round((($pv > $ps) ? $maxsize : $maxsize*$koef),0);
			$new_s = round($new_v/$koef,0);
			$finalimg = imagecreatetruecolor($new_s,$new_v);
			imagecopyresized($finalimg, $srcimg, 0,0,0,0, $new_s, $new_v, $ps, $pv);			
			if ($pt == 1):
				imagegif($finalimg, $fn);
			elseif ($pt == 2):
				imagejpeg($finalimg, $fn);
			elseif ($pt == 3):
				imagepng($finalimg, $fn);
			endif;
		else:
			$okmove = rename($imgname,$fn);
			if (!$okmove):
				die("Nepodařilo se uložit soubor - CreateFotoImg!");
			endif;
		endif;
		return $in;
	}
	function CreateFotoImg2($img,$maxsize,$subpath,$i)
	// vytvoří a uloží do podadresáře $subpath z obrázku $img jeho kopii o zadaném maximálním rozměru $maxsize
	// v případě úspěchu vrací relativní cestu vzhledem k adresáři img
	// pokud je uveden identifikátor záznamu z tabulky content - $i, pak se tvoří jméno obrázku pro soutěž
	{
		$imgname = $img["tmp_name"];
		$newimgname = ($i ? "soutez".$i : CreateFilename($img["name"],"yesdot"));
		$imgtype = $img["type"];
		$fn = "";
		if (($imgtype == "image/jpeg") || ($imgtype == "image/pjpeg")):
			if ($i):
				$newimgname .= ".jpg";
			endif;
		elseif ($imgtype == "image/gif"):
			if ($i):
				$newimgname .= ".gif";
			endif;
		elseif (($imgtype == "image/png") || ($imgtype == "image/x-png")):
			if ($i):
				$newimgname .= ".png";
			endif;
		else:
			return "";
		endif;
		list($ps, $pv, $pt, $pa) = getimagesize($imgname);
		$new_v = $pv;
		$new_s = $ps;
		if ($pv > $maxsize || $ps > $maxsize):
		  $koef = $pv/$ps;
		  $new_v = round((($pv > $ps) ? $maxsize : $maxsize*$koef),0);
		  $new_s = round($new_v/$koef,0);
		endif;
		$fn = "../img/".$subpath."/s".$maxsize."_".$newimgname; // testované jméno souboru na neexistenci
		$in = $subpath."/s".$maxsize."_".$newimgname;
		$i = 0;
		while (file_exists($fn)):
			++$i;
			$fn = "../img/".$subpath."/s".$maxsize."_".$i.$newimgname;
			$in = $subpath."/s".$maxsize."_".$i.$newimgname;
		endwhile;
		if ($pv > $maxsize || $ps > $maxsize):
			$params = "-sample ".$new_s."x".$new_v." ".$imgname." ".$fn;
			exec("convert $params",$out,$err);
			$in = ($err ? "" : 	$in);
		else:
			$okmove = move_uploaded_file($imgname,$fn);
			if (!$okmove):
				die("Nepodařilo se uložit soubor - CreateFotoImg2!");
			endif;
		endif;
		return $in;
	}
	function CreateFile2Handle($ftmp,$subpath)	
	// uloží do podadresáře $subpath uploadovaný soubor
	{
		$filename = $ftmp["tmp_name"];
		$newfilename = CreateFilename($ftmp["name"],"yesdot");
		$fn = "../".$subpath."/".$newfilename;
		$in = $subpath."/".$newfilename;
		$i = 0;
		while (file_exists($fn)):
			++$i;
			$fn = "../".$subpath."/".$i.$newfilename;
			$in = $subpath."/".$i.$newfilename;
		endwhile;
		$okmove = move_uploaded_file($filename,$fn);
		if (!$okmove):
			die("Nepodařilo se uložit soubor - CreateFile2Handle!");
		endif;
		return $in;
	}
	function GetHeaderFromCsv($csv,$callingsrc)
	// načte z importovaného souboru CSV záhlaví pro jména sloupců tabulky
	// $callingsrc je pochopitelně volající script
	{
		$server = $_SERVER["SERVER_NAME"];
		$script = $_SERVER["SCRIPT_NAME"];
		$lenstr = strlen($script);
		$lenpath = strpos($script,"edit/".$callingsrc);
		$path = substr($script,0,$lenpath);
		$csvfile = "http://".$server.$path.$csv;
		$csvcheckname = "../".$csv;
		$tblheader = "";
		if (file_exists($csvcheckname)):
			$fcsv = fopen($csvfile, "r");
			$tblheader = fgets($fcsv);
			fclose($fcsv);
		endif;
		return $tblheader;
	}
	function utf8_substr($str,$start)
	// funkce pro korektní zpracování utf8 řetězce
	{
		preg_match_all("/./u", $str, $ar);
		if(func_num_args() >= 3):
			$end = func_get_arg(2);
			return join("",array_slice($ar[0],$start,$end));
		else:
	    	return join("",array_slice($ar[0],$start));
		endif;
	} 
	function GetSearch()
	// generování fulltextového obsahu
	{
		// procházení tabulky menu
		$dotaz = "SELECT * FROM menu";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nezdařil se výběr z tabulky menu - GetSearch!");
		else:
			while ($record = mysql_fetch_array($result)):
				FileHandler($record["filename"],$record["titulek"]);
			endwhile;
		endif;
	}
	function FileHandler($file,$title)
	// úprava souboru obsahu
	{
		global $titlearr,$metatags,$patharr,$words;
		$server = $_SERVER["SERVER_NAME"];
		$script = $_SERVER["SCRIPT_NAME"];
		$lenstr = strlen($script);
		$lenpath = strpos($script,"edit/indexsearch.php");
		$path = substr($script,0,$lenpath).(strstr($file,".php") ? $file : "page.php?fp=$file");
		$fullpath = "http://".$server.$path;
		$fulldoc = @implode ('', @file ($fullpath));
		// odstřižení tagů
		$search = array (
		"'<head>.*?</head>'si",					// hlavička 
		"'<script[^>]*?>.*?</script>'si",		// javascript
		"'<[\/\!]*?[^<>]*?>'si",          		// html tagy
		"'\{.*?\}'si",							// {} tagy
		"'\[.*?\]'si",							// [] tagy
		"'\[.*?\]'si",							// [] tagy
		"'<.*?>'si",							// <> tagy
		"'\(.*?\)'si",							// () tagy
		"'(<!--).*?(-->)'si",					// komentáře
		"'([\r\n])[\s]+'",						// mezery
		"'&(quot|#34);'i",						// html entity
		"'&(amp|#38);'i",
		"'&(lt|#60);'i",
		"'&(gt|#62);'i",
		"'&(nbsp|#160);'i",
		"'&(iexcl|#161);'i",
		"'&(cent|#162);'i",
		"'&(pound|#163);'i",
		"'&(copy|#169);'i",
		"'&#(\d+);'e"							// zpracování php
		);
		// nahrazující znaky
		$replace = array(
		" ", 
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		"",
		" ",
		"\\1",
		"\"",
		"&",
		"<",
		">",
		" ",
		chr(161),
		chr(162),
		chr(163),
		chr(169),
		"chr(\\1)"
		);
		$title = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$title);
		$text = preg_replace($search, $replace, $fulldoc);
		// nahrazení tvrdé mezery
		$text = str_replace("&nbsp;", " ", $text);
		$titlearr[] = $title;
		$patharr[] = $fullpath;
		$words[] = $text;
	}
	function GetMysqlVer()
	// vrací řetězec obsahující údaje o verzi MySQL
	{
		$dotazver = "SELECT VERSION()";
		$resultver = mysql_query("$dotazver");
		if (!$resultver):
			die("Ani číslo verze MySQL serveru už nedokážu zjistit - search.tpl!");
		endif;
		$recordver = mysql_fetch_row($resultver);
		return $recordver[0];
	}
	function GetIntTime($timestr)	
	// generování časového údaje
	{
	$mysqlver = substr(GetMysqlVer(),0,5);
	if (strlen($timestr) > 10): 
		if ($mysqlver <= "4.1.0"):
			$cas = mktime(substr($timestr,8,2),substr($timestr,10,2),substr($timestr,12,2),substr($timestr,4,2),substr($timestr,6,2),substr($timestr,0,4));
		else:
			$cas = mktime(substr($timestr,11,2),substr($timestr,14,2),substr($timestr,17,2),substr($timestr,5,2),substr($timestr,8,2),substr($timestr,0,4));
		endif;
	else:
		$cas = mktime(0,0,0,substr($timestr,5,2),substr($timestr,8,2),substr($timestr,0,4));
	endif;
	return $cas;
	}
	function CheckLogin()
	// kontroluje, zda je uživatel přihlášený
	{
		if (!isset($_SERVER["PHP_AUTH_USER"]) || ($_POST["videno"] == 1 && $_POST["olduser"] == $_SERVER["PHP_AUTH_USER"])):
			header("WWW-authenticate: basic realm=\"Redakce\"");
			header("HTTP/1.0 401 Unauthorized");
			echo "<h3>Uzivatel neprihlasen!</h3>\n";
			exit;
		else:
			$uzivatel = strtolower($_SERVER["PHP_AUTH_USER"]);
			$sql_dotaz = "SELECT * FROM redaktor WHERE user='$uzivatel'";
			$result = mysql_query("$sql_dotaz");
			if ($result):
				$poczaz = mysql_num_rows($result);
				if ($poczaz == 0):
					header("WWW-authenticate: basic realm=\"Redakce\"");
					header("HTTP/1.0 401 Unauthorized");
					echo "<h3>Zadny takovy redaktor neexistuje!</h3>\n";
					exit;
				endif;
				$record = mysql_fetch_array($result);
				if ($_SERVER["PHP_AUTH_PW"]!= $record["pwd"]):
					header("WWW-authenticate: basic realm=\"Redakce\"");
					header("HTTP/1.0 401 Unauthorized");
					echo "<h3>Spatne heslo!</h3>\n";
					exit;
				endif;
				return $record["id"];
			else:
				header("WWW-authenticate: basic realm=\"Redakce\"");
				header("HTTP/1.0 401 Unauthorized");
				echo "<h3>Spatne uzivatelske jmeno!</h3>\n";
				exit;
			endif;
		endif;
	}
	function SetCzDateForm($dat)
	// převádí formát data $dat z amerického na český
	{
		return date('d.m.Y',mktime(0,0,0,substr($dat,5,2),substr($dat,8,2),substr($dat,0,4)));	
	}		
	function GetUpLevelPlace($pl,$l1,$l2,$l3,$l4,$l5,$l6)
	// vrací ID nadrazeneho uzemi
	// $pl je uroven zkoumaneho uzemi
	{
		$podm = "";
		for ($i=1;$i<=6;$i++):
			$promlev = "l".$i;
			$podm .= ($i < $pl ? "level$i=$l".$$promlev : "level$i=0");
			if ($i < 6):
				$podm .= " AND ";
			endif;
		endfor;
		$dotaz = "SELECT * FROM mista WHERE $podm";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nezdaril se vyber z tabulky mist - GetUpLevelPlace!");
		else:
			$record = mysql_fetch_array($result);
			return $record["id"];
		endif;
	}
	function GetMaxIdLevel($pl,$id)
	// vrací novou hodnotu pro daný level 
	// $id určuje nadřazené menu
	{	
		if ($pl == 1):
			$dotaz = "SELECT MAX(level1) FROM mista";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nezdařil se vyber - GetMaxIdLevel!");
			else:
				$record = mysql_fetch_array($result);
				return $record[0]+1;
			endif;
		else:
			$dotaz1 = "SELECT * FROM mista WHERE id=$id";
			$result1 = mysql_query("$dotaz1");
			if (!$result1):
				die("Nezdařil se prvni vyber - GetMaxIdLevel!");
			endif;
			$record1 = mysql_fetch_array($result1);
			$podm = "";
			for ($i=1; $i<=6; $i++):
				if ($i > 1):
					$podm .= " AND ";
				endif;
				$podm .= "level$i=".$record1[$i];
				if (!$record1[$i+1]):
					break;
				endif;
			endfor;
			$sl = "level".$pl; 
			$dotaz2 = "SELECT MAX(".$sl.") FROM mista WHERE $podm";
			$result2 = mysql_query("$dotaz2");
			if (!$result2):
				die("Nezdařil se druhy vyber - GetMaxIdLevel!");
			else:
				$record2 = mysql_fetch_array($result2);
				return $record2[0]+1;
			endif;
		endif;
	}
	function GetSelPersQuery($rt)
	// vrací dotaz pro výběr z tabulky osoba
	// $rt je příslušný záznam z tabulky selosoba
	{
		$dotaz = "SELECT o.jmeno,o.prijmeni,o.titulpred,o.titulza";
		// výběr jednotlivých polí
		$perfields = "";
		$perfields .= ($rt["ptelefon1"] ? ",o.telefon1" : "");
		$perfields .= ($rt["ptelefon2"] ? ",o.telefon2" : "");
		$perfields .= ($rt["pmobil1"] ? ",o.mobil1" : "");
		$perfields .= ($rt["pmobil2"] ? ",o.mobil2" : "");
		$perfields .= ($rt["pfax"] ? ",o.fax" : "");
		$perfields .= ($rt["picq"] ? ",o.icq" : "");
		$perfields .= ($rt["pemail1"] ? ",o.email1" : "");
		$perfields .= ($rt["pemail2"] ? ",o.email2" : "");
		$perfields .= ($rt["pimg"] ? ",o.img" : "");
		$perfields .= ($rt["pidzarazeni"] ? ",pz.nazev AS prac_zarazeni" : "");
		$zartbl = ($rt["pidzarazeni"] ? 1 : 0);
		$perfields .= ($rt["pidodbor"] ? ",ob.nazev AS nazev_odboru" : "");
		$odbtbl = ($rt["pidodbor"] ? 1 : 0);
		$perfields .= ($rt["pidoddeleni"] ? ",od.nazev AS nazev_oddeleni" : "");
		$oddtbl = ($rt["pidoddeleni"] ? 1 : 0);
		$perfields .= ($rt["pidbudova"] ? ",bu.nazev AS nazev_budovy,bu.ulice" : "");
		$budtbl = ($rt["pidbudova"] ? 1 : 0);
		$perfields .= ($rt["pdvere"] ? ",o.dvere" : "");
		$perfields .= ($rt["pidstrana"] ? ",st.nazev AS nazev_strany,st.zkratka" : "");
		$strtbl = ($rt["pidstrana"] ? 1 : 0);
		$perfields .= ($rt["pidzarzast"] ? ",zz.nazev AS nazev_funkce_zastup" : "");
		$zzatbl = ($rt["pidzarzast"] ? 1 : 0);
		$perfields .= ($rt["pidzarrada"] ? ",zr.nazev AS nazev_funkce_rada" : "");
		$zratbl = ($rt["pidzarrada"] ? 1 : 0);
		$perfields .= ($rt["pidvybor"] ? ",vy.nazev AS nazev_vyboru" : "");
		$vybtbl = ($rt["pidvybor"] ? 1 : 0);
		$perfields .= ($rt["pidzarvybor"] ? ",zv.nazev AS nazev_funkce_vybor" : "");
		$zvytbl = ($rt["pidzarvybor"] ? 1 : 0);
		$perfields .= ($rt["pidkomise"] ? ",ko.nazev AS nazev_komise" : "");
		$komtbl = ($rt["pidkomise"] ? 1 : 0);
		$perfields .= ($rt["pidzarkomise"] ? ",zk.nazev AS nazev_funkce_komise" : "");
		$zkotbl = ($rt["pidzarkomise"] ? 1 : 0);
		$dotaz .= $perfields." FROM osoba AS o";
		$dotaz .= ($zartbl ? ", zarazeni AS pz" : "");
		$dotaz .= ($odbtbl ? ", odbor AS ob" : "");
		$dotaz .= ($oddtbl ? ", oddeleni AS od" : "");
		$dotaz .= ($budtbl ? ", budova AS bu" : "");
		$dotaz .= ($strtbl ? ", strana AS st" : "");
		$dotaz .= ($zzatbl ? ", zarzast AS zz" : "");
		$dotaz .= ($zratbl ? ", zarrada AS zr" : "");
		$dotaz .= ($vybtbl ? ", vybor AS vy" : "");
		$dotaz .= ($zvytbl ? ", zarvybor AS zv" : "");
		$dotaz .= ($komtbl ? ", komise AS ko" : "");
		$dotaz .= ($zkotbl ? ", zarkomise AS zk" : "");
		// podmínky
		if ($rt["polesel"]):
			$perclaus = " WHERE o.".$rt["polesel"].($rt["poleval"] ? "=" : "!=").$rt["poleval"];
			$perclaus .= ($zartbl ? " AND o.idzarazeni=pz.id" : "");
			$perclaus .= ($odbtbl ? " AND o.idodbor=ob.id" : "");
			$perclaus .= ($oddtbl ? " AND o.idoddeleni=od.id" : "");
			$perclaus .= ($budtbl ? " AND o.idbudova=bu.id" : "");
			$perclaus .= ($strtbl ? " AND o.idstrana=st.id" : "");
			$perclaus .= ($zzatbl ? " AND o.idzarzast=zz.id" : "");
			$perclaus .= ($zratbl ? " AND o.idzarrada=zr.id" : "");
			$perclaus .= ($vybtbl ? " AND o.idvybor=vy.id" : "");
			$perclaus .= ($zvytbl ? " AND o.idzarvybor=zv.id" : "");
			$perclaus .= ($komtbl ? " AND o.idkomise=ko.id" : "");
			$perclaus .= ($zkotbl ? " AND o.idzarkomise=zk.id" : "");
			$dotaz .= $perclaus;
		endif;
		// řazení
		$orderclaus = " ORDER BY ";
		if ($rt["poleraz"] == "prijmeni"):
			$orderclaus .= "o.prijmorder";
		else:
			if ($zartbl):
				$orderclaus .= "pz.level";
			elseif ($zzatbl):
				$orderclaus .= "zz.level";
			elseif ($zratbl):
				$orderclaus .= "zr.level";
			elseif ($zvytbl):
				$orderclaus .= "zv.level";
			elseif ($zkotbl):
				$orderclaus .= "zk.level";
			else:
				$orderclaus .= "o.id";
			endif;
		endif;
		$dotaz .= $orderclaus;
		return $dotaz;
	}
	function IsArticleInThisMenu($art,$mid)
	// zjistí zda již není článek připojen k aktuální položce menu
	{
		$i = 0;
		$dotaz = "SELECT * FROM articlejoin WHERE mtid=$art AND menuid=$mid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodaril se vyber z tabulky articlejoin - fce IsArticleInThisMenu - $dotaz!");
		else:
			$i = mysql_num_rows($result);
		endif;
		return $i;
	}
	function ConvText($p)
	// konvertuje text pro lepsi ceske razeni
	{
		$po = $p;
		$po = ereg_replace("ä","az",$po);
		$po = ereg_replace("ö","oz",$po);
		$po = ereg_replace("ü","uz",$po);
		$po = ereg_replace("Ä","Az",$po);
		$po = ereg_replace("Ö","Oz",$po);
		$po = ereg_replace("Ü","Uz",$po);
		$po = ereg_replace("á","az",$po);
		$po = ereg_replace("č","cz",$po);
		$po = ereg_replace("ď","dz",$po);
		$po = ereg_replace("é","ez",$po);
		$po = ereg_replace("ě","ez",$po);
		$po = ereg_replace("í","iz",$po);
		$po = ereg_replace("ľ","lz",$po);
		$po = ereg_replace("ň","nz",$po);
		$po = ereg_replace("ó","oz",$po);
		$po = ereg_replace("ř","rz",$po);
		$po = ereg_replace("š","sz",$po);
		$po = ereg_replace("ť","tz",$po);
		$po = ereg_replace("ú","uz",$po);
		$po = ereg_replace("ů","uz",$po);
		$po = ereg_replace("ý","yz",$po);
		$po = ereg_replace("ž","zz",$po);
		$po = ereg_replace("Á","Az",$po);
		$po = ereg_replace("Č","Cz",$po);
		$po = ereg_replace("Ď","Dz",$po);
		$po = ereg_replace("É","Ez",$po);
		$po = ereg_replace("Ě","Ez",$po);
		$po = ereg_replace("Í","Iz",$po);
		$po = ereg_replace("Ľ","Lz",$po);
		$po = ereg_replace("Ň","Nz",$po);
		$po = ereg_replace("Ó","Oz",$po);
		$po = ereg_replace("Ř","Rz",$po);
		$po = ereg_replace("Š","Sz",$po);
		$po = ereg_replace("Ú","Uz",$po);
		$po = ereg_replace("Ů","Uz",$po);
		$po = ereg_replace("Ý","Yz",$po);
		$po = ereg_replace("Ž","Zz",$po);
		return $po;
	}
	function GetNrVotes($idvote,$odp)
	{
		$poc = 0;
		$dotaz = "SELECT * FROM hlas WHERE idvote=$idvote AND odp=$odp";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Chyba - $dotaz");
		endif;
		$poc = mysql_num_rows($result);
		return $poc;
	}
?>
