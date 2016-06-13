<?php
// načtení funkcí
include "../scripts/settings.php";
include "./scripts/editfce.php";
echo "<?xml version='1.0' encoding='UTF-8'?>\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs">
<head>
	<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="author" content="All: Pavel Kamir [C@mus]; mailto:ja@camus.cz" />
	<meta name="author" content="Supported by C@mus; http://www.camus.cz" />
	<meta name="copyright" content="C@mus" />
	<title>Albert 2 - odhlášení</title>
	<style type="text/css" title="Styl1">
	/*<![CDATA[*/
	@import url("./css/editstyles.css");
	/*]]>*/
	</style>
</head>
<body>
	<div id="container">
		<p class="bold">Právě jste se odhlásil(a) z editačního režimu</p>
		<hr />
		<form action="./index.php" method="post">
			<fieldset>
			<input type="hidden" name="videno" value="1" />
   			<input type="hidden" name="olduser" value="<?php echo $_SERVER["PHP_AUTH_USER"]; ?>" />
   			<input type="submit" value="přihlásit jiného uživatele" />
			</fieldset>
		</form>
	</div>

</html>
