<?php
	require $pref."scripts/settings.php";
	
	function VypisChybu($c)
	{
		if ($c == 1):
			$txt = "Špatně zapsaná e-mailová adresa!";
		elseif ($c == 16):
			$txt = "Chybí název";
		elseif ($c == 9):
			$txt = "Chybí uživatelské jméno";
		elseif ($c == 10):
			$txt = "Chybí heslo";
		elseif ($c == 11):
			$txt = "Chybí heslo znovu";
		elseif ($c == 12):
			$txt = "Heslo a  heslo znovu jsou různé";
		elseif ($c == 3):
			$txt = "Chybí e-mailová adresa";
		elseif ($c == 13):
			$txt = "Chybí jméno";
		elseif ($c == 14):
			$txt = "Chybí příjmení";
		elseif ($c == 15):
			$txt = "Uživatelské jméno je již použito";
		elseif ($c == 2):
			$txt = "Chybí jméno a příjmení žadatele";
		elseif ($c == 8):
			$txt = "Chybí jméno a příjmení pisatele";
		elseif ($c == 5):
			$txt = "Chybí ulice";
		elseif ($c == 6):
			$txt = "Chybí město";
		elseif ($c == 7):
			$txt = "Chybí psč";
		elseif ($c == 4):
			$txt = "Chybí text";
		endif;
		
		return $txt;
		
	}
	
	function BezSkriptu($text)
	// odstraňuje většinu pokusů o hacknutí skrzevá zadaný text ve formuláři
	{
	$nahrada = " (CENSORED) ";
	
		$text = eregi_replace("include","$nahrada",$text);
		$text = eregi_replace("require","$nahrada",$text);
	
		$text = strip_tags($text);
		$znak = 50; //dlouha slova delit po 50 znacich
		$slovo = split("[[:blank:]]+", $text); //rozdeleni textu na slova
		for ($y = 0; $y < count($slovo); $y++):
			$slovo[$y] = trim($slovo[$y]); //odstraneni mezer na konci slova  
 			if (strlen($slovo[$y]) <= $znak): //nebudeme delit
				if (eregi("^(http://.+\..{2,3})$", $slovo[$y])): //jedna se odkaz typu http://
					$odkaz = eregi_replace("^(http://.+\..{2,3})$", "<a href=\\1>\\1</a> ", $slovo[$y]);
				else:
					$odkaz = $slovo[$y] . " "; //jedna se o normalni slovo
				endif;
				$celek .= $odkaz; //spojeni vsech slov opet dohromady  
			else:
				$delit = ceil(strlen($slovo[$y])/$znak); //delime dlouhe slovo
				for($z = 0; $z < $delit; $z++):
					$cast = utf8_substr($slovo[$y], $z * $znak, $znak);
					$celek .= $cast . " "; //na konec jednotlivych casti pridat pomlcku
				endfor;
			endif;
		endfor;
	return $celek;
	}

	function FileProm()
	// vrací proměnnou s názvem volajícího skriptu
	{
		$script = $_SERVER["SCRIPT_NAME"];
		$len = strlen($script);
		$poz = strrpos($script, "/")+1;
		$file = substr($script, $poz, $len-$poz);
		return $file;
	}
	
	function MenuHandler($f)
	// vrací pole s údaji menu
	{
		$dotaz = "SELECT * FROM menu WHERE filename='$f'";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Z tabulky s nabídkou se nepodařilo načíst ani Ň - fce MenuHandler");
		else:
			$menuarr = mysql_fetch_array($result);
		endif;
		
		return $menuarr;
	}
	
	function GetLevel1Menu($mid)
	// vrací id položky menu úrovně 1
	{
		$dotaz = "SELECT * FROM menu WHERE id=$mid";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Z tabulky s nabídkou se nepodařilo načíst ani Ň - fce GetLevel1Menu");
		else:
			$menuarr = mysql_fetch_array($result);
			$ml = $menuarr["level"];
			while ($ml > 1):
				$mid = $menuarr["idtop"];
				$dotaz = "SELECT * FROM menu WHERE id=$mid";
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Z tabulky s nabídkou se nepodařilo načíst ani Ň - fce GetLevel1Menu");
				else:
					$menuarr = mysql_fetch_array($result);
					$ml = $menuarr["level"];
				endif;
			endwhile;
		endif;
		
		return $menuarr;
	}

	function IsSubMenu($f)
	// zjišťuje, zda existuje submenu
	{
		$dotaz = "SELECT * FROM menu WHERE filename='$f'";
		$result = mysql_query("$dotaz");
		$s = 0;
		if (!$result):
			die("Z tabulky s nabídkou se nepodařilo načíst ani Ň - fce IsSubMenu 1");
		else:
			$record = mysql_fetch_array($result);
			$i = $record["id"];
			$dotaz = "SELECT * FROM menu WHERE idtop='$i'";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Z tabulky s nabídkou se nepodařilo načíst ani Ň - fce IsSubMenu 2");
			else:
				$s = mysql_num_rows($result);
			endif;
		endif;
		
		return $s;
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

	function GetTxtNr($mt)
	// vrací počet textových údajů článku
	// $mt je id článku
	{
		$dotaz = "SELECT * FROM content AS ct, tablename AS tn WHERE ct.mtid=$mt AND ct.idtbl=tn.id AND tn.typ=\"txt\"";
		$result = mysql_query("$dotaz");
		$s = 0;
		if (!$result):
			die("Z tabulky textů se nepodařilo načíst ani Ň - fce GetTxtNr");
		else:
			$s = mysql_num_rows($result);
		endif;
		
		return $s;
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
		
	function TblHandler($i,$t)
	// vrací pole s údaji tabulky
	// $i je id klíčové položky
	// $t je název tabulky
	{
		$dotaz = "SELECT * FROM $t WHERE id=$i";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Z tabulky se nepodařilo načíst ani Ň - fce TblHandler - dotaz vypadá takhle: $dotaz");
		else:
			$arr = mysql_fetch_array($result);
		endif;
		
		return $arr;
	}
	
	function HPKalendarSelect($misto,$dny)
		// funkce vybírá záznamy pro zobrazení v kalendáři na HP
		// $misto je id mista
		// $dny udava, kolik dnu dopredu budou akce zobrazeny
		{
		$dat1 = Time()-86400;
		$dat2 = $dat1+(86400*$dny);
		
		// výběr konkrétního místa
		$sql_dotaz = "SELECT level1,level2,level3,level4 FROM mista WHERE id=".$misto;
		$result = mysql_query("$sql_dotaz");
		if (!$result):
			die("Nepodařilo se vybrat místo konání akce - HPKalendarSelect");
		endif;
		$record = mysql_fetch_array($result);
		if (!$record["level4"]):
			if (!$record["level3"]):
				if (!$record["level2"]):
					if (!$record["level1"]):
						$sql_dotaz = "SELECT DISTINCT k.id AS kid, k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." ORDER BY k.datum";
					else:
						$sql_dotaz = "SELECT DISTINCT k.id AS kid, k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." ORDER BY k.datum";
					endif;
				else:
					$sql_dotaz = "SELECT DISTINCT k.id AS kid, k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." AND s.level2=".$record["level2"]." ORDER BY k.datum";
				endif;
			else:
				$sql_dotaz = "SELECT DISTINCT k.id AS kid, k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." AND s.level2=".$record["level2"]." AND s.level3=".$record["level3"]." ORDER BY k.datum";
			endif;
		else:
			$sql_dotaz = "SELECT k.id AS kid, k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=".$misto." ORDER BY k.datum";
		endif;
	
		$result = mysql_query("$sql_dotaz");

		if (!$result):
			die("Nepodařilo se vybrat akce - HPKalendarSelect");
		endif;
		return $result;
		}
	

	function KalendarSelect($mis,$obd,$typ)
		// výběr dat pro kalendář
		{
		$dat1 = Time()-86400;
		$dat2 = $dat1+(86400*$obd);
		
		// dotaz pro výběr dat
		$sql_dotaz = "SELECT level1,level2,level3,level4 FROM mista WHERE id=".$mis;
		$result = mysql_query("$sql_dotaz");
		if (!$result):
			die("Nepodařilo se vybrat místo konání akce - KalendarSelect");
		endif;
		$record = mysql_fetch_array($result);
		if ($typ == 99):
			if (!$record["level4"]):
				if (!$record["level3"]):
					if (!$record["level2"]):
						if (!$record["level1"]):
							$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." ORDER BY k.datum";
						else:
							$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." ORDER BY k.datum";
						endif;
					else:
						$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." AND s.level2=".$record["level2"]." ORDER BY k.datum";
					endif;
				else:
					$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." AND s.level2=".$record["level2"]." AND s.level3=".$record["level3"]." ORDER BY k.datum";
				endif;
			else:
				$sql_dotaz = "SELECT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=".$mis." ORDER BY k.datum";
			endif;
		else:
			if (!$record["level4"]):
				if (!$record["level3"]):
					if (!$record["level2"]):
						if (!$record["level1"]):
							$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.typakce_id=".$typ." AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." ORDER BY k.datum";
						else:
							$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.typakce_id=".$typ." AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." ORDER BY k.datum";
						endif;
					else:
						$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.typakce_id=".$typ." AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." AND s.level2=".$record["level2"]." ORDER BY k.datum";
					endif;
				else:
					$sql_dotaz = "SELECT DISTINCT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p,mista s WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.typakce_id=".$typ." AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=s.id AND s.level1=".$record["level1"]." AND s.level2=".$record["level2"]." AND s.level3=".$record["level3"]." ORDER BY k.datum";
				endif;
			else:
				$sql_dotaz = "SELECT k.id AS kid,k.datum,k.datum_do,k.zacatek,k.titulek,k.anotace,m.podnik,m.ulice,m.mesto,p.jmeno,p.telefon,p.email FROM kalendar k,podnik m,poradatel p WHERE k.schvaleno=1 AND k.podnik_id=m.id AND k.porad_id=p.id AND k.typakce_id=".$typ." AND k.datum<=".$dat2." AND k.datum_do>=".$dat1." AND k.misto_id=".$mis." ORDER BY k.datum";
			endif;
		endif;
	
		$result = mysql_query("$sql_dotaz");
		if (!$result):
			 die("Nepodařilo se vybrat akce - KalendarSelect");
		endif;
		
		return $result;
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
		$mysqlver = GetMysqlVer();
		if (strlen($timestr) > 10): 
			if ($mysqlver <= "4.0.1"):
				$cas = mktime(substr($timestr,8,2),substr($timestr,10,2),substr($timestr,12,2),substr($timestr,4,2),substr($timestr,6,2),substr($timestr,0,4));
			else:
				$cas = mktime(substr($timestr,11,2),substr($timestr,14,2),substr($timestr,17,2),substr($timestr,5,2),substr($timestr,8,2),substr($timestr,0,4));
			endif;
		else:
			$cas = mktime(0,0,0,substr($timestr,5,2),substr($timestr,8,2),substr($timestr,0,4));
		endif;
		
		return $cas;
		}
		
	function HasUserVote($u,$a)
		// hlasoval již uživatel $u v anketě $a?
		{
		if (!$u):
			return 1;
		else:
			$dotaz = "SELECT * FROM hlas WHERE idvote=$a AND iduser=$u";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nezdařil se výběr z tabulky hlas - HasUserVote!");
			endif;
			return mysql_num_rows($result);
		endif;
		}

	function HasUserCst($u,$s)
		// soutěžil již uživatel $u v soutěži $s?
		{
		if (!$u):
			return 1;
		else:
			$ru = TblHandler($u,"uzivatel"); 
			if ($ru["fullreg"]):
				$dotaz = "SELECT * FROM odpoved WHERE idcst=$s AND iduser=$u";
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Nezdařil se výběr z tabulky odpoved - HasUserCst!");
				endif;
				return mysql_num_rows($result);
			else: 
				return 1;
			endif;
		endif;
		}
		
	function SetCzDateForm($dat)
		// převádí formát data $dat z amerického na český
		{
			return date('d.m.Y',mktime(0,0,0,substr($dat,5,2),substr($dat,8,2),substr($dat,0,4)));	
		}		
		
	function CheckUserName($uid,$uname)
		// kontroluje, zda není již už. jméno použito
		{
			$dotaz = "SELECT * FROM uzivatel ".($uid ? "WHERE id!=$uid AND user='$uname'" : "WHERE user='$uname'");
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Výběr z tabulky uživatel se nezdařil - CheckUserName!");
			else:
				return mysql_num_rows($result);
			endif;
		}
	
	function Add2Stat($fn)
		// zapisuje do tabulek stat a toppages navstevu konkretni stranky $fn
		{
			$dotazart = "SELECT * FROM menu AS m, mastertxt AS mt WHERE m.filename='$fn' AND m.id=mt.menuid";
			$resultart = mysql_query("$dotazart");
			if (!$resultart):
				die("Výběr pro zjištění článků se nezdařil - Add2Stat!");
			else:
				$pocart = mysql_num_rows($resultart);
				if ($pocart):
					$recordart = mysql_fetch_array($resultart);
					$mi = $recordart["menuid"];
					$ip = $_SERVER["REMOTE_ADDR"];
					$hn = gethostbyaddr($ip);
					$dotazstat = "INSERT INTO stat (menuid,ipadresa,hostname) VALUES ($mi,'$ip','$hn')";
					$resultstat = mysql_query("$dotazstat");
					if (!$resultstat):
						die("Zápis do tabulky stat se nezdařil - Add2Stat!");
					endif;
					$dotazmi = "SELECT * FROM toppages WHERE menuid=$mi";
					$resultmi = mysql_query("$dotazmi");
					if (!$resultmi):
						die("Výběr pro zjištění exitence menu v tabulce toppages se nezdařil - Add2Stat!");
					else:
						$pocmi = mysql_num_rows($resultmi);
						if ($pocmi):
							$dotaztop = "UPDATE toppages SET cetnost = cetnost + 1 WHERE menuid = $mi";
						else:
							$dotaztop = "INSERT INTO toppages (menuid,cetnost) VALUES ($mi,1)";
						endif;
						$resulttop = mysql_query("$dotaztop");
						if (!$resultstat):
							die("Úprava tabulky toppages se nezdařila - Add2Stat!");
						endif;
					endif;
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
			$orderclaus .= "o.prijmeni";
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
		
	function GetCzechFieldName($t)
		// podle názvu pole $t v tabulce vrací český nadpis
		{
		$ct = "";
		switch ($t):
			case "jmeno":
				$ct = "jméno";
				break;
			case "prijmeni":
				$ct = "příjmení";
				break;
			case "titulpred":
				$ct = "titul před jménem";
				break;
			case "titulza":
				$ct = "titul za jménem";
				break;
			case "telefon1":
				$ct = "telefon";
				break;
			case "telefon2":
				$ct = "telefon 2";
				break;
			case "mobil1":
				$ct = "mobil";
				break;
			case "mobil2":
				$ct = "mobil 2";
				break;
			case "email1":
				$ct = "e-mail";
				break;
			case "email2":
				$ct = "e-mail 2";
				break;
			case "img":
				$ct = "foto";
				break;
			case "prac_zarazeni":
				$ct = "pracovní zařazení";
				break;
			case "nazev_odboru":
				$ct = "název odboru";
				break;
			case "nazev_oddeleni":
				$ct = "název oddělení";
				break;
			case "nazev_budovy":
				$ct = "název budovy";
				break;
			case "nazev_strany":
				$ct = "název strany";
				break;
			case "zkratka":
				$ct = "polit. přísl.";
				break;
			case "nazev_funkce_zastup":
				$ct = "funkce v zastupitelstvu";
				break;
			case "nazev_funkce_rada":
				$ct = "funkce v radě";
				break;
			case "nazev_vyboru":
				$ct = "název výboru zastupitelstva";

				break;
			case "nazev_funkce_vybor":
				$ct = "funkce ve výboru";
				break;
			case "nazev_komise":
				$ct = "název komise rady";
				break;
			case "nazev_funkce_komise":
				$ct = "funkce v komisi";
				break;
			default:
				$ct = $t;
				break;
		endswitch;
		return $ct;
		}
		
	function GetNumRecords($t,$p)
		// zjisteni poctu zaznamu tabulky $t podle podminky $p
		{
			$dotaz = "SELECT * FROM $t WHERE $p";
			$result = mysql_query("$dotaz");
			$i = 0;
			if (!$result):
				die("Nezdaril se vyber z tabulky $t - GetNumRecords()!");
			else:
				$i = mysql_num_rows($result);
			endif;
			
			return $i;
		}
		
	function GetMaxTime($t,$c,$p)
		// zjisteni casoveho maxima hodnoty $c v tabulce $t podle podminky $p
		{
			$dotaz = "SELECT MAX($c) FROM $t WHERE $p";
			$result = mysql_query("$dotaz");
			$i = "";
			if (!$result):
				die("Nezdaril se vyber z tabulky $t - GetNumRecords()!");
			else:
				$record = mysql_fetch_array($result);
				$i = $record[0];
			endif;
			
			return $i;
		}
		
	function GetPlainText($t)
		// vrací textový řetězec $tbez diakritiky
		{
			$t = ereg_replace("ä","a",$t);
			$t = ereg_replace("ö","o",$t);
			$t = ereg_replace("ü","u",$t);
			$t = ereg_replace("Ä","A",$t);
			$t = ereg_replace("Ö","O",$t);
			$t = ereg_replace("Ü","U",$t);
			$t = ereg_replace("á","a",$t);
			$t = ereg_replace("č","c",$t);
			$t = ereg_replace("ď","d",$t);
			$t = ereg_replace("é","e",$t);
			$t = ereg_replace("ě","e",$t);
			$t = ereg_replace("í","i",$t);
			$t = ereg_replace("ľ","l",$t);
			$t = ereg_replace("ň","n",$t);
			$t = ereg_replace("ó","o",$t);
			$t = ereg_replace("ř","r",$t);
			$t = ereg_replace("š","s",$t);
			$t = ereg_replace("ť","t",$t);
			$t = ereg_replace("ú","u",$t);
			$t = ereg_replace("ů","u",$t);
			$t = ereg_replace("ý","y",$t);
			$t = ereg_replace("ž","z",$t);
			$t = ereg_replace("Á","A",$t);
			$t = ereg_replace("Č","C",$t);
			$t = ereg_replace("Ď","D",$t);
			$t = ereg_replace("É","E",$t);
			$t = ereg_replace("Ě","E",$t);
			$t = ereg_replace("Í","I",$t);
			$t = ereg_replace("Ľ","L",$t);
			$t = ereg_replace("Ň","N",$t);
			$t = ereg_replace("Ó","O",$t);
			$t = ereg_replace("Ř","R",$t);
			$t = ereg_replace("Š","S",$t);
			$t = ereg_replace("Ú","U",$t);
			$t = ereg_replace("Ů","U",$t);
			$t = ereg_replace("Ý","Y",$t);
			$t = ereg_replace("Ž","Z",$t);
			return $t;
		}
		
?>