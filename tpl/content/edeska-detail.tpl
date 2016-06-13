<div id="contentbar"><div class="articlebox">
  <h2>Elektronická úřední deska - detail vyvěšení</h2>
  <p>Informace zveřejněné podle § 26 zákona č. 500/2004 Sb., správní řád. <br />Soubory jsou ve formátu pdf.</p> 
  <ul id="edmenu">
    <li><a href="edeska.php">aktuální stav</a></li>
    <li><a href="edeska.php?idform=arc">stav k datu</a></li>
    <li><a href="edeska.php?idform=sel">výběr</a></li>
  </ul>
<?php
  $datum = date("Y-m-d",time());
	// výběr pro stránku
  $query = "SELECT d.nazev AS dnazev,d.text,d.znacka,t.nazev AS tnazev,p.nazev AS pnazev,p.ulice,p.psc,p.misto,p.udvlastnik,d.datum1,d.datum2,d.datum3,d.datum4,DATE_FORMAT(d.datum1,'%d.%m.%Y') AS fdatum1,DATE_FORMAT(d.datum2,'%d.%m.%Y') AS fdatum2,DATE_FORMAT(d.datum3,'%d.%m.%Y') AS fdatum3,DATE_FORMAT(d.datum4,'%d.%m.%Y') AS fdatum4,DATE_FORMAT(d.datumr,'%d.%m.%Y %H:%i:%s') AS datumr,DATE_FORMAT(d.datume,'%d.%m.%Y %H:%i:%s') AS datume,DATE_FORMAT(d.lasttime,'%d.%m.%Y %H:%i:%s') AS lasttime,d.docfile,d.version,d.public  
              FROM udeska AS d, udtyp AS t, udpuvodce AS p WHERE d.id=$idrec AND d.id_typ = t.id AND d.id_puvodce = p.id";
	$rq = mysql_query("$query");
	if (!$rq):
		die("Nepodařilo se vybrat záznam - edeska-detail.tpl!");
	else:
	   if ($arr = mysql_fetch_array($rq)):
	     echo "<div id=\"eddetail\">\n";
	     echo "<h3>".$arr['dnazev']."</h3>\n";
	     if ($arr['znacka']):
	       echo "<p><span>Značka:</span> <strong>".$arr['znacka']."</strong></p>\n";
	     endif;
	     if ($arr['text']):
	       echo "<p><span>Textový popis:</span> <strong>".$arr['text']."</strong></p>\n";
	     endif;
             if (file_exists($arr['docfile'])) {
                 $size = format_size(filesize($arr['docfile']));
                 $link = true;
             } else {
                 $size = 'n/a';
                 $link = false;
             }
	     echo "<p>Přiložený dokument: <strong>";
             if ($link) {
                 echo "<a href=\"".$arr['docfile']."\">";
             }
             echo substr($arr['docfile'],9);
             if ($link) {
                 echo "</a>";
             }
             echo "</strong> ($size)</p>\n";
	     echo "<p>Kategorie: <strong>".$arr['tnazev']."</strong></p>\n";
	     echo "<p>Původce: <strong>".$arr['pnazev'].($arr['ulice'] ? ", ".$arr['ulice'] : "").($arr['psc'] ? ", ".$arr['psc'] : "").($arr['misto'] ? ($arr['psc'] ? " " : ", ").$arr['misto'] : "")."</strong></p>\n";
	     echo "<p>Verze: <strong>".$arr['version']."</strong></p>\n";
	     echo "<p>Stav: <strong>".($arr['public'] == 0 ? "archivní" : ($arr['datum2'] < $datum ? "neaktuální" : "aktuální"))."</strong></p>\n";
	     echo "<h4>Informace o vyvěšení a zveřejnění</h4>\n";
	     if (($arr['udvlastnik'] == 0) && ($arr['datum3']) && ($arr['datum4'])):
	       echo "<h5>Zveřejnění u původce - ".$arr['pnazev'].($arr['ulice'] ? ", ".$arr['ulice'] : "").($arr['psc'] ? ", ".$arr['psc'] : "").($arr['misto'] ? ($arr['psc'] ? " " : ", ").$arr['misto'] : "")."</h5>\n";
	       echo "<p>Zveřejněno od: <strong>".$arr['fdatum3']."</strong> do: <strong>".$arr['fdatum4']."</strong></p>\n";
	     endif;
       echo "<h5>Zveřejnění na úřední desce</h5>\n";
       echo "<p>Zveřejněno od: <strong>".$arr['fdatum1']."</strong> do: <strong>".$arr['fdatum2']."</strong></p>\n";
       echo "<h5>Zveřejnění umožňující dálkový přístup</h5>\n";
	     echo "<p>Zveřejněno od: <strong>".$arr['datumr']."</strong> do: <strong>".($arr['lasttime'] ? $arr['lasttime'] : $arr['datume'])."</strong></p>\n";
	     echo "</div>\n";
     endif; 
	endif;
	echo "<p><a href=\"".$_SERVER['HTTP_REFERER']."\">zpět na seznam vyvěšení</a></p>\n";
?>
</div></div>
