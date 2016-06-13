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
		<ul class="menu">
			<li><a href="<?php echo htmlspecialchars($t->pref);?>form.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;act=add">Přidat <?php echo htmlspecialchars($t->what);?></a></li>
			<?php if ($t->user)  {?>
			<li><a href="textform.php?<?php echo htmlspecialchars($t->curl_aid);?>">Upravit text tiskové sestavy</a></li>
			<?php }?>
		</ul>
		<table>
			<tr>
			<?php if ($t->fce)  {?><th>Název funkce</th><?php }?>
			<?php if ($t->person)  {?><th>Příjmení, jméno, titul</th><th>Narozen</th><th>Funkce</th><?php }?>
			<?php if ($t->user)  {?><th>Příjmení, jméno, titul</th><th>Už. jméno</th><th>Adresa</th><?php }?>
			<?php if ($t->doc)  {?><th>Období</th><th>Příjmení, jméno</th><th>Dokument</th><?php }?>
			<th>&nbsp;</th>
			</tr>
			<?php if ($t->fce)  {?>
			<?php if ($this->options['strict'] || (is_array($t->data)  || is_object($t->data))) foreach($t->data as $key => $value) {?>
				<tr><td><?php echo htmlspecialchars($value);?></td><td><a href="fceform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;act=edit">upravit</a> <a href="delform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;form=fce">smazat</a></td></tr>
			<?php }?>
			<?php }?>
			<?php if ($t->person)  {?>
			<?php if ($this->options['strict'] || (is_array($t->data)  || is_object($t->data))) foreach($t->data as $key => $value) {?>
				<tr><td><?php echo htmlspecialchars($value['prijmeni']);?> <?php echo htmlspecialchars($value['jmeno']);?> <?php echo htmlspecialchars($value['titulpred']);?></td><td><?php echo htmlspecialchars($value['narozen_d']);?></td><td><?php echo htmlspecialchars($value['funkce']);?></td><td><a href="personform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;act=edit">upravit</a> <a href="delform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;form=person">smazat</a></td></tr>
			<?php }?>
			<?php }?>
			<?php if ($t->user)  {?>
			<?php if ($this->options['strict'] || (is_array($t->data)  || is_object($t->data))) foreach($t->data as $key => $value) {?>
				<tr><td><?php echo htmlspecialchars($value['prijmeni']);?> <?php echo htmlspecialchars($value['jmeno']);?> <?php echo htmlspecialchars($value['titulpred']);?></td><td><?php echo htmlspecialchars($value['username']);?></td><td><?php echo htmlspecialchars($value['mesto']);?>, <?php echo htmlspecialchars($value['ulicecp']);?></td><td><a href="userform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;act=edit">upravit</a> <a href="delform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;form=user">smazat</a> <a href="printuser.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>">tisk údajů</a></td></tr>
			<?php }?>
			<?php }?>
			<?php if ($t->doc)  {?>
			<?php if ($this->options['strict'] || (is_array($t->data)  || is_object($t->data))) foreach($t->data as $key => $value) {?>
				<tr><td><?php echo htmlspecialchars($value['obdobiod_d']);?> <?php echo htmlspecialchars($value['obdobido_d']);?></td><td><?php echo htmlspecialchars($value['prijmeni']);?> <?php echo htmlspecialchars($value['jmeno']);?></td><td><a href="scripts/viewdoc.php?doc=<?php echo htmlspecialchars($value['filename']);?>&amp;<?php echo htmlspecialchars($t->curl_aid);?>"><?php echo htmlspecialchars($value['filetitle']);?></a></td><td><a href="docform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;act=edit">upravit</a> <a href="delform.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($key);?>&amp;form=doc">smazat</a></td></tr>
			<?php }?>
			<?php }?>
		</table>
		<p class="control">&laquo; <a href="index.php?<?php echo htmlspecialchars($t->curl_aid);?>">návrat</a></p>
		<p class="userinfo">
			Přihlášený uživatel: <strong><?php echo htmlspecialchars($t->userinfo);?></strong> <a href="scripts/logout.php?<?php echo htmlspecialchars($t->curl_aid);?>">odhlásit se</a> &raquo;
		</p>
	</div>
</body>
</html>