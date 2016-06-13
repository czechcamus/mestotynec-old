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
			<li><a href="docmng.php?<?php echo htmlspecialchars($t->curl_aid);?>">Správa dokumentů</a></li>
			<li><a href="personmng.php?<?php echo htmlspecialchars($t->curl_aid);?>">Správa osob</a></li>
			<li><a href="fcemng.php?<?php echo htmlspecialchars($t->curl_aid);?>">Správa funkcí</a></li>
			<li><a href="usermng.php?<?php echo htmlspecialchars($t->curl_aid);?>">Správa uživatelů</a></li>
			<li><a href="viewlog.php?<?php echo htmlspecialchars($t->curl_aid);?>">Prohlížení logu</a></li>
		</ul>
		<p class="userinfo">
			Přihlášený uživatel: <strong><?php echo htmlspecialchars($t->userinfo);?></strong> <a href="scripts/logout.php?<?php echo htmlspecialchars($t->curl_aid);?>">odhlásit se</a> &raquo;
		</p>
	</div>
</body>
</html>