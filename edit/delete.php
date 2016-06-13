<?php
	$menuid = $_GET['menuid'];
	$itemid = $_GET['itemid'];
	$fn = $_GET["fn"];
	$tbl = $_GET["tbl"];
	$ttbl = $_GET["ttbl"];
	$akce = "del";
	$mtid = $_GET["mtid"];
	$idtema = $_GET["idtema"];
	$idfirmy = $_GET["idfirmy"];
	include "./tpl/header.tpl";
	if ($tbl == "menu"):
		$submenu = HasSubmenu($itemid);
		$article = HasArticle($itemid);
		$menu = TblHandler($itemid,$tbl);
		if ($submenu || $article):
			$titulek = "Položku menu - ".ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$menu["titulek"])." nelze smazat z následujících důvodů:";
		else:
			$titulek = "položku menu - ".ereg_replace('(.*)\((.)(.*)\)','\\1\\2\\3',$menu["titulek"])."?";
		endif;
	elseif ($tbl == "mastertxt"):
		$clanek = TblHandler($itemid,$tbl);
		$titulek = "článek - ".$clanek["titulek"]."?";
	elseif ($tbl == "articlejoin"):
		$aj = TblHandler($itemid,$tbl);
		$clanek = TblHandler($aj["mtid"],"mastertxt");
		$titulek = "článek - ".$clanek["titulek"]."?";
	elseif ($tbl == "anketa"):
		$clanek = TblHandler($itemid,$tbl);
		$titulek = "anketu na otázku - ".$clanek["otazka"];
	elseif ($tbl == "pocasi"):
		$clanek = TblHandler($itemid,$tbl);
		$titulek = "údaje počasí z ".SetCzDateForm($clanek["datum"])."?";
	elseif ($ttbl == "cis"):
		$clanek = TblHandler($itemid,$tbl);
		if ($tbl == "autor"):
			$titulek = "autora - ".$clanek["jmeno"]." ".$clanek["prijmeni"]."?";
		elseif ($tbl == "redaktor"):
			$titulek = "redaktora - ".$clanek["jmeno"]." ".$clanek["prijmeni"]."?";
		elseif ($tbl == "uzivatel"):
			$titulek = "uživatele - ".$clanek["jmeno"]." ".$clanek["prijmeni"]."?";
		elseif ($tbl == "osoba"):
			$titulek = "údaje osoby - ".$clanek["jmeno"]." ".$clanek["prijmeni"]."?";
		elseif ($tbl == "kalendar"):
			$titulek = "akci - ".$clanek["titulek"]."?";
		elseif ($tbl == "mista"):
			$titulek = "misto - ".$clanek["name"]."?";
		elseif ($tbl == "podnik"):
			$titulek = "podnik - ".$clanek["podnik"]."?";
		elseif ($tbl == "poradatel"):
			$titulek = "pořadatele - ".$clanek["jmeno"]."?";
		elseif ($tbl == "typakce"):
			$titulek = "kategorii - ".$clanek["popis"]."?";
		elseif ($tbl == "zapis"):
			$titulek = "zapis - ".$clanek["titulek"]."?";
		elseif ($tbl == "firmy_cinnosti"):
		  $nadpis = TblHandler($clanek["idcinnosti"],"cinnosti");
		  $titulek = "činnost firmy - ".$nadpis["nazev"]."?";
		else:
			$titulek = "záznam z tabulky $tbl - ".$clanek["nazev"]."?";
		endif;
	else:
		$clanek = TblHandler($mtid,"mastertxt");
		$titulek = "část článku ".$clanek["titulek"]."?";
	endif;
?>
<div id="formcontent">
	<?php if ($submenu || $article):
		echo "<h3>".$titulek."</h3>\n";
		echo ($submenu ? "<h4>&bull; položka obsahuje další nabídku</h4>\n" : "");
		echo ($article ? "<h4>&bull; položka obsahuje články</h4>\n" : ""); ?>
	<?php if ($menuid && !$itemid): ?>	
		<form action="./webmng.php" method="get">
	<?php else: ?>
		<form action="./articlemng.php" method="get">
	<?php endif; ?>
			<div>
			<input type="hidden" name="menuid" value="<?php echo $menuid ?>" />
			<input type="submit" value="OK" />
			</div>
		</form>
	<?php else:
		if ($tbl == "articlejoin"): ?> 
			<h3>Opravdu chcete odpojit <?php echo $titulek; ?></h3>
		<?php else: ?>
			<h3>Opravdu chcete smazat <?php echo $titulek; ?></h3>
		<?php endif; ?>
		<form action="./changetbl.php" method="get">
			<?php if ($tbl == "mista"): ?>
				<input type="hidden" name="placelevel" value="<?php echo $placelevel ?>" />
			<?php elseif ($tbl == "firmy_cinnosti"): ?>
				<input type="hidden" name="idfirmy" value="<?php echo $idfirmy ?>" />
			<?php endif; ?>
			<div>
			<input type="hidden" name="itemid" value="<?php echo $itemid ?>" />
			<input type="hidden" name="menuid" value="<?php echo $menuid ?>" />
			<input type="hidden" name="mtid" value="<?php echo $mtid ?>" />
			<input type="hidden" name="idtema" value="<?php echo $idtema ?>" />
			<input type="hidden" name="fn" value="<?php echo $fn ?>" />
			<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
			<input type="hidden" name="ttbl" value="<?php echo $ttbl ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="Ano" />
			</div>
		</form>
		<?php if ($tbl == "anketa"): ?>
			<form action="./votemng.php" method="get">
		<?php elseif ($tbl == "pocasi"): ?>
			<form action="./weathermng.php" method="get">
		<?php elseif ($tbl == "mastertxt" && !$menuid): ?>
			<form action="./articlemng.php" method="get">
		<?php elseif ($ttbl == "cis"): ?>
			<form action="<?php echo "./".$fn; ?>" method="get">
		<?php else: ?>
			<form action="./webmng.php" method="get">
		<?php endif; ?>
			<div>
			<input type="hidden" name="menuid" value="<?php echo $menuid ?>" />
			<input type="hidden" name="idtema" value="<?php echo $idtema ?>" />
			<input type="hidden" name="idfirmy" value="<?php echo $idfirmy ?>" />
			<input type="submit" value="Ne" />
			</div>
		</form>
	<?php endif; ?>
</div>
<?php	
	include "./tpl/footer.tpl";
?>
