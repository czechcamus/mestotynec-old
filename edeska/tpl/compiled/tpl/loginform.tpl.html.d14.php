<?php
ob_start(); /* template body */ ?><?php echo '<?xml'; ?> version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="author" content="All: Pavel Kamir [C@mus]; mailto:ja@camus.cz" />
	<meta name="author" content="Supported by C@mus; http://www.camus.cz" />
	<meta name="copyright" content="<?php echo $this->scope["copyright"];?>" />
	<meta name="keywords" content="<?php echo $this->scope["keywords"];?>" />
	<meta name="description" content="<?php echo $this->scope["description"];?>" />
	<title><?php echo $this->scope["title"];?></title>
	<link rel='stylesheet' type='text/css' media='all' href='css/editstyles.css' />
</head>
<body id="loginbody">
	<div id="logincontainer">
		<h1>Přihlášení do systému</h1>
		<?php if ((isset($this->scope["errorstring"]) ? $this->scope["errorstring"] : null)) {
?>
			<p class="error"><?php echo $this->scope["errorstring"];?></p>
		<?php 
}?>

		<form method="get" enctype="multipart/form-data" class="editform">
			<fieldset>
			<label for="user" class="required">Uživatel *:</label>
			<input type="text" name="user" id="user" size="12" class="txtinput" />
			<label for="pwd" class="required">Heslo *:</label>
			<input type="password" name="pwd" id="pwd" size="12" class="txtinput" />
			<div>
				<input type="submit" name="login" id="login" value="přihlásit" class="subinput" />
			</div>
			</fieldset>
		</form>
	</div>
</body>
</html><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>