<?php if ($recordred["admin"] || $recordred["schval"] || $recordred["anketa"] || $recordred["pocasi"] || $recordred["soutez"]): ?>
<h3>Hlavní obsah:</h3>
<ul>
<?php if ($recordred["admin"] || $recordred["schval"]): ?>
	<li><a href="./webmng.php">správa obsahu webu</a></li>
<?php endif;
	if ($recordred["admin"] || $recordred["anketa"]): ?>
	<li><a href="./votemng.php">správa anket</a></li>
<?php endif;
	if ($recordred["admin"] || $recordred["pocasi"]): ?>
	<li><a href="./weathermng.php">správa údajů o počasí</a></li>
<?php endif;
	if ($recordred["admin"] || $recordred["soutez"]): ?>
	<li><a href="./contestmng.php">správa soutěží</a></li>
<?php endif; ?>
</ul>
<?php endif;
if ($recordred["admin"] || $recordred["kalendar"]): ?>
<h3>Kalendář:</h3>
<ul>
	<li><a href="./calendarmng.php">správa obsahu kalendáře</a></li>
	<li><a href="./placemng.php?placelevel=1">správa názvů států</a></li>
	<li><a href="./placemng.php?placelevel=2">správa názvů krajů</a></li>
	<li><a href="./placemng.php?placelevel=3">správa názvů regionů</a></li>
	<li><a href="./placemng.php?placelevel=4">správa názvů obcí</a></li>
	<li><a href="./podnikmng.php">správa podniků</a></li>
	<li><a href="./poradatelmng.php">správa pořadatelů</a></li>
	<li><a href="./categorymng.php">správa kategorií</a></li>
</ul>
<?php endif;
if ($recordred["admin"] || $recordred["diskuse"]): ?>
<h3>Diskuse:</h3>
<ul>
	<li><a href="./diskusemng.php">správa témat a příspěvků</a></li>
</ul>
<?php endif;
if ($recordred["admin"] || $recordred["ciselniky"]): ?>
<h3>Číselníky:</h3>
<ul>
	<li><a href="./personmng.php">osobní údaje</a></li>
	<li><a href="./jobzastupmng.php">funkce v zastupitelstvu</a></li>
	<li><a href="./jobradamng.php">funkce v radě</a></li>
	<li><a href="./jobvybormng.php">funkce ve výboru zastupitelstva</a></li>
	<li><a href="./vybormng.php">výbory zastupitelstva</a></li>
	<li><a href="./jobkomisemng.php">funkce v komisi rady</a></li>
	<li><a href="./komisemng.php">komise rady</a></li>
	<li><a href="./partymng.php">politické strany</a></li>
	<li><a href="./sectionmng.php">odbory úřadu</a></li>
	<li><a href="./jobmng.php">pracovní zařazení</a></li>
	<li><a href="./firmmng.php">firmy</a></li>
	<li><a href="./actionmng.php">podnikatelské činnosti</a></li>
</ul>
<?php endif;
if ($recordred["admin"] || $recordred["uzivatele"]): ?>
<h3>Uživatelé:</h3>
<ul>
	<li><a href="./authormng.php">autoři</a></li>
	<?php if ($recordred["admin"]): ?>
		<li><a href="./redactionmng.php">redaktoři</a></li>
		<li><a href="./usermng.php">uživatelé</a></li>
	<?php endif; ?>
</ul>
<?php endif;
if ($recordred["admin"] || $recordred["udeska"]): ?>
<h3>Úřední deska:</h3>
<ul>
	<li><a href="../edeska/index.php">správa úřední desky</a></li>
</ul>
<?php endif; 
if ($recordred["admin"] || $recordred["mp"]):?>
<h3>Majetková přiznání:</h3>
<ul>
	<li><a href="../mp/loginform.php">aplikace pro majetková přiznání</a></li>
</ul>
<?php endif; ?>
<h3>Speciální funkce:</h3>
<ul>
	<li><a href="./indexsearch.php">vytvoření indexu pro vyhledávání</a></li>
	<li><a href="./contentpoz.php">seřazení položek článků</a></li>
</ul>
