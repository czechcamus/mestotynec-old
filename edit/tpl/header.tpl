<?php // nacteni funkci
include "../scripts/settings.php"; 
include "./scripts/editfce.php";
$idredaktor = CheckLogin();
$recordred = TblHandler($idredaktor,"redaktor");
// typ dokumentu
echo "<?xml version='1.0' encoding='UTF-8'?>";?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="All: Pavel Kamir [C@mus]; mailto:ja@camus.cz" />
	<meta name="author" content="Supported by C@mus; http://www.camus.cz" />
	<meta name="copyright" content="C@mus" />
	<title>Albert 2 - redakční systém</title>
  	<script type="text/javascript" src="./jscripts/editfce.js"></script>
	<style type="text/css" title="Styl1">
	/*<![CDATA[*/
	@import url("./css/editstyles.css");
	/*]]>*/
	</style>
</head>
<body>
	<div id="container">
		<div id="user">
			<?php 
				echo "<div>Uživatel: ".$recordred["jmeno"]." ".$recordred["prijmeni"]."</div>\n";
			?>
			<form action="./logoutform.php" method="get">
				<fieldset>
				<input type="submit" value="Odhlásit" />
				</fieldset>
			</form>
		</div>
		<h1>Týnec nad Sázavou - web města</h1>
		<h2>
		<?php
			if (!strpos($_SERVER["SCRIPT_NAME"],"index.php")):
				echo "<a href=\"./index.php\">";
			endif;
			echo "Editační režim";
			if (!strpos($_SERVER["SCRIPT_NAME"],"index.php")):
				echo " - úvod</a>";
			endif;
			if ($recordred["admin"] || $recordred["schval"]):
				echo ", <a href=\"./webmng.php\">struktura menu</a>";
			endif;
			if ($menuid && !strpos($_SERVER["SCRIPT_NAME"],"webmng.php")):
				echo ", <a href=\"./webmng.php?menuid=$menuid\">aktuální položka nabídky</a>";
			endif;
			if (!strpos($_SERVER["SCRIPT_NAME"],"articlemng.php")):
				echo ", <a href=\"./articlemng.php\">seznam článků</a>";
			endif;
		?>
		</h2>
		<hr />