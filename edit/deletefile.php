<?php
$fn = $_GET["fn"];
if ($fn):
$lastchr = strrchr($fn,"/");
$df = ($lastchr == "/" ? rmdir("../".$fn) : unlink("../".$fn));
endif;
if (!$fn):
?>
<form action="deletefile.php" method="get">
<input type="text" name="fn" />
<input type="submit" name="smazat" />
</form>
<?php else:
if ($df): ?>
<h3>Soubor byl uspesne vymazan</h3>
<?php else: ?>
<h3>Vymaz se nepovedl</h3>
<?php endif; ?>
<form action="deletefile.php" method="get">
<input type="submit" name="ok" />
</form>
<?php endif; ?>
