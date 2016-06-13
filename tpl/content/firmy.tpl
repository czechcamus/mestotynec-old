<?php
// byl již změněn výběr?
$idcinnosti = $_GET["idcinnosti"];
$razeni = $_GET["razeni"];

// standardně se zobrazí všechny firmy seřazené abecedně
if (!$idcinnosti):
	$idcinnosti = 99999;
	$razeni = 1;
endif;

// načtení položek pro seznam činností
$sql_dotaz = "SELECT * FROM cinnosti ORDER BY cznazev";
$result = mysql_query("$sql_dotaz");

if (!$result):
	 die("nepodařilo se vybrat činnosti - firmy.tpl");
else:
	echo "<form action=\"page.php\" method=\"get\" id=\"calendarform\">\n";
	echo "<fieldset>\n";
	echo "<label for=\"idcinnosti\" class=\"noblock\">Druh činnosti:</label>\n";
	echo "<select name=\"idcinnosti\" id=\"idcinnosti\" size=\"1\">";
	echo "<option value=\"99999\"".($idcinnosti=="99999" ? " selected=\"selected\"" : "").">bez rozlišení</option>\n";
	while ($record = mysql_fetch_array($result)):
		echo "<option value=\"".$record["id"]."\"";
		echo ($idcinnosti==$record["id"] ? " selected=\"selected\"" : "");
		echo ">".$record["nazev"]."</option>\n";
	endwhile;
	echo "</select>\n";
	echo "<label for=\"razeni\" class=\"noblock\">Řadit podle:</label>\n"; 
	echo "<select name=\"razeni\" id=\"razeni\" size=\"1\">\n";
	echo "<option value=\"1\"".($razeni==1 ? " selected=\"selected\"" : "").">abecedy</option>\n";
	echo "<option value=\"2\"".($razeni==2 ? " selected=\"selected\"" : "").">činností</option>\n";
	echo "</select>\n";
	echo "<input type=\"hidden\" name=\"fp\" value=\"$fp\" />\n";
	echo "<input type=\"hidden\" name=\"artid\" value=\"$artid\" />\n";
	echo "<input type=\"submit\" name=\"odeslano\" value=\"Vybrat\" class=\"subinput\" />\n";
	echo "</fieldset>\n";
	echo "</form>\n";
endif;

// načtení dat pro seznam firem
$resultfirm = FirmSelect($idcinnosti,$razeni);
$pocfirm = mysql_num_rows($resultfirm);
if (!$pocfirm):
	echo "<p class=\"bold\">Nenalezen žádný vyhovující záznam...</p>\n";
else:
	echo "<div id=\"firmbox\">\n";
	$i = 1;
	$oldcinnost = 0;
	$oldfirm = 0;
	while ($rec = mysql_fetch_array($resultfirm)):
	   if ($razeni == 1):
	     if ($rec["idfirmy"] != $oldfirm):
   	  	   $i = ($i ? 0 : 1);
           $oldfirm = $rec["idfirmy"];
     	     echo "<div class=\"firmaddr bg$i\">\n";
  	       echo "<address><span class=\"nazev\">".$rec["firmnazev"].($rec["dodatek"] ? ", ".$rec["dodatek"] : "")."</span><br />\n";
  	       if ($rec["ulice"]):
  	         echo $rec["ulice"]."<br />\n";
           endif; 
  	       if ($rec["psc"]):
  	         echo $rec["psc"].", ";
           endif; 
  	       if ($rec["mesto"]):
  	         echo $rec["mesto"];
           endif; 
  	       if ($rec["telefony"]):
  	         echo "<span class=\"telefony\">".$rec["telefony"]."</span>\n";
           endif; 
  	       if ($rec["mobily"]):
  	         echo "<span class=\"mobily\">".$rec["mobily"]."</span>\n";
           endif; 
  	       if ($rec["faxy"]):
  	         echo "<span class=\"faxy\">".$rec["faxy"]."</span>\n";
           endif; 
  	       if ($rec["emaily"]):
  	         echo "<span class=\"emaily\">".$rec["emaily"]."</span>\n";
           endif; 
  	       if ($rec["web"]):
  	         echo "<span class=\"web\"><a href=\"".(strtolower(substr($rec["web"],0,7)) == "http://" ? $rec["web"] : "http://".$rec["web"])."\">".$rec["web"]."</a></span>";
           endif; 
           echo "</address>\n";
	        echo "</div>\n";
       endif;
	     if ($idcinnosti == 99999):
 	  	   $j = ($i ? 1 : 0);
         echo "<div class=\"firmcinn bg$j\">".$rec["cinnost"]."</div>\n";
       endif;
	   else:
	     if ($rec["idcinnosti"] != $oldcinnost):
	       $oldcinnost = $rec["idcinnosti"];
	       echo "<h3>".$rec["cinnost"]."</h3>\n";
	     endif;
	     echo "<div class=\"firmaddr bg$i\">\n";
    	   $i = ($i ? 0 : 1);
	       echo "<address><span class=\"nazev\">".$rec["firmnazev"].($rec["dodatek"] ? ", ".$rec["dodatek"] : "")."</span><br />\n";
	       if ($rec["ulice"]):
	         echo $rec["ulice"]."<br />\n";
         endif; 
	       if ($rec["psc"]):
	         echo $rec["psc"].", ";
         endif; 
	       if ($rec["mesto"]):
	         echo $rec["mesto"];
         endif; 
	       if ($rec["telefony"]):
	         echo "<span class=\"telefony\">".$rec["telefony"]."</span>\n";
         endif; 
	       if ($rec["mobily"]):
	         echo "<span class=\"mobily\">".$rec["mobily"]."</span>\n";
         endif; 
	       if ($rec["faxy"]):
	         echo "<span class=\"faxy\">".$rec["faxy"]."</span>\n";
         endif; 
	       if ($rec["emaily"]):
	         echo "<span class=\"emaily\">".$rec["emaily"]."</span>\n";
         endif; 
	       if ($rec["web"]):
	         echo "<span class=\"web\"><a href=\"".(strtolower(substr($rec["web"],0,7)) == "http://" ? $rec["web"] : "http://".$rec["web"])."\">".$rec["web"]."</a></span>";
         endif; 
         echo "</address>\n";
	     echo "</div>\n";
	   endif;
	endwhile;
	echo "</div>\n";
endif;
?>
