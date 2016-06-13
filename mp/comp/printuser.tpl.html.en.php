<?php echo "<"; ?>?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><?php echo htmlspecialchars($t->title);?></title>
<link rel="stylesheet" href="css/default.css" type="text/css" />
</head>
<body>
	<div id="printcontainer">
		<h1><?php echo htmlspecialchars($t->title);?></h1>
		<div class="content">
			<address>
			<?php echo htmlspecialchars($t->titulpred);?><br />
			<?php echo htmlspecialchars($t->jmeno);?> <?php echo htmlspecialchars($t->prijmeni);?><br />
			<?php echo htmlspecialchars($t->ulicecp);?><br />
			<?php echo htmlspecialchars($t->psc);?> <?php echo htmlspecialchars($t->mesto);?>
			</address>
			<div><?php echo $t->text1;?></div>
			<div class="username">Vaše uživatelské jméno je: <strong><?php echo htmlspecialchars($t->username);?></strong></div>
			<div class="userpswd">Vaše heslo je: <strong><?php echo htmlspecialchars($t->userpswd);?></strong></div>
			<div><?php echo $t->text2;?></div>
			<p class="footer">Uživatele ověřil a přístupové údaje vydal: <?php echo htmlspecialchars($t->userinfo);?><br />
			 dne: <?php echo htmlspecialchars($t->today);?>.</p>
		</div>
		<p class="control">&laquo; <a href="printuser.php?<?php echo htmlspecialchars($t->curl_aid);?>&amp;id=<?php echo htmlspecialchars($t->id);?>" onclick="print()">tisk</a> &raquo;</p>
		<p class="control">&laquo; <a href="usermng.php?<?php echo htmlspecialchars($t->curl_aid);?>">návrat</a></p>
	</div>
</body>
</html>