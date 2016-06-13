<?php
	$menuid = $_GET["menuid"];
	$itemid = $_GET["itemid"];
	$akce = $_GET["akce"];
	$tbl = $_GET["tbl"]; 
	$title = $_GET["title"];
	$ttbl = $_GET["ttbl"];
	$fn = $_GET["fn"];
	$mtid = $_GET["mtid"];
	$placelevel = $_GET["placelevel"];
	$idtema = $_GET["idtema"];
	$idfirmy = $_GET["idfirmy"];
	include "./tpl/header.tpl";
	if ($tbl == "menu"):
		include "./tpl/formmenu.tpl";
	elseif ($tbl == "mastertxt"):
		include "./tpl/formmastertxt.tpl";
	elseif ($tbl == "anketa"):
		include "./tpl/formvote.tpl";
	elseif ($tbl == "pocasi"):
		include "./tpl/formweather.tpl";
	elseif ($tbl == "selosoba"):
		include "./tpl/formselperson.tpl";
	elseif ($ttbl == "cis"):
		if ($tbl == "kalendar"):
			include "./tpl/formkal.tpl";
		else:
			include "./tpl/formcis.tpl";
		endif;
	else:
		if ($akce == "add"):
			$tbltyp = $_GET["tbltyp"];
		else:
			// výběr typu tabulky, názvu tabulky a id části článku podle id položky obsahu
			$dotaz = "SELECT * FROM content AS ct, tablename AS tn WHERE ct.contid=$itemid AND tn.tblname='$tbl' AND ct.idtbl=tn.id";
			$result = mysql_query("$dotaz");
			if (!$result):
				die("Nezdařil se výběr z tabulek content a tablename - edit.php!");
			else:
				$record = mysql_fetch_array($result);
				$tbltyp = $record["typ"];
				$itemid = $record["contid"];
				$tbl = $record["tblname"];
			endif;
		endif;
		if ($tbltyp == "txt"):
			include "./tpl/formtxt.tpl";
		elseif ($tbltyp == "img"):
			include "./tpl/formimg.tpl";
		elseif ($tbltyp == "lst"):
			include "./tpl/formlst.tpl";
		elseif ($tbltyp == "tbl"):
			$step = $_GET["step"];
			if ($step):
				include "./tpl/formselsl.tpl";
			else:
				include "./tpl/formseltbl.tpl";
			endif;
		elseif ($tbltyp == "lnk"):
			if ($tbl == "soubor"):
				include "./tpl/formfile.tpl";
			else:
				include "./tpl/formlnk.tpl";
			endif;
		elseif ($tbltyp == "scr"):
			include "./tpl/formscr.tpl";
		elseif ($tbltyp == "cst"):
			include "./tpl/formcst.tpl";
		endif;
	endif;
	include "./tpl/footer.tpl";
?>
