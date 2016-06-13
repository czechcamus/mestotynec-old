<?php
// spuštění session
session_name("UserSess");
session_start();

// řetězec session
$strsess = ($_SESSION["userid"] ? substr(SID,9) : ""); 

// načtení funkcí
require "scripts/usrfce.php";

// generování údajů uživatele
if ($_SESSION["userid"]):
	$recorduser = TblHandler($_SESSION["userid"],"uzivatel");
endif;

// volající script, větev a úroveň menu
if (!$fp):
	$fp = FileProm(); // proměnná s názvem souboru
else:
	$filehit = (strstr($fp,".php") ? "" : $fp);
	if ($filehit):
		Add2Stat($filehit);
	endif;
endif;
if ($fp == "search.php"):
	$sm = 0;
	$pagetitle = "výsledky hledání";
elseif ($fp == "register.php"):
	$sm = 0;
	$pagetitle = "registrace";
elseif ($fp == "diskuse.php"):
	$sm = 0;
	$pagetitle = "diskusní fórum";
elseif ($fp == "servermap.php"):
	$sm = 0;
	$pagetitle = "mapa serveru";
else:
	$menu = MenuHandler($fp); // pole s údaji z tabulky menu
	$l1m = ($menu["level"] > 1 ? GetLevel1Menu($menu["id"]) : $menu); // vrací pole menu úrovně 1
	$sm = IsSubMenu($fp); // existence submenu
	$pagetitle = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$menu["titulek"]);
endif;


// typ dokumentu
echo "<?xml version='1.0' encoding='UTF-8'?>";
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs">

<head>
	<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="author" content="All: Pavel Kamir [C@mus]; mailto:ja@camus.cz" />
	<meta name="author" content="Supported by C@mus; http://www.camus.cz" />
	<meta name="copyright" content="Město Dačice" />
	<meta name="keywords" content="Dačice, město" />
	<meta name="description" content="Dačice - městský internetový server" />
	<title>Dačice - <?php echo $pagetitle; ?> - textová verze</title>
	<style type="text/css" title="Styl1">
	/*<![CDATA[*/
	@import url("css/stylestxt.css");
	/*]]>*/
	</style>
</head>

<body>
		<h1><a href="<?php echo "index.php".($_SESSION["userid"] ? "?".SID : ""); ?>" title="úvodní stránka" id="mainlink">Dačice</a> - <?php echo $pagetitle; ?></h1>
		<h2>obsah: <?php echo $menu["obsah"]; ?></h2>
		<hr />
		<ul>
			<li><a href="<?php echo "page.php?fp=radnice/uredni-deska".($_SESSION["userid"] ? "&amp;".SID : ""); ?>" accesskey="d">úře<span class="letterkey">d</span>ní&nbsp;deska</a><br />
				Na úřední desce najdete důležité dokumenty a informace.
			</li>
			<li><a href="<?php echo "page.php?fp=radnice/elektronicka-podatelna".($_SESSION["userid"] ? "&amp;".SID : ""); ?>" accesskey="p">e<span class="letterkey">p</span>odatelna</a><br />
				Elektronická podatelna nabízí www formuláře a kontakty pro Vaše sdělení nebo žádosti o poskytnutí informací.
			</li>
<!--						
			<li><a href="<?php echo "shop/index.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="e"><span class="letterkey">e</span>shop</a><br />
				V elektronickém obchodě si můžete koupit například regionální publikace.
			</li>
-->						
			<li><a href="<?php echo "diskuse.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="i">d<span class="letterkey">i</span>skuse</a><br />
				V diskusi mohou registrovaní uživatelé debatovat o různých tématech. Neregistrovaní mají vyhrazeno jedno téma 
				pro	návštěvy.
			</li>
			<li><a href="<?php echo "servermap.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="a">m<span class="letterkey">a</span>pa&nbsp;serveru</a><br />
				Podrobnou strukturu webu najdete na této mapě serveru.
			</li>
		</ul>
		<hr />		