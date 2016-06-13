<?php
$idtema = $_GET["idtema"];
$idtop = $_GET["idtop"];
$zac = ($_GET["zac"] ? $_GET["zac"] : 0);
include "tpl/header.tpl";
if ($idtema):
	if ($idtop):
		include "tpl/odpoved.tpl";
	else:
		include "tpl/zapis.tpl";
	endif;
else:
	include "tpl/tema.tpl";
endif;
include "tpl/left.tpl";
include "tpl/footer.tpl";
?>