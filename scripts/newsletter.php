<?php
	$pref = "../";
	require "usrfce.php";
	
	$server = $_SERVER["SERVER_NAME"];
	$port = $_SERVER["SERVER_PORT"];
	$script = $_SERVER["SCRIPT_NAME"];
	$newscnt = 0;
	
	// určení zpráv pro newsletter
	$datcheck0 = date("Y-m-d", time());
	$datcheck1 = date("Y-m-d", time()-($newsletterdays*86400));
	$mysqlver = GetMysqlVer();
	$timecheck = time()-($newsletterdays*86400);
	if ($mysqlver <= "4.0.1"):
		$datcheck2 = date("YmdHis", $timecheck);
	else:
		$datcheck2 = date("Y-m-d H:i:s", $timecheck);
	endif;
	$dotazmt = "SELECT mt.caszapisu, mt.titulek, mt.perex, me.filename FROM mastertxt AS mt, menu AS me WHERE mt.switchoff=0 AND mt.publish=1 AND mt.caszapisu>'$datcheck2' AND mt.datum1<='$datcheck0' AND mt.datum2>='$datcheck1' AND mt.menuid=me.id ORDER BY mt.caszapisu DESC";
	$resultmt = mysql_query("$dotazmt");
	if (!$resultmt):
		die();
	else:
		$newscnt = mysql_num_rows($resultmt);
		if ($newscnt != 0):
			$bodymail = "";
			while ($recordmt = mysql_fetch_array($resultmt)):
				$casint = GetIntTime($recordmt["caszapisu"]);
				$casstr = date("d.m.Y H:i", $casint);
				$bodymail .= $casstr." - ".$recordmt["titulek"]."\n"; 
				$bodymail .= "http://www.dacice.cz:80/page.php?fp=".$recordmt["filename"]."\n"; 
				$bodymail .= ($recordmt["perex"] ? $recordmt["perex"]."\n" : "")."\n\n";
			endwhile;
		endif;
	endif;
	
	// zaslání zpráv registrovaným uživatelům
	if ($newscnt != 0):
		$dotazuz = "SELECT * FROM uzivatel WHERE letter=1 AND povol=1";
		$resultuz = mysql_query("$dotazuz");
		if (!$resultuz):
			die();
		else:
			while ($recorduz = mysql_fetch_array($resultuz)):
				@$posta = mail($recorduz["email"], "Dacice - newsletter", $bodymail,"From: web@dacice.cz\nX-Sender: <web@dacice.cz>\nX-Mailer: PHP\nX-Priority: 3\nReturn-Path: <web@dacice.cz>\nContent-Type: text/plain; charset=utf-8\n");
			endwhile;
		endif;
	endif;
?>
