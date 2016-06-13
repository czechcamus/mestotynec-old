<?php
	$tbl = $_GET["tbl"];
	$akce = "del";
	include "./tpl/header.tpl";
?>
<div id="formcontent">
	<h3>Opravdu chcete smazat tabulku <?php echo $tbl; ?>?</h3>
	<form action="./changeimptbl.php" method="get">
		<div>
		<input type="hidden" name="tbl" value="<?php echo $tbl ?>" />
		<input type="hidden" name="akce" value="<?php echo $akce ?>" />
		<input type="submit" value="Ano" />
		</div>
	</form>
	<form action="./importedtbl.php" method="get">
		<div>
		<input type="submit" value="Ne" />
		</div>
	</form>
</div>
<?php	
	include "./tpl/footer.tpl";
?>
