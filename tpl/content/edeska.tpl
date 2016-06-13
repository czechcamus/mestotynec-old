<div id="contentbar"><div class="articlebox">
  <h2>Elektronická úřední deska</h2>
  <p>Informace zveřejněné podle § 26 zákona č. 500/2004 Sb., správní řád. <br />Soubory jsou ve formátu pdf.</p> 
  <ul id="edmenu">
    <li><a href="edeska.php">aktuální stav</a></li>
    <li><a href="edeska.php?idform=arc">stav k datu</a></li>
    <li><a href="edeska.php?idform=sel">výběr</a></li>
  </ul>
<?php
  if ($idform == "arc"):
    include "tpl/content/ed_arcform.tpl";
  elseif ($idform == "sel"):
    include "tpl/content/ed_selform.tpl";
  endif;
  $ord = (isset($_GET['ord']) ? $_GET['ord'] : "datumr2");
  // pomocné proměnné
  $str = (isset($_GET['str']) ? $_GET['str'] : 1); // zobrazená stránka
  $strzaz = 25; // počet záznamů na stránce
  $limitstart = ($str - 1)*$strzaz;
	// určení záznamů
	$datum = date("Y-m-d H:i:s",time());
	// výběr pro počet záznamů
	$cond = "WHERE d.id_typ = t.id AND d.id_puvodce = p.id";
	if (isset($_GET['sel'])): // data z formuláře
	  // doplnění $cond 
	  if (isset($_GET['arcdatum'])):
	    // stav k datu
	    $farcdatum = DateConvertForDb($arcdatum);
	    $farctime = $farcdatum." ".($arctime ? $arctime : "00:00:00");
	    $cond .= " AND datumr <= '$farctime' AND datume >= '$farctime' AND newtime <= '$farctime' AND (isnull(lasttime) OR (lasttime >= '$farctime'))";
	    $urlvars = "arcdatum=$arcdatum&amp;arctime=$arctime&amp;sel=1&amp;idform=arc";
	  else:
	    // výběr
	    $urlvars = "";
	    $fdatum1 = DateConvertForDb($datum1)." 00:00:00";
	    $fdatum2 = DateConvertForDb($datum2)." 23:59:59";
	    if ($nazev):
	       $cond .= " AND d.nazev LIKE '%$nazev%'";
	       $urlvars .= "nazev=$nazev";
	    endif;
	    if ($znacka):
	       $cond .= " AND d.znacka LIKE '%$znacka%'";
	       $urlvars .= ($urlvars ? "&amp;" : "")."znacka=$znacka";
	    endif;
	    if ($id_typ):
	       $cond .= " AND id_typ=$id_typ";
         $urlvars .= ($urlvars ? "&amp;" : "")."id_typ=$id_typ";
	    endif;
	    if ($status):
	       if ($status == 1):
	         $cond .= " AND d.public = 1 AND d.datumr <= '$datum' AND d.datume >= '$datum'";
	       elseif ($status == 2):
	         $cond .= " AND d.public = 1 AND d.datume < '$datum'";
	       elseif ($status == 3):
	         $cond .= " AND d.public = 0";
	       endif;
         $urlvars .= ($urlvars ? "&amp;" : "")."status=$status";
	    endif;
	    if ($id_puvodce):
	       $cond .= " AND id_puvodce=$id_puvodce";
         $urlvars .= ($urlvars ? "&amp;" : "")."id_puvodce=$id_puvodce";
	    endif;
	    if ($datum1):
	       $cond .= " AND datume >= '$fdatum1'";
         $urlvars .= ($urlvars ? "&amp;" : "")."datum1=$datum1";
	    endif;
	    if ($datum2):
	       $cond .= " AND datumr <= '$fdatum2'";
         $urlvars .= ($urlvars ? "&amp;" : "")."datum2=$datum2";
	    endif;
	    $urlvars .= ($urlvars ? "&amp;" : "")."sel=1&amp;idform=sel";
	  endif;
	else:
	   // aktuální záznamy
	   $cond .= " AND d.public = 1 AND d.datumr <= '$datum' AND d.datume >= '$datum'";
	   $urlvars = '';
	endif;
	if (!(isset($_GET['idform']) && !isset($_GET['sel']))):
  	$query1 = "SELECT d.id FROM udeska AS d, udtyp AS t, udpuvodce AS p $cond";
  	$rq1 = mysql_query("$query1");
  	if (!$rq1):
  		die("Nepodařilo se vybrat záznamy 1 - edeska.tpl!");
  	endif;
  	$zazcnt = mysql_num_rows($rq1);
  	$strcnt = ceil($zazcnt/$strzaz);
  	// výběr pro stránku
    $query = "SELECT d.id, d.nazev AS dnazev,t.nazev AS tnazev,p.nazev AS pnazev,p.ulice,p.psc,p.misto,d.datumr,d.datume,DATE_FORMAT(d.datumr,'%d.%m.%Y') AS fdatum1,DATE_FORMAT(d.datume,'%d.%m.%Y') AS fdatum2,d.docfile,d.public  
                FROM udeska AS d, udtyp AS t, udpuvodce AS p 
                $cond 
                ORDER BY ".substr($ord,0,-1)." ".(substr($ord,-1) == "2" ? "DESC" : "")." 
                LIMIT $limitstart,$strzaz";
  	$rq = mysql_query("$query");
  	if (!$rq):
  		die("Nepodařilo se vybrat záznamy 2 - edeska.tpl!");
  	else:
  		if (mysql_num_rows($rq)):
  		  echo "<span class=\"bold\">Počet zobrazených vyvěšení: $zazcnt</span>\n";
  			echo "<table id=\"edtable\">\n";
  			echo "<tr><th".($ord == "dnazev1" ? " class=\"ordup\"" : ($ord == "dnazev2" ? " class=\"orddown\"" : ""))."><a href=\"?".($urlvars  ? "$urlvars&amp;" : "")."ord=".($ord == "dnazev1" ? "dnazev2" : "dnazev1")."\" title=\"nastavit řazení\">název</a></th><th".($ord == "tnazev1" ? " class=\"ordup\"" : ($ord == "tnazev2" ? " class=\"orddown\"" : ""))."><a href=\"?".($urlvars  ? "$urlvars&amp;" : "")."ord=".($ord == "tnazev1" ? "tnazev2" : "tnazev1")."\" title=\"nastavit řazení\">kategorie</a></th><th".($ord == "datumr1" ? " class=\"ordup\"" : ($ord == "datumr2" ? " class=\"orddown\"" : ""))."><a href=\"?".($urlvars  ? "$urlvars&amp;" : "")."ord=".($ord == "datumr1" ? "datumr2" : "datumr1")."\" title=\"nastavit řazení\">vyvěšeno od</a></th><th".($ord == "datume1" ? " class=\"ordup\"" : ($ord == "datume2" ? " class=\"orddown\"" : ""))."><a href=\"?".($urlvars  ? "$urlvars&amp;" : "")."ord=".($ord == "datume1" ? "datume2" : "datume1")."\" title=\"nastavit řazení\">vyvěšeno do</a></th></tr>\n";
  			echo "<tr><th colspan=\"2\"".($ord == "pnazev1" ? " class=\"ordup\"" : ($ord == "pnazev2" ? " class=\"orddown\"" : ""))."><a href=\"?".($urlvars  ? "$urlvars&amp;" : "")."ord=".($ord == "pnazev1" ? "pnazev2" : "pnazev1")."\" title=\"nastavit řazení\">původce</a></th><th colspan=\"2\"".($ord == "docfile1" ? " class=\"ordup\"" : ($ord == "docfile2" ? " class=\"orddown\"" : ""))."><a href=\"?".($urlvars  ? "$urlvars&amp;" : "")."ord=".($ord == "docfile1" ? "docfile2" : "docfile1")."\" title=\"nastavit řazení\">dokument</a></th></tr>\n";
  			$i = 0;
  			while ($arr = mysql_fetch_array($rq)):
  			  $doc = substr($arr['docfile'],9);
                          if (file_exists($arr['docfile'])) {
                            $size = format_size(filesize($arr['docfile']));
                            $link = true;
                          } else {
                            $size = 'n/a';
                            $link = false;
                          }
  			  $status = ($arr['public'] ? (($datum >= $arr['datumr']) && ($datum <= $arr['datume']) ? "act" : "out") : "arc");
  			  $title = ($status == "act" ? "aktuální" : ($status == "arc" ? "archivní" : "neaktuální"));
  				echo "<tr class=\"bg$i\"><td class=\"sl11 $status\" title=\"$title vyvěšení\"><a href=\"edeska-detail.php?id=".$arr['id']."\">".$arr['dnazev']."</a></td><td>".$arr['tnazev']."</td><td>".$arr['fdatum1']."</td><td>".$arr['fdatum2']."</td></tr>\n";
  				echo "<tr class=\"bg$i\"><td class=\"sl12\" colspan=\"2\">".$arr['pnazev'].($arr['ulice'] ? ", ".$arr['ulice'] : "").($arr['psc'] ? ", ".$arr['psc'] : "").($arr['misto'] ? " ".$arr['misto'] : "")."</td><td colspan=\"2\">";
                                if ($link) {
                                    echo "<a href=\"".$arr['docfile']."\">";
                                }
                                echo $doc;
                                if ($link) {
                                    echo "</a>";
                                }
                                echo " ($size)</td></tr>\n";
  				$i = ($i ? 0 : 1);
  			endwhile;
  			echo "</table>\n";
  		  if ($strcnt > 1):
  		    // navigace stránkování
  		    echo "<p>Výpis strana: ";
    			for ($i = 1; $i <= $strcnt; $i++):
    			  if ($i != $str):
              echo "<a href=\"?str=$i".($urlvars ? "&amp;$urlvars" : "").($ord ? "&amp;$ord" : "")."\" title=\"přechod na stránku $i\">";
            endif;
            echo $i;
    			  if ($i != $str):
              echo "</a>\n";
            endif;
            echo "&nbsp;";
          endfor;
          echo "</p>\n";
        endif;
  		endif;
  	endif;
	endif;	
?>
  <p><strong>Legenda:</strong><br />
  <img src="img/design/ed_act.gif" alt="ikona - aktuální vyvěšení" /> - aktuální vyvěšení (platné)<br /> 
  <img src="img/design/ed_out.gif" alt="ikona - neaktuální vyvěšení" /> - neaktuální vyvěšení (platnost vypršela)<br /> 
  <img src="img/design/ed_arc.gif" alt="ikona - archivní vyvěšení" /> - archivní vyvěšení (nahrazeno novou verzí)</p>
</div></div>
