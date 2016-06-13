<?php
$pref = "../";
require "usrfce.php";

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$fp = $_POST["fp"];
$form = $_POST["form"];
$artid = $_POST["artid"];
$kontrola = $_POST["kontrola"];
$kontrolkod = $_POST["kontrolkod"];
$path = substr($script, 0, strrpos($script, "/"))."/".$pref;
$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref.(strstr($fp,".php") ? $fp : "page.php?fp=$fp");
$errnr = 0;

if ($form == "i106"):
	$zadatel = $_POST["zadatel"];
	$vyrizuje = $_POST["vyrizuje"];
	$ulice = $_POST["ulice"];
	$mesto = $_POST["mesto"];
	$psc = $_POST["psc"];
	$telefon = $_POST["telefon"];
	$fax = $_POST["fax"];
	$email = $_POST["email"];
	$text = $_POST["text"];
	$doruceni = $_POST["doruceni"];
	if (!$zadatel):
		$errnr = 2;
	elseif (!$email):
		$errnr = 3;
	elseif (!strpos($email,"@")):
		$errnr = 1;
	elseif (!$text):
		$errnr = 4;
	elseif (!$ulice):
		$errnr = 5;
	elseif (!$mesto):
		$errnr = 6;
	elseif (!$psc):
		$errnr = 7;
	elseif ($kontrola != $kontrolkod):
	  $errnr = 99;
	else:
		// bez chyb
		$zadatel = BezSkriptu($zadatel);
		$vyrizuje = BezSkriptu($vyrizuje);
		$ulice = BezSkriptu($ulice);
		$mesto = BezSkriptu($mesto);
		$psc = BezSkriptu($psc);
		$telefon = BezSkriptu($telefon);
		$fax = BezSkriptu($fax);
		$email = BezSkriptu($email);
		$text = BezSkriptu($text);
		// poslani zpravy
		$radek_1="Název žadatele: ".$zadatel;
		$radek_2="Adresa: ".$ulice.", ".$mesto.", ".$psc;
		$radek_3="E-mail: ".$email.($telefon ? ", telefon: ".$telefon : "").($fax ? ", fax: ".$fax : "");
		$radek_4="Text žádosti: ".nl2br($text);
		$radek_5="Způsob doručení odpovědi: ".$doruceni;
		
		@$posta=mail("radnice@mestotynec.cz", "zadost o informace", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
	endif;
	if ($errnr):
		$path2 = "&artid=$artid&errnr=$errnr&zadatel=$zadatel&vyrizuje=$vyrizuje&ulice=$ulice&mesto=$mesto&psc=$psc&telefon=$telefon&fax=$fax&email=$email&text=$text&doruceni=$doruceni";
	else:
		$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
		$path2 = "?form=i106&fp=$fp&posta=$posta";
	endif;
elseif ($form == "sdel"):
	$pisatel = $_POST["pisatel"];
	$email = $_POST["email"];
	$text = $_POST["text"];
	if (!$pisatel):
		$errnr = 8;
	elseif (!$email):
		$errnr = 3;
	elseif (!strpos($email,"@") AND !strpos($email,"@")):
		$errnr = 1;
	elseif (!$text):
		$errnr = 4;
	elseif ($kontrola != $kontrolkod):
	  $errnr = 99;
	else:
		// bez chyb
		$pisatel = BezSkriptu($pisatel);
		$email = BezSkriptu($email);
		$text = BezSkriptu($text);
		// poslani zpravy
		$radek_1="Jméno pisatele: ".$pisatel;
		$radek_2="E-mail: ".$email;
		$radek_3="Text sdělení: ".nl2br($text);
		
		@$posta=mail("radnice@mestotynec.cz", "sdeleni", $radek_1."\n".$radek_2."\n".$radek_3,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
	endif;
	if ($errnr):
		$path2 = "&artid=$artid&errnr=$errnr&pisatel=$pisatel&email=$email&text=$text";
	else:
		$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
		$path2 = "?form=sdel&fp=$fp&posta=$posta";
	endif;
elseif ($form == "diskuse"):	
	$titulek = $_POST["titulek"];
	$jmeno = $_POST["jmeno"];
	$email = $_POST["email"];
	$text = $_POST["text"];
	$idtema = $_POST["idtema"];
	$idtop = ($_POST["idtop"] ? $_POST["idtop"] : 0);
	$employee = 0;
	if (!$titulek):
		$errnr = 16;
	elseif (!$jmeno):
		$errnr = 13;
	elseif ($email AND !strpos($email,"@")):
		$errnr = 1;
	elseif (!$text):
		$errnr = 4;
	elseif ($kontrola != $kontrolkod):
	  $errnr = 99;
	else:
		// bez chyb
		$titulek = BezSkriptu($titulek);
		$jmeno = BezSkriptu($jmeno);
		$email = BezSkriptu($email);
		$text = BezSkriptu($text);
		// zapis zpravy
		$dotazins = "INSERT INTO zapis (idtema,idtop,titulek,jmeno,email,text,employee) VALUES ($idtema,$idtop,'$titulek','$jmeno','$email','$text',$employee)";
		$resultins = mysql_query("$dotazins");
		if (!$resultins):
			die("Nepodarilo se pridat prispevek do diskuse - checkform.tpl!");
		endif;		
		// poslani upozorneni
		$recordtema = TblHandler($idtema,"tema");
		if (!$recordtema["public"] && $idtop):
			$dotazmail = "SELECT * FROM zapis WHERE id=$idtop OR idtop=$idtop";
			$resultmail = mysql_query("$dotazmail");
			if (!$resultmail):
				die("Nezdaril se vyber z tabulky zapisu pro poslani zprav diskutujicim - checkform!");
			else:
				while ($record = mysql_fetch_array($resultmail)):
					$email = $record["email"];
					$isregistr = GetNumRecords("uzivatel","email='$email'");
					if ($isregistr):
						$radek_1 = $record["jmeno"]." odpověděl na příspěvek:";
						$radek_2 = $record["titulek"];
						$radek_3 = "adresa příspěvku: http://".$server.":".$port.$path."diskuse.php?idtema=$idtema&idtop=$idtop";
						@$posta=mail($email, "odpoved v diskusi", $radek_1."\n".$radek_2."\n".$radek_3,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
					endif;
				endwhile;
			endif;
		endif;
	endif;
	if ($errnr):
		$path2 = "?idtema=$idtema&idtop=$idtop&errnr=$errnr&titulek=$titulek&jmeno=$jmeno&email=$email&text=$text";
	else:
		$path2 = "?idtema=$idtema&idtop=$idtop";
	endif;
elseif ($form == "dotazbus"):
  $otazka1 = $_POST["otazka1"];
  $otazka2 = $_POST["otazka2"];
  $otazka3 = $_POST["otazka3"];
  $otazka4 = $_POST["otazka4"];
  $otazka5 = $_POST["otazka5"];
  $otazka6 = $_POST["otazka6"];  
	$otazka4opt1txt = BezSkriptu($_POST["otazka4opt1txt"]);
	$otazka6opt2txt = BezSkriptu($_POST["otazka6opt2txt"]);
	$sdeleni = BezSkriptu($_POST["sdeleni"]);
	// poslani zpravy
	$radek_1="Otazka 1: ".$otazka1;
	$radek_2="Otazka 2: ".$otazka2;
	$radek_3="Otazka 3: ".$otazka3;
	$radek_4="Otazka 4: ".$otazka4.(($otazka4=="ano, casto")&&($otazka4opt1txt!="") ? " - ".$otazka4opt1txt : "");
	$radek_5="Otazka 5: ".$otazka5;
	$radek_6="Otazka 6: ".$otazka6.(($otazka6=="ne")&&($otazka6opt2txt!="") ? " - ".$otazka6opt2txt : "");
	$radek_7="Dalsi sdeleni: ".nl2br($sdeleni);
	@$posta=mail("radnice@mestotynec.cz", "Dotaznik - doprava", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5."\n".$radek_6."\n".$radek_7,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
	$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
	$path2 = "?form=dotazbus&fp=$fp&posta=$posta";
elseif ($form == "dotazjid"):
  $otazka1 = $_POST["otazka1"];
	$sdeleni2 = BezSkriptu($_POST["sdeleni2"]);
	$sdeleni3 = BezSkriptu($_POST["sdeleni3"]);
	// poslani zpravy
	$radek_1="Otazka 1: ".$otazka1;
	$radek_2="Sdělení 2: ".nl2br($sdeleni2);
	$radek_3="Sdělení 3: ".nl2br($sdeleni3);
	@$posta=mail("radnice@mestotynec.cz", "Dotaznik - skolni jidelna", $radek_1."\n".$radek_2."\n".$radek_3,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
	$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
	$path2 = "?form=dotazbus&fp=$fp&posta=$posta";
elseif ($form == "dotazfit"):
  $otazka1 = $_POST["otazka1"];
  $otazka2 = $_POST["otazka2"];
  $otazka3 = $_POST["otazka3"];
  $otazka4 = $_POST["otazka4"];
  $otazka5 = $_POST["otazka5"];
  $otazka6 = $_POST["otazka6"];  
  $otazka8 = $_POST["otazka8"]; 
  $otazka9 = $_POST["otazka9"];   
	$otazka4opt4txt = BezSkriptu($_POST["otazka4opt4txt"]);
	$otazka4opt5txt = BezSkriptu($_POST["otazka4opt5txt"]);
  $otazka5opt6txt = BezSkriptu($_POST["otazka5opt6txt"]);
	$sdeleni7 = BezSkriptu($_POST["sdeleni7"]);
  $otazka8opt7txt = BezSkriptu($_POST["otazka8opt7txt"]);
	$otazka8opt8txt = BezSkriptu($_POST["otazka8opt8txt"]);
	$sdeleni10 = BezSkriptu($_POST["sdeleni10"]);	
	// poslani zpravy
	$radek_1="Otázka 1: ".$otazka1;
	$radek_2="Otázka 2: ".$otazka2;
	$radek_3="Otázka 3: ".$otazka3;
	$radek_4="Otázka 4: ".$otazka4.(($otazka4=="tydne")&&($_POST["otazka4opt4txt"]) ? " - ".$otazka4opt4txt : "").(($otazka4=="mesicne")&&($_POST["otazka4opt5txt"]) ? " - ".$otazka4opt5txt : "");
	$radek_5="Otázka 5: ".$otazka5.(($otazka5=="dojizdim do")&&($_POST["otazka5opt6txt"]) ? " - ".$otazka5opt6txt : "");
	$radek_6="Otázka 6: ".$otazka6;
	$radek_7="Sdělení 7 ".nl2br($sdeleni7);
	$radek_8="Otázka 8: ".$otazka8.(($otazka8=="tydne")&&($_POST["otazka8opt7txt"]) ? " - ".$otazka8opt7txt : "").(($otazka8=="mesicne")&&($_POST["otazka8opt8txt"]) ? " - ".$otazka8opt8txt : "");
	$radek_9="Otázka 9: ".$otazka9;
	$radek_10="Sdělení 10 ".nl2br($sdeleni10);
	@$posta=mail("radnice@mestotynec.cz", "Dotaznik - fitko", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5."\n".$radek_6."\n".$radek_7."\n".$radek_8."\n".$radek_9."\n".$radek_10,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
	$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
	$path2 = "?form=dotazfit&fp=$fp&posta=$posta";
elseif ($form == "dotazvize"):
	$sdeleni1 = BezSkriptu($_POST["sdeleni1"]);
	$sdeleni2 = BezSkriptu($_POST["sdeleni2"]);
	$otazka31txt = BezSkriptu($_POST["otazka31txt"]);
	$otazka32txt = BezSkriptu($_POST["otazka32txt"]);
	$otazka33txt = BezSkriptu($_POST["otazka33txt"]);
	$otazka34txt = BezSkriptu($_POST["otazka34txt"]);
	$otazka35txt = BezSkriptu($_POST["otazka35txt"]);
	$otazka36txt = BezSkriptu($_POST["otazka36txt"]);
	$otazka4 = $_POST["otazka4"];
	$otazka5 = $_POST["otazka5"];
	$otazka6txt = $_POST["otazka6txt"];
	$otazka7 = $_POST["otazka7"];
	$otazka8 = $_POST["otazka8"];
	// poslani zpravy
	$radek_1="Sdělení 1: ".$sdeleni1;
	$radek_2="Sdělení 2: ".$sdeleni2;
	$radek_3="Otázka 3: ".$otazka31txt." - služby, ".$otazka32txt." - doprava, ".$otazka33txt." - zaměstnání, ".$otazka34txt." - volný čas, ".$otazka35txt." - kultura, ".$otazka36txt;
	$radek_4="Otázka 4: ".$otazka4;
	$radek_5="Otázka 5: ".$otazka5;
	$radek_6="Otázka 6: ".$otazka6txt;
	$radek_7="Otázka 7 ".$otazka7;
	$radek_8="Otázka 8: ".$otazka8;
	@$posta=mail("radnice@mestotynec.cz", "Dotaznik - vize", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5."\n".$radek_6."\n".$radek_7."\n".$radek_8,"From: web@mestotynec.cz\nX-Sender: <web@mestotynec.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@mestotynec.cz>\nContent-Type: text/plain; charset=utf-8\n");
	$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
	$path2 = "?form=dotazvize&fp=$fp&posta=$posta";
endif;

$path = $path1.$path2;

// návrat na původní stránku
Header("Location: http://".$server.":".$port.$path);
?>
