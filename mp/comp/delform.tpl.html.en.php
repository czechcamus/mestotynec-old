<?php echo "<"; ?>?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Upozornění před smazáním</title>
<link rel="stylesheet" href="css/default.css" type="text/css" />
</head>
<body>
	<div id="container">
		<h1>Upozornění před smazáním</h1>
		<h2>Opravdu chcete smazat <?php echo htmlspecialchars($t->title);?> ?</h2>
		<form action="scripts/procform.php" method="get" enctype="multipart/form-data">
			<fieldset>
			<?php echo $this->elements['aid']->toHtml();?>
			<?php echo $this->elements['act']->toHtml();?>
			<?php echo $this->elements['form']->toHtml();?>
			<?php echo $this->elements['id']->toHtml();?>
			<?php echo $this->elements['button1']->toHtml();?>
			<?php echo $this->elements['button2']->toHtml();?>
			</fieldset>
		</form>
	</div>
</body>
</html>