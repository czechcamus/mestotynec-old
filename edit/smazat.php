<?php
	$jmsouboru = $_GET['jmsouboru'];
	$id = $_GET['id'];
	$akce = "del";
	include "./tpl/header.tpl";
?>
<div id="content">
	<h3>Opravdu chcete smazat vybraný záznam?</h3>
	<form action="./changetbl.php" method="get">
			<div>
			<input type="hidden" name="id" value="<?php echo $id ?>" />
			<input type="hidden" name="jmsouboru" value="<?php echo $jmsouboru ?>" />
			<input type="hidden" name="akce" value="<?php echo $akce ?>" />
			<input type="submit" value="Ano" />
			</div>
		</fieldset>
	</form>
	<form action="./webmng.php" method="get">
			<div>
			<input type="hidden" name="jmsouboru" value="<?php echo $jmsouboru ?>" />
			<input type="submit" value="Ne" />
			</div>
		</fieldset>
	</form>
</div>
<?php	
	include "./tpl/footer.tpl";
?>
