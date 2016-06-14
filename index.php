<?php // nastavení cookie
$nrskin = isset($_COOKIE["nrskin"]) ? $_COOKIE["nrskin"] : 1;
$idankety = isset($_COOKIE["idankety"]) ? $_COOKIE["idankety"] : 0;

// test muzea
if ($_SERVER['HTTP_HOST'] == "muzeum.mestotynec.cz"):
	header("HTTP/1.1 301 Moved Permanently");
	header("Location: http://www.mestotynec.cz/muzeum");
	exit;
endif;

// nactení funkcí
require "scripts/usrfce.php";

// volající script, vetev a úroven menu
$fp = $_GET['fp'];
if (!$fp):
	$fp = FileProm(); // promenná s názvem souboru
endif;
$menu = MenuHandler($fp); // pole s údaji z tabulky menu
$l1m = ($menu["level"] > 1 ? GetLevel1Menu($menu["id"]) : $menu); // vrací pole menu úrovne 1
$sm = IsSubMenu($fp); // existence submenu
$pagetitle = ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$menu["titulek"]);

// typ dokumentu
echo "<?xml version='1.0' encoding='UTF-8'?>"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="author" content="All: Pavel Kamir [C@mus]; mailto:ja@camus.cz" />
	<meta name="author" content="Supported by C@mus; http://www.camus.cz" />
	<meta name="copyright" content="Město Týnec nad Sázavou" />
	<meta name="keywords" content="týnec,nad,sázavou,sázava,posázaví,týnecko,město,radnice,úřad,městský,městská" />
	<meta name="description" content="Informační server města Týnec nad Sázavou" />

	<title>Týnec nad Sázavou - <?php echo $pagetitle; ?></title>
	<style type="text/css" title="Styl1">
	/*<![CDATA[*/
<?php if ($nrskin == 2): ?>
	@import url("css/spring.css");
<?php else: ?>
	@import url("css/styles1.css");
<?php endif; ?>
	/*]]>*/
	</style>
	<link rel="shortcut icon" href="img/design/favicon.ico" />
	<link rel="alternate" title="Týnec nad Sázavou RSS" href="http://www.mestotynec.cz/rss.xml" type="application/rss+xml" />	
</head>

<body>
	<div id="container">
		<div id="header">
			<div id="quickmenu">
				<ul>
					<li><a href="<?php echo "page.php?fp=radnice/uredni-deska"; ?>" title="dokumenty" tabindex="2">dokumenty</a></li>
					<li><a href="<?php echo "edeska.php"; ?>" title="elektronická úřední deska" tabindex="3">úřední deska</a></li>
					<li><a href="<?php echo "page.php?fp=radnice/elektronicka-podatelna"; ?>" title="elektronická podatelna" tabindex="4">podatelna</a></li>
					<li><a href="<?php echo "page.php?fp=radnice/vase-nazory"; ?>" title="Vaše názory" tabindex="5">vaše názory</a></li>
					<li class="lastitem"><a href="<?php echo "servermap.php"; ?>" title="mapa serveru" tabindex="6">mapa serveru</a></li>
				</ul>
			</div>
			<div id="banner">
				<h1><a href="index.php" title="úvodní stránka" tabindex="1">Týnec nad Sázavou<span id="logo"></span></a> - <?php echo $pagetitle; ?></h1>
			</div>
			<div id="searchbar">
<!--			
				<div id="flags">
					<a href="<?php echo "index.php"; ?>" title="česká verze" tabindex="7" class="cz">česky<span class="flag"></span></a>
					<a href="<?php echo "en/index.php"; ?>" title="english version" tabindex="8" class="en">anglicky<span class="flag"></span></a>
				</div>
-->				
				<form action="search.php" method="get" id="searchform">
					<fieldset>
						<label for="searchtext">vyhledávání</label>
						<input type="text" name="searchtext" id="searchtext" size="12" maxlength="250" value="<?php echo $searchtext; ?>" tabindex="7" class="txtinput" />
						<input type="submit" value=" OK " title="tlačítko najít" tabindex="8" class="subinput" />
					</fieldset>
				</form>
			</div>
		</div>
		<div id="body">
		<?php
			include "tpl/right.tpl";
			include "tpl/center.tpl";
			include "tpl/left.tpl";
		?>
		</div>
		<hr class="masterclear" />
		<div id="footer">
			<div class="imprint">
				<a href="pristupnost.php">Prohlášení o přístupnosti</a><br />
				Provozovatel: Městský úřad Týnec nad Sázavou<br />
				Webmaster: <a href="http://www.camus.cz">C@mus</a>
			</div>
		</div>
	</div>
</body>

</html>
