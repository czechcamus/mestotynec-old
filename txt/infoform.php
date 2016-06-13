<?php
$fp = $_GET["fp"];
$form = $_GET["form"];
if ($form == "cst"):
	$idcst = $_GET["idcst"];
	$odp = $_GET["odp"];
elseif ($form == "i106" || $form == "sdel"):
	$posta = $_GET["posta"];
elseif ($form == "register"):
	$akce = $_GET["akce"];
endif;
include "tpl/header.tpl";
include "tpl/infoform.tpl";
include "tpl/left.tpl";
include "tpl/footer.tpl";
?>