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
		<?php if ($t->logform)  {?>
			<form method="get" enctype="multipart/form-data">
				<fieldset>
				<label for="obdobi_od" class="required">Období od (DD.MM.RRRR) *:</label>
				<?php echo $this->elements['obdobi_od']->toHtml();?>
				<label for="obdobi_do" class="required">Období do (DD.MM.RRRR) *:</label>
				<?php echo $this->elements['obdobi_do']->toHtml();?>
				<?php echo $this->elements['aid']->toHtml();?>
				<div>
					<?php echo $this->elements['save']->toHtml();?>
				</div>
				</fieldset>
			</form>
		<?php } else {?>
			<table>
				<caption>Výpis logu za období od <?php echo htmlspecialchars($t->obdobi_od);?> do <?php echo htmlspecialchars($t->obdobi_do);?></caption> 
				<tr><th>Čas přístupu</th><th>Jméno návštěvníka</th><th>Osoba - dokument</th></tr>
				<?php if ($this->options['strict'] || (is_array($t->data)  || is_object($t->data))) foreach($t->data as $key => $value) {?>
					<tr><td><?php echo htmlspecialchars($value['acctime']);?></td><td><?php echo htmlspecialchars($value['user']);?></td><td><?php echo htmlspecialchars($value['person']);?> - <a href="scripts/viewdoc.php?doc=<?php echo htmlspecialchars($value['filename']);?>&amp;<?php echo htmlspecialchars($t->curl_aid);?>"><?php echo htmlspecialchars($value['filetitle']);?></a></td></tr>
				<?php }?>
			</table>
		<?php }?>
		<p class="control">&laquo; <a href="index.php?<?php echo htmlspecialchars($t->curl_aid);?>">návrat</a></p>
		<p class="userinfo">
			Přihlášený uživatel: <strong><?php echo htmlspecialchars($t->userinfo);?></strong> <a href="scripts/logout.php?<?php echo htmlspecialchars($t->curl_aid);?>">odhlásit se</a> &raquo;
		</p>
	</div>
</body>
</html>