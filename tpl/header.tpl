<?php
// spuštění session
session_name("UserSess");
session_start();

// řetězec session
$strsess = ($_SESSION["userid"] ? substr(SID,9) : ""); 

// nastavení cookie
$nrskin = $_COOKIE["nrskin"];
$idankety = $_COOKIE["idankety"];

if (!$nrskin):
	$nrskin = 1;
endif;
if (!idankety):
	$idankety = 0;
endif;


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
elseif ($fp == "skins.php"):
	$sm = 0;
	$pagetitle = "změna vzhledu webu";
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
	<meta name="copyright" content="Město Týnec nad Sázavou" />
	<meta name="keywords" content="Týnec, nad, Sázavou, město" />
	<meta name="description" content="Týnec nad Sázavou - městský internetový server" />
	<title>Týnec nad Sázavou - <?php echo $pagetitle; ?></title>
	<style type="text/css" title="Styl1">
	/*<![CDATA[*/
<?php if ($nrskin == 2): ?>
	@import url("css/oldiered1.css");
<?php elseif ($nrskin == 3): ?>
	@import url("css/oldieblue1.css");
<?php else: ?>
	@import url("css/styles1.css");
<?php endif; ?>
	/*]]>*/
	</style>
	<link rel="shortcut icon" href="img/design/favicon.ico" />
	<link rel="alternate" title="Týnec nad Sázavou RSS" href="http://www.mestotynec.cz/rss.xml" type="application/rss+xml" />	
</head>

<body>
	<?php echo ($fp == "index.php" ? "<div id=\"hpcontainer\">" : "<div id=\"container\">"); ?>
		<div id="banner">
			<div>
				<h1>Dačice - <?php echo $pagetitle; ?></h1>
				<h2>obsah: <?php echo $menu["obsah"]; ?></h2>
				<a href="<?php echo "index.php".($_SESSION["userid"] ? "?".SID : ""); ?>" title="úvodní stránka" id="mainlink">úvod<span></span></a>
			</div>
		</div><!-- end banner -->
		<div id="loginbox">
			<div class="margin">
				<h3>přihlášení</h3>
				<?php if ($_SESSION["userid"]): ?>
					<div class="loguser">Přihlášený uživatel:<br />
					<strong><?php echo $recorduser["user"]; ?></strong></div>
					<form action="scripts/logout.php" method="get" id="loginform">
						<div>
						<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
						<input type="submit" value="odhlásit" title="tlačítko odhlásit" class="subinput" />
						</div>
					</form>
				<?php else: ?>
					<form action="scripts/login.php" method="get" id="loginform">
						<fieldset>
							<div>					
							<label for="username">Uživatel</label>
							<input type="text" name="username" id="username" size="10" maxlength="20" class="txtinput" />
							</div>
							<div>
							<label for="userpwd">Heslo</label>
							<input type="password" name="userpwd" id="userpwd" size="10" maxlength="20" class="txtinput" />
							<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
							</div>
						</fieldset>
						<div><input type="submit" value="přihlásit" title="tlačítko přihlásit" class="subinput" /></div>
					</form>
				<?php endif;
				if ($fp != "register.php"): ?>
				<div id="reglinks">
					<?php if ($_SESSION["userid"]): ?>
						<a href="<?php echo "register.php?".SID; ?>" title="stránka s registračním formulářem" class="rightarrowlink">změnit registrační údaje</a>
					<?php else: ?>
						<a href="register.php" title="stránka s registračním formulářem a popisem výhod registrace" class="rightarrowlink">registrovat se</a>
					<?php endif; ?>
				</div>
				<?php endif; ?>
			</div>
		</div><!-- end loginbox -->
		<div id="horizontalbarbox">
			<div class="margin1"><div class="margin2">
				<div id="searchbox">
					<form action="search.php" method="get" id="searchform">
						<fieldset>
							<label for="searchtext">Hledaný výraz</label>
							<input type="text" name="searchtext" id="searchtext" size="10" maxlength="250" value="<?php echo $searchtext; ?>" class="txtinput" />
							<input type="submit" value="vyhledat" title="tlačítko vyhledat" class="subinput" />
						</fieldset>
					</form>
				</div>
				<div id="languages">
					<div>
					<a href="<?php echo "en/index.php"; ?>" class="en" title="english version">english<span></span></a><span class="nodisp">,</span>
					<a href="<?php echo "de/index.php"; ?>" class="de" title="deutsche version">deutsch<span></span></a>
					</div>
				</div>
				<div id="quickmenubox">
					<ul>
						<li><a href="<?php echo "page.php?fp=radnice/uredni-deska".($_SESSION["userid"] ? "&amp;".SID : ""); ?>" accesskey="u"><span class="textunderline">dok<span class="letterkey">u</span>menty</span></a>
							<div class="iteminfobox"><div class="margin">
								Na úřední desce najdete důležité dokumenty a informace.
							</div></div>
						</li>
						<li><a href="<?php echo "edeska.php".($_SESSION["userid"] ? "&amp;".SID : ""); ?>" accesskey="d"><span class="textunderline">úře<span class="letterkey">d</span>ní&nbsp;deska</span></a>
							<div class="iteminfobox"><div class="margin">
								Na úřední desce najdete důležité dokumenty a informace.
							</div></div>
						</li>
						<li><a href="<?php echo "page.php?fp=radnice/elektronicka-podatelna".($_SESSION["userid"] ? "&amp;".SID : ""); ?>" accesskey="p"><span class="textunderline">e<span class="letterkey">p</span>odatelna</span></a>
							<div class="iteminfobox"><div class="margin">
								Elektronická podatelna nabízí www formuláře a kontakty pro Vaše sdělení nebo žádosti o poskytnutí informací.
							</div></div>
						</li>
<!--						
						<li><a href="<?php echo "shop/index.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="e"><span class="textunderline"><span class="letterkey">e</span>shop</span></a>
							<div class="iteminfobox"><div class="margin">
								V elektronickém obchodě si můžete koupit například regionální publikace.
							</div></div>
						</li>
-->						
						<li><a href="<?php echo "diskuse.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="i"><span class="textunderline">d<span class="letterkey">i</span>skuse</span></a>
							<div class="iteminfobox"><div class="margin">
								V diskusi mohou registrovaní uživatelé debatovat o různých tématech. Nabídka témat pro neregistrované uživatele je silně omezena ;-)
							</div></div>
						</li>
						<li><a href="<?php echo "servermap.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="a"><span class="textunderline">m<span class="letterkey">a</span>pa&nbsp;serveru</span></a>
							<div class="iteminfobox"><div class="margin">
								Podrobnou strukturu webu najdete na této mapě serveru.
							</div></div>
						</li>
						<li><a href="<?php echo "skins.php".($_SESSION["userid"] ? "?".SID : ""); ?>" accesskey="y"><span class="textunderline">skin<span class="letterkey">y</span></span></a>
							<div class="iteminfobox"><div class="margin">
								Zde si můžete vybrat vzhled webu, který se Vám nejvíce líbí.
							</div></div>
						</li>
					</ul>
				</div>
			</div></div>
		</div>
