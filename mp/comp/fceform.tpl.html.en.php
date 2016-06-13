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
		<?php if ($t->error)  {?>
			<p class="error"><?php echo htmlspecialchars($t->error);?></p>
		<?php }?>
		<form action="scripts/procform.php" method="get" enctype="multipart/form-data">
			<fieldset>
			<label for="nazev" class="required">Název funkce *:</label>
			<?php echo $this->elements['nazev']->toHtml();?>
			<?php echo $this->elements['aid']->toHtml();?>
			<?php echo $this->elements['required']->toHtml();?>
			<?php echo $this->elements['act']->toHtml();?>
			<?php echo $this->elements['form']->toHtml();?>
			<?php if ($t->id)  {?>
				<?php echo $this->elements['id']->toHtml();?>
			<?php }?>
			<div>
				<?php echo $this->elements['save']->toHtml();?>
			</div>
			</fieldset>
		</form>
		<p class="control">&laquo; <a href="fcemng.php?<?php echo htmlspecialchars($t->curl_aid);?>">návrat</a></p>
		<p class="userinfo">
			Přihlášený uživatel: <strong><?php echo htmlspecialchars($t->userinfo);?></strong> <a href="scripts/logout.php?<?php echo htmlspecialchars($t->curl_aid);?>">odhlásit se</a> &raquo;
		</p>
	</div>
</body>
</html>