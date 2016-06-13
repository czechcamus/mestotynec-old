<?php
include "../scripts/settings.php";
include "./scripts/editfce.php";
$idredaktor = CheckLogin();

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$menuid = $_POST["menuid"];
$akce = $_POST["akce"];
$tbl = $_POST["tbl"];
$ttbl = $_POST["ttbl"];
$fn = $_POST["fn"];
if (!$tbl):
	$akce = $_GET["akce"];
	$tbl = $_GET["tbl"];
	$ttbl = $_GET["ttbl"];
	$fn = $_GET["fn"];
	$placelevel = $_GET["placelevel"];
	$idtema = $_GET["idtema"];
endif;
if (($tbl != "menu") && ($tbl != "mastertxt") && ($tbl != "anketa")):
	$tbltyp = GetTblType($tbl);
endif;

if (($akce == "add") || ($akce == "edit")):
	if ($tbl == "menu"):
		$id = $_POST["itemid"];
		$titulek = $_POST["titulek"]; 
		$oldfilename = $_POST["oldfilename"]; 
		$filename = $_POST["filename"]; 
		if (!$filename):
			$filename = GetFilename($menuid,$titulek);
		endif;
		$obsah = $_POST["obsah"]; 
		$idtop = $menuid; 
		$pozice = $_POST["pozice"]; 
		$level = $_POST["level"];
	elseif ($tbl == "mastertxt"):
		$id = $_POST["itemid"];
		$mtid = $id;
		$titulek = $_POST["titulek"]; 
		$den1 = $_POST["den1"];
		$mes1 = $_POST["mes1"];
		$rok1 = $_POST["rok1"];
		$den2 = $_POST["den2"];
		$mes2 = $_POST["mes2"];
		$rok2 = $_POST["rok2"];
		$perexhp = ($_POST["perexhp"] ? ($menuid == 1 ? 0 : 1) : 0);
		$perexmid = ($_POST["perexmid"] ? GetLevel1MenuId($menuid) : 0);
		$idautor = $_POST["idautor"]; 
		$thumbimgon = ($menuid == 1 ? 0 : $_POST["thumbimgon"]);
		if ($thumbimgon):
			$thumbimg = $_POST["thumbimg"];
			$thumbimgtmp = $_FILES["thumbimgtmp"];
			if ($thumbimgtmp["tmp_name"] && $thumbimgtmp["tmp_name"] != "none"):
				$obr = CreateFile2Handle($thumbimgtmp,"temp");
				$thumbimg = CreateFotoImg($obr,"150","others",0);
				if (!$thumbimg):
					die("nepodařilo se vytvořit snímek pro úvodník článku");
				endif;
			endif;
			$titlethumbimg = ($thumbimg ? $_POST["titlethumbimg"] : "");
			$cssthumbimg = ($thumbimg ? $_POST["cssthumbimg"] : "");
		else:
			$thumbimg = "";
			$titlethumbimg = "";
			$cssthumbimg = "";
		endif;
		$maininfo = ($_POST["maininfo"] ? ($menuid == 1 ? 0 : 1) : 0);
		$aktualinfo = ($_POST["aktualinfo"] ? ($maininfo ? 0 : ($menuid == 1 ? 0 : 1)) : 0);
		$typinfoid = ($aktualinfo ? ($_POST["typinfoid"] ? $_POST["typinfoid"] : 0) : 0);
		$perex = $_POST["perex"];
		// datum
		if (!($den1.$mes1.$rok1)):
			$dat1ok = 1;
			$datum1 = date("Y-m-d",time());
		else:
			$dat1ok = checkdate($mes1,$den1,$rok1);
		endif;
		$datum1 = $rok1."-".$mes1."-".$den1;
		if (!($den2.$mes2.$rok2)):
			$dat2ok = 1;
			$datum2 = "9999-12-31";
		else:
			$dat2ok = checkdate($mes2,$den2,$rok2);
			$datum2 = $rok2."-".$mes2."-".$den2;
		endif;
	elseif ($tbl == "anketa"):
		$id = $_POST["itemid"];
		$otazka = $_POST["otazka"];
		$odp1 = $_POST["odp1"];
		$odp2 = $_POST["odp2"];
		$odp3 = $_POST["odp3"];
		$odp4 = $_POST["odp4"];
		$odp5 = $_POST["odp5"];
		$odp6 = $_POST["odp6"];
		$odp7 = $_POST["odp7"];
		$odp8 = $_POST["odp8"];
		$odp9 = $_POST["odp9"];
		$odp10 = $_POST["odp10"];
	elseif ($tbl == "pocasi"):
		$id = $_POST["itemid"];
		$den = $_POST["den"];
		$mes = $_POST["mes"];
		$rok = $_POST["rok"];
		$kodpoc = $_POST["kodpoc"];
		$rano = $_POST["rano"];
		$odpoledne = $_POST["odpoledne"];
		$datum = $rok."-".$mes."-".$den;
	elseif ($ttbl == "cis"):
		$id = $_GET["itemid"];
		if (!$id):
			$id = $_POST["itemid"];
		endif;
		if ($tbl == "budova"):
			$nazev = $_GET["nazev"];
			$ulice = $_GET["ulice"];
		elseif ($tbl == "zarazeni" || $tbl == "zarkomise" || $tbl == "zarvybor" || $tbl == "zarrada" || $tbl == "zarzast"):
			$nazev = $_GET["nazev"];
			$level = $_GET["level"];
		elseif ($tbl == "strana"):
			$nazev = $_GET["nazev"];
			$zkratka = $_GET["zkratka"];
		elseif ($tbl == "autor"):
			$nick = $_GET["nick"];
			$jmeno = $_GET["jmeno"];
			$prijmeni = $_GET["prijmeni"];
			$email = $_GET["email"];
		elseif ($tbl == "redaktor"):
			$user = $_GET["username"];
			$pwd = $_GET["pwduser"];
			$jmeno = $_GET["jmeno"];
			$prijmeni = $_GET["prijmeni"];
			$email = $_GET["email"];
			$admin = ($_GET["admin"] ? 1 : 0);
			$schval = ($_GET["schval"] ? 1 : 0);
			$web = ($_GET["web"] ? 1 : 0);
			$anketa = ($_GET["anketa"] ? 1 : 0);
			$soutez = ($_GET["soutez"] ? 1 : 0);
			$pocasi = ($_GET["pocasi"] ? 1 : 0);
			$ciselniky = ($_GET["ciselniky"] ? 1 : 0);
			$kalendar = ($_GET["kalendar"] ? 1 : 0);
			$diskuse = ($_GET["diskuse"] ? 1 : 0);
			$uzivatele = ($_GET["uzivatele"] ? 1 : 0);
			$import = ($_GET["import"] ? 1 : 0);
			$udeska = ($_GET["udeska"] ? 1 : 0);
		elseif ($tbl == "uzivatel"):
			$user = $_GET["username"];
			$pwd = $_GET["pwduser"];
			$jmeno = $_GET["jmeno"];
			$prijmeni = $_GET["prijmeni"];
			$titul = $_GET["titul"];
			$ulice = $_GET["ulice"];
			$mesto = $_GET["mesto"];
			$psc = $_GET["psc"];
			$email = $_GET["email"];
			$fullreg = ($_GET["fullreg"] ? 1 : 0);
			$letter = ($_GET["letter"] ? 1 : 0);
			$povol = ($_GET["povol"] ? 1 : 0);
			$employee = ($_GET["employee"] ? 1 : 0);
		elseif ($tbl == "osoba"):
			$jmeno = $_POST["jmeno"];
			$prijmeni = $_POST["prijmeni"];
			$prijmorder = ConvText($prijmeni);
			$titulpred = $_POST["titulpred"];
			$titulza = $_POST["titulza"];
			$img = $_POST["img"];
			$imgtmp = $_FILES["imgtmp"];
			if ($imgtmp["tmp_name"] && $imgtmp["tmp_name"] != "none"):
				$obr = CreateFile2Handle($imgtmp,"temp");
				$img = CreateFotoImg($obr,"80","others",0);
				if (!$img):
					die("nepodařilo se vytvořit foto");
				endif;
			endif;
			$zaron = $_POST["zaron"];
			$idbudova = ($zaron ? ($_POST["idbudova"] ? $_POST["idbudova"] : 0) : 0);
			$idodbor = ($zaron ? ($_POST["idodbor"] ? $_POST["idodbor"] : 0) : 0);
			$idoddeleni = ($zaron ? ($_POST["idoddeleni"] ? $_POST["idoddeleni"] : 0) : 0);
			$idzarazeni = ($zaron ? ($_POST["idzarazeni"] ? $_POST["idzarazeni"] : 0) : 0);
			$dvere = $_POST["dvere"];
			$politon = $_POST["politon"];
			$idstrana = ($politon ? $_POST["idstrana"] : 0);
			$zaston = $_POST["zaston"];
			$idzarzast = ($zaston ? $_POST["idzarzast"] : 0);
			$radaon = $_POST["radaon"];
			$idzarrada = ($radaon ? $_POST["idzarrada"] : 0);
			$vyboron = $_POST["vyboron"];
			$idvybor = ($vyboron ? $_POST["idvybor"] : 0);
			$idzarvybor = ($vyboron ? $_POST["idzarvybor"] : 0);
			$komiseon = $_POST["komiseon"];
			$idkomise = ($komiseon ? $_POST["idkomise"] : 0);
			$idzarkomise = ($komiseon ? $_POST["idzarkomise"] : 0);
			$telefon1 = $_POST["telefon1"];
			$telefon2 = $_POST["telefon2"];
			$mobil1 = $_POST["mobil1"];
			$mobil2 = $_POST["mobil2"];
			$fax = $_POST["fax"];
			$icq = $_POST["icq"];
			$email1 = $_POST["email1"];
			$email2 = $_POST["email2"];
		elseif ($tbl == "mista"):
			$idlevel1 = $_GET["idlevel1"];
			if ($akce == "add"):
				if ($placelevel == 1):
					$level1 = GetMaxIdLevel($placelevel,1);
					$level2 = 0;
					$level3 = 0;
					$level4 = 0;
					$level5 = 0;
					$level6 = 0;
				endif;
				if ($idlevel1):
					$polelev = TblHandler($idlevel1,"mista");
					$level1 = $polelev["level1"];
					$level2 = GetMaxIdLevel($placelevel,$idlevel1);
					$level3 = $polelev["level3"];
					$level4 = $polelev["level4"];
					$level5 = $polelev["level5"];
					$level6 = $polelev["level6"];
				endif;
				$idlevel2 = $_GET["idlevel2"];
				if ($idlevel2):
					$polelev = TblHandler($idlevel2,"mista");
					$level1 = $polelev["level1"];
					$level2 = $polelev["level2"];
					$level3 = GetMaxIdLevel($placelevel,$idlevel2);
					$level4 = $polelev["level4"];
					$level5 = $polelev["level5"];
					$level6 = $polelev["level6"];
				endif;
				$idlevel3 = $_GET["idlevel3"];
				if ($idlevel3):
					$polelev = TblHandler($idlevel3,"mista");
					$level1 = $polelev["level1"];
					$level2 = $polelev["level2"];
					$level3 = $polelev["level3"];
					$level4 = GetMaxIdLevel($placelevel,$idlevel3);
					$level5 = $polelev["level5"];
					$level6 = $polelev["level6"];
				endif;
				$idlevel4 = $_GET["idlevel4"];
				if ($idlevel4):
					$polelev = TblHandler($idlevel4,"mista");
					$level1 = $polelev["level1"];
					$level2 = $polelev["level2"];
					$level3 = $polelev["level3"];
					$level4 = $polelev["level4"];
					$level5 = GetMaxIdLevel($placelevel,$idlevel4);
					$level6 = $polelev["level6"];
				endif;
				$idlevel5 = $_GET["idlevel5"];
				if ($idlevel5):
					$polelev = TblHandler($idlevel5,"mista");
					$level1 = $polelev["level1"];
					$level2 = $polelev["level2"];
					$level3 = $polelev["level3"];
					$level4 = $polelev["level4"];
					$level5 = $polelev["level5"];
					$level6 = GetMaxIdLevel($placelevel,$idlevel5);
				endif;
			endif;
			$name = $_GET["name"];
		elseif ($tbl == "podnik"):
			$misto_id = $_GET["misto_id"];
			$podnik = $_GET["podnik"];
			$ulice = $_GET["ulice"];
			$recmisto = TblHandler($misto_id, "mista");
			$mesto = $recmisto["name"];
		elseif ($tbl == "poradatel"):
			$jmeno = $_GET["jmeno"];
			$telefon = $_GET["telefon"];
			$email = $_GET["email"];
		elseif ($tbl == "typakce"):
			$popis = $_GET["popis"];
		elseif ($tbl == "tema"):
			$nazev = $_POST["nazev"];
			$public = 1;
			$uvod = $_POST["uvod"];
			$idgarant = $_POST["idgarant"];
		elseif ($tbl == "zapis"):
			$idtema = $_POST["idtema"];
			$titulek = $_POST["titulek"];
			$recred = TblHandler($idredaktor,"redaktor");
			$jmeno = $recred["prijmeni"]." ".$recred["jmeno"];
			$email = $recred["email"];
			$text = $_POST["text"];
		elseif ($tbl == "firmy"):
			$nazev = $_GET["nazev"];
			$cznazev = ConvText($nazev);
			$dodatek = $_GET["dodatek"];
			$ulice = $_GET["ulice"];
			$mesto = $_GET["mesto"];
			$psc = $_GET["psc"];
			$telefony = $_GET["telefony"];
			$mobily = $_GET["mobily"];
			$faxy = $_GET["faxy"];
			$emaily = $_GET["emaily"];
			$web = $_GET["web"];
		elseif ($tbl == "cinnosti"):
			$nazev = $_GET["nazev"];
			$cznazev = ConvText($nazev);
		elseif ($tbl == "firmy_cinnosti"):
			$idfirmy = $_GET["idfirmy"];
			$idcinnosti = $_GET["idcinnosti"];
		else:
			$nazev = $_GET["nazev"];
		endif;
	else:
		$mtid = $_POST["mtid"];
		if ($tbltyp == "txt"):
			$id = $_POST["itemid"];
			$cssstyl = $_POST["cssstyl"];
			$img = $_POST["img"];
			$maximg = $_POST["maximg"];
			$imgtmp = $_FILES["imgtmp"];
			if ($imgtmp["tmp_name"] && $imgtmp["tmp_name"] != "none"):
				$obr = CreateFile2Handle($imgtmp,"temp");
				$img = CreateFotoImg($obr,$maximg,"others",0);
				if (!$img):
					die("nepodařilo se vytvořit snímek pro textovou článku");
				endif;
				$titleimg = ($img ? $_POST["titleimg"] : "");
				$cssimg = ($img ? $_POST["cssimg"] : "");
			endif;
			$titleimg = ($img ? $_POST["titleimg"] : "");
			$cssimg = ($img ? $_POST["cssimg"] : "");
			$txt = $_POST["txt"];
		elseif ($tbltyp == "img"):
			$id = $_POST["itemid"];
			$den = $_POST["den"];
			$mes = $_POST["mes"];
			$rok = $_POST["rok"];
			if ($den || $mes || $rok):
				$datum = (CheckDate($mes, $den, $rok) ? $rok."-".$mes."-".$den : "0000-00-00");
			else:
				$datum = "0000-00-00";
			endif;
			$nazev = $_POST["nazev"];
			$nahled = $_POST["nahled"];
			$snimek = $_POST["snimek"];
			$snimektmp = $_FILES["snimektmp"];
			if ($snimektmp["tmp_name"] && $snimektmp["tmp_name"] != "none"):
				$obr = CreateFile2Handle($snimektmp,"temp");
				$nahled = CreateFotoImg($obr,"150","gallery",0);
				if (!$nahled):
					die("nepodařilo se vytvořit náhled");
				endif;
				$snimek = CreateFotoImg($obr,"500","gallery",0);
				if (!$snimek):
					die("nepodařilo se vytvořit snímek");
				endif;
			endif;
			$popis = $_POST["popis"];
			$idautor = $_POST["idautor"];
		elseif ($tbltyp == "lst"):
			$id = $_POST["itemid"];
			$styl = $_POST["styl"];
			$itemstyl = $_POST["itemstyl"];
			$cssstyl = $_POST["cssstyl"];
			$txt = $_POST["txt"];
			if ($styl == "ul"):
				$itemstyl = (($itemstyl == "lstdec") || ($itemstyl == "lstrom") || ($itemstyl == "lstlalfa") || ($itemstyl == "lstualfa") ? "" : $itemstyl);
			else:
				$itemstyl = (($itemstyl == "lstdisc") || ($itemstyl == "lstsquare") || ($itemstyl == "lstcircle") ? "" : $itemstyl);
			endif;
		elseif ($tbltyp == "lnk"):
			$id = $_POST["itemid"];
			$styl = $_POST["styl"];
			$typlnk = $_POST["typlnk"];
			$cssstyl = $_POST["cssstyl"];
			$addrlnk = $_POST["addrlnk"];
			$filetmp = $_FILES["filetmp"];
			if ($filetmp["tmp_name"] && $filetmp["tmp_name"] != "none"):
				$addrlnk = CreateFile2Handle($filetmp,"download");
				if (!$addrlnk):
					die("nepodařilo se uložit soubor ke stažení - changetbl");
				endif;
				$addrpath = substr($script, 0, strrpos($script, "/"));
				$addrpath = ereg_replace("/edit","/",$addrpath);
				$addrlnk = "http://".$server.$addrpath.$addrlnk;
			endif;
			$txt = $_POST["txt"];
		elseif ($tbltyp == "scr"):
			$id = $_POST["itemid"];
			$nazev = $_POST["nazev"];
			$umisteni = $_POST["umisteni"];
		elseif ($tbltyp == "cst"):
			$id = $_POST["itemid"];
			$otazka = $_POST["otazka"];
			$odp1 = $_POST["odp1"];
			$odp2 = $_POST["odp2"];
			$odp3 = $_POST["odp3"];
			$odp4 = $_POST["odp4"];
			$odp5 = $_POST["odp5"];
			$img = $_POST["img"];
			$imgtmp = $_FILES["imgtmp"];
			if ($imgtmp["tmp_name"] && $imgtmp["tmp_name"] != "none"):
				$obr = CreateFile2Handle($imgtmp,"temp");
				$img = CreateFotoImg($obr,"500","contest",0);
				if (!$img):
					die("nepodařilo se vytvořit snímek pro soutěž");
				endif;
			endif;
			$spravne = $_POST["spravne"];
		endif;
	endif;
else:
	$id = $_GET["itemid"];
	if (($tbl != "anketa") && ($tbl != "pocasi")):
		$menuid = $_GET["menuid"];
		$idtop = $menuid;
		$mtid = $_GET["mtid"];
		$actualrec = TblHandler($id,$tbl);
		if (($akce == "up") || ($akce == "down")):
			$pozice = $actualrec["pozice"];
			$newpozice = ($akce == "up" ? $pozice - 1 : $pozice + 1);
		endif;
	endif;
endif;

// zapis
if ($tbl == "menu"):
	if (!$menuid):
		$idtop = 0;
		$level = 0;
	endif;
endif;
if ($akce == "add"):
	if ($tbl == "menu"):
		if (!$menuid):
			$menuid = 0;
		endif;
		$dotaz = "INSERT INTO $tbl (titulek,level,filename,obsah,idtop,pozice) VALUES ('$titulek',$level,'$filename','$obsah',$menuid,$pozice)";
	elseif ($tbl == "mastertxt"):
		$dotaz = "INSERT INTO $tbl (caszapisu,datum1,datum2,perexhp,perexmid,idautor,idredaktor,titulek,thumbimg,titlethumbimg,cssthumbimg,maininfo,aktualinfo,typinfoid,perex) VALUES (NOW(),'$datum1','$datum2',$perexhp,$perexmid,$idautor,$idredaktor,'$titulek','$thumbimg','$titlethumbimg','$cssthumbimg',$maininfo,$aktualinfo,$typinfoid,'$perex')";
	elseif ($tbl == "anketa"):
		$dotaz = "INSERT INTO $tbl (otazka,odp1,odp2,odp3,odp4,odp5,odp6,odp7,odp8,odp9,odp10,idredaktor) VALUES ('$otazka','$odp1','$odp2','$odp3','$odp4','$odp5','$odp6','$odp7','$odp8','$odp9','$odp10',$idredaktor)";
	elseif ($tbl == "pocasi"):
		$dotaz = "INSERT INTO $tbl (datum,kodpoc,rano,odpoledne,idredaktor) VALUES ('$datum','$kodpoc','$rano','$odpoledne',$idredaktor)";
	elseif ($ttbl == "cis"):
		$dotaz = "INSERT INTO $tbl (".($tbl != "osoba" ? "id" : "").(($tbl != "redaktor") && ($tbl != "uzivatel") && ($tbl != "zapis") ? ($tbl != "osoba" ? ",idredaktor" : "idredaktor") : "");
		if ($tbl == "budova"):
			$dotaz .= ",nazev,ulice";
		elseif ($tbl == "zarazeni" || $tbl == "zarkomise" || $tbl == "zarvybor" || $tbl == "zarrada" || $tbl == "zarzast"):
			$dotaz .= ",nazev,level";
		elseif ($tbl == "strana"):
			$dotaz .= ",nazev,zkratka";
		elseif ($tbl == "autor"):
			$dotaz .= ",nick,jmeno,prijmeni,email";
		elseif ($tbl == "redaktor"):
			$dotaz .= ",user,pwd,jmeno,prijmeni,email,admin,web,schval,anketa,soutez,pocasi,ciselniky,uzivatele,import,kalendar,diskuse,udeska";
		elseif ($tbl == "uzivatel"):
			$dotaz .= ",user,pwd,jmeno,prijmeni,titul,ulice,mesto,psc,email,fullreg,letter,povol,employee";
		elseif ($tbl == "osoba"):
			$dotaz .= ",jmeno,prijmeni,prijmorder,titulpred,titulza,img,idbudova,idodbor,idoddeleni,idzarazeni,dvere,idstrana,idzarzast,idzarrada,idvybor,idzarvybor,idkomise,idzarkomise,telefon1,telefon2,mobil1,mobil2,fax,icq,email1,email2";
		elseif ($tbl == "mista"):
			$dotaz .= ",level1,level2,level3,level4,level5,level6,name";
		elseif ($tbl == "podnik"):
			$dotaz .= ",podnik,ulice,mesto,misto_id";
		elseif ($tbl == "poradatel"):
			$dotaz .= ",jmeno,telefon,email";
		elseif ($tbl == "typakce"):
			$dotaz .= ",popis";
		elseif ($tbl == "tema"):
			$dotaz .= ",nazev,public,uvod,idgarant";
		elseif ($tbl == "zapis"):
			$dotaz .= ",idtema,titulek,jmeno,email,text";
		elseif ($tbl == "firmy"):
			$dotaz .= ",nazev,cznazev,dodatek,ulice,mesto,psc,telefony,mobily,faxy,emaily,web";
		elseif ($tbl == "cinnosti"):
			$dotaz .= ",nazev,cznazev";
		elseif ($tbl == "firmy_cinnosti"):
			$dotaz .= ",idfirmy,idcinnosti";
		else:
			$dotaz .= ",nazev";
		endif;
		$dotaz .= ") VALUES (".($tbl != "osoba" ? "$id" : "").(($tbl != "redaktor") && ($tbl != "uzivatel") && ($tbl != "zapis") ? ($tbl != "osoba" ? ",$idredaktor" : "$idredaktor") : "");
		if ($tbl == "budova"):
			$dotaz .= ",'$nazev','$ulice'";
		elseif ($tbl == "zarazeni" || $tbl == "zarkomise" || $tbl == "zarvybor" || $tbl == "zarrada" || $tbl == "zarzast"):
			$dotaz .= ",'$nazev',$level";
		elseif ($tbl == "strana"):
			$dotaz .= ",'$nazev','$zkratka'";
		elseif ($tbl == "autor"):
			$dotaz .= ",'$nick','$jmeno','$prijmeni','$email'";
		elseif ($tbl == "redaktor"):
			$dotaz .= ",'$user','$pwd','$jmeno','$prijmeni','$email',$admin,$web,$schval,$anketa,$soutez,$pocasi,$ciselniky,$uzivatele,$import,$kalendar,$diskuse,$udeska";
		elseif ($tbl == "uzivatel"):
			$dotaz .= ",'$user','$pwd','$jmeno','$prijmeni','$titul','$ulice','$mesto','$psc','$email',$fullreg,$letter,$povol,$employee";
		elseif ($tbl == "osoba"):
			$dotaz .= ",'$jmeno','$prijmeni','$prijmorder','$titulpred','$titulza','$img',$idbudova,$idodbor,$idoddeleni,$idzarazeni,'$dvere',$idstrana,$idzarzast,$idzarrada,$idvybor,$idzarvybor,$idkomise,$idzarkomise,'$telefon1','$telefon2','$mobil1','$mobil2','$fax','$icq','$email1','$email2'";
		elseif ($tbl == "mista"):
			$dotaz .= ",$level1,$level2,$level3,$level4,$level5,$level6,'$name'";
		elseif ($tbl == "podnik"):
			$dotaz .= ",'$podnik','$ulice','$mesto',$misto_id";
		elseif ($tbl == "poradatel"):
			$dotaz .= ",'$jmeno','$telefon','$email'";
		elseif ($tbl == "typakce"):
			$dotaz .= ",'$popis'";
		elseif ($tbl == "tema"):
			$dotaz .= ",'$nazev',$public,'$uvod',$idgarant";
		elseif ($tbl == "zapis"):
			$dotaz .= ",$idtema,'$titulek','$jmeno','$email','$text'";
		elseif ($tbl == "firmy"):
			$dotaz .= ",'$nazev','$cznazev','$dodatek','$ulice','$mesto','$psc','$telefony','$mobily','$faxy','$emaily','$web'";
		elseif ($tbl == "cinnosti"):
			$dotaz .= ",'$nazev','$cznazev'";
		elseif ($tbl == "firmy_cinnosti"):
			$dotaz .= ",$idfirmy,$idcinnosti";
		else:
			$dotaz .= ",'$nazev'";
		endif;
		$dotaz .= ")";
	else:
		if ($tbltyp == "txt"):
			$dotaz = "INSERT INTO $tbl (cssstyl,img,titleimg,cssimg,txt,uprava) VALUES ('$cssstyl','$img','$titleimg','$cssimg','$txt',1)";
		elseif ($tbltyp == "img"):
			$dotaz = "INSERT INTO $tbl (datum,nazev,popis,nahled,snimek,idautor,uprava) VALUES ('$datum','$nazev','$popis','$nahled','$snimek',$idautor,1)";
		elseif ($tbltyp == "lst"):
			$dotaz = "INSERT INTO $tbl (styl,itemstyl,cssstyl,txt,uprava) VALUES ('$styl','$itemstyl','$cssstyl','$txt',1)";
		elseif ($tbltyp == "tbl"):
			echo "Tady furt jsou ještě lvi - changetbl.php insert a typtbl = tbl!";
		elseif ($tbltyp == "lnk"):
			$dotaz = "INSERT INTO $tbl (styl,typlnk,cssstyl,addrlnk,txt,uprava) VALUES ('$styl','$typlnk','$cssstyl','$addrlnk','$txt',1)";
		elseif ($tbltyp == "scr"):
			$dotaz = "INSERT INTO $tbl (nazev,umisteni,uprava) VALUES ('$nazev','$umisteni',1)";
		elseif ($tbltyp == "cst"):
			$dotaz = "INSERT INTO $tbl (otazka,odp1,odp2,odp3,odp4,odp5,img,spravne,uprava) VALUES ('$otazka','$odp1','$odp2','$odp3','$odp4','$odp5','$img',$spravne,1)";
		endif;
	endif;
elseif ($akce == "edit"):
	if ($tbl == "menu"):
		$dotaz = "UPDATE $tbl SET titulek = '$titulek', level = $level, filename = '$filename', obsah = '$obsah', idtop = $idtop, pozice = $pozice WHERE id = $id";
	elseif ($tbl == "mastertxt"):
		$dotaz = "UPDATE $tbl SET caszapisu = NOW(), datum1 = '$datum1', datum2 = '$datum2', perexhp = $perexhp, perexmid = $perexmid, idautor = $idautor, idredaktor = $idredaktor, titulek = '$titulek', thumbimg = '$thumbimg', titlethumbimg = '$titlethumbimg', cssthumbimg = '$cssthumbimg', maininfo = $maininfo, aktualinfo = $aktualinfo, typinfoid = $typinfoid, perex = '$perex' WHERE id = $id";
	elseif ($tbl == "anketa"):
		$dotaz = "UPDATE $tbl SET otazka = '$otazka', odp1 = '$odp1', odp2 = '$odp2', odp3 = '$odp3', odp4 = '$odp4', odp5 = '$odp5', odp6 = '$odp6', odp7 = '$odp7', odp8 = '$odp8', odp9 = '$odp9', odp10 = '$odp10', idredaktor = $idredaktor WHERE id = $id";
	elseif ($tbl == "pocasi"):
		$dotaz = "UPDATE $tbl SET datum = '$datum', kodpoc = '$kodpoc', rano = '$rano', odpoledne = '$odpoledne', idredaktor = $idredaktor WHERE id = $id";
	elseif ($ttbl == "cis"):
		$dotaz = "UPDATE $tbl SET ".(($tbl != "redaktor") && ($tbl != "zapis") && ($tbl != "uzivatel") ? "idredaktor = $idredaktor" : "");
		if ($tbl == "budova"):
			$dotaz .= ", nazev = '$nazev', ulice = '$ulice'";
		elseif ($tbl == "zarazeni" || $tbl == "zarkomise" || $tbl == "zarvybor" || $tbl == "zarrada" || $tbl == "zarzast"):
			$dotaz .= ", nazev = '$nazev', level = $level";
		elseif ($tbl == "strana"):
			$dotaz .= ", nazev = '$nazev', zkratka = '$zkratka'";
		elseif ($tbl == "autor"):
			$dotaz .= ", nick = '$nick', jmeno = '$jmeno', prijmeni = '$prijmeni', email = '$email'";
		elseif ($tbl == "redaktor"):
			$dotaz .= "user = '$user', pwd = '$pwd', jmeno = '$jmeno', prijmeni = '$prijmeni', email = '$email', admin = $admin,
				web = $web, schval = $schval, anketa = $anketa, soutez = $soutez, pocasi = $pocasi, ciselniky = $ciselniky, 
				uzivatele = $uzivatele, import = $import, kalendar = $kalendar, diskuse = $diskuse, udeska = $udeska";
		elseif ($tbl == "uzivatel"):
			$dotaz .= "user = '$user', pwd = '$pwd', jmeno = '$jmeno', prijmeni = '$prijmeni', titul = '$titul', ulice = '$ulice',
				mesto = '$mesto', psc = '$psc', email = '$email', fullreg = $fullreg, letter = $letter, povol = $povol, employee = $employee";
		elseif ($tbl == "osoba"):
			$dotaz .= ", jmeno = '$jmeno', prijmeni = '$prijmeni', prijmorder = '$prijmorder', titulpred = '$titulpred', titulza = '$titulza',
				img = '$img', idbudova = $idbudova, idodbor = $idodbor, idoddeleni = $idoddeleni, idzarazeni = $idzarazeni,
				dvere = '$dvere', idstrana = $idstrana, idzarzast = $idzarzast, idzarrada = $idzarrada, idvybor = $idvybor,
				idzarvybor = $idzarvybor, idkomise = $idkomise, idzarkomise = $idzarkomise, telefon1 = '$telefon1',
				telefon2 = '$telefon2', mobil1 = '$mobil1', mobil2 = '$mobil2', fax = '$fax', icq = '$icq',
				email1 = '$email1', email2 = '$email2'";
		elseif ($tbl == "mista"):
			$dotaz .= ", name = '$name'";
		elseif ($tbl == "podnik"):
			$dotaz .= ", podnik = '$podnik', ulice ='$ulice', mesto = '$mesto', misto_id = $misto_id";
		elseif ($tbl == "poradatel"):
			$dotaz .= ", jmeno = '$jmeno', telefon ='$telefon', email = '$email'";
		elseif ($tbl == "typakce"):
			$dotaz .= ", popis = '$popis'";
		elseif ($tbl == "tema"):
			$dotaz .= ", nazev = '$nazev', public = $public, uvod ='$uvod', idgarant = $idgarant";
		elseif ($tbl == "zapis"):
			$dotaz .= " titulek = '$titulek', caszapisu = caszapisu, text ='$text'";
		elseif ($tbl == "firmy"):
			$dotaz .= ", nazev = '$nazev', cznazev = '$cznazev', dodatek = '$dodatek', ulice ='$ulice', mesto = '$mesto', psc = '$psc', telefony = '$telefony', mobily = '$mobily', faxy = '$faxy', emaily = '$emaily', web = '$web'";
		elseif ($tbl == "cinnosti"):
			$dotaz .= ", nazev = '$nazev', cznazev = '$cznazev'";
		elseif ($tbl == "firmy_cinnosti"):
			$dotaz .= ", idcinnosti = $idcinnosti";
		else:
			$dotaz .= ", nazev = '$nazev'";
		endif;
		$dotaz .= " WHERE id = $id";
	else:
		if ($tbltyp == "txt"):
			$dotaz = "UPDATE $tbl SET cssstyl = '$cssstyl', img = '$img', titleimg = '$titleimg', cssimg = '$cssimg', txt = '$txt' WHERE id=$id";
		elseif ($tbltyp == "img"):
			$dotaz = "UPDATE $tbl SET datum = '$datum', nazev = '$nazev', popis = '$popis', nahled = '$nahled', snimek = '$snimek', idautor = $idautor WHERE id=$id";
		elseif ($tbltyp == "lst"):
			$dotaz = "UPDATE $tbl SET styl = '$styl', itemstyl = '$itemstyl', cssstyl = '$cssstyl', txt = '$txt' WHERE id=$id";
		elseif ($tbltyp == "tbl"):
			echo "Tady furt jsou ještě lvi - changetbl.php insert a typtbl = tbl!";
		elseif ($tbltyp == "lnk"):
			$dotaz = "UPDATE $tbl SET styl = '$styl', typlnk = '$typlnk', cssstyl = '$cssstyl', addrlnk = '$addrlnk', txt = '$txt' WHERE id=$id";
		elseif ($tbltyp == "scr"):
			$dotaz = "UPDATE $tbl SET nazev = '$nazev', umisteni = '$umisteni' WHERE id=$id";
		elseif ($tbltyp == "cst"):
			$dotaz = "UPDATE $tbl SET otazka = '$otazka', odp1 = '$odp1', odp2 = '$odp2', odp3 = '$odp3', odp4 = '$odp4', odp5 = '$odp5', img = '$img', spravne = $spravne WHERE id=$id";
		endif;
	endif;	
elseif ($akce == "del"):
	$dotaz = "DELETE FROM $tbl WHERE id=$id";
else:
	if ($tbl == "menu"):
		$dotaz = "SELECT * FROM $tbl WHERE idtop=$idtop";
	elseif ($tbl == "articlejoin"):
		$dotaz = "SELECT * FROM $tbl WHERE menuid=$menuid";
	else:
		$dotaz = "SELECT * FROM $tbl WHERE mtid=$mtid";
	endif;
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Chyba při výběru dat - changetable - úprava pozice - $dotaz!");
	else:
		$maxpozice = mysql_num_rows($result);
		if (($newpozice != 0) && ($newpozice <= $maxpozice)):
			$dotaz = "UPDATE $tbl SET pozice = $newpozice, uprava = 1 WHERE id=$id";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Změna úpravy neprošla - changetbl!");
			else:
				$chgpozice = ($akce == "up" ? $newpozice+1 : $newpozice-1);
				if ($tbl == "menu"):
					$dotaz = "UPDATE $tbl SET pozice = $chgpozice WHERE idtop=$idtop AND uprava!=1 AND pozice=$newpozice";
				elseif ($tbl == "articlejoin"):
					$dotaz = "UPDATE $tbl SET pozice = $chgpozice WHERE menuid=$menuid AND uprava!=1 AND pozice=$newpozice";
				else:
					$dotaz = "UPDATE $tbl SET pozice = $chgpozice WHERE mtid=$mtid AND uprava!=1 AND pozice=$newpozice";
				endif;
				$result = mysql_query("$dotaz");
				if (!$result):
					die("Změna pozice se nezdařila - changetbl!");
				else:
					$dotaz = "UPDATE $tbl SET uprava = 0 WHERE uprava=1";
					$result = mysql_query("$dotaz");
					if (!$result):
						die("Změna v sloupci úprava se nezdařila - changetbl!");
					endif;
				endif;
			endif;
		endif;
	endif;
endif;

$result = mysql_query("$dotaz");
if (!$result):
	if ($akce == "add"):
		die("nepodařilo se vložit záznam - changetbl.php - $dotaz");
	elseif ($akce == "edit"):
		die("nepodařilo se změnit záznam - changetbl.php - $dotaz");
	else:
		die("nepodařilo se smazat záznam - changetbl.php - $dotaz");
	endif;
else: 
	if ($akce == "add"):
		if (($tbl != "menu") && ($tbl != "mastertxt") && ($tbl != "anketa") && ($tbl != "pocasi") && ($ttbl != "cis")):
			$mtid = $_POST["mtid"];
			$pozice = GetNewPozice("content",$mtid);
			$idtbl = GetTblId($tbl);
			$contid = GetUprId($tbl);
			$dotaz = "INSERT INTO content (idtbl,mtid,contid,pozice) VALUES ($idtbl,$mtid,$contid,$pozice)";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Přidání obsahu do tabulky content přece jen úplně nedopadlo - changetbl!");
			endif;
		elseif ($tbl == "mastertxt"): 
			$mtid = mysql_insert_id();
		endif;	
	elseif (($akce == "del") && ($tbl != "anketa") && ($tbl != "pocasi") && ($ttbl != "cis")):
		if ($tbl == "menu"):
			$pozice = $actualrec["pozice"];
			$filename = $actualrec["filename"];
			$idtop = $actualrec["idtop"];
			$dotaz = "SELECT * FROM menu WHERE pozice>$pozice AND idtop=$idtop";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Chyba při výběru dat - changetbl - úprava tabulky menu po mazání!");
			else:
				while ($record = mysql_fetch_array($result)):
					$id = $record["id"];
					$chgpozice = $record["pozice"]-1;
					$dotaz = "UPDATE menu SET pozice = $chgpozice WHERE id=$id";
					$result2 = mysql_query("$dotaz");
					if (!$result2):
						die("Změna pozice se nezdařila - changetbl akce del!");
					endif;
				endwhile;
			endif;
		elseif ($tbl == "articlejoin"):
			$pozice = $actualrec["pozice"];
			$menuid = $actualrec["menuid"];
			$dotaz = "SELECT * FROM articlejoin WHERE pozice>$pozice AND menuid=$menuid";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Chyba při výběru dat - changetbl - úprava tabulky articlejoin po mazání - $dotaz!");
			else:
				while ($record = mysql_fetch_array($result)):
					$id = $record["id"];
					$chgpozice = $record["pozice"]-1;
					$dotaz = "UPDATE articlejoin SET pozice = $chgpozice WHERE id=$id";
					$result2 = mysql_query("$dotaz");
					if (!$result2):
						die("Změna pozice se nezdařila - changetbl akce del - $dotaz!");
					endif;
				endwhile;
			endif;
		elseif ($tbl == "mastertxt"):
			DeleteJoin($id);
			DeleteContent($id);
		else:
			// zjištění pozice v tabulce content
			$idtbl = GetTblId($tbl);
			$dotaz = "SELECT * FROM content WHERE idtbl=$idtbl AND contid=$id";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Chyba při výběru záznamu ke smazání z tabulky content - changetbl!");
			else:
				$record = mysql_fetch_array($result);
				$pozice = $record["pozice"];
			endif;
			// výběr záznamů pro úpravu
			$dotaz = "SELECT * FROM content WHERE pozice>$pozice AND mtid=$mtid";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Chyba při výběru dat - changetbl - úprava tabulky content po mazání!");
			else:
				while ($record = mysql_fetch_array($result)):
					$ctid = $record["id"];
					$chgpozice = $record["pozice"]-1;
					$dotaz = "UPDATE content SET pozice = $chgpozice WHERE id=$ctid";
					$result2 = mysql_query("$dotaz");
					if (!$result2):
						die("Změna pozice se nezdařila - changetbl!");
					endif;
				endwhile;
			endif;
			// smazání záznamu z tabulky content
			$dotaz = "DELETE FROM content WHERE idtbl=$idtbl AND contid=$id";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Chyba při mazání záznamu v tabulce content - changetbl!");
			endif;
		endif;
	endif;
endif;

if ($tbl == "anketa"):
	$path = substr($script, 0, strrpos($script, "/"))."/votemng.php";
elseif ($tbl == "pocasi"):
	$path = substr($script, 0, strrpos($script, "/"))."/weathermng.php";
elseif ($ttbl == "cis"):
	$path = substr($script, 0, strrpos($script, "/"))."/".$fn.($placelevel ? "?placelevel=$placelevel" : "").($idtema ? "?idtema=$idtema" : "").($idfirmy ? "?idfirmy=$idfirmy" : "");
elseif ($tbl == "articlejoin" || $tbl == "menu"):
	$path = substr($script, 0, strrpos($script, "/"))."/webmng.php?menuid=$menuid";
elseif ($tbl == "mastertxt" && $akce == "del"):	
	$path = substr($script, 0, strrpos($script, "/"))."/articlemng.php?menuid=$menuid";
else:
	$path = substr($script, 0, StrRPos($script, "/"))."/contentmng.php?itemid=$mtid&menuid=$menuid";
endif;

Header("Location: http://".$server.":".$port.$path);
?>
