<?php echo "<"; ?>?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><?php echo htmlspecialchars($t->title);?></title>
<link rel="stylesheet" href="css/default.css" type="text/css" />
</head>
<body>
	<div id="container">
		<h1><?php echo htmlspecialchars($t->title);?></h1>
		<form action="scripts/proctext.php" method="get" enctype="multipart/form-data">
			<fieldset>
			<label for="text1">Text - první odstavec:</label>
			<?php echo $this->elements['text1']->toHtml();?>
			<label for="text2">Text - poslední odstavec:</label>
			<?php echo $this->elements['text2']->toHtml();?>
			<?php echo $this->elements['aid']->toHtml();?>
			<div>
				<?php echo $this->elements['save']->toHtml();?>
			</div>
			</fieldset>
		</form>
		<p class="control">&laquo; <a href="usermng.php?<?php echo htmlspecialchars($t->curl_aid);?>">návrat</a></p>
		<p class="userinfo">
			Přihlášený uživatel: <strong><?php echo htmlspecialchars($t->userinfo);?></strong> <a href="scripts/logout.php?<?php echo htmlspecialchars($t->curl_aid);?>">odhlásit se</a> &raquo;
		</p>
	</div>
</body>
</html>