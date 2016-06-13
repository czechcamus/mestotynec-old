<?php
// spuštění session
session_name("UserSess");
session_start();

$pref = "../";
require "usrfce.php";

$server = $_SERVER["SERVER_NAME"];
$port = $_SERVER["SERVER_PORT"];
$script = $_SERVER["SCRIPT_NAME"];
$fp = $_POST["fp"];
$form = $_POST["form"];
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
		
		@$posta=mail("e-podatelna@dacice.cz", "žádost o informace", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5,"From: web@dacice.cz\nX-Sender: <web@dacice.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@dacice.cz>\nContent-Type: text/plain; charset=utf-8\n");
	endif;
	if ($errnr):
		$path2 = "&errnr=$errnr&zadatel=$zadatel&vyrizuje=$vyrizuje&ulice=$ulice&mesto=$mesto&psc=$psc&telefon=$telefon&fax=$fax&email=$email&text=$text&doruceni=$doruceni";
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
	else:
		// bez chyb
		$pisatel = BezSkriptu($pisatel);
		$email = BezSkriptu($email);
		$text = BezSkriptu($text);
		// poslani zpravy
		$radek_1="Jméno pisatele: ".$pisatel;
		$radek_2="E-mail: ".$email;
		$radek_3="Text sdělení: ".nl2br($text);
		
		@$posta=mail("e-podatelna@dacice.cz", "sdeleni", $radek_1."\n".$radek_2."\n".$radek_3,"From: web@dacice.cz\nX-Sender: <web@dacice.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@dacice.cz>\nContent-Type: text/plain; charset=utf-8\n");
	endif;
	if ($errnr):
		$path2 = "errnr=$errnr&pisatel=$pisatel&email=$email&text=$text";
	else:
		$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
		$path2 = "?form=i106&fp=$fp&posta=$posta";
	endif;
elseif ($form == "register"):	
	$user = $_POST["user"];
	$pwd = $_POST["pwd"];
	$pwdagain = $_POST["pwdagain"];
	$jmeno = $_POST["jmeno"];
	$prijmeni = $_POST["prijmeni"];
	$titul = $_POST["titul"];
	$ulice = $_POST["ulice"];
	$mesto = $_POST["mesto"];
	$psc = $_POST["psc"];
	$email = $_POST["email"];
	$fullreg = $_POST["fullreg"];
	$fullreg = ($fullreg ? 1 : 0);
	$letter = $_POST["letter"];
	$letter = ($letter ? 1 : 0);
	if (CheckUserName($_SESSION["userid"],$user)):
		$errnr = 15;
	elseif (!$user):
		$errnr = 9;
	elseif (!$pwd):
		$errnr = 10;
	elseif (!$pwdagain):
		$errnr = 11;
	elseif ($pwd != $pwdagain):
		$errnr = 12;
	elseif (!$email):
		$errnr = 3;
	elseif (!strpos($email,"@")):
		$errnr = 1;
	endif;
	if ($fullreg):
		if (!$jmeno):
			$errnr = 13;
		elseif (!$prijmeni):
			$errnr = 14;
		elseif (!$ulice):
			$errnr = 5;
		elseif (!$mesto):
			$errnr = 6;
		elseif (!$psc):
			$errnr = 7;
		endif;
	endif;
	if (!$errnr):
		// bez chyb
		$user = BezSkriptu($user);
		$pwd = BezSkriptu($pwd);
		$pwdagain = BezSkriptu($pwdagain);
		$ulice = BezSkriptu($ulice);
		$mesto = BezSkriptu($mesto);
		$psc = BezSkriptu($psc);
		$email = BezSkriptu($email);
		// poslani vyzvy k potvrzeni uzivateli
		if (!$_SESSION["userid"]):
			// zapis do tabulky uzivatelu
			$dotaz = "INSERT INTO uzivatel (user,pwd,jmeno,prijmeni,titul,ulice,mesto,psc,email,fullreg,letter,povol) VALUES ('$user','$pwd','$jmeno','$prijmeni','$titul','$ulice','$mesto','$psc','$email',$fullreg,$letter,0)";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Do tabulky uzivatel se nepodarilo nic zapsat - checkform.php!");
			else:
				// kodovani jmena uzivatele (pomoci MySQL pro zajisteni shody)
				$dotazmd5 = "SELECT MD5(user) AS md5user FROM uzivatel WHERE user='$user'";
				$resultmd5 = mysql_query("$dotazmd5");
				if (!$resultmd5):
					die("Nepodarilo se zakodovat uzivatelske jmeno - checkform.php!");
				endif;
				$recordmd5 = mysql_fetch_array($resultmd5);
				$radek_1="Dekujeme Vam za registraci na webu Mesta Dacic.\nVase registracni jsou:\n";
				$radek_2="uz. jmeno: ".$user."\n";
				$radek_3="heslo: ".$pwd."\n\n";
				$radek_4="Pro potvrzeni registrace navstivte nasledujici adresu (vlozte do adresniho radku prohlizece):\n";
				$radek_5="http://".$server.":".$port.$path."register.php?uid=".$recordmd5["md5user"];
				@$posta=mail($email, "registrace na www.dacice.cz", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5,"From: web@dacice.cz\nX-Sender: <web@dacice.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@dacice.cz>\nContent-Type: text/plain; charset=utf-8\n");
			endif;
			$akce = "add";
		else:
			$ru = TblHandler($_SESSION["userid"],"uzivatel");
			$dotaz = "UPDATE uzivatel SET pwd = '$pwd', jmeno = '$jmeno', prijmeni = '$prijmeni', titul = '$titul', ulice = '$ulice', mesto = '$mesto', psc = '$psc', email = '$email', fullreg = $fullreg, letter = $letter, povol = ".($email == $ru["email"] ? "1" : "0")." WHERE id = ".$_SESSION["userid"];
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Do tabulky uzivatel se nepodarilo zapsat zmeny - checkform.php!");
			else:
				if ($email != $ru["email"]):
					$radek_1="Vas e-mail byl zmenen.\n";
					$radek_2="puvodni e-mail: ".$ru["email"]."\n";
					$radek_2="novy e-mail: ".$email."\n";
					$radek_4="Pro potvrzeni zmeny navstivte nasledujici adresu (vlozte do adresniho radku prohlizece):\n";
					$radek_5="http://".$server.":".$port.$path."register.php?uid=".$recordmd5[0];
					@$posta=mail($email, "zmena v registraci na www.dacice.cz", $radek_1."\n".$radek_2."\n".$radek_3."\n".$radek_4."\n".$radek_5,"From: web@dacice.cz\nX-Sender: <web@dacice.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@dacice.cz>\nContent-Type: text/plain; charset=utf-8\n");
					$akce = "updmail";
					$_SESSION = array();
					if (isset($_COOKIE[session_name()])):
					   setcookie(session_name(), '', time()-42000, '/');
					endif;
					session_destroy();
				else:
					$akce = "update";
				endif;
			endif;
		endif;
	endif;
	if ($errnr):
		$path2 = (strstr($fp,".php") ? "?" : "&")."errnr=$errnr&user=$user&email=$email&jmeno=$jmeno&prijmeni=$prijmeni&titul=$titul&ulice=$ulice&mesto=$mesto&psc=$psc&fullreg=$fullreg&letter=$letter";
	else:
		$path1 = substr($script, 0, strrpos($script, "/"))."/".$pref."infoform.php";
		$path2 = "?form=register&akce=$akce&fp=$fp";
	endif;
elseif ($form == "diskuse"):	
	$titulek = $_POST["titulek"];
	$jmeno = $_POST["jmeno"];
	$email = $_POST["email"];
	$text = $_POST["text"];
	$idtema = $_POST["idtema"];
	$idtop = ($_POST["idtop"] ? $_POST["idtop"] : 0);
	$employee = 0;
	if ($_SESSION["userid"]):
		$recorduser = TblHandler($_SESSION["userid"],"uzivatel");
		$employee = $recorduser["employee"];
	endif;
	if (!$titulek):
		$errnr = 16;
	elseif (!$jmeno):
		$errnr = 13;
	elseif ($email AND !strpos($email,"@")):
		$errnr = 1;
	elseif (!$text):
		$errnr = 4;
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
					$radek_1 = $record["jmeno"]." odpověděl na příspěvek:";
					$radek_2 = $record["titulek"];
					$radek_3 = "adresa příspěvku: http://".$server.":".$port.$path."diskuse.php?idtema=$idtema&idtop=$idtop";
					@$posta=mail($record["email"], "odpověď v diskusi", $radek_1."\n".$radek_2."\n".$radek_3,"From: web@dacice.cz\nX-Sender: <web@dacice.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@dacice.cz>\nContent-Type: text/plain; charset=utf-8\n");
				endwhile;
			endif;
		endif;
	endif;
	if ($errnr):
		$path2 = "?idtema=$idtema&idtop=$idtop&errnr=$errnr&titulek=$titulek&jmeno=$jmeno&email=$email&text=$text";
	else:
		$path2 = "?idtema=$idtema&idtop=$idtop";
	endif;
endif;

$path = $path1.$path2.($_SESSION["userid"] ? "&".SID : "");

// návrat na původní stránku
Header("Location: http://".$server.":".$port.$path);
?>